Return-Path: <virtio-dev-return-13491-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2ABEC04A94
	for <virtio-dev@archiver.kernel.org>; Tue,  8 Aug 2023 04:11:16 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 2D0273E30C
	for <virtio-dev@archiver.kernel.org>; Tue,  8 Aug 2023 04:11:16 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1FB9698658D
	for <virtio-dev@archiver.kernel.org>; Tue,  8 Aug 2023 04:11:16 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 1308E986461; Tue,  8 Aug 2023 04:11:16 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F2BB5986460;
	Tue,  8 Aug 2023 04:11:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lkeoLMRPVnQF4YHn32RXeCsi+NcKEpBnLord4PorfKw/z9s3AL047il1FJ5PmnoAPUIjFI5392HgyLCW9iGukYtb+sbIWZmUy1dtTBe39DBTVMPkNuurlsDCP1mYzK/8DljWmt/qojAMtsf9amX4Bu9BPX13DedEt4Ib4eDwI74Rfw54SB//eenVbPkpk85rjjTGzP+SvNxRJ27NYsTvlvrQAof6U6MlpFyBFzsVmOISO1DLi+q+cLeX2n233lCYdYTgXm3/HcUW5Q5Ix/564qK49BYTRChB0iLD4/+H5M9hDqfroul7ik79wTazE6fkYazWphN+/Ea02Yp+HWq4aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FcnqqbjOKOlgUEb687e1yE1VRPmeZia0ZyZ7yJkn54U=;
 b=cGaZQoRF7tr4n93QHM7w7iI1WrKV/Ej42Zq10Di+X/fUfzPLmVQGLhb9vGhHSepZjukoaWM5NFdHiyagqxQn4agUiCEaYCF4OcfC5dm/YdVxraKz/lbHRNHWsmweUAxNsN4RtQ/2nYy1fOeUdECaeMH6R+TaHOk0ilm0ZSOngtxkB9okmxTT6qygJ1wW8yezV6pCDt3N9yIT1KLoEg7iPLWpy2CjVy4o3Y3IcRSn4fNetBQC/dcCNaxwyFx74ftjzMODdRK9B1gi5O+DjpzNMf9Dkolsv3wvmfbjHTRlSCKIQX7LjfcNNrJmoLeiDQO9o0L6+0ComfEnuFDDRH2gdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Thread-Topic: RE: RE: RE: RE: RE: [virtio-comment] RE: RE: RE: RE: [RFC]
 virtio-net: support access and control the member devices
Thread-Index:
 AQHZxeT2Q5D2+syVdECqHrje6hzlHq/YUmCAgAAS74CAAAGPkIAAAc8AgAACoHCAAAFdAIAAAN7QgAACXwCAAAH+cIAAASWAgAAY2vCAAR9QAIAAAoAAgAAHcYCAAAfd0IAABlWAgAAvCwCAACGFIIAESeeAgAFTlICAAAUXAIAACRuAgAABk3CAAAzhgIAAAgIg
