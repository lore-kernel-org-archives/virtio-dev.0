Return-Path: virtio-dev-return-6617-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5BA59985E05
	for <virtio-dev@lists.oasis-open.org>; Wed,  8 Jan 2020 11:04:53 +0000 (UTC)
References: <20200107125049.99728-1-Anton.Yakovlev@opensynergy.com>
 <20200108103447.geh6qb4hay6konft@sirius.home.kraxel.org>
From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Message-ID: <c103cd0b-07c9-bff7-83e0-f2897e28c613@opensynergy.com>
Date: Wed, 8 Jan 2020 12:04:48 +0100
MIME-Version: 1.0
In-Reply-To: <20200108103447.geh6qb4hay6konft@sirius.home.kraxel.org>
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH v4] virtio-snd: add virtio sound device specification
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, liam.r.girdwood@linux.intel.com, tiwai@suse.de, broonie@kernel.org, maz@kernel.org, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, cdupontd@redhat.com, jean-philippe@linaro.org
List-ID: <virtio-dev.lists.oasis-open.org>

On 08.01.2020 11:34, Gerd Hoffmann wrote:
> On Tue, Jan 07, 2020 at 01:50:49PM +0100, Anton Yakovlev wrote:
>> This patch proposes virtio specification for a new virtio sound device,
>> that may be useful in case when having audio is required but a device
>> passthrough or emulation is not an option.
>=20
> Looks pretty good overall.  Some small nits:
>=20
>> +/* a common header */
>> +struct virtio_snd_hdr {
>> +    le32 code;
>> +};
>> +
>> +/* an event notification */
>> +struct virtio_snd_event {
>> +    le32 type;
>=20
> Use "struct virtio_snd_hdr hdr" instead of "type", for consistency with
> the other structs?

Yes, good idea.


>> +\begin{description}
>> +\item[\field{code}] (device-readable) specifies a device request type
>> +(VIRTIO_SND_R_*).
>> +\end{description}
>> +
>> +A response part has, or consists of, a common header containing the fol=
lowing
>> +field:
>> +
>> +\begin{description}
>> +\item[\field{code}] (device-writable) specifies a device request status
>> +(VIRTIO_SND_S_*).
>> +\end{description}
>=20
> Repeating "device-readable" or "device-writable" for each struct field
> looks a bit odd because this applies to the whole struct.  Not so much
> for these structs with a single field only, but there are structs with
> more fields further down the spec ...

Well, I'm not sure here. Previously, I was told to mark explicitly every
field.


>> +\begin{description}
>> +\item[\field{type}] (device-writable) specifies an event type (VIRTIO_S=
ND_EVT_*).
>> +\item[\field{data}] (device-writable) specifies an optional event data.
>> +\end{description}
>=20
> ... here for example.
>=20
>> +/* a response containing PCM stream capabilities */
>> +struct virtio_snd_pcm_caps {
>> +    struct virtio_snd_hdr hdr; /* VIRTIO_SND_S_XXX */
>> +    u8 directions; /* 1 << VIRTIO_SND_PCM_T_XXX */
>> +    u8 channels_min;
>> +    u8 channels_max;
>> +    u8 features; /* 1 << VIRTIO_SND_PCM_F_XXX */
>> +    le64 formats; /* 1 << VIRTIO_SND_PCM_FMT_XXX */
>> +    le32 rates; /* 1 << VIRTIO_SND_PCM_RATE_XXX */
>=20
> Use le64 for rates too, just in case?
>=20
> For features a few more bits don't hurt too, we already have 5 defined,
> so having only 8 total available isn't that much for possible
> extensions ...

Okey, then I will rearrange the structure.


>> +\paragraph{VIRTIO_SND_R_PCM_PAUSE}
>> +\paragraph{VIRTIO_SND_R_PCM_UNPAUSE}
>=20
> Still here.
>=20
> So there are good reasons to keep them instead of just using stop/start?

We can get rid of pause/unpause at the moment. Later, they can be added as =
a=20
stream feature, if necessary.

Also, regarding requirement for populating tx/rx queues with period size=20
buffers. Maybe it's better to replace MUST with SHOULD? It would give more=
=20
flexibility for the driver. What do you think?


--=20
Anton Yakovlev
Senior Software Engineer

OpenSynergy GmbH
Rotherstr. 20, 10245 Berlin

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

