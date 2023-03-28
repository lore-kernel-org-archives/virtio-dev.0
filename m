Return-Path: <virtio-dev-return-11809-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E6ACC761AF
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Mar 2023 13:53:35 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 434E176074
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Mar 2023 13:53:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2A7C6986466
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Mar 2023 13:53:34 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 182D998637D; Tue, 28 Mar 2023 13:53:34 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 03F0D98638E;
	Tue, 28 Mar 2023 13:53:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e44SLadMfwy8Q/7lvmzLL7ara064pJwBwj7qo744ZabczY51jNaFKQ29jz7XYIyEKS2qcTNdFlVEtpRQ1Hr+ewsJwb6sYRBj4k/VRIL6ke5M5+mgcCZutPNn2KiBMURNPeGkBXp7wlk0PWKkxpbIiJNGHLPQPi0KZuohJGEJtTa/tk10mcY8lF+XdDCXJKOSSk31ypQsUl1ZB4Zgirn1+sv4Z6XFv1yipFkate+2/D/+owwd3RlTxQI+V+TNqYE9v6mmIP4x1aF3E4/kFQO3RcAX14ypH2pU3FG9oL6fkPGq/DlLhujkxpc5+qF3l9pIx2bjT8s52kpDiqErmzAebA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w0NMebbiHJv6rvxablVx1sa9s9c/dBeuC+s0im2lzFs=;
 b=S+/T+F0lAb1RBwuTqFzyH2NVM+aYd+3w8OgabUTnG3Oa4sf9YbfGEjwFoxfYBb/zjLipvfqME8Mt7YztCtSFRMVLbHXM+k9O3G9FMn8dtS4h9TMfamFAg4BuwB+1R8Nmu5+jbvXD26RiILqu1/DVWIWhttW2FXCKNSXdrT4pgx1FC8GKFiMDXNRjMtPe1nwH45hXgZ3/VQV2CXAAzNjlRmpwPSOq561riaYUm0zPtJYnWRVnZNMiUQJ0bBnQtaW/CiW1BuiRlG6SO9D294o7xKaVnZzRjX9gfIj/EoGGLDGCvuNKulDrAoQf/BNDoZ2nEeDuH+P5HPcml5zq7t7PAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
From: David Edmondson <david.edmondson@oracle.com>
To: Parav Pandit <parav@nvidia.com>, mst@redhat.com,
        virtio-dev@lists.oasis-open.org, pasic@linux.ibm.com,
        cohuck@redhat.com
Cc: sgarzare@redhat.com, virtio-comment@lists.oasis-open.org,
        shahafs@nvidia.com, Parav Pandit <parav@nvidia.com>
