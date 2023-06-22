Return-Path: <virtio-dev-return-13056-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AF75EB64DA
	for <virtio-dev@archiver.kernel.org>; Thu, 22 Jun 2023 17:58:36 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id AF7221CA24B
	for <virtio-dev@archiver.kernel.org>; Thu, 22 Jun 2023 17:58:35 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A32B59866CD
	for <virtio-dev@archiver.kernel.org>; Thu, 22 Jun 2023 17:58:35 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 9542E9865D6; Thu, 22 Jun 2023 17:58:35 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8077F9865D4;
	Thu, 22 Jun 2023 17:58:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UxjA/yjPIncuqR6Kjh1rnnNnuMd8TjERNk6HmMDKrlzrKIJGURSePnAqaGlrITHNGCobVyxwIX1dYQbUV57O53z1JcGw2AMYJ/uNZHQhxtt5VGN1hRPDgl0F1ud4W1wNs4DoQDV0ESV69531zbqUYckbtcVkR/Tq/o92xlmW15NYct2dur1tQAkEkYLkdCRWCOfzQHMNMp6KWHIzHs7pM+ImA8fU9B4O8xTVzY9r3k0ZOgz29sgE1rK8PuQwtz5OZekIaR5KiXjqzvnASVaXV9dcRFiySosN99xtf7iALWhcA7Ro/B26U4ZL6q9wu+Dsh1RJl3t2Bgt4AU/wvFK29Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1YzRGrBOA18RdqRQyyN19+wk2menQpXHjKozs0D7s1c=;
 b=FN85+ETeCTeQ8ZA5+7PLXM5009tZtxenUXup4Zy2zN7DvtjAtso8SR5uTjioyJMbcll+ENfIQ9RafkJPFh7onYkVCwupvPdkMSFJwVC6X7Cim4OU2zo0iw/CpRgqtfRytGqU2K+t3AfPFxSXQpCCvFIxo70/0fM6DzKWDeLhQ3p2QPRh7WviSziWYYuBxaWzq+h8HvIyLmsZjrNr6/E1O+iNSgI/MvCTYnE/43cBUWgw/aYuuIw6r6SgamU8YWL8Y323hhLG1eFRQAp2G5t+rIZRUNhERJ0RMkPQYEtLyxFjthzctS185GWOpZnLWrYc8HrU8MZYz43qDlIHHe3oMw==
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
 AQHZpEdpSlZ4I0eUeUmZIFkjtAkw3q+VZGYAgAASyQCAAC5zgIAAADyAgAAMJYCAAAHeEIAABAeAgAAB1cCAAKHPAIAAY0PggAAXcACAAAvqkIAAJ4CAgAAA4ICAAAPngIAAAI9wgAAGWICAAAbYIA==
Date: Thu, 22 Jun 2023 17:58:29 +0000
Message-ID:
 <PH0PR12MB54812CE792CC801B36AC6E56DC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230621163116-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481C4EA5D0614E1289DFC77DC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230622021932-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54815D6D07A49CE775620088DC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <82e83a90-6491-c20b-d96d-f9e0d15c2641@linux.alibaba.com>
 <PH0PR12MB5481A5055A5F58045437391CDC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230622123203-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548100743287D401B8ED78CFDC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230622125601-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481FFF9F0F1443F75782C26DC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230622131455-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230622131455-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CY8PR12MB7707:EE_
