Return-Path: <virtio-dev-return-12903-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CB4AC7EE25
	for <virtio-dev@archiver.kernel.org>; Thu,  8 Jun 2023 19:05:33 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id ABBD2157EF0
	for <virtio-dev@archiver.kernel.org>; Thu,  8 Jun 2023 19:05:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5A55A98668D
	for <virtio-dev@archiver.kernel.org>; Thu,  8 Jun 2023 19:05:32 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id C1132986681; Thu,  8 Jun 2023 19:05:31 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 49C50986682;
	Thu,  8 Jun 2023 19:04:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WBYOX6BUr+9mOghbVd8AXpodYN19XdGxse2oN9rcPTi768h+aaR4FV0TNCNxA7wxsN6pJWx96UnqUrxy660fda3TBa+Jb1M2OPGb2Ccqdn7+B9c12owZIHpNRO9um+ZEtiDLrQ742qpN+sVGQJelb2V3Xu7n7H5hjLvk57NKHN1hdAbO/JFjSv/TqBE5CYfRvEguMkmfqF7r5szcuR/jL6/qXkLQzmDrntL1GBaTkdNxCjLb76oCUTwtku0yPi77tr8FDOYOAi4DLBUlxTU+yL3i146O7EfDZ0R2Lx8HnQB0EMnPIjHl7dPJfSTP1Zv8rhY9THhigLKKvdrpUhSiew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3akLL8H8cIG23U/E1fVjvrY51RAVmceyE/DGMWHzR8I=;
 b=YlrzLJECXEsstCcksys0dzbh8g5+X0dMW8lm3DgCoBZXplS9szRZg55b67vlqEIzxW8NVa/0mEipwr/9VcbQaooLEbigzWPZ4ice5Rcr1JTRr/nhbGgPwPTw6iy1wOIDWsz8nwmPuW3XrPnGPEkjJsaxxFS5ISJ0ruA7itEqX9jUnpqvFsGbDe1PAbGL6BaoXBVkJxr9V87FA84S9Fc6tYPCpU/kLlOjneaJmaBHtMaEf5tkgIooU+3AyLOd6Z1+XSiThNZTb1VDUfcHthW8WhGRwpBWO9AEB4HCLtqjBCKl44FHQtiSCOQjz5cFE3KfyRxxQsjCEQmtDoJ8rnXwOQ==
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
Thread-Topic: [PATCH v3 2/3] transport-pci: Introduce legacy registers access
 commands
Thread-Index: AQHZlZHrjhTPPTQ0ZUaNTBTq19TtJ6+BRI4AgAAFc+CAAAHqgIAAAOtg
Date: Thu, 8 Jun 2023 19:04:14 +0000
Message-ID:
 <PH0PR12MB5481F2AE3CB48A425FBBF6B3DC50A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230602203604.627661-1-parav@nvidia.com>
 <20230602203604.627661-3-parav@nvidia.com>
 <20230608143135-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54818BA9BDC5EAF4FA8388E4DC50A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230608145944-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230608145944-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|LV3PR12MB9235:EE_
