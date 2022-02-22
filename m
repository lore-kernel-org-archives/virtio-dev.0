Return-Path: <virtio-dev-return-9321-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 69B7E98636F
	for <virtio-dev@lists.oasis-open.org>; Tue, 22 Feb 2022 04:26:45 +0000 (UTC)
MIME-Version: 1.0
References: <20220221083641.115069-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20220221083641.115069-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 22 Feb 2022 12:26:29 +0800
Message-ID: <CACGkMEvmrsH3Kpkr6j8hSGiQ8=DWx9qOX6PyiKrBT-g=TJfqAA@mail.gmail.com>
Subject: Re: [virtio-dev] [PATCH v3] virtio-net: support reset queue
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Virtio-Dev <virtio-dev@lists.oasis-open.org>, "Michael S. Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Feb 21, 2022 at 4:36 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrot=
e:
>
> This patch defines some requirements for virtio-net to support reset
> queues.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  content.tex | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/content.tex b/content.tex
> index c6f116c..e293881 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -4337,6 +4337,11 @@ \subsubsection{Control Virtqueue}\label{sec:Device=
 Types / Network Device / Devi
>  \field{virtqueue_pairs} once it has placed the
>  VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET command in a used buffer.
>
> +After automatic receive steering has completed the selection of the queu=
e,

Nit: I think we can remove this part since the reselection is part of
the steering.

Others look good.

Thanks

> if
> +the destination receive queue is in reset state(See \ref{sec:Basic Facil=
ities of a Virtio Device / Virtqueues / Virtqueue Reset}),
> +the device SHOULD re-select a different random queue. If all receive que=
ues are
> +in reset state, the device MUST drop the packet.
> +
>  \subparagraph{Legacy Interface: Automatic receive steering in multiqueue=
 mode}\label{sec:Device Types / Network Device / Device Operation / Control=
 Virtqueue / Automatic receive steering in multiqueue mode / Legacy Interfa=
ce: Automatic receive steering in multiqueue mode}
>  When using the legacy interface, transitional devices and drivers
>  MUST format \field{virtqueue_pairs}
> @@ -4425,6 +4430,7 @@ \subsubsection{Control Virtqueue}\label{sec:Device =
Types / Network Device / Devi
>  \item Calculate the hash of the packet as defined in \ref{sec:Device Typ=
es / Network Device / Device Operation / Processing of Incoming Packets / H=
ash calculation for incoming packets}.
>  \item If the device did not calculate the hash for the specific packet, =
the device directs the packet to the receiveq specified by \field{unclassif=
ied_queue} of virtio_net_rss_config structure (value of 0 corresponds to re=
ceiveq1).
>  \item Apply \field{indirection_table_mask} to the calculated hash and us=
e the result as the index in the indirection table to get 0-based number of=
 destination receiveq (value of 0 corresponds to receiveq1).
> +\item If the destination receive queue is in reset state(See \ref{sec:Ba=
sic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}), the dev=
ice MUST drop the packet.
>  \end{itemize}
>
>  \paragraph{Offloads State Configuration}\label{sec:Device Types / Networ=
k Device / Device Operation / Control Virtqueue / Offloads State Configurat=
ion}
> --
> 2.31.0
>
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

