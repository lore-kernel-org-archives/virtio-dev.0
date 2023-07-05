Return-Path: <virtio-dev-return-13238-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E2E8C001B0
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Jul 2023 14:37:28 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id CFF87C8DF1
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Jul 2023 14:37:27 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BEDCE986729
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Jul 2023 14:37:27 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id AFAE9986725; Wed,  5 Jul 2023 14:37:27 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 978D4986721;
	Wed,  5 Jul 2023 14:37:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mzcoiRlpWUgCqzGU/5Q/HdeZqkwgFbqu6WXCdw9eykVtoegNpPYUzlxhmOnll+XsEZDPnLkV8u/86o2wDx+Mw61o4WlKrUwEhBmlfkJUaWT4BmXl6TFXwOwW50nC3moRKv0m/HUwig2hBWsnM06aK5DK5E4o6ADOBw1vF98ZQbBzgnY8xziEH5quoxbbTD39wnyfN36M38hm3vkblwg5oEF2Z0h6MmA7kxvmLq/+zuxZnqsNcAiPff1BYQfmSDKcesWSFw70bTF306fX/vCKjb9+nC0YtpHrwHLPa/wXXh98/qgfuh00P0xXOKEucXGA1RAK4fwIPeFoC0aRuMAGHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BIxoJnVyeQRFtgm4AuCQthBwC8sayKXFeq113g9riDc=;
 b=EVipMpyYvhgZKKQ+s+ay2mUOBOTI6h18Z05HkxZkZEfyKIp6/gGJKNxO0znnbv1+n06IsM/zJavAtf6dm7Llbrsn2vYu1L55/GnL+tnlSZCyFtKNOwJo06vd0OlPxzqvib7Q2ufIm5RXkZC0bqW9iRZrW2pmR6NU3GfQ1bHn+M3+z5W89oXIipoGzvbh7GEXl0v8A4MDSIc1OB/jrGlN30K5AbAvhf2eRKzJy+70B3H++2xq+xUQWRlJQAMLoBS2dPBekmQYm5pEx4HLwvGmBoVCb+ZG3HY5OboF1lofv5v7NIJK0zDATpaocoJMnNghNPCRSqBZXI3Z7W7Ydn9ufQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Cornelia Huck <cohuck@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "david.edmondson@oracle.com"
	<david.edmondson@oracle.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "sburla@marvell.com" <sburla@marvell.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>, Yishai Hadas
	<yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>, Shahaf Shuler
	<shahafs@nvidia.com>
Thread-Topic: [virtio-comment] [PATCH v9 0/4] admin: Access legacy registers
 using admin commands
Thread-Index: AQHZrtCLWAcU8k1wLESQt7niIKXarK+rBJ+AgAAdwiCAAA0fAIAADvOA
Date: Wed, 5 Jul 2023 14:37:22 +0000
Message-ID:
 <PH0PR12MB5481787D2C6F9C1701BBC978DC2FA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230704233724.22394-1-parav@nvidia.com>
 <20230705070758-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481B4761D5B67B850755782DC2FA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <87a5wa325r.fsf@redhat.com>
