Return-Path: <virtio-dev-return-13129-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E462EB64DA
	for <virtio-dev@archiver.kernel.org>; Wed, 28 Jun 2023 16:46:10 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 5FD517A068
	for <virtio-dev@archiver.kernel.org>; Wed, 28 Jun 2023 16:46:09 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5A2529865CE
	for <virtio-dev@archiver.kernel.org>; Wed, 28 Jun 2023 16:46:09 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 4B4C4986585; Wed, 28 Jun 2023 16:46:09 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 38D7D986587;
	Wed, 28 Jun 2023 16:46:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ME6HOisU5lrzeuASSP7tt5dtoq/cSw4jPCjMFoPgEh6tjF8Wv9/9n09RvCblrqawrMYNAx387TwbXYxpcR9wc1zRlXPFFzCdFBPEePZ4KP2tm3ittT983PA343v8CRhtdYMUfCsHcrAR3EqetrEmNyqEMo455cIXQTtkjbE/l0imKVNsxv9o54Vj+p4UxyT5AFXqfETpvqvY1tOOVp48KUk+Kmrq1tjh14OL8D+ekOulf13mVT2w6hm/ez8UZDlMKDfRDgaAL2ibUiIOAd0nEHTqEhdeID949Ah6ZjxErMMeDnHd3dA7mfWJIDmNgmbw2SrL5e/IRuBgUmU9VFWBpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lhdBrUVg4Ypz60fNUEl5qiwAxfQeVeX7F7hUdyWpZrQ=;
 b=LYk4QNFP+0zuW0zdYuTmJryoHkl63Z8Z8S/DRXKTKDx5QXCA0lffNy+708LHBPWmwnrctHDA3Jvt2CLBysVHPitbjiaOfzf7JGmuOmr0n4ORxYQ0YxMcrKTWJUlaOaBkuJ83rdk2nawDIDU8C5FeGufR20kxeL2VuSSKBIdAa+UlS5hwEU5jqqYmWue6oNpnWP64+WC+rxlqaddgqBe2CGM/fzCLq6ANo2BR5ERQCSL+U04W28a3HHuFFfBJBUyFj3ZpuRNqyQkeE8wJM1wtpm/33YedTP7kLv0fEcIx37tmJ2gk84SyggRVoNN8lN0fV5T3kwRp1cVG2B9iTGuBCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Heng Qi <hengqi@linux.alibaba.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, Jason Wang <jasowang@redhat.com>, Yuri
 Benditovich <yuri.benditovich@daynix.com>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>, Cornelia Huck <cohuck@redhat.com>
Thread-Topic: [virtio-comment] Re: [PATCH v18] virtio-net: support inner
 header hash
Thread-Index:
 AQHZpEdpSlZ4I0eUeUmZIFkjtAkw3q+VZGYAgAASyQCAAC5zgIAAADyAgAAMJYCAAAHeEIAABAeAgAAB1cCAAKHPAIAAY0PggAAXcACAAAvqkIAAJ4CAgAAA4ICAAAPngIAAAI9wgAAGWICAAAbYIIAI9WyAgABeQeA=
Date: Wed, 28 Jun 2023 16:46:04 +0000
Message-ID:
 <PH0PR12MB5481F6DD7652BE1998635DE2DC24A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230622021932-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54815D6D07A49CE775620088DC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <82e83a90-6491-c20b-d96d-f9e0d15c2641@linux.alibaba.com>
 <PH0PR12MB5481A5055A5F58045437391CDC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230622123203-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548100743287D401B8ED78CFDC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230622125601-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481FFF9F0F1443F75782C26DC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230622131455-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54812CE792CC801B36AC6E56DC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230628062758-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230628062758-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SA3PR12MB9200:EE_
