Return-Path: <virtio-dev-return-12627-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B327C77B7C
	for <virtio-dev@archiver.kernel.org>; Wed, 10 May 2023 14:45:36 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 8DE1E6846B
	for <virtio-dev@archiver.kernel.org>; Wed, 10 May 2023 14:45:35 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7EC629866E2
	for <virtio-dev@archiver.kernel.org>; Wed, 10 May 2023 14:45:35 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 73309986590; Wed, 10 May 2023 14:45:35 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 52858986591;
	Wed, 10 May 2023 14:45:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=msA812bs9yFeX+mTyHQelA2pVjQenW2aj89TeU8hOT5GTnP8N5DScvZdk3A/vkAfZ1HWobhWYFJl1nr3FPthTMOvHvgWr5ZvR7D4PYeKPjtuegImWPt4+7nAfTAjY41QduGFKq/5AcL2bh4paAbrAuHjg6zhk3BMHHnUDJzD50ywn161DMQuAjilOhVytsYmSnc/ZgBup2yTW3uBCJZWz80x1M87IsWn6lwIlx7AxVKs4aX2I8vKrVKmlAuO1/DXjMzlY5WavIjLY/hiTiJAxhYwPaFdWfH88JtGNaaQatAQIVHDzm7QoN7nMsGee1LU8gARDnagvetbkczV4EG3ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cnZ4yaMExx6GflwltDsABGtRiHHph1HQ/fSe0jPG8+Q=;
 b=RJEKsvvD6uHaf11gcHtabLxdXTC+pOsO+iO3s2kug8lZpqts/6j2mhEecfgI8I4ygTo/vS2j1hBW7lIcCqL9qWbxgwKnTscWJ2exxh+g21ymdWMVMr0OWS0SzvNMvQ9bceHvsHjLsNDjBtTZaOXjp3GUfEw6Hbai7R+FOatZngUHuAKnhJlQTvTZNDMclYFCvNMeOOPdI0yyd0Nx1SB40c4PES8si5apI2qkFGghnOrQo2OeDCF1GTlX3dbnYwh5DvrHN0bmZWzPFcKuqOCVd/2zMHW5fvArczaGgBXg2/9J6tRx0Gue+uobZHaUZ8iYUPJO+vYd1F+QW+UpCwXIrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Date: Wed, 10 May 2023 16:45:22 +0200
From: Jiri Pirko <jiri@nvidia.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"sgarzare@redhat.com" <sgarzare@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>,
	"nrupal.jani@intel.com" <nrupal.jani@intel.com>,
	"Piotr.Uminski@intel.com" <Piotr.Uminski@intel.com>,
	"hang.yuan@intel.com" <hang.yuan@intel.com>,
	"virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>,
	Zhu Lingshan <lingshan.zhu@intel.com>,
	"pasic@linux.ibm.com" <pasic@linux.ibm.com>,
	Shahaf Shuler <shahafs@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <ZFuuAuuQz1u1AA6L@nanopsycho>
References: <cover.1683301091.git.mst@redhat.com>
 <ZFuqesg6YUSJi4dd@nanopsycho>
 <PH0PR12MB54814BF87CB79304EAAADC79DC779@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR12MB54814BF87CB79304EAAADC79DC779@PH0PR12MB5481.namprd12.prod.outlook.com>
