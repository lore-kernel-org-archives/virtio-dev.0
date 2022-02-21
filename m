Return-Path: <virtio-dev-return-9317-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8CE8A986349
	for <virtio-dev@lists.oasis-open.org>; Mon, 21 Feb 2022 04:27:31 +0000 (UTC)
Message-ID: <ca643724-2d75-a796-2eb7-a2b397e82071@redhat.com>
Date: Mon, 21 Feb 2022 12:27:20 +0800
MIME-Version: 1.0
References: <20220210110343.24848-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220210110343.24848-1-xuanzhuo@linux.alibaba.com>
Subject: [virtio-dev] Re: [PATCH v2] virtio-net: support reset queue
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtio-dev@lists.oasis-open.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>


=E5=9C=A8 2022/2/10 =E4=B8=8B=E5=8D=887:03, Xuan Zhuo =E5=86=99=E9=81=93:
> This patch defines some requirements for virtio-net to support reset
> queues.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>   conformance.tex |  1 +
>   content.tex     | 16 ++++++++++++++++
>   2 files changed, 17 insertions(+)
>
> diff --git a/conformance.tex b/conformance.tex
> index 42f8537..3656da5 100644
> --- a/conformance.tex
> +++ b/conformance.tex
> @@ -396,6 +396,7 @@ \section{Conformance Targets}\label{sec:Conformance /=
 Conformance Targets}
>   \item \ref{devicenormative:Device Types / Network Device / Device Opera=
tion / Packet Transmission}
>   \item \ref{devicenormative:Device Types / Network Device / Device Opera=
tion / Setting Up Receive Buffers}
>   \item \ref{devicenormative:Device Types / Network Device / Device Opera=
tion / Processing of Incoming Packets}
> +\item \ref{devicenormative:Device Types / Network Device / Device Operat=
ion / Reset Virtqueue}
>   \item \ref{devicenormative:Device Types / Network Device / Device Opera=
tion / Control Virtqueue / Packet Receive Filtering}
>   \item \ref{devicenormative:Device Types / Network Device / Device Opera=
tion / Control Virtqueue / Setting MAC Address Filtering}
>   \item \ref{devicenormative:Device Types / Network Device / Device Opera=
tion / Control Virtqueue / Gratuitous Packet Sending}
> diff --git a/content.tex b/content.tex
> index c6f116c..63dacb0 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -4000,6 +4000,22 @@ \subsubsection{Processing of Incoming Packets}\lab=
el{sec:Device Types / Network
>   #define VIRTIO_NET_HASH_REPORT_UDPv6_EX        9
>   \end{lstlisting}
>  =20
> +\subsubsection{Reset Virtqueue}\label{sec:Device Types / Network Device =
/ Device Operation / Reset Virtqueue}
> +
> +The receive and transmission virtqueues and the control virtqueue can im=
plement
> +reset based on Virtqueue Reset (See \ref{sec:Basic Facilities of a Virti=
o Device / Virtqueues / Virtqueue Reset}).
> +
> +\devicenormative{\paragraph}{Gratuitous Packet Sending}{Device Types / N=
etwork Device / Device Operation / Reset Virtqueue}


s/"Gratuitous Packet Sending"/"Reset Virtqueue"/ ?


> +
> +After automatic receive steering or RSS receive steering has completed t=
he
> +selection of the queue, if the destination receive queue is in reset sta=
te,
> +the device SHOULD re-select a different random queue.
> +
> +After RSS receive steering has completed the selection of the queue, if =
the
> +destination receive queue is in reset state, the device can drop the pac=
ket.


I guess what we really mean is to use "MUST" here? And this paragraph=20
(can drop) seems conflict with previous one (SHOULD re-select)?

I wonder if it's better to add stuffs simply in the device normative in=20
automatic steering and RSS instead of using a dedicated subsection here.

Thanks


> +
> +If all receive queues are in reset state, the device can drop the packet=
.
> +
>   \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Devi=
ce / Device Operation / Control Virtqueue}
>  =20
>   The driver uses the control virtqueue (if VIRTIO_NET_F_CTRL_VQ is


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

