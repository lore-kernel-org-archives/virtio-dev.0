Return-Path: virtio-dev-return-6210-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B131198406D
	for <virtio-dev@lists.oasis-open.org>; Mon,  7 Oct 2019 17:29:54 +0000 (UTC)
References: <1463684030-23555-1-git-send-email-stefanha@redhat.com>
From: Matti Moell <Matti.Moell@opensynergy.com>
Message-ID: <dd3b5bfb-af0e-5d19-e208-c5f59e3895d7@opensynergy.com>
Date: Mon, 7 Oct 2019 19:29:49 +0200
MIME-Version: 1.0
In-Reply-To: <1463684030-23555-1-git-send-email-stefanha@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH] virtio-blk: document VIRTIO_BLK_F_MQ multiqueue feature
To: Stefan Hajnoczi <stefanha@redhat.com>, virtio-dev@lists.oasis-open.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Ming Lei <ming.lei@canonical.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Stefan,

I wasn't able to find any discussion about not including multiqueue in 
the spec and this patch was never applied, is there any particular 
reason why it wasn't added?

Should it even be added to the spec?

Cheers,

		Matti

On 19.05.16 20:53, Stefan Hajnoczi wrote:
> Linux 3.17 added the virtio-blk multiqueue feature to the virtio_blk
> guest driver.  The feature was never formalized in the VIRTIO
> specification.  Let's document it now.
> 
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Ming Lei <ming.lei@canonical.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   trunk/content.tex | 12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/trunk/content.tex b/trunk/content.tex
> index d989d98..c8fd79c 100644
> --- a/trunk/content.tex
> +++ b/trunk/content.tex
> @@ -4023,6 +4023,8 @@ device except where noted.
>   \subsection{Virtqueues}\label{sec:Device Types / Block Device / Virtqueues}
>   \begin{description}
>   \item[0] requestq
> +\item[\ldots]
> +\item[N] requestqN
>   \end{description}
>   
>   \subsection{Feature bits}\label{sec:Device Types / Block Device / Feature bits}
> @@ -4043,6 +4045,8 @@ device except where noted.
>   
>   \item[VIRTIO_BLK_F_TOPOLOGY (10)] Device exports information on optimal I/O
>       alignment.
> +
> +\item[VIRTIO_BLK_F_MQ (12)] Number of virtqueues is in \field{num_queues}.
>   \end{description}
>   
>   \subsubsection{Legacy Interface: Feature bits}\label{sec:Device Types / Block Device / Feature bits / Legacy Interface: Feature bits}
> @@ -4090,6 +4094,8 @@ struct virtio_blk_config {
>                   le32 opt_io_size;
>           } topology;
>           u8 reserved;
> +        u8 reserved2;
> +        le16 num_queues;
>   };
>   \end{lstlisting}
>   
> @@ -4119,6 +4125,10 @@ according to the native endian of the guest rather than
>     \field{topology} struct can be read to determine the physical block size and optimal
>     I/O lengths for the driver to use. This also does not affect the units
>     in the protocol, only performance.
> +
> +\item If the VIRTIO_BLK_F_MQ feature is negotiated, \field{num_queues} can be
> +  read to determine the number of virtqueues.  There is always at least 1
> +  virtqueue even if the feature is not negotiated.
>   \end{enumerate}
>   
>   \subsubsection{Legacy Interface: Device Initialization}\label{sec:Device Types / Block Device / Device Initialization / Legacy Interface: Device Initialization}
> @@ -4137,7 +4147,7 @@ after a driver announced lack of support for VIRTIO_BLK_F_FLUSH.
>   
>   \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Operation}
>   
> -The driver queues requests to the virtqueue, and they are used by
> +The driver queues requests to a virtqueue, and they are used by
>   the device (not necessarily in order). Each request is of form:
>   
>   \begin{lstlisting}
> 


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

