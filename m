Return-Path: virtio-dev-return-6339-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5C998985D81
	for <virtio-dev@lists.oasis-open.org>; Tue, 19 Nov 2019 15:14:19 +0000 (UTC)
Message-ID: <cf778ac23a8a059dec4b3ef24c09eaf7714d37bf.camel@linux.intel.com>
From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Date: Tue, 19 Nov 2019 15:14:12 +0000
In-Reply-To: <893007b8-a104-6b4b-8221-57c70210869a@opensynergy.com>
References: <20191105150606.18194-1-Mikhail.Golubev@opensynergy.com>
	 <3a024891-4d92-0a6e-0f51-f29a7ae2b9c1@opensynergy.com>
	 <ea394f357d9daaab8a3f463d7988cf5e3bf5cb2e.camel@linux.intel.com>
	 <893007b8-a104-6b4b-8221-57c70210869a@opensynergy.com>
Mime-Version: 1.0
Subject: Re: [virtio-dev] [PATCH v2] snd: Add virtio sound device
 specification
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: Anton Yakovlev <anton.yakovlev@opensynergy.com>, Mikhail Golubev <mikhail.golubev@opensynergy.com>, virtio-dev@lists.oasis-open.org
Cc: tiwai@suse.de, broonie@kernel.org, maz@kernel.org, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, 2019-11-14 at 14:23 +0100, Anton Yakovlev wrote:
> > > >=20
> > > > +\subsection{Device Operation}\label{sec:Device Types / Sound
> > > > Device / Device Operation}
> > > > +
> > > > +All control messages are placed into the controlq virtqueue
> > > > and
> > > > use the following
> > > > +layout structure and definitions:
> > > > +
> > > > +\begin{lstlisting}
> > > > +enum {
> > > > +    /* PCM control request types */
> > > > +    VIRTIO_SND_R_PCM_CHMAP_INFO =3D 0,
> > > > +    VIRTIO_SND_R_PCM_SET_FORMAT,
> > > > +    VIRTIO_SND_R_PCM_PREPARE,
> > > > +    VIRTIO_SND_R_PCM_START,
> > > > +    VIRTIO_SND_R_PCM_STOP,
> > > > +    VIRTIO_SND_R_PCM_PAUSE,
> > > > +    VIRTIO_SND_R_PCM_UNPAUSE,
> >=20
> > Where do I tear down the PCM when I'm finished with it ? i.e. to
> > free
> > resources.
>=20
> Current workflow:
> - a PCM stream is preparing with the set_format/prepare/start
> requests
> - if necessary, resources are freed/released with the stop request
>=20
> If needed, the stream can be temporary paused (the pause/unpause
> requests).

Temp pause/unpause is fine, since we can keep audio power ON to avoid
audio atifacts and we resume from the same position.=20

However, there are times when we need to stop audio for longer periods
and restart (where we do want to power down) or when we want to recover
a stream by stopping and then restarting it (without having to resend
all the params and realloc buffers etc).

I would recommend you have something like VIRTIO_SND_R_PCM_FREE to free
all resource and not overload STOP.

Liam=20


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

