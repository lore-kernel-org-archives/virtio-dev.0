Return-Path: <virtio-dev-return-11932-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B98AC76196
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 20:27:42 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 6A7792AC55
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 20:27:41 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 614CF98641D
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 20:27:41 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 4B0369843C6; Mon,  3 Apr 2023 20:27:41 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2A3DD9863E4;
	Mon,  3 Apr 2023 20:27:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FLVIcCzmR0pzzgyw8hEngq6wYHGdacYBcR2O/4YRQRAa8orStB7uhnd4InAUWxytQTQCChbOVkZFpJvG++Qx7WnFM1IZBPjoLAdrP/WxJaPMg63D2aMy4ki31gQqMRI2V1sTKQoNRELHDEvKMS3lhqr3jCRMHAwessLPa68lRV3u8LaLJvfGRgnjSGbQG35k/mJYkSzZEJQkrETUSUDh7wHTZOlxdiWv4ksPsvSFBAc5e58VvfuocF5mCYYqI6GeJeK5eN6qlqZm55wYsBEGjjzwLc40PBel5OrU/Im40hlh9LskUtMMCU6FWUupefOPSubnGAjBg1YjPdtVAQA1CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wsetv/y9AGsDeAxVOpZIBPg0proNZ64dvEm7DzUTSsU=;
 b=hg1RsNo14khcxSxI67NwVKTA0wvqJtwyh1FBT5XMZwJCy7sE/9rIRFUHQkrkPH/U08aNUmyqz/fgZPHBxUXfjp8wb2Z49a8Ny6x//fXk9kW8aVL4fw1jp/372HlgAwVsK1Mw4ScbLbpEyJRqB5o5/ty0tFeZWtgR2xbWs2EWMB4z7TgQbUzjKFiQRlPWi6R6Fzeps+pDgRItBU0FkIeYZvQ3G7MwkEIBOxByR/4HiK0NjLUCOcVkx1dVqgJTxLgHvKZs3EtH0806DUX+4K33pvVkSRpkfeSxdjjEb1cMIiISzjGlvaqqpzcLK2MTZ3b4G9C6i54jQrLnf02tmp7INA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
CC: "mst@redhat.com" <mst@redhat.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [virtio-comment] [PATCH 00/11] Introduce transitional mmr pci
 device
Thread-Index: AQHZY1tF5ObSeHDFk0eWHj0gIzL7fK8ZryCAgABed4D//+uJAIAAFP9w
Date: Mon, 3 Apr 2023 20:27:28 +0000
Message-ID:
 <PH0PR12MB54819A725015CC49952D3CC3DC929@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230330225834.506969-1-parav@nvidia.com>
 <20230403144523.GC302168@fedora>
 <46a0db06-f922-2a8a-acf0-cf7e453a2945@nvidia.com>
 <20230403191014.GA350467@fedora>
