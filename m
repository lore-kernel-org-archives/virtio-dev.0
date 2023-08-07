Return-Path: <virtio-dev-return-13481-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5158BC04A6A
	for <virtio-dev@archiver.kernel.org>; Mon,  7 Aug 2023 14:57:03 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id B2BFE3357F
	for <virtio-dev@archiver.kernel.org>; Mon,  7 Aug 2023 14:57:02 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AABEF986461
	for <virtio-dev@archiver.kernel.org>; Mon,  7 Aug 2023 14:57:02 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 9EA1E984033; Mon,  7 Aug 2023 14:57:02 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8E8A898612D
	for <virtio-dev@lists.oasis-open.org>; Mon,  7 Aug 2023 14:57:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: Tyx8vJzfPm-AvsqbcWx-lg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691420207; x=1692025007;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=52FkRl8JBmd88a7U93GJp9SZlYNH5Bc//dB257xfwD8=;
        b=jU3ZCZmbhZ8vhYlF0PZFyV4MyoXDBK3YaiDx+QTsENPXyRvkP82rSuWM719I3msOx6
         6vkcYEdw0RNUKm+aMlp3KvTidR+/EoaNam/UZANKXtEvYKOgrl9sisyzDRZ+LEF7uUNV
         Z78vTYSrZXCIug9Pnc2njJJHiu42iZ10X0m14pjkpW1o4VYMY9OTrvnAG4WIjv60wV6E
         lzGoZt2D2Rqs+5DE6yL6Zy9/bo4xnxzwPSUmmQfoak63D0Im82BJVjjVS6qp0iTG51WF
         2+1JlX+WjldIKKHXTfvPPKFJMLUpXSW0KYAvwaP3i79xajwisUanGX7AB5pvf0pnDWbP
         PlLQ==
X-Gm-Message-State: AOJu0Yyb1ctUAxJu9mKrIhqgFrgGwqV1EuGU3TYJSkAD+zOv396juZxP
	tci0ABHRYLPILMdbssmWw+K9r63Fv5JmDV9l9LPDJY+p+FPpaR8MJ9AvMgAVHk8RHIiH4LbGAER
	byFpx9/t9zfcooiIq0oHyhjXUFhw4
X-Received: by 2002:a17:907:7815:b0:99c:e1f4:271f with SMTP id la21-20020a170907781500b0099ce1f4271fmr1571382ejc.18.1691420206857;
        Mon, 07 Aug 2023 07:56:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSNO5VqhsMBLS46dXMPNc3raL6VWNmb7j3i4ViFNdpNj2v3co8CkrmAOvdhNqHrxzb04dIiQ==
X-Received: by 2002:a17:907:7815:b0:99c:e1f4:271f with SMTP id la21-20020a170907781500b0099ce1f4271fmr1571375ejc.18.1691420206522;
        Mon, 07 Aug 2023 07:56:46 -0700 (PDT)
Date: Mon, 7 Aug 2023 10:56:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org,
	jasowang@redhat.com, parav@nvidia.com, xuanzhuo@linux.alibaba.com
Message-ID: <20230807104317-mutt-send-email-mst@kernel.org>
References: <20230728084635.19916-1-hengqi@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <20230728084635.19916-1-hengqi@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH] virtio-net: support the outer source port hash for
 UDP-encapsulated packets

On Fri, Jul 28, 2023 at 04:46:35PM +0800, Heng Qi wrote:
> UDP tunneling protocols usually identify a flow using the outer source UDP
> port, which is useful for processing UDP-encapsulated packets, such as
> increasing entropy for RSS queue selection or hashing the same flow to the
> same receive queue. Therefore, we extend it as a new RSS configuration.
>

that's not a real motivation is it? it's already included for
increasing entropy.

