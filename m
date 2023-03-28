Return-Path: <virtio-dev-return-11816-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41B09C77B61
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Mar 2023 14:13:39 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 760E1722A6
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Mar 2023 14:13:38 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 70A289863E6
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Mar 2023 14:13:38 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 60EB698638E; Tue, 28 Mar 2023 14:13:38 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4CC8D9863BF;
	Tue, 28 Mar 2023 14:13:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mOGm94kuS4QYANON5SoAzn5MEDGK0iTpyjZtIvK02l/gcshM/PziNnT4l69R8MLTfpe4s8D/ITwT1dQ33NTjfxhrX9vSC2AM2gk04DiDhQbOqUCYXN7BJUXCdsyd0MyqYvzoaHqCiLSBKQ6PWodfW3r3Rb2P0hJIwOc9vxfEg4O6TbXHoQLLsrNAjpsJ6gc2VAu9uu0CwWu6rBrBzVj5Rgz3ETe1UW7Z/MuXG3EyiHmCSIjWJrcg22s3Q1zD+3L4XcJkHAu3jzOLjQWEQ5fk+Uap+ov1tvnq0ZduAyj66LQ4YqLGrf0l6Psvh/AjH4yMJxLAN9YLzwZjyAWiR9Ikfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I0Yy37fUBqGARr8VQV8hDJ6ULclh8uY+scp+3mcnZ9g=;
 b=FpFj09JjDpKa7DCaisHmicm9F74vmu6SWjZk0+l/fKJXxaWk87VZIX18ZokkHnuAG0TTqm8fF5ZStJ3M4lAimvRFBhivmt3VlWjjVGrBCKOaAfHJjygpT351rWOmWOsgC1wMRuNwy1DLClAD/1T4RwRqMSJdFhdTfw13d5d2BYYl1GfXbROBDoFCzUUE/FQjuKNvVmnbB2ylXT7OE6Ao6WYQsCoZLa4NQpUxVL4UCrrrK25/Rc07DR3fHMn7cy5Oi5xSFQMS7PmTOxPRutzShLKBxYPLlOnENX7eJs/vC6kbowJIGgtgr/dFaea4yT0nNbCszmtzXxEm6Qyg9c2/Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
From: David Edmondson <david.edmondson@oracle.com>
To: Parav Pandit <parav@nvidia.com>, mst@redhat.com,
        virtio-dev@lists.oasis-open.org, pasic@linux.ibm.com,
        cohuck@redhat.com
Cc: sgarzare@redhat.com, virtio-comment@lists.oasis-open.org,
        shahafs@nvidia.com, Parav Pandit <parav@nvidia.com>
In-Reply-To: <20230327235936.414196-9-parav@nvidia.com>
References: <20230327235936.414196-1-parav@nvidia.com>
 <20230327235936.414196-9-parav@nvidia.com>
