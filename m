Return-Path: <virtio-dev-return-9435-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7789B983F05
	for <virtio-dev@lists.oasis-open.org>; Sun, 24 Apr 2022 06:34:26 +0000 (UTC)
Message-ID: <0173cee1-2342-d9b2-b011-12ea9dba1276@redhat.com>
Date: Sun, 24 Apr 2022 14:34:15 +0800
MIME-Version: 1.0
References: <20220222065241.89602-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220222065241.89602-1-xuanzhuo@linux.alibaba.com>
Subject: [virtio-dev] Re: [PATCH v4] virtio-net: support reset queue
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtio-dev@lists.oasis-open.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>


=E5=9C=A8 2022/2/22 14:52, Xuan Zhuo =E5=86=99=E9=81=93:
> This patch defines some requirements for virtio-net to support reset
> queues.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---


Reviewed-by: Jason Wang <jasowang@redhat.com>


>   content.tex | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/content.tex b/content.tex
> index c6f116c..45751f4 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -4337,6 +4337,10 @@ \subsubsection{Control Virtqueue}\label{sec:Device=
 Types / Network Device / Devi
>   \field{virtqueue_pairs} once it has placed the
>   VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET command in a used buffer.
>  =20
> +If the destination receive queue is in reset state(See \ref{sec:Basic Fa=
cilities of a Virtio Device / Virtqueues / Virtqueue Reset}),
> +the device SHOULD re-select a different random queue. If all receive que=
ues are
> +in reset state, the device MUST drop the packet.
> +
>   \subparagraph{Legacy Interface: Automatic receive steering in multiqueu=
e mode}\label{sec:Device Types / Network Device / Device Operation / Contro=
l Virtqueue / Automatic receive steering in multiqueue mode / Legacy Interf=
ace: Automatic receive steering in multiqueue mode}
>   When using the legacy interface, transitional devices and drivers
>   MUST format \field{virtqueue_pairs}
> @@ -4425,6 +4429,7 @@ \subsubsection{Control Virtqueue}\label{sec:Device =
Types / Network Device / Devi
>   \item Calculate the hash of the packet as defined in \ref{sec:Device Ty=
pes / Network Device / Device Operation / Processing of Incoming Packets / =
Hash calculation for incoming packets}.
>   \item If the device did not calculate the hash for the specific packet,=
 the device directs the packet to the receiveq specified by \field{unclassi=
fied_queue} of virtio_net_rss_config structure (value of 0 corresponds to r=
eceiveq1).
>   \item Apply \field{indirection_table_mask} to the calculated hash and u=
se the result as the index in the indirection table to get 0-based number o=
f destination receiveq (value of 0 corresponds to receiveq1).
> +\item If the destination receive queue is in reset state(See \ref{sec:Ba=
sic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}), the dev=
ice MUST drop the packet.
>   \end{itemize}
>  =20
>   \paragraph{Offloads State Configuration}\label{sec:Device Types / Netwo=
rk Device / Device Operation / Control Virtqueue / Offloads State Configura=
tion}


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

