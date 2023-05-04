Return-Path: <virtio-dev-return-12548-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 687DFC7EE21
	for <virtio-dev@archiver.kernel.org>; Thu,  4 May 2023 14:28:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id B4BC83263B
	for <virtio-dev@archiver.kernel.org>; Thu,  4 May 2023 14:28:31 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AC2559866C2
	for <virtio-dev@archiver.kernel.org>; Thu,  4 May 2023 14:28:31 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 9BDC29866B5; Thu,  4 May 2023 14:28:31 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 884E39866B2;
	Thu,  4 May 2023 14:28:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZYCVh8anWX0tmoJqeR71wPeQKhCPTuwf00GVZ7xYD888WTyYQaIposAj0mPGT/Fp2P4XgVcA7f13tllUcOMt8QJuO6giptoWvaS0i8fUEiTRKZ+27MiMbzlDED5DQLzzldiK2AmWhu9QdcO5RiBwMiHq2lKWVcdJZNRPe3ih32KW3lf0X0Npr0JUnzt4Bo3v8I2Q5I/MwZf9I2aO4LRGG+L/e0wIIJPQpIZoUJQ+M2cJGeUHvQJe5qrZ1JhABZB/1FsyGN//4kPE2SI1KYQqvc6mwe4NGOd0sNjuDb3XbGL9BgHm16D7/dTsvy+r2cZwBEXv2LrTRSoV931oWLQ9lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/o0qShZAbI1CcMU4oaMUis7kZDxbCH6nyrxqAl/pIso=;
 b=ExBih+NRMBA9wosi5SnMzD7+IZuZEIm5o1LCp6U41diCG+6UtmcduNyh9jyqRLd4pC8j1ul/CvDKpOUSunr4oL13Q/EK7uc7OULFOM2jDmEJrr0hic2J0QAOUn1q8qLDC3UeUSV3a5PkQeNlZJ4bgAEm2v/DKfH+b1xdTh6JkcP1rnf6lLEZsva5yB/uWBMRP2Xh+aoDZ8z/QcZD/LS/g4GVyOnpKBEbQbb4kXcbeL2lMk78Bb4t/DEdH2h4uorCs68dbz2OU86poyIwPCzuUkoIfDd8ws5HK9H9KA4L6BIzXwfLLayrWXAqwewNhzTr1aIw1aZ8D9NSbZR9DppZYQ==
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
In-Reply-To: <20230504022959.547025-4-parav@nvidia.com>
References: <20230504022959.547025-1-parav@nvidia.com>
 <20230504022959.547025-4-parav@nvidia.com>
