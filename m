Return-Path: <virtio-dev-return-11814-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17819C6FD18
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Mar 2023 14:05:57 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 6865641A1D
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Mar 2023 14:05:56 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5F9EC986418
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Mar 2023 14:05:56 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 52E429863C2; Tue, 28 Mar 2023 14:05:56 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 427F598638E;
	Tue, 28 Mar 2023 14:05:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K4EG9AtdqW13JUGM5x7JgKA2Xl0pXWqnVKdCxEAHj8B6OtoEDcWfZLp+d6vSJ3M/5sFSA7OotKMlttt+U0/ovO4YR2dMEyEDsFL0BiveS+m+KVrNio0G7TNU8GkMTpYxpr76mo/WsA5GrHmpelzAJgdZv/ZE6Q+b3SsT1zKWUByp1yYKgrl3FKZ7jG5I8aZaiZZZbvfHkrOHctx6PPlvwAT1UTDGykni/YprTPOPX8rJ7A3yz5GPhb4ivuLJskyE8zft8lRGozz+8QtMAuisXeEiErPzpZ61URODjuN5j9+En0tXjpVe8iQ6utJqm+vimbF3uIT4M33oUoHQxBfHog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jqJ51kyTM+FEeBUB4+YxRdufXQ3ldm8Jrd9egzSpPmo=;
 b=hZ/TRkYkttR46XEgRRZoiUwBAthms58fUa1E3wE5FwmzmaRiNWW9VMb+THL37wBdRFAYuZsUafid0UlB7Q9bZJd9FmKEkWO1hgG7lmqj+aJM8BUcTkkIx4mL7m+VqTPXj4GihNWgM88V8oXnf5dNxidh8E7Je3pzel1TopPIFs4g10NzXNjPi4oQL5VurCRdgAfW2E1HROLz/W0sYA1kQXtVgeAp/dsnzBMObb21vqjq/im7JoMXTPuP6Q0y930nQVshrHfX1ELCr8ic0c6/beJ27BXbs9MfheA5rqntmgy0Ad1nwnQ0GkQp7rMjC/vqj/grqrKRIEqg/3pukpK+Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
From: David Edmondson <david.edmondson@oracle.com>
To: Parav Pandit <parav@nvidia.com>, mst@redhat.com,
        virtio-dev@lists.oasis-open.org, pasic@linux.ibm.com,
        cohuck@redhat.com
Cc: sgarzare@redhat.com, virtio-comment@lists.oasis-open.org,
        shahafs@nvidia.com, Parav Pandit <parav@nvidia.com>,
        Jiri Pirko
 <jiri@nvidia.com>
In-Reply-To: <20230327235936.414196-5-parav@nvidia.com>
References: <20230327235936.414196-1-parav@nvidia.com>
 <20230327235936.414196-5-parav@nvidia.com>