Date: Tue, 8 Aug 2023 04:11:03 +0000
Message-ID:
 <PH0PR12MB54813D793F8BAA9D6614FA78DC0DA@PH0PR12MB5481.namprd12.prod.outlook.com>
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
In-Reply-To: <1691467247.671468-4-xuanzhuo@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|MW3PR12MB4473:EE_
x-ms-office365-filtering-correlation-id: a2652c66-8519-4b90-0b27-08db97c57b85
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Ib9fiGyitKe1XN9oHGR5NwUIBabXBtvoeKxYjQzkdmESNn/4/yJUlIkSmZIQSQ63ZaPBiUNKHt6ZgAWPl8izcImsvF8yuXfpnGnlEHXF6QuZToz5BzynGOZVuKMKKsFe59RtMQZ3ttM0OgcQ6xrffL58u4DHWUk6AhYpbdKJrzfBwRkXj5YXj7mxYZRO4bCMjteAe84j8flW//N1sfb1ieWUdTpdOudRNEky4ZUn622+8Kdoka//EJhTnffsz6TKAZdre97JrQB6TYuAciOoRAzDx7FD86kYX8Pnct4cbqkaynRluOrVZxrjmqAJp5a3iscpEXpIoTgRWQTV5VHIsdB1od1Pv3e6Yl5uCOG8sdgop2Ab2WtB2ERVwN6pd2O9EY0gkDp6lYy1ipDZMaaB5adZ9UF8/Zt7OGzaonw2VKdtpBSu2qdgW4OMkSOX4vfUn6GTU/FsRbltgbPLv/1jtH30FnxylN1Z/55wfyXbfaxs6aM/U+h5UfK2HeIjfrd65txRr5SRrH1akR4I6fIzEp8UuhQe8ABkcuLsv0fqG58dalJcU5G5QrIRnn0uoJoAEosdD4iSbaUR3uWTV6lQt4j/ynD5hISQaPuX0JApOWS26X1Syq/m8PpS2/hgXTAEkWd84qjWDVVWkXVsa9wAHNDwhW56SfGZnjSv29J16FcF9JeSD8Yew4UK1CgdARWa
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(366004)(136003)(39860400002)(451199021)(90021799007)(1800799003)(186006)(90011799007)(2906002)(55016003)(41300700001)(52536014)(5660300002)(8936002)(8676002)(38070700005)(33656002)(86362001)(478600001)(122000001)(71200400001)(66446008)(54906003)(38100700002)(26005)(6506007)(9686003)(7696005)(66556008)(4326008)(66946007)(66476007)(6916009)(64756008)(76116006)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?5DXp8XwROOBf7o00Ib9lJ4siVaBGlmXiIsE9El7hSjOpj8ehVKnGVvXQjgSC?=
 =?us-ascii?Q?QTxCVaQQYM/qLMLt9wJ6BREf/JCaFokRhOwrCZ/LVvZ65UX7cS+KT7fFw8GW?=
 =?us-ascii?Q?DtURR5sLxw+S6AemIwLkt0GBc11341W1oeZkj5vOqoDmoBOdYCEDZlY+Fahs?=
 =?us-ascii?Q?spik9lamusLkf+4DU2E7toUZXCbaPmS1haxE9WQGmBw585b9ffw8gD4prNZz?=
 =?us-ascii?Q?A7EO+nKuaGR/xiV9kVadTHoxlmFDpxNDrD5i+gbYMOaAsxyZ3bZAq6+fe3Ab?=
 =?us-ascii?Q?2tv1y2JULCTT2TJYEUECcHpT1bZULzKwT3WF/9GroPKJYKD0LItzSXJmZROP?=
 =?us-ascii?Q?y0dqcDk69ACNZCeRuF/051+R6c2KLkl+Xph1uFcc/HlOM6kedrmLd5ewzp1K?=
 =?us-ascii?Q?MM25sl3vtf2iT3wyJXT0chfhkbPLGP6pjxROKHGmEOC1p07be6fU/ZzU+xMR?=
 =?us-ascii?Q?tZamrxNESFY5UVaefVc2XgJgCpHy+0w/CNyXXlfOZTCUKyB57SJMpspbaCur?=
 =?us-ascii?Q?cJvbtVgTgfAUQDDO72TV1dxNzbPVwaamPuOl2BS+iF29/CCb3Mrenxuz0y/6?=
 =?us-ascii?Q?NsEC1ET5pC3/ozXI6tWQdlcnR8tgTDGZetphil5R38JJMguJwbp9pCZxUUpj?=
 =?us-ascii?Q?Da4l0DqZBdCliZH2RuQqy2Tco+1P4YOGCSkI75gCyO8eXTKWmWxHqbKV59l4?=
 =?us-ascii?Q?9C7QCOr2FqFFpWeA/MWCP1Ct0wkeM9xeOfohP1CtW+0eMzADiOZAaALnDcMU?=
 =?us-ascii?Q?FzaTAxLc5Tmzv0fBjdK0ex7v7laeJw7+/n+YfOoEqrP0uruQ6AaQpa/eWOnj?=
 =?us-ascii?Q?RKEzn2srFlwbp2p3wJ9PCAH4DbIhdgkvRRjLKRFoRp/0VmRRZB5rEl8yiZOX?=
 =?us-ascii?Q?a/yJLfydyAkw/YwpdyLdsY1zvXy3u4YvbZY2HotjVqxGFpy7bEJzPv0NgTv+?=
 =?us-ascii?Q?W99DfiTv1y69ZSJ5Z9F9UqC+zYTUZNSRybE40q3BIwNrKb74BtmO97tRrs5y?=
 =?us-ascii?Q?3K/uIfZrBE+QzZ/vaCOb2O/9btTOQWNx1bZnpCgGl01Z+jGoWH0kAG7Ef5c4?=
 =?us-ascii?Q?30X5Gt2ccuk+jOf0EtuP0agt7GF8rKK9SPe1t+NhFX8/CGTba9EiP3eDMSfy?=
 =?us-ascii?Q?T9WliI4N/G/Y3iIVYB/eEFcl4baXSxOXEqvWNtgpE7Zsq0l2XxYQ66Zcz+UF?=
 =?us-ascii?Q?ra/zGAg0sfMibtM6F3wBeMISvphTR6XXhicAvc72HXk9p876BDzlSY7n2Y1u?=
 =?us-ascii?Q?ks3Qh/w+2pXcdB6igli/t48cEoYnrWUhf/S0CIujB4fMX/GE36EP3qa5S+Iq?=
 =?us-ascii?Q?j1aA4WzwLWouf2fKd8aX52ZBxDOigeAHAuMwYl0crqg69N0pY+TcZbaq/nRG?=
 =?us-ascii?Q?yf2f0JVwmGyBvJH3rBtHcfGNVFl8h/JzI2q55qImPL6Md24khzWDfxzN6EyV?=
 =?us-ascii?Q?LtKEO4oNsDbYQFafeeFiYuZjJdQtRt2IVSv0c9e51VMpFIneMJFbfEtSVOfT?=
 =?us-ascii?Q?LCw1dYoZBsMA912dOiu/lH/ehEpNFkg41AtOmIgEp2fkZYvhNv24it/+e6Z2?=
 =?us-ascii?Q?+VSmIqdSxQMbvAKZVZc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2652c66-8519-4b90-0b27-08db97c57b85
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2023 04:11:03.9532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ob1fzE2BlVbN9NFKdXsxJwL6i9Wrm3QAwYwkLaLxcZ4liqkBuB3Z1W/A4MeeMfV5jdMf2laDfb7BGP2YBRgLkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4473
Subject: [virtio-dev] RE: RE: RE: RE: RE: RE: [virtio-comment] RE: RE: RE: RE: [RFC]
 virtio-net: support access and control the member devices