the real motivation is ignoring source and destination ip
because they can change if tunneling gateway changes, right?

 
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  device-types/net/description.tex        | 49 ++++++++++++++++++++++++-
>  device-types/net/device-conformance.tex |  1 +
>  2 files changed, 48 insertions(+), 2 deletions(-)
> 
> diff --git a/device-types/net/description.tex b/device-types/net/description.tex
> index 76585b0..366775a 100644
> --- a/device-types/net/description.tex
> +++ b/device-types/net/description.tex
> @@ -88,6 +88,9 @@ \subsection{Feature bits}\label{sec:Device Types / Network Device / Feature bits
>  \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through control
>      channel.
>  
> +\item[VIRTIO_NET_F_HASH_UDP_TUNNEL_SRCPORT(50)] Device supports outer source port hash
> +    for UDP-encapsulated packets.
> +
>  \item[VIRTIO_NET_F_HASH_TUNNEL(51)] Device supports inner header hash for encapsulated packets.
>  
>  \item[VIRTIO_NET_F_VQ_NOTF_COAL(52)] Device supports virtqueue notification coalescing.
> @@ -150,6 +153,7 @@ \subsubsection{Feature bit requirements}\label{sec:Device Types / Network Device
>  \item[VIRTIO_NET_F_RSS] Requires VIRTIO_NET_F_CTRL_VQ.
>  \item[VIRTIO_NET_F_VQ_NOTF_COAL] Requires VIRTIO_NET_F_CTRL_VQ.
>  \item[VIRTIO_NET_F_HASH_TUNNEL] Requires VIRTIO_NET_F_CTRL_VQ along with VIRTIO_NET_F_RSS or VIRTIO_NET_F_HASH_REPORT.
> +\item[VIRTIO_NET_F_HASH_UDP_TUNNEL_SRCPORT] Requires VIRTIO_NET_F_CTRL_VQ along with VIRTIO_NET_F_RSS or VIRTIO_NET_F_HASH_REPORT.
>  \end{description}
>  
>  \subsubsection{Legacy Interface: Feature bits}\label{sec:Device Types / Network Device / Feature bits / Legacy Interface: Feature bits}
> @@ -927,11 +931,29 @@ \subsubsection{Processing of Incoming Packets}\label{sec:Device Types / Network
>  #define VIRTIO_NET_HASH_TYPE_UDP_EX            (1 << 8)
>  \end{lstlisting}
>  
> +A UDP-encapsulated packet uses UDP as the transport protocol in the outer header
> +\ref{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets / Encapsulated packet}.
> +UDP tunneling protocols usually use the outer source UDP port to identify a specific flow.
> +The hash calculated over the outer source UDP port
> can thus be used by the device to queue these different flows

what does this "can be used" mean here is unclear.

> +on different receive queues or queue the same specific flow on the same receive queue.

different from what? same as what?


> +
> +If additionally the feature VIRTIO_NET_F_HASH_UDP_TUNNEL_SRCPORT was negotiated,
> +the following hash types are applicable for UDP-encapsulated packets:
> +\begin{lstlisting}
> +#define VIRTIO_NET_HASH_TYPE_UDPv4_TUNNEL_SRCPORT (1 << 9)
> +#define VIRTIO_NET_HASH_TYPE_UDPv6_TUNNEL_SRCPORT (1 << 10)
> +\end{lstlisting}
> +
>  \subparagraph{IPv4 packets}
>  \label{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets / IPv4 packets}
>  The device calculates the hash on IPv4 packets according to 'Enabled hash types' bitmask as follows:
>  \begin{itemize}
> -\item If VIRTIO_NET_HASH_TYPE_TCPv4 is set and the packet has
> +\item If additionally VIRTIO_NET_HASH_TYPE_UDPv4_TUNNEL_SRCPORT is set and a received encapsulated

what makes the packet "encapsulated" here is unclear.

> +packet has an outer UDPv4 header, the hash is calculated over the following fields:
> +\begin{itemize}
> +\item Outer source UDP port
> +\end{itemize}
> +\item Else if VIRTIO_NET_HASH_TYPE_TCPv4 is set and the packet has
>  a TCP header, the hash is calculated over the following fields:
>  \begin{itemize}
>  \item Source IP address
> @@ -961,7 +983,12 @@ \subsubsection{Processing of Incoming Packets}\label{sec:Device Types / Network
>  The device calculates the hash on IPv6 packets without extension
>  headers according to 'Enabled hash types' bitmask as follows:
>  \begin{itemize}
> -\item If VIRTIO_NET_HASH_TYPE_TCPv6 is set and the packet has
> +\item If additionally VIRTIO_NET_HASH_TYPE_UDPv6_TUNNEL_SRCPORT is set and a received encapsulated
> +packet has an outer UDPv6 header, the hash is calculated over the following fields:
> +\begin{itemize}
> +\item Outer source UDP port
> +\end{itemize}
> +\item Else if VIRTIO_NET_HASH_TYPE_TCPv6 is set and the packet has
>  a TCPv6 header, the hash is calculated over the following fields:
>  \begin{itemize}
>  \item Source IPv6 address
> @@ -991,6 +1018,11 @@ \subsubsection{Processing of Incoming Packets}\label{sec:Device Types / Network
>  The device calculates the hash on IPv6 packets with extension
>  headers according to 'Enabled hash types' bitmask as follows:
>  \begin{itemize}
> +\item If additionally VIRTIO_NET_HASH_TYPE_UDPv6_TUNNEL_SRCPORT is set and a received encapsulated
> +packet has an outer UDPv6 header, the hash is calculated over the following fields:
> +\begin{itemize}
> +\item Outer source UDP port
> +\end{itemize}
>  \item If VIRTIO_NET_HASH_TYPE_TCP_EX is set and the packet
>  has a TCPv6 header, the hash is calculated over the following fields:
>  \begin{itemize}
> @@ -1139,8 +1171,21 @@ \subsubsection{Processing of Incoming Packets}\label{sec:Device Types / Network
>  #define VIRTIO_NET_HASH_REPORT_IPv6_EX         7
>  #define VIRTIO_NET_HASH_REPORT_TCPv6_EX        8
>  #define VIRTIO_NET_HASH_REPORT_UDPv6_EX        9
> +#define VIRTIO_NET_HASH_REPORT_UDPv4_TUNNEL_SRCPORT 10 /* Only if additionally VIRTIO_NET_F_HASH_UDP_TUNNEL_SRCPORT was negotiated */
> +#define VIRTIO_NET_HASH_REPORT_UDPv6_TUNNEL_SRCPORT 11 /* Only if additionally VIRTIO_NET_F_HASH_UDP_TUNNEL_SRCPORT was negotiated */
>  \end{lstlisting}
>  
> +\devicenormative{\subparagraph}{Outer Source UDP Port}{Device Types / Network Device / Device Operation / Outer Source UDP Port}
> +
> +When all the following cases occur:
> +\begin{itemize}
> +\item Both VIRTIO_NET_F_HASH_UDP_TUNNEL_SRCPORT and VIRTIO_NET_F_HASH_TUNNEL are negotiated.
> +\item A received UDP-encapsulated packet's outer header matches one of the encapsulation types enabled in \field{enabled_tunnel_types}.
> +\item VIRTIO_NET_HASH_TYPE_UDPv4_TUNNEL_SRCPORT is set in \field{hash_types} and a received encapsulated packet has an outer UDPv4 header or
> +      VIRTIO_NET_HASH_TYPE_UDPv6_TUNNEL_SRCPORT is set in \field{hash_types} and a received encapsulated packet has an outer UDPv6 header.
> +\end{itemize}
> +the device MUST calculate the hash over the inner header rather than the outer source UDP port.
> +
>  \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue}
>  
>  The driver uses the control virtqueue (if VIRTIO_NET_F_CTRL_VQ is
> diff --git a/device-types/net/device-conformance.tex b/device-types/net/device-conformance.tex
> index f88f48b..4fd036b 100644
> --- a/device-types/net/device-conformance.tex
> +++ b/device-types/net/device-conformance.tex
> @@ -7,6 +7,7 @@
>  \item \ref{devicenormative:Device Types / Network Device / Device Operation / Packet Transmission}
>  \item \ref{devicenormative:Device Types / Network Device / Device Operation / Setting Up Receive Buffers}
>  \item \ref{devicenormative:Device Types / Network Device / Device Operation / Processing of Incoming Packets}
> +\item \ref{devicenormative:Device Types / Network Device / Device Operation / Outer Source UDP Port}
>  \item \ref{devicenormative:Device Types / Network Device / Device Operation / Control Virtqueue / Packet Receive Filtering}
>  \item \ref{devicenormative:Device Types / Network Device / Device Operation / Control Virtqueue / Setting MAC Address Filtering}
>  \item \ref{devicenormative:Device Types / Network Device / Device Operation / Control Virtqueue / VLAN Filtering}
> -- 
> 2.19.1.6.gb485710b


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

