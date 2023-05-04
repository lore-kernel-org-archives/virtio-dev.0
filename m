Return-Path: <virtio-dev-return-12550-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FF94C7EE21
	for <virtio-dev@archiver.kernel.org>; Thu,  4 May 2023 14:29:52 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 67E9677EB
	for <virtio-dev@archiver.kernel.org>; Thu,  4 May 2023 14:29:51 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6149A9866B6
	for <virtio-dev@archiver.kernel.org>; Thu,  4 May 2023 14:29:51 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 552299866B1; Thu,  4 May 2023 14:29:51 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 446879866B2;
	Thu,  4 May 2023 14:29:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mVfHARjcjmWcvBuh6/nY668Qk5clOH866oEK03dzGWlQwh04acfsZdpPSOtb2IGEw6I6Fsld8jpyjQL9p58mGWwEkPnOsjF3nhTJ1q3bSR1NQNOnmwp9Kh9hKWVxMahx3fP2w76chIIl7nvTDqppQAtpZ1o2x10H2gxTwEhcJLBDVRoyj8SfXduxI4waY4Q5DwMjBSf+/jltF75s6kwb5oJWs8wiS+wfmpd7jPM3No/sznIZjgBsJo4LeG3vpTL6aAia7O5PCO5CVAU12sXfH+R87sKP6TaSXrCWFSBW7FeBGSCDhpoWJYxYDQCUN1zyT1+dbPItFHb3JNDIvpf3+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vhWR589CGWFQHeXjwyV0YOXn3DRJr5R9sdlg7Z3kt6w=;
 b=HEa+ZCWYa8dyWjuyJzwN6ureQVMr4A2p48OZalYr+jM1lJSChHRBu9EJJeB3eAv8HZasrO92OjQK3mP8aO2kuKFXaCHhx32V0SZLyMwl0rDDUCGSOzFKMUVGQlGUJ+KX7c+tSCvxnV76FB7WKbocK8lz7gaASeXW4BfRAF3LUhL7zU0hE9JC6IHwoQeYTXxTeMhC5eMHo7O35k4fw3ufycPnsAHPrMWYt44FguibpRqthBAmMM0LjAAzuzpHACz7nXZAG9tj6c8BU+3pkiFnHH4/rIQukqSAPuQEOmzkgSYjvf55s8yDnQkhgq+6S2y4tAnxTxW+E/cx73e6xL37nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
From: David Edmondson <david.edmondson@oracle.com>
To: Parav Pandit <parav@nvidia.com>, mst@redhat.com,
        virtio-dev@lists.oasis-open.org, cohuck@redhat.com
Cc: sgarzare@redhat.com, pasic@linux.ibm.com,
        virtio-comment@lists.oasis-open.org, shahafs@nvidia.com,
        Parav Pandit
 <parav@nvidia.com>
In-Reply-To: <20230504022959.547025-7-parav@nvidia.com>
References: <20230504022959.547025-1-parav@nvidia.com>
 <20230504022959.547025-7-parav@nvidia.com>
