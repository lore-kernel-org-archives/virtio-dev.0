Return-Path: virtio-dev-return-6959-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9171C985CE6
	for <virtio-dev@lists.oasis-open.org>; Tue, 17 Mar 2020 09:39:30 +0000 (UTC)
References: <20200311140432.433238-1-Anton.Yakovlev@opensynergy.com>
 <20200316101954.2zlmrxm6el6hzdjz@sirius.home.kraxel.org>
 <769eea1f-9ef6-94ae-b265-5dd62503b7c3@opensynergy.com>
 <20200317091533.biyhxvpjrbqgdxds@sirius.home.kraxel.org>
From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Message-ID: <ae0ed378-12e0-ae9d-ed41-fe1f47558aaa@opensynergy.com>
Date: Tue, 17 Mar 2020 10:39:23 +0100
MIME-Version: 1.0
In-Reply-To: <20200317091533.biyhxvpjrbqgdxds@sirius.home.kraxel.org>
Content-Language: en-US
Subject: Re: [virtio-dev] Re: [PATCH v7] virtio-snd: add virtio sound device
 specification
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, liam.r.girdwood@linux.intel.com, tiwai@suse.de, broonie@kernel.org, maz@kernel.org, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, cdupontd@redhat.com, jean-philippe@linaro.org
List-ID: <virtio-dev.lists.oasis-open.org>

Hi,

On 17.03.2020 10:15, Gerd Hoffmann wrote:
> On Mon, Mar 16, 2020 at 09:30:59PM +0100, Anton Yakovlev wrote:
>> Hi,
>>
>> On 16.03.2020 11:19, Gerd Hoffmann wrote:
>>>     Hi,
>>>
>>>> 2. Rework jack configuration structure, now it's more aligned with the=
 HDA spec.
>>>
>>> Yep, that looks good.
>>>
>>>> +\item[\field{hda_fn_nid}] indicates a functional node identifier
>>>> +(see \hyperref[intro:HDA]{HDA}, section 7.1.2).
>>>
>>> How is the nid used?
>>
>> Since a functional group in HDA links entities of different kinds
>> together, as an example, the linux driver can provide different groups
>> as different PCM devices (and this well aligns with hardware case when
>> streams with different capabilities live in different groups). This may
>> be necessary to reassign the jack, because you need to know which
>> streams are attached to the jacks. In addition, it will allow you to
>> associate device controls with the stream/PCM device.
>=20
> Ah, there is virtio_snd_pcm_config.hda_fn_nid.  So this is how jacks are
> associated with streams.  Havn't noticed this update before.

Yes, you are right.

Also, I think we should decouple a chmap from stream configuration and=20
make it as yet one optional module of a functional group. Because now,
if a group contains more than one stream, then it's not clear how to
properly provide chmap information.


>>> In general some of the defconf and caps fields might need some
>>> clarification if and how they are used, given we just cherry-pick
>>> some items from the HDA spec ...
>>
>> Yes, I also thought about it. But will this lead to a direct dependence
>> on the HDA specification? If something changes there, we should update
>> here. Therefore, I left these elements transparent and allowed the
>> device/driver to decide on the wise use of these fields.
>=20
> I'm mostly thinking about virtio-sound specific stuff which obviously
> isn't covered by the HDA spec, like this:
>=20
>>> If the "Presence Detect Capable" bit is set the status is available in
>>> the "connected" field.

I think, the connected field is valid in any case. Since it indicates
device presence at the moment of jack initialization. This is done so as
not to send unnecessary notification after the virtio device is
initialized.


--=20
Anton Yakovlev
Senior Software Engineer

OpenSynergy GmbH
Rotherstr. 20, 10245 Berlin

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

