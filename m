Return-Path: <virtio-dev-return-12007-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27E9FC7619A
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 09:18:03 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 538582B055
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 09:18:02 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 26B4A9865B2
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 09:18:02 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 0A148983DE1; Wed,  5 Apr 2023 09:18:02 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EB9279865A7
	for <virtio-dev@lists.oasis-open.org>; Wed,  5 Apr 2023 09:18:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: AfucUPnyMsCeu6CDmt4D5Q-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680686278;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2rotSWNcagXfiMV6GCeHpPV80q09Nl9YiarAzqc1ubo=;
        b=tjwKQi8KN9U2v0bbi+yR3xqxeJKAb0+qv6nw8eGqIDEdfRrf44E0lQ0/lsMnhlEp5o
         dqLp3tmNtsHs7ue2X80r+Lw5lQBz546JxATT1I2gLVd56nYSiaVxCvW5SYgYkf7zHW80
         2XeXUDUl7r57vzXnldMqIbhqLmZ5fUpPwzMCM4CQTukFbJ4C7Ews61mQ2nHAgedHg/8U
         jkmqAN2DQ9rgTVQPKNcb8mYxcleAKUOVJu9A3TcSiEWZZEG+n4bf678zp4wJ6oTLu2fu
         P5LEN24wpcDovg1wMxcuTXKv7ClM/C0FN4im0u+gGXu7Rs/MKiwgoqJxqH4gEGdjEo07
         KiYA==
X-Gm-Message-State: AAQBX9d8EczheB2dagH2tapr9LSYEzDOpB9yhfWkDKC910aBq356SAzu
	h7Z//8a2QUotWaFWZ2crNc2EY58xF2vMmvCKSZiE80nb+OKGgssl99Y/++g1O9g92JtwBLeLCKR
	i38sEveKA2CpX2zcMD1VbTJIM1nvfDFFnehsO
X-Received: by 2002:a17:907:724c:b0:92e:eecf:b742 with SMTP id ds12-20020a170907724c00b0092eeecfb742mr2889054ejc.2.1680686278484;
        Wed, 05 Apr 2023 02:17:58 -0700 (PDT)
X-Google-Smtp-Source: AKy350Y2/PJZ3NCN7gDeRhiqxYqShakKs6GsUtSeZfIHaIxKiCZGARjLVjxJw3mXshJHdQwpc2mBrA==
X-Received: by 2002:a17:907:724c:b0:92e:eecf:b742 with SMTP id ds12-20020a170907724c00b0092eeecfb742mr2889036ejc.2.1680686278191;
        Wed, 05 Apr 2023 02:17:58 -0700 (PDT)
Date: Wed, 5 Apr 2023 05:17:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: virtio-dev@lists.oasis-open.org, cohuck@redhat.com, sgarzare@redhat.com,
	pasic@linux.ibm.com, virtio-comment@lists.oasis-open.org,
	shahafs@nvidia.com
Message-ID: <20230405051637-mutt-send-email-mst@kernel.org>
References: <20230405010657.612529-1-parav@nvidia.com>
 <20230405010657.612529-11-parav@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230405010657.612529-11-parav@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v12 10/10] virtio-net: Describe RSS using rss rq id

On Wed, Apr 05, 2023 at 04:06:57AM +0300, Parav Pandit wrote:
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
> index 435c1fc..4eb10d1 100644
> --- a/device-types/net/description.tex
> +++ b/device-types/net/description.tex
> @@ -1423,11 +1423,16 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
>  
>  Driver sends a VIRTIO_NET_CTRL_MQ_RSS_CONFIG command using the following format for \field{command-specific-data}:
>  \begin{lstlisting}
> +struct rss_rq_id {
> +   le16 vqn_1_16: 15; /* Bits 1 to 16 of the vq index */

Do you want to then call this vq_index_1_16 ?
And in the comment I would just write virtqueue index.

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
> @@ -1442,10 +1447,15 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
>  \field{indirection_table} array.
>  Number of entries in \field{indirection_table} is (\field{indirection_table_mask} + 1).
>  
> -Field \field{unclassified_queue} contains the 0-based index of
> -the receive virtqueue to place unclassified packets in. Index 0 corresponds to receiveq1.
> +\field{rss_rq_id} is a receive virtqueue id. \field{vqn_1_16}
> +consists of bits 1 to 16 of a vq index. For example, a
> +\field{vqn_1_16} value of 3 corresponds to vq index 6,
> +which maps to receiveq4.
> +
> +Field \field{unclassified_queue} contains the receive virtqueue
> +in which to place unclassified packets.
>  
> -Field \field{indirection_table} contains an array of 0-based indices of receive virtqueues. Index 0 corresponds to receiveq1.
> +Field \field{indirection_table} is an array of receive virtqueues.
>  
>  A driver sets \field{max_tx_vq} to inform a device how many transmit virtqueues it may use (transmitq1\ldots transmitq \field{max_tx_vq}).
>  
> @@ -1455,7 +1465,8 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
>  
>  A driver MUST NOT send the VIRTIO_NET_CTRL_MQ_RSS_CONFIG command if the feature VIRTIO_NET_F_RSS has not been negotiated.
>  
> -A driver MUST fill the \field{indirection_table} array only with indices of enabled queues. Index 0 corresponds to receiveq1.
> +A driver MUST fill the \field{indirection_table} array only with
> +enabled receive virtqueues.
>  
>  The number of entries in \field{indirection_table} (\field{indirection_table_mask} + 1) MUST be a power of two.
>  
> @@ -1468,7 +1479,9 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
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


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

