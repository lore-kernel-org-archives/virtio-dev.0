Return-Path: <virtio-dev-return-12132-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90915C77B70
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 14:31:03 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id AC5A44256C
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 14:31:02 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A1D639865A6
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 14:31:02 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 9651798636D; Tue, 11 Apr 2023 14:31:02 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7B9EE98636E;
	Tue, 11 Apr 2023 14:30:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ALOmXByBbXU6f7Zk3QLvYdmI+0Jx95WUQN+ukz+sYjuGXPPfE2rp8IPCKcYAxOKUKodbaL7logkO6NAFM2g7iJDZwp1Wr478HPjD0PMmXFlozfktkJue6tOR+RyAS5XeHOI22DvUdG0M9euqkES/372auL9Spb1NpRCLbV/0qsCd4tQW3JLkrVUqUuYOruaq6drv4OjjgsaWpiwkAPEVarIiwTUDYIyiff7+3rXl3/pi3UgU/dLgPV0DdH6nAEUrWt154hSoWY3nUtpX2qyQNsVY/jWiAFuuZSrNTrlVbGn8lhQbuIHhBGpz2wc/aZkzyEBDAgtVt/RLzmg97CPywg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mgIbpF8Y2fMJMe00S44FwBaGKfp7fj7UWayRGuSDt0o=;
 b=EKeqSzH7XG5GGCP5n3HktjwSqIH9csnQ8eEkHOVEfZekODzZuYf4S9JNbYL5gh7mdSJQCAUuYnByB87PrImVQGHeozFDVeICuLnmqpF3/tm4dCe3VamtZe1rdKjyM5leZKKIV1lRSG1DFKZmzLqoE7zCgTKGxJwyWMLbVrI45knOERxng+x7FZ5jrqauHchmlzGq+5qjecO9eHqmIYbBnrxR/+MjkjO29Ku/8oBo7iMkrroeyBG7FTfZ+QBnvxQpgQju26IPiIKh/O4Cd1EjII+XcpztKyl1mT4dLs0+cZkmivWCnSqRIMF3uQ9N3LkpsXV40nbP/zxIuM2BybvGKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Jason Wang <jasowang@redhat.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>, Satananda Burla <sburla@marvell.com>
Thread-Topic: [virtio-comment] Re: [virtio-dev] [PATCH 08/11] transport-pci:
 Introduce virtio extended capability
Thread-Index:
 AQHZY1tK9bYi+VUlRk+f1PKXMn2Qra8j0vmAgABQjgCAAA6TAIAALr4AgAEQlICAAE50gIAAcdIAgAAEJICAAABX4IAAAcSAgAACy8A=
Date: Tue, 11 Apr 2023 14:30:51 +0000
Message-ID:
 <PH0PR12MB5481566A687F40ACDD07A1BCDC9A9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230330225834.506969-9-parav@nvidia.com>
 <CACGkMEtMOy4B-O-52ka+9P3OBQ_hs1KvdjWodNYg-XKLff+giw@mail.gmail.com>
 <20230410021619-mutt-send-email-mst@kernel.org>
 <CACGkMEsZXozY7iC7L3L9FC+o8dQGY9+Hhbag2Z-G-nxr9BvDdw@mail.gmail.com>
 <20230410055947-mutt-send-email-mst@kernel.org>
 <CACGkMEsKLeJ1q3Vh8h2JYM=-RcrGd+31yR1Zsw0U=SRd1JZugg@mail.gmail.com>
 <20230411025646-mutt-send-email-mst@kernel.org>
 <c6e986e2-4806-6635-5d8b-0f70c51c6b88@nvidia.com>
 <20230411100209-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54812D94E60C793734DC8DCBDC9A9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230411100914-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230411100914-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|IA1PR12MB8190:EE_
