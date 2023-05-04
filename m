Return-Path: <virtio-dev-return-12552-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3075C7EE23
	for <virtio-dev@archiver.kernel.org>; Thu,  4 May 2023 14:36:29 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 301511318D0
	for <virtio-dev@archiver.kernel.org>; Thu,  4 May 2023 14:36:29 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1E4649866C3
	for <virtio-dev@archiver.kernel.org>; Thu,  4 May 2023 14:36:29 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 10E9D9866B1; Thu,  4 May 2023 14:36:29 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F01919866B2;
	Thu,  4 May 2023 14:36:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oj/ecuBl6E2x83F3bYF9LWzRith8Pzvd2TTci4VNczTN7avCREXZEEtd451vhj8zpx8XFqwL/z5wTdgZm6W3BLF6jdumXI0vXhbN77ysitcOo8Cn872Q/vf41KQxs2CQ8/ulqnB2je6IAztuwFVjkppRBY4IJ4yuQQBllADC30HcVjUAqtO3riCZnKbT+0i0KynEUUAoSae3iDFLe/nZnGd9S1gkMuAGHVxOz3051deMTamm07e+LJkjDfSZpyDFmvsI86EtbY2svsVKCidANPID8I8e3o7Wfi3ruZELC3bR6Y+vlY50TIr0X2OdptP3RTnqNMvhWVlMorkQdbld8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=owBuKzxFBCsdRogfxcxPK4okVDIrmcK2TET8bCSbrbg=;
 b=Rs/xkrUkXSKVjCWyms6KZW7MbQyZvnuONbsx/aoV6WnreyjfMWUb88GfnqnaBI+1+E+zpnHT07GV0FNLARuFBrg/dDNMrlV8uY7cqoY7+JyePSR21F+1KHv8eJ5zXfdUleo+88r92LcrvnUHA0Xhs8q3BrvPCJRh1+j2MLAAJuAZ4ZroV3HvZ6Q7H2Zvq1OCRum53djHB89P0yBkNlnN7ZvzNrVZi/vr/i66YYHnIBwFsateobiSwN3MRy5UhHc2ntp5JqtcVjy09/WjKQS4omw+kxOqHETWd8y93rbVx90JgvYwwsz6s0VAxVviBz/u3qCbmJlY1q/dhenHXUToAg==
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
In-Reply-To: <20230504022959.547025-11-parav@nvidia.com>
References: <20230504022959.547025-1-parav@nvidia.com>
 <20230504022959.547025-11-parav@nvidia.com>
