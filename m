Return-Path: <virtio-dev-return-12516-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58BD9C77B75
	for <virtio-dev@archiver.kernel.org>; Wed,  3 May 2023 15:59:13 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 72BE74454B
	for <virtio-dev@archiver.kernel.org>; Wed,  3 May 2023 15:59:12 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 695D19866B8
	for <virtio-dev@archiver.kernel.org>; Wed,  3 May 2023 15:59:12 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 5A15E9865A1; Wed,  3 May 2023 15:59:12 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 453CB986594;
	Wed,  3 May 2023 15:59:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LCMf3tomhQJr8TUJpbLeALrPcYU7XSrYHo/wJMTq1k3EpIIYojJ/q56ms3/gA93GRSGyOnPUx7BhaugTtvQFLi7RH3C6sBne1CMT0nFK12uNeUlOlqH+YRo1V43vwG8mjpgIopuA4fc46Nk0T350iorjipNVVsx+GyJaN2u4jA/1cXwnDy3DC1/tajWekXFpMV4q36hOgf1M5kGBva9E0MZIrAEI9omd8e9bIf6IDhPT/Cnbu9nhcqcUkvsbtUBPLNKoX39l/BgqkZdvEtOdq9ggtqCr03kIcFepzLI7qAZJgEetdcT0haKMRVc9HFE7rtTvS3l5ZOgCgOwIC0jxog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aS2NSU93QjrAEjt9PQ+LYp10gV75DJdFYCk8BVI+GCM=;
 b=IdSzIoWj6/4+5JEdxIJWDw+MrB3O8Nf5cPlcDhRV74iPgeGFqJ66Uq3vgtJY9e7xI3BjIgf8UB98x9HL9OrZKIeJVj1EnVkqMr+B5xacuRexuIHza2ixgaUL5qKI8BOVXTfYyGm7jB3bjv5+0fXFqJ8r0X1N2/KjvDDZ6HKYoQncDZrafe+DY3LuLHboawL1nH6y+6VziQCpl9byhkl/djahfRAPKZhKVc2FvhD9t1GIbvcT7nks8hYDB0yC86HjjqFdNtQ/nGg78OFb6g/AdP5rscmNJl+GtV3ZOnRP54jzerdldgj/yvsk8gnzRRBd/lHlgVgOJDZQqNQPezlhbw==
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
In-Reply-To: <20230428041949.411221-11-parav@nvidia.com>
References: <20230428041949.411221-1-parav@nvidia.com>
 <20230428041949.411221-11-parav@nvidia.com>
