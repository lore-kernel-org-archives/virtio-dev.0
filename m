Return-Path: virtio-dev-return-7012-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 61DCA9843EC
	for <virtio-dev@lists.oasis-open.org>; Mon,  6 Apr 2020 13:08:06 +0000 (UTC)
References: <20200330163413.975345-1-anton.yakovlev@opensynergy.com>
 <20200403105316.urv4wasigr33wxkm@sirius.home.kraxel.org>
From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Message-ID: <a1069a63-8213-459f-bda0-fe49ff462433@opensynergy.com>
Date: Mon, 6 Apr 2020 15:07:44 +0200
MIME-Version: 1.0
In-Reply-To: <20200403105316.urv4wasigr33wxkm@sirius.home.kraxel.org>
Content-Language: en-US
Subject: Re: [virtio-dev] Re: [PATCH v8] virtio-snd: add virtio sound device
 specification
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, liam.r.girdwood@linux.intel.com, tiwai@suse.de, broonie@kernel.org, maz@kernel.org, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, cdupontd@redhat.com, jean-philippe@linaro.org
List-ID: <virtio-dev.lists.oasis-open.org>

Hi,

On 03.04.2020 12:53, Gerd Hoffmann wrote:
>    Hi,
>=20
>> This patch proposes virtio specification for a new virtio sound device,
>> that may be useful in case when having audio is required but a device
>> passthrough or emulation is not an option.
>>
>> Signed-off-by: Anton Yakovlev <anton.yakovlev@opensynergy.com>
>> ---
>>
>> v7->v8 changes:
>> 1. Add a universal control request to query information about any
>>     configuration item (jacks, streams and channel maps). The request
>>     allows to get information in one by one or in a batch manner.
>> 2. Add a common information header that allows to link items together
>>     in a unified way.
>> 3. Rework a jack configuration as a jack information structure.
>> 4. Rework a stream configuration as a stream information structure.
>> 5. Make a channel map as a separate item and add the
>>     "Channel Map Control Messages" section.
>=20
> Looks good to me.  The new *INFO commands are certainly an improvement.
> I guess you have both guest and host implementations for this meanwhile?

Yes, we do. The driver (v8) is available at the same place:
https://github.com/OpenSynergy/linux/tree/virtio-snd-draft


>=20
> take care,
>    Gerd
>=20
>=20
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>=20
>=20

--=20
Anton Yakovlev
Senior Software Engineer

OpenSynergy GmbH
Rotherstr. 20, 10245 Berlin

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

