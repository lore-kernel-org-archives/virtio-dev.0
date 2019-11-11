Return-Path: virtio-dev-return-6312-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3EE50985D79
	for <virtio-dev@lists.oasis-open.org>; Mon, 11 Nov 2019 15:28:25 +0000 (UTC)
Message-ID: <ea394f357d9daaab8a3f463d7988cf5e3bf5cb2e.camel@linux.intel.com>
From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Date: Mon, 11 Nov 2019 15:28:17 +0000
In-Reply-To: <3a024891-4d92-0a6e-0f51-f29a7ae2b9c1@opensynergy.com>
References: <20191105150606.18194-1-Mikhail.Golubev@opensynergy.com>
	 <3a024891-4d92-0a6e-0f51-f29a7ae2b9c1@opensynergy.com>
Mime-Version: 1.0
Subject: Re: [virtio-dev] [PATCH v2] snd: Add virtio sound device
 specification
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: Mikhail Golubev <mikhail.golubev@opensynergy.com>, virtio-dev@lists.oasis-open.org
Cc: tiwai@suse.de, broonie@kernel.org, maz@kernel.org, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, Anton Yakovlev <Anton.Yakovlev@opensynergy.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, 2019-11-06 at 10:28 +0100, Mikhail Golubev wrote:
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/54
>=20
> Request for a vote.

Sorry, I think there are still too many opens. I would also recommend
that this proposal be sent to ALSA devel list (subscribers only) to get
a more thorough review since it will be difficult to fix once deployed.

Can you also provide more details on the use case testing carried out
here ?=20

>=20
> BR,
> Mikhail.
>=20
> On 11/5/19 4:06 PM, Mikhail Golubev wrote:
> > From: Anton Yakovlev <Anton.Yakovlev@opensynergy.com>
> >=20

snip

> >=20
> > +\subsection{Device Operation}\label{sec:Device Types / Sound
> > Device / Device Operation}
> > +
> > +All control messages are placed into the controlq virtqueue and
> > use the following
> > +layout structure and definitions:
> > +
> > +\begin{lstlisting}
> > +enum {
> > +    /* PCM control request types */
> > +    VIRTIO_SND_R_PCM_CHMAP_INFO =3D 0,
> > +    VIRTIO_SND_R_PCM_SET_FORMAT,
> > +    VIRTIO_SND_R_PCM_PREPARE,
> > +    VIRTIO_SND_R_PCM_START,
> > +    VIRTIO_SND_R_PCM_STOP,
> > +    VIRTIO_SND_R_PCM_PAUSE,
> > +    VIRTIO_SND_R_PCM_UNPAUSE,

Where do I tear down the PCM when I'm finished with it ? i.e. to free
resources.

> > +
> > +    /* generic status codes */
> > +    VIRTIO_SND_S_OK =3D 0x8000,
> > +    VIRTIO_SND_S_BAD_MSG,
> > +    VIRTIO_SND_S_NOT_SUPP,
> > +    VIRTIO_SND_S_IO_ERR
> > +};
> > +
> > +struct virtio_snd_ctl_msg {
> > +    /* device-read-only data */
> > +    le32 request_code;
> > +    u8 request_payload[];
> > +    /* device-writable data */
> > +    le32 response_status;
> > +    u8 response_payload[];
> > +};
> > +\end{lstlisting}
> > +

Using request_code for payload size is just asking for trouble.

> >=20
> > +
> > +\subsubsection{Device Operation: PCM I/O requests}
> > +
> > +All I/O requests are placed into the pcmq virtqueue. Each request
> > is in the
> > +following form:
> > +
> > +\begin{lstlisting}
> > +struct virtio_snd_pcm_xfer {
> > +    le32 stream;
> > +    u8 data[];
> > +    le32 status;
> > +    le32 actual_length;
> > +};

Using period/fragment/block size for PCM means we only copy the minimum
data necessary and dont have to pad.=20

Thanks

Liam


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

