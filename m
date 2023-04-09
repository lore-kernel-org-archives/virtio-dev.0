Return-Path: <virtio-dev-return-12069-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07979C7619A
	for <virtio-dev@archiver.kernel.org>; Sun,  9 Apr 2023 03:15:07 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 166B52AF80
	for <virtio-dev@archiver.kernel.org>; Sun,  9 Apr 2023 03:15:07 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DFC5998413E
	for <virtio-dev@archiver.kernel.org>; Sun,  9 Apr 2023 03:15:06 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id C83F7983FEB; Sun,  9 Apr 2023 03:15:06 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id ABBA3984037;
	Sun,  9 Apr 2023 03:15:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iEx0xv42vtQ2KSij1HU83tmEVkfGcb97vdBOFu+y3TAHZCemX69sgyuXmsGzgAxg+BBst4lzEYYL62Elmlh8rtPyxTjuwH8AyBNke0x5XTjEfcToddH0XV0mrjOruyttnSwV8tnofCqGeY7SN7wMKjTBkdMbNXzpOf/YaBXIFHycq8PcoV5fvsnsOEiLEZ4T0KcQITU/5chuYfDPJ7dpPjzzyDiWHnG1x90G8moNHxshn3Ij1NtF4Q2dfMHOhuOM+0FEMNp55OEAMRYPZy0Fhy6nyBWSFin6Duf6UBaYTQkz5KCxs24Q59hs6LygLijA64DEv2aP5sv0EIHFm1M0Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t3vO5Tk0dkzxDtDi1Zf8JnNdqGPBFn7sPxH64zEm/bA=;
 b=FIeYXax5Az1G8DqoFXSqh6tiPgX7Y9rV1fe8tNTjf5t28wDRq08d/TxXWT08Plm/NwKn1SqCD251kKmRsZSelhDHC+JShLmm2Qx+7jGbA9/OATjHb0i5OKtQDUPi0WIgYsQrC5rAoBh73Npco2dd5ntXV49QV0BQNiZR7ai0P+L3JWuPZxHczQEXGlsGH1UqD8ezeX3hbWnLeLJO5CEuFzzgAhusvFWmTJrukmLSaRYTPeKYKIdNUS89+gw/TT3GExerzOS7I0qryupZT3FNW7iumqSpqz0B8shtVRncYF6lcekpk/hy5+U1nyw96OXpI52BV9UaqCBg9AVj6AyIcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>, Satananda Burla <sburla@marvell.com>
Thread-Topic: [virtio-comment] Re: [PATCH 07/11] transport-pci: Introduce
 transitional MMR device id
Thread-Index:
 AQHZY1tHbf+nicr9uUaxzLNq1cXcgq8ax2UAgACRZQCABHJagIAALYOwgAASQQCAAkyugA==
Date: Sun, 9 Apr 2023 03:15:01 +0000
Message-ID:
 <PH0PR12MB5481097A6BE0F55E6F626935DC949@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230330225834.506969-1-parav@nvidia.com>
 <20230330225834.506969-8-parav@nvidia.com>
 <20230404032700-mutt-send-email-mst@kernel.org>
 <94b217ee-29d9-42da-f2b8-28ced7e64371@nvidia.com>
 <20230407074605-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481BF6222A169B898B6A5BEDC969@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230407113737-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230407113737-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|PH7PR12MB5950:EE_
