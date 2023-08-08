Return-Path: <virtio-dev-return-13493-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF8E6C001B0
	for <virtio-dev@archiver.kernel.org>; Tue,  8 Aug 2023 04:18:49 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 46860C6237
	for <virtio-dev@archiver.kernel.org>; Tue,  8 Aug 2023 04:18:49 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3A91F9864A1
	for <virtio-dev@archiver.kernel.org>; Tue,  8 Aug 2023 04:18:49 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 2D43C983EB3; Tue,  8 Aug 2023 04:18:49 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 19F58986460;
	Tue,  8 Aug 2023 04:18:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LmHNFhBD8FTudwWtBlpGSXGwlnUknsCWhVTQKtXh4anEgjmohae63BKHamdmHInoKRptdvFkWgOaSlTiAnr25h6TUOVAAXz1V1wr74iNPohFbYB+T8tHVLWKPwqYDOGkQ2QTtt5MbF0BSkadd4Ty5l0oWwRQx29SLFaxV6FWPFUmWoOcrx6sO8A3U8uMKfFQ3cPzUhngN7VE+P0S4CsuQam1Ihl6wXKZk19L+bpWzyLnQVJacyWiqCMvNiKU15A49RhNvfHpH8pKL51LGkbLsR7wAnesBcKnexaTh+BHzT9Q/9ume001K4IHX91fla5sQYR45V8gPaMpZzV5eohvCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PAT85jjjDSTjGwgSIioqX7L2d0D2mWsXAXvXkkZi7Gs=;
 b=aLfXGXAowN+75Of8hpYa4W4Zy720SBM//OZBDz17iMx74JITeLnYKz5Js89cBvxiUMPV/DytUpmyPXJMrdJOeBboU1l796dmJTIjMPC3yOhndWsIGVSowI60+Y60NYIeEA7XYmrV1/fTMNP0QogZLnIJwxAULNr+1CSUrVdwJ17dPdPp+HnORGqH90ndLezw2itOEOFN6SPaN182qxKJ7VIikUNXMl0KlN9Ub61mXdYq92+j+NCdgEZ/Kj4kONC0VSg/9Synra+Ryc1u4pIOZs4UYBHiwWkZAOsVLVIIwOuR0tQYEo2K6TOBBC5w1bfglDlwgJeJFrOOGgtqQMM37A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
From: Satananda Burla <sburla@marvell.com>
To: Parav Pandit <parav@nvidia.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
        "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Thread-Topic: RE: RE: RE: RE: RE: [virtio-comment] RE: RE: RE: RE: [RFC]
 virtio-net: support access and control the member devices
Thread-Index: AQHZya5k8+OCMm21XEm429uOdkk5Uq/fyivw
Date: Tue, 8 Aug 2023 04:18:39 +0000
Message-ID: 
 <SJ0PR18MB4477B97494BEA4FEFDF73280C30DA@SJ0PR18MB4477.namprd18.prod.outlook.com>
References: <20230803083150.46745-1-xuanzhuo@linux.alibaba.com>
 <20230803054333-mutt-send-email-mst@kernel.org>
 <1691059929.235804-1-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481B5B3C5366CCACB221083DC08A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691060652.3764465-2-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB548191AE225B08BACFC0C350DC08A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691061508.9066079-5-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481CB7BE555F4672394A6ECDC08A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691062204.2378864-7-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481E104793F9E68E1DC95CADC08A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691062877.0013635-8-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481C3CE21016385BF7D6FF0DC08A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691129914.3255427-1-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481F521F146049E5E483B7DDC09A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691132049.7182267-2-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481BE16AC810CD3A6D64832DC09A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691135097.4908528-3-xuanzhuo@linux.alibaba.com>
 <20230804053958-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548152A5677F0508A62587AFDC09A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691388171.3192031-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEtKcmvBqSJac4aNQMtvE+fYnOeLxeeXz1vtP5d2PM69bQ@mail.gmail.com>
 <1691462188.324996-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEszg7nUNH2bW+EQLVxnPvUzT66D8=V8x7JKw+DL=RzsiQ@mail.gmail.com>
 <PH0PR12MB5481D3BDFB943D7856D846A9DC0DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691467247.671468-4-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB54813D793F8BAA9D6614FA78DC0DA@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: 
 <PH0PR12MB54813D793F8BAA9D6614FA78DC0DA@PH0PR12MB5481.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR18MB4477:EE_|DM8PR18MB4504:EE_