In-Reply-To: <87a5wa325r.fsf@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DM4PR12MB5168:EE_
x-ms-office365-filtering-correlation-id: 7dd4ee3f-7b39-4b69-0576-08db7d6557e1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 axpBXha8eGz5EsUKWvW79n2cFOiUdmlXByRyDcHAyfhe5FqfeqDhMcnoKxfLGNLMEeZnT3JeLmXxIBjppThhxXQURSttgpU2rqIkymjhE8bwDwSg67uKkIASl2j09atEEBnKTl6Jdhm+k6ImU/IQGcr42mXARtpXVk7vXACX8oAKLgzU/pcFAg2xODwbxZZaGO5NL+Bs4dyhC3mDN7K+saVNGzEmD1IrGaWV8DCDaajqJ7SKDbaHQHTwWdXnvFoq6KEIenO1RezGGtEkaSOvpFJ2QF5e5lGkHqFHBrMDNQAAinwkJmbGfC56DhR3ruAS25yK9478FgT2kHF9BX+HQItk5CNSIZUGpbdNdKpatVY5v4nLhBBnecdy+2Qm+rY8oITCP1I/1CjwIriy9tNMdhlLTPb1kUW70QvSNkNYRod0JoSBvHgD3gpaQFn5UrE6VYstN7Yaj9cr+okZIY/vGfuocvhpWKz5YLAmZ8BXqGwHnNWer2jmEnb36cOGep53tUoxpuZ9+IrlnbBYun2yMVfUeiqFbNXgeCyH9J02SvcUQcGvBOzYqpg/ZpUyf3D/Wjo4JRjWAnP2sdgVzlldxvxTMH2QwDWnUkGdNG+RPgquZeL+YFet4DecH0tlbQDy
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(136003)(396003)(376002)(366004)(451199021)(107886003)(41300700001)(478600001)(38070700005)(9686003)(54906003)(110136005)(86362001)(38100700002)(7696005)(122000001)(71200400001)(4326008)(316002)(83380400001)(33656002)(66556008)(66476007)(66446008)(64756008)(66946007)(76116006)(55016003)(8936002)(8676002)(2906002)(5660300002)(52536014)(186003)(6506007)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?bSL30coT50LGehVpUoLb4/aaUd130yggnL/kOpet/vtolpgNbtxbMhHiU1RY?=
 =?us-ascii?Q?w821hHCxGfCbSkkefS9VquBROM5Wd6CddHrJLmCcW3Wt4jRY/cTV4jz9a/lY?=
 =?us-ascii?Q?i6jNSvD1xK3+ZVoccQ+P0duFakdH4ixLqK1gLi2fewBg6av1LFQLxbN4Na3F?=
 =?us-ascii?Q?TdV3P7MJDTmXi94VbPnxaYJkdn3r1oFk/yYPoff+CAKPc7s73xKJQ+nJBjrg?=
 =?us-ascii?Q?pVTphKV+uYgVmQdf/z38TN9BxlTtKS1wH9wcDYWKJxnobP0Z38qM83zldfFY?=
 =?us-ascii?Q?WAoaX4MO9rywYd73ZFf2HBY9Dg/MLZGCYY/0XqqZWaQOgmwD8TzrK8DryG+/?=
 =?us-ascii?Q?OWWJu1ogSY0qayp4dwScFWLpOK2QiOlQPhg2MPwuNiQkgB2IO3OWxwW6Zg1g?=
 =?us-ascii?Q?p7cBmwjdM2MFH1uj0fde6i9DP/0MCMlsjhpWHkFhlbtGAViNaWpiZwyw2HEL?=
 =?us-ascii?Q?SmHcNltQ9oXac5U9ED+YL0WjjCW85LpT1rznb2NiZW2NgM8uUNRMA9R9CunV?=
 =?us-ascii?Q?IrrP9oUj4jXCXpoI7+wSe3L56szMlZdJAEnc/B5f1Ji/rAx67roJUIARoC2v?=
 =?us-ascii?Q?+wf1q5ZVSjf9tA0k94ysJkKyvgkhkxYEzFDxsY/VM/20R908FvGyPAnUV1qi?=
 =?us-ascii?Q?U7mrSpdXr3BsyLhfotYXe+OmyOpFy9+Y67kAZagyMM5YqofbFvpoaoCdqzX5?=
 =?us-ascii?Q?PYlExLZhUQDUHKgGYGBF04h588vgrofdOraNfOVRTIMPC7a2rHIddiN3ZswH?=
 =?us-ascii?Q?b6cq1VqxPXsE7/6ub0Ece7mlk9i4zjVW+3/vU1qW128hHqy/bj2F+FcY9Q92?=
 =?us-ascii?Q?5SAbBQw5ksqPPDOmjpfElRk+mSxU7C/EtuJ+fHiDork+kyqTRKwOVeDil5nC?=
 =?us-ascii?Q?mzVavn+Yma4tPb2TaEmJMEmzYpSxOzrLJd8e7K3fEuH4gBL2G8f7FZRdtdD7?=
 =?us-ascii?Q?qrZPk/TsZVDa7KLDMGR0S+amD1bFolp0Lpex87+sXg4RVmYch3xijSYKPv4x?=
 =?us-ascii?Q?WLoiKbHCDdiHeVWSYoFvpP6386DtG/nI35go39KT2bYsNH974RuMCDFvEh7Y?=
 =?us-ascii?Q?+8dlEYIQlQVj8lktoNNMIpyJoVC5Vet+4ka4Q5KPgoZpOl5jPOzsq/WeaQsq?=
 =?us-ascii?Q?0fpg9PxmA8yj3PU3iOv9OeCq/oDezvSKlxGIH00fiRgOc5MKIOig4YOh188Z?=
 =?us-ascii?Q?Pz242NjlI+ZYqs3QteKqr+QEMX8x+DA5f3t371lsMpPPs9NM+4izuPOedsTA?=
 =?us-ascii?Q?oqK0r+RZwWbJb1hH42M+yzAVGVskwu8ciXR99Q0ZUDGa9osDbbuT7DSjZOfa?=
 =?us-ascii?Q?9hb7PIuLsV8lH/u3+J1anvCM6OCtnp94joiidM8/UQmGHs3Jtjt7K5DrjFFo?=
 =?us-ascii?Q?qoyI+y8AU64asq2qFtE5jPkeNqGZt73mgnxcPPiAghRJ3WeJzwl4Mji/VVME?=
 =?us-ascii?Q?++c/JWBBbLUD5caw6XQ4A6VxLSxGHZ87URbNVc09DGfWGTD4zCqZqpzRhCGd?=
 =?us-ascii?Q?GI3fE62Jknghf6aGL3e2XxGz88XxjRTsubSCaEYWAZICuE1VWAbzGgipi8PZ?=
 =?us-ascii?Q?LBh/O7f8rMxZkldSI98=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dd4ee3f-7b39-4b69-0576-08db7d6557e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2023 14:37:22.2353
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TKqDg91VGde2Hi9iEKZ0SpGvvrbDnphcy+xl1qiPYGGcjQHIC58Nu2cHWwn+QhvjVPFRSeRTS4GBkho7kPADgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5168
Subject: [virtio-dev] RE: [virtio-comment] [PATCH v9 0/4] admin: Access legacy registers
 using admin commands



