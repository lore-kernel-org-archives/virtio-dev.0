Return-Path: <virtio-dev-return-13927-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D183E71064
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 12:39:35 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id B527A2AC4B
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 12:39:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 967DA986697
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 12:39:34 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 83CFB986687; Thu, 21 Sep 2023 12:39:34 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 75531986688
	for <virtio-dev@lists.oasis-open.org>; Thu, 21 Sep 2023 12:39:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gBnq1HYeGfFISNBFGZlUAMmg4K8OKW6DnuBFX736MC02mSYKMhsCR34D5JHfEwJXtLq33lw2pnWFwnj+zaw5SfsUIo+hka/AAEQIn0A502Vs8tqzhb5zKJ9UilDSLf/VkURCXVlHt5eyMidmd9xnDU4ngM1R375cp6tMIBCCCsbDaHSNhVNzRpj0EU+QAzeJEcdjdGPTExy8N4ZpF32NPOfdBNaIa8goA3t9wS5xX/O4i7niu6FG+5GqpbNYotrZ55kiU/LAlxTnojWgXahkCgwnxL6JjahorNah9nf/hSAnBi2gXzqWyXrTpSaulycSYtEeSQA26kMNBsYoBdE9dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i3L9VXcPUrmNXwd5nmlbxNVLrWasXZBC+0osltCb5tE=;
 b=gChDPMTC5HdXAndaIRtLy/xMpiB1BXlyCQ6e6kroMZL465UbQY1PDz3HBI5TQYERXy5sk0Gfrr6NB7PeDp6GucDwOIWMnsILzNxbY1TPXYqOwf7p2ccpjnJZLvdvDcP8+4i2ZqAdJXDjy30AUPnNi1bbS0vVvC1/+yGSd7iwRP2PBJUBhEZSzYtnp48GT13zKkNArYGMTYEDZ6qfiq2zg8k+FJsQvvbgBULiB8RJUcaJCXol6MRSwGIFFg6JdNbb1dfygVa40wNVk4ad2UF630FTQPcPB7RIYK1l6wceuXqgWC7IwEx7/gSANJ78PINFPhyXzNSExqbX6iRaKaKZUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "Zhu, Lingshan" <lingshan.zhu@intel.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Jason
 Wang <jasowang@redhat.com>
Thread-Topic: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and
 vq state
Thread-Index:
 AQHZ540fvvI9R/h+mUufqKbomRy5frAegLUwgAFrbQCAABUsgIAAD5cAgAAA+ACAABKeIIAABNaAgAAAXmCAAC3dgIAAl98QgAADDoCAAk+KgIAAS2wAgAAM9QCAAAwSAIAAChWAgAAB0VCAABiEAIAAJySAgAA6DQCAAH/8EIAAIYaAgAAAnQCAAAZZAIAAAKfwgAAT/YCAAADbUIAADTWAgAAEM0CAABzpgIAABtkggAAeZACAAALQgA==
Date: Thu, 21 Sep 2023 12:39:31 +0000
Message-ID:
 <PH0PR12MB5481C9D17AA734BE13CA6A75DCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230921004957-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481E096E0298F29C9EA73B4DCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230921015810-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481821D526E376771E70204DCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230921031129-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54810CEA225EA1BB896AF7C2DCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230921040133-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481F59CBD9B2B615D6F4B0EDCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230921060320-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54819A286CA557DD654E7BA6DCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230921073101-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230921073101-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DS7PR12MB6005:EE_
