Return-Path: <virtio-dev-return-11541-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98F7DC678D5
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 16:42:30 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 760CE29FDC
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 16:42:29 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5CBA59866FC
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 16:42:29 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 4B17A9866F2; Wed,  8 Mar 2023 16:42:29 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 38BC99866F1;
	Wed,  8 Mar 2023 16:42:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H71RE1waBos4fKN3unx7/OCicOR59mOyUDP0rHZAku0ZStBmeOY0O9C/tmsERbxigUhBtMY/wAO33OazrXIMgWR2AsXkeIMoYBcHHxVyh4ylFS7hh977ALBWpONwBIfTkZaQ/+/Muv3XJOkLLBqAO5ZkXBor2jb158DNfPcqTGMM5cCyw28R3hkMrK4nY0iAlmPdObQkh27b0kzmBxwUFmkIf5tGc84wt9uEIpPBqizclQbRUos+E21BcNNIzLydp0IDGaLZMHz5uD/3vKx0/WLqEekPv64UxgbdTSq54O7iC0QzH42LRia4idIcf6IyEefj3U2Znb3b5HeXUxTjvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gR0TGxwli3qeeqAxDSy4nU7QNBVlJxKRIIw+Ez33uAs=;
 b=XPSW9fn2l3SVJyfrnGT97Q7B7ji05Vg/M2jo64gXX9IDlzNKCqavPliAn6gaOcxSmoYG1e35kxskPwkv4KQLGjWHXMAoabqdDFqK1+He1lHpmvDs8/Av9lfE5ZaM6kEeuo7vQyK8Ql8QLfuuLsL/XXL4E6S9dy5kCuaB2nSPqYX1PYcMVl4LStudtjagLWX0eTmwi6M7+cbV2lGQu/loa1MaUIapK3y6dj6rEwtu+cu58VYicsYemRvXePWqJ6Ih3upRgGfC8IlFDcRdPSGnLZEthBTss6hsQx69R3mO7x38H/G7b/jUKILlDyaMRRxKtG42Z5qQYdxn55dcne0RMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, David Edmondson
	<david.edmondson@oracle.com>
CC: Heng Qi <hengqi@linux.alibaba.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, Alvaro Karsz <alvaro.karsz@solid-run.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jason Wang <jasowang@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>
Thread-Topic: [virtio-comment] [PATCH v10] virtio-net: support the virtqueue
 coalescing moderation
Thread-Index: AQHZTEeWQwTFVtCRMEet8OSrJT5oDa7nXdkAgAcHigCAArsXsA==
Date: Wed, 8 Mar 2023 16:42:25 +0000
Message-ID:
 <PH0PR12MB5481A9D8A005A61139535CF7DCB49@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230301141027.59500-1-hengqi@linux.alibaba.com>
 <m2lekf1iq8.fsf@oracle.com> <20230306175558-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230306175558-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CY5PR12MB6323:EE_