Date: Thu, 04 May 2023 15:28:06 +0100
Message-ID: <m21qjw5fyh.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0390.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:f::18) To DS7PR10MB4926.namprd10.prod.outlook.com
 (2603:10b6:5:3ac::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB4926:EE_|SN7PR10MB7073:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d97e06e-fffd-499d-3027-08db4cabcb7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	yh0vssgHNdhUhM4qvuk1xyLjVS2Zc5q9+BV/q3VYCitIDnV8J8ZgByFu8zze3KMKcxm5lVq6GAfRghi0KP09UHiacbaRexcoNZsjIJKou4GOyhPtGWllQw0XyLsdiFbw+KTivdjJpvlP7Ticc5g6b5ShAJ1CfRAwjVCQKqfbfg/TlOkbZlInU2ppCi2SOrFgyjFqE+5Hv5ZlwqUYqKZxl294YSgkmMdcp0JxZmzc8DczwFuMSpnMGPAo54QPsGF1lcbBOBojAxeQOgU4SMjIyMBSCvOrGi/5rW78W7RD8lPILftuf04OM7v314e225xXuTiA8IdtxXWLJdV1kwjjGluk42UyHPYTpZq26zaAC9tay4WHx31cZ8LhAeRHuTWGBjwboQUBa8MOmrGWq5F5T2aH4cmNqb4u/v8t8SbqS+6DwcyCEwD1+9cmfyVnxkpqX6dgbiDma90t83H7OrPXBR91b0KbbLnH7X8ej0waFUZbbvjIzrD0ef3iLLpiCbll0Hj6e9zIWt9YObRjVvdqqNjq1Lr5g9zP/nw+1OpVCxM=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4926.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(39860400002)(366004)(136003)(346002)(451199021)(83380400001)(8936002)(38100700002)(41300700001)(26005)(2616005)(86362001)(6506007)(6512007)(44832011)(5660300002)(8676002)(186003)(30864003)(478600001)(2906002)(36756003)(66556008)(316002)(66946007)(4326008)(66476007)(966005)(6666004)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?JWv0pC0qHtIn/qeLqVviFyhiJNpxlsH+y3FzMSIk7qca67dVoxhUcnWZpXLI?=
 =?us-ascii?Q?ZRDRDHfqOen9c/SjOQw1k19k2ZvQLQdwTy3plKarzsME1PhWmpBgRf8aMm0Z?=
 =?us-ascii?Q?pVIHW0WZ5yMPa+f1dxHy27j0J82UZlqKBDcEWwxGgkPCvPw+3Heq/nZXPeEl?=
 =?us-ascii?Q?o8QdbAhB4JW6EaHrSYcaLVlxmAeqmuAKHler+51LQDutqQXqohFjrVkHDe/q?=
 =?us-ascii?Q?eW91Qe5My6HvcOrJ67uixlm6YAIOxZTupV5Qb/MI00d6UbRBienC9FBain8b?=
 =?us-ascii?Q?qYrc4m5jziXsAxieQBjT2Pl6Z8pUK3oHJ2u6GojJjt63cyTRH6IZTVK+wTwk?=
 =?us-ascii?Q?I9YRjAMFu+pMI/aZGBRieHlkwNWA+C9XlZs9NJ/yGeoSrYZ2jwj/qHK7u29q?=
 =?us-ascii?Q?t+le0B6i0uDN0TjQf7qGQUQIQSSIoVP32hQuZxB7gFid4zSS1RaUooYa/5cl?=
 =?us-ascii?Q?gGBqkozeZgmlJFqZRmk1ew0IFf09Rw0bBnPNCm96nN+ZKs7p67YvcLvq1bZP?=
 =?us-ascii?Q?/GAedlbYjrrzbuV6FGXwwoTFAFfvt/tVK8UUszxcNvFNDS/c03FA+X+KmbfK?=
 =?us-ascii?Q?m06TleDhAKHsxwzFF8GBmWnzy4fM6uQz5pFtIJLjMcdRhUL5cGfF5+k4qKbt?=
 =?us-ascii?Q?24GBCoums5WBIxIn4U0UG1k3UYpNCe0hHrSnfSo2tOPsLDX9cz39h7ZH0SH4?=
 =?us-ascii?Q?OCZB9ZRFdd4Uh6Sui5i/3l0KCZSTV9OjbY30yaFyemErLTyVxq/gg9XRT1uo?=
 =?us-ascii?Q?CWU0bjJ3op3cnpM7JUNeCXFki6uriQXajqU0XttrdtWAVOS+xhu6jmlQeoZe?=
 =?us-ascii?Q?doCGsvQf2mWr98ket1VJaCVOVCIf/Xkt33zWAM/66cb0kqJLlznpFdVJODhh?=
 =?us-ascii?Q?bkuwaNb/4ABhywWPVmDXQpnNuWLSIhnNyzvOM8cRPlhV4igqq7Rh8xdwxXN3?=
 =?us-ascii?Q?IUf2RQPIgJrWilHWk3xl86UkZye4oswZn6XYtTHcCuJA16lzXfVza3WuQzx6?=
 =?us-ascii?Q?7O6XeZamrAoS14kf7U6AzwkVmvaRvtRWGbAlAvL5l9LJlg4SFV7Dzgd2bW4y?=
 =?us-ascii?Q?xRB146GqzQJ3DzhVySV48Zjmkxwx6gXGtX9xRayIhxqlZnXMbajRwoZCnoXY?=
 =?us-ascii?Q?eSXI0FPquk5WgV04cN/bsKfYumpMP2nWY/O3dhYAYsM5d3ypJ9ByO7nUFTJh?=
 =?us-ascii?Q?maqHZYmJER+M3Gx7hwqld7O1U6mnq+mlIh59pVpxagnm7EzhTVAnpJ8UNajB?=
 =?us-ascii?Q?XaVbvs0M1uVbdA9SEOwTWpU3HB5WhThoyiOQrq6m4OOFqze2Vh8EYxpdWMat?=
 =?us-ascii?Q?senCVpvloFf5z83/Oz5qXIipClNYkRIFtEXXOQr9u9LqF4k/e5pnLrhpOEUE?=
 =?us-ascii?Q?JPFJEpkIRss2/zJjWKlmMT1+4EtdkfEkIbquQ2R7EmhKOFOf8uS3NnBBXzOO?=
 =?us-ascii?Q?r2J4u09cG7ZUaDWshQ7iWc23sOThHGOwERj95GqY1PpbMvclFljoBOgE7ktP?=
 =?us-ascii?Q?5MJOGbL1E9AUP83nmvJwfuUI3Ce6NzbcZRyBp7NquZuMNGFF2m1jggsQ1Ik+?=
 =?us-ascii?Q?WdvwpvO6VGdKMFh9Xpo0IS5jq1gBTrGJ15E09zE+xxr+cSRhMxCEbax/3mjn?=
 =?us-ascii?Q?hA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	sziKnFENFxXCWdfQOgTkNqBXQv613b326ZB0b4UM8yS/zQmy5QHYKt6yyqwKv+8PjBNsL5kq4lMNxyM33X1f7pzXKKEk0OzNq3Y/sPbVKgWdRad4ceSNZD06x1dzOSNL6pgyi9GII9wAewQkQuPGKxw25sVJh/wh9uO4tEyR99tFCVcvVmeaXs4SkxVvhm0TLODFbg0u2LUq5bcYVYOIs9F7o+PGcBJsUE6NfXIL4foOpMEDTMPjkVOZhjHNah7Py6rzjbVDfb0QeeqsDZ3Pc9W5vSctmHCp/N71uh3rEkwCz9SprMkFqaNsfbc43UASdIHki8FK7iLpN0wnYdWOWVKOvLA/7QY06dIjGIg3015+duUxvTwbxc0ptEjOc5uknbA7cmP9Ddl7iu53cfbLa7iXBihernqGk56Txcw6SRNp7/oeeJGh1vp/t/LQLZ3vHAG5UQhKryDSssHOJGXL5gLq3+mbXwZ6rw9bAGE4ygTOgMpGAceN4eXaiTlDBUl7fmOP6YDGNOqeWVg0UN6WS1cQJDgX0hQ5e0Fl6G6brx3Vw8tYqzIvbH4Sm3qhx9lpUWymYMXd7IPeK93bnKKpjuT8H1PgWQgZHGiVUUx4RywAdhTeJUemGq6QM5Xd2ibCgRP+8dVt3NuGmpt0MifOjQ1PbiqpQtYo42CLVCNlG74ijTevf3QrB6PNK0S80XPjQeF85I7lGttkbGQrVJd/1Jkr+dv1fopgndrZCJDBq1lSuDugJyMNz6u+EZtP1MJAy8dysezGoAgJYwiuvIGrNY/1mP8itNGjYOzL7PNDgoYGDLzis8vcf69V8++/VOpGE+PDQWCvgsZUo4D7CB5w/N0ZkyJpd7rO3E3drm52MiRswX2f/mQNkdV2I/qjuE9W
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d97e06e-fffd-499d-3027-08db4cabcb7e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4926.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 14:28:14.1491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZTJrX5LMnnRrtdqR+9EAwIWP/bKO2xVIkv9oQfGsyvb6pflyq0KEZfis3/vNfRteYaq1bshYyfcOTZQE0gmTzKvcBbzyG+FitHAfNOOy8Pk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7073
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_10,2023-05-04_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305040119
X-Proofpoint-GUID: BwbMA7F37qApABiAVJ06C373w9hY1oxM
X-Proofpoint-ORIG-GUID: BwbMA7F37qApABiAVJ06C373w9hY1oxM
Subject: [virtio-dev] Re: [PATCH v16 03/11] content: Rename confusing queue_notify_data
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
> ---
> changelog:
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
> index 9cf938c..8c5b07a 100644
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
> +\item [vq_index_config_data] Either virtqueue index or device supplied
> +      queue notification config data corresponding to a virtqueue.

vq_index_config_data doesn't exist.

Given that this is an anonymous union, perhaps:

\item [vq_index or vq_notif_config_data] Either ...

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

The above two should be inside itemize?

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
Why does it have to be like this? I can never tell.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