Date: Tue, 28 Mar 2023 15:13:01 +0100
Message-ID: <m2sfdparrm.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0309.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:197::8) To DS7PR10MB4926.namprd10.prod.outlook.com
 (2603:10b6:5:3ac::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB4926:EE_|CO1PR10MB4465:EE_
X-MS-Office365-Filtering-Correlation-Id: a6f15cfd-bb69-40e4-2936-08db2f968d06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	o81yHrocVykrch/QIrQsZzf8gxdJtQmCmpAG1Ch1UJ8b8XX3sfOYy+BSQuUJuNaKj6qEoeZZTjuZqYD7FOr7oytgiWcYTmw3lsOIXzJKY1bdqaGthLjg88BLX666pawH7O2K57lqawpAA2z+vuGlUJaKRG6ObhzqHN9ubyheAj9waqcJQZJc9mdgbARER0c2denjgo5H8NEht6sjdP97QWfel1jSsKgrBwhqDitB1GVs2LyU0gZS4gDGSXhr2fiJD0C+4Ud0iP0nRLC/ztw5WyQR0dNIAj0fdriczvG+UW2n8jy90sLydqRrp6/LaspRKpUNA4ub6NB15tJavnBGlaRzR/qGJ8dylvGPjEHuMq5cABuk2+N1taToWLsd/lKIDTmyzy42wMG1tV+0bkqUTiH+DWYMV9JyPKpu+D090gvtCYFNtKJffvdCOfmZS5LJRdXjtJCbcDEkfjPB/+3jd5GKu6fG4s6hKHRdmCUhjvfxCkVTskHvY6o2LCaOTobrU6Jv79qCgZ5rUFoGDFOt9wtGZChncx7r/asM9wCuXhE=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4926.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(376002)(366004)(346002)(396003)(451199021)(4326008)(66899021)(41300700001)(316002)(66476007)(478600001)(8676002)(66556008)(66946007)(38100700002)(44832011)(2906002)(83380400001)(186003)(5660300002)(2616005)(86362001)(36756003)(6486002)(966005)(6666004)(6512007)(6506007)(26005)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?O4Z/+cWhWrMhGXiB5rzeko87KTtlih4UVcUs9WYZVoofD5+YhW05j9Y8XY1G?=
 =?us-ascii?Q?yH3pAnQCsTQeLlSZQep0SquFahreKStrms58F4hsbpCs1DLCFcD3ZktEO/zX?=
 =?us-ascii?Q?FXUT6ZpFEVqy9epgJLLbLqowy55RcKX4jgImL2bgOwYnyyLYSQ9n660SqtXm?=
 =?us-ascii?Q?iq/P2UOXDkyuanL4VnVhfiIO84ObQFFsRmIU7Hm6iOat6Faj61Ajn9hxQXNi?=
 =?us-ascii?Q?srgv34pG8ErU+rOVLUmImmM/b1Jny8iZvPNCC+1tzHZyQAPIZleZqQy6adsu?=
 =?us-ascii?Q?U8k7UbJe5Z/mZLCTQXCqp+7MMihrgsnH1hzmjLp8rrnIrDGQqueY481JoY1V?=
 =?us-ascii?Q?DW/yatEYtgj/jyp8VmY1PorxBacaJOgXwK+W1kG6m1pqhFsYMS1ytCd7NhIJ?=
 =?us-ascii?Q?dlT81/pTCZyCnGmP47k58bcH2cpXjQCTd4/AHVbNweQv2vk+UfrEpQBbd/55?=
 =?us-ascii?Q?Clc3Iw+Q2Ss+epP5Yp8iHenkOl/C/vsmVtb0mtzwlmR3qfe/O5J0/xK7y8Ad?=
 =?us-ascii?Q?WeGU8m5kwZTJbmM/R3XlBPBsptFAhhEaCxCnIw7cvuNpuzzh3l/wi1Ed/Ch+?=
 =?us-ascii?Q?6/YrZCkO+aJP4b4LIzURILktlaWgKntErqOkufIvndISB67o1lKze9Qa+pBN?=
 =?us-ascii?Q?JDxHyX34wfHyRj02wWb5msq8/3aY74LSMQnQEnnCXZXY7ECu+9VE3FMTPKke?=
 =?us-ascii?Q?rDb5WC4A43kNhAniuL21na0bwTwX/EPJ0iGFDyEEk3KHmIs6BHzlsz123syL?=
 =?us-ascii?Q?7iqvZUfCcPNTfZdFbU9ADPBXpBv3o9aLvzLwC16p9ZWbOmmodzYtaReSYrDF?=
 =?us-ascii?Q?CvO3p8bcJ5ij7lCvTp/2OO3BUYpRUaEzZix3Up6STsFZjSiEH7ZYUya7GN+n?=
 =?us-ascii?Q?7LGu1vSPLjHL7hzFHxKSbn0hBSzMXjVRpBBZeU4HWRqt4q6OsQf+ai0O/VBh?=
 =?us-ascii?Q?e3fQ/L6KEw+BfPCiooYGW3VaeS+puh+eEg8rrM5r/ZH29ISSgpQlr+it3ffp?=
 =?us-ascii?Q?Ctxrkbv755dwnYLCSHOQNVkvltfEQDIOFjJndjpkt1nmBt/2bAKlDYL5UKj+?=
 =?us-ascii?Q?DFJthj9d+8++k3RmBEy1Q4G98spvLpsws6UCToDwfgC+0dlgOcVkovhtics5?=
 =?us-ascii?Q?q1bQhn4gMbs2PIapNJWE4MX2sJ2Yg72XpFGA2/ZI66A3jcihhFqlsLtJarng?=
 =?us-ascii?Q?FESjZMPiGp5m020HlX3cibDNQRqTaO2TeNAqMRpUbuBWl69Y63huwmyXznMZ?=
 =?us-ascii?Q?HTf5wcFTW+JASk6WZaMmarLMw184cZd44mg3I8CAPQ64wE4MzG59zRI/WzcD?=
 =?us-ascii?Q?iQ8Tk6SGSotzIaCfs9S/uXSwHBcGpHyr3ueFNkrwzLZOZKF0FvTPOtYIkD/e?=
 =?us-ascii?Q?Q/Y8Y9WOZRpBcXzI7q7qbDTqsFk8173o+pX4hPPbv/r/jsMbH4XsOtalmmbA?=
 =?us-ascii?Q?fYp9ZLiqOMhig1abX37d1b8lD4xGZow76ZArv7sGk/eV07Wxo6jzB9UXuIbG?=
 =?us-ascii?Q?+7+n9YPz3ZPoqDVsukSS69VQYISKUH2MosGDpX31ogm4PB1nVlLewSXz1VOW?=
 =?us-ascii?Q?WRFee5FkIfpdwWyFYL+pIBIOK3MDRy7wq1A2W2+Ul2zeuDjTLZqsEvfSg878?=
 =?us-ascii?Q?xA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	fIlnibBoi4vtYB58tCEqDki89NSF+QC+qyKocpG//4UwPaqGWcsiiO7jwoIApGWcOZIrpK4J1f6sCzziZIGEzxgbC2tVVhdQPbOT3oJiGhqJeCV3tfvwUOwwr3hHYO2Y6aqUgG/8io9dRkRxcHizaHnU9JdCEgiQ6kxhm6Ul7Z8yDjJxC45dZQq+VZpf+gcKwn0sISRz1H4T+CvjiBpXLpYVDx45VtH6wsFD0VmIBxnO7/MQGPLNc3+bi7iUHwIjQw3i/iYPuVwh4fng8QvUySF/Qtpm5VNDvw0npLLegGq9Sma+VDqSVTXHn68zjMwaQrRJA/9tx/bnV1he1erg3wp1rnbkgtn8xAapq8DC90p2dvjeOp2BbSMFX0XS8rt7KYMwLaXiCsb2/8c8dRT+bY9KfW5rQq7ir2Yeu3/E71UZqysSlSuLhrAogUjuFBaBPiPMJU+jrcV4VoeJ1BaLlIsUPtqNvf/ItIkINz1FnDvvlYAQJAf2qiyWFIPRZuu9oKk6kdbG5be3z8ps3Sgjy1FeZi9KuqGD0htZeq2GU/6CYVQr2v4bgiQbW8Rc8X7tGY3g80b07FPKnMn25tBexZJC9RoH7l/89+IT7SeIVKmjzO7aeLvj1Qi4W9Jkqj5S0vZWJKfLzmTr9J3QWNkqAwJJs7SJ0Ldfjw6dN5yKL23/SZP/ZChkhQ2RwBx52F1fLtjxp0Tw4WtgbqHHY2jSyMsGzrUhXnAiUG4AIu3OvWa2SasKIaUdAqB0X/7KAO7A8Ia+nX6XNxIpOrj8m7zgmzEBRHj30ftxEbe8PgHsommU80IU6xkv/x/wmHJg43ZhvtSjDnoJ8TAsqqwKQDlFc8MhWDgexhdX/FU9o4qUm5tWRqPQVIsU/UqZWH32KKh3
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6f15cfd-bb69-40e4-2936-08db2f968d06
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4926.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 14:13:06.2746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B1CSIyRmI8f6GE+qTkK38JdIKkaKE/nBPrvNDXhZIJIjUzPf8Htkby+Jk3eyozh5I7Jr7DebchNWHVbQHU85yhU6qUxe7YL/kQ2wEROmgFk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4465
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-28_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303280113
X-Proofpoint-ORIG-GUID: F0Vu4skpiD8zVi7JI2dA-0gqx51g46rl
X-Proofpoint-GUID: F0Vu4skpiD8zVi7JI2dA-0gqx51g46rl
Subject: Re: [virtio-dev] [PATCH v8 8/8] virtio-net: Describe RSS using rss
 rq id

Parav Pandit <parav@nvidia.com> writes:

> The content of indirection table and unclassified_queue which are
> based on math calculation historically. To better describe this, to
> avoid intermixing array index with virtqueue index and to use virtqueue
> number
>
> introduce a field rq_handle (receive queue handle) and refer them
> to describe unclassified_queue and indirection_table fields.
>
> As part of it, have the example that uses non zero virtqueue
> number which helps to have better mapping between receiveX
> object with virtqueue number and the actual value in the
> indirection table.
>
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
> Signed-off-by: Parav Pandit <parav@nvidia.com>
>
> ---
> changelog:
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
>  device-types/net/description.tex | 26 +++++++++++++++++++-------
>  1 file changed, 19 insertions(+), 7 deletions(-)
>
> diff --git a/device-types/net/description.tex b/device-types/net/description.tex
> index 435c1fc..d6dd897 100644
> --- a/device-types/net/description.tex
> +++ b/device-types/net/description.tex
> @@ -1423,11 +1423,16 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
>  
>  Driver sends a VIRTIO_NET_CTRL_MQ_RSS_CONFIG command using the following format for \field{command-specific-data}:
>  \begin{lstlisting}
> +struct rss_rq_id {
> +   le16 vqn_1_16: 15; /* Bits 1 to 16 of the virtqueue number */
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
> @@ -1442,10 +1447,14 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
>  \field{indirection_table} array.
>  Number of entries in \field{indirection_table} is (\field{indirection_table_mask} + 1).
>  
> -Field \field{unclassified_queue} contains the 0-based index of
> -the receive virtqueue to place unclassified packets in. Index 0 corresponds to receiveq1.
> +\field{rss_rq_id} is a receive virtqueue id. \field{vqn_1_16}
> +consists of bits 1 to 16 of virtqueue number. For example,
> +\field{vqn_1_16} value of 3 corresponds to virtqueue number 6 maps to receiveq4.

\field{rss_rq_id} is a receive virtqueue id. \field{vqn_1_16} consists
of bits 1 to 16 of a virtqueue number. For example, a \field{vqn_1_16}
value of 3 corresponds to virtqueue number 6, which maps to receiveq4.

> +
> +Field \field{unclassified_queue} contains the receive virtqueue
> +to place unclassified packets in.

Field \field{unclassified_queue} contains the receive virtqueue in which
to place unclassified packets.

> -Field \field{indirection_table} contains an array of 0-based indices of receive virtqueues. Index 0 corresponds to receiveq1.
> +Field \field{indirection_table} is an array of receive virtqueues.
>  
>  A driver sets \field{max_tx_vq} to inform a device how many transmit virtqueues it may use (transmitq1\ldots transmitq \field{max_tx_vq}).
>  
> @@ -1455,7 +1464,8 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
>  
>  A driver MUST NOT send the VIRTIO_NET_CTRL_MQ_RSS_CONFIG command if the feature VIRTIO_NET_F_RSS has not been negotiated.
>  
> -A driver MUST fill the \field{indirection_table} array only with indices of enabled queues. Index 0 corresponds to receiveq1.
> +A driver MUST fill the \field{indirection_table} array only with
> +enabled receive virtqueues.
>  
>  The number of entries in \field{indirection_table} (\field{indirection_table_mask} + 1) MUST be a power of two.
>  
> @@ -1468,7 +1478,9 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
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
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
-- 
Tonight I think I'll walk alone, I'll find my soul as I go home.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