x-ms-office365-filtering-correlation-id: fa8298c6-31ec-4a37-1572-08db1ff41941
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 C2BUNg862t3Y8gZT58h1O3oNKNXh3z5Vx2+b60YkyHFXz76+CdIvEECHkIVT9at321v090APFfeCJei8FzMproBOoZNvz2cXDS7NjVgxccRwIrH/SZSyMFRrg6P9D6VV3chUXLc0S0vl5LXpaiw9okVujmb1tHbRowH/Tqh3QgTo/TrUd1lXBboKlnnSzvmlSZ0udnqd383V2yz3REkHTIJ3RhVoySTYeaSq7qSSR5MUcjUSWim6WMT54TCQg54YCKOsyWreQotrFUkRZKiXjCql+WWinXf4dWU9+6AF2VOQgquVEukqB1uDymK+8eSp8W2XuxpAI0DQgrNCuOxpxA0bPF3d2ZLnem9PbiPJ1pTM1sxG+ihBUa/xLslLkHDb2H05JHwIWO9q+YejRoREIm0E2F9m9GUn4I6Bl+wJkxNf7/Dljm56uBqeEh45fh18T+W/BT8nkoizXy5UopV9reuGkB3hVqFbR1mk1eX2hh0PG1tYboJDBCPM4hjalnaZ0JZxvXu2PG9xpIeeENXgbwy0XSZY8hFgfXdScU2yHEXDIzeUbASnBtOApnopdzSSECcqqrRGxG1FUrODEMvVYZdhNVMzne5quByweiL0plGwg1p2MmXpQc5TilQboCJeZv2gcm8cPaP6dy/3BF+GwfmVonsi9vX2++LqjWQPQVy1DiR6iQyt4cV2KVKTJPrHLor+ef4qLmpnxpUu9+bitA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(39860400002)(136003)(396003)(346002)(376002)(451199018)(26005)(83380400001)(33656002)(54906003)(6506007)(478600001)(122000001)(316002)(38070700005)(55016003)(38100700002)(7696005)(5660300002)(9686003)(110136005)(186003)(41300700001)(4744005)(66476007)(66446008)(71200400001)(76116006)(66946007)(66556008)(8936002)(64756008)(2906002)(86362001)(8676002)(4326008)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?vZp/Rc4PaYVi3iat4r8WVLxrr2v0xJJo/Pf9AK9E6NKjMNGd4cCmiwJU8j3N?=
 =?us-ascii?Q?2KEnliw6HNG3UN0H2z9403Dax8nyGH1Gk65ahztr/RqYHwARXToF9UpqltnL?=
 =?us-ascii?Q?5ABrycCf19NeXMDP5IiQPTjZM1l3rH2BaFV4tGJhvB7mbFmNp3H44JIXd6Ws?=
 =?us-ascii?Q?9STzvyqgeVkRaunZSjxhmnxDLk2qg+Bz4R232djLA9Srb7AnDlK1enb3TOb4?=
 =?us-ascii?Q?ZKQo71eiVbME09MgdHUqRyxmFq0L9kQURpHnCGJCUVfEwO9OQSwODw391bqC?=
 =?us-ascii?Q?OeAcSiSwMS2K6qIiBZSS1pvVz2EZNB4c1JdmJqX9ztlPgmWvNoYkn4ti5zLF?=
 =?us-ascii?Q?NQy/sY9/qdetvaWASH91shvuWmxwM5nY7HySTZ5XlmDbNf5Fkd5SGR91We7T?=
 =?us-ascii?Q?rpBkn8T6ksxn7NQnz9srpF8TEX185sRcMPUNpbuEX+6ltAEAu2Z0PcHyXaQu?=
 =?us-ascii?Q?GeYriT1daPSfamx4BnuTJI66hOs/JtzarEzqchUgkMWxBcTtwN1+I/gHuhgp?=
 =?us-ascii?Q?nTH/k/ql6ntQgMyFLI0GPqXeTus9T3fmM9qRSyGGwXe3/DX8Zo5WtPiWGGdt?=
 =?us-ascii?Q?+BIcKKT6buiBqmK/T9qNwe36eJSgv3H/NOED95Qh2xmMbqRUu7mOvbqU+P7C?=
 =?us-ascii?Q?mWnRcSnwWrIQmg+WaJOhlxclD4QlVaAosiWLD76dQpc1DPDGiF7VCOucvWVn?=
 =?us-ascii?Q?VIZ2C+4Efl2fK+Qj5EJiKFRDmwxcqZtuFza3cvSUBNshy1MjQfY/mtXofcJB?=
 =?us-ascii?Q?UDoEvr4PUdwF7WaDHF2j6njSJ53FS0S6dXh78YhBnUiTGKxA7Cti+uExQx+u?=
 =?us-ascii?Q?OX3eYPgR0I2btUfpLd9XdTidUemb0zMN6NofLavXezpztqeYhMqapMxL1hyN?=
 =?us-ascii?Q?GvfN0FmqkyoUvZrtyxckCk9YHwmusIceLgMI7SPbsi9DNjw0As5KIQyoNm2G?=
 =?us-ascii?Q?PiT86o1r1HFjBWZPFh02GxrZL941kqOOYM2ItaMylBSz8lO+j3khk6VOMyuW?=
 =?us-ascii?Q?nPfYB+dsejLgN8GTy564D5FMoi6T5ilbfEK6PkA1iyeezTtKcQ8HNXf4XAE5?=
 =?us-ascii?Q?xfWF32xMgDAAhLm3GRdKVI+HRzjkT7TxmnCA2S4UfavFtBzQJilCKfBvoqeZ?=
 =?us-ascii?Q?yG1ohMW6I1PKpORiIPk4iZekDZLUOuIhWOZPUskbq6AAEHVDcAQlRB7qbTmX?=
 =?us-ascii?Q?JdJew0g6AEgtfPyvM0v3o3atjYpa7vAeE9s56Zt1gq/1AxVlvgGHiXAts10C?=
 =?us-ascii?Q?xd9pijMCjT0d/0FVHmMWbbGtCvBgMDnDg4UZlS7r7pR74ELt1HwdideFxgw3?=
 =?us-ascii?Q?Ot01V9HvugUF8pK934xEXe1Djlv+GKEoZhwpgfTkJ9kW0oEfCsRn+10QQkvK?=
 =?us-ascii?Q?Rg4IGa863+lMwsagE6HmV99Fllekm4UUCNVo5zNsNkP9vhiz/2B2Nf9NFZgY?=
 =?us-ascii?Q?r1b/tPcf1hwvWuVB9nODEdd7Xi46bLGqF2G+/qFVNVaO8i79z27CrtPRuEvN?=
 =?us-ascii?Q?dkXjnjKZsTDHnokqDvgNy/eVjm3QJx1IGCGqkd+/l5ubFh8OjqX3Dthf8RKM?=
 =?us-ascii?Q?TdYzvF/MTwhD03ER4Eo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa8298c6-31ec-4a37-1572-08db1ff41941
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2023 16:42:25.8609
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: thtjSAOCNZL3zIXvHyw+fX+Mckwqu9QW7D6Qsj7O5LdmIupVdLEIc6C1ZFqmJiKoUsteibOQ/Mo9EKHYT7ynwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6323
Subject: [virtio-dev] RE: [virtio-comment] [PATCH v10] virtio-net: support the virtqueue
 coalescing moderation


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Monday, March 6, 2023 5:57 PM
>=20
> On Thu, Mar 02, 2023 at 11:36:18AM +0000, David Edmondson wrote:
> > > +                                        for an enabled transmit/rece=
ive virtqueue whose
> number is \field{vqn}.
> >
> > Should this now be "whose index is \field{vqn}"?
>=20
> Ugh.  I guess we'll have to fix the number/index mess in the spec first. =
Parav
> you said you are looking into it?

Yes, I want to send v1 for " Rename queue index to queue number" series.
V1 will include,
=20
a. the vqn changes for net device rss and=20
b. other ccw changes that Cornelia requested.
c. extra note that you asked to add to mmio for referring the old naming co=
nvention

I guess we agree that it should be vqn.
Therefore, vq coalescing and aq series should progress with vqn terminology=
.
This way all 3 series can progress in parallel (aq, vq coalescing, current =
spec cleanup).

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