x-ms-office365-filtering-correlation-id: 9df3b101-c028-41b2-6934-08db734a48f9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 n3zoIYLOA59l5aBipZc2JV23hHe2fbWXvR5U/ytL9Mo5lUSglD+o+hxYtZk+fAGMWw5fBSk+/MxrNki/GZOfilpngoRBHCqW7ufeNDYvhlIhhUJGjOfxV3PYBTKPD/epngCwemuq4L6T63WNY4C0FB+vRPdPIYBC55THG+gQfU721qPgHirCire+NuNQVoZV37upfw1PiTBvUXhfUyEv+i6PQGduUGhWQQfgcr1HzpI5aqo2VfDB7HwGDyfFk66i/VjGe1M2YOQUs1JCOJYXal0XJEKuGwjA8JEWElVo+cCxm9nfIVfs7A64W1zf1rREfbUBa5tz4iT71XJyenzHqhSiKRTRoWkN/tzNit7DFhmNCFYcxQdPFYzypSyVmeC6LcggtNFwefPLexlPgr27z2a/ap/CPd1TAxZPwBJAXMTuxlC1uweuu5AEcPs+51Jft9ziRMaH0TiVupN+adqkxlWxym2JjM4n1s05DrQqbZY/uzPO5L7TTSQytYbVrZYkqbr0NXgJFKLbNq5pJ1DPp5K0k5DT6LiT+Ta9NMCn8qiHhR0M0JSnR3nNRzDHnvyAalWPRiGz+BvTQdK24N/GZ5pg6/uSFwsRtvOAPm0uYBTtsArioYroaIo5EzSdzfqN
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(346002)(136003)(396003)(366004)(451199021)(8676002)(6916009)(41300700001)(8936002)(2906002)(66556008)(66476007)(66446008)(478600001)(76116006)(66946007)(64756008)(71200400001)(52536014)(4326008)(316002)(5660300002)(83380400001)(54906003)(7696005)(122000001)(38100700002)(55016003)(33656002)(9686003)(6506007)(186003)(26005)(86362001)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?cnp5SntAYvKfGZK2NvV2vomgeQnfySzLpxD+W4geH13rqywnhHNgYdoBlXBK?=
 =?us-ascii?Q?YDT0hjFZ+yufkxkZvXXgRZHhRey8gXQH1aERw0k3OvUtRPCe4Cly5EGysmnh?=
 =?us-ascii?Q?eE451vCK+wAbvMj1pjiGSMtHCdPwYgyZv5R9nB9G1rUXfGFnA3EzaRm5+lPz?=
 =?us-ascii?Q?TlhnrRs0pToCdlN3DtQpOszqDg7nRkmGfxIoWBgxdC5agQKwa+PiQINONkun?=
 =?us-ascii?Q?5hdBrQVCX+m5B317FjS11ZvwtRUFKoataFGQt8r9bZ93CUyx8+7Lv4sG5qBK?=
 =?us-ascii?Q?AFOmmp+pHMczreIXWBpfoOjzwKmKUvrIxJCp2Vhlkpx/QTYKTtcSpnGjYwBx?=
 =?us-ascii?Q?bq+WqacONoq6A1olyhWhAvll09QAErauDSnPSJoxB6bRT4pgRzeVvUtnO1/D?=
 =?us-ascii?Q?npcGO6xJtWP1LK1y+2oS6BoiUMnhoytToCgRplZ95u4YrGuYz501n54YDdh8?=
 =?us-ascii?Q?HOrhUlywKrBNIdzJcVdoBElZP+LzCMQnbRIJQeRGIVkWvV4HsFze8JUUofxS?=
 =?us-ascii?Q?OD2PRuomUdccC87Jjsn5vipmdD1D0sEEKm4aHhh2PJp92t1ZX99nsdb6hlGj?=
 =?us-ascii?Q?W/Y9DZ0lcyu60Gme8/pyI9DKSmdUweEt1Fqw5GGg49cTEXy2pcGXxz/E0RXr?=
 =?us-ascii?Q?xzRwN6ILN1jjMTmmTLMm8EjAUBKa7tazsqd8KN1Ni/JWfNd8GGgiyxBxeUrV?=
 =?us-ascii?Q?qSmGQMmqq8GVIUJ7WoREvPkDbm7QiRt5LegLB/UMpdGori3aUSsfJFp7VzKP?=
 =?us-ascii?Q?ll/Jfkluc/747lFwxfsTDQynWJb9t7bZNcBnFGH/iNCLr741RLhUI5m2LUaD?=
 =?us-ascii?Q?StDUcTyn+LKrdO5oLxTy8CFwR87hSNFY2LarwFMAh1t1dONi1LG9YJy9fa1l?=
 =?us-ascii?Q?aK0ZIXWrOKAOxE9LGkPuUXT9Refyt/WPBEuDyxL110TIb9+22eDR3MtlHDXT?=
 =?us-ascii?Q?6zgfGdMm7Pg8xGQWtVyNy34XEsC26WfXOOlwGYXhvLskaTel94TtxXN10hkj?=
 =?us-ascii?Q?vOD4AirW/FfWfjQ9vsFyk7OA1NtIUJtQnP8R6lNx3UUeQlCoh8KtX24EuJq9?=
 =?us-ascii?Q?RIvrPkyCOTmoEgDQaIqKhdKYFvUVwagjGYR88D/dQKYqKi7KAP81FcSml9L6?=
 =?us-ascii?Q?KPo1XnPAbbP1Imny/BlN6ft7jmXYrnXOPBzjCZnx/lhkPIuaAl6f/wmwr+ub?=
 =?us-ascii?Q?p8SxFI9tUjuLyW4vrGP5eyLg0gXsrm2XPNLw/h/eyYsmk2ufA8qO4psSOjKl?=
 =?us-ascii?Q?4Vlg2drmhhs1HfNCrnnNeF6b6QoiyglUTe1gUCns+3ZTuEj1n++a3G9hVXZ6?=
 =?us-ascii?Q?oUWqtZrXwP0I3gVggwyVeAmMD6sL/DXdn6piMaZPqfUq5PgrIjBTuNaWzC0x?=
 =?us-ascii?Q?nek8bEOL0Hp8qZRUnDLkwLt4xe3uek8CToJsYOJHegC6G1kaT7V5nEEb/BRS?=
 =?us-ascii?Q?76n744CKD+KgNH97hvpua2evOWfFpHVyZQNnK6Xg8yEcqzVjhINPCpYBzQDH?=
 =?us-ascii?Q?CMdV/eFHR1yp5pWS/n7M3bJkpqrampHih1+dbCTy6q8D//6SN9c440pPOa8f?=
 =?us-ascii?Q?UQxpQ3gXY6urAxP9dkQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9df3b101-c028-41b2-6934-08db734a48f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2023 17:58:29.1689
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pNJvAWEowxl15xRWlpeQPcB4oZBrzH3mQ63qUH4eTxQiCzMxE7TMF7BOg3czV5eIO8yAQGtYUYCCFQ8Dzrtlyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7707
Subject: [virtio-dev] RE: [virtio-comment] Re: [PATCH v18] virtio-net: support inner header
 hash



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Thursday, June 22, 2023 1:28 PM

