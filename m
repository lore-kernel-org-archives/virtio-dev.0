Return-Path: <virtio-dev-return-13588-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3C4EC6FA8F
	for <virtio-dev@archiver.kernel.org>; Wed, 30 Aug 2023 00:43:12 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id D83447E90B
	for <virtio-dev@archiver.kernel.org>; Wed, 30 Aug 2023 00:43:11 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B703C986514
	for <virtio-dev@archiver.kernel.org>; Wed, 30 Aug 2023 00:43:11 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 99E389864F0; Wed, 30 Aug 2023 00:43:11 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8348B986475;
	Wed, 30 Aug 2023 00:43:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693356185; x=1693960985;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=geBafR2ZZkInUaScdknSMKOSHuAX9Irufb4T1DBz7Gg=;
        b=Nlowmw3dBivtEIj2b47PfQt9Y6804Htsq+NMAmHUbCVD5KLnDVi/s0yIcTwOgrhzy4
         7DiBS5YQWZos/mS2E+xbp1YO2Vj2QzN1nTO9BsT6wdaCwzIkYU3dTjee0AjPrdCIFTmL
         fZSjg4e5ddmi/TbhgXL1nHPNHNGj8vZEl4uePaJ4TJvssmyicgbGKu5P8rvjz4CB8RW9
         yjivF96ygvzdp+WW0wsCvVHJiz4QNlU5O08GIROnORiwz/nMFte9pW6WrYrxcNRGJB3A
         vLzYvRpZOLrPTZRt8eU3CMfouJEoq1vhZ+L26NH4ATIoP4f0UezAdHaP1p/4DHHZpMJS
         f2YA==
X-Gm-Message-State: AOJu0YwnxjqGv1/S1Bmkz0EKhdJmrWskqvQ2SsBS7PDoGS8JIhYECETj
	ELdzqDErW6q1PO5jPqYUzWg=
X-Google-Smtp-Source: AGHT+IFW7TTcputO1R4GxS6ZSsn7cgdndSULJMGIIKblkcVEFkCiWq2kGuOHGh2Y/RzcNW2jn5wmaQ==
X-Received: by 2002:a17:902:edc7:b0:1bb:c5a9:6b26 with SMTP id q7-20020a170902edc700b001bbc5a96b26mr667653plk.5.1693356185213;
        Tue, 29 Aug 2023 17:43:05 -0700 (PDT)
Date: Wed, 30 Aug 2023 00:43:03 +0000
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Bobby Eshleman <bobby.eshleman@bytedance.com>,
	virtio-dev@lists.oasis-open.org, cong.wang@bytedance.com,
	jiang.wang@bytedance.com, cohuck@redhat.com,
	virtualization@lists.linux-foundation.org, stefanha@redhat.com,
	virtio-comment@lists.oasis-open.org, arseny.krasnov@kaspersky.com
Message-ID: <ZO6Ql9iWi6a8vDyU@bullseye>
References: <20230829212945.3420727-1-bobby.eshleman@bytedance.com>
 <20230829181549-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230829181549-mutt-send-email-mst@kernel.org>
Subject: [virtio-dev] Re: [PATCH] virtio-vsock: add VIRTIO_VSOCK_F_DGRAM feature bit

