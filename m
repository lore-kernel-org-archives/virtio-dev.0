Return-Path: <virtio-dev-return-13127-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3392CEB64D7
	for <virtio-dev@archiver.kernel.org>; Wed, 28 Jun 2023 16:18:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id B573826A5F
	for <virtio-dev@archiver.kernel.org>; Wed, 28 Jun 2023 16:18:29 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AFB969865CF
	for <virtio-dev@archiver.kernel.org>; Wed, 28 Jun 2023 16:18:29 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id A1386986585; Wed, 28 Jun 2023 16:18:29 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8BEF7986587;
	Wed, 28 Jun 2023 16:18:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ks6cDekza0bnZf8zxdmUOQYeWq8Q+ye8YAuxfWaH14l5ZYsF3SJzF5Jd7a3eEMQsXR8RfcS+Dg3v/WAfmMQf5qwXbYIC3XZvXNrmat4UrP+7nmwxy+Nrv8nqtyAS1CZFZQc3r/pIaj0gJgyU9vbE3QckDAGL26+fLLYLWQCfalk50g88j+56K1x+aFR30a6WELdFVPtOdBKmHv0N66zcrsnBqszoXs9Cori5I96QzvP2435mMP9qGBoW2Trt+KnRe+zJOkz+/C9WHI7yJbKrZR0xqUZuUulqNNGpw6USZtmRu+L/Ey2gnEBIOYh85PXlj0EisCYUc9OIFwMprHwuyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EnjwDazwPhjeSzla96iCvzmft0iib7H6kOXhy8jrE7Y=;
 b=g2WUtobbelMVvvFTWafuQ9hjr/4fqi7FD+qmZZOo0XP8rUnNPsfK8ivRhEalfe2Cx97WEO3S8AaWCRYDqxIX0Ea9ap6IRPSROwXWoWd8UWYYJ6CKPa0j7BGe8kUawT2W/8buEloD6+slbuubV+HaKAnxYTzcVz1RBfJRx506ehQcqc6h4ZJRC5Od60U08wgJ5yJ8nUyVH99aPIX7Uy/qxszglYCA+CxzShIjiwsNPvjeGAENf5xO/yYpDUrSXWITOw/2jwmd0fE45R7B2eke0rl2yXQTX9wITn+mW7nHoGT6zCDVNZuwZny7DywXlGNHM30Uv7nBwAC04GAdQ2Og6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Jason Wang <jasowang@redhat.com>, Heng Qi <hengqi@linux.alibaba.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Yuri
 Benditovich <yuri.benditovich@daynix.com>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>
Thread-Topic: [virtio-comment] RE: [PATCH v19] virtio-net: support inner
 header hash
Thread-Index: AQHZqRVyfixvgxNlsUC5ASNdYCAGYa+flAoAgAAIhiCAAGduAIAAXkug
Date: Wed, 28 Jun 2023 16:18:02 +0000
Message-ID:
 <PH0PR12MB5481ED6C94DE8CC414C3369BDC24A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230627163549.40028-1-hengqi@linux.alibaba.com>
 <CACGkMEvFmAiWDp8w=ytin21Oi+PcTb1X3Eve7Kt2NVr_RkhgmA@mail.gmail.com>
 <PH0PR12MB54811123CFCDEFE3B48D4381DC24A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230628061257-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230628061257-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SA1PR12MB7127:EE_
