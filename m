Return-Path: <virtio-dev-return-12820-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FA28C77B73
	for <virtio-dev@archiver.kernel.org>; Wed, 24 May 2023 21:02:28 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id D60BFCA66C
	for <virtio-dev@archiver.kernel.org>; Wed, 24 May 2023 21:02:27 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BD34D986605
	for <virtio-dev@archiver.kernel.org>; Wed, 24 May 2023 21:02:27 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id B12FF98655E; Wed, 24 May 2023 21:02:27 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9CA67986554;
	Wed, 24 May 2023 21:02:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e+nL4QnybMcZ/cQI84luUskOdBRk97GNl1q417OqQgkM/N7VktUg8vD1RJ5OKg8TBYp3CDlVilLb5U4iTa8IoltVKh0+exMcEPrzVPqSiT0GbjFQX7P0PO26+FBPzxK9jgNfWdWwECbucl9oMRR6jP7dNiaqS78kiG0oG2J0t1GjrHlO1psJBvoojEgHZCwOoCYRzdtfsaZ30tLmlRUNufTwPa5lcgTvB2YhiCfywHVS5HLg/uk/s+3Cts89O2Pmdj3xVBd3Nv8FR9JL/p6ZfUGYLh82l7o8F0NBnkhUECqs/803SfnEnD3vAix00hhKzv+YWIwH9qlFLIGW/eW9FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wHI7CHFaWD74dwRkRNZMNUSF2J1esQyj+lqWNSLD9eM=;
 b=VnAlITkDQy8Usg2W3iQusfHtIYYWQejestKAP/knhM9MbZcB1oayRTpzsMWMyruP9Cnh96sZyW2GGh6H6rzUfX0amnTEUYuhEJsIsCJR33MmTvh1OMfHEmkZF1K2PE9ZSRrfJ40T/YMSqBy75Pe1CVaPgIfzTYLj54CIBtIhA6ZB0RmY0yCY2J58NcErqnFsHUmeNi6q+fhEVkpmuyVVLTIyMkMR7CdwcZ+lfTI/ae+MECFY6arcJBFg56rhXZvJQ+epcn4zkOrbbVfxL50h3MyhG5eq0lbIjUENxKdbf+vXHxiCPNY+IqjIAxcdL81HZ+So5y/W5Y73ERe85hJ3cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>, "david.edmondson@oracle.com"
	<david.edmondson@oracle.com>, "sburla@marvell.com" <sburla@marvell.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>, Yishai Hadas
	<yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [virtio-comment] RE: [PATCH v2 1/2] transport-pci: Introduce
 legacy registers access commands
Thread-Index:
 AQHZf639R6aTQu3GsEiaqC7Dtr8vQa9eBfIAgADi2pCAAZmGAIAArnkAgACuQ0CAAqt6AIAAPtmwgAAZkYCAAACz8IAB7w8AgAABbZCAABb6AIABJ5CwgAA8YwCAAC3WEIAA0t4AgACUwwCAABRagIAACxcg
Date: Wed, 24 May 2023 21:02:21 +0000
Message-ID:
 <PH0PR12MB5481F68612984DE40B89BC14DC419@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230521102050-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54815D83C3287FE7B3A2947CDC429@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230522154149-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481A2AD326E7F0A7CEFC223DC439@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230522170700-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54818BD5421AC200C2DEEDCFDC409@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230523141718-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548124A538CE4CCCE76F068FDC409@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230524054225-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481C5C2A080FC9BD6296AE5DC419@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230524155902-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230524155902-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|IA1PR12MB6090:EE_
