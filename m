Return-Path: <virtio-dev-return-12569-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0705C77B75
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 08:09:39 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 0E06811B66E
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 08:09:39 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F14B19866BD
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 08:09:38 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id E5F1998665E; Fri,  5 May 2023 08:09:38 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D0FB998665C;
	Fri,  5 May 2023 08:09:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YvtRjC/1yrL1g6BtgzFqr/uYt50iIJeX5DW/H/9NLp66Cz4W4NdAq7oQVYZJfMY/MH33/XxEKug830wgfEiyq7pok5sFJe/scARtNNPg+QXdqH1jq/+G6E/SqushuXI/HOXrjuB8gg8IqzekpEeOo+2BojWB6AOHOl27XWMFjPAHuM1iMXE5eGTXLdm0NT7m+cCNn4/mttPnRoyd2M72PKU5LsgLGypy6en23Dp6xUVnfXt9M9IhZVuKhtDsrhEhCJIT+4FuICENU9t86mfL4HtfGwG4zDnPo/4JQDDTT0oh8PlMNyRNf2PF2Xqt+aQ6IXwvu1IpQP/Pmlfy1icM0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8DtZxKAlsPHU2N/iQ84W86MP6wH9RVWSqMJk41JttFE=;
 b=KqyEGRcyYb1OZb7Fxrlv0eE0T3eU0wb84O0Z/E6W4Xq20IPQ/i3rEJ6i6V862bzlxpZVxgle2kRNhBq48o8oQHLT6fg71EOMY++T2fDjRifp/xJVdD25+uPekddE7WzDExxqgHlYHylPh6K4f87aspG0apJmTRrxvQJmtROZBEWPmzUusm0dlxCtX93TASnFjXTFFMzFYBiBNx5T9M1aFIV9eS3sNXoDP4qc54H1DOAvfXPAKiqw1PhTkfQ9N2EeI7+VBBRmUW9dm/hipTR/2/5PkTzh00miP9VhJfJ6lSoEGuy3ojPmCPSLNwo6as5R8I4eEjDfoZqKktF9kuEcKw==
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
In-Reply-To: <20230505014614.571520-4-parav@nvidia.com>
References: <20230505014614.571520-1-parav@nvidia.com>
 <20230505014614.571520-4-parav@nvidia.com>
