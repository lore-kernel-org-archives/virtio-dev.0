Return-Path: virtio-dev-return-6333-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2DAF8985F81
	for <virtio-dev@lists.oasis-open.org>; Thu, 14 Nov 2019 13:23:32 +0000 (UTC)
References: <20191105150606.18194-1-Mikhail.Golubev@opensynergy.com>
 <3a024891-4d92-0a6e-0f51-f29a7ae2b9c1@opensynergy.com>
 <ea394f357d9daaab8a3f463d7988cf5e3bf5cb2e.camel@linux.intel.com>
From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Message-ID: <893007b8-a104-6b4b-8221-57c70210869a@opensynergy.com>
Date: Thu, 14 Nov 2019 14:23:25 +0100
MIME-Version: 1.0
In-Reply-To: <ea394f357d9daaab8a3f463d7988cf5e3bf5cb2e.camel@linux.intel.com>
Content-Language: en-US
Subject: Re: [virtio-dev] [PATCH v2] snd: Add virtio sound device
 specification
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mikhail Golubev <mikhail.golubev@opensynergy.com>, virtio-dev@lists.oasis-open.org
Cc: tiwai@suse.de, broonie@kernel.org, maz@kernel.org, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 11.11.2019 16:28, Liam Girdwood wrote:
> On Wed, 2019-11-06 at 10:28 +0100, Mikhail Golubev wrote:
>> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/54
>>

snip

>>>
>>> +\subsection{Device Operation}\label{sec:Device Types / Sound
>>> Device / Device Operation}
>>> +
>>> +All control messages are placed into the controlq virtqueue and
>>> use the following
>>> +layout structure and definitions:
>>> +
>>> +\begin{lstlisting}
>>> +enum {
>>> +    /* PCM control request types */
>>> +    VIRTIO_SND_R_PCM_CHMAP_INFO =3D 0,
>>> +    VIRTIO_SND_R_PCM_SET_FORMAT,
>>> +    VIRTIO_SND_R_PCM_PREPARE,
>>> +    VIRTIO_SND_R_PCM_START,
>>> +    VIRTIO_SND_R_PCM_STOP,
>>> +    VIRTIO_SND_R_PCM_PAUSE,
>>> +    VIRTIO_SND_R_PCM_UNPAUSE,
>=20
> Where do I tear down the PCM when I'm finished with it ? i.e. to free
> resources.

Current workflow:
- a PCM stream is preparing with the set_format/prepare/start requests
- if necessary, resources are freed/released with the stop request

If needed, the stream can be temporary paused (the pause/unpause requests).

snip

--=20
Anton Yakovlev
Senior Software Engineer

OpenSynergy GmbH
Rotherstr. 20, 10245 Berlin

Phone: +49 30 60 98 54 0
E-Mail: anton.yakovlev@opensynergy.com

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