Date: Tue, 28 Mar 2023 15:05:20 +0100
Message-ID: <m21ql9c6ov.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0078.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:138::11) To DS7PR10MB4926.namprd10.prod.outlook.com
 (2603:10b6:5:3ac::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB4926:EE_|BY5PR10MB4130:EE_
X-MS-Office365-Filtering-Correlation-Id: 629e997f-bf0b-4695-b30a-08db2f957acb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	QrQcbK/+3XW/4Xuz0X4zg10AsFJvvuPnFZAX8KHhZQr4etZGc/ATkV2qdvoOoIsKKC5UvcHUq8L9WxzciFdayhp4OXB06RlWSN/CjbdLqUYx6AQNRac/NoZ0RQaEMTj3G51Rqn36h8hs35gZrPItxvSQK+41pkQZUCwlDuox5oGD5SXmye6U8iy3AjQ6Dq9kl5LMos6NvAq1VRiUyFU74Hn6E8UWspSbiMdJpgZ6cwi9J18OTeUrPKyJ+AxjH/6cZs6ou0tAzOIdc9PzjfrjZ2oRMJly+cBI6YHJOvFNBNgaNP85jTPRz13aCX1y9gYOQrWqxDfz1QlEnVgHecyX1zSSWZR6MMkDruZ1zgvIcZJvsffzvbeLtX9EUQGlW1GkGfDa63w/u/c/aCBDcjuL0JiAt5BmC0QKXOYH1xyXxZiQ3x254IkRnQD1MTRqBDBt74B20TfLhjMWYs0Q5zsslvsofJ5bAfcLrXSTE6bz8/4uG4WY/TJ9PbGgd6qFEpGRi5Tm4O83aGK8QCJh+J/hFbGGzlxORuZHFaC48iKIuYSb5zSp0CeVq5Cghxa79ZHs1vr/TQkXz/I0kbES8YXTAg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4926.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(366004)(346002)(39860400002)(376002)(451199021)(6486002)(966005)(4326008)(66476007)(8676002)(66946007)(66556008)(41300700001)(36756003)(2906002)(86362001)(5660300002)(8936002)(44832011)(38100700002)(478600001)(316002)(54906003)(6506007)(6512007)(26005)(186003)(6666004)(2616005)(83380400001)(66899021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?lYMIKTC2O94tAv9yscSNo7FDKB1UP2tQHqaIyQ8qr7sjpdDxOdziRi3LJ8HU?=
 =?us-ascii?Q?s9imkckmuHnTf1B7ZxOovfdcOH6gj+VUuevEZhW2ecnqHlUPaLmCibg2Burk?=
 =?us-ascii?Q?IbGvyvwq6jqziaZSY6MYpVN+Qt7mer7kJoNcilOKvsYwLE47KH5TL29ubFwm?=
 =?us-ascii?Q?bIlmaAPNChoM7PHtJ+BCr+0NmgXaj9q5Nlcli/UGVcWOVUITRZmdCaqx3O4h?=
 =?us-ascii?Q?rDTpqpG1AMHZRfDMgJwGHUWBXEHtFjKDElA3NldkJPeogmGSRrzW8R+2ddio?=
 =?us-ascii?Q?SYglICAGk/MeFeM46F1lrYk450DIzoFoEbYsR2W6ncYGsWKv1IwAfUOEH0Fu?=
 =?us-ascii?Q?m7K0T88I7z7f+WhGRCLTUKaQL/oscPIEmJw0qgVGU7rdmd3XMPFG0WIeJVHh?=
 =?us-ascii?Q?KiKRkFsO3bjGG5SosIo78Iw/2/i0VGa+nqzb7Uv/JA7ThQ/Rb6I9H+fTsJ3q?=
 =?us-ascii?Q?EGLBrNQVNqtquVylwH/EnUMKpfm8UB1MNKgLLHh17A4wYy6zOcsYHJz80ttY?=
 =?us-ascii?Q?YFL9g1n05UjE7dkObBO9ffqjE42End8UeaOoJdBd7C4yTjE6XtSm+CVI6vQm?=
 =?us-ascii?Q?U3Z37XlpypR/yDVMazXE2nSBj7jpN2Qqjgmb9QKphc+8RjF30BzwtXfurOGo?=
 =?us-ascii?Q?8jYInptJXlFv4T2GDwFiyDRSMabzz5mhY2uD+3Kf1HZi/1PMIRwuuBdZIK6C?=
 =?us-ascii?Q?2JAERjH0hSKhq1GCJfjg53QByJi3XIfPeSy6yjdb7ETvtA4hPcusTbMl/G//?=
 =?us-ascii?Q?6T0o2Q64vAJQId9HS5LoTVXEh8lQVHZxSeUsx7kgKs1RCjToGjq1pDqrCK9x?=
 =?us-ascii?Q?k2qzJHmopRkBR3KxNtQ+dd/SfkzVgAQFUH3ac/Y+eRiF8zdyXpAnH0UzJbDc?=
 =?us-ascii?Q?CpVpm0DnhU/aThHgvqqoduGZL5mdQePPYoHe8EjT4mRY+ISBx61JsY2smySh?=
 =?us-ascii?Q?oU2N6mrnn6LYEPMXROiSTo6wBcX1QLiXKNlwLKDnN+uQeo6qPC11wBqwA5cq?=
 =?us-ascii?Q?aGqbKPEDhDKXoQzbiiPXQsV8qfuDyhHDxGYRPx/OvADZ6Fse9KZO/HfO3aAE?=
 =?us-ascii?Q?Yrli4Lwi0ufXtJNspAHkxKYN8SKrm7IOLAfF93ivJGr8WMrlG/+nfJFEOaUs?=
 =?us-ascii?Q?CGhs7bdzKF6d8z6oFyCo4kzdrSW1bGz5fhbGM8SZCaTFWEQHPLB8WVu9+pce?=
 =?us-ascii?Q?jKpiFismimfa9RW/B82VxCterxbATV4dPZD8K7lAtApfsngcnFtGwoYVou9S?=
 =?us-ascii?Q?4m4umgBDiqxmLWTBzwZhXfPgrR6T7YasuVmorHipALFmkbWSRFxKSp+oYm0T?=
 =?us-ascii?Q?9N1A3GkRA5Yqu6ynyJ0cYpi9f7DvRQOIHe0/8GqsCsnP7YQFTZ1aZm839M8M?=
 =?us-ascii?Q?NEY+75LeCMiWyjZACTGMFbqPASZ7JdAwkxcr0hhB6bbYzUGpPgeVlnSIwwnh?=
 =?us-ascii?Q?QpP6vFTxEdEsOgZWBSFSRfoM3atWmyTFgs3G38kparAEkKBjvzXJdMEiMr44?=
 =?us-ascii?Q?qWioRHRjgcY4jJdmoTptVOOM3SJ3Z2pIp6pHLQITXqcVyIVCVPeJYOG9yGcM?=
 =?us-ascii?Q?vokY8KJS7bQ2oCaa25oWS0AF0k14OKZ39WBfJsxySn5Gml/9f34MJvN0p4S6?=
 =?us-ascii?Q?jg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	81t2dVS/w75/iKKHdY+FcvjE74kT80ZPwU//enHG+pzfgt7Hm9CrLNFc6w15oShM9KnBjtMkMZpS8JOel/fcYXN3nzvDAtHnedpIchbWpQHuKuyOq06oFSkENrDbpOtQ8ZsqtHiuctrTY8a4hCd8cqkdSLhkOI9uuOWCEAD/ykAIf4rbHnMTZZHvUplDRD68vhwI+g5tceC5Y33Xlz+r6nQueUD28Zo2De3RSQTfa+5hsUIYIVLrKBkiV1CvmZF5yHjZ0H7JtEJRf15rmHDnDmjl2SI/SnpJfttr1CZzUAMWH72LD6vQk63x5VZ8DrTyCU0astIF8Sr6i/rbfAGtdfomzuvG+BqHaA0qXZusAdAq8nZzp9yito+hJhsbc8l8+KN6YQv4cJXRV2ZrFHxqbtE7t34rfXVJVrpdpz1OH7YwtRXme8JRaXz5wAMJuZm+4vVgT2O1xpZfV95HaDIsf9qk7uIEGyEqi/ON1wGm5QUrdaZAz9IWv70/PqNxQ8yUjiybpI/wgz7Spxbs1uTj8VsltylodheMpuc270ARmg0ZFTUcVN4P1jdteKZEezk59fgrhgKiSCTGu07GiIeXXOFBBeSScG9trlODTOfZGAWcQnT7EXX0y3u5NGuKhu6oHsTzXHK3fvWZtodzH+SmCQVHHdq+l+P/EdEO9t9fb6Obam2lXVaGUKTyacWeJ88u00w5S+0JlK5LJ68o9Ro0TOiCSk14uK804Y8+hPzhMFBq6VKU/SGFzSAqbzCURApeViail3cmogAVNs/QtoUzBlUDTksr+DkRt/XqpOA52I+Mw+1Z1lWLQWZabUUC9QQnqQxQvLBJRj6gU0TGEdfXsEfHpUu2f90icy1ME4J41aYOa13nKJuMTZk5euv6mzts
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 629e997f-bf0b-4695-b30a-08db2f957acb
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4926.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 14:05:26.1937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kgLmgnEGbVIM3/6q3hxOF0NPyRGZ9HDbgYLEugin/1XL2le+jkVWvxuVgjJ7yofypBPqZH+jbBBZX+OFhuDWA9wIKOmccMVj79KTFhUvBaI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4130
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-28_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 spamscore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303280111
X-Proofpoint-ORIG-GUID: M97JefUQz6TDLwOwn5z1PmHRuNj7Q4no
X-Proofpoint-GUID: M97JefUQz6TDLwOwn5z1PmHRuNj7Q4no
Subject: [virtio-dev] Re: [virtio-comment] [PATCH v8 4/8] transport-mmio: Refer to the vq
 by its number

Parav Pandit <parav@nvidia.com> writes:

> Currently specification uses virtqueue index and
> number interchangeably to refer to the virtqueue.
>
> Instead refer to it by its number.
>
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> Signed-off-by: Parav Pandit <parav@nvidia.com>
>
> ---
> changelog:
> v6->v7:
> - remove text around first vq as it is already covered in the basic
>   virtqueues facility section
> ---
>  transport-mmio.tex | 21 ++++++++-------------
>  1 file changed, 8 insertions(+), 13 deletions(-)
>
> diff --git a/transport-mmio.tex b/transport-mmio.tex
> index 3047633..2aa6627 100644
> --- a/transport-mmio.tex
> +++ b/transport-mmio.tex
> @@ -108,13 +108,12 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio Transport Options / Vi
>      bits accessible by writing to \field{DriverFeatures}.
>    }
>    \hline
> -  \mmioreg{QueueSel}{Virtual queue index}{0x030}{W}{%
> +  \mmioreg{QueueSel}{Virtual queue number}{0x030}{W}{%
>      Writing to this register selects the virtual queue that the
>      following operations on \field{QueueSizeMax},
>      \field{QueueSize}, \field{QueueReady},
>      \field{QueueDescLow}, \field{QueueDescHigh}, \field{QueueDriverlLow}, \field{QueueDriverHigh},
> -    \field{QueueDeviceLow}, \field{QueueDeviceHigh} and \field{QueueReset} apply to. The index
> -    number of the first queue is zero (0x0).
> +    \field{QueueDeviceLow}, \field{QueueDeviceHigh} and \field{QueueReset} apply to.
>    }
>    \hline
>    \mmioreg{QueueSizeMax}{Maximum virtual queue size}{0x034}{R}{%
> @@ -149,7 +148,7 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio Transport Options / Vi
>      there are new buffers to process in a queue.
>  
>      When VIRTIO_F_NOTIFICATION_DATA has not been negotiated,
> -    the value written is the queue index.
> +    the value written is the queue number.

Should "queue number" become "virtqueue number" everywhere?

Perhaps the introduction should indicate that "queue number" is another
term for "virtqueue number".

>  
>      When VIRTIO_F_NOTIFICATION_DATA has been negotiated,
>      the \field{Notification data} value has the following format:
> @@ -363,8 +362,7 @@ \subsubsection{Virtqueue Configuration}\label{sec:Virtio Transport Options / Vir
>  The driver will typically initialize the virtual queue in the following way:
>  
>  \begin{enumerate}
> -\item Select the queue writing its index (first queue is 0) to
> -   \field{QueueSel}.
> +\item Select the queue writing its number to \field{QueueSel}.

s/queue/queue by/

>  
>  \item Check if the queue is not already in use: read \field{QueueReady},
>     and expect a returned value of zero (0x0).
> @@ -392,7 +390,7 @@ \subsubsection{Available Buffer Notifications}\label{sec:Virtio Transport Option
>  
>  When VIRTIO_F_NOTIFICATION_DATA has not been negotiated,
>  the driver sends an available buffer notification to the device by writing
> -the 16-bit virtqueue index
> +the 16-bit virtqueue number
>  of the queue to be notified to \field{QueueNotify}.
>  
>  When VIRTIO_F_NOTIFICATION_DATA has been negotiated,
> @@ -470,13 +468,11 @@ \subsection{Legacy interface}\label{sec:Virtio Transport Options / Virtio Over M
>      (see QueuePFN).
>    }
>    \hline
> -  \mmioreg{QueueSel}{Virtual queue index}{0x030}{W}{%
> +  \mmioreg{QueueSel}{Virtual queue number}{0x030}{W}{%
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
> +\item Select the queue writing its number to \field{QueueSel}.

s/queue/queue by/

>  
>  \item Check if the queue is not already in use: read \field{QueuePFN},
>     expecting a returned value of zero (0x0).
> -- 
> 2.26.2
>
>
> This publicly archived list offers a means to provide input to the
> OASIS Virtual I/O Device (VIRTIO) TC.
>
> In order to verify user consent to the Feedback License terms and
> to minimize spam in the list archive, subscription is required
> before posting.
>
> Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> List help: virtio-comment-help@lists.oasis-open.org
> List archive: https://lists.oasis-open.org/archives/virtio-comment/
> Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
> List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
> Committee: https://www.oasis-open.org/committees/virtio/
> Join OASIS: https://www.oasis-open.org/join/
-- 
I move with the movement and I have the touch.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