x-ms-office365-filtering-correlation-id: 9a50baea-4d73-4406-9082-08db77f72a19
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 TXExFruIG1T591yRnqniX5OTH+prJ2w1rJcK/7vc2dTyFG67FSjAJ4zN7LLB1xdBQUit2dGXisIEbB2aXzDxo8fmnQZ8at22QNzyJB079S2qkUSC4VGtlYxK2VDmRkcUkgmL/EVZfXc/4ME5hGjtoKC3friMLE4pidGbtPlFe/wIBMMeUPsI4N11mRAOP3jxkgq4xkfjN1oEuNf+oM8IvMykFSlGtVMrAL8hysCag21YBIQjCFXocRcEoctWBKicg1OmBtkoHVltY6lEI+wYNUmsYuyMrEqTdH9/R8mJIyG6tdvrcZHjmWb9c4A7YYpi3Yd4kD+KLl/FXorLhWGW1aPpmqQ9QBXgDO2wIkVGf8OQ2vEMdHzqzaigvFNHHyh39EYDDZxQHvjaE1z7IcxMTBJhwqtMKD2eendEM5OUR3+lUE99cTUZ9AC8t1sBCZQH6E8JPCK3PRVoygPku6frYxKJ7jFHKWVsPz7KiVnmVEQc6Kg1cTB4LUfhsla9hd/cjPcpX16oqaWOqegVWTYF0yAXbp9lfX0v6P9lshaFTSxgNZ0PlMIfpaOkBtKhXqINrXE3Z+2ClFzFUxreERUPlknXSEjDaDW1slEqdB9Y6v7CcSFQA5tYjeMORtzMULI5
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(39860400002)(396003)(346002)(136003)(451199021)(7696005)(2906002)(9686003)(38100700002)(26005)(83380400001)(71200400001)(122000001)(6506007)(186003)(55016003)(41300700001)(86362001)(54906003)(4326008)(38070700005)(478600001)(66556008)(66946007)(66446008)(33656002)(316002)(76116006)(6916009)(66476007)(64756008)(8936002)(5660300002)(8676002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?LE5Q9+U+JqsReIzTQj7y1pJyUPsVrI9HSgK2HyUs24Yzw2JZIkURZZvmn1ix?=
 =?us-ascii?Q?MYwZaOWTAjv8kYAJZPG+T3ZXRdnLOp4hL0muzghkmbqaMWpUCrdtvdVXe97C?=
 =?us-ascii?Q?NzU3tgN64MfkTHo1/KMgzCa03z8hGdLsTyXMVPHt6yNUKwD4W6JTFbCC+quU?=
 =?us-ascii?Q?c/6R7A7fosl9oGHTZe3k1GEY0gGK85vmuNPm6SwVJ971/KfSVFe5WNxXdVJT?=
 =?us-ascii?Q?XUPI/1iEcQiAhib5dYoeHM2cNeeTgaozyMTH64xHz2baWsMuko51kwVNq4by?=
 =?us-ascii?Q?sjNx05yGMrU7DBeWu1YpWxVIRreRF8UoeWYqov3+fVjZBAD5ptwSpsTIMK0C?=
 =?us-ascii?Q?6uk+263essdX4sw36pjEd9aqdQqDNmvL5FrXoEJ9tnzJaYsuBiEG4jv6rncC?=
 =?us-ascii?Q?05J2lcXWVXuCg9m7cRUCWSAjxREtJx9/fdefkZz9GJLZIExaZtHvXjYbkN/h?=
 =?us-ascii?Q?p0kP8CSDsKQ+3Nu5mOxPT3yA1agGzoXa4Rzj5hSmxzBloOw+HBkFHP6hi2oi?=
 =?us-ascii?Q?5GxanmXBrBufmnsmk2+4ggzSaJ7RFF21Ewg5jxqpQn3Sorqx+IH9bFYHblCf?=
 =?us-ascii?Q?ct4u0NFyKmj/ForxrRC5aZcGFAJ8hVSq05cAIa9dqn7Z9CWnrQnZ+oEBgqeH?=
 =?us-ascii?Q?3u5d/k1y0yoOg0rHDav9bSQJ3xy4rDzx23FDstS1bcwKU2w/2b/vUdSS/No/?=
 =?us-ascii?Q?bxFiFLqFyDp+Re+kbs5jBz34XYDvjJGuxOA5VLtayKiYuir9Cq73BeKZY0rn?=
 =?us-ascii?Q?7VDpDE3yHpGyl6omfBukzBEQxZpxhKlAuGgf+0hek6ua1w26L4hiPtBSOC4a?=
 =?us-ascii?Q?jP6Wz7IEqeFNfIlunrSH6nFk0009PfPIMVaKTBkf+UKAr7T6A7btJO6fox4p?=
 =?us-ascii?Q?UuiLPkJLiKiWOzCfJ4ZkSEEXY9Xg30efAoKobNqdJJ615JsLius5P7LnYjkZ?=
 =?us-ascii?Q?YeX7eSKh/LTz24f56DwZSzHOaOFegds8X0achFlkbrvpfkb6gOO1fARu3thY?=
 =?us-ascii?Q?b1aIU1FW9pIljcCR7ie+R1bVCkQ8AMNoo1MdPiZHuC1Cw0eUOb00sDp2jktF?=
 =?us-ascii?Q?mjCONTKuQRIuz/5e9d5PGet6HhF1cMzepQ30esQqON4lHRol8PnP9xouRSyS?=
 =?us-ascii?Q?sT7+oHM8cZVhRfRrJAeX+jPtmIrqJxp3LdWZnKUqexF0NdLspCh+PONhsnig?=
 =?us-ascii?Q?uelbLpGgCJrMSi0T8nSUkUWKSNcLHBF0F3yy/WfxrgUqUcjGR0TKP4aVNkK8?=
 =?us-ascii?Q?0yNzaJArBEbc4XPkZ4V8/cgDZeYU+KuQgTA+rqjUB77i3fmvRFMFbiWh/LqB?=
 =?us-ascii?Q?mws4QZsW9/1WQEz75Jw5Q41N2l1XBjKkNcWPmZmERENk3xuAgGcccCrX7aZD?=
 =?us-ascii?Q?KuFibTUPipCGAFLL8984UOTBM72G2EaKCUqyp0lTY01AYvyDHJIs29ubQHGI?=
 =?us-ascii?Q?1d7DxyGJZ9sx3kP5POITcRmVQd1nZ15AuPJ9FGBFeSzA+ljJaKIo6Hzauhxk?=
 =?us-ascii?Q?iBoXeLoyv19HA+RTL8b/tf5StV1oZi6RU4DIabJXPDi79mkRHTyew+isHjSG?=
 =?us-ascii?Q?+7FJx93LDB305ccv+Jg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a50baea-4d73-4406-9082-08db77f72a19
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2023 16:46:04.9752
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GVHHOHWeAMVWMd35IwPbbBU1rBgRSdxnS+iOsgIKE3Fd7zQ6Yyl6RDyjaEXG03h12ppGUCb7X+MmBtFcCzLIBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9200
Subject: [virtio-dev] RE: [virtio-comment] Re: [PATCH v18] virtio-net: support inner header
 hash


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Wednesday, June 28, 2023 6:41 AM

> > > So just quickly add the new capability in the spec and then the
> > > number of linux releases that will have the new feature but not
> > > config command or whatever that is will be too small for vendors to c=
are.
> > >
> > I didn't follow this suggestion.
>=20
> It is very simple though. 1.3 has inner hash feature. Imagine that instea=
d of
> endless flamewars rehashing same arguments, immediately post

For sure if you call this discussion a war, I didn't start it and I didn't =
delay it to this point either :)