x-ms-office365-filtering-correlation-id: 690bd8cb-dc6e-47dd-721d-08db38a89b85
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 LLLB1rMrG34UfQFbKiMJQ5V5mGrU0Yol6LKgsHzbv5Qv971kGkazgOFI2nAuliAw+BxX58EsUj88wfdn0wRECqIbhtBk8WR/K3qgie6tiSWpDMuRUEIVMSH6HjI49ju7eyLfl74FKS8HFXj1QmAGzlsqAjSlQ3W8xgDchp/AFQECCPCzJyocOEQCx2GdGjTfth5uFlQIgQyuap22TZ5wjP9OLYE4xmkPGzt+z1JtVQJFXp1MME46U9a4/envbCDTN97uSYYZ16B94HwVsPOh2xJpp/ACe0Nm0T+by/7QheAtue/ghwT+glrWNXWndJH3z/AL1/lNKxGIfqUjFOSIt6tIOEUZkzxFY29D/hkQsQMrcOBedAamfBzGP9/U2l7CTc/iXWogKeGPSFSGd0wBhBBq5TSvYg5tpUUnXdc6Nu0SIqnPkL8oh6XtCBxSYVE3tUoBzyF5tc9WLpxgdf45k1fkrWOJ00ik09we6eTiJx1/d73Mkx6E5l36pOZuvsxaoQzxrVmcxvMGF6XMQzIz9rCSM1wDvfIT9WakbZ1e79GwAvcGozT0+OVkPJ6hRjEHlETw1x1ICWGIARra6S2S4jHKzswwL6RY7ITI41EV0Ci4FVeBLMFJPyDomKFULJTA
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(366004)(39860400002)(346002)(451199021)(86362001)(38070700005)(9686003)(6506007)(26005)(83380400001)(186003)(122000001)(2906002)(5660300002)(33656002)(52536014)(7696005)(38100700002)(66899021)(8676002)(8936002)(478600001)(71200400001)(54906003)(41300700001)(316002)(64756008)(66946007)(76116006)(55016003)(66476007)(66446008)(6916009)(4326008)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?zEDvc+SpTsyCk/JG96iOx0+cYN1nv9XMoBiYi7Bsz+eswMgGHWpiKQV1b57N?=
 =?us-ascii?Q?T+Yt6SuZ8E0wWcPcEgPWgIEBEoOl6LwimjDtcN18wsxa18Gk7t0N6ri2L8AG?=
 =?us-ascii?Q?X4F/IjBLL91sCvFxfdrL5DQ/hBFkbd1SuKaVsgaQngyskoRRH3b95phOskkl?=
 =?us-ascii?Q?rbC3CP3vA40EI18o8CHc2IfUQPjgyqGpMTdNkRqle2BJf8KeqET6ikGkayjN?=
 =?us-ascii?Q?L3RZMSC64OwjkE/dzTe/KFgXu/ksWcbmss8F8eixz0TqVIj2OGew94rZzH96?=
 =?us-ascii?Q?1A7wU7zYWBUv6cZ+Qc4ttGYrdJT2697cmwP8wwb+VU1WlL157piM5C5m6KQw?=
 =?us-ascii?Q?cDwjhRipFL+2lLtOEMZoYG6aPtLyb3ij46KuuJLOSzyBqJ+5UC01pYlq1CRZ?=
 =?us-ascii?Q?H512Dt6jzCb1dKU73yb1yMpKs/mY5Dx6ZiplPvlSUlUvaA4YjJ7VeVl8uW00?=
 =?us-ascii?Q?1QTwzuDjQexBL8zaJ6Bh/okh7ENq4huIRU1wVGzBI5i2IOQIHXDDfXHo/U5N?=
 =?us-ascii?Q?UKBIFcHgfHZCzFNR4VZCv/W0gOguGwY/UjllTDAfg4zoIY9HSCv+sVJLR9kx?=
 =?us-ascii?Q?fDVL4cNhgI5fxppsosT3XSt/dYxZyt7D5CNWVNCJVPrrXk55ZR6VNx6SEpjW?=
 =?us-ascii?Q?h5AlEGoUGxfOOFcsYXxiWtZDVfBLqRvWpllMWylHDDL09pKyDsTjjM9XMZUI?=
 =?us-ascii?Q?hBSSFC+M0WdNcP+tJQQx4vNEILkPn2JbqSBmNAt23gMawZcFrzOD1dGVa5Dn?=
 =?us-ascii?Q?3TptW9YX4madQUrhpoPCzUrYOuXrjOIyUmsGzc22jpDmZkoLDh29u0MSpvpD?=
 =?us-ascii?Q?P/mPlDGq/jQGfue+EOe7ZLvv9dEaFFbNK47JverT1J5WEs9Q9nTksXXee268?=
 =?us-ascii?Q?BuiQZoYfS3GbvzhCeKJJYkmioDLFQE28F/g/9TZ387RR0esnmrrVKWwhduPv?=
 =?us-ascii?Q?7sxUqXyoyU92zj7lj+aR5ssdzN3tNG/v0uzHEfP/64LvdVercn6ImU5IAprN?=
 =?us-ascii?Q?F1y6V0isMOcp+X7S/FhAWe71sxF8PdhiAZutR9HCsFuMydDuSYG9A0JeKMlR?=
 =?us-ascii?Q?6IHj0A4k921pyqEbEgdlRTTyiZLopisyJEdhvWUtDs2mGKaJyMS88fVzlVDv?=
 =?us-ascii?Q?/nnLDxWDvs3BXb/r+cClpNnfxL1UKIVXVF7+Yw83HOK4XMSpha2+DGvVd+Zd?=
 =?us-ascii?Q?5YTY2stDQX4AXyXaB7W23M7r78LCLRV1/UIsV2rIoOwKzQfo1E/aoDC39eFx?=
 =?us-ascii?Q?RxgD8fdE4JdkiZMduO/J73JWm3VhUq31Dl0H+JWxRmQNUi3zuhyk99boB8qb?=
 =?us-ascii?Q?CoSKAK0Wel9KeP0Ol9TqXypUMxTemDu21T/A2HWboy0jBBhdAeiGDIzODo5j?=
 =?us-ascii?Q?bV0KtASsqdc2tbsHIE3hcn5QC0VqLRVwf8PT3uOoLac8CszC9EZ0sNkQFG9J?=
 =?us-ascii?Q?/RSB7JFx0T+7ZGdVNJleAWD4w24qLrWrkpyxAks0fPK3JFp4NTumsBZb6P2/?=
 =?us-ascii?Q?Cmu6QPLOYXur/KZ5qLD3+U45vyA+tJ4xbKs75upKVX/vqaxCtOfkDF6qm06l?=
 =?us-ascii?Q?Vmk5zF8vr5RFlV18Kqc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 690bd8cb-dc6e-47dd-721d-08db38a89b85
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2023 03:15:01.7543
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H5T+vPsKYB6MKRM4wAM4uVy9HfyMks5F8H/ko2XzNhWeWaXYUat8TOafRwJmupppCWEZwYHX0H799qyjgL6sNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5950
Subject: [virtio-dev] RE: [virtio-comment] Re: [PATCH 07/11] transport-pci: Introduce
 transitional MMR device id


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Friday, April 7, 2023 11:51 AM

