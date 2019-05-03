Return-Path: virtio-dev-return-5712-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F28B2985BE7
	for <virtio-dev@lists.oasis-open.org>; Fri,  3 May 2019 17:12:39 +0000 (UTC)
Date: Fri, 3 May 2019 10:45:01 -0600
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190503164501.GB8373@stefanha-x1.localdomain>
References: <abe4bd97-8010-8fd0-8ded-f9e847a4fdb3@13byte.com>
 <20190429134754.GI7587@stefanha-x1.localdomain>
 <4fcd7456-de22-7f6d-d5ef-939cd3d7cf95@13byte.com>
 <20190501170525.GB22391@stefanha-x1.localdomain>
 <c74aebe9-5db4-902f-ef0b-f0a786806acd@13byte.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zx4FCpZtqtKETZ7O"
Content-Disposition: inline
In-Reply-To: <c74aebe9-5db4-902f-ef0b-f0a786806acd@13byte.com>
Subject: Re: [virtio-dev] Request for a new device number for a virtio-audio
 device.
To: Marco Martinelli - 13Byte srl <marco@13byte.com>
Cc: virtio-dev@lists.oasis-open.org, kraxel@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

--zx4FCpZtqtKETZ7O
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 02, 2019 at 01:18:40PM +0200, Marco Martinelli - 13Byte srl wro=
te:
> Il 01/05/19 19:05, Stefan Hajnoczi ha scritto:
>=20
> > On Mon, Apr 29, 2019 at 07:39:17PM +0200, Marco Martinelli - 13Byte srl=
 wrote:
> > > Il 29/04/19 15:47, Stefan Hajnoczi ha scritto:
> > > > On Mon, Apr 29, 2019 at 12:22:41AM +0200, Marco Martinelli - 13Byte=
 srl wrote:
> > > > > I'm not sure how this works, is that number already assigned and =
I should
> > > > > use that or should I get a new one?
> > > > >=20
> > > > > For last, I have a question to clear the things up for me. It is =
my
> > > > > understanding that in this mailing list you discuss about the
> > > > > specifications, not the actual code. What's the usual process whe=
n writing a
> > > > > new virtio device?
> > > > > Should I start with writing the code and then document how it wor=
ks or is it
> > > > > the opposite? Should I document it and have it approved and then =
implement
> > > > > the specifications?
> > > > >=20
> > > > > I know that this may sound like a stupid question, but please be =
patient
> > > > > with me, it's my first time.
> > > > I suggest posting a draft specification for the new device type bef=
ore
> > > > investing too much time in the implementation.
> > > >=20
> > > > Then work on the code while the spec discussion is ongoing.  This w=
ay
> > > > you won't have to wait too long before implementation but you also =
won't
> > > > find that reviewers are asking for large changes after you completed
> > > > your work.
> > > I feared that would be the answer.
> > > As I stated I'm not familiar with most of the technologies involved. =
I don't
> > > know if I have the capabilities to write a draft of the specifications
> > > without first working on some code to clear things up.
> > > I'll try my best.
> > I'm happy to help you get started.
> >=20
> > I have a basic understanding of sound cards (mostly from an audio API
> > and application perspective) and can explain the virtio device model.
> >=20
> > Please post the requirements and scope of the device you'd like to
> > create.  Are you thinking of something general-purpose like the USB
> > Audio Device Class specification, which can handle many different types
> > of devices.  Or were you thinking of something more limited?
> >=20
> > In terms of virtio concepts, audio streams would be transferred in
> > chunks over virtqueues.  A "control" virtqueue might be necessary to
> > configure the device.  It would process configuration request/response
> > packets.
> >=20
> > Stefan
>=20
> Hi Stefan,
>=20
> thank you for your offer.
>=20
> I'll explain what I have in mind.

Thanks.  Some random thoughts (not strong opinions) below:

>=20
> The scope of my project is to transfer a multichannel PCM stream from the=
 VM
