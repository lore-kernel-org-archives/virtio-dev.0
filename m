Return-Path: <virtio-dev-return-10139-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 149A3986507
	for <virtio-dev@lists.oasis-open.org>; Wed,  9 Nov 2022 13:20:19 +0000 (UTC)
Date: Wed, 9 Nov 2022 08:20:11 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20221109081558-mutt-send-email-mst@kernel.org>
References: <20221109113257.120297-2-hengqi@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <20221109113257.120297-2-hengqi@linux.alibaba.com>
Subject: [virtio-dev] Re: [PATCH 1/2] virtio_net: fix syntax errors
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: virtio-dev@lists.oasis-open.org, Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Nov 09, 2022 at 07:32:56PM +0800, Heng Qi wrote:
> From: Heng Qi <henqqi@linux.alibaba.com>
> 
> \field{hash_types} can contain multiple bitmasks.

I don't think this matches accepted usage.

It's a mask in that cleared bits mask unavailable hash types.

Besides I think it would be a grammar error not a syntax one :)

> Signed-off-by: Heng Qi <henqqi@linux.alibaba.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  content.tex | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/content.tex b/content.tex
> index e863709..6fabf1d 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -3210,7 +3210,7 @@ \subsection{Device configuration layout}\label{sec:Device Types / Network Device
>  The next field, \field{supported_hash_types} only exists if the device supports hash calculation,
>  i.e. if VIRTIO_NET_F_RSS or VIRTIO_NET_F_HASH_REPORT is set.
>  
> -Field \field{supported_hash_types} contains the bitmask of supported hash types.
> +Field \field{supported_hash_types} contains the bitmasks of supported hash types.
>  See \ref{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets / Supported/enabled hash types} for details of supported hash types.
>  
>  \devicenormative{\subsubsection}{Device configuration layout}{Device Types / Network Device / Device configuration layout}
> @@ -4369,7 +4369,7 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
>      u8 hash_key_data[hash_key_length];
>  };
>  \end{lstlisting}
> -Field \field{hash_types} contains a bitmask of allowed hash types as
> +Field \field{hash_types} contains bitmasks of allowed hash types as
>  defined in
>  \ref{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets / Supported/enabled hash types}.
>  Initially the device has all hash types disabled and reports only VIRTIO_NET_HASH_REPORT_NONE.
> @@ -4398,7 +4398,7 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
>      u8 hash_key_data[hash_key_length];
>  };
>  \end{lstlisting}
> -Field \field{hash_types} contains a bitmask of allowed hash types as
> +Field \field{hash_types} contains bitmasks of allowed hash types as
>  defined in
>  \ref{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets / Supported/enabled hash types}.
>  
> -- 
> 2.19.1.6.gb485710b


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

