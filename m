Return-Path: <virtio-dev-return-13596-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44C29CA0FE1
	for <virtio-dev@archiver.kernel.org>; Fri,  1 Sep 2023 12:45:22 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 7A3DB2AC51
	for <virtio-dev@archiver.kernel.org>; Fri,  1 Sep 2023 12:45:21 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 549D69865A6
	for <virtio-dev@archiver.kernel.org>; Fri,  1 Sep 2023 12:45:21 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 35EA3986589; Fri,  1 Sep 2023 12:45:21 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 24F8598658A
	for <virtio-dev@lists.oasis-open.org>; Fri,  1 Sep 2023 12:45:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: wHF-apSiMdWA-EPAGpvhvQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693572317; x=1694177117;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ouXJVZl4mDR5/cEQyxHcnEFyhfSlawc7J6ry03lS/Xk=;
        b=KpnCGYPqDCqdFN/drP2zhqGRaQ1Y6dfHlYqjNOg7TLdiv6DWEY6rpDv1Mhqi1l3Kv1
         vQcEhXksVC/lkOGviUPhNhqsfKJt/ZBNWrAlXQmZA84DQx7YugCJXc20MA7E9LlEcfdJ
         NK3NrasJtUU4MCt8XlMYLZb6Xzf1F3VoDdWRe+iuut8LsjCUQBr7N9Yxw+R0oMMqdI+H
         W8mdxjab4+k5ydcsZZZ6DXwxoqkEgEGXhhPJHgaAHpUf1bzUqDRSvRqmNuqlaq6hROc2
         7DEE/fLkv08NEnAU6DOnQ5keVpAPg7SrZwDFN8i4QSrDuUf7xNAPj24TDtaGzcDuxx7x
         6eOg==
X-Gm-Message-State: AOJu0Yw23lgcL7khfWtomDbTUxJEJJSMC4pk4bqk0zUa1Jz312yAQrMw
	T/y12KyT7KAYeW0CvNnctUuTpwDzc5lseVMT2/0B2jBeM4hZy96w5bUZA6Wjt5rP9W0LLokT+u1
	zU9OGirtNafH3r74bOEooU32HKe4x
X-Received: by 2002:a17:907:2953:b0:99d:f056:5d6b with SMTP id et19-20020a170907295300b0099df0565d6bmr1523513ejc.20.1693572317718;
        Fri, 01 Sep 2023 05:45:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6/69QvGdy41KX06nMkkHYkHcfdpDOpRN/548wudGayx2mCpSoCRUaTC9GcwIY8kIBKX+y9A==
X-Received: by 2002:a17:907:2953:b0:99d:f056:5d6b with SMTP id et19-20020a170907295300b0099df0565d6bmr1523498ejc.20.1693572317380;
        Fri, 01 Sep 2023 05:45:17 -0700 (PDT)
Date: Fri, 1 Sep 2023 14:45:14 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobby.eshleman@bytedance.com>
Cc: virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org, 
	bobbyeshleman@gmail.com, cong.wang@bytedance.com, stefanha@redhat.com, 
	jiang.wang@bytedance.com, arseny.krasnov@kaspersky.com, 
	virtualization@lists.linux-foundation.org, cohuck@redhat.com, mst@redhat.com
Message-ID: <h6wtvcglyw55enk6shdogbfnw3m6zbmb4lv65uhznpwzqjw5sc@vc7clkjbxfep>
References: <20230829212945.3420727-1-bobby.eshleman@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20230829212945.3420727-1-bobby.eshleman@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH] virtio-vsock: add VIRTIO_VSOCK_F_DGRAM feature bit

