Return-Path: virtio-dev-return-6525-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id ED3A1985EDC
	for <virtio-dev@lists.oasis-open.org>; Tue, 17 Dec 2019 14:45:51 +0000 (UTC)
Date: Tue, 17 Dec 2019 15:45:42 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20191217144542.5kptswa2ew4f6umi@sirius.home.kraxel.org>
References: <20191216130031.21912-1-Anton.Yakovlev@opensynergy.com>
MIME-Version: 1.0
In-Reply-To: <20191216130031.21912-1-Anton.Yakovlev@opensynergy.com>
Subject: [virtio-dev] Re: [PATCH v3] virtio-snd: add virtio sound device specification
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Anton Yakovlev <Anton.Yakovlev@opensynergy.com>
Cc: virtio-dev@lists.oasis-open.org, liam.r.girdwood@linux.intel.com, tiwai@suse.de, broonie@kernel.org, maz@kernel.org, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, cdupontd@redhat.com, jean-philippe@linaro.org
List-ID: <virtio-dev.lists.oasis-open.org>

  Hi,

> +\subsection{Feature bits}\label{sec:Device Types / Sound Device / Featur=
e bits}
> +
> +None currently defined.

Flags for hostmem & guestmem here?

This could be an information the driver might want to know before
initializing the virtqueues.

> +\item START
> +\item PAUSE
> +\item UNPAUSE
> +\item STOP

Why pause/unpause?

I don't see a reason compelling for this given the driver can restart a
stream (i.e. set-params -> prepare -> start -> stop -> start -> stop ->
release).  Would a device handle stop and pause in a different way?

> +/* supported PCM stream features */
> +enum {
> +    VIRTIO_SND_PCM_F_HOST_MEM =3D 0,
> +    VIRTIO_SND_PCM_F_GUEST_MEM,

Is this useful as stream property?  I would expect when supported by a
device it would work for all streams.

> +    VIRTIO_SND_PCM_F_EVT_PERIOD,

I think this is only useful for hostmem/guestmem.

> +struct virtio_snd_pcm_set_params {
> +    struct virtio_snd_pcm_hdr hdr; /* .code =3D VIRTIO_SND_R_PCM_SET_PAR=
AMS */
> +    u8 features;
> +    u8 channels;
> +    u8 format;
> +    u8 rate;
> +    le32 buffer_bytes;
> +    le32 period_bytes;
> +};
> +\end{lstlisting}
> +
> +The request contains the following fields:
> +
> +\begin{description}
> +\item[\field{features}] (device-readable) is a selected feature bit map:
> +\begin{itemize*}
> +\item VIRTIO_SND_PCM_F_HOST_MEM: use shared memory allocated by the host=
 (TBD),
> +\item VIRTIO_SND_PCM_F_GUEST_MEM: use shared memory allocated by the gue=
st (TBD),

I'd suggest to drop those bits here.  For hostmem + guestmem we probably
need a virtio_snd_pcm_set_params_{hostmem,guestmem} struct (and command)
with additional parameters anyway.

> +\item VIRTIO_SND_PCM_F_EVT_PERIOD: enable elapsed period notifications,

Same comment as above ;)

> +\begin{itemize*}
> +\item VIRTIO_SND_EVT_PCM_PERIOD: send notifications about each elapsed p=
eriod,
> +the size of the period is specified in the \field{period_bytes} field.

Same comment as above ;)

> +\subsubsection{PCM I/O Messages}\label{sec:Device Types / Sound Device /=
 Device Operation / PCM IO Messages}
> +
> +An I/O message consists of the header part, followed by the buffer, and =
then
> +the status part.

Each buffer MUST (or SHOULD?) be period_bytes in size.

The driver SHOULD queue (buffer_bytes / period_bytes) virtio buffers, so
the device has buffer_bytes total buffer space available.

cheers,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