Patch added GET and SET command, GET returns device static and dynamic valu=
e, without burdening the device in consistent way.
Will moving to config space, take away the GET command? No?

Then what did one gain other than extra complexity of additional config spa=
ce? Just more device memory burning.

> 1.3 we vote on an interface to access config space through DMA (not sure =
it's a
> VQ BTW but that's a separate discussion).  This should include a way to e=
xpose
> a subset of DMA features through MMIO, for compatibility.

I think you are missing the main point that I try to highlight but presumab=
ly it didn't come across. :(

Having an optional DMA interface does _not_ help device to optimize, becaus=
e device must be support old drivers.

The proposal I explained in previous email is:
a. All new fields via vq
This means it is _guaranteed_ to be offchip and zero reason for backward co=
mpatibility, because there is no backward compat of non existing fields.

b. all existing fields stay in cfg space

c. Optionally existing fields can also be queried via cfg space

> If we are lucky guest support can land in the same Linux release that has=
 inner
> hash.  Drivers do not need to care: they just do virtio_cread and that is=
 it.
>
virtio_cread for extended config space accessible only via DMA or VQ will s=
urely be hidden inside th virtio_cread(). Easy.
=20
If we agree on this approach, great, one additional field like this can be =
added to config space.

> So a vendor that builds device with inner hash, can expose inner hash onl=
y
> through DMA and not through MMIO.
>=20
> I conclude that there's no reason to block this feature just because it u=
ses config
> space.
>
I must repeat that I am not blocking, I replied to way back on both the app=
roaches in v14 or even before that.
And also explained part of the proposal.

This is why one should discuss the design and not keep asking for patches..
=20
>=20
> > > >
> > > > > A good implementation of virtio_cread can abstract that easily
> > > > > so we don't need to change drivers.
> > > >
> > > > There is no backward compat issue for the GET command being new.
> > >
> > > It's just a shortcut replacing what we really want.  As long as a
> > > shortcut is available people will keep using exactly that.  So I
> > > fully expect more proposals for such GET commands on the pretext
> > > that one is there so why not another one. Adding more tech debt for
> > > whoever finally gets around to building a config space access gateway=
.
> > >
> > Not really. as suggested, the first addition of new field to the config=
 space in
> 1.4-time frame, should add the cfgvq, and not follow the previous example=
.
> > Because this is being thought through now, it is not at all hard for an=
y new
> things to follow the guideline.
>=20
> Really. Oh great, so there will be 3 ways to provision things!
>
Not sure how you concluded 3 ways...

Provision is via single command via AQ by the owner device.
New config fields via VQ of member device itself, again single way.
Existing config fields access via config space, single way.

> I have not seen this patch yet.  And how long will this take to materiali=
ze? I don't
> believe all TC work must be blocked until this happens, or alternatively =
use ad-
> hock hacks.
It is surely not the right way to ask for the patch when doing the design d=
iscussion and claiming that it is not ready.

>=20
> I get it you want to save on chip memory. So work on a consistent soltion=
 for
> this.
>=20
> All config space accesses should go through DMA.
This is not predictable due to backward compat need.
Hence the ask is all *new* config space access go through DMA.

> Thus no special guidelines should be necessary, and drivers can just keep=
 doing
> virtio_cread like they always did.
>
This can be very easily achieved in sw by knowing extended config space off=
set to use DMA.
=20
> To add to that, it will allow cheaper devices as some existing config spa=
ce will be
> able to move quickly.
This is possible only in those config when device side can know early enoug=
h, through a new feature bit and new registers for DMA, which will pay off =
for larger config space extended region.


I want to summarize my humble input:

1. all new extended config space fields to be accessed only via DMA/VQ by m=
ember device itself.
2. all existing fields to stay in config space without any interface change
3. optionally existing fields can be accessed vid DMA/VQ by member device i=
tself.

4. If above proposal looks reasonable, sure, have the inner hash field of t=
his patch as part of existing config space. I have no problem with it.

5. any new fields proposed in extended config space in 1.4-time frame must =
implement DMA/VQ interface as part of the proposal.

6. And if this needs more discussion, lets spend quality time on it and dif=
fer the release by a week and at least agree on the path forward.
No need to draft the spec normative language for design.



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

