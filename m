Return-Path: virtio-dev-return-6365-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9242F985EA4
	for <virtio-dev@lists.oasis-open.org>; Fri, 22 Nov 2019 07:20:04 +0000 (UTC)
Date: Fri, 22 Nov 2019 08:19:54 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20191122071954.2ar6u3jwwn7yutjt@sirius.home.kraxel.org>
References: <0cc8007b70f4f5984223703313730d8e066006a7.camel@linux.intel.com>
 <20191112110937.GA4187507@lophozonia>
 <0c5939ad0b330bc4f42d63536340293745dce728.camel@linux.intel.com>
 <20191112160554.GA16008@lophozonia>
 <4ca16fb1d412bc92a2a65104680282b80742f6b1.camel@linux.intel.com>
 <ee52234e-6b53-1f2a-563f-c3dd50dd1764@opensynergy.com>
 <21039a042ad38302e9dc9010014223d915704b91.camel@linux.intel.com>
 <07b9804d-2c20-9ff4-a375-2c65f1d27f63@opensynergy.com>
 <20191121090403.6vjnovlru4zrmzzs@sirius.home.kraxel.org>
 <84fb109c-1d1e-a52c-8efa-8dcd00b864b3@opensynergy.com>
MIME-Version: 1.0
In-Reply-To: <84fb109c-1d1e-a52c-8efa-8dcd00b864b3@opensynergy.com>
Subject: Re: [virtio-dev] [PATCH] snd: Add virtio sound device specification
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Mikhail Golubev <Mikhail.Golubev@opensynergy.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>
List-ID: <virtio-dev.lists.oasis-open.org>

> Feature bits
> ------------
>=20
> VIRTIO_SND_F_PCM_OUTPUT
> VIRTIO_SND_F_PCM_INPUT
>=20
> and new ones would be
>=20
> VIRTIO_SND_F_PCM_EVT_PERIOD - support elapsed period notifications
> VIRTIO_SND_F_PCM_EVT_XRUN - support underrun/overrun notifications
> VIRTIO_SND_F_PCM_MSG - support message-based data transport
> VIRTIO_SND_F_PCM_HOST_MEM - support sharing host memory with guest
> VIRTIO_SND_F_PCM_GUEST_MEM - support sharing guest memory with host
>=20
> Not sure about correct naming here.

Hmm, I think at least parts of this should be device configuration not
feature bits ...=20

Instead of PCM_OUTPUT and PCM_INPUT I would put the number of input and
output streams into the device config space (and explicitly allow count
being zero).

PCM_EVT_* probably makes sense to be a per-stream configuration bit.

PCM_MSG -- I would drop the feature bit and make that mandatory, so we
have a common baseline on which all drivers and devices can agree on.

> By the way, Liam mentioned something about using PCI BARs for mapping hos=
t
> memory. Does it mean, that some features will be transport-specific?

In the latest spec revision virtio got support for shared memory
regions.  This should be used for VIRTIO_SND_F_PCM_HOST_MEM.

> What about virtio mmio?

Right now this is defined for the pci transport only.

> Virtqueues
> ----------
>=20
> As Gerd explained, we need 4 virtqueues in total:
>=20
> 1. control queue (guest->host: commands)
> 2. events queue (host->guest: notifications)
> 3. tx queue (guest->host: playback)
> 4. rx queue (host->guest: capture)
>=20
> The first one always exists, but all other depend on feature bits. Should=
 we
> check and assign these in some pre-defined order?

I'd suggest to make them all mandatory.

> Configuration space
> -------------------
>=20
> We talked about PCM formats defined in ALSA. In Linux kernel v5.4-rc8 we =
have
>=20
> Do we really need all of them? And I skipped endianess, but should we car=
e
> about it as well?

I'd keep the list as short as possible.  The formats listed in the patch
looked like a good start.

> It also affects how large configuration space should be.

I'd make the format bitfield 64bit no matter what.  It doesn't cost much
and it leaves room to extend things without hassle if needed.

> Common control message structure will be explicitly splitted into two
>=20
> struct virtio_snd_ctl_req {
>     le32 type;
      le32 stream_id;
>     u8 payload[];
> };

> and the SET_FORMAT request will be replaced with the SET_PARAMS
>=20
> struct virtio_snd_pcm_set_params {
>     struct virtio_snd_pcm_hdr hdr;
>     le32 channels;
>     le32 format;
>     le32 rate;
>     le32 period_size;
> };
>=20
> We only need to decide units for the period_size field (frames or bytes).

I'd suggest bytes (and rename the field to period_bytes).

> PCM I/O requests
> --------------------
>=20
> As we get rid of multiplexing, we don't need a header anymore.

What if a device wants support two playback streams (possibly even with
different features, say one stereo and one 5:1)?

> And a message
> will have only status
>=20
> struct virtio_snd_pcm_status {
>     le32 status;
>     le32 actual_length;
> };

Hmm.  Why actual_length?  Do we want allow short transfers?  Why?
Wouldn't it be more useful to just fill the buffer completely?

cheers,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