x-ms-office365-filtering-correlation-id: 5e9b8f7e-2ff1-4294-6f74-08db5c9a2add
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 txUNAfKuudtpmqb+Lft5MUcThy2z4r6owx3ANePbCIKeT+uTyFxwWo4E9hMQP6hjLQCXZNTRyOU6vM/VLMqfcsWPf6Bv6QRB7LC4ZVRU43egOTl3FVD7YPt1hK5Zv4SOEqKfw+Uz7MdPxVJ0R1pM+LRzGQUZt3gVvIShnzSrmbiFFbwR7ZNRm6aTwfuKhOlqTeg+2UEj7Wt4Xnce6iaZ1j/48ouwLUMG9r4uHCu2sIsLhDnij4Cyr0FMpWWg+JQ3cMUvOcioioTFy6R8Q9JST83Ymy/fnJeAeSogWQeTB6bR1KX32ii+G9PTKjyYgt7WQ+++SM82yKCRx0icAgLJewH/ht9nCu0TFasKBKJbSNhlwHGtQz3cWJ23ukaMsAFmbrrpTY/QsFpGXHoUmQo7onTqQs5M/X4qCWDTZETvZrbFS6oOA0Qm7sJl+V16en/ZsSXcAdnUCBCQ9BZ4s8wxCNxo32O9HBTHiOF7gT5/SnThjXGcHep83wWTPqglsUrtgflDs+RZViesyX7FZO6nnaHHnGTNwJWpRGXR771VxJ0KvclYwrf/lCNuzfulrTGrjhBsYVGC2/lpZh/4BN9+KyD8TpLNN0jtkZHqMmUrs64oekOSPZuj+BjlPHyPMQiU
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(366004)(346002)(396003)(39860400002)(451199021)(55016003)(83380400001)(38070700005)(107886003)(6506007)(26005)(9686003)(86362001)(122000001)(186003)(5660300002)(2906002)(8936002)(8676002)(52536014)(478600001)(71200400001)(66556008)(316002)(66476007)(38100700002)(6916009)(41300700001)(4326008)(66446008)(64756008)(66946007)(76116006)(33656002)(7696005)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?p9LLmoBTWcZ02kzRRDyxzFcjdAtjmnUaIukB7jTGgwrKsUrx7zStd3ZGSPsp?=
 =?us-ascii?Q?OsaYWq/UePmlz3A47CckNid4r8J0++oC0TXvdLsJY/rwSV2/ozpMpxxI0SV9?=
 =?us-ascii?Q?LFkIN3W0XO7WR17THHMXaUToWKthUvEh9tEzDgmK0M3hXtqldzJmIiIjUaJp?=
 =?us-ascii?Q?DvlaHWeEDUtIU3uJEK2ZMcwcIThnIb2inA9nKhOzwVDdWqsqMjWVphBbzVje?=
 =?us-ascii?Q?TmHvCZdZNto8cZ9s5SJJ9+YYRPqXwEqeqiBsb3Fw7gd5Hfjf2jfHDMVnhuUS?=
 =?us-ascii?Q?9vWPvB6GwscbL1w5Wg5UC8s+7WN7t0g64zhjUULpxl6ESpWv/NmsXYgIgs3a?=
 =?us-ascii?Q?HVI9sl7H4lXxBxhRQj1bKCt3o2CxR2FP7v1A5fb+8CL/Ufmsa/4wQMWuntHh?=
 =?us-ascii?Q?nbt3ywMAkDfx+2PX+nGt+Og96PTc3JbbQ+XlSwjHBzIc3a1qanr5iHPF1rrj?=
 =?us-ascii?Q?Xa7+FQjBOQNj0Y04fjwJhM2IPBtnU/Ll5g+oNuZe6C7zffloDrHnw5nPmjt8?=
 =?us-ascii?Q?sYoa+R8yrcT6l5M7N/CJRSn5S0HdEVtmMYpdIeMqYHjDjSQk7ogaWWlMTAk1?=
 =?us-ascii?Q?KRiF4DYuzSxbJvsJhp+6Hm+94AahIZq1oIEQjxi4t3mrOcs6b2169e/bJBNS?=
 =?us-ascii?Q?u2qzC7lW/QIu57H4ym4KIQV1HbDFNHPBZooNcMsd1xurFcAblioHfcD579ZS?=
 =?us-ascii?Q?PHomzAoK4YLauiYdZybE03epLlZpVTtikNA3yOheS0/zhvwjnCitFP/qyOOY?=
 =?us-ascii?Q?7jit9IkeQYoiUQiE8LpH/xAO35mWy2rTgGihR6O+X/NIRF8EuXuFvpzs66i0?=
 =?us-ascii?Q?0ed0fgYCLzyxUlud/Dwn0kaC7d3p887GHfDMY3S0ekIafTJBXI2GpHcxYsfi?=
 =?us-ascii?Q?jHapf4Mgb4KUqe8eBHp3n9EhxypNZ5/yfd+KtKSgJstcUDxE/OE5sAKgvdUv?=
 =?us-ascii?Q?y+kADiwfqoReE9nONpwP7uPcybk/r6Fi4KXmo+aFu4F0RrP7nQE8Uz62Wj6y?=
 =?us-ascii?Q?lSVW63cQ5SpLiNSFS1kiAiR8RWPIC9x8MYcOFVhZjOVH19UGA7s5ol9Ryni+?=
 =?us-ascii?Q?384Boj+DiuoxF7nPOFeIBLUuzPGOak3xbMp/QB5Q6xsC299c4oChk3FlFFTT?=
 =?us-ascii?Q?WYnJqkhRHchu3vE6bYy2D/Ec3mBwiGxEGnnHrzMhXhbE2iwKdmOBED3/FE5/?=
 =?us-ascii?Q?u8hSYVX67PhyH0GY4+ScdI1cpBl8idqRbfRJNSYA8yVf/KYPqnXTvKo1MlzE?=
 =?us-ascii?Q?Jjj88XoEDvX5r2TYjWIcDrOTUX6J9eS+WsqdC1jXUGeX5D9rV4Vkmm12Omh/?=
 =?us-ascii?Q?dMHzaSbnooFZeShfthqepU7bQOuPaFN84nIqNwYhinb8FaPFAQ+dyNdXLj3s?=
 =?us-ascii?Q?mEHXG29hnu46+TTLMN3lUJmlm6VeauL98HvUlcKW2M8Nv1O1Jo4+XF8cLoPv?=
 =?us-ascii?Q?JH/klGtyRtOiOAwmXLfMmnkgOEGwu8lF/9ci2ulWhya+OoEJflBFO6zkO3Sv?=
 =?us-ascii?Q?SqBNZPFpXfFAwrWwfRP1ohdYlhu8i9bw1ACKtqUI1MZkgQuEK8crz9IV/Gvx?=
 =?us-ascii?Q?nRmiMeb60KdsgixpCXc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e9b8f7e-2ff1-4294-6f74-08db5c9a2add
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2023 21:02:21.6555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r70CUNsbdtapJXIAV938No8jK9XUZKxA9az9XaHgRT/zRQ64dBk7ADgp3RYRfZtqlfB4H1Nq6ylNo6GB7HzwBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6090
Subject: [virtio-dev] RE: [virtio-comment] RE: [PATCH v2 1/2] transport-pci: Introduce
 legacy registers access commands


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Wednesday, May 24, 2023 4:13 PM
[..]
> > Sounds good to me.
> > What about discovery the notification place for the VF?
> > We have two options.
> > 1. discover them via AQ like config registers access 2. discover it
> > via extended PCI capability
> >
> > #1 is far more programable and does not need to bake in the PCI device
> layout.
>=20
> I think 2 is easier for drivers to use.
Yes.=20
Its trade off.
But not a huge difference from sw point of view as they use underlying apis=
.

