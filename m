Return-Path: <virtio-dev-return-12354-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D0E1C77B78
	for <virtio-dev@archiver.kernel.org>; Mon, 24 Apr 2023 13:22:41 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 91EBB29FFA
	for <virtio-dev@archiver.kernel.org>; Mon, 24 Apr 2023 13:22:39 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 70AC1986394
	for <virtio-dev@archiver.kernel.org>; Mon, 24 Apr 2023 13:22:39 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 6216298633A; Mon, 24 Apr 2023 13:22:39 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4EB4A98634E;
	Mon, 24 Apr 2023 13:22:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
Date: Mon, 24 Apr 2023 15:22:21 +0200
From: Halil Pasic <pasic@linux.ibm.com>
To: Parav Pandit <parav@nvidia.com>
Cc: <mst@redhat.com>, <virtio-dev@lists.oasis-open.org>, <cohuck@redhat.com>,
        <sgarzare@redhat.com>, <virtio-comment@lists.oasis-open.org>,
        <shahafs@nvidia.com>, Halil Pasic
 <pasic@linux.ibm.com>
Message-ID: <20230424152221.54c44489.pasic@linux.ibm.com>
In-Reply-To: <20230419014639.919458-11-parav@nvidia.com>
References: <20230419014639.919458-1-parav@nvidia.com>
	<20230419014639.919458-11-parav@nvidia.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: I15vUxfzdF7YfyFIvlccKCwNU5sea7if
X-Proofpoint-ORIG-GUID: Cgd0FOHKb3sBZhDvWKMnCU_wHR-HY0DD
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-24_07,2023-04-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 phishscore=0 clxscore=1015 impostorscore=0 adultscore=0 priorityscore=1501
 mlxscore=0 lowpriorityscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304240118
Subject: [virtio-dev] Re: [PATCH v14 10/11] virtio-net: Describe RSS using rss rq id

On Wed, 19 Apr 2023 04:46:38 +0300
Parav Pandit <parav@nvidia.com> wrote:

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
> index f3f9f1d..e4d236e 100644
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

I'm not a fan of this being done with bitmaps, as I have stated before,
but I can live with it.

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
> +Field \field{unclassified_queue} contains the receive virtqueue
> +in which to place unclassified packets.

It does not contain a receive virtqueue but its \field{rss_rq_id},
i.e. it's "receive virtqueue id".

>  
> -Field \field{indirection_table} contains an array of 0-based indices of receive virtqueues. Index 0 corresponds to receiveq1.
> +Field \field{indirection_table} is an array of receive virtqueues.

Same here.

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

Same here.
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

Same here.

>  \item If the destination receive queue is being reset (See \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}), the device MUST drop the packet.
>  \end{itemize}
>  


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

