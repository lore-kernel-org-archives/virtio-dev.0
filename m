Return-Path: virtio-dev-return-5729-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B00FC985DFB
	for <virtio-dev@lists.oasis-open.org>; Fri, 10 May 2019 15:48:30 +0000 (UTC)
Date: Fri, 10 May 2019 16:48:24 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190510154824.GJ22311@stefanha-x1.localdomain>
References: <20190501170525.GB22391@stefanha-x1.localdomain>
 <c74aebe9-5db4-902f-ef0b-f0a786806acd@13byte.com>
 <20190503164501.GB8373@stefanha-x1.localdomain>
 <863e1be1-11cc-816b-896d-3954427e98f3@13byte.com>
 <20190506052715.vkdopunuauyhl22m@sirius.home.kraxel.org>
 <7ac2ae97-bcb7-22cc-272a-723e7209910c@13byte.com>
 <20190509122710.rfhfnhqez2u7inju@sirius.home.kraxel.org>
 <5d316321-2c48-342b-f2ce-359e3596dae0@opensynergy.com>
 <20190510121656.3ab7w5xef6io764o@sirius.home.kraxel.org>
 <76D732A88286A1478FFA94B453B715C1EEA25DD4@MXS02.open-synergy.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LQAwcd5tHl0Qlnzi"
Content-Disposition: inline
In-Reply-To: <76D732A88286A1478FFA94B453B715C1EEA25DD4@MXS02.open-synergy.com>
Subject: Re: [virtio-dev] Request for a new device number for a virtio-audio
 device.
To: Anton Yakovlev <Anton.Yakovlev@opensynergy.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Mikhail Golubev <Mikhail.Golubev@opensynergy.com>, Marco Martinelli - 13Byte srl <marco@13byte.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, =?utf-8?B?S8WRdsOhZ8OzIFpvbHTDoW4=?= <dirty.ice.hu@gmail.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--LQAwcd5tHl0Qlnzi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2019 at 02:15:00PM +0000, Anton Yakovlev wrote:
> > Why do you think this is needed?
>=20
> When you implement an audio device, you usually start with what we call "=
manual mode". It works, but only for simple use cases. There're two major c=
hallenges here.
>=20
> 1) An application can use audio device in many different ways. It may fil=
l the entire buffer with frames and let it draining. It may provides data i=
n form of relatively big chunks. But usually you will face with so called "=
low latency" applications. These try to reduce result latency by providing =
small chunks of data. In extreme cases, the driver may receive requests con=
taining only 5-10 frames. It means an amount of both system calls and reque=
sts to the device will grow. At some point this rate may become quite notic=
able. But things may become even worse, if an application activates both st=
reams (playback and capture) at the same time. For example, voice chat appl=
ications (trying to reduce latency as much as possible) may hang you VM bec=
ause of huge amount of small requests on both PCM streams. Thus, no request=
s/traps/hypercalls to the device while a stream is running - no problems he=
re.
>=20
> 2) Everybody wants to reduce a latency as much as possible. One of the mo=
st logical way is to allow to mmap data buffer into the user space memory. =
(Actually, in some cases you even have no choice here, like in case of the =
WaveRT interface in Windows.) But memory mapped buffer means, that you eith=
er have a very little or have not at all an idea what is going on with buff=
er content. Even if you have information about when and where an applicatio=
n writes to or reads from the buffer (ALSA enforces an application to maint=
ain its appl_ptr value), you will have a lot of headache with tracking the =
rewind/forward cases. I can't say for everyone, but our experiments with us=
ing "manual mode" here all failed. From other side, the isochronous nature =
of PCM stream and the nature of sound card itself suggest you right solutio=
n. You don't need to care about what and how an application does with a buf=
fer. Since it's expected from the device to read/write data with constant r=
ate. Thus, you can do the same in your virtual audio device. And it works l=
ike a charm!
>=20
> We wanted to be ready for every possible use case, that's why we combined=
 solutions for described issues into what we call "automatic mode". The fun=
niest thing is, according to our tests, in automatic mode you can have stab=
le and clean playback/capturing even under the very high CPU pressure.

Thanks for contributing your virtio-snd spec to the discussion!

Shared memory isn't a native concept to VIRTIO.  The device and the
driver don't assume shared memory access in the general case (i.e.
virtqueue buffers could even be copied and virtio-blk, virtio-net, etc
would still work!).

There is currently a spec extension on the mailing list to add Shared
Memory Resources to VIRTIO and new device types will use it.  However, I
don't think this is necessary for this use case.

Two techniques can be used to minimize virtqueue notifications:

1. Polling has become a commonly used technique over the last several
   years.  Both the driver and the device may disable notifications and
   simply peek at the ring indices to detect new buffers from the other
   side.

2. For synchronization and to reduce notifications the device could
   support bundling playback and capture into a single buffer so that
   only 1 virtqueue is used:

   /* A packet of PCM data associated with a stream */
   struct virtio_audio_pcm_data {
       unsigned stream_id;
       uint8_t data[num_frames * num_channels * bytes_per_sample];
   };

   /* An exchange of playback and capture PCM data */
   struct virtio_audio_pcm {
       /* Write (Driver -> Device) */
       /* Note that all playback and capture streams must have the same
	* sample rate.
        */
       unsigned num_playback; /* 0 or more */
       unsigned num_capture; /* 0 or more */

       /* All playback and capture streams transfer this number of
	* frames of PCM data.
        */
       unsigned num_frames;

       struct virtio_audio_pcm_data playback[num_playback];

       /* Read (Device -> Driver) */
       struct virtio_audio_pcm_data capture[num_capture];
       /* TODO status and error codes */
   };

   In other words, a single struct virtio_audio_pcm delivers playback
   samples to the device and returns capture samples to the driver.

   I used arrays so that multiple streams with the same sample rate can
   be bundled together.

--LQAwcd5tHl0Qlnzi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAlzVnUgACgkQnKSrs4Gr
c8h+tQgAuzdwyKnnKnovzh+/wx2jiISpqhF1VGC1TJQ/4bYPA+kE2Oz4HNsjHQm3
r8O10mvbft2kaItiZobq9fF7CZ1E8dy3gTu9KqYmZT8VvNJuzvxjXAnD16H7O0Mm
/NYGZd7H6v7wFR9Yrfy/Pc8rRxvqjqQm3254uBfW2DZJRAtUW1p5QK3B4FlH6iom
JphTSZpNJnCIQTUAlkvPITNFJyK5Z69gEUA1eyZICTwmOhkFF4hh3YE0Dv+T5GCS
HGgwumwX+gEd0Wbp48yYuRsO2D2paNT+dmKUo+xmdplQKVboc7SnelN3/YPeyQQp
5X+lt9SzSoa6L56bstFdDN7UFADWDQ==
=8otW
-----END PGP SIGNATURE-----

--LQAwcd5tHl0Qlnzi--