Date: Wed, 03 May 2023 16:57:52 +0100
Message-ID: <m2fs8dv24f.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0090.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::23) To DS7PR10MB4926.namprd10.prod.outlook.com
 (2603:10b6:5:3ac::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB4926:EE_|CH3PR10MB7630:EE_
X-MS-Office365-Filtering-Correlation-Id: 0980d1fc-d045-4815-9619-08db4bef2a29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	OTYSdGATzg+zcJpdQ/9F/U84r8CWs4NjN4w61Ky8//NSmGfihwxnb/J5Yct1W8ncSo/qPWC3ciiR5fgW6+G/DKxWKQJMQ+0Vtx8+lmu0xJ4EJQ47dBmj8bhm7pEQKVnzhzkc9Snyj+WJPbdTNNaGg710ud0nxPWENQU4zBjmGLLDUvWuBJiEKrKWxj8kWLLhyS0N+MK0l7hpwB6t4RdsnkZ3XPee5BN9six1g4hmc+ByNceEvZeBd3vDVnj3WpLStBDhZKTLaJpu4s//nUGJmkLCnDuqKzI5TIoVw3g3pguPL+vvya/9x4UfixeGhmY8uUNn0MimttQm8VsTvyiksBRX+xa4Fa9700rarRdnH3oDHJxTtVSgGlqJbpcjAiGLGZfXu2AZyI09IFUEidOYmsbLOh8ULNN3w2NPVWbmMV3IHbmhzBPnfENE9Hhz/j1q6g8tFRRDri7df08Fk1dP7oJAvMDzXwtMcfDkEmEmnbGjkjVjqwsXBkQ0uepN+RfzadNSFhzQNUODweIB9hYKEDMJQ3Kpi7dgxBXpC2Da7G4Uq7UbXmVlBTddoQU+HqXunPUaaBGKdiGF8rNtrdIBGQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4926.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(366004)(346002)(39860400002)(376002)(451199021)(26005)(6512007)(6506007)(38100700002)(6486002)(36756003)(2616005)(41300700001)(4326008)(478600001)(66556008)(66946007)(316002)(83380400001)(6666004)(86362001)(186003)(44832011)(2906002)(5660300002)(8936002)(66476007)(8676002)(66899021)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?XfhhRP3BAm6b2ma1hwfxetxqb84b11nkiNBBLLCasyKeiEzmZ0sMqLTGn/iY?=
 =?us-ascii?Q?sE/1ibpg2BFywpW2P5glKBUIiDg9nzK3xRrRI3VApogilN8iIXaJdULEGavw?=
 =?us-ascii?Q?vAxodQR8PfxfAspZN1u/87lohZF8ZTVbcuZL6GPpNGA70yA2T3cxkh4P+WR7?=
 =?us-ascii?Q?wjfjnlK9B4zzGW3Xs7HtVcEQYowun6AYnvijefVFIMqdNeBTFys5xKzrfaIY?=
 =?us-ascii?Q?PusVZLGqbs7Kqfr3kBSvejwrGeL3esysDm9sx8Q79MAd2q5Ixinpu2AEkSnO?=
 =?us-ascii?Q?BgCIYt7TF0kzwd5EIdz2JJ/Fmv0gZLiaGBrMcUJjxsCWpelWku4brqKJ5AeH?=
 =?us-ascii?Q?4ZMg0ewNTwMY4O8bvEmkWWuAT3npM7ErAwtny6ZHgQ1WLH3eT3HHcuj3aC4v?=
 =?us-ascii?Q?lWC2BvNy2aRZYasIyaQxE1nOUHDwuPMhjhigxd8IXluCKfepLilfjahG3ti0?=
 =?us-ascii?Q?8n1IL5aZAyrSMK3BJ11l3JObsNX8e+JjS/w52ipLvSb72RH7iZ1lWF5MTsCv?=
 =?us-ascii?Q?G8NCpF1nDEhkMVQl5/yiO0LfjmpQnu+TQwtyHq5++v4KP0BTrsBydm/V0TOa?=
 =?us-ascii?Q?+p0XmKouUtLYsi3a/omrfRqYjXJuBQN6aGgLyLnadcsGccOpgpuM1WUtr+fx?=
 =?us-ascii?Q?UGGLj5PbLPoh6nKWm8CFGP0StK/XWVHNeQNGEfVbXyXVxIQ0LvEF5CoAuVEa?=
 =?us-ascii?Q?+qQzId22qu0a/TDwVuq7RaW28+SamIcTXlrJ2THSvUQctcTIlDkiPH07L2lA?=
 =?us-ascii?Q?lBVs3yEWjqhfLSIzmMJs9vQSgpWGufTEnmjWylfvKh1HIcWm6YqDXl1fdG8Y?=
 =?us-ascii?Q?zuLHBhJl/JqJN+fOqkIaZ9mfUPUUBkF95+OZSrbqO/v78swUaz0kQca8+azE?=
 =?us-ascii?Q?qQxkoCFxgn19ZItuMRLSnkhjJz+bdgqQasbqcfU8JCAQ2GURfgM5bItx1VeO?=
 =?us-ascii?Q?I/cgnqDkSqVuS+B2X0Z+n7yOGJoS9i+1VgFNld/sjSd/mrN2n+ht56GACEqJ?=
 =?us-ascii?Q?W3wAwHZkIjttZr3NNKXQVtBmX9R04TYBsBliA8KwYcoMkZxzmIrx7oYSMbyb?=
 =?us-ascii?Q?HX9SPfQ++t+zsUIJTYATOfN9rLg6fcm3zjMlw12xHRVwZsKA+arsrrQVPCkZ?=
 =?us-ascii?Q?gZ4YXYkPnXecKvxrAP+/pHf0QflQIChOSj1bddqekGKrBvJ5+B9CHl/LrVlG?=
 =?us-ascii?Q?gn5L40XMGblUCkjo+SOGvx6dHBS9nWv4bCJHjzSiNrvlb1JjLm8bwrNEHm67?=
 =?us-ascii?Q?sF1gozpExP9C3C3icSKYTw0bnNl07wKcxpIiVloLhmSVfJNvUARPOwIcoyDJ?=
 =?us-ascii?Q?F0Bn9065o9z8Bfq+YuqRPBzzw3qvykNOEsNZf1lCFweGhgrA44RQ+n1sqKv9?=
 =?us-ascii?Q?Y76ParIR6Nx5rOscVYYga5UmV1fjDsLSLFrZJ1qpSbbDQXsGrL6D3iHFVQt9?=
 =?us-ascii?Q?6I30ADbx1WcEyx6smsPQ5utRIV9Zh+yQ1MmRso4tmCFUZO3RUHJy5tj/zr7K?=
 =?us-ascii?Q?Wz7njymVUM2H6wp+Dn/qknAoL2rrONs+bRGYzhZYSYcFJV7maCmwDXbKAW05?=
 =?us-ascii?Q?HWUP6EyyyNPdwFYbq/oGHfpPrlQ9QwPU0DH8tF5Etdr7qGpBhm671tcVAtOi?=
 =?us-ascii?Q?/Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	fUu1HhTK3KtkE56tfgZqDCoiqRBB9Hbg8WP6WPdwK/gOpXqTshloj0wGldibV9D1mTICYsOAAkw8TwzrothhvwMsAT0YfQAdI+HlfwLxCO3QqpiVRmPHA8AZgKMF5kCk80/546m0vD6k8QyjPc7xFRXZoZJ34hIF2mZSpjioCXcfgrta0Cs/215P8NeB7EaOf64PD0I/T5TnSO7RDLmhO0soei2BKbLAdx9r9y/g86qQj3tQwTdTLV6jcaO7slM2Ci6HK+I/AztVQgTFsAF342EW+Drl1MHUjFzl3U54oZaE5HSoewYCU0BY6BYmda6ycly0dez8lfp9qucqkOfXoO58Tfy+3Iy75qW52OzXWRMniuY8QFIqPNYfLtR/UeTe0fke5CxYJAP4xXZWgG9d9cTJAJst1nCn5MkVHIpLBiHXxlqWQNZ9qKyAI9E2Ljkm8sAI94vjXMknRffannjSYqsJ2Xm7cSkiMa7dRAQMwwQILzubSXM9/uf174h+XpVA87eFWBmDXJDlT0siaA2mV5hIPn3dvvIRKgkKuumkMlUeTABchkrqzx/XQrR8ES6TwCA/BWKQ3toM948U7mYGZzUVO81VLATqo3Nmvh9gt0GrFNwODz4+o99ja5GWWCQ2TvjTrCzma7lR9mnMns1zofx6C+E4PQZtOpD2pfKH9yLS/44huhVZvoyV7Kmz6y0pvvg38dgoMsDBiVC9Ms8BxPYfTbRsrwPDmLlGCPC8Xig2jrsjhLIoHb1AVs9b/IOaFRFjEnsYe1ZgAxNb5KEgsvxVHnEE9XzkK0AsvfGDXlRGsCKEyD84/FBj+B7uFEmB+10zzz6pYk+FeQPz96iuRN0j6QvuUqUR2qhw0aaor2hlDCwXbmSvY2xZ1azUUIJq
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0980d1fc-d045-4815-9619-08db4bef2a29
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4926.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 15:57:58.1903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: guz5OQapJ26qT7NIiXDx9LljYJGebuTl4cs1d+fX/yFIxe/JNzt5dersDBVOwXCz0t9xQDOxaGXwKbpCxZKjaPponIzJf15wiPa9c2yEnLU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7630
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-03_11,2023-05-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305030136
X-Proofpoint-GUID: dblnYA7zY5IAtWoVx8GIxJGCDPkNGA7B
X-Proofpoint-ORIG-GUID: dblnYA7zY5IAtWoVx8GIxJGCDPkNGA7B
Subject: [virtio-dev] Re: [virtio-comment] [PATCH v15 10/11] virtio-net: Describe RSS
 using rss rq id

Parav Pandit <parav@nvidia.com> writes:

> The content of the indirection table and unclassified_queue were
> originally described based on mathematical operations. In order to
> make it easier to understand and to avoid intermixing the array
> index with the vq index, introduce a structure
> rss_rq_id (RSS receive queue
> ID) and use it to describe the unclassified_queue and
> indirection_table fields.
>
> As part of it, have the example that uses non-zero virtqueue
> index which helps to have better mapping between receiveX
> object with virtqueue index and the actual value in the
> indirection table.
>
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
> Signed-off-by: Parav Pandit <parav@nvidia.com>
>
> ---
> changelog:
> v14->v15:
> - address next comment from Michael and Halil
> - changed description of unclassified_queue to use 'specifies'
> v12->v13:
> - rename vqn to vq_index
> - renamed vq index to virtqueue index
> v11->v12:
> - use 'virtqueue index' instead of 'virtqueue number'
> v10->v11:
> - commit log updated to drop old reference to rq_handle, replaced with
>   rss_rq_id detail
> v8->v9:
> - reword rss_rq_id and unclassified_packets description
> - use article
> - use 'vq number' instead of 'virtqueue number'
> v4->v5:
> - change subject to reflect rss_rq_id
> - fixed accidental removal of "unclassifed packets".
> - simplfied text around indirection_table mask to use the term
>   destination receive virtqueue. This aligns with next line about queue
>   reset.
> - removed rss_rq_id references as indirection table and
>   unclassified_queue data type is self explanatory
> v3->v4:
> - renamed rq_handle to rss_rq_id
> - moved rss_rq_id definition close to its usage in rss_config struct
> v2->v3:
> - moved rq_handle definition before using it
> - removed duplicate example as rq_handle is now described first
> v0->v1:
> - new patch suggested by Michael Tsirkin
> ---
>  device-types/net/description.tex | 27 ++++++++++++++++++++-------
>  1 file changed, 20 insertions(+), 7 deletions(-)
>
> diff --git a/device-types/net/description.tex b/device-types/net/description.tex
> index f3f9f1d..e25a9d0 100644
> --- a/device-types/net/description.tex
> +++ b/device-types/net/description.tex
> @@ -1434,11 +1434,16 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
>  
>  Driver sends a VIRTIO_NET_CTRL_MQ_RSS_CONFIG command using the following format for \field{command-specific-data}:
>  \begin{lstlisting}
> +struct rss_rq_id {
> +   le16 vq_index_1_16: 15; /* Bits 1 to 16 of the virtqueue index */
> +   le16 reserved: 1; /* Set to zero */
> +};
> +
>  struct virtio_net_rss_config {
>      le32 hash_types;
>      le16 indirection_table_mask;
> -    le16 unclassified_queue;
> -    le16 indirection_table[indirection_table_length];
> +    struct rss_rq_id unclassified_queue;
> +    struct rss_rq_id indirection_table[indirection_table_length];
>      le16 max_tx_vq;
>      u8 hash_key_length;
>      u8 hash_key_data[hash_key_length];
> @@ -1453,10 +1458,15 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
>  \field{indirection_table} array.
>  Number of entries in \field{indirection_table} is (\field{indirection_table_mask} + 1).
>  
> -Field \field{unclassified_queue} contains the 0-based index of
> -the receive virtqueue to place unclassified packets in. Index 0 corresponds to receiveq1.
> +\field{rss_rq_id} is a receive virtqueue id. \field{vq_index_1_16}
> +consists of bits 1 to 16 of a virtqueue index. For example, a
> +\field{vq_index_1_16} value of 3 corresponds to virtqueue index 6,
> +which maps to receiveq4.
> +
> +Field \field{unclassified_queue} specifies the receive virtqueue in which to
> +place unclassified packets.
>  
> -Field \field{indirection_table} contains an array of 0-based indices of receive virtqueues. Index 0 corresponds to receiveq1.
> +Field \field{indirection_table} is an array of receive virtqueues.

...an array of receive virtqueue ids.

>  
>  A driver sets \field{max_tx_vq} to inform a device how many transmit virtqueues it may use (transmitq1\ldots transmitq \field{max_tx_vq}).
>  
> @@ -1466,7 +1476,8 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
>  
>  A driver MUST NOT send the VIRTIO_NET_CTRL_MQ_RSS_CONFIG command if the feature VIRTIO_NET_F_RSS has not been negotiated.
>  
> -A driver MUST fill the \field{indirection_table} array only with indices of enabled queues. Index 0 corresponds to receiveq1.
> +A driver MUST fill the \field{indirection_table} array only with
> +enabled receive virtqueues.
>  
>  The number of entries in \field{indirection_table} (\field{indirection_table_mask} + 1) MUST be a power of two.
>  
> @@ -1479,7 +1490,9 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
>  \begin{itemize}
>  \item Calculate the hash of the packet as defined in \ref{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets}.
>  \item If the device did not calculate the hash for the specific packet, the device directs the packet to the receiveq specified by \field{unclassified_queue} of virtio_net_rss_config structure.
> -\item Apply \field{indirection_table_mask} to the calculated hash and use the result as the index in the indirection table to get 0-based number of destination receiveq.
> +\item Apply \field{indirection_table_mask} to the calculated hash
> +and use the result as the index in the indirection table to get
> +the destination receive virtqueue.
>  \item If the destination receive queue is being reset (See \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}), the device MUST drop the packet.
>  \end{itemize}
>  
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
J'aurais toujours faim de toi.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