x-ms-office365-filtering-correlation-id: 3e6acd10-da9d-41b4-284b-08db97c68acd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 xbRVQK7didR0WhA0fLLNd0cEQMH7kROuRgUYSUpO0tprHFGdAy8bWHcxq7VCOdMR4QX8L3w4f0T0oQmdwCxyLMmhs0FGXl31qkhPzH4Gp/lH4iQ53GJNMjD0hrNPwQJZbitbAeKtmohogEYXT37PA8gluS4ajiqljJXW6Eq30mWVWGFuKyZv8ZJLzT/ePrmT+N58WDiBEIV3Z5wJ5AFdmPoqKcxW5Ey7PmD8f8iBk83Grylwl1vYdboOwEwC7zt4Opc5ccBMZALI+MQ8SqKSiu1D0ItYlav1WnjVonQeAvShVAI0nu8ZGCQS0L+C0WtjYUhtOhMjBbFf1uFTZDADrOgpZD7Yel/zv67GV4ighDMV8REb7+h3CUe4r4yS3/SnpXfkZS/z79b/KDEQx/gulyKfTiH73Eb7kwB7CXNvM7dz/CVCrF60CRc5GTX0qLXFgU4hV2KfR20+GWyz5j0o/G7cxSK+bbTyViU6Lx5G2ArPuozli+aex6WAJXuEkevbGkdaoQesMHUJ0ysiOu3Nd737Pkr8JTWwihqrbZzkanzx0tGYN7b2DQzfou1xiC/Lxl3CnwOtfchF72DnG50+fSTAUpEdV08VHvc6TfK9jlVjM71aHx8oYBVy4LEiZGLYgNCQODAEwbfsnRY+wOKdvY3n1sDdLsdiSwhP2hoWXPA/docOmLqak8R09ljrBELQ
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR18MB4477.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(366004)(136003)(376002)(451199021)(90021799007)(186006)(1800799003)(90011799007)(2906002)(55016003)(83380400001)(66899021)(41300700001)(52536014)(5660300002)(8676002)(8936002)(38070700005)(33656002)(86362001)(54906003)(110136005)(478600001)(122000001)(38100700002)(9686003)(7696005)(26005)(53546011)(71200400001)(6506007)(66476007)(66946007)(66556008)(4326008)(66446008)(64756008)(76116006)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?DqmOy1MOo1JAUymfAlDxjzNBCAD7tQO9Mqdxfe/4zX9xSlNL+QiG7RpJG6xy?=
 =?us-ascii?Q?fmLMVjwRGG3z27zvSUzz6nXhdaMr4NktYpP/glzdhHwgZ1yKLCw5EjX1McE2?=
 =?us-ascii?Q?XwZTYSJbsXwKlA0bPiFFiGSbE6ekgFFzAJZafXXHx1MsKdSiXEhQvgXSOUGX?=
 =?us-ascii?Q?lfF1RGyTJibGgwpxHqmQ8q6gAl2fp3PJkkCnqAKi5+0/zYSqVEWUSA8h8KTV?=
 =?us-ascii?Q?IZRX4+hjJcKEk8wDkmVaZxFpwGn2yI9a4Uu0eo6l/LJNE390sWKtBDN7TbZg?=
 =?us-ascii?Q?UXW3b9kSPsZP3hjCS15AA9lCEmxHN5Ac6kYXn9S3StGBq2krz/ElY9asppN6?=
 =?us-ascii?Q?ySG+WXwCENnuDQYW+Z5qwtJ0BlxTgVlt4wczlwyHOnqNkmC1fy3owF2S6W29?=
 =?us-ascii?Q?zVwsyn1DIIUXTLCSWMX+CJOxMhJaWHkFy3TDixCUkkBWyI9XA3Ff8K3Sy00s?=
 =?us-ascii?Q?BFhFGqjRRplaXnlxSss31+/pJIe148oQv69e9HTZ9ZoMCz6YyaTPv4JN6G3M?=
 =?us-ascii?Q?gX+KuTIpBwwGBjDrosifArZEifRUNKjKNLd+fGGjg5soDErC66BW0l3zqzRZ?=
 =?us-ascii?Q?ZcW0gEzut9QNZ9nsoWR+tobGgCau9IPpB9xxXwOZ/LJbkCHEQcybyLFBZl6P?=
 =?us-ascii?Q?OtPbmtLG/e71yxl2wDfTLhisTO1RP2s+cBW0N0ckeaXLoLjX7rbvsJ2B9aFB?=
 =?us-ascii?Q?MTPX8bleXxxL7JzwaMDbP6uKTmoA2ffRJWXNZ651YAH1LPdHLTLMJV6D8oYg?=
 =?us-ascii?Q?7wV5h3Ynz6gmthk3Yd0aFqzhM5wpIuuxatx4BEXNQqwsnQEstmRVHy5Mbagk?=
 =?us-ascii?Q?c92kQglBS6M4rs2DtziZQnKOWEDZ6NlPmAfvxW+7XO5TaHkkua997AIvG7GF?=
 =?us-ascii?Q?V2AoBVpaFoxEj9mN7yaRMdy3svKWorqn4zgUdxolBkh/+fCzFb/+eHnbL1+p?=
 =?us-ascii?Q?0wQGWqSW9NSPkDHsYIZRWr8gg1B2nlS54bRHpfVfQUPAahCMDkLZrPFwmS84?=
 =?us-ascii?Q?AxVnretefVsYnMZhFm9b0yVOss1GUZQ8irLjuSNgJbe40WmG7cAnA+x3GbKQ?=
 =?us-ascii?Q?BLqTiBqmn23VVcHAoxXuXXq+ynedsjPhdn3rF+JjpyoBivWCQkfkGeADVlEk?=
 =?us-ascii?Q?ygVPjxYKkwY3bR6CwxlS6FCLeeOEMNn1wbDzbyr28ZqEdmytheVdQPWpGl1H?=
 =?us-ascii?Q?fzwjbe7xGsVQswSbVSRQ/N4tDgCLnRIKXGOfu8Ie4WwlNqfox+bGhx2miOdH?=
 =?us-ascii?Q?aLiLkNt9VzNPiq7LX8dVt0E/1CDm3FsBIA6PRRoO5nHMv8BQp34J+Lbl29Fv?=
 =?us-ascii?Q?dP4Csct4T4s6pT6v1RMz/Ub98cc8DheeIRh75puJoaX4qeZvxcJ9+oQ7XETE?=
 =?us-ascii?Q?Dz/8Ysdtp6leRqkaaWkBoXo+OdcuWd8+TRdSpaEQpFrW3DbVspUrOLJDotKD?=
 =?us-ascii?Q?gxw1WzAUIP+n7WAPo5GPyzFZ350ijyeA/+ydObGJCknT8p2T/J/khpYJymaD?=
 =?us-ascii?Q?pMUIIdHITiEEMURhond3UlyuEqnUNqQWToIjI6kOCibafe/pHczAPqyHuBWS?=
 =?us-ascii?Q?lh25Np84202PUKICaLSI3l6HvF3iwlgPb6x8LFzE?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR18MB4477.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e6acd10-da9d-41b4-284b-08db97c68acd
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2023 04:18:39.0492
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mDVObWULeyydrExeaQkjqUYJHUTpqAUS6Gk8QYpqnGecWn5lBsecaXAuvIsskU6ly9IDJ2W6lTeOW2CpunRYzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR18MB4504
X-Proofpoint-GUID: HcUO3KzitMhAb5KUN6Fp0YhdrQVwrV76
X-Proofpoint-ORIG-GUID: HcUO3KzitMhAb5KUN6Fp0YhdrQVwrV76
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-08_01,2023-08-03_01,2023-05-22_02
Subject: [virtio-dev] RE: RE: RE: RE: RE: RE: [virtio-comment] RE: RE: RE: RE: [RFC]
 virtio-net: support access and control the member devices