On Tue, Aug 29, 2023 at 09:29:45PM +0000, Bobby Eshleman wrote:
>This adds support for datagrams to the virtio-vsock device.
>
>virtio-vsock already supports stream and seqpacket types. The existing
>message types and header fields are extended to support datagrams.
>Semantic differences between the flow types are stated, as well as any
>additional requirements for devices and drivers implementing this
>feature.
>
>Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
>---
> device-types/vsock/description.tex | 95 +++++++++++++++++++++++++++---
> 1 file changed, 88 insertions(+), 7 deletions(-)
>
>diff --git a/device-types/vsock/description.tex b/device-types/vsock/description.tex
>index 7d91d159872f..638dca8e5da1 100644
>--- a/device-types/vsock/description.tex
>+++ b/device-types/vsock/description.tex
>@@ -20,6 +20,7 @@ \subsection{Feature bits}\label{sec:Device Types / Socket Device / Feature bits}
> \item[VIRTIO_VSOCK_F_STREAM (0)] stream socket type is supported.
> \item[VIRTIO_VSOCK_F_SEQPACKET (1)] seqpacket socket type is supported.
> \item[VIRTIO_VSOCK_F_NO_IMPLIED_STREAM (2)] stream socket type is not implied.
>+\item[VIRTIO_VSOCK_F_DGRAM (3)] datagram socket type is supported.
> \end{description}
>
> \drivernormative{\subsubsection}{Feature bits}{Device Types / Socket Device / Feature bits}
>@@ -167,17 +168,22 @@ \subsubsection{Addressing}\label{sec:Device Types / Socket Device / Device Opera
> consists of a (cid, port number) tuple. The header fields used for this are
> \field{src_cid}, \field{src_port}, \field{dst_cid}, and \field{dst_port}.
>
>-Currently stream and seqpacket sockets are supported. \field{type} is 1 (VIRTIO_VSOCK_TYPE_STREAM)
>-for stream socket types, and 2 (VIRTIO_VSOCK_TYPE_SEQPACKET) for seqpacket socket types.
>+
>+Currently stream, seqpacket, and datagram sockets are supported. \field{type} is
>+1 (VIRTIO_VSOCK_TYPE_STREAM) for stream socket types, 2 (VIRTIO_VSOCK_TYPE_SEQPACKET) for
>+seqpacket socket types, and 3 (VIRTIO_VSOCK_TYPE_DGRAM) for datagram socket types.
>
> \begin{lstlisting}
> #define VIRTIO_VSOCK_TYPE_STREAM    1
> #define VIRTIO_VSOCK_TYPE_SEQPACKET 2
>+#define VIRTIO_VSOCK_TYPE_DGRAM     3
> \end{lstlisting}
>
> Stream sockets provide in-order, guaranteed, connection-oriented delivery
> without message boundaries. Seqpacket sockets provide in-order, guaranteed,
>-connection-oriented delivery with message and record boundaries.
>+connection-oriented delivery with message and record boundaries. Datagram
>+sockets provide connection-less, best-effort delivery of messages, with no
>+order or reliability guarantees.
>
> \subsubsection{Buffer Space Management}\label{sec:Device Types / Socket Device / Device Operation / Buffer Space Management}
> \field{buf_alloc} and \field{fwd_cnt} are used for buffer space management of
>@@ -203,16 +209,19 @@ \subsubsection{Buffer Space Management}\label{sec:Device Types / Socket Device /
> previously receiving a VIRTIO_VSOCK_OP_CREDIT_REQUEST packet. This allows
> communicating updates any time a change in buffer space occurs.
>
>+\field{buf_alloc} and \field{fwd_cnt} are reserved for future use by datagram
>+sockets. These fields are not used for datagram buffer space management.
>+
> \drivernormative{\paragraph}{Device Operation: Buffer Space Management}{Device Types / Socket Device / Device Operation / Buffer Space Management}
>-VIRTIO_VSOCK_OP_RW data packets MUST only be transmitted when the peer has
>-sufficient free buffer space for the payload.
>+For stream and seqpacket flows, VIRTIO_VSOCK_OP_RW data packets MUST only be
>+transmitted when the peer has sufficient free buffer space for the payload.
>
> All packets associated with a stream flow MUST contain valid information in
> \field{buf_alloc} and \field{fwd_cnt} fields.
>
> \devicenormative{\paragraph}{Device Operation: Buffer Space 
> Management}{Device Types / Socket Device / Device Operation / Buffer 
> Space Management}
>-VIRTIO_VSOCK_OP_RW data packets MUST only be transmitted when the peer has
>-sufficient free buffer space for the payload.
>+For stream and seqpacket flows, VIRTIO_VSOCK_OP_RW data packets MUST only be
>+transmitted when the peer has sufficient free buffer space for the payload.
>
> All packets associated with a stream flow MUST contain valid information in
> \field{buf_alloc} and \field{fwd_cnt} fields.
>@@ -299,6 +308,78 @@ \subsubsection{Seqpacket Sockets}\label{sec:Device Types / Socket Device / Devic
> #define VIRTIO_VSOCK_SEQ_EOR (1 << 1)
> \end{lstlisting}
>
>+\subsubsection{Datagram Sockets}\label{sec:Device Types / Socket Device / Device Operation / Datagram Sockets}
>+
>+\drivernormative{\paragraph}{Device Operation: Packet Fragmentation}{Device Types / Socket Device / Datagram Sockets / Fragmentation}
>+
>+Drivers MAY disassemble packets into smaller fragments. If drivers fragment a
>+packet, they MUST follow the fragmentation rules described in section
>+\ref{sec:Device Types / Socket Device / Device Operation / Datagram Sockets / Fragmentation}.
>+
>+Drivers MUST support assembly of received packet fragments according to the
>+fragmentation rules described in section
>+\ref{sec:Device Types / Socket Device / Device Operation / Datagram 
>Sockets / Fragmentation}.
>+
>+\devicenormative{\paragraph}{Device Operation: Packet Fragmentation}{Device Types / Socket Device / Datagram Sockets / Fragmentation}
>+
>+Devices MAY disassemble packets into smaller fragments. If devices fragment a
>+packet, they MUST follow the fragmentation rules described in section
>+\ref{sec:Device Types / Socket Device / Device Operation / Datagram Sockets / Fragmentation}.
>+
>+Devices MUST support assembly of received packet fragments according to the
>+fragmentation rules described in section
>+\ref{sec:Device Types / Socket Device / Device Operation / Datagram Sockets / Fragmentation}.
>+
>+\drivernormative{\paragraph}{Device Operation: Packet Dropping}{Device Types / Socket Device / Datagram Sockets / Dropping}
>+
>+The driver MAY drop received packets with no notification to the device. This
>+can happen if, for example, there are insufficient resources or no socket
>+exists for the destination address.
>+
>+\devicenormative{\paragraph}{Device Operation: Packet Dropping}{Device Types / Socket Device / Datagram Sockets / Dropping}
>+
>+The device MAY drop received packets with no notification to the driver. This
>+can happen if, for example, there are insufficient resources or no socket
>+exists for the destination address.

Should we provide some notification if the socket does not exist at the
destination?

>+
>+\paragraph{Datagram Fragmentation}\label{sec:Device Types / Socket Device / Device Operation / Datagram Sockets / Fragmentation}
>+
>+\field{flags} may have the following bit set:
>+
>+\begin{lstlisting}
>+#define VIRTIO_VSOCK_DGRAM_EOM (1 << 0)
>+\end{lstlisting}
>+
>+When the header \field{flags} field bit VIRTIO_VSOCK_DGRAM_EOM (bit 0) is set,
>+it indicates that the current payload is the end of a datagram 
>fragment OR that
>+the current payload is an entire datagram packet.

In the destination, if we discard some fragments, then could we
reconstruct a different datagram from the one sent?

Is that anything acceptable?

Thanks,
Stefano

>+
>+Datagram fragmentation is subject to the following rules:
>+
>+The fragments for a datagram packet MUST be added to the virtqueue in
>+sequential order.
>+
>+If a packet is not a fragment, then the VIRTIO_VSOCK_DGRAM_EOM bit (bit 0) of
>+\field{flags} MUST be set.
>+
>+If a packet is the last fragment of a fragment sequence, then the
>+VIRTIO_VSOCK_DGRAM_EOM bit (bit 0) of \field{flags} MUST be set.
>+
>+If a packet is any fragment except the last fragment of a fragment sequence,
>+then the VIRTIO_VSOCK_DGRAM_EOM bit (bit 0) of \field{flags} MUST NOT be set.
>+
>+If a driver or device has already placed a fragment of a packet on the
>+virtqueue, it MUST add the remaining fragments of the packet to the virtqueue
>+before adding any additional packets or fragments to the virtqueue.
>+
>+If fragments for a packet are only partially received after an
>+implementation-specific amount of time, then the destination device or driver
>+MAY drop the fragments.
>+
>+Each buffer containing a fragment MUST begin with a valid struct
>+virtio_vsock_hdr. \field{len} MUST equal the length of the fragment payload
>+only.
>+
> \subsubsection{Device Events}\label{sec:Device Types / Socket Device / Device Operation / Device Events}
>
> Certain events are communicated by the device to the driver using the event
>-- 
>2.20.1
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

