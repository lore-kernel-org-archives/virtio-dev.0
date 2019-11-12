Return-Path: virtio-dev-return-6323-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9AFF5985E61
	for <virtio-dev@lists.oasis-open.org>; Tue, 12 Nov 2019 14:20:51 +0000 (UTC)
Message-ID: <0c5939ad0b330bc4f42d63536340293745dce728.camel@linux.intel.com>
From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Date: Tue, 12 Nov 2019 14:20:44 +0000
In-Reply-To: <20191112110937.GA4187507@lophozonia>
References: <20190924144323.4590-1-Mikhail.Golubev@opensynergy.com>
	 <6a4978e85505ae00ca9e2b170f5e893a064c03d2.camel@linux.intel.com>
	 <568f32dc-8d82-a189-469f-5cb3a0140b8c@opensynergy.com>
	 <0cc8007b70f4f5984223703313730d8e066006a7.camel@linux.intel.com>
	 <20191112110937.GA4187507@lophozonia>
Mime-Version: 1.0
Subject: Re: [virtio-dev] [PATCH] snd: Add virtio sound device specification
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: Anton Yakovlev <anton.yakovlev@opensynergy.com>, Mikhail Golubev <Mikhail.Golubev@opensynergy.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, 2019-11-12 at 12:09 +0100, Jean-Philippe Brucker wrote:
> Hi,
>=20
> On Mon, Nov 11, 2019 at 03:20:55PM +0000, Liam Girdwood wrote:
> > > > > +struct virtio_snd_ctl_msg {
> > > > > +    /* device-read-only data */
> > > > > +    le32 request_code;
> > > > > +    u8 request_payload[];
> > > >=20
> > > > How do I know how much data to read here ? Is size embedded in
> > > > request_code ?
> > >=20
> > > Yes, you are right. Actual request/response length can be easily
> > > derived from=20
> > > a request_code.
> > >=20
> >=20
> > Nak, please use a separate size and type code otherwise we will
> > have
> > real problems in the future when we come to add new features (with
> > new
> > codes or bigger sizes).
>=20
> Other virtio devices rely on the buffer length already provided by
> virtio
> for this. For example see the virtio-net control virtqueue
> (virtio_net_ctrl*), which is extended with new commands from time to
> time.
> Most recently, the "receive-side scaling" feature introduces a large
> structure as payload to virtio_net_ctrl.
>=20

Sorry, not following, what does this have to do with combining type and
size into request_code ? Or are you saying the size is encoded
elsewhere in the virtio transport data ?

> [...]
> > > > > +\begin{lstlisting}
> > > > > +struct virtio_snd_pcm_xfer {
> > > > > +    le32 stream;
> > > > > +    u8 data[];
> > > > > +    le32 status;
> > > > > +    le32 actual_length;
> > > >=20
> > > > Not following this, is actual_length the size of data[]. If so,
> > > > it
> > > > must
> > > > preceed data[].
> > >=20
> > > No, the actual_length field is supposed to be used by device side
> > > to
> > > report
> > > actual amount of bytes read from/written to a buffer.
>=20
> By the way the written size is already provided by virtio (field len
> in
> the used descriptor), but not the read size.
>=20
> > > In real world
> > > scenario,=20
> > > if an I/O request contains N bytes, a device can play/capture *up
> > > to*
> > > N bytes.=20
> > > Thus, it's required to report this length back to a driver.
> > >=20
> >=20
> > This is not how PCM audio buffering works. I don't copy extra
> > padding
> > if I dont need to, I only copy when my buffer is full. See the need
> > for
> > period size in earlier comments.
>=20
> [...]
> > > > 2) Zero copy of audio data and stream positions. Essential for
> > > > any
> > > > low
> > > > latency audio use cases (if supported by HW, hypervisor, VM
> > > > framework).
> > >=20
> > > What do you mean by zero-copy? Shared memory between device and
> > > driver sides?
> >=20
> > Yes, but I see this is now a separate thread as it used by others
> > too.
>=20
> The virtio transport already permits zero-copy, because one buffer
> can be
> described with a chain of descriptors, each pointing to a different
> area
> in memory. The driver can split the virtio_snd_pcm_xfer into header
> and
> data:
>=20
>     virtqueue
>     desc ring
>     |       |
>     +-------+
>     |       |---------> header (copied)
>     +- - - -+
>     |       |---------> PCM data (mapped)
>     +-------+
>     |       |
>=20
> So it might be a good idea to put all the metadata (stream, status,
> actual_length) at the beginning of the virtio_snd_pcm_xfer struct,
> otherwise the driver will need three descriptors instead of two to
> achieve

This would be a good improvement, it's less copying and would likely
improve user experience, however the buffer ptr still suffers latency
as it's queued (same for stream positions going the other way).

Low latency zero (software) copy audio needs to work like this:

1) The guest buffers SG PHY pages are shared with audio device driver
and/or DSP FW at stream init.

2) Device driver or DSP FW programs DMAC IP with SG PHY pages of guest
buffer.

3) DMA is started and audio data is copied directly to audio endpoint
(I2S, HDA, SDW etc) or directly to DSP.

At this point, the audio can be rendered by guests very close to the
DMA R/W positions (low latency) if they knew the HW pointer position
accurately. The guest needs to also be able to read the stream HW
position from the device driver or DSP using a low latency method too:

4) Common timestamp between audio HW/DSP and all guests can be used and
sent over virtio. Allows guests to interpolate any drift and estimate
audio position with good accuracy using common clock.

OR

5) Common stream status between audio HW/DSP and all guests (when
supported by HW). Device driver can export RO page of stream data to
each guest that DSP FW can update with realtime true rendering
positions (Intel HW supports this feature). =20

Thanks

Liam


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

