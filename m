Return-Path: virtio-dev-return-6349-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3A412985E6F
	for <virtio-dev@lists.oasis-open.org>; Wed, 20 Nov 2019 11:10:06 +0000 (UTC)
Date: Wed, 20 Nov 2019 12:09:57 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20191120110957.dj7dnz7hmb3zj5en@sirius.home.kraxel.org>
References: <20191105150606.18194-1-Mikhail.Golubev@opensynergy.com>
 <20191112132025.GB4187507@lophozonia>
 <778905a7-f41b-d44b-f590-15945096e535@opensynergy.com>
MIME-Version: 1.0
In-Reply-To: <778905a7-f41b-d44b-f590-15945096e535@opensynergy.com>
Subject: Re: [virtio-dev] [PATCH v2] snd: Add virtio sound device
 specification
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, Mikhail Golubev <Mikhail.Golubev@opensynergy.com>, virtio-dev@lists.oasis-open.org, liam.r.girdwood@linux.intel.com, tiwai@suse.de, broonie@kernel.org, maz@kernel.org, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com
List-ID: <virtio-dev.lists.oasis-open.org>

  Hi,

> > > +\begin{description}
> > > +\item[0] controlq
> > > +\item[1] pcmq
> > > +\end{description}
> > > +
> > > +The controlq virtqueue always exists, the pcmq virtqueue only exists=
 if
> > > +the VIRTIO_SND_F_PCM_OUTPUT and/or VIRTIO_SND_F_PCM_INPUT feature is=
 negotiated.
> >=20
> > Why not use two queues, one for input and one for output?  I think most
> > virtio devices do it that way. It could simplify the implementations,
> > shave 32 bits off the buffers, and allow to quiesce notifications for
> > input and output streams independently. And in the future you can exten=
d
> > the device with more than two streams.
>=20
> This was discussed earlier (having two separate virtqueues vs multiplexin=
g
> into single one). It's hard to say what is better, but at least one
> virtqueue =3D less maintenance work at runtime.

I'd suggest separate tx (playback) and rx (record) queues, the workflow
is quite different so that makes sense.  Multiplexing multiple playback
streams over a single tx queue is alot less problematic than handling
both rx and tx in a single queue.

> > > +\begin{lstlisting}
> > > +enum {
> > > +    /* PCM control request types */
> > > +    VIRTIO_SND_R_PCM_CHMAP_INFO =3D 0,
> > > +    VIRTIO_SND_R_PCM_SET_FORMAT,
> > > +    VIRTIO_SND_R_PCM_PREPARE,
> > > +    VIRTIO_SND_R_PCM_START,
> > > +    VIRTIO_SND_R_PCM_STOP,
> > > +    VIRTIO_SND_R_PCM_PAUSE,
> > > +    VIRTIO_SND_R_PCM_UNPAUSE,
> > > +
> > > +    /* generic status codes */
> > > +    VIRTIO_SND_S_OK =3D 0x8000,
> > > +    VIRTIO_SND_S_BAD_MSG,
> > > +    VIRTIO_SND_S_NOT_SUPP,
> > > +    VIRTIO_SND_S_IO_ERR
> > > +};
> >=20
> > Any reason not to use two separate enums starting from 0?
>=20
> It's funny, because initially there were exactly two separate enums. It w=
as
> proposed to combine them into one to keep things in one place.

Having non-overlapping values for request types and status codes is more
robust, so IMO this is a good thing.  I'd also suggest to *not* start
from 0 (so a fresh, zero-initialized field is not a valid request type).

> > > +struct virtio_snd_ctl_msg {
> > > +    /* device-read-only data */
> > > +    le32 request_code;
> > > +    u8 request_payload[];
> > > +    /* device-writable data */
> > > +    le32 response_status;
> > > +    u8 response_payload[];
> > > +};
> > > +\end{lstlisting}

Must be splitted into out and in structs (see also virtqueue element
discussion in v1 thread).

I'd also suggest to specify a union for the payload.  Or different
structs for different request types (if they have a payload).

cheers,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

