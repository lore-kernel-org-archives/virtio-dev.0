Return-Path: <virtio-dev-return-12507-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80B8FC77B7F
	for <virtio-dev@archiver.kernel.org>; Wed,  3 May 2023 10:48:30 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 9F8121CA267
	for <virtio-dev@archiver.kernel.org>; Wed,  3 May 2023 10:48:28 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8EE219866B5
	for <virtio-dev@archiver.kernel.org>; Wed,  3 May 2023 10:48:28 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 79E9E986586; Wed,  3 May 2023 10:48:28 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 65E79986587;
	Wed,  3 May 2023 10:48:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lZvpIQwmqfoUarhfhUR7T+9kzSOn91SL9+a5olUSyFWiSE7gleuLXIHa5IoOJ2PlfomNU5Q2Gwc7iy4iv/fT2MUoAMiAzPOgx28RtSw6UlPjah1XN4ENz5c3q3x+b08uutRaHjtu2h53JWEHa8Mb0c7gkYsOr3UqmFz8hCwun0pqrsJccKU/xajSf9qOIQ2hwEPHSfglVM6sjWEh63nA+u8PZdZU4uTMgewctEH6DEo1PxKO+b64+EvBZmxeh1vPHdgy35xCvSDZzwGnet/t0sfxITnvJxWcuLLQMPi0jc8vy6vQ4cRvgPf8GV832V5aOEvd5jntTRzG7xmBgo8ZnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R0K+VTpCOF+Qt/daTe9/HwvJ11BJcrIKZ74XEvZ2BKY=;
 b=B6GV+uK6F8S6c0rQVMXMwfmOZC7r7sA7GZ3gvrecReBM593cSPieG9mtlplKbQYIJl+oEUxGojBWb9fEHareyiyMHOLQw6XF3eMY3SQhOB6utzetECixCcM3Zc3ano52rCGnEGd1ubsEFPAdnHH6kfevp4Cx8wbscCWN9Qn53gJQQOFoM2xN2vf7zkoLDJsdItk8PRMpHyoqCh62e1hzkpb7bCz3WE3OEfinaUWhjnQiU4r0JnxI5+hjVFR7G+i/5cRmRp9nx6u54vswttgtsonijW0t+6TGMP0LMEeu0kZ+1vLbNcy4eLRjBIPMF4p47j9SoOLDacL4PJyAwl95aA==
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
In-Reply-To: <20230428041949.411221-4-parav@nvidia.com>
References: <20230428041949.411221-1-parav@nvidia.com>
 <20230428041949.411221-4-parav@nvidia.com>