x-ms-office365-filtering-correlation-id: 56e8d35b-4b86-45db-9400-08db77f33f78
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 xT8EBrUg+hCq6TaEho3+xTPGNa4HZMS9iswdsZmITx977PMcnAEZ6KMoS4UsqPjOZ9bQi0qyHyJQH2lKkT8WOMReSSxtGZRE8V7Avcr7CdgF9K56kL/hGZGUuzx0JSuWn6VvLeRvmKSsU1rsmOqUj9qxpdYP371ySBusPSELOyHcqVQnPxrfknux2zHyOxMOfDwbzzDhlhEgaJfxEnRtOUB6vpKVVvciC1ui1tN+BaIGMwuG3zOI3QANDZOb9FcKyy4lpi16EyvfMGrq6Z2SjHS5w7/PDuWhCMmRSa3gRcbWuTcoZ5quU82nKqpWGdAj7833EF1lX0vmsZb3oU23EDRxX21tApyfQzMmBZaMik+5OjCfTfClO/RmKGEAD+B3iy5vP1Hycv2YPSGJ5Xr6uh0rknIe5c4e1eBLzSWPwiAizqtnE8kkW9u5FeJjJKv9oD+RuN7kQwDWZ/DQeF5zt+CbKtSLex1rkdOzegZjc0bABvX4fuBECpk7VOey0+mjekKEeSmBPIMIZjw8HSVi2hySqKY9EdhxpymMwW8wk0qjHsIAMkk0FPzc2W+kWhFClBl88bxv9LfMzD7N+9QpPm3l/8xR+Aau9s6Cx/5o/HK2d5cIXSbN+XOhDGIJP1eU
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(136003)(396003)(366004)(451199021)(6916009)(38070700005)(122000001)(38100700002)(33656002)(86362001)(66946007)(55016003)(71200400001)(52536014)(186003)(8936002)(316002)(7696005)(6506007)(5660300002)(66476007)(26005)(9686003)(66446008)(64756008)(4326008)(83380400001)(54906003)(8676002)(76116006)(66556008)(2906002)(478600001)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?7FDJuEDUiAABysnrRlwZCmTLQ9Q4DBAhf/v7Lo06ha0ICuSBUd6zzaF2eWCs?=
 =?us-ascii?Q?PHGvU3bhxmNTOwt0/R0fVLA9TZLweoZWj+Aov0r7H6pFTs7tGg/0VMEvwqKs?=
 =?us-ascii?Q?iZSPPaxm+z90sK96/E0tFDoJ9fS6+sj/X6fbrysMm2p2lMRYuktQ9OmxOeHC?=
 =?us-ascii?Q?eExkqjKlT1yRqurWlndDfhw59gNsB/9mLxx1kUd74a6D4dqd40J7Zl4hDoNM?=
 =?us-ascii?Q?rlh/GV7XBRgLZMAh2Y8jNhxL+WOAHlS/7U0ha/MwwTirUi2fhb9vlTj2g1fs?=
 =?us-ascii?Q?3Qi3XaCc5h3wuFXL8OdUcwodYxtRghGE897c5Wx7COmmdh6t1RsQIOzPtNUL?=
 =?us-ascii?Q?H313UQ74t1gx8PKamVzwFP7lxNagnTz/PaZEW4hO7SaSSioWTQDeQxZ7VHaN?=
 =?us-ascii?Q?QxRYkr4lzXknXX39mOqau7JjRyRafVrNonwoDpZ33GTpAgLWoEp0/tBhF0lO?=
 =?us-ascii?Q?FXfHESq73mbNcYc9kozgaQEgoJog/EJ1tNrj6UHSzySNrqMbLIsUpmRfAuxn?=
 =?us-ascii?Q?PTHfQHy1PhKjLxuUjuytXLgZVwdnlEMZKHhQ2x41W1AjGuj9QZG9cd71umn4?=
 =?us-ascii?Q?DO2Q+F5upfFyhoHVhhs2BcIl7dFjU43aXa7DA5LH0KA4cWZoAbuSPMO3OfCU?=
 =?us-ascii?Q?CF0WAzvpv16htSfzLB4naFoYSijf4jvy2FU8AO1Jx+0UmCm6JEaWhxN7AfKW?=
 =?us-ascii?Q?rtf23o3GKse1iJMVHyspB2Ypn6E94qDxiSLKk+CONrZ4y1RyOBf72kccXLjR?=
 =?us-ascii?Q?F2072SLQ6daqqG2zLc8rAwfJnS7r324W9R1saF4XKNUJgEkkzt6NGxvuwQ7g?=
 =?us-ascii?Q?0HWZT+LNgPJDkghDWid0gigoeQeABcDHeRahA/Jz3luYpESRTybMNGFyVdI0?=
 =?us-ascii?Q?Xo+821OjOiuJkByXBtzwGyeUvJlHGzcP+Iw6xiHuD9xR9KuiPembZnsTZSSS?=
 =?us-ascii?Q?IIZ8gMeXrtWcnpu018/CaPK0rkq0XagJU0C/qaKprWerCE7VT73MhwBQsAFs?=
 =?us-ascii?Q?Ry2sweBZoHw8bKwfmyUUp61Cjr11dQp0j61Gm2iAepdACstnJMWx1L/MDNNA?=
 =?us-ascii?Q?mE/2Oqf4ZwqP4J4OaSz/SvszmTPqFq89DBtFLmbNqJn41yyRW4kankjKtZRu?=
 =?us-ascii?Q?UOlO3w3WnxVzo4lVdybRdn+Z336csA0AybreVorFLzfgm030TGSPjpT/CigU?=
 =?us-ascii?Q?Kk4UQYswbMga10aywODx+zdd2umgG/NMV7SiTIik5s5Z8w6rCYPAtoq31jNd?=
 =?us-ascii?Q?kk2YEQnbDzs0/mxdKSqunxhCjtHOmCx1SY+ReMHN04DmdW4YehSjcH4eU4CK?=
 =?us-ascii?Q?lFFre+AJ1o3ZdOKQbZ8OjePXOkgUL61wGNVpg6+L2kupv55p8vuCj4XXEgNz?=
 =?us-ascii?Q?N8eEpOiTZHJuwhIM0wMtOYJaRAWoa4yLw3po1l+IWayQc6+mzMwQc0zlpheY?=
 =?us-ascii?Q?GFIRzNQTxZ/i7VLeG6TrzwZtOahE/OM8vQLbp5f/ZXrvFoQKzXNXwsrjR94V?=
 =?us-ascii?Q?bdAIUIyww/QEDusc7yIGAJ3VPtDMvMypyAGw17xRQ8luC7rECjIRpQzoIJM0?=
 =?us-ascii?Q?7i9lYaAzjBBHBhKCmIU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56e8d35b-4b86-45db-9400-08db77f33f78
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2023 16:18:02.8140
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /waTtdcH7Hp77MjGuCLnI/CHShqssCcgQxaDJ+OS5dOr7kAPLodYog8r6r/o7bj9vPCZ39pmDTJ9FZZoQs2OSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7127
Subject: [virtio-dev] RE: [virtio-comment] RE: [PATCH v19] virtio-net: support inner header
 hash



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Wednesday, June 28, 2023 6:27 AM
>=20
> On Wed, Jun 28, 2023 at 04:23:09AM +0000, Parav Pandit wrote:
> >
> > > From: Jason Wang <jasowang@redhat.com>
> > > Sent: Tuesday, June 27, 2023 11:46 PM
> > >
> > > Having it in the config space, then a type agnostic provisioning
> > > through config space + feature bits just works fine.
> > >
> > Provisioning is far simpler thing to do in device specific way than ask=
ing device
> to store this value in onchip area which is rarely accessed.
>=20
> I thought a lot about this over the weekend. I just do not see this worki=
ng out,
> sorry.  Two things is never easier than one.=20