x-ms-office365-filtering-correlation-id: 9a6cc656-c4fb-40f1-0b1f-08db3a995a06
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 5+OREQKuZHoedKokytipfSz9K9phhzDdv87+Rf9QoyFaGxlUW4HwImp07BmvtjUAWTZTS/ODsI/uDlDentFG3EjiB0zeJQpK6bWqgj71hCBQJlgejOi4/qSpvvAd+FAagB0f1ik5vN3PuA5CgoBMLxnF5R2udCjWUqrHQE/L/5PleYpkzzuCJiCNN6iIPHTmgAlwX3mSvzbEjSoSmZ/jAhS3PMyGDvdB90dT1B7KLRW5xoyKgE2HRnXVTIRc6mUATM//jWg/MiwbfMEnyixOxK0yr9QU6iOzuGb3ueExCahct342YSCcPj1nft9Sf+HNwxc0yj1hdM/BiyWzZDlXpH9q740t1Vhg1e59+mHknSZxTkJz+JHiZgbapVRwo6UYcBumOggqG6QGCCmUexf4YeRsOITHDHYmc7ZwNFbmSLq1ZPBSyP2rVqNEJF/SPQ7Y7S9p4j4cCj8FZopcoviZrFpU9iJdB7BXjyK4CBBwNSG43G2xTVKr0b6AAJcBX/XddeZ1w52vPQbU82++q+xUiAZl5ipE/xW1kkK61jAieLMLtkwY3NOEhshbd4n5oUic4Xtn1/4zQ5Rpye7PuHyDxezQpWrV73LiMseAMpUa/wx+8Tkrk4MRsHhWSP1QfVKQ
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(376002)(366004)(346002)(451199021)(54906003)(71200400001)(478600001)(33656002)(6506007)(9686003)(122000001)(7696005)(41300700001)(316002)(76116006)(66476007)(66446008)(66556008)(64756008)(4326008)(6916009)(186003)(83380400001)(66946007)(52536014)(2906002)(4744005)(5660300002)(38070700005)(86362001)(38100700002)(8676002)(55016003)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?1wedUDOo41IbUnO7gUmAviiIv/xdfp3bA3w94sG7/hb8zxWsMPV6Lrb/TfSI?=
 =?us-ascii?Q?2/0H1Acmet+1AjYrr86OlHZMxLYzgsVz5v9sI3FEIavmHLKGLVTOXZsp8q9M?=
 =?us-ascii?Q?eePDeikmzuFh8vyP/CiC0YvgMBR1B6duJKPaHZstonmjl3IqGcCsb5/iGdDi?=
 =?us-ascii?Q?BAuWXZzfSBUBZiy1cigPFn6wE2ztqRP1KE79+ZKEB8MmpHEhpRhOuqlIYt3N?=
 =?us-ascii?Q?39K7tPNalX0o9yyTmgxUsNowB/Tt825FViHg2MhNvVZgLxWop73826wieohq?=
 =?us-ascii?Q?459FFNV+LvjX7Sl2c5AMFBss88Mw/G5jxkPVBFYyAi5rQyzuMhmpkLLwk34A?=
 =?us-ascii?Q?1TC30Ja80l8MXr3Cadn0E+T7kye0S7SYnMdmLN6vl1JWIaN+RlF8p9AkUhql?=
 =?us-ascii?Q?MLcQLL37fXDWVY/P4giem3ait4ED1JFWVislj4RB6yByEq1xfRGVuvyybYeP?=
 =?us-ascii?Q?10ykb/owCof4C4b97x+BnbXBfV4adrMB/10kqVFOKzZjjwVK6YY8EHr9Z77W?=
 =?us-ascii?Q?EarE/Th2gF+HAznPW4vtnOCNdG49O+S0OzgT6YdCHwy8vq7u4ex5BGD4yjV8?=
 =?us-ascii?Q?SZy6yS6HQFPPF1nSLjVvHNIPQ9KtzQUdy97YvvxhEWLMjQdeIVQ/CJhUb4Rj?=
 =?us-ascii?Q?6uv/rdExD5EQnAPrwjbUX/3PQhNXe/yJkEo1OYarjvCo6DXqI7j0jBPcbA7L?=
 =?us-ascii?Q?jR5ZwSBIVKUfCuhkS4s0Xr04awOCrW56D2p8j4YrQFHz4Xid41g1UQLUP9Tw?=
 =?us-ascii?Q?YxhrdCofNS5CsLmRa6pkFQGhK1r6EVubYzY6dA8EP6ZE9wyelaxvpiw03Yw7?=
 =?us-ascii?Q?pDEq7/REKezfBnU/H2SEZbKk5R0W3YZCcp7vJbegP3F+BJ3kV8jmY9KUj2ip?=
 =?us-ascii?Q?81pSBeZUAxXBCok8n5hW8hxPRih8tQH0Podhbuk7CJbMnutF5amqMEyvQIoV?=
 =?us-ascii?Q?dFC+UDtGhZRZtfF++SAAY321g97VjlK6eYVdRarX7R/we0KewQVA/vpa1K3Y?=
 =?us-ascii?Q?EaJ57EHl5S28n6/DRTdTD4+vpciQijH0Wwz4M+rfyX9ep1c+R22Dt/Dsm9F0?=
 =?us-ascii?Q?3tjKGEY47976Cskw8Dv2XR6GWFrtobtw8OVan3QoAGRxRP60yvakslw7lCTb?=
 =?us-ascii?Q?EubEez5eSAOp72H9LJNOmkme2w1+MtfQoKTIzVGH1wTWZQhUwwldpips1DG2?=
 =?us-ascii?Q?QoMMJCToq4wtISqN3cGU8i6amD/amwlR1KO3AL24AT2lZb4+OFF1NZTsSN4i?=
 =?us-ascii?Q?ehpTLwVMadYXJJfdVJ0L0mUQLYF7cU9elYNGBmZbQ6Yf2RgAW3p1kSM/zuKN?=
 =?us-ascii?Q?kM01OBroR1O4u/sJgGzSxa5smJgnP/+tyc4yUSLnIpug9pmx47km/UbPO6jK?=
 =?us-ascii?Q?vSD8PiMoHvfhl0K/Gx3bw9dadFznPMUoOSdfPDXsyaf8tqiyjVze5ZdICO0G?=
 =?us-ascii?Q?jmGIa+Mih9POTf3b9StLs/kzuJLe1uj1NSMFaJVBxwyNyFavQQE5+Jz6mbQj?=
 =?us-ascii?Q?u5RlIxPXeHTxRrYx8orpJPxdmCy2x1W7WvCu87BFHOybXoQsoXCuUC2Nup/F?=
 =?us-ascii?Q?N7GqPKs1w2IJ4Bi4FdqfNtkOpbT1SV7JmtRzCjknZ/ci17KrvI3Qmng2ZJJf?=
 =?us-ascii?Q?y3cuIfrS6uhSp6Z/EJTNDWE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a6cc656-c4fb-40f1-0b1f-08db3a995a06
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2023 14:30:51.7465
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cGN8JDAIZM2VRZCf4eAqXhhwF3V/oLtmAdf0F8DBIsZm6WUpwQnMGgy/J6NuIr2JY/6+cOxzdLMqU3gO+6jLJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8190
Subject: [virtio-dev] RE: [virtio-comment] Re: [virtio-dev] [PATCH 08/11] transport-pci:
 Introduce virtio extended capability



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Tuesday, April 11, 2023 10:10 AM
>=20
> well, of course, my question was for a new, future device, can we put all
> capabilities in the extended space? will we be able to teach bios to acce=
ss
> these?
Cannot speak for BIOS vendors,=20
but from PCI spec side, the extended capability exists for more than a deca=
de ago.
ACS, SR-IOV etc are part of extended.

We still need to teach BIOS for the new device where to look for.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