In-Reply-To: <20230327235936.414196-1-parav@nvidia.com>
References: <20230327235936.414196-1-parav@nvidia.com>
Date: Tue, 28 Mar 2023 14:53:05 +0100
Message-ID: <m2fs9pc79a.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0420.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18b::11) To DS7PR10MB4926.namprd10.prod.outlook.com
 (2603:10b6:5:3ac::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB4926:EE_|DM6PR10MB4156:EE_
X-MS-Office365-Filtering-Correlation-Id: 7527f43f-dc49-449c-b9a2-08db2f93c428
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	10/D4C6inEjKpz+mJPASsmYIcccj4rtdNFMn+RN1d2c0bgjjdt/oDAS31ZBeHEMAU/VVwc7MbLqfVFhY23QetyWUgPefa6wSmvWePQSecTZHbtltpjhoLLqoF9d2uxk0eEQpb1Rfnd+SLuBBsFVJ6ekpSLe/IFxoSYbI7jFgFkRPUnJ3P5FfaDKGX56KIht5tAHXxO77wCRLyXPRKbiHJdPw1Yejg/vsmObWM86VouJ5y0tP/WrvARiTM4MRby43lGoz4m67qrIZVUNdPoHB6w8wFk0ZTM6+QtceIM3/Z89ILPoF13EJ7tRkjZLmgzZOfrJsKEDqmTQfeLMb2Wjdmo3frACqlDpVwReQ0S2G54wFVooc6uHnxFXcvolAQVtSMXMZxQexlM18VPekp3DyEec8lz1OvpJOzH18ycrAnXLnRa4BWsc11uVRPQaal0lKZjVW/0tq1PyqV0i3P1Si4yNVYQCa/vp7VS66VerK1/+J7MUgYI9jjmGATz/SrACFxENde4QEacLIZFtrpITiFmCA9py8USTILQD60nYdqpw=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4926.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(136003)(396003)(39860400002)(376002)(451199021)(186003)(6486002)(966005)(6506007)(316002)(6512007)(8676002)(4326008)(66476007)(66946007)(66556008)(66899021)(2616005)(478600001)(6666004)(26005)(41300700001)(5660300002)(8936002)(44832011)(2906002)(83380400001)(86362001)(38100700002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?yXsPLk615xGEnjXmYDYPdqsI4i0Agky1ICErEoqmmEXYumBcyCtmopE/Apij?=
 =?us-ascii?Q?R93JpAnJRVzb3kW4DQSnCISdfzIw++q06yXMyENspa4tpqxEIsathIOFIUUS?=
 =?us-ascii?Q?ESWGCIpu93kP1cjxykcGkiNpVh4mqVWH+hjFoTiXCZOOSdDPHMH3L95qldmg?=
 =?us-ascii?Q?QXi7ScrvajQWAORbi/4kFJ5ua0BvFkt6wyLBqwdnDHRX2XsY59mPUekqL9wl?=
 =?us-ascii?Q?Kh2cbIIknIB+PxZFdwwaO67yreDTd3MW0Fkv7jafb4VE3EOTsu2LZztri28w?=
 =?us-ascii?Q?t0TKztuNnYtC8OsJU7V0WjrnNQFa3/Nl2IyYXY1SHaSW/deiDSYB8LtJRZwv?=
 =?us-ascii?Q?VwH/qKx8wACsJeFpgjvBCe+WXMIb/R7jd+5jRTexlyX1u+tGyBk3FhkDEmcP?=
 =?us-ascii?Q?rCuiyFKCS9wDWEF7l2WG6U/HatMqQyUx+jA42DjJcxJtGvFgixAR1RApkHZu?=
 =?us-ascii?Q?2Y03d+TVU9JR1vfCJyjQfDbCLLaMD7JLpZqMh5mIjLcrgAG2QV0d16weq3Si?=
 =?us-ascii?Q?Vy9x5hbg131UGRjXx4NS7f2SBMEKPQmMVyODk9kzyEq03ZweUqgdWw9wYCi+?=
 =?us-ascii?Q?hjpTqP+Egzxe0dRS946witM5vgPoXaDgspHzjatXumH8EgmBrV0ADxbmI6Ul?=
 =?us-ascii?Q?D4iUgZcbtdXxl8u1lvsrLyyy8mCn83kQCWAQpie/k6tXJGY/ZiDvs/lqgFwc?=
 =?us-ascii?Q?pyO49Hdz8QASPzWTyVt5G56xn7pEkGLcyX1yfmr0pfL4O1oT2CPW6NvubkZa?=
 =?us-ascii?Q?2NAL/pw/2zTAlEF2p4MHHJjnuzX5nqPBVvKC8P85fmGpC53kb8exJX+Q28Wz?=
 =?us-ascii?Q?QLshbAFcn9c2ZVdHO3EKFlLlZ/SgFa045OKDdL4tSsmG+dqn9he/C5cLnzkQ?=
 =?us-ascii?Q?EU+XrFbEZ3bl8XPM6c4tBd/JrovuQFEihk9O8+powzGQ1Bu8JlvvOiqodwTE?=
 =?us-ascii?Q?eq/QGdq4QL6LQPnYSFjSKXeYjFYf/woSebTJCCLljnps8ajMcaaXZewwsrbf?=
 =?us-ascii?Q?j2kBiTF1owZ0TlNN9kJFX4w4fevZ7Yx1V6wG3nqFsDewUT3aex6jwOjwL6iK?=
 =?us-ascii?Q?zoSGU9Z4wLbG8fs3SqpSrdTePMTxKZfvcOWbmPq5xoTzv6A7zCvGdqaxM2mK?=
 =?us-ascii?Q?Dof3aqT9F+k6MPSfc4d5BlmDpIhPAnD3CICl4593Fsw7eQUux8sMg9z5ADJ7?=
 =?us-ascii?Q?3FvKexTEKJXugzSUOglKoDT+sfV3WDZJhaBsG1XXtD8XxxFdDyFpr9cZ6Lzt?=
 =?us-ascii?Q?CKDVRZe6F/9JIcMUBGXm0oRdhjG3JfPWqsXUSqrP7KhhaHlNK6M0P+KyoY3g?=
 =?us-ascii?Q?aFlLGMY4Dvy2iOZlW93FQFAF/4xrqKd1k25qrBEd+j8ZYssderOYDv/nNGyn?=
 =?us-ascii?Q?QsaFWypXL0Kb+MPHQP1JTuBq8l8cjbI23RjtKnT2SqSk39wXCA3uN5QzTbir?=
 =?us-ascii?Q?/tfzgGzzQo2l0ICpj5cG5ORxpkzIk+WwgUx8cMmesqEWQO7HbnTWKa+f01ft?=
 =?us-ascii?Q?JP7IYSdsOuxs01LrWEBuKxc8lalFazF3v72ZO2lsFsH1jYsJqGhPm3WtRYjB?=
 =?us-ascii?Q?g3eah2CYUGIFnkI95OF9TOFLaS4LnGtEHDOsoceIHbd8W9tOr2fy5JJ4Oc/4?=
 =?us-ascii?Q?KA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	MWK55DRWAq+l8UFJfNs71Yc7/PjuEnCHrpRvPggMi1z6WKGcrAGwQZ1jE5s8Q5uHZdDlWbpE7jf5QwlciUicEpLFfsGWbbCWkq0b54yH28NKR8GhmNRa+hcxd7ScHYHO+V/4CVDQ0LjFGDn204PzF70xnDD0wZ+VbNdFXocccxozcSlbij2umr+J+RoUOR0wYqzmgueg2T8Oc2Hcj78wboN5U+31nsid850U5cPweLaBz8z4A4TqREUeAYPrq+PhdpC5kcqJUo+FFpN1iliL2JUui0ghvNc6wpsmb1MsidKrBXyJ9XI5oMW63PK7Yii2PeSmbSNyJfWOKz5gbV2aavCBzj4PAykLXV15jk76TeVtLKaYmKpdXKTz8d2mExFMTpV6hwOJjO1z/YOQGNnUyG0m8WHieHINa3M9DUI0f285+c34Rc6oOBQuCreBsC1pZ+YW0f3HgbVenATFNAiwxoaAzRH4bI0RaMUCEgJZyfH9BiK1yJywsvdY1TXWGnW4lKV171FDNoH/R66AbOBuD1G3NakinR/36NONfWLzk4JfgjiKKEVmUzQWKZE6uj+QwbrlJA/PSl+4dxV/ZfPjgAoIt6qTtgI7O570u3QgUqHRF2Yd7ZuxxfWic0kufLdoDMgDJVNXzPx3oV7G/H54GLxxpsk49grY+2fwWylVGkeCYehfJT4cSGq+yewNO2xn/is1qpf6S3vanHIk9DBAj4t8F4bsRUvRBN2eNZOLxHpnTwawRkZ6Jad6cCwjxBRD256nWZXF94aIfUW5x2svRQe1G2mYCHFDAJRrNN/Q7bCryDkUsSl7cqgjEqtE2jIxA7pRySS/xunrm4PdEsnWkJwizCZq1u2Ljf6Jiwu7w8CZmSy/fFrq1M3uZryjgB7H
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7527f43f-dc49-449c-b9a2-08db2f93c428
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4926.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 13:53:10.2227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UHK9Y7FORv2cfc5ZeoNS8BODd/onvkHMdKkwNJYlt+FMeJPVEiS+igJcLndpUv7XYgU+W0/HjBQZAWhRwVsV5CIdp1GWG/HddIlXCivuI28=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4156
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-28_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303280110
X-Proofpoint-ORIG-GUID: NWnA4M1ScSd3HAjd-Q6r9DdHFdvyOB9o
X-Proofpoint-GUID: NWnA4M1ScSd3HAjd-Q6r9DdHFdvyOB9o
Subject: Re: [virtio-dev] [PATCH v8 0/8] Rename queue index to queue number

Parav Pandit <parav@nvidia.com> writes:

> 1. Currently, virtqueue is identified between driver and device
> interchangeably using either number of index terminology.

"number or index"

>
> 2. Between PCI and MMIO transport the queue size (depth) is
> defined as queue_size and QueueNum respectively.
>
> To avoid confusion and to have consistency, unify them to use as Number.

s/as//

>
> Solution:
> a. Use virtqueue number description, and rename MMIO register as QueueSize.
> b. Replace virtqueue index to virtqueue number

s/to/with/

> c. RSS area of virtio net has inherited some logic, describe it
> using abstract rq_handle.
>
> Patch summary:
> patch-1 introduce vq number as generic term
> patch-2 renames index to number for pci transport
> patch-3 renames mmio register from Num to Size
> patch-4 renames index to number for mmio transport
> patch-5 renames num field to size for ccw transport
> patch-6 renames index field to queue_select for ccw transport
> patch-7 for virtio-net removes duplicate example from requirements
> patch-8 for virtio-net updates rss description to use vq number
>
> This series only improves the documentation, it does not change any
> transport or device functionality.
>
> Please review.
> This series fixes the issue [1].
>
> [1] https://github.com/oasis-tcs/virtio-spec/issues/163
>
> ---
> changelog:
> v7->v8:
> - remove note about first virtqueue number
> - skipped Max's comment to put word 'structure' in same line as its
>   crosses 65 chars limit per line
> - reworded queue_notification data set line, as '=' and vq number
>   wording was odd
> v6->v7:
> - remove text around first vq as it is already covered in the basic
>   virtqueues facility section
> v5->v6:
> - moved the vq number description from middle of vq operation
>   to beginning of vq introduction
> v4->v5:
> - fixed accidental removal of "unclassifed packets".
> - simplfied text around indirection_table mask
> - removed rss_rq_id references as indirection table and
>   unclassified_queue data type is self explanatory
> v3->v4:
> - moved note to comment for ccw
> - renamed rq_handle to rss_rq_id
> - moved rss_rq_id next to rss_config structure
> - define rss_config structure using rss_rq_id
> v2->v3:
> - addressed comments from Michael
> - added previous definitions for ccw fields
> - moved rq_handle definition before using it
> - added first patch to describe vq number
> - updated pci for available buffer notification section
> v1->v2:
> - added patches for virtio net for rss area
> - added patches for covering ccw transport
> - added missing entries to refer in mmio transport
>
>
> Parav Pandit (8):
>   content: Add vq number text
>   transport-pci: Refer to the vq by its number
>   transport-mmio: Rename QueueNum register
>   transport-mmio: Refer to the vq by its number
>   transport-ccw: Rename queue depth/size to other transports
>   transport-ccw: Refer to the vq by its number
>   virtio-net: Avoid duplicate receive queue example
>   virtio-net: Describe RSS using rss rq id
>
>  content.tex                      |  3 ++
>  device-types/net/description.tex | 28 ++++++++++----
>  transport-ccw.tex                | 27 ++++++++------
>  transport-mmio.tex               | 63 ++++++++++++++++++--------------
>  transport-pci.tex                | 14 ++++---
>  5 files changed, 82 insertions(+), 53 deletions(-)
>
> -- 
> 2.26.2
>
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
-- 
When the laugh track starts then the fun starts.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