x-ms-office365-filtering-correlation-id: 61674b29-a251-49a8-a62e-08dbba9fcdb4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 T3oRfPka13KAU1VzwIi9w4Z06g5rsNmaoflmb/4W1CguqbEzmHAaJv2bsclXf186mCFBBSbwwkfshi0XZTk9EbXxWNauWG9aA1gLLLAKzykvgeg8LM+b1aMuDKfKvMs5w6hnNmJctChKhtDzmxCOTKTLFQlqDz5MJihKUhnZnAV2HfFmNdR+YGjj+qwII3Ic9XovTSykHFDsxfSeC2PO2/k22QBldACCbIK+Nq8skxr5F7ODGPog3e26nlMpLkWkL00B2cGu+e4y1UfKG5i5eh8gyT5F3cdyfrq0qurfyfVytp3Wd9oaZdct3mfaHKN/JKFG+w7AYmFUmeYge10AH5tyAybdoMWuK+iri4Zy1SXdUrRtYhfXq4UQOLLpAjeTz/Td6hdpyImvOtMJZ4GyXSJLr4oMaDsBNrmtt0j9+a2W4UlBac1KHAx4IHD0okI/lCAWHB0XefSbd/0P86qA08yPs8NJ+9h9+/Z4jo70kDcVDZvMpGwQxGRGKlsmNG2ALvRMDF4litQwvFMCZ+OtsinprFyTWMwD44QA1b7N2CJyt9Ps62ecFG8yeLLrCkVmGrd5S28vzYJpbHiG/WWNxOn79A6v+c5jJQNxB+Tgm7ZMnb2ltt/93m/ZkACZqPTe
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(136003)(376002)(39860400002)(186009)(1800799009)(451199024)(83380400001)(6916009)(26005)(316002)(54906003)(55016003)(4326008)(8676002)(8936002)(41300700001)(7696005)(55236004)(478600001)(6506007)(71200400001)(122000001)(66476007)(86362001)(38100700002)(33656002)(38070700005)(66446008)(66556008)(66946007)(76116006)(64756008)(9686003)(2906002)(15650500001)(52536014)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?bZaWcthSbSxumwU5srQAk2Zl3DvTnkdaGgowGeFhKjEbGrQYcQ0erbA9oH9S?=
 =?us-ascii?Q?xG6FmOwbTNHUcv1OG2omuLkQNG4v9svdR/XSGa6SOw84Vt+Lsu3ViXmPxmYQ?=
 =?us-ascii?Q?uEBw0UWfwq1rqBR1jKXWoiTECIeM3KNDfy56DkIskX1KOPQADbkceNU5JmlI?=
 =?us-ascii?Q?51P5BoRV3RK97DZYvohHyHQlfHUWXp5WYOfQ0by8n7azNj2YMG+fUdsNj2Wc?=
 =?us-ascii?Q?NYpbiRDs9EYbr0EB+uObs8hoG2xys4CfuwdwB0zlUXvJsV6IZr2R7xv3c5Gr?=
 =?us-ascii?Q?5NYstFAQZSLie90ZgeD8VqlwLIK3yVnlN8yjjRcljWf3dxLz86NWrNbs14jN?=
 =?us-ascii?Q?Km+3F8M3dEnRelKtydefQYdM44aOP49KuKORM+qsfQopNB3vdy6PoY2NqOkK?=
 =?us-ascii?Q?I7XKTykMGN3MVSzxj9kLxiR6mqYQm35Bw31yA/nThBCYfjJ2AL8GIPe/lWKb?=
 =?us-ascii?Q?FaHnw1jjf4BI+dyCALtoJR/R/fnprB5snYxiokXCVoizNvG8+pxkayZQT2yH?=
 =?us-ascii?Q?+Ce2OjrbPT57ycCdsAvfSpjdZ7EWfiys4VM4rKrVFQy64IAGiiREjc9utoda?=
 =?us-ascii?Q?lqZU3s6m87HW9BGIWhD/KI/9CUrW4d1sYR+m2/D1ya6qgLxBeLbiujiOXR41?=
 =?us-ascii?Q?gOaGn1pRoE6RqL6PHaWC4w5+3t3xGpqNUyc7cCXl7Jb2V1lNteS+B8RKwtAH?=
 =?us-ascii?Q?STItbn30dLVItIeHEOI43iMDUdbpPg+/1jIUMD1peVxCnn7PnuzmEm0C8Hvx?=
 =?us-ascii?Q?e13oEvoLojAqKF3jFZvIUbpe7dSafOoXKXusrf1zxmU7moNDZ4pK/gP28hV+?=
 =?us-ascii?Q?y9WVaNeAyhHQ5nd+8M5p8GDcU0d5xqDtvDCpIk/Ad0yNRprAgAzSfcLyLcdr?=
 =?us-ascii?Q?dCuHNFxT4h9OPlcv9Gc+8hYuVNlyW03A7QkEVgiOKv5jd1AchsBH4BLZxwbb?=
 =?us-ascii?Q?tdRa3NsYr/uxJ/soEUtxdVLF7kfoVbXegskbIsaNIqcjwlDpEdpK8wkjVurQ?=
 =?us-ascii?Q?0eQYloCavxB3IJn0X0fqthFaOcJsx8gURBDn9Ggohk4+5qbjiX5M4LPqs90g?=
 =?us-ascii?Q?RgzIouhIyAm2QtPNbA6mgs4VMqwlUYoafmuXlwhlkdO1nWMGF34PcJgAdxdR?=
 =?us-ascii?Q?8UYc5u8g18WWJzBtKn/AJ+s8Yb+w+ZxP8mjb89jpFibtnjqjrS0moWlFzyLI?=
 =?us-ascii?Q?fzPDSnTNpvRwAzv8tFGHZg33Vj5D0vTShgrmxRgHrS6u9+u0vgpJMWCfTZEW?=
 =?us-ascii?Q?h5DYVtEMM2FHr3Cl4+4vwZ3tzYfNrQ55WOfUeupAC4ngY50J2NZp3NH2L+V0?=
 =?us-ascii?Q?1ySeBmqI+L7ec3kNiGbdLEI7LascvRgpkc9u2FIyNvsrJqmzj/sd6Hp8uFvV?=
 =?us-ascii?Q?UH+0n2tB2oGgEYB8Jtj8fyx8IGOrZIL3OB+rIRMNvAD9qZyViTwsV8HUrBzJ?=
 =?us-ascii?Q?+Z0j1KeR0EtDbJaWaJ/UQUw7Q0bdonLpCBbg9KbfX3f0G292FS4s7UqHqR/g?=
 =?us-ascii?Q?m67GpGuY9EayU4nJI+ouVilCi+ccG9vrCGP2F+YNASm8H4tUmKNloRRGAN5U?=
 =?us-ascii?Q?bzyIAcvzdBvvNEPH33E=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61674b29-a251-49a8-a62e-08dbba9fcdb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2023 12:39:31.6358
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HJjxtAlazfJNRoTNv1kiJTMl7r4hGm1xwfdCKVkEyN8EiP709FTxic6gM6g9zJ7wNTjkp8EYkxCbxl9Re4oCjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6005
Subject: RE: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and vq
 state


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Thursday, September 21, 2023 5:53 PM