> > > If VF is assigned then we can't really control what does guest enable=
.
> > >
> > All parameters set over the CVQ needs to be accessible to the migration=
 entity.
> > Including RSS and including this bit.
> > Either by trapping the CVQ or by having AQ command to query member dev
> capabilities.
>=20
> Yes, parameters set needs to be trapped, so they can be replayed.=20
Only for vdpa type of solution.

For passthrough device no need to trap any parameters or capability.=20

> This is a
> capability though. After guest has driven the CVQ for a while submitting =
a
> command to it so we get capability - I don't see how that works.
>=20
Group owner device gets to query the capabilities (and provision) using adm=
in command.
(already part of transport vq proposal).

> > > > > But querying over cvq while VF is assigned clearly *doesn't* work=
.
> > > > >
> > > > That is not the idea at all.
> > > > Querying VF capabilities is the role of the admin command for
> > > > which we built
> > > it.
> > >
> > > This GET is exactly that though.
> > >
> > Not exactly.
> > This GET command is needed for the member driver to know what is
> supported for the device it got.
>=20
> yes. but how will hypervisor get the capability?
>
By issuing admin command on the group owner device.

> > > > > So what is the solution proposed for this?
> > > > >
> > > > 1. Query member device capabilities via admin command
> > >
> > > But that's not 1.3 material.
> > >
> > > > > Yes the current migration is broken in many ways but that's what
> > > > > we have. Let's build something better sure but that is not 1.3 ma=
terial.
> > > >
> > > > True, it is not 1.3 material, hence the proposal was to have the GE=
T
> command.
> > > > Once/if we reach agreement that no new fields to be added to
> > > > config space
> > > starting 1.4 and should be queried using non intercepted cfgvq, it
> > > makes sense to let this go in cfg space.
> > > > Else GET command seems the elegant and right approach.
> > >
> > > I expect no such agreement at all. Instead, I expect that we'll have
> > > an alternative way to access config space. guest virtio core then
> > > needs to learn both ways, and devices can support one or both.
> > >
> > Yeah, we disagree.
> > Because alternative way that you propose is not predictable way to buil=
d the
> device efficiently.
> > It always needs to account for old driver to support.
> > This is clearly sub-optimal as the capabilities grow.
>=20
> So just quickly add the new capability in the spec and then the number of=
 linux
> releases that will have the new feature but not config command or whateve=
r
> that is will be too small for vendors to care.
>=20
I didn't follow this suggestion.

> >
> > > A good implementation of virtio_cread can abstract that easily so we
> > > don't need to change drivers.
> >
> > There is no backward compat issue for the GET command being new.
>=20
> It's just a shortcut replacing what we really want.  As long as a shortcu=
t is
> available people will keep using exactly that.  So I fully expect more pr=
oposals
> for such GET commands on the pretext that one is there so why not another
> one. Adding more tech debt for whoever finally gets around to building a =
config
> space access gateway.
>
Not really. as suggested, the first addition of new field to the config spa=
ce in 1.4-time frame, should add the cfgvq, and not follow the previous exa=
mple.
Because this is being thought through now, it is not at all hard for any ne=
w things to follow the guideline.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