Date: Wed, 03 May 2023 11:48:14 +0100
Message-ID: <m2ild9vggh.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: LO4P302CA0021.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c1::12) To DS7PR10MB4926.namprd10.prod.outlook.com
 (2603:10b6:5:3ac::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB4926:EE_|BL3PR10MB6018:EE_
X-MS-Office365-Filtering-Correlation-Id: 013ca6f6-66f0-45ef-8672-08db4bc3e8bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	d81nd1ZrikeEfOBNX5bC8Hn6YVHxEZU4Wg3W35rDSU8yUk4umLUcHCGdEWLjKERTjz2R9rQhj1pOz9TWvHZL94v+9vAZ078wZSLu9bLuSLMEeTOuT9CXjBMBpvNOFx9YgnQ1Jx50tCbsiFIghO07ShxGdkAWOJnZfolwe9JskIRD6DdD1v8SsGfFlitb1tYWfWoenl6PkgQ7sJAqtQaw2iBx9aJW06HEMhQIbSWoijuyq9CrJiYGkh5BnVMGvCbYQvl5cNWGOvuiGjeINZlqcrcnIIMTZyfAvQodduGQbpEehIckZ2FRS94daMe9B3FFesWru1JqpG5Wk8IpZ7YUL4/1JHHfTUT98o29s934d3PDGCNcY08hm7tiN1JOP/ay9sZK+02H4qZinA+YG1PQm2jM4eTEDmaFNfnWl6Z3bS7sLeS2OHnQBCeIUzLYhXLTvLWv/WazlNLWI0IVBzVVV+fhdWl7Cvi2xTMSRe3d6V46Rcel/Dk0Pbom3voqKktv3kN4n2v23rVE22gRYoTwyAm3Slgd6HM9L+XsBUYpIBhfJ7Femrekmra0ghFlKoUNJSkhjwguVrv0XF+e3xitxA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4926.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(396003)(136003)(376002)(39860400002)(451199021)(2616005)(83380400001)(478600001)(186003)(4326008)(66556008)(66476007)(66946007)(26005)(966005)(6486002)(6666004)(6512007)(6506007)(44832011)(316002)(66899021)(8676002)(8936002)(5660300002)(41300700001)(2906002)(38100700002)(30864003)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?bFJdJlD+U1BiwbkAQGoC3nXQc2s478n+DvCVhv/CA7i8fgn/jzN51jlaLBrP?=
 =?us-ascii?Q?EdWM1W4TgS6uREbgYwYWdq8S6cRO3cxliMPhFtSmC84HgT75Le5u9692TgHR?=
 =?us-ascii?Q?kypaDA2RVV7LBw1M/eLAB4YQixGlrBpvksgoT0+bs4rt/VEzPpbNus9BUjpD?=
 =?us-ascii?Q?Qwjmj88XXQViVc7HTNGctR9KpgEreNcVDc7OBJ4lGwnupoqhcuGdZV/MBdI/?=
 =?us-ascii?Q?hihR62U22JZEr6mSRmnlDkp5eJ6o2u3Y78xoVjyvksV6yzLHFINJKR1WnnkD?=
 =?us-ascii?Q?4bWV/BCktdvDVSlOWjozm45evJ8nOQI74n2ADgm0F6Bv/5T3cVGeVXbwAbQU?=
 =?us-ascii?Q?Oij/LEA4u4+TV9xM7tZ+JqIqszEgacOVEiB8maEzgE4rW/A8L2UB6YtgLNiZ?=
 =?us-ascii?Q?JmhSlfLlxj5CLWfuQnl2ymSfo6ZFJvKY3HsL4SOcf7lXNnYonpFj3HZUuuJq?=
 =?us-ascii?Q?Bfiu7MSjX2Iw/f6Nvbw9/fSKhGfX0KCSdt6gZtAECwVJRakMcozgGRsRoSwr?=
 =?us-ascii?Q?QhWn5UdJV+XOlHicrsqicUX0yJNdqFbkwp+vAg254OMXp+1QsBEBm0oABBtK?=
 =?us-ascii?Q?dFVAo97OIcgL1cHV0l/8WkoEYAPzQcgx17en0UEXcECGWfxGgYqdbnXjd6R4?=
 =?us-ascii?Q?RgoEHrONuLPOo//5CHhWWWLjILYDNOqZx44STJ9QbBs9GyLBpRtfeB3QgrMa?=
 =?us-ascii?Q?qCzD4Y1gGPG80osiho1O8huIvoavNeCR/Ml4J07ZeRWlwyUZADP99Jei5ckl?=
 =?us-ascii?Q?Af+jhlHCEACZlKmUbR2OJaFszN+6DQJFbgM+yBxE8TWisbdHX5YeWGSGzYcG?=
 =?us-ascii?Q?s9a7EkuiPx2Dj7ama9cXWk6/QWWiaUJ9/rcwngZ+IJA4TSAPKPlZdf5oq+AK?=
 =?us-ascii?Q?jUkTNOv/i0DcckLVxEkQWLnoAoir07MjJPIg/0NoPIdg8VwnO/0dpRoA3wjW?=
 =?us-ascii?Q?o8c0xKu+9PA6N6VbBgfhwy2XEjwwR6+ebG/Wno1d1S3+RKYs0O990xpBx1GD?=
 =?us-ascii?Q?B07WUjvDcshEmoyXnH4lwOAcxMGWGwIxSq6fDPIG8hjI0aKKPNUJN/MS/dGy?=
 =?us-ascii?Q?+VLYyxm4gmuZMSrSGf2kbXIr86ea56h+yRgJXgOYQPrYiLZhFAnUeqFxQfuF?=
 =?us-ascii?Q?xZ92X6Mmo/AgX1h8jnlsqJ+HJIdr6kKZPxy+yRmew/5jRACY0d2vPPAszQdv?=
 =?us-ascii?Q?pk5tbuYuj/KU0L0HAJPJdSKDQzOGn0fE7HBxSYpcfbqe7sZDzCS5Wt6N72Nn?=
 =?us-ascii?Q?yluA7dI/Geohsn4jrXggWXU7S72av111fFoMnAJUN+R9F8fUcIs3EZe/0jSY?=
 =?us-ascii?Q?gU75ObtRXlZFVhWmOPuROX7d5cYyVrs1L1/hBZtYZGpAvYRG8zQZH79EyxiQ?=
 =?us-ascii?Q?JqySkAceV4gHlYH3Z5jvPvOnptSXKOqIrQYtQ45djOn5sMdBG+OyAWrdf5Bg?=
 =?us-ascii?Q?sFvHhvVhlfCyfn6zjFv+BVmyqoKBZcMHWgjc50hASPR8q5X6Vifnx5tTYJIn?=
 =?us-ascii?Q?1x9X35GzP3SCbU990bkLX4beYO3pEctZJOav/idsog94aPhx5714tjm/lyO5?=
 =?us-ascii?Q?HYqTTbqjlmKk+ag5jwYt8Z0XC9aZcpUPnBNS0N2NDcjGL8Yzv4om95vOaWcJ?=
 =?us-ascii?Q?eA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	BCbz6QDF6ku2gdFOW9ZRFG4Mw+B4D/X5A53FEYYw6GYsH1UO6D1eVP/MtTNwftHhIx8UUqF4yg02iWBYzJ/pdTIG171PZubp4WPA/kmvUdaMuOQIzm8PZE8fvzRzx2hHE5mA0wXO4mBWdnFfehALZ1eO23rN61xCsWUEhgz54oy/+xhB1p6fr86d/UBYfNCU5cT59hhdCN41P+0rWc+KSZxZCoJjWt6VdpyqrZk+bLknpe+DQ2EFSC4UfctVdoL97+zqYv1NX0Ld6QTKQZTLu3Y5+e6RdTg7qLZ+JG2ELjATByZvg2T6ZJX4Jejgd7EiaeGXJLLWfaQxxfrM4UIE0AUQSSvQGdKFn2FhHhEbaUyALslXh4douoL4w74ALePCTenvZzhs2UouzxUS8ecjNUFjHtHaLj5MVWAL1msD0A9TbSdjffvob64CyPGA8h9pDBz3NSxPHaP5+zLEohLKOsEjrQmym7NnauMtJUXFnLHb7gU3P0v/3TuoH5zsMoks+5yIxmtS0juhiRovt5BL0MXhklmcTNMoA2nrz6HhVgy5kozhzaxdirex+KGx+HkyOAy9IeycGgm8RT3OdbtTz0SDlo/Ct0AQCFAHFSe4XXizy+ynlShp0fmIqwbb4CkjiUuxfIuiO2SlyiGn/cr3jokkHF3+xA1Ky2229adoqmltSD4B8recnX+6CQOSYkzleUvogZtl+2rMsAGPvHdsk/jjm05G8vnqbqTAS/IEFYu1kAN7MKxecqB1bS4Md6YL0Qi3Ecs9hcPNFIwUYzmXp0mLpRsJ/lslo20+4WD8L8uLhAN8llwCu/nYEEVWpl5H3mH2DG0aOdObrqhdlVQxnbB3/KO1eVo+yYwgIGb5p66lsld4mMcw+Il9OHc5kz/W
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 013ca6f6-66f0-45ef-8672-08db4bc3e8bd
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4926.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 10:48:20.0672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rtSCU61tbBg+HVGwU9HBgZ/vpGEu4ErM3gZYemzgCCUiC1t2eMNp/43v9gvBLa+IpeVA2Y1K7rLPT2jmH34Al95+FINY9OSoV3qb5RQirJ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6018
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-03_06,2023-05-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305030090
X-Proofpoint-GUID: hnOXpFNA_n0_aCzkwnQ9vj9HyGaUPXJR
X-Proofpoint-ORIG-GUID: hnOXpFNA_n0_aCzkwnQ9vj9HyGaUPXJR
Subject: [virtio-dev] Re: [virtio-comment] [PATCH v15 03/11] content: Rename confusing
 queue_notify_data and vqn names

Parav Pandit <parav@nvidia.com> writes:

> Currently queue_notify_data register indicates the device
> internal queue notification content. This register is
> meaningful only when feature bit VIRTIO_F_NOTIF_CONFIG_DATA is
> negotiated.
>
> However, above register name often get confusing association with
> very similar feature bit VIRTIO_F_NOTIFICATION_DATA.
>
> When VIRTIO_F_NOTIFICATION_DATA feature bit is negotiated,
> notification really involves sending additional queue progress
> related information (not queue identifier or index).
>
> Hence
> 1. to avoid any misunderstanding and association of
> queue_notify_data with similar name VIRTIO_F_NOTIFICATION_DATA,
>
> and
> 2. to reflect that queue_notify_data is the actual device
> internal virtqueue identifier/index/data/cookie,
>
> a. rename queue_notify_data to queue_notif_config_data.
>
> b. rename ambiguous vqn to a union of vq_index and vq_config_data
>
> c. The driver notification section assumes that queue notification contains
> vq index always. CONFIG_DATA feature bit introduction missed to
> update the driver notification section. Hence, correct it.
>
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
> Acked-by: Halil Pasic <pasic@linux.ibm.com>
> Signed-off-by: Parav Pandit <parav@nvidia.com>
>
> ---
> changelog:
> v14->v15:
> - fixed white spaces at the end of lines
> - fixed next listed comments from Michael and Halil
> - renamed notifications-pci-le.c to notifications-data-le.c
> - removed unwanted \item tag
> v13->v14:
> - added pci transport specific union structure
> - added normative lines for case when VIRTIO_F_NOTIF_CONFIG_DATA
>   is not negotiated.
> - added normataive lines for clarify bit-width for driver notification
> - replace left over _id with _config_data
> - use _notif_config_data name to align to feature name
> v12->v13:
> - replace _id with _config_data
> - dropped vq identifier
> - dropped the idea of union as description is for config data feature
> v11->v12:
> - new patch
> ---
>  content.tex             | 11 +++++--
>  notifications-be.c      |  2 +-
>  notifications-data-le.c |  8 +++++
>  notifications-le.c      |  2 +-
>  transport-pci.tex       | 72 ++++++++++++++++++++++++++++++-----------
>  5 files changed, 71 insertions(+), 24 deletions(-)
>  create mode 100644 notifications-data-le.c
>
> diff --git a/content.tex b/content.tex
> index e79d722..e1345ea 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -404,8 +404,12 @@ \section{Driver Notifications} \label{sec:Basic Facilities of a Virtio Device /
>  notification to the device.
>  
>  When VIRTIO_F_NOTIFICATION_DATA has not been negotiated,
> -this notification involves sending the
> -virtqueue index to the device (method depending on the transport).
> +this notification contains either virtqueue index if VIRTIO_F_NOTIF_CONFIG_DATA

"a" or "the" virtqueue index.

> +is not negotiated or device supplied virtqueue notification config data if
> +VIRTIO_F_NOTIF_CONFIG_DATA is negotiated.
> +
> +A notification method and suppling such virtqueue notification config data is
> +transport specific.

"The" notification method. "supplying any such"

>  
>  However, some devices benefit from the ability to find out the
>  amount of available data in the queue without accessing the virtqueue in memory:
> @@ -416,7 +420,8 @@ \section{Driver Notifications} \label{sec:Basic Facilities of a Virtio Device /
>  the following information:
>  
>  \begin{description}
> -\item [vqn] VQ number to be notified.
> +\item [vq_index_config_data] Either virtqueue index or device supplied
> +      queue notification config data corresponding to a virtqueue.
>  \item [next_off] Offset
>        within the ring where the next available ring entry
>        will be written.
> diff --git a/notifications-be.c b/notifications-be.c
> index 5be947e..bf6d1cd 100644
> --- a/notifications-be.c
> +++ b/notifications-be.c
> @@ -1,5 +1,5 @@
>  be32 {
> -	vqn : 16;
> +	vq_index: 16; /* previously known as vqn */
>  	next_off : 15;
>  	next_wrap : 1;
>  };
> diff --git a/notifications-data-le.c b/notifications-data-le.c
> new file mode 100644
> index 0000000..3ee80e4
> --- /dev/null
> +++ b/notifications-data-le.c
> @@ -0,0 +1,8 @@
> +le32 {
> +	union {
> +		vq_index: 16; /* Used if VIRTIO_F_NOTIF_CONFIG_DATA not negotiated */
> +		vq_notif_config_data: 16; /* Used if VIRTIO_F_NOTIF_CONFIG_DATA negotiated */
> +	};
> +	next_off : 15;
> +	next_wrap : 1;
> +};
> diff --git a/notifications-le.c b/notifications-le.c
> index fe51267..8a19389 100644
> --- a/notifications-le.c
> +++ b/notifications-le.c
> @@ -1,5 +1,5 @@
>  le32 {
> -	vqn : 16;
> +	vq_index: 16; /* previously known as vqn */
>  	next_off : 15;
>  	next_wrap : 1;
>  };
> diff --git a/transport-pci.tex b/transport-pci.tex
> index 524bfff..b292fc3 100644
> --- a/transport-pci.tex
> +++ b/transport-pci.tex
> @@ -319,7 +319,7 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
>          le64 queue_desc;                /* read-write */
>          le64 queue_driver;              /* read-write */
>          le64 queue_device;              /* read-write */
> -        le16 queue_notify_data;         /* read-only for driver */
> +        le16 queue_notif_config_data;   /* read-only for driver */

"previously known as"?

(I'm not particularly bothered, but if we are going to be consistent, it
should be here.)

>          le16 queue_reset;               /* read-write */
>  };
>  \end{lstlisting}
> @@ -388,17 +388,21 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
>  \item[\field{queue_device}]
>          The driver writes the physical address of Device Area here.  See section \ref{sec:Basic Facilities of a Virtio Device / Virtqueues}.
>  
> -\item[\field{queue_notify_data}]
> +\item[\field{queue_notif_config_data}]
>          This field exists only if VIRTIO_F_NOTIF_CONFIG_DATA has been negotiated.
> -        The driver will use this value to put it in the 'virtqueue number' field
> -        in the available buffer notification structure.
> +        The driver will use this value when driver sends available buffer
> +        notification to the device.
>          See section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Available Buffer Notifications}.
>          \begin{note}
>          This field provides the device with flexibility to determine how virtqueues
>          will be referred to in available buffer notifications.
> -        In a trivial case the device can set \field{queue_notify_data}=vqn. Some devices
> -        may benefit from providing another value, for example an internal virtqueue
> -        identifier, or an internal offset related to the virtqueue number.
> +        In a trivial case the device can set \field{queue_notif_config_data} to
> +        virtqueue index. Some devices may benefit from providing another value,

"the" virtqueue index.

> +        for example an internal virtqueue identifier, or an internal offset
> +        related to the virtqueue index.
> +        \end{note}
> +        \begin{note}
> +        This field is previously known as queue_notify_data.

s/is/was/

>          \end{note}
>  
>  \item[\field{queue_reset}]
> @@ -468,7 +472,9 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
>  
>  \drivernormative{\paragraph}{Common configuration structure layout}{Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Common configuration structure layout}
>  
> -The driver MUST NOT write to \field{device_feature}, \field{num_queues}, \field{config_generation}, \field{queue_notify_off} or \field{queue_notify_data}.
> +The driver MUST NOT write to \field{device_feature}, \field{num_queues},
> +\field{config_generation}, \field{queue_notify_off} or
> +\field{queue_notif_config_data}.
>  
>  If VIRTIO_F_RING_PACKED has been negotiated,
>  the driver MUST NOT write the value 0 to \field{queue_size}.
> @@ -1035,13 +1041,22 @@ \subsubsection{Available Buffer Notifications}\label{sec:Virtio Transport Option
>  
>  When VIRTIO_F_NOTIFICATION_DATA has not been negotiated,
>  the driver sends an available buffer notification to the device by writing
> -the 16-bit virtqueue index
> -of this virtqueue to the Queue Notify address.
> +only the 16-bit notification value to the Queue Notify address of the
> +virtqueue. A notification value depends on the negotiation of
> +VIRTIO_F_NOTIF_CONFIG_DATA.
>  
> -When VIRTIO_F_NOTIFICATION_DATA has been negotiated,
> -the driver sends an available buffer notification to the device by writing
> -the following 32-bit value to the Queue Notify address:
> -\lstinputlisting{notifications-le.c}
> +If VIRTIO_F_NOTIFICATION_DATA has been negotiated, the driver sends an
> +available buffer notification to the device by writing the following 32-bit
> +value to the Queue Notify address:
> +\lstinputlisting{notifications-data-le.c}
> +
> +\begin{itemize}
> +\item When VIRTIO_F_NOTIF_CONFIG_DATA is not negotiated \field{vq_index} is set
> +to the virtqueue index.
> +
> +\item When VIRTIO_F_NOTIFICATION_DATA is negotiated,
> +\field{vq_notif_config_data} is set to \field{queue_notif_config_data}.
> +\end{itemize}
>  
>  See \ref{sec:Basic Facilities of a Virtio Device / Driver notifications}~\nameref{sec:Basic Facilities of a Virtio Device / Driver notifications}
>  for the definition of the components.
> @@ -1050,12 +1065,31 @@ \subsubsection{Available Buffer Notifications}\label{sec:Virtio Transport Option
>  for how to calculate the Queue Notify address.
>  
>  \drivernormative{\paragraph}{Available Buffer Notifications}{Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Available Buffer Notifications}
> -If VIRTIO_F_NOTIF_CONFIG_DATA has been negotiated:
> +
> +If VIRTIO_F_NOTIFICATION_DATA is not negotiated, the driver notification
> +MUST be a 16-bit notification.
> +
> +If VIRTIO_F_NOTIFICATION_DATA is negotiated, the driver notification
> +MUST be a 32-bit notification.
> +
> +If VIRTIO_F_NOTIF_CONFIG_DATA is not negotiated:
> +\begin{itemize}
> +\item If VIRTIO_F_NOTIFICATION_DATA is not negotiated, the driver MUST set the
> +notification value to virtqueue index.

"the" virtqueue index.

> +
> +\item If VIRTIO_F_NOTIFICATION_DATA is negotiated, the driver MUST set the
> +\field{vq_index} to the virtqueue index.
> +
> +\end{itemize}
> +
> +If VIRTIO_F_NOTIF_CONFIG_DATA is negotiated:
>  \begin{itemize}
> -\item If VIRTIO_F_NOTIFICATION_DATA has not been negotiated, the driver MUST use the
> -\field{queue_notify_data} value instead of the virtqueue index.
> -\item If VIRTIO_F_NOTIFICATION_DATA has been negotiated, the driver MUST set the
> -\field{vqn} field to the \field{queue_notify_data} value.
> +\item If VIRTIO_F_NOTIFICATION_DATA is not negotiated, the driver MUST set
> +the notification value to \field{queue_notif_config_data}.
> +
> +\item If VIRTIO_F_NOTIFICATION_DATA is not negotiated, the driver MUST set the

s/not//

> +\field{vq_notify_config_data} to the \field{queue_notif_config_data}
> +value.
>  \end{itemize}
>  
>  \subsubsection{Used Buffer Notifications}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Used Buffer Notifications}
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
This is the time. This is the record of the time.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