> From: Cornelia Huck <cohuck@redhat.com>
> Sent: Wednesday, July 5, 2023 9:43 AM

>=20
> >> From: Michael S. Tsirkin <mst@redhat.com>
> >> Sent: Wednesday, July 5, 2023 7:09 AM
> >>
> >> OK I sent a bunch of comments. Pls try to address, unfortunately I
> >> didn't go in depth over the last patch, but I feel it should be
> >> squashed into the generic legacy command sections avoiding need for
> >> indirection, so rewriting it now wouldn't be efficient.
> >
> > I relooked at well yday.
> > Transport has very small section.
> > This aligns to how the existing spec is written, for example vq notify =
data is
> explained in generic way and defined in pci way in PCI chapter.
> > The indirection is fine and also self-contained similarly here.
>=20
> Would it make sense to do this the other way around (i.e. use something t=
hat is
> PCI-only from the start?)
>=20
> IIUC, the "legacy" problem as it stands is something specific to PCI, wit=
h MMIO
> using two distinct approaches for pre-1.0 and 1.0+, and CCW simply using
> different commands (and no need for any kind of cross
> access.) Not 100% sure about MMIO, but I don't think we need a version of=
 this
> for CCW.
V4 or v5 was having everything in PCI and Michael asked to write as generic=
 as possible.
so I moved large part as generic.
And kept pci part in pci.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

