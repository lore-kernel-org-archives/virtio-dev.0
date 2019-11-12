Return-Path: virtio-dev-return-6319-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C6265985E61
	for <virtio-dev@lists.oasis-open.org>; Tue, 12 Nov 2019 11:09:41 +0000 (UTC)
Date: Tue, 12 Nov 2019 12:09:37 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
Message-ID: <20191112110937.GA4187507@lophozonia>
References: <20190924144323.4590-1-Mikhail.Golubev@opensynergy.com>
 <6a4978e85505ae00ca9e2b170f5e893a064c03d2.camel@linux.intel.com>
 <568f32dc-8d82-a189-469f-5cb3a0140b8c@opensynergy.com>
 <0cc8007b70f4f5984223703313730d8e066006a7.camel@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <0cc8007b70f4f5984223703313730d8e066006a7.camel@linux.intel.com>
Subject: Re: [virtio-dev] [PATCH] snd: Add virtio sound device specification
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Anton Yakovlev <anton.yakovlev@opensynergy.com>, Mikhail Golubev <Mikhail.Golubev@opensynergy.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi,

On Mon, Nov 11, 2019 at 03:20:55PM +0000, Liam Girdwood wrote:
> > > > +struct virtio_snd_ctl_msg {
> > > > +    /* device-read-only data */
> > > > +    le32 request_code;
> > > > +    u8 request_payload[];
> > >=20
> > > How do I know how much data to read here ? Is size embedded in
> > > request_code ?
> >=20
> > Yes, you are right. Actual request/response length can be easily
> > derived from=20
> > a request_code.
> >=20
>=20
> Nak, please use a separate size and type code otherwise we will have
> real problems in the future when we come to add new features (with new
> codes or bigger sizes).

Other virtio devices rely on the buffer length already provided by virtio
for this. For example see the virtio-net control virtqueue
(virtio_net_ctrl*), which is extended with new commands from time to time.
Most recently, the "receive-side scaling" feature introduces a large
structure as payload to virtio_net_ctrl.

[...]
> > > > +\begin{lstlisting}
> > > > +struct virtio_snd_pcm_xfer {
> > > > +    le32 stream;
> > > > +    u8 data[];
> > > > +    le32 status;
> > > > +    le32 actual_length;
> > >=20
> > > Not following this, is actual_length the size of data[]. If so, it
> > > must
> > > preceed data[].
> >=20
> > No, the actual_length field is supposed to be used by device side to
> > report
> > actual amount of bytes read from/written to a buffer.

By the way the written size is already provided by virtio (field len in
the used descriptor), but not the read size.

> > In real world
> > scenario,=20
> > if an I/O request contains N bytes, a device can play/capture *up to*
> > N bytes.=20
> > Thus, it's required to report this length back to a driver.
> >=20
>=20
> This is not how PCM audio buffering works. I don't copy extra padding
> if I dont need to, I only copy when my buffer is full. See the need for
> period size in earlier comments.
[...]
> > > 2) Zero copy of audio data and stream positions. Essential for any
> > > low
> > > latency audio use cases (if supported by HW, hypervisor, VM
> > > framework).
> >=20
> > What do you mean by zero-copy? Shared memory between device and
> > driver sides?
>=20
> Yes, but I see this is now a separate thread as it used by others too.

The virtio transport already permits zero-copy, because one buffer can be
described with a chain of descriptors, each pointing to a different area
in memory. The driver can split the virtio_snd_pcm_xfer into header and
data:

    virtqueue
    desc ring
    |       |
    +-------+
    |       |---------> header (copied)
    +- - - -+
    |       |---------> PCM data (mapped)
    +-------+
    |       |

So it might be a good idea to put all the metadata (stream, status,
actual_length) at the beginning of the virtio_snd_pcm_xfer struct,
otherwise the driver will need three descriptors instead of two to achieve
this.

Thanks,
Jean

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