> > 1. A non-transitional device will expose a capability (not a feature bi=
t, but a
> capability at transport level).
>=20
> Note that we can allow this capability in transitional devices too.
> This is useful since IO bar might not be enabled even if present.
>
This capability exposure makes a device transitional in some sense.
=20
> > This capability indicates that, it supports legacy interface.
> > Lets name it legacy_if_emulation for sake of this discussion.
> > It is a two-way pci capability.
> > Device reports it.
> > And driver enables it. (Why two way and why driver needs to enable it,
> described later in point #d below).
> >
> > Hence, such non transitional device does not need to comply to below li=
sted
> requirements #a and #b.
> >
> > a. A driver MUST accept VIRTIO_F_VERSION_1 if it is offered.
> > (Because hypervisor driver is a passthrough driver; and legacy driver w=
ill not
> accept this feature bit).
>=20
> This is not a device requirement at all.
>=20
Those this is written as driver requirement; a device expects this feature =
bit to be negotiated.
What should device implementor do? It should allow driver to not negotiate =
bit, right?

Which means, below line to be change:

from:
device MAY fail to operate further if VIRTIO_F_VERSION_1 is not accepted.

to:
Non transitional device that does not have legacy interface capability MAY =
fail to operate further if V_1 is not accepted.
Non transitional device that has legacy interface capability SHOULD operate=
 further even if V_1 is not accepted.

> > b. device MAY fail to operate further if VIRTIO_F_VERSION_1 is not acce=
pted.
>=20
> This is optional not a requirement.
>=20
Please see above wording, if its acceptable.

> > c. A non-transitional device with above legacy_if_supported
> > capability, will allow device reset sequence, described in [1] Driver
> > Requirements: Device Initialization (3.1.1) [2] Legacy Interface:
> > Device Initialization (3.1.2)
> >
> > > > device reset sequence.
> > >
> > > what is this one?
> >
> > I listed above in #c.
> > And
> >
> > d. When legacy_if_emulation capability is offered and hypervisor driver
> enabled it, when driver perform device reset, driver will not wait for de=
vice
> reset to go zero.
> > When legacy_if_emulation capability is not enabled by (hypervisor or ot=
her
> say existing) driver, driver will wait for device reset to turn 0. (Follo=
wing the
> driver requirement 2.4.2).
>=20
> It might not be a bad idea to enable it, but I observe that it is possibl=
e for
> hypervisor to expose a standard transitional device on top of this MMR
> capability. Thus it will not be known whether guest driver accesses legac=
y or
> modern BAR until guest runs.
> I propose, instead, that device exposes same registers at two addresses a=
nd
> executes reset correctly depending on which address it was accessed throu=
gh.
> WDYT?
Yep, this the exact proposal here.
Legacy registers exposes via AQ (aka TVQ) or MMR location, behaves like leg=
acy.
And regular registers at their location as-is.

With that feature bit negotiation is the only thing to relax like worded ab=
ove.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

