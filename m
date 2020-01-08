Return-Path: virtio-dev-return-6613-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8F4F5985E01
	for <virtio-dev@lists.oasis-open.org>; Wed,  8 Jan 2020 10:34:55 +0000 (UTC)
Date: Wed, 8 Jan 2020 11:34:47 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20200108103447.geh6qb4hay6konft@sirius.home.kraxel.org>
References: <20200107125049.99728-1-Anton.Yakovlev@opensynergy.com>
MIME-Version: 1.0
In-Reply-To: <20200107125049.99728-1-Anton.Yakovlev@opensynergy.com>
Subject: [virtio-dev] Re: [PATCH v4] virtio-snd: add virtio sound device specification
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Anton Yakovlev <Anton.Yakovlev@opensynergy.com>
Cc: virtio-dev@lists.oasis-open.org, liam.r.girdwood@linux.intel.com, tiwai@suse.de, broonie@kernel.org, maz@kernel.org, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, cdupontd@redhat.com, jean-philippe@linaro.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Jan 07, 2020 at 01:50:49PM +0100, Anton Yakovlev wrote:
> This patch proposes virtio specification for a new virtio sound device,
> that may be useful in case when having audio is required but a device
> passthrough or emulation is not an option.

Looks pretty good overall.  Some small nits:

> +/* a common header */
> +struct virtio_snd_hdr {
> +    le32 code;
> +};
> +
> +/* an event notification */
> +struct virtio_snd_event {
> +    le32 type;

Use "struct virtio_snd_hdr hdr" instead of "type", for consistency with
the other structs?

> +\begin{description}
> +\item[\field{code}] (device-readable) specifies a device request type
> +(VIRTIO_SND_R_*).
> +\end{description}
> +
> +A response part has, or consists of, a common header containing the foll=
owing
> +field:
> +
> +\begin{description}
> +\item[\field{code}] (device-writable) specifies a device request status
> +(VIRTIO_SND_S_*).
> +\end{description}

Repeating "device-readable" or "device-writable" for each struct field
looks a bit odd because this applies to the whole struct.  Not so much
for these structs with a single field only, but there are structs with
more fields further down the spec ...

> +\begin{description}
> +\item[\field{type}] (device-writable) specifies an event type (VIRTIO_SN=
D_EVT_*).
> +\item[\field{data}] (device-writable) specifies an optional event data.
> +\end{description}

... here for example.

> +/* a response containing PCM stream capabilities */
> +struct virtio_snd_pcm_caps {
> +    struct virtio_snd_hdr hdr; /* VIRTIO_SND_S_XXX */
> +    u8 directions; /* 1 << VIRTIO_SND_PCM_T_XXX */
> +    u8 channels_min;
> +    u8 channels_max;
> +    u8 features; /* 1 << VIRTIO_SND_PCM_F_XXX */
> +    le64 formats; /* 1 << VIRTIO_SND_PCM_FMT_XXX */
> +    le32 rates; /* 1 << VIRTIO_SND_PCM_RATE_XXX */

Use le64 for rates too, just in case?

For features a few more bits don't hurt too, we already have 5 defined,
so having only 8 total available isn't that much for possible
extensions ...

> +\paragraph{VIRTIO_SND_R_PCM_PAUSE}
> +\paragraph{VIRTIO_SND_R_PCM_UNPAUSE}

Still here.

So there are good reasons to keep them instead of just using stop/start?

cheers,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