>=20
> Again the thread has been side-tracked, which linux module does what is n=
ot
> what it was talking about.  By the way I wonder who decided to drop virti=
o
> comment from this and copy virtio-dev. Guys please don't do this and gene=
rally
> just send spec patches to virtio-comment, implementation discussion on vi=
rtio-
> dev.

I have no idea who dropped the virtio-comment.
For sure it is not me, as I am fully aware that virtio-dev is not the one t=
o discuss.

>=20
>=20
> > >
> > > But for example, to migrate cross-vendor you need the pci config
> > > space to look the same and for some devices this might mean that pci
> > > config space will have to be mediated.
> > > Or maybe not. vdpa is a good framework in that it gives us
> > > flexibility, it is not opinionated.
> >
> > Sure, as you list, both has its pros and cons.
> > So both solutions has its space and trade off.
>=20
> You can thinkably write a vfio based driver for PF and VF in userspace, s=
ure. But
> I think this is just making things unnecessarily complex for users who wi=
ll have
> to know which device to use with which driver. I think that e.g. if we ha=
ve two
> ways to submit admin commands, vdpa can just support both of them and tha=
t
> is all.
> When mediation is not needed then vdpa will just get out of the way.
>=20
Well there is enough documentation already exists to indicate users to know=
 when to use what.

> > Hence, if both can converge to same set of commands, =3D> good.
> > When there is different way two stacks operates for those items, we wil=
l have
> spec extensions for both model, right?
>=20
> My intiution says a modest amount of duplication isn't too bad.
> E.g. I can see two ways to submit admin commands as being acceptable.
> Are the SUSPEND bit and vq state as defined by these patches acceptable i=
n
> addition to vq commands as defined by your patches? For sure it seems
> inelegant to say the least.

Right, my patches are not bifurcating the device during the device migratio=
n.
It has generic device migration concept, so be it config space, or shared m=
emory or admin queue or config interrupts or some other dma interface or so=
me other things.
All are covered under device migration that software does not need to bisec=
t.

So may be instead of suspending the VQ, it can be reseting the VQ by using =
existing functionality, and when enabling the VQ, it can start from newly s=
upplied avail index.
This way, it can be elegant too.

These patches do not explain the motivation of why to suspend individual qu=
eues. Do you know?
There is suspend device bit as well, so it is unclear why to have both.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