Date: Fri, 05 May 2023 09:04:19 +0100
Message-ID: <m2lei34324.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0050.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1::14) To DS7PR10MB4926.namprd10.prod.outlook.com
 (2603:10b6:5:3ac::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB4926:EE_|PH0PR10MB4805:EE_
X-MS-Office365-Filtering-Correlation-Id: ea005847-2e6e-4223-46c5-08db4d3f5776
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	LIqVFtyERRoHyyQW2Tze+oZj7pfU/db7AWCJiFommy4mdViMZiUqwXtqlkS3slOQJVXcCiWyYBFifOPLTz+gXPA0rDBxL6L9p3coYpfELpSI0emx0eDTgNEOiTSYwXvYWKDH+UMPOouFA2YfHUL7L1eFqdseKSpk20CWjAlSZeJjo465QzazvlyT2RWVKcm6yU5rUt9d2sIy/f7l1ovG2LO6NR/67CnbwQWTdAGfK8wor81zTqBzZOqiMUiv2t6CgnIdzwfWKOhclKcdLeA24PTZanaRCm+p1iYz9artoQ3p872hKEz1Wm8pHpgDyt2iI6NeBdOWVRSEBSRrJj+/wbuJEBiRuHWkHv2fWc3uCPsXRVq9MJjANchl6Bx7eJTrYwIjUWn2KytehvS5vtQK2EZfvtk3Fh9QWUfvgS5k6VRKWCVIvhpjzS7FoRT9EMd03Xve4rKo95bpmwemYr7REJwHY7FREEQoD5/iwrAe9B3eJoc2AkZs7Y4+7BuoVUYIEWUggvz0DpJg0yUbyCHFKeZmRJSaEzqh/SE4x1nP63Y=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4926.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(346002)(136003)(396003)(366004)(451199021)(86362001)(36756003)(316002)(66946007)(66556008)(66476007)(4326008)(966005)(6486002)(478600001)(6666004)(41300700001)(8676002)(5660300002)(8936002)(30864003)(2906002)(44832011)(38100700002)(186003)(2616005)(6512007)(6506007)(26005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?nVhERgtQ2YNYhSjgc89Tp9qjeNpCbQ+Rpq7hisfeOdEFOdtIDOxhBKxJKlme?=
 =?us-ascii?Q?6Zxs+BaP88yZlejzttpbv59yhwpiL2xvr/N4M1ktI5tzaOoWg6cm64mJPILk?=
 =?us-ascii?Q?vpGYAQLU2Nnt89hfod+G0upvsjLCfnz4tHaHf73GYZ5iQThOfKJ+RFay30Ae?=
 =?us-ascii?Q?NbxWdW4itrGC31SFut1uR1TBY79pdxZfrAYkVQx6y/C4XiyGBo2xJWI6py9R?=
 =?us-ascii?Q?3B3/d7czSZJjxYKdtOsz7nN3YPVOZTluxIY3Y5Kii5fp1TsHIl6pXxcwZvUm?=
 =?us-ascii?Q?1H7qEO1VWWpKG2g6NMM6PUhwQbp9LSFEsFmAUs60ZSf3r/QcnpAqu15euuBE?=
 =?us-ascii?Q?LO3OjUNuO2/dSJnD7Kxf3V0DDrY60fhJqn9j8XU3fxRVU/93egrJLc1XGvfc?=
 =?us-ascii?Q?7L5GzK9vSFkE0wEug27yx1WlsF7ikYw+1w9DBPviL/qGLuaeJ8dZCcd/KzeR?=
 =?us-ascii?Q?guZrRfJRQ9IuY24n6+kfeex2tqGicwLqCSo/+EDV7wVW78+RC0ojG3kysVY/?=
 =?us-ascii?Q?5gE2wWJRUR1ITXWyh9nkbfmFcIdws0qRu2quIENQ/rz7E5pk6gqrmYJ/I0EO?=
 =?us-ascii?Q?m5JpZYqWBrDbjE+HUxqOdHogVz+HYpoWRWhwTR+CLHr4juFkv+B7+qWpyK9V?=
 =?us-ascii?Q?VS+jH6Kvhn+cuq25X25LusUCSDZ34VQD2cf2rw6JAvwNEpRUBlIOqjAxYQ5I?=
 =?us-ascii?Q?2cr7HJmHvcm7N2sVGNVjsshvEawtmVFDb0I1psQd9JKjVYaoZvZNwhzL7H+N?=
 =?us-ascii?Q?1cTAdCDHDhs7FsBe0AwJMD3QPj9oADhIu0Ki/sRO51P4/CZnG1cgjvhgjnLI?=
 =?us-ascii?Q?CyftO394SdQ9Kn6kRqBxFKOsv4HQoSmPDdcqA9jGkcSg1EPvjpC2QETbpBDV?=
 =?us-ascii?Q?azuu53rqVDGGTLr44y3QYDg4Pi61wBIDbLZs30wxuCS4rqYBQqSHkBLAkw0Y?=
 =?us-ascii?Q?+MfQxTIapt3/bG+WdsIcVYahG/q9nfYhjVD5pBjFuyjj4k9kCerNRtN8xe3s?=
 =?us-ascii?Q?Tqin2Jt9jpaA683nEy4Foe0JaYFCEzrAq/MYdokYJtPA+54j52Okb+jdWvZX?=
 =?us-ascii?Q?UiysLTJdZ+AHjimKR7LRWzsdxcfCo0R5Lx2iqiI1q+AH92MJ3VA9N61CqzZH?=
 =?us-ascii?Q?6iLLRCd7MsUG13xGmhgzQjEwNM1DgEUV9j42urZiY5ge2mcvRCF02HgwMGU+?=
 =?us-ascii?Q?OsId/QPmSJwg9wIax+xhV/NJRfz+F10YpA2KZaldCsauby7kCLYKbiXB99Ax?=
 =?us-ascii?Q?7exzHiYYa4V83dzLqeQ+BJGECXXe78FEnom1RHCudKPRsbK+1rib973qw5m5?=
 =?us-ascii?Q?Tp33tKtng3IiPRf9PkCaBnZ0IwpmV+yWIPfSNrW7a8KOU86G7MlQ5r+yebsr?=
 =?us-ascii?Q?LXTNNVeINLO+dgddYoChPMlr3paJPalXP5Cz3EtxScrpq/f4ow3Yh/nBjVuc?=
 =?us-ascii?Q?igSistqVGZgQGdTsDr/n2V6rVXNDRqkPA5WoWdj3NOOAPixqW1RzTs8zJ0rt?=
 =?us-ascii?Q?/FVLtGJv09SV3euYu0K2Ux3Ju4gumSVYsC8yZTHDMLzVln01oFzXOZOAPhnw?=
 =?us-ascii?Q?T7EM4WTB14SowhTgNV/bgW9DLPsGlIIBaa0C+/MmuySgXNqCja2Rgm0p2bAV?=
 =?us-ascii?Q?Ag=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	pr+lrbBscCoPQvWNgpurTvbO49dJJDfY/xmNln80sNaKjKecao1nzb+esQfOktIszWoYgMLri25L4BLAzTrqMkRZif5qqrSyd5fwpujMP/TodVERzz3tVkCa0vlrTxWF+yD7R+usX/EltzZequ563IpVlu+6O3J4xEwy3Y8ROqA/iOsnm8U3ANfJ3gVmleKKvRB4EdnFXvBxNRdntTwRA6MSioT2nyR6MZRYXVTbGtUaTF9jP8p7mNtFwdzSfrJdfwgvw9bMu17kV+vyh3+RZIUL8istk+EeHYWz++R3mRCMGX73b4GzjlwiWxmrkx0FU08rRcY/RBqn/uPHD4oCznV+TfAtpD+GBY+staHXrgnnO0lSmWaYLCTxEngL8vnUgGxVDS9YBS6WKHRaQ/Wzu3vgHULVEvHT2013Y8IzBLQw0OQdhT2hV4OOHRDFM+uIx9dEbIWD99GKSsa1iRKn5/zwwLMxVVAUW0aljz5xIp8N5xlJOpbzl5tFce4u2A3oNZfOUdbPbDhYaN/T6C0XjbP3wYFtMe5XMa4OfTrnnHM/OamOh8G547HBoKqVb5shyrPgNd6fu1mE8qREiqX7IpfqkRMJTQQjyL64He1TIaNYprnfOxftsCsdHUOv4f8oQuOlQ0yRxZVcCMF+dWhnridSWcR0E5PHEm01E70qjCnP0mFOpq/TIEq4IwyJQPrnGAg5y1ErTYF0pgu7LdFxq8Yn22MLL3bo3NyM1vvVm7f4UvR3IsAcKkKEjxDUm8YwGf0erZ23MjYh/uecxPhPr35XWdeW6cpKk/U76hK+d/su6u/IrzPChPzM3eyum3L7r56e6LZc0NP62339vkqYR2Tuv7fetfP2mxnZlWzOI+HAuJNe+zR0ESCdjEla/xx+
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea005847-2e6e-4223-46c5-08db4d3f5776
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4926.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 08:04:25.1123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6WNvfWES+JxXut1HQ6UqyOD0zkfjvKV+cozqwnnFqj7SZtvtqT7d0gkj8QamNQ3LMZYaG6Xv7VBdSFtgnvVoBUlJLidU4Gm+q+2NiOo9kE0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4805
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_15,2023-05-04_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305050069
X-Proofpoint-GUID: ERdel9CTtoN8WeeNCSb8uB2NKHNONPuI
X-Proofpoint-ORIG-GUID: ERdel9CTtoN8WeeNCSb8uB2NKHNONPuI
Subject: [virtio-dev] Re: [PATCH v17 03/11] content: Rename confusing queue_notify_data
 and vqn names

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

Reviewed-by: David Edmondson <david.edmondson@oracle.com>

> ---
> changelog:
> v16->v17:
> - improved item name
> - dropped suggestion to itemize two normatives as it reads odd in pdf
> v15->v16:
> - fixed adding article
> - replaced is with was
> - fixed incorrect type of 'not'
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
>  transport-pci.tex       | 71 ++++++++++++++++++++++++++++++-----------
>  5 files changed, 70 insertions(+), 24 deletions(-)
>  create mode 100644 notifications-data-le.c
>
> diff --git a/content.tex b/content.tex
> index 9cf938c..327926f 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -405,8 +405,12 @@ \section{Driver Notifications} \label{sec:Basic Facilities of a Virtio Device /
>  notification to the device.
>  
>  When VIRTIO_F_NOTIFICATION_DATA has not been negotiated,
> -this notification involves sending the
> -virtqueue index to the device (method depending on the transport).
> +this notification contains either a virtqueue index if
> +VIRTIO_F_NOTIF_CONFIG_DATA is not negotiated or device supplied virtqueue
> +notification config data if VIRTIO_F_NOTIF_CONFIG_DATA is negotiated.
> +
> +The notification method and suppling any such virtqueue notification config data
> +is transport specific.
>  
>  However, some devices benefit from the ability to find out the
>  amount of available data in the queue without accessing the virtqueue in memory:
> @@ -417,7 +421,8 @@ \section{Driver Notifications} \label{sec:Basic Facilities of a Virtio Device /
>  the following information:
>  
>  \begin{description}
> -\item [vqn] VQ number to be notified.
> +\item [vq_index or vq_notif_config_data] Either virtqueue index or device
> +      supplied queue notification config data corresponding to a virtqueue.
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
> index 524bfff..aa9842f 100644
> --- a/transport-pci.tex
> +++ b/transport-pci.tex
> @@ -319,7 +319,7 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
>          le64 queue_desc;                /* read-write */
>          le64 queue_driver;              /* read-write */
>          le64 queue_device;              /* read-write */
> -        le16 queue_notify_data;         /* read-only for driver */
> +        le16 queue_notif_config_data;   /* read-only for driver */
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
> +        the virtqueue index. Some devices may benefit from providing another value,
> +        for example an internal virtqueue identifier, or an internal offset
> +        related to the virtqueue index.
> +        \end{note}
> +        \begin{note}
> +        This field was previously known as queue_notify_data.
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
> @@ -1050,12 +1065,30 @@ \subsubsection{Available Buffer Notifications}\label{sec:Virtio Transport Option
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
> +notification value to the virtqueue index.
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
> +\item If VIRTIO_F_NOTIFICATION_DATA is negotiated, the driver MUST set the
> +\field{vq_notify_config_data} to the \field{queue_notif_config_data} value.
>  \end{itemize}
>  
>  \subsubsection{Used Buffer Notifications}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Used Buffer Notifications}
> -- 
> 2.26.2
-- 
You know it's not the twilight zone.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