X-ClientProxiedBy: FR2P281CA0013.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::23) To MN0PR12MB5979.namprd12.prod.outlook.com
 (2603:10b6:208:37e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5979:EE_|DS0PR12MB6461:EE_
X-MS-Office365-Filtering-Correlation-Id: 83f6c4ad-3ad4-4f5c-ed0b-08db516531a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ynb0BKgzrmVGGU4NkRuypz3Pf9N/5mrRLRIpzrh0he07LZT5nSuUa66ls8iypXj8van/Hys9jHfu4S6JDwLwOUApuCaGAj4dpsVKc+1pte36BOq3wg/qBhee26wW+o1uezQPIxbb7rtq7/BpyPbZIsUqf2ijTAhl2KE0pAbOTx/pHhAm5pIKfKc9n+tbzBu6i2SxuY8Om9Wxs0SrxWSPiyV6zzZwLLyRQ178HEMES1sEXuc726t3WSNkC9hpeDJGXR1YAPj/xTUnR8mFHwlLgbmmKGn2dSAZ8JcnBg29XY41lbEzJ4lw5rYuwmNtCoxbtnfZQviC4o581g397pXNNnScBKG+eJYfhWAl2JINYrQ3AhyXMzCl9C1lWMmLdIu4ibaNOcpzD81ZZ2w85Rp/aGFCAhf+mNCcRRCFXIJWPTcAg4PplhX0wPYvWgSLEUYDGG0Pqs43RAs5RhFEUy4/ap3PsjmAwxxN98fPZUA1WLjOmchF7gsoeGTxqmv0I4MsK8p/Z0D+APXjIse6NuKbh7qT/jlNEjAKpET8E76oGOn4TDcw6NufR2AIL35WVdZz58Rmex4xUrReEoSqBtOWKlDbsPrIpX7bQbJkLZcOi9U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5979.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(136003)(366004)(376002)(346002)(39860400002)(396003)(451199021)(478600001)(66946007)(6486002)(4326008)(66476007)(66556008)(6636002)(54906003)(6666004)(316002)(86362001)(107886003)(26005)(6512007)(9686003)(6506007)(33716001)(8936002)(6862004)(2906002)(5660300002)(186003)(41300700001)(7416002)(4744005)(8676002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G39JGIWlgyBBTBcIhYjA/V4ETdbS6N6L9rlNr6eu/onnHjcgxBDm4Nw8tw3b?=
 =?us-ascii?Q?Czg3NtN6JZUfh4yFyTDynCtoiAcEZPOHfbFZfIsqdiUY9i06r2iRdN4nT4z5?=
 =?us-ascii?Q?CDxryIgMsI8Ctk9UQIPWTqivr1KV0LRnno2buUsyFFKJPUbkfKAsqOjZ4aSn?=
 =?us-ascii?Q?WCNYu/EqxMBpl4LC317HmcaRpEQGseznIhe5Mqvt2ff8mJ6pvD3Cvc00ZwAV?=
 =?us-ascii?Q?zyFKir94G9t8zhyqo4kVp3g+6ANz7BLi+d5MWgS0vrIGe5l/xmeagBx+Fe7A?=
 =?us-ascii?Q?NQyMU3QOmwlhgABAhWbZ3sR90wnCx3NKAvwymvCMxU/PGF5AqUVBhfVSxPPJ?=
 =?us-ascii?Q?oIjPx7eb6NaRhAo30KQB8rhIqNhA1PSBdAoiAGzPF0NH/bGfyPWw3aeCwHKI?=
 =?us-ascii?Q?mr1G97os66sU2Ex5H5Nq4P4JpHACFH5PPZ/sYK+3VPFsUBc/tC1ftdIRrzks?=
 =?us-ascii?Q?ffTdyVluadPTDbyceuLiiRzoKxxcIwsltKNVcTz9+nAB09VIXNVcPPYhzR/Y?=
 =?us-ascii?Q?l7knK604N6Thdx1L5iF4aJZo+PTyA7qWUHDwyOJkIFjVquxWKhqv4DBaQgiG?=
 =?us-ascii?Q?dNOI+L3TYPvtoShh24JqJW0LQizDDzkqyolQY3jfeg6wQWI2AQkRMy4ZKAVz?=
 =?us-ascii?Q?hX+ls6cFLAzCulYfE8ckUGmI6Lw12L0d1QMxfJm058EEE9y/lB2rNJDA2Y01?=
 =?us-ascii?Q?u5L04Sx19qw9H4+WYOBGitZPzUnred3g57wRXw5jKSGEo0BeKtsurNW4vm+Z?=
 =?us-ascii?Q?1fzSdtUd78ODH29aHzN+ARepCAGWi4TAJ4BNBjLnKy6OEtR+8KXv78+yLprO?=
 =?us-ascii?Q?TgBE5qb7LAPu060AqfIreww9qr9FNt4AAZ9/3FmzEJgCKUa7NJtnivYsLzq5?=
 =?us-ascii?Q?NxpKl40tmbB1ncuxzh1pphL2ylbXVyVeQJ2J3N94F48OpfJQkZ0Rg2l7hQks?=
 =?us-ascii?Q?tZ0swRHKuW8DWNYk/STetiq1lEM2HQs0h4x54rxNhcLMG9tSzoBV5kj8c4fj?=
 =?us-ascii?Q?R3Mzgo5RJY/GquXPu2A39eIfkepHFxLRAJ+ilxCeEZlkzu1OLJX5blevE/fd?=
 =?us-ascii?Q?gKq5X7AIQykcaCeMdNvhRblJyUmgaLGQfdB40DAeTry/xiBCW0EmTSqenNcC?=
 =?us-ascii?Q?m6eNtP8KZWNyun0A4HilI3NybhONeozIYnWQPVIkk6qbyLxQzqOm9aytLuj7?=
 =?us-ascii?Q?Ls4Jq6IVvyRm/e+GI3JLP1/qyQf+1HqemR/lZmRqh2C5FXDxFP9RXbKCWaBS?=
 =?us-ascii?Q?VDQ/cHhKjPU3Mgm6f+Cvee45YIsWQZaEToIL2fBJ+XXZNKIJdYQ49crN6mtI?=
 =?us-ascii?Q?/NlGJ/Fhj4srGX9O4Lx4531wVvEVFxPCzwC94/Ygr8rBWv4RXc6nn+6kngO3?=
 =?us-ascii?Q?vZKcJ2ag7FD71Ft4dQQQphR0hSlijgNi9Yvu7FBgbwbu8ZArcHGfdDF11lso?=
 =?us-ascii?Q?b9sI7DGf6HOkOaKO0Ubs1SjSODa3ln0TffwbcQNHgy7FaEEJNAyHtm+CgJ9E?=
 =?us-ascii?Q?LUIYE3ncbMWmA1sypFj3CoULVMMxbeO9DUhzdgnTJ43ZJKvf0/+R8eNNQvQS?=
 =?us-ascii?Q?SxLQD4A2HgcpyEEPSU6Q3H7nTl5Wqv8PMc5OTVTU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83f6c4ad-3ad4-4f5c-ed0b-08db516531a8
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5979.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 14:45:27.1631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DU6BrQt21KBDlAOZ5i2vde5pMYj4kg+d2eTg4262OIPeFgkmTRhSU52R0CNhzimY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6461
Subject: [virtio-dev] Re: [PATCH v13 00/10] Introduce device group and device management

Wed, May 10, 2023 at 04:33:52PM CEST, parav@nvidia.com wrote:
>
>> From: Jiri Pirko <jiri@nvidia.com>
>> Sent: Wednesday, May 10, 2023 10:30 AM
>
>> 
>> Michael, not sure if it is problem of this patchset or on my side but makepdf
>> fails to build this. With master branch, works fine.
>
>This patch fixes it.
>https://lore.kernel.org/virtio-comment/20230505163712.589460-1-parav@nvidia.com/
>
>You can use b4 now to get this patch.

Indeed, that helped. Thanks!

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