> to the host and another the other way.
>=20
> The VM will see this transport interface like a generic soundcard with
> configurable input / output.
>=20
> Both windows and alsa work with PCM internally and it's not a problem to
> feed the stream of one to the other, keeping in mind that channel mapping
> may vary.
> I'm not aware of systems where PCM isn't used, I don't expect problems wi=
th
> this.
>=20
> In Scream ( https://github.com/duncanthrax/scream ) I've used IVSHMEM as a
> ring buffer. That worked very well, it reduced the latency and improved t=
he
> performances quite a bit over the original network protocol, but it's one
> way only (windows VM to linux host) and not as fast as it can be with vir=
tio
> I think.
>=20
> My idea is to have a device configuration layout where both the host and =
the
> guest can expose their current audio configuration, more or less like thi=
s.
>=20
> struct virtio_audio_config {
> =A0=A0=A0=A0=A0=A0=A0 le32 sample_rate;=A0=A0=A0=A0=A0 //from 8000Hz up t=
o 192000Hz
> =A0=A0=A0=A0=A0=A0=A0 le8=A0 sample_size;=A0=A0=A0=A0=A0 //8bit, 16bit, 3=
2bit or floating point
> =A0=A0=A0=A0=A0=A0=A0 le8=A0 channels;=A0=A0=A0=A0=A0=A0=A0=A0 //from 1 (=
mono) up to 8 (7.1 surround) or
> even more in theory (eg. Dolby Atmos, 64 channels, or MAudio 1010, 20+
> channels)
> =A0=A0=A0=A0=A0=A0=A0 le8=A0 channel_map[...]; //it's a list of constants=
 to identify the
> channel order in the PCM stream (eg. CH_LEFT, CH_RIGHT, CH_CENTER)
> };
>=20
> The struct will be double, one from audio out, one for audio in. When the
> host or the guest change it's configuration its struct should be updated =
and
> the other side notified.
>=20
> If the other side can't handle the configuration I'd like to figure out a
> graceful fallback. I have a few ideas in mind but I want to do some tests
> first.

This does not offer a way to enumerate supported configurations.  The
other side blindly suggests a configuration which may or may not be
accepted.

Enumeration of sample rates, channel topologies, sample formats, etc
would allow for negotiation that works the first time and instead of
guessing a configuration that ends up being rejected by the other side.

> If the host or the guest don't support audio out they can write 0 as numb=
er
> of channel, or zero out the entire struct during device initialization.
> If they don't support audio input
>=20
> I imagine two separate virtqueues, one for the output stream, another for
> the input stream.
>=20
> What I want to do in the end consist in a few modules:
> - virtio-audio specifications
> - a new QEMU device based on the specs
> - Windows driver for guest, based on MSVAD sample driver or SYSVAD sample
> driver, both released under MS-PL (I'll have to figure out how to have th=
em
> signed and distributed, is MS-PL a problem?)
> - ALSA driver for linux guest

This is also what I'd imagine.

>=20
> Maybe I'll focus more on audio output at first and audio input later,
> because that's the common use case.
>=20
> This weekend I'll take the time to document this better.
>=20
> If you have any question or I was not clear let me know.

Okay, it sounds like an audio API-level interface, not lower-level like
what the USB Audio Device Class does.  I'm not sure if we lose any
important functionality by choosing a high level interface.

How would soundcards with multiple inputs work?  Is each input
represented as a separate virtio-audio device?  The alternative is to
use an arbitrary number of mono or stereo channel pairs...

Stefan

--zx4FCpZtqtKETZ7O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAlzMb/AACgkQnKSrs4Gr
c8in+Qf+LqSTQlaHYlWNguXRwvcLyqRYk/eEGA7v7obtLR0/equG//4JvAh4Pxdc
D4LSMOMZa4mJA8n7UPtT9cLBHMunpTG/TJN8jOoTHNLcuX84wM+JOYqi+KxpGbCl
i4G0Zg28aE6jyuWMoZ4X6y2DJFXypGRmLBCSj6T4k5nFgJyIg8s2gJyJ7kY4J7yS
3R+BQs+SMO4CWq7NY4vktWVkmkuY2AAmc2dGMyGG0T5DvVyXi0osbsexUruf7/Mz
5yp6t7LQRS7dF7At4i40t7y29IVqyfQ8DeyBqMgC5W4vV4yDTg3JkLnV3b9zk2BF
KSnzqfIJF75ITNpioefdMqYogfqybw==
=KmKK
-----END PGP SIGNATURE-----

--zx4FCpZtqtKETZ7O--
