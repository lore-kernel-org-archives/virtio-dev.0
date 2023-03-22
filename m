Return-Path: <virtio-dev-return-11733-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F5AEC74A5B
	for <virtio-dev@archiver.kernel.org>; Wed, 22 Mar 2023 23:03:53 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id ACDD3157EED
	for <virtio-dev@archiver.kernel.org>; Wed, 22 Mar 2023 23:03:51 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A45DA986455
	for <virtio-dev@archiver.kernel.org>; Wed, 22 Mar 2023 23:03:51 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 95A1C983EB6; Wed, 22 Mar 2023 23:03:51 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8381A986458
	for <virtio-dev@lists.oasis-open.org>; Wed, 22 Mar 2023 23:03:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 4VqalC98MZWiO9uYq6zHYQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679526227;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gw/zDbko0sStF37nn0xi3KAtQint7VgSCZr1DYDMcIg=;
        b=Js0sj6Lzgn+A1/JCF4yTTcsypFlQHt1plHLqoWazLFJtbL8nnQuAzuorv/tKl7jZLT
         6IDc+26P4gDMjhTx1naa8bCIw8/4+HmOK/aUIs//hHZkkzV6uvtgQV0+qcM+dt4hquqN
         tjidvbGVFjsnhKNjGsjG45bSoGAVHpMWOxOuYsWJjSZ+h7nj/lfpFakimSqkjq+zW0Qp
         Dz/bgkDx+M6MxNUs4472SziRHxCz1LDQVrJz/ifs3tjqhgA42aP+tgS4B0wsITgkRmlS
         l57jkeYHX0H2z4w6XY7pxnvepYY68/lKPCSOxt9DwGgZO11HeqsjndJlZp9oc6TLhUSv
         epTA==
X-Gm-Message-State: AO0yUKVg0qGZzH3VEzrcHYGWcZVrCY65ss3HfARBhz1GxRTpzTx7TE9V
	5ALhb7k6Jy0iZ6T4MqW0P/ycSn2aFS/cRfbzm0VnaYkHFrT7/NCdczzvJdEE6f1o+4bLulZ5YSB
	wBuuWoNQ4zg3IaDf6WStvrvHN54aB
X-Received: by 2002:a17:906:68cb:b0:8b1:fc:b06d with SMTP id y11-20020a17090668cb00b008b100fcb06dmr7807203ejr.77.1679526226947;
        Wed, 22 Mar 2023 16:03:46 -0700 (PDT)
X-Google-Smtp-Source: AK7set+uDGxaI6/JhUfK7mMSHunuoIBBDb2SN7vdRpuAWwucIx0b7dc+8oTt56L515PvN0oqVs6HvQ==
X-Received: by 2002:a17:906:68cb:b0:8b1:fc:b06d with SMTP id y11-20020a17090668cb00b008b100fcb06dmr7807186ejr.77.1679526226659;
        Wed, 22 Mar 2023 16:03:46 -0700 (PDT)
Date: Wed, 22 Mar 2023 19:03:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: virtio-dev@lists.oasis-open.org, pasic@linux.ibm.com, cohuck@redhat.com,
	virtio-comment@lists.oasis-open.org, shahafs@nvidia.com
Message-ID: <20230322184932-mutt-send-email-mst@kernel.org>
References: <20230322215243.249524-1-parav@nvidia.com>
 <20230322215243.249524-9-parav@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230322215243.249524-9-parav@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v4 8/8] virtio-net: Describe RSS using receive queue
 handle

On Wed, Mar 22, 2023 at 11:52:43PM +0200, Parav Pandit wrote:
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

getting there, I feel however there's still too much focus on
rq_id. It's just a struct we use. What matters is the vqn.
More comments below.

> ---
> changelog:
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
> index 435c1fc..8b560f3 100644
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
> @@ -1442,10 +1447,15 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
>  \field{indirection_table} array.
>  Number of entries in \field{indirection_table} is (\field{indirection_table_mask} + 1).
>  
> -Field \field{unclassified_queue} contains the 0-based index of
> -the receive virtqueue to place unclassified packets in. Index 0 corresponds to receiveq1.
> +\field{rss_rq_id} is a receive virtqueue id. \field{vqn_1_16}

Looks like you keep removing the main thing which is *what is this field
actually for*.

More comments:

id is actually abbreviation. Field is actually \field{unclassified_queue} -
rss_rq_id is just a name of struct has no meaning by itself.
so either \field{struct rss_rq_id} or just don't mention this at all.
Below example on how not to mention at all.

Here's one way to put it:

\field{unclassified_queue} identifies a receive virtqueue
to place unclassified packets in. Within \field{unclassified_queue}, \field{vqn_1_16},
consists of bits 1 to 16 of the receive virtqueue number
For example,
\field{vqn_1_16} value of 3 corresponds to virtqueue number 6 maps to receiveq4.

> +consists of bits 1 to 16 of virtqueue number. For example,
> +\field{vqn_1_16} value of 3 corresponds to virtqueue number 6 maps to receiveq4.
> +
> +Field \field{unclassified_queue} contains the receive virtqueue
> +id \field{rss_rq_id} described above.
>  
> -Field \field{indirection_table} contains an array of 0-based indices of receive virtqueues. Index 0 corresponds to receiveq1.
> +Field \field{indirection_table} is an array of receive
> +queue ids described above in \field{rss_rq_id}.

Field \field{indirection_table} is an array of receive queue
identifiers, using the same format as \field{unclassified_queue}.


>  
>  A driver sets \field{max_tx_vq} to inform a device how many transmit virtqueues it may use (transmitq1\ldots transmitq \field{max_tx_vq}).
>  
> @@ -1455,7 +1465,8 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
>  
>  A driver MUST NOT send the VIRTIO_NET_CTRL_MQ_RSS_CONFIG command if the feature VIRTIO_NET_F_RSS has not been negotiated.
>  
> -A driver MUST fill the \field{indirection_table} array only with indices of enabled queues. Index 0 corresponds to receiveq1.
> +A driver MUST fill the \field{indirection_table} array only with
> +the \field{rss_rq_id} corresponding to the enabled receive virtqueues.

There's no field like this. Also not "the" virtqueues - we didn't
discuss them previously. Generally if you want to tweak grammar it's
best to do it separately...

example way to put it better:

\field{vqn_1_16} in each entry corresponding to enabled receive virtqueues.





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
> +\field{rss_rq_id}.

to get \field{vqn_1_16}

>  \item If the destination receive queue is being reset (See \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}), the device MUST drop the packet.
>  \end{itemize}
>  
> -- 
> 2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

