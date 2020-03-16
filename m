Return-Path: virtio-dev-return-6953-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 45A749849ED
	for <virtio-dev@lists.oasis-open.org>; Mon, 16 Mar 2020 20:31:18 +0000 (UTC)
References: <20200311140432.433238-1-Anton.Yakovlev@opensynergy.com>
 <20200316101954.2zlmrxm6el6hzdjz@sirius.home.kraxel.org>
From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Message-ID: <769eea1f-9ef6-94ae-b265-5dd62503b7c3@opensynergy.com>
Date: Mon, 16 Mar 2020 21:30:59 +0100
MIME-Version: 1.0
In-Reply-To: <20200316101954.2zlmrxm6el6hzdjz@sirius.home.kraxel.org>
Content-Language: en-US
Subject: Re: [virtio-dev] Re: [PATCH v7] virtio-snd: add virtio sound device
 specification
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, liam.r.girdwood@linux.intel.com, tiwai@suse.de, broonie@kernel.org, maz@kernel.org, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, cdupontd@redhat.com, jean-philippe@linaro.org
List-ID: <virtio-dev.lists.oasis-open.org>

Hi,

On 16.03.2020 11:19, Gerd Hoffmann wrote:
>    Hi,
>=20
>> 2. Rework jack configuration structure, now it's more aligned with the H=
DA spec.
>=20
> Yep, that looks good.
>=20
>> +\item[\field{hda_fn_nid}] indicates a functional node identifier
>> +(see \hyperref[intro:HDA]{HDA}, section 7.1.2).
>=20
> How is the nid used?

Since a functional group in HDA links entities of different kinds
together, as an example, the linux driver can provide different groups
as different PCM devices (and this well aligns with hardware case when
streams with different capabilities live in different groups). This may
be necessary to reassign the jack, because you need to know which
streams are attached to the jacks. In addition, it will allow you to
associate device controls with the stream/PCM device.


> In general some of the defconf and caps fields might need some
> clarification if and how they are used, given we just cherry-pick
> some items from the HDA spec ...

Yes, I also thought about it. But will this lead to a direct dependence
on the HDA specification? If something changes there, we should update
here. Therefore, I left these elements transparent and allowed the
device/driver to decide on the wise use of these fields.


>> +\item[\field{hda_reg_caps}] indicates a pin capabilities value
>> +(see \hyperref[intro:HDA]{HDA}, section 7.3.4.9).
>=20
> ... for example:
>=20
> If the "Presence Detect Capable" bit is set the status is available in
> the "connected" field.
>=20
> "VRef Control" is not supported and must be zero.
>=20
>> +\item[\field{connected}] indicates the current jack connection status
>> +(1 - connected, 0 - disconnected).
>=20
> cheers,
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