x-ms-office365-filtering-correlation-id: 46ed6cd7-f24f-405b-1bc8-08db685326f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 C+8v2tK0jjr+vBFVCCpv8H6kwIZLktUdUjhDy9yg8YxFtBrjUwBI1uNWy/6GIC4mb46HAzgSZGHZcJRxiGsCc2VDgAIQ4u6rRM6cWotc7Nq0pnj8gMPesqVeL4Oj/XJdnWp0G51zhMzfQeYpJ9x7hIeW+zK4YFdU3iCDWDP1sAySpN4A3axta6nCx37uK9nTiGlG3SK9LoKgNSAu2aLYVg/sLRBkrkCzx0CsWKDEMZAhoklT17zjf1O7hqcSMjR+i/0rYgVlUQnxExliyM69oBvoQhabLxSTwwBdVr613jShZWDp3mFWg1xJGIljnvP4aloP5WroXLcfShLXaKYTg9ywLXy2pXKTFhDdy8Pf1050OSaHiE5CzNN27oqFvzE10ut65VOzNaBPrp5GVicB7KEe//lMOUZQXrlilfwDxWRx39QLNn83fawGVUlO2xa+53plIC570w0Jme0WnqtaMNR8Gzb0vAmkmzPtWxfD3RL+QQctiGIvNP+Y/HALdatFz3spxUZhGIfVg4th2YYBGQm2E2PoHxABCOU+m+f+MqF3KgiD5pp0kZAZnZCATf3xg3dBY6SqX/tQ2guNhXAI873nYFsWupP7rgq64DFhwmzlb3REr6/XQGRm71bPjC8o
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(136003)(346002)(376002)(396003)(451199021)(2906002)(38070700005)(7696005)(71200400001)(9686003)(26005)(55016003)(107886003)(83380400001)(6506007)(33656002)(86362001)(186003)(38100700002)(122000001)(54906003)(5660300002)(52536014)(478600001)(316002)(41300700001)(4326008)(8936002)(66476007)(76116006)(64756008)(6916009)(8676002)(66446008)(66946007)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?NrnxBdCLIgVoBZSKJTtukPihuGMVeC4axBe5UCKgPO3NvQ5meRbDDG25D8M5?=
 =?us-ascii?Q?kFkWAqfmU5U3lslM65XluCfu9xzwJSJ3JwHJ+ex0om0iB2YDSLSST0SI8Gd4?=
 =?us-ascii?Q?1ylV16zf4xRpcK66QCp8TPQd+zGvikShD/vejVbANSdWOvOGjXm4YF7jtSOJ?=
 =?us-ascii?Q?HHlM6B9JT55b8rWAlL+b6kKBzrISKkQFRhCw78x15LPfxgmcPhQVCv8kJinQ?=
 =?us-ascii?Q?KIfJMsBmxYkXFtFNPwIZ8e/0UvKchtqaMZQZjRzkcW2rY0JGngIiP33dNICq?=
 =?us-ascii?Q?2UeJilb6MvJcCzDQGizMZbqjfpGXC7RP5AFnmX+B7mx87XouZuEJUB52DSgx?=
 =?us-ascii?Q?jZCkOfW7Qld8OaxAOewaiG96XL80hjuBCLFFwJYfefZtb13c79YKoWpveDFQ?=
 =?us-ascii?Q?82ArN63Vw45foUdujDxcbV6B2Yq+bKL/dysJ2WO7CpXLkaKsoJjcVWWMJj12?=
 =?us-ascii?Q?UYnRu78D7llUJwYnQT1g4J8urIQwgWHE9Sz/PtJZsw6Xl64WChZBMZ3/VHuF?=
 =?us-ascii?Q?BwesBRjOnIMtBTATRpuIBRTPhHPCaLcUu7lC3OZgsTtYLa0SSUMP2dInKqWb?=
 =?us-ascii?Q?4vedN1FohU+GtPndJ4lhLlwazK8Sz+tsWmETEes0Ik52209EfEYN/a/NM7t3?=
 =?us-ascii?Q?FJHFiezIhZHgWESuPL1kzi3xXmPmyAGJAIrLC0bDjJQkreame4TEiDLAq2nO?=
 =?us-ascii?Q?U0+MWnU2QX/JcCuga9SYCHL5GcCSxXjv5NKHftNLnXBj8rTgdp1mKbx/iYjw?=
 =?us-ascii?Q?P5A6UKXem8ZbziGuQ+PYNno86y/V0VvqTA5DYzZzBU+ZtUr1Xjv7W11VUrq+?=
 =?us-ascii?Q?6YJM/Hx4CwDNkom0iueGh0ouiCK/GdV5gRt6I0dYJJyGXXkibeupMAWFX3yo?=
 =?us-ascii?Q?ewWzb5596lyD3NxH5uZ5aYMTpMWyskDzdHRxTSfV9PYL/eD+qqLSJht8zNMw?=
 =?us-ascii?Q?w9n+mXDLVHUy5rHalse0ILBsLw12wrq1hJ5lbI3pNMvVS/wZM2JAZDp/egR4?=
 =?us-ascii?Q?ZoKXeYBDizJ1qG40wv67GtsHd5nWNtnaAwmEvknIloFc+PXfmqh4kVgsjhyT?=
 =?us-ascii?Q?7Dl7z32jKpLCJwIpF/L98pPOhBq72gNiOsAGySGwXdZwGkBYD+Ur1zmzf5o9?=
 =?us-ascii?Q?asMSWSosw6rAWHc9iOIYuv79o4QS5K/bbC2R7AUctzsoy9i9E5kx8abTFV8i?=
 =?us-ascii?Q?sBx6XiSL2mXFISH6LyrtfG9sJaHi8540fTV2Zha7u/hzruMUiEte2urOPSfM?=
 =?us-ascii?Q?lKvVUpvCQx5j537/Lcs0b3zhtcTY0Ji6ixA3CRYbSW+2KFNPpaRY/1bHGKX6?=
 =?us-ascii?Q?Kob/DqsMyxxinNSt4URNyYeVK0OHCLWpc8j+xgIjLoRUrzENwDHPTa6pQ+v5?=
 =?us-ascii?Q?x5SXLMRVt1RX/bZtPPl3BzcTcOssm2Y4ySCkHPlADP1ru7iW3Lzsa2uHnJKT?=
 =?us-ascii?Q?nGUOK2dSWYDQJHv6oSgnWrYrJlBexM5l0O+mdgmJ/6pKsw2Zz7gduYeeHpzh?=
 =?us-ascii?Q?25m7F9gPCewJ8DOGLDBeuv2pQGTZ680o0iwdlLIQEkuxM3bS5Cx05rJk0W3Z?=
 =?us-ascii?Q?qsAEirHOEcI9Pt5OrQ0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46ed6cd7-f24f-405b-1bc8-08db685326f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2023 19:04:14.7618
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kqxEyoguMLAQH6q0cINPrsT2K6m+m/2CbIxctzQ9PpR5slQCpCdaMejhy1FSw//msvXGmer5V9EdyI/fPMeU4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9235
Subject: [virtio-dev] RE: [PATCH v3 2/3] transport-pci: Introduce legacy registers access
 commands


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Thursday, June 8, 2023 3:01 PM
>=20
> On Thu, Jun 08, 2023 at 06:55:29PM +0000, Parav Pandit wrote:
> >
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: Thursday, June 8, 2023 2:34 PM
> >
> > > > +0x0003 & VIRTIO_ADMIN_CMD_LCC_REG_READ & Read legacy
> common
> > > configuration registers of a member device    \\
> > > > +\hline
> > > > +0x0004 & VIRTIO_ADMIN_CMD_LD_REG_WRITE & Write legacy device
> > > registers of a member device    \\
> > > > +\hline
> > > > +0x0005 & VIRTIO_ADMIN_CMD_LD_REG_READ & Read legacy device
> > > registers of a member device    \\
> > > > +\hline
> > > > +0x0006 & VIRTIO_ADMIN_CMD_LQ_NOTIFY_QUERY & Read the queue
> > > > +notification offset for legacy interface \\ \hline
> > >
> > > Could you avoid such drastic abbreviation in command names?
> > > Standard things like CMD,CFG are ok, but LCC/LD will not ring any
> > > bells for anyone, except maybe confusingly make one think of "C
> > > Compiler" and "Link eDitor".
> > > Let's just LEGACY_COMMON_CFG/LEGACY_DEVICE_CFG?
> > >
> > It looked too long before abbreviating it.
> > Will change.
> >
> > VIRTIO_ADMIN_CMD_LEGACY_COMMON_REG_READ
> > VIRTIO_ADMIN_CMD_LEGACY_DEV_REG_READ
>=20
> I think you can drop _REG_ that does not really add any value and does no=
t
> match anything in the spec.  _CFG_ would make sense spec calls this commo=
n
> configuration and device configuration.

Ok.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