You proposed two things and making it mandatory.
I am glad that you realized to do using one interface.

In different context, you proposed two interface for driver notification on=
 PF and/or VF BAR in separate thread for flexibility. I asked for one.
Somehow you promoted flexibility (and also complexity that no vendor wanted=
), and here you lean towards single interface...

So more explanation of the rationale will help to understand.

I didn't propose two interfaces. Let me explain again.

I proposed,=20
a. all new fields to go via vq (single interface)
b. all existing fields to stay in cfg space (single interface)
c. if one wants to optimize optionally existing fields can utilize (same fl=
exibility how you asked for PF and VF notification).


> We already need config space with provisioning. =20
Provisioning does provision features, config space and control parameters, =
msix vectors and more.
Provisioning does _not_ need config space.

> In fact e.g. on Linux we want drivers to keep doing virtio_cread()
> and all the DMA tricks should be hidden behind the scenes. You don't like=
 it that
> config space is on-chip? Build an interface for it not to be on chip. The=
re is
> simply no downside to that.
>=20
This is the ask to build software interface between driver and device to no=
t demand on-chip config space more importantly _predictably_.

> I came back after a small break and I still see this discussion that keep=
s playing
> out as a big distraction.
> In particular where are you doing to store the things that are for DMA?
> In system RAM? We don't *have* anywhere in system RAM to store this, we w=
ill
> need an interface to allocate system RAM and pass it to device for this i=
dea to
> work. So in 1.3 where we won't have this, there is much less of an excuse=
 to use
> a vq.
To store what?
CVQ is already there to do GET and SET operation.

>=20
>=20
>=20
>=20
> > There are many fields of many features for 1.4 are discussed including =
this
> one. All of these capabilities just cannot be stored in config space.
>=20
> config space is synchronous interface, vq is asynchronous.  Setup is just=
 too
> messy to do asynchronously. So yes, config space.
>=20
Huh, I disagree. The whole virtio spec has got the VQs all over and you say=
 that VQ is messy.
Doesn't make any sense at all.

>=20
> Please let people just focus on fixing config space instead of temporary =
cvq
> hacks.

The ask is to have predictable sizing for existing defined config space fie=
ld and not keep infinitely growing by two interfaces.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