Date: Thu, 04 May 2023 15:30:52 +0100
Message-ID: <m2r0rw419f.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0026.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600::14)
 To DS7PR10MB4926.namprd10.prod.outlook.com (2603:10b6:5:3ac::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB4926:EE_|MW4PR10MB6557:EE_
X-MS-Office365-Filtering-Correlation-Id: b56be990-359e-48c5-1f4d-08db4cac2d03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	9rxXw/HxOBMKsT4TOnQwkfSqYEbTi4GplAnUj4sJnhNe3AxmSQYPpIe+rEtv/19675/ofMOYkbVxgA4D/s/LWGaY80tlbUlJ3F7UZk13heUEsASacKdEpobo6uxHkP9zeBnZnVLIWqV9i5Z7P5KGcu5/seB5nzbEyGh1DkxAxTo/ef6CdW8cqnpksZXc6xG2wpdAYkjInL3YdwtX8ceT7zXbs4FlAHQLuulqxtiQvWsb1qT/bWNEn5tkZ8ikSo4YnF8EN3vnayJRBX1ueX7D28cPwD1+/jL3tbqBamIiO9D82Oar7tv2ksvCGjmRJcrWQvd5Cnsz/M47V9fZUWG7mYYqdNqiGseQ3Mv603tE878QpG3WTlRIieH5eyg/XMVCEfyF5gNuBPqYGgPPF0U3LVDnjkaI8E2LJxpJwBycTyq+6p4QpeOupiYhlnG8zd6xGTR9psNsN1CxfO9YJ+n7NEb0jk3fcsG7gWLBdVw9zvkVpML0Zs4Z75Wp46NEihVK0L/0XjLl7QHpKSD7dyn7C9cGG94eGC7WCnBEYpxY3/s=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4926.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(346002)(396003)(136003)(366004)(451199021)(6512007)(2906002)(2616005)(186003)(44832011)(83380400001)(6506007)(26005)(478600001)(5660300002)(66476007)(38100700002)(66556008)(66946007)(966005)(8676002)(8936002)(41300700001)(6486002)(6666004)(36756003)(316002)(86362001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?m3a799VGuuTwaZtnhfY1PHaJ7FrkCWKgsppf+eaFabwmkzXsawGX6/RRs/Lm?=
 =?us-ascii?Q?OBqC+fLhZQ8I9uzL3OfPCLuUygeZ7qdYqBV8QdHWDajPfhQDCN9FiJJ3pDZF?=
 =?us-ascii?Q?wRlWn6zT+NnWlJacAFmb1C11V9VHEZpG2n/JJw7dGnBaMec+lOUIWvnnxjy6?=
 =?us-ascii?Q?/VQbJ7MF5lDwDsWIjfHBRq7LOmoJ/9tbf7xmhEj1Ez01Rh95YXRdNxoa2lkT?=
 =?us-ascii?Q?7G/ziiGTyIyrJVdJwgUfUYbTGtv/W6oPBcdRqD7fCOLaez+Iq7reLBinocae?=
 =?us-ascii?Q?BNqQISjhH2v97zPHbPwM2UXohgmXEfx57WGQY5YIgZRmbdpR8abHTzL9Gn/Z?=
 =?us-ascii?Q?fGItZbe1JOENE3lYeEIJTTFDuUrZgdX5CRJJVIdKECd4jlXOS1/XiazAhDcZ?=
 =?us-ascii?Q?p9QehedhT9yDrb5k9+iS1nmnH7u0mT4HRv/hlfr8xGSjm9pcukdqVe/eUXy6?=
 =?us-ascii?Q?iaba5jQQf+gqzvzD4rVJnxBGYJA+1yawWNRwG/DBs3mWsPFsib8mood86Kph?=
 =?us-ascii?Q?AQShc5nZBbzPiX5QYxqeGBREJx26zcyIbg85t+MSfZ40PpMpLQTvEDZ/P17p?=
 =?us-ascii?Q?EUEFePrPl0ISG0/2tXRc5N8D425bnciEsIKPoo2nCEadWJKwGbhF8KxxgiAA?=
 =?us-ascii?Q?nBPs6/ziF8nT3prJKpEn5Dw1zrOaX+dFOhp2B4vmIM8prcaos7RXsG22IfBc?=
 =?us-ascii?Q?s8xL7+7MERvZhar2J3e7WpniS0gejn0DD4jDu2ZMSzsnhfAwtm9NqBgJIr6S?=
 =?us-ascii?Q?gVed1xiPZKn47RoO2BdzNF2ggn6fp0zGwMkUvG2U5q4ZWrJcAg2HCrxI1XZU?=
 =?us-ascii?Q?AoAYpu0xTTCa9jIWBDuTLJzrKyk22ubJ+oCCocm+1TiTsoUgHV+HPfY8LRCK?=
 =?us-ascii?Q?l/TirYW/ll/l2dEYl/yuPbjDpn/zrl/nIGY2LQKbupR4MjyoaCID494tOl1D?=
 =?us-ascii?Q?M9OW2jx6CtAcNCkJl6XxYfAONgbVRGnxa9fP+lNCFSv5N4vNt0uGcBh3buhu?=
 =?us-ascii?Q?mSZkKCQJ1O3k2yaDkxlYaXY4s7z+4ROymvlDdrf3JWzBkzFi++UlMKpLc4OK?=
 =?us-ascii?Q?gKHYZFh/Wg5zjZNqHN2+25LIbTMvH8ywaU2lWE7wmkbQKCuYA1R4CtI49Vju?=
 =?us-ascii?Q?2SIXO5qOsvWWqUyHZwjSXVEG8sDa1kukfIUlcBVdIVmUjyb6vI/rmES2NRMI?=
 =?us-ascii?Q?v6VVq1mUZCC9yZMnYgN/8V+ZmIszpS+RH3KLKGh48iOOTXBbTVhs0VvAphhA?=
 =?us-ascii?Q?jeMsTk0tstxxFHqw5KHlWlkP224KXnBTft8/1eZ9NmwBqwz6Fe7QoXm6qYNr?=
 =?us-ascii?Q?IcEmKMLpi5FMH+eAnXkN+geaT9r/GheMZK2FGWnyW5OkOzrE7jLf+iD9eHq4?=
 =?us-ascii?Q?2D2Md+pdw4rzspB8KDauGGI/XvtgRl+9oXiW+h+Ckbb0tfHi0AMY4Q+wyzRv?=
 =?us-ascii?Q?bTcH4Ucx5GuTvmH5cG980O5wn+5AtGJzGScgE4+CIKZAvY8WNkgje0c+SgJG?=
 =?us-ascii?Q?296ogpFiODqYnuOOUj1dV09xZx0Ktz2Npjtx0AK6uHIBvhsMo6sXPh2klM45?=
 =?us-ascii?Q?+QWvw4BFjWy6s4y5FktkqTyazhdp/7y8TJe6r+KXd9giGzNwXzt+bc/G+SDJ?=
 =?us-ascii?Q?yw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	g4LaEa3FjgULHhgylo3QgTA21JVbDfHxZ38/RgIm1ufjVKqdqaK7Sh1bFOkX0/uyOuw9pGCuXkUVCuu3HnkCN8X17sufc57m7bgqMj0O0cM7WTpUwAw9FmTYUHM3k0hfCqUcb4WurszbfxzOw7bUy0+MvaYeaL3vwBfgZWyGhsBz+bjL6pHNHC4BYmLBjcVt+LQGuY5JwyBI2Lz8j5DAEHiY9u55rMw1tsJWG0bHum/l4WBuAybjs3WY7QQLh09tKGYubEWMHT0CmxAlIbn66UK+7BvilCf8m818m/QVCpM7Re3MY36YogRxGq87rt+UTALlUvR5Hcmw9+Ky5tMxgCwZL53cQleZQ93orMSMGBEN13OxBf1JSmHoQowUt1Gl8lnbxsn/k2IJ/4jZzvqJxKeaQyKJ4+p72JizN+qxVpoKrbw89Z1KUoTxpT6gw8qTVkczA//U8q8LqD5hqvX4UP6eF/L6aF9hFgkicLm9D+vlUYAVg/h1lMYIn24jO9ThtsOQZ0jin6NhapOvqqIx8cBMuzsjSZNjDBXKp3CNe4SXx78aj/0rSDZv8NWWDA0huGI1PwRCfM+ChTJnNIlaTLSMCf7Letz0gM6h6+CpbOuhw5guhPHWftDuG8RfNLu7eUvN4JARu2LsuZo9241y2tv/crqeBETSkO78a5VEricv0CbMUBfcPQwph0m0dJjGv54/VWXAyVfWYv/+rqPzrV0i5Io0NefmQ+DOpHKiV3DjIfxpY4VTbEM2ze6cqAUrtaVhy+EMvI6ssdvmwykZXA9z9kfCMb7Tqe3XYy0CaIdMj50Tez7GrApSbfFJgYrQlRvHhrrZ5jSWhMRd4+9TfEKqqAqHtGaR2ZxZlE+x4B2qrHOFYUOvNU0ddLK8ZPuT
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b56be990-359e-48c5-1f4d-08db4cac2d03
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4926.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 14:30:57.8470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sSDt6HL37BfY+Pv6DfAIadfeUT0Xr15rYjAzRebpbQ1Ecs//JVqk8eDXpShWFaXc5agwUQlfyHX2Xz6noG8VvGahWdyLhKOstq6TcAWx1S4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6557
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_10,2023-05-04_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305040119
X-Proofpoint-ORIG-GUID: Ex02nqNlHQgBb5K1D144uBwg-InFhHqG
X-Proofpoint-GUID: Ex02nqNlHQgBb5K1D144uBwg-InFhHqG
Subject: [virtio-dev] Re: [PATCH v16 10/11] virtio-net: Describe RSS using rss rq id

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

Reviewed-by: David Edmondson <david.edmondson@oracle.com>

> ---
> changelog:
> v15->v16:
> - replaced receive virtqueue with receive virtqueue id
> v13->v14:
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
> index f3f9f1d..83bdaef 100644
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
> +Field \field{unclassified_queue} specifies the receive virtqueue id in which to
> +place unclassified packets.
>  
> -Field \field{indirection_table} contains an array of 0-based indices of receive virtqueues. Index 0 corresponds to receiveq1.
> +Field \field{indirection_table} is an array of receive virtqueues ids.
>  
>  A driver sets \field{max_tx_vq} to inform a device how many transmit virtqueues it may use (transmitq1\ldots transmitq \field{max_tx_vq}).
>  
> @@ -1466,7 +1476,8 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
>  
>  A driver MUST NOT send the VIRTIO_NET_CTRL_MQ_RSS_CONFIG command if the feature VIRTIO_NET_F_RSS has not been negotiated.
>  
> -A driver MUST fill the \field{indirection_table} array only with indices of enabled queues. Index 0 corresponds to receiveq1.
> +A driver MUST fill the \field{indirection_table} array only with
> +enabled receive virtqueues ids.
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
> +the destination receive virtqueue id.
>  \item If the destination receive queue is being reset (See \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}), the device MUST drop the packet.
>  \end{itemize}
>  
> -- 
> 2.26.2
-- 
Walking upside down in the sky, between the satellites passing by, I'm looking.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