On Tue, Aug 29, 2023 at 06:21:35PM -0400, Michael S. Tsirkin wrote:
> On Tue, Aug 29, 2023 at 09:29:45PM +0000, Bobby Eshleman wrote:
> > This adds support for datagrams to the virtio-vsock device.
> > 
> > virtio-vsock already supports stream and seqpacket types. The existing
> > message types and header fields are extended to support datagrams.
> > Semantic differences between the flow types are stated, as well as any
> > additional requirements for devices and drivers implementing this
> > feature.
> > 
> > Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
> > ---
> >  device-types/vsock/description.tex | 95 +++++++++++++++++++++++++++---
> >  1 file changed, 88 insertions(+), 7 deletions(-)
> > 
> > diff --git a/device-types/vsock/description.tex b/device-types/vsock/description.tex
> > index 7d91d159872f..638dca8e5da1 100644
> > --- a/device-types/vsock/description.tex
> > +++ b/device-types/vsock/description.tex
> > @@ -20,6 +20,7 @@ \subsection{Feature bits}\label{sec:Device Types / Socket Device / Feature bits}
> >  \item[VIRTIO_VSOCK_F_STREAM (0)] stream socket type is supported.
> >  \item[VIRTIO_VSOCK_F_SEQPACKET (1)] seqpacket socket type is supported.
> >  \item[VIRTIO_VSOCK_F_NO_IMPLIED_STREAM (2)] stream socket type is not implied.
> > +\item[VIRTIO_VSOCK_F_DGRAM (3)] datagram socket type is supported.
> >  \end{description}
> >  
> >  \drivernormative{\subsubsection}{Feature bits}{Device Types / Socket Device / Feature bits}
> > @@ -167,17 +168,22 @@ \subsubsection{Addressing}\label{sec:Device Types / Socket Device / Device Opera
> >  consists of a (cid, port number) tuple. The header fields used for this are
> >  \field{src_cid}, \field{src_port}, \field{dst_cid}, and \field{dst_port}.
> >  
> > -Currently stream and seqpacket sockets are supported. \field{type} is 1 (VIRTIO_VSOCK_TYPE_STREAM)
> > -for stream socket types, and 2 (VIRTIO_VSOCK_TYPE_SEQPACKET) for seqpacket socket types.
> > +
> > +Currently stream, seqpacket, and datagram sockets are supported. \field{type} is
> > +1 (VIRTIO_VSOCK_TYPE_STREAM) for stream socket types, 2 (VIRTIO_VSOCK_TYPE_SEQPACKET) for
> > +seqpacket socket types, and 3 (VIRTIO_VSOCK_TYPE_DGRAM) for datagram socket types.
> >  
> >  \begin{lstlisting}
> >  #define VIRTIO_VSOCK_TYPE_STREAM    1
> >  #define VIRTIO_VSOCK_TYPE_SEQPACKET 2
> > +#define VIRTIO_VSOCK_TYPE_DGRAM     3
> >  \end{lstlisting}
> >  
> >  Stream sockets provide in-order, guaranteed, connection-oriented delivery
> >  without message boundaries. Seqpacket sockets provide in-order, guaranteed,
> > -connection-oriented delivery with message and record boundaries.
> > +connection-oriented delivery with message and record boundaries. Datagram
> > +sockets provide connection-less, best-effort delivery of messages, with no
> > +order or reliability guarantees.
> >  
> >  \subsubsection{Buffer Space Management}\label{sec:Device Types / Socket Device / Device Operation / Buffer Space Management}
> >  \field{buf_alloc} and \field{fwd_cnt} are used for buffer space management of
> > @@ -203,16 +209,19 @@ \subsubsection{Buffer Space Management}\label{sec:Device Types / Socket Device /
> >  previously receiving a VIRTIO_VSOCK_OP_CREDIT_REQUEST packet. This allows
> >  communicating updates any time a change in buffer space occurs.
> >  
> > +\field{buf_alloc} and \field{fwd_cnt} are reserved for future use by datagram
> > +sockets. These fields are not used for datagram buffer space management.
> 
> no limits on datagram size?
> 

In the Linux proof-of-concept, it is 64KB. I can add that here too.

> also with no flow control at all there's a performance problem:
> imagine queue gets full. now buffers begin to be dropped.
> problem is, dropping is faster than delivering to application.
> so now application sees its packets consumed super quickly
> and starts sending even faster.
> not good for performance.
> 
> yes datagram expects some way to drop packets but just disabling flow
> control completely is not the right thing to do I think.
> 

On the LKML I discussed using congestion notification as a way to handle
this situation, but deferred it to a future feature bit. I can build
it in from the beginning though.

> 
> > +
> >  \drivernormative{\paragraph}{Device Operation: Buffer Space Management}{Device Types / Socket Device / Device Operation / Buffer Space Management}
> > -VIRTIO_VSOCK_OP_RW data packets MUST only be transmitted when the peer has
> > -sufficient free buffer space for the payload.
> > +For stream and seqpacket flows, VIRTIO_VSOCK_OP_RW data packets MUST only be
> > +transmitted when the peer has sufficient free buffer space for the payload.
> >  
> >  All packets associated with a stream flow MUST contain valid information in
> >  \field{buf_alloc} and \field{fwd_cnt} fields.
> >  
> >  \devicenormative{\paragraph}{Device Operation: Buffer Space Management}{Device Types / Socket Device / Device Operation / Buffer Space Management}
> > -VIRTIO_VSOCK_OP_RW data packets MUST only be transmitted when the peer has
> > -sufficient free buffer space for the payload.
> > +For stream and seqpacket flows, VIRTIO_VSOCK_OP_RW data packets MUST only be
> > +transmitted when the peer has sufficient free buffer space for the payload.
> >  
> >  All packets associated with a stream flow MUST contain valid information in
> >  \field{buf_alloc} and \field{fwd_cnt} fields.
> > @@ -299,6 +308,78 @@ \subsubsection{Seqpacket Sockets}\label{sec:Device Types / Socket Device / Devic
> >  #define VIRTIO_VSOCK_SEQ_EOR (1 << 1)
> >  \end{lstlisting}
> >  
> > +\subsubsection{Datagram Sockets}\label{sec:Device Types / Socket Device / Device Operation / Datagram Sockets}
> > +
> > +\drivernormative{\paragraph}{Device Operation: Packet Fragmentation}{Device Types / Socket Device / Datagram Sockets / Fragmentation}
> > +
> > +Drivers MAY disassemble packets into smaller fragments. If drivers fragment a
> > +packet, they MUST follow the fragmentation rules described in section
> > +\ref{sec:Device Types / Socket Device / Device Operation / Datagram Sockets / Fragmentation}.
> > +
> > +Drivers MUST support assembly of received packet fragments according to the
> > +fragmentation rules described in section
> > +\ref{sec:Device Types / Socket Device / Device Operation / Datagram Sockets / Fragmentation}.
> > +
> > +\devicenormative{\paragraph}{Device Operation: Packet Fragmentation}{Device Types / Socket Device / Datagram Sockets / Fragmentation}
> > +
> > +Devices MAY disassemble packets into smaller fragments. If devices fragment a
> > +packet, they MUST follow the fragmentation rules described in section
> > +\ref{sec:Device Types / Socket Device / Device Operation / Datagram Sockets / Fragmentation}.
> > +
> > +Devices MUST support assembly of received packet fragments according to the
> > +fragmentation rules described in section
> > +\ref{sec:Device Types / Socket Device / Device Operation / Datagram Sockets / Fragmentation}.
> > +
> > +\drivernormative{\paragraph}{Device Operation: Packet Dropping}{Device Types / Socket Device / Datagram Sockets / Dropping}
> > +
> > +The driver MAY drop received packets with no notification to the device. This
> > +can happen if, for example, there are insufficient resources or no socket
> > +exists for the destination address.
> > +
> > +\devicenormative{\paragraph}{Device Operation: Packet Dropping}{Device Types / Socket Device / Datagram Sockets / Dropping}
> > +
> > +The device MAY drop received packets with no notification to the driver. This
> > +can happen if, for example, there are insufficient resources or no socket
> > +exists for the destination address.
> > +
> > +\paragraph{Datagram Fragmentation}\label{sec:Device Types / Socket Device / Device Operation / Datagram Sockets / Fragmentation}
> > +
> > +\field{flags} may have the following bit set:
> > +
> > +\begin{lstlisting}
> > +#define VIRTIO_VSOCK_DGRAM_EOM (1 << 0)
> > +\end{lstlisting}
> > +
> > +When the header \field{flags} field bit VIRTIO_VSOCK_DGRAM_EOM (bit 0) is set,
> > +it indicates that the current payload is the end of a datagram fragment OR that
> > +the current payload is an entire datagram packet.
> > +
> > +Datagram fragmentation is subject to the following rules:
> > +
> > +The fragments for a datagram packet MUST be added to the virtqueue in
> > +sequential order.
> > +
> > +If a packet is not a fragment, then the VIRTIO_VSOCK_DGRAM_EOM bit (bit 0) of
> > +\field{flags} MUST be set.
> > +
> > +If a packet is the last fragment of a fragment sequence, then the
> > +VIRTIO_VSOCK_DGRAM_EOM bit (bit 0) of \field{flags} MUST be set.
> > +
> > +If a packet is any fragment except the last fragment of a fragment sequence,
> > +then the VIRTIO_VSOCK_DGRAM_EOM bit (bit 0) of \field{flags} MUST NOT be set.
> > +
> > +If a driver or device has already placed a fragment of a packet on the
> > +virtqueue, it MUST add the remaining fragments of the packet to the virtqueue
> > +before adding any additional packets or fragments to the virtqueue.
> > +
> > +If fragments for a packet are only partially received after an
> > +implementation-specific amount of time, then the destination device or driver
> > +MAY drop the fragments.
> 
> and how to detect this partial situation?
> 
> and if not then what happens?

All packets with EOM=0 should be added into a per-flow fragment list.

Once a packet with EOM=1 is received, they can all be concatenated and
delivered to the destination socket.

If after X time no packet with EOM=1 is received, then we have detected
this partial situation. The "then what happens part" is that the
fragment list can be dropped and freed. Because the peer must send the
remaining fragments, they will also be dropped and freed until EOM=1 is
received.

> 
> > +Each buffer containing a fragment MUST begin with a valid struct
> > +virtio_vsock_hdr. \field{len} MUST equal the length of the fragment payload
> > +only.
> 
> what does this mean exactly?
> 

It means that len only accounts for the fragment and not the whole
(fragmented) packet. The second sentence means that the virtqueue buffer
starts with the header.

For virtio-net mergable RX buffers the header is only in the first
buffer and the length field accounts for the entire fragmented packet
(that spans multiple bufers), so I suspected the specification was
needed here too.

I'm happy to omit it.

> >  \subsubsection{Device Events}\label{sec:Device Types / Socket Device / Device Operation / Device Events}
> >  
> >  Certain events are communicated by the device to the driver using the event
> > -- 
> > 2.20.1
> 
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

