Return-Path: <virtio-dev-return-11698-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90A18C6FD1D
	for <virtio-dev@archiver.kernel.org>; Tue, 21 Mar 2023 22:21:40 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id C6C33EEA19
	for <virtio-dev@archiver.kernel.org>; Tue, 21 Mar 2023 22:21:39 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8B219986463
	for <virtio-dev@archiver.kernel.org>; Tue, 21 Mar 2023 22:21:39 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 6426F98631B; Tue, 21 Mar 2023 22:21:39 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5202598643E
	for <virtio-dev@lists.oasis-open.org>; Tue, 21 Mar 2023 22:21:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: NyvtAacoObWTyINlQ-ur5Q-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679437296;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4a41ikKbawONelAoJyN/MIPE/x/izEhgxnKy8zj7C1g=;
        b=GyJ/y5RPpr9JeC9eJrthTuOyjbe055BuVc1l8/z5nGvXNbJ8VPO/LEX0GLTjGYG6kA
         Bvi6DDhqkFgUCksDdm2vPvX3q5jaAa64ZJSgoJxBi6BD82nGEf5aDbj59nbuGIfhC0ta
         jkfghyk0XWTAJG3ZepLYsTVxNiy40FHfeg0QB3oGsXKGPCUjjG5y032nCZa8+VxZagoQ
         8GtEzkt+ymb2XHexOmOI3YSgrX803GSYrKwkzrI+ot1mJkcbLha5UiHl0967+jhXzojU
         LKh5bdc8TXRJP4Q5K+7sawGaBvixhxREhFoTXXB4RJODrZcKjC29ZxTiFdmzVLLF04dD
         c2+g==
X-Gm-Message-State: AO0yUKXseDuSVpoHP5EyxS7yhNy6urgtBtj/Fy3UIaj+9BhrSvb+gI4d
	8WJ3zKeAFy7kHAJdcrfTJS4GXfanRor/uVBxe3uKgZ4IijnTi3krgoGE7wIsb/+3CH7gm65ox2g
	2yC2p0qEh8irUwhGPpznK/MWeWP6C
X-Received: by 2002:adf:f48c:0:b0:2c7:a9ec:3 with SMTP id l12-20020adff48c000000b002c7a9ec0003mr3703771wro.65.1679437296300;
        Tue, 21 Mar 2023 15:21:36 -0700 (PDT)
X-Google-Smtp-Source: AK7set+jOgcGeQfGdE2m19IBq2vG70wPzi3pFCsFRWB+2lZrokjbVpoo1wpknFD4s+rXb0IWsjCTnQ==
X-Received: by 2002:adf:f48c:0:b0:2c7:a9ec:3 with SMTP id l12-20020adff48c000000b002c7a9ec0003mr3703753wro.65.1679437295936;
        Tue, 21 Mar 2023 15:21:35 -0700 (PDT)
Date: Tue, 21 Mar 2023 18:21:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: virtio-dev@lists.oasis-open.org, pasic@linux.ibm.com, cohuck@redhat.com,
	virtio-comment@lists.oasis-open.org, shahafs@nvidia.com
Message-ID: <20230321181704-mutt-send-email-mst@kernel.org>
References: <20230321215834.225856-1-parav@nvidia.com>
 <20230321215834.225856-7-parav@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230321215834.225856-7-parav@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v3 6/8] transport-ccw: Refer to the vq by its number

On Tue, Mar 21, 2023 at 11:58:32PM +0200, Parav Pandit wrote:
> Currently specification uses virtqueue index and
> number interchangeably to refer to the virtqueue.
> 
> Instead refer to it by its number.
> 
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
> Signed-off-by: Parav Pandit <parav@nvidia.com>
> 
> ---
> changelog:
> v2->v3:
> - added comment note for queue_select similar to max_queue_size
> v0->v1:
> - new patch
> ---
>  transport-ccw.tex | 27 ++++++++++++++++++++-------
>  1 file changed, 20 insertions(+), 7 deletions(-)
> 
> diff --git a/transport-ccw.tex b/transport-ccw.tex
> index c2e60b6..880b87f 100644
> --- a/transport-ccw.tex
> +++ b/transport-ccw.tex
> @@ -236,14 +236,18 @@ \subsubsection{Configuring a Virtqueue}\label{sec:Virtio Transport Options / Vir
>  
>  \begin{lstlisting}
>  struct vq_config_block {
> -        be16 index;
> +        be16 queue_select;
>          be16 max_queue_size;
>  };
>  \end{lstlisting}
>  
> -The requested number of buffers for queue \field{index} is returned in
> +The requested number of buffers for queue \field{queue_select} is returned in
>  \field{max_queue_size}.
>  
> +\begin{note}
> +\field{queue_select} was previously named as index.

sounds a bit strange, and \field{} is missing. If you insist I'd say
	in previous versions of this specification,
	field{queue_select} was also called queue \field{index}


e.g. in blk we have this:
  In the legacy interface, VIRTIO_BLK_F_FLUSH was also 
  called VIRTIO_BLK_F_WCE.


but I really feel this misses the point, the compat is needed
in the struct definition, not split out after usage
is described. This is why I proposed just making this a comment in the
struct. Why not?



> +\end{note}
> +
>  \begin{note}
>  \field{max_queue_size} was previously named as max_num.
>  \end{note}
> @@ -256,7 +260,7 @@ \subsubsection{Configuring a Virtqueue}\label{sec:Virtio Transport Options / Vir
>  struct vq_info_block {
>          be64 desc;
>          be32 res0;
> -        be16 index;
> +        be16 queue_select;
>          be16 size;
>          be64 driver;
>          be64 device;
> @@ -265,10 +269,14 @@ \subsubsection{Configuring a Virtqueue}\label{sec:Virtio Transport Options / Vir
>  
>  \field{desc}, \field{driver} and \field{device} contain the guest
>  addresses for the descriptor area,
> -available area and used area for queue \field{index}, respectively. The actual
> +available area and used area for queue number \field{queue_select}, respectively. The actual
>  virtqueue size (number of allocated buffers) is transmitted in
>  \field{size}.
>  
> +\begin{note}
> +\field{queue_select} was previously named as index.
> +\end{note}
> +
>  \begin{note}
>  \field{size} was previously named as num.
>  \end{note}
> @@ -286,15 +294,20 @@ \subsubsection{Configuring a Virtqueue}\label{sec:Virtio Transport Options / Vir
>  struct vq_info_block_legacy {
>          be64 queue;
>          be32 align;
> -        be16 index;
> +        be16 queue_select;
>          be16 size;
>  };
>  \end{lstlisting}
>  
> -\field{queue} contains the guest address for queue \field{index},
> +\field{queue} contains the guest address for queue number
> +\field{queue_select},
>  \field{size} the number of buffers
>  and \field{align} the alignment. The queue layout follows \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Legacy Interfaces: A Note on Virtqueue Layout}~\nameref{sec:Basic Facilities of a Virtio Device / Virtqueues / Legacy Interfaces: A Note on Virtqueue Layout}.
>  
> +\begin{note}
> +\field{queue_select} was previously named as index.
> +\end{note}
> +
>  \begin{note}
>  \field{size} was previously named as num.
>  \end{note}
> @@ -583,7 +596,7 @@ \subsubsection{Guest->Host Notification}\label{sec:Virtio Transport Options / Vi
>  For example:
>  \begin{lstlisting}
>  info->cookie = do_notify(schid,
> -                         virtqueue_get_queue_index(vq),
> +                         virtqueue_get_queue_number(vq),
>                           info->cookie);
>  \end{lstlisting}
>  \end{note}
> -- 
> 2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