In-Reply-To: <20230403191014.GA350467@fedora>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|PH8PR12MB6698:EE_
x-ms-office365-filtering-correlation-id: 2f021e9f-d318-4650-89cc-08db3481d86b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 pUs0kJBSKFkNuhFnPJfmy7YllUPv8uw5ld5Vw23nnDFpW4HR1t4xFqwzXQNMY76xNTICLp84eJRH1pB9VCHZJm8fK4dJI1pi0fd1ncdv/xDr/6A623IlIn43QYXDg4AYY4X9XPVfE3FWaFPHQg6Ni+F5KZ7uDp36ThaT3a+uplj/5fdsoz1PXTJtc5WSESnAvWuaURDtlMZuR0GqoaJ8czK7tCFEwCYZExtH6qZVpjqRtDuvvnQTcwpx3c/krjSPTz29G3B93ab5/VSh7vNIuFa1OBUfBeSQqQrhv9ewyYj98ctJ1RlJL1wy5e/MiBCKV0siZnqD2dlkkolG7x4pRTTF+UhwMuyYpqlKu/DU0RQ5CchZiAf80gl26Stdoki3WAJ6Pv1exkfIq2r1u7SyR5LsLQmOawXdNdKAU+VRXMIqp+LOrHQ63cyNQ83dXBLghuwGdA2Q2UT6zjiowT5ODwOhUARy424lbtireVzgmipWUVsBjB/rk4xVClxg6nI/CLA+U5nsVvih4qh2/wPDzJvCWnL+mhh11GyuoYIK1V3Znfj41aa8tjUWTVlwswE0al07feNYbn3Ptrje8MqNt2GNy+4QOVi9S1RWByMYPR5KkWOy5OQAtmdFARkuPWWL
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(376002)(136003)(396003)(366004)(451199021)(8936002)(8676002)(66446008)(64756008)(66946007)(5660300002)(66556008)(76116006)(66476007)(4326008)(55016003)(107886003)(186003)(54906003)(71200400001)(52536014)(41300700001)(6916009)(38100700002)(33656002)(4744005)(2906002)(7696005)(316002)(122000001)(38070700005)(478600001)(86362001)(83380400001)(26005)(6506007)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?cFRrsJj0oHbxKUSQn6Em0ZlWgXz5XSouJlLWn/u7CmDesb8c38eJY4mBv11X?=
 =?us-ascii?Q?0CdPxzefk3s6rJbdDTVbXSwmBGAGVItekW37qLpgHAKLVvMg6tyiZPRF1Cxe?=
 =?us-ascii?Q?80HinrRINlVC1y8WDTiWzQ64Hnq8SvL9ZSnA7ssA64uivMQtUU0uu1Gf1cwU?=
 =?us-ascii?Q?3ohlSICWq9rU4TLYrG0NaH4qq/MErmDZy69+yxEem9jaFPx1ZL7Gl8cwX7cU?=
 =?us-ascii?Q?dDRbC/QpEqyOgJiTB9N+M/gcw7iVUTPU6bcu+fk6k+sUCxnZmCLmUzRPs+Vk?=
 =?us-ascii?Q?md1I7OXseYXHqG0SGS9psW0CNMYzkjULlWaNQV5BRzfoen7ryz7MGlzpF/Xn?=
 =?us-ascii?Q?HvNUXOXUVByeHszaXU/btk/oOMmXWlY0qQ4Cakp7ZDovM7FmAs/EqgIDKAA1?=
 =?us-ascii?Q?+n1X3R3cwG5MDAtwqoXiKOSjvF9EWLL9lKPn9BiuCJmD1aAzPhqmZKLtS/Ke?=
 =?us-ascii?Q?sb9d1t5D6824Zcio7HvV8u9xWKTDgipKBqpsVkmkL/oHUs9zBOz1/LLTbAup?=
 =?us-ascii?Q?UvAaTkZ4mG8g9lO9KutKZOBTQlaoNxJoEyU/RiNX8Wr7jUmzQ4qfGBclvGSX?=
 =?us-ascii?Q?a3IqUz7+0buMxc98dqn+X7fWO8ArimOPK6/WEv6D2ylfCBSXMhY3Kzt6dCxF?=
 =?us-ascii?Q?zmF8WNXAWPQEr9ON5b0MO1q+YLE7t2zRmiR55FvQdvRyAaIAhAYSsTpKABHA?=
 =?us-ascii?Q?/DtXb4bD1Mqd5C8zdSdtp5bMq6hoal1orPYyo9jJaUrjSWhcOD8+T0B7DxMl?=
 =?us-ascii?Q?RaENlwWSM0S0H1aURSd1Pl82Q/HU4AoQj1CKmVSws9HytFF0K+tsyKn7PsPT?=
 =?us-ascii?Q?axu+mnKbniqMXou/NZJBGTE0fPnBbAxZI0tC69HT+lhSEbpDZhXSEUFgA/SS?=
 =?us-ascii?Q?Rhk+B0icP563uC15H9EhEvXCQPZKnvEBYUNyAtfrkp9hYrN4E5F4VzpZWh+q?=
 =?us-ascii?Q?VujVsJQwrudBmGMW2jRnxzZFmLK1izuYMzCo8n4aioL0qmEwdO4TqULH/xJ+?=
 =?us-ascii?Q?J4McwgEaAIrCiR3b25hN4mKdyS1Yy2UhazdVr8kIS8+sXbHdiSCeJ3+sDZz7?=
 =?us-ascii?Q?8Bzkwtyt6611Di8CPW5BRdi7CmeYGYvtCbhk1dcCDmJMegZQ5hi4q884umIG?=
 =?us-ascii?Q?RYrUpw/hGbOC0x0mu1MjxG92FE3mO8JiTac6UX3uRpgsxrHXxXHXikNxFpVg?=
 =?us-ascii?Q?Kirqywt1DGjVz91PubortA+9OzJ1i6DKdENETWUHZz6icziK4r1mJPSE3Jl1?=
 =?us-ascii?Q?u2zVdw2ByHEIJ6QdZztxjDinjFsGqiiQgg3+GGehkId3gePPMqO/0lWkwyZL?=
 =?us-ascii?Q?ZjO9xw1GnW26tqVfnMI0bDI9C0Ss/Loy1rhAcuKkM20fi/iQUg+KU0SMKDUa?=
 =?us-ascii?Q?m+Goj/PN2gGZaxvwyCsWmGF3H3XHPEho30VZiNwzveIS3YMvuRSVxucdJOcR?=
 =?us-ascii?Q?xKUH4Pv8ezKEWG7gnOplbMKH0NRPUmLYYbUTbLypW7EkD9CFeatvJ5VkLH3P?=
 =?us-ascii?Q?jr3hhENxoCDtdW2J7fStXfofxJlG5yOnGrEvczxKTQrWkZEAqDY3D7plD+ko?=
 =?us-ascii?Q?KxIvIX2PMw5eYDeKysY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f021e9f-d318-4650-89cc-08db3481d86b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2023 20:27:28.9083
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UPT56uiZCzaDHp8ZuYwZ5ZJS05F7jSMtNxKmwlJKBeYt0Ee6ozoUETl2brbCeqTYak635yKdMCrB7Tujp24dPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6698
Subject: [virtio-dev] RE: [virtio-comment] [PATCH 00/11] Introduce transitional mmr pci
 device


> From: Stefan Hajnoczi <stefanha@redhat.com>
> Sent: Monday, April 3, 2023 3:10 PM


> Maybe call it "Memory-mapped Transitional"? That name would be easier to
> understand.
>
Sounds fine to me.
=20
> > > Modern devices were added to Linux in 2014 and support SR-IOV.
> >
> > > Why is it
> > > important to support Transitional (which really means Legacy
> > > devices, otherwise Modern devices would be sufficient)?
> > >
> > To support guest VMs which only understand legacy devices and
> > unfortunately they are still in much wider use by the users.
>=20
> I wonder which guest software without Modern VIRTIO support will still be
> supported by the time Transitional MMR software and hardware becomes
> available. Are you aiming for particular guest software versions?

Transitional MMR hardware is available almost now.
Transitional MMR software is also WIP to be available as soon as we ratify =
the spec via tvq or via mmr or both.
This will be support the guest sw version such as 2.6.32.754 kernel.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