As opposed to do that baking pci capabilities is slightly hard as it needs =
to intermix control path over registers..

Typically, CVQ and AQ etc a PCI device would do using some sort of firmware=
, so adding commands are easier than low level PCI capabilities based tunne=
ling.

>=20
> > So this way one day in future we can get rid of it more easily for thos=
e PCI
> devices who may prefer everything in the hw.
>=20
> I think these devices are better off with a new transport using drastical=
ly less
> registers.
>=20
That way AQ scores more.

> > > a feels ok to me... maybe test the waters with express capability as
> > > well, it will come handy down the road I think.
> > Yes, if this is really needed for some OS, this addition will be possib=
le in future
> in the spec and also of the devices in CC list here.
>=20
> hmm not sure what do you mean. I meant to put the capabilities with the n=
ew
> legacy bar in express config space.
>=20
I mean to say we should do AQ.
And if an OS can never implement two driver communication for legacy, may b=
e at that future point a spec should evolve to provide this capability-base=
d access.

> > The new capability in mind is:
> > VIRTIO_PCI_EXT_CAP_PCI_LEGACY_REG
> >
> > struct virtio_pci_legacy_cfg_cap {
> > 	struct virtio_pci_cap cap;
> > 	le32 addr; /* register offset, width, op=3DRD/WR,
> status:0=3Dpending,1=3Ddone)
> > 	le32 reg_data;
> > };
>=20
> I would use cap64, cap is there because we did not think about 64 bit ear=
ly
> enough.
>
Yes.
=20
> > This will be hard to do for SIOV in future, so I prefer AQ cmd for conf=
ig
> register access and notification discovery.
> > WDYT?
>=20
> I need to go back and look at how does SIOV tvq proposal manage notificat=
ions
> then.  Do not remember off the top of my head.
SIOV tvq proposal does not tunnel the driver notifications.
It exposes the address and size of db region like how I had in similar comm=
and.
This is why it is not a transport vq and I suggest to rename to aq :)
Snippet of it below.

+The virtqueue notification area information can be get through the followi=
ng commands:
+
+\begin{lstlisting}
+#define VIRTIO_TRANSPTQ_CTRL_VQ_NOTIFY    11
+ #define VIRTIO_TRANSPTQ_CTRL_VQ_NOTIFY_GET          0
+
+struct virtio_transportq_ctrl_vq_notification_area {
+       u64 address;
+       u64 size;
+};
+\end{lstlisting}


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