> -----Original Message-----
> From: virtio-dev@lists.oasis-open.org <virtio-dev@lists.oasis-open.org>
> On Behalf Of Parav Pandit
> Sent: Monday, August 7, 2023 9:11 PM
> To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Cc: virtio-dev@lists.oasis-open.org; virtio-comment@lists.oasis-
> open.org; Michael S. Tsirkin <mst@redhat.com>; Jason Wang
> <jasowang@redhat.com>
> Subject: [EXT] [virtio-dev] RE: RE: RE: RE: RE: RE: [virtio-comment] RE:
> RE: RE: RE: [RFC] virtio-net: support access and control the member
> devices
>=20
> External Email
>=20
> ----------------------------------------------------------------------
>=20
>=20
> > From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > Sent: Tuesday, August 8, 2023 9:31 AM
> >
> > On Tue, 8 Aug 2023 03:16:44 +0000, Parav Pandit <parav@nvidia.com>
> wrote:
> > >
> > >
> > > > From: Jason Wang <jasowang@redhat.com>
> > > > Sent: Tuesday, August 8, 2023 8:39 AM
> > >
> > > >
> > > > Yes, but even for TX, would it be better to filter the IP as early
> > > > as possible in the TX path other than depend on the switch to do
> that?
> > >
> > > The idea is to introduce filters on the new virtio switch object for
> tx and rx
> > both.
> >
> > Filters for tx?
> >
> Yes. the regular switchdev model that exists in Linux kernel for several
> years now.
This is what representors would be used for. The Tx of representee is the
RX of representor. Hence one can install RX L4/L3/L2 filters of choice
on representor using tc flower, offload to device if need be,=20
these would then be applied on the tx path of representee. Similarly the
owner device can also have rx filters installed to direct traffic to the
the representee.
> And similar in another hypervisor.
>=20
> > Are there other use cases?
> >
>=20
> >
> > > A virtio switch object can be part of a existing virtio device or a
> new virtio
> > device type in itself.
> > >
> > > Xuan,
> > > As we discussed, since the owner device packets also needs to be
> > > filtered, potentially outside of the owner device itself,
> > >
> > > Do you see the need to introduce virtio switch object now, or can it
> wait?
> >
> > For virtio switch, I am ok.
> >
> I didn't follow your answer "I am ok".
> Do you see the need now or can it wait?
>=20
> > But for me, I just have this requirement that needs the switch.
>=20
> > So if we do this in the device, then that is not need for me.
> >
> Device meaning outside of the virtio domain, for example dpu or
> something else, yes?
>=20
> > Now, you think we should introduce the rx/tx filter to the virtio
> switch.
> >
> I am asking to _not_ introduce currently.
>=20
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