Date: Thu, 04 May 2023 15:29:38 +0100
Message-ID: <m2ttws41bh.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0297.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::21) To DS7PR10MB4926.namprd10.prod.outlook.com
 (2603:10b6:5:3ac::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB4926:EE_|SN7PR10MB7073:EE_
X-MS-Office365-Filtering-Correlation-Id: 06fb1e3a-acdc-4bfb-9a93-08db4cac0152
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	zgrP8BPz539bHNDkx9juDpvj1zlfdugH1gnY4+vdsn5uTMeT5cmIkmTQpuBEVHAagRKG59AnPRH+UNi9nJsDaVDWFgzqv1rtCTnzTbzGqP9qh6uI8mOAb+WF4PWeGHosySDPsmGlBMdpxIJ/xmkVn/K56j5aRBizNo63a4bWIs/QayS/LczMDnc83Xyvi1CW9aFHy2IY1ka+X01xSAktyjE+zFqQER/KWKlVAseqWduVuQwTGx/aI01rp8pBl7JDWLX4YBY3ugvBGSnRkbUxh6QZ99033NnWA3E9m5uuk37gakt+c5rrW8wobziDdCAizdhZEwIiBXq0YbYDoPLx0lsBf5TpGalEOv8cjGdqFQqBEQV7Qa5BDJS0MsboQficPUAaxR0W2SRAol2OAaQGRgbgUP3X5l0dwaWpUUpnZPkYsEeamQzYYcCr6JRhc0lqXUYvRdnF5JqA1rfyQdgOGNsv9IlA6RhFbm2DhpuyKw+LScHLbpmka4lPreLky9FnaLgaF+gFttWFj45TbgtbzkQrO2ZWo6qAvA+S12ad0YU=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4926.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(39860400002)(366004)(136003)(346002)(451199021)(83380400001)(8936002)(38100700002)(41300700001)(26005)(2616005)(86362001)(6506007)(6512007)(44832011)(5660300002)(8676002)(186003)(478600001)(2906002)(36756003)(66556008)(316002)(66946007)(4326008)(66476007)(966005)(6666004)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?QzqzCH01KRQwBB6IaJaxV4AkkerDJd6ccC9U3bec2/PgPAohOfQt2wsk8yAt?=
 =?us-ascii?Q?uRFWHenXO4bRDIkrVRnV3aGVotMnsEG+KGKAKMXD/iuYJtXLhC4nLFDzYLD8?=
 =?us-ascii?Q?22v+7cTszIfLCa14T++uN4cTa9YMwY0VOc8g3bTcMTXasKfgTHEWaAHdWLPz?=
 =?us-ascii?Q?kNkWESiVna57YyEivzOMwEQczYTjTY+YI+kXOZ2Yvz2sayFGDOnQPBUJ6ur6?=
 =?us-ascii?Q?OtQrCCY4PFMfxYmw4JRu6YD0r6k9kDlH/qcfzyez2JqE7dZNTD6oHRwFO9ec?=
 =?us-ascii?Q?YQjpix3Jwli7S0mta6ewLOxKxJBgj2LIdTDjLrCxKAP0gL+/J3dT1oOLKaoS?=
 =?us-ascii?Q?Ow/vs62Kg+zQmqNeLOwm7OgkH7YNX72Tlo6unJq5bEyKpBqTnlyOmKk13lRP?=
 =?us-ascii?Q?XsqMJySgnBd/JwYULTxZmD2/PtjlQmMCjdZxroqfqfkKaRdQeKDtKItysDxW?=
 =?us-ascii?Q?8JoaEjT6QqEZrzkHnDVRJa8GtRYSorco7rbs5KdLcKIJdGVgmXPys+qVcRlT?=
 =?us-ascii?Q?mzY7ko/TBNueS9KJuM4Mt+A2Idu4uScxkJF8vZVMOS747wpsSdSLSvrKeUjT?=
 =?us-ascii?Q?dQ7yKF4xGmGAq6S35pDsUVWMLVod2VjrdvHl7pI/pFLDQNhpOVYr6uqjehQ8?=
 =?us-ascii?Q?LxozK81FaBW8kob+80cmkbaKxu/jVhNmkX2BrNXMdM94+Ah7WBcswMybNXtj?=
 =?us-ascii?Q?xXm7pmTSz/7Rj4ZsFc8qaiGeW7qVPKIx/wcMnD/DysySd9IVHh3H7WPnd5lY?=
 =?us-ascii?Q?X0iYrwf0gGLQJuVDEC63XFCkWYnYexhcNp9fsQuAGT8fCgBShVFKyoXu0UrB?=
 =?us-ascii?Q?sDV+GTzGhPCABRcWKBZXrKpTuE/btfNz0TKYMiCCpCUHtLECQUdm6pR8Hi6P?=
 =?us-ascii?Q?hbjD3mVkCwoyyuYK+B/H8EUvAhenQ1jIdg8m9dAbMW9X2w38+7iFcOhBo41p?=
 =?us-ascii?Q?0mGVK8sAuoltwu9VEbA9i5jsTMGGATygn/cyT+pz1VXLiY/4GcyOG3X13ZQ2?=
 =?us-ascii?Q?Bew4thKK6HbjjyGAi60dJOQ3imN2EQgCRIgKK7N7WKoMCvpKahOAPwg3ciaY?=
 =?us-ascii?Q?YaQkA3poFmPFANxU6s3wzO/GcZXf5WNqFeFYVgZ+Fyf+rOwInJO+IsVMhCZc?=
 =?us-ascii?Q?izyrylXXeeB9gw5YzRr1AK5XQEi/b7e0rlqVk6h1763VJr2bjttx1wSX8pat?=
 =?us-ascii?Q?BkGhmyFA1uB1mAELLygJs472gAPuVMnInIIkm6aZPwZXwm1qLQGz5l2DsUIj?=
 =?us-ascii?Q?mYR3oEKdPu6UOMhq//IySgSfEAPsVafUeIZd3Huk14/MzCkCIK8xyqGZVKVE?=
 =?us-ascii?Q?JoX9CGlF8/neN2QdJML46F/ywx/H84q47foA8pMqBwAru2FlcArRLCT8mH0N?=
 =?us-ascii?Q?268QBa6mmiJFX4qPdrKQ6883QwZKgDl2eT7qrYS0QcRF1gK3uODiVVxPYPND?=
 =?us-ascii?Q?nSoQn6AaF4Ub/UnacZZHW3aJ8iCZUNzZffSTXaB0wwypau3GRqsWRosLoP7E?=
 =?us-ascii?Q?0PekPI9uHTh9eV+tvBX8NCxLA6Xu1V6U9Msgzdif5RF8DDGFNh3SkhVMguiZ?=
 =?us-ascii?Q?ON8YEgwZIstn7nJvTJwWlB5WvMFAlTwXz/828EGJHqdJnbOb5rYTMKIxXRMi?=
 =?us-ascii?Q?pg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ZlIjCxD1k+Yf0BynrXRdRd3gVSwQxdGC5YjdkRivd7+MAGgl2tc59798Fhl1CekzAsd/HmI4u4zfOzD5fYgZOeAJuh005oeyAXshllX7VWla/NBRzZVuA2AbrqVxr6ArSsiuagv8haNdCCm529u4bd2xud7gKIB9IHIEaUZYkrdSz7cmCX7K072EXSS+wWzB2V4XBYHNTwH5kVE/rtJr61lZ3MM54FqqK0plZxi5ISZWbUo/MzPeYKk0VUJOj3MzVzzy9DGkWfPvMdnOLXAh8BDH18xxSomCPDJ0szx+IeU1poky5U3tGNwGbkqn2nmwwAYoN3MxPui3wyVw1I9wjZhTBYRCDx7TWLeOdvv10jGswnbZsP3F8OaRW0DJUEF0HEPEVTO/uUyvsxuPJoOCIXOG4h9r9FmBpHF25gi99NkJaIZlIiR+eJlfnGdl9AhaHM+mohd04lz/HHQQSDaUEoqQGLBEaD73rJjI3k+UK9g9+FtHVfpLU+mgKjKlqgDr+9ihRJEjnBsS4gFrtilrt/0SqUel6gUqGPVvzhZ+zZMFW1lMqinxXvS16ThfyJOvKZOSFdO7dM+mRS5WjgAED49DmZSTmNeTYd5AupQKX2scigRDyBRAtYZWeim5BEb1OfGi5eeQfPqX2ipLeIOQdi+vcfd7RfW8U5mVRXFfhaZwGDe1HhDSoX/XbLdUz5+mRSR9jzPUgaSDSomteOlZSUuEKXr8ClCPZAw9K3DqW/65RRSJ4LYxtZkVic92RtVaSYJpGLRyWawSea5gHNxmlvjeLgSakPPfKWXGRJwRDaCXfVSzMjpfus/WTSkvlXkKrSgTKZdSr39j+BFs+zCxUQSTc0yDCCVGYZMHlPinUB5etipkHEzBlU10IrNy2YkM
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06fb1e3a-acdc-4bfb-9a93-08db4cac0152
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4926.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 14:29:44.5672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TQbPqFAefM7Ru7fWv3lPZyFHuATd6ZmNAqm02lRJGoPVhLMztRendBqBt3Hyd5zvOZeBfeQxDn+lF/6tqOvdvxJNTRF7B1UP4Hgx9X3ebpY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7073
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_10,2023-05-04_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305040119
X-Proofpoint-GUID: _7edBMdKsIDaag9y6KVZoAQvIkSXt62M
X-Proofpoint-ORIG-GUID: _7edBMdKsIDaag9y6KVZoAQvIkSXt62M
Subject: [virtio-dev] Re: [PATCH v16 06/11] transport-mmio: Avoid referring to zero based
 index

Parav Pandit <parav@nvidia.com> writes:

> VQ range is already described in the first patch in basic virtqueue
> section. Hence remove the duplicate reference to it.
>
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
> Acked-by: Halil Pasic <pasic@linux.ibm.com>
> Signed-off-by: Parav Pandit <parav@nvidia.com>
>

Reviewed-by: David Edmondson <david.edmondson@oracle.com>

> ---
> changelog:
> v12->v13:
> - corrected number to index
> v11->v12:
> - remove changes related to 'vq number'
> v8->v9:
> - added 'by' at two places
> - replaced 'queue number' with 'vq number'
>
> v6->v7:
> - remove text around first vq as it is already covered in the basic
>   virtqueues facility section
> ---
>  transport-mmio.tex | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
>
> diff --git a/transport-mmio.tex b/transport-mmio.tex
> index 164e640..2d24b4c 100644
> --- a/transport-mmio.tex
> +++ b/transport-mmio.tex
> @@ -113,8 +113,7 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio Transport Options / Vi
>      following operations on \field{QueueSizeMax},
>      \field{QueueSize}, \field{QueueReady},
>      \field{QueueDescLow}, \field{QueueDescHigh}, \field{QueueDriverlLow}, \field{QueueDriverHigh},
> -    \field{QueueDeviceLow}, \field{QueueDeviceHigh} and \field{QueueReset} apply to. The index
> -    number of the first queue is zero (0x0).
> +    \field{QueueDeviceLow}, \field{QueueDeviceHigh} and \field{QueueReset} apply to.
>    }
>    \hline
>    \mmioreg{QueueSizeMax}{Maximum virtual queue size}{0x034}{R}{%
> @@ -363,8 +362,7 @@ \subsubsection{Virtqueue Configuration}\label{sec:Virtio Transport Options / Vir
>  The driver will typically initialize the virtual queue in the following way:
>  
>  \begin{enumerate}
> -\item Select the queue writing its index (first queue is 0) to
> -   \field{QueueSel}.
> +\item Select the queue by writing its index to \field{QueueSel}.
>  
>  \item Check if the queue is not already in use: read \field{QueueReady},
>     and expect a returned value of zero (0x0).
> @@ -474,9 +472,7 @@ \subsection{Legacy interface}\label{sec:Virtio Transport Options / Virtio Over M
>      Writing to this register selects the virtual queue that the
>      following operations on the \field{QueueSizeMax},
>      \field{QueueSize}, \field{QueueAlign}
> -    and \field{QueuePFN} registers apply to. The index
> -    number of the first queue is zero (0x0).
> -.
> +    and \field{QueuePFN} registers apply to.
>    }
>    \hline
>    \mmioreg{QueueSizeMax}{Maximum virtual queue size}{0x034}{R}{%
> @@ -550,8 +546,7 @@ \subsection{Legacy interface}\label{sec:Virtio Transport Options / Virtio Over M
>  
>  The virtual queue is configured as follows:
>  \begin{enumerate}
> -\item Select the queue writing its index (first queue is 0) to
> -   \field{QueueSel}.
> +\item Select the queue by writing its index to \field{QueueSel}.
>  
>  \item Check if the queue is not already in use: read \field{QueuePFN},
>     expecting a returned value of zero (0x0).
> -- 
> 2.26.2
-- 
Up eighty flights of stairs to a basement flat.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