> From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Sent: Tuesday, August 8, 2023 9:31 AM
>=20
> On Tue, 8 Aug 2023 03:16:44 +0000, Parav Pandit <parav@nvidia.com> wrote:
> >
> >
> > > From: Jason Wang <jasowang@redhat.com>
> > > Sent: Tuesday, August 8, 2023 8:39 AM
> >
> > >
> > > Yes, but even for TX, would it be better to filter the IP as early
> > > as possible in the TX path other than depend on the switch to do that=
?
> >
> > The idea is to introduce filters on the new virtio switch object for tx=
 and rx
> both.
>=20
> Filters for tx?
>
Yes. the regular switchdev model that exists in Linux kernel for several ye=
ars now.
And similar in another hypervisor.
=20
> Are there other use cases?
>=20

>=20
> > A virtio switch object can be part of a existing virtio device or a new=
 virtio
> device type in itself.
> >
> > Xuan,
> > As we discussed, since the owner device packets also needs to be
> > filtered, potentially outside of the owner device itself,
> >
> > Do you see the need to introduce virtio switch object now, or can it wa=
it?
>=20
> For virtio switch, I am ok.
>=20
I didn't follow your answer "I am ok".
Do you see the need now or can it wait?

> But for me, I just have this requirement that needs the switch.

> So if we do this in the device, then that is not need for me.
>=20
Device meaning outside of the virtio domain, for example dpu or something e=
lse, yes?

> Now, you think we should introduce the rx/tx filter to the virtio switch.
>
I am asking to _not_ introduce currently.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

