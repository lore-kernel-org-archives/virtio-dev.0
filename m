Return-Path: <virtio-dev-return-13632-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDC8CEB8FA5
	for <virtio-dev@archiver.kernel.org>; Wed,  6 Sep 2023 08:18:08 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 533B97B0AD
	for <virtio-dev@archiver.kernel.org>; Wed,  6 Sep 2023 08:18:08 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 453F59865EE
	for <virtio-dev@archiver.kernel.org>; Wed,  6 Sep 2023 08:18:08 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 371BC9865C9; Wed,  6 Sep 2023 08:18:08 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 292249865D0
	for <virtio-dev@lists.oasis-open.org>; Wed,  6 Sep 2023 08:18:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: bf6sM1lxNo-u7XXsRQcf0Q-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693988284; x=1694593084;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EEWHH7s1tqM5Re2X1thPTcUM+yV+Rev1ROiI6AZZKi0=;
        b=J8OP7nlbVmAIiyJ/sWLII4XrWkySUW39wn/YeZZt+gOrrnJP1LGjjsC/lc+o2Li6Gw
         68KudulvBAP4tq2p7KDMw4BK6eAsQhhuZX3gzHmkPzNwjMZl13MB5zNmds1DK6Npqd/O
         5OAZ+zW+jhW34NH3mdJfGhCxX1YxBdcXN0fOiRYqGj6INY2Exgz38oXhGGPsdh2SN0MS
         /mBXLmvvleASnyqRuageoioKu6Sb4mDV8c9nqxvvxWXksVb1RkNwtwERjgckySv2RHnh
         YBNQ1IX8LX43Vr4EFcZLSvezzW7ED8Si9bUECNYnnwVg8FBncUZLwpLrAVEjjAq220BW
         I7hw==
X-Gm-Message-State: AOJu0YyShN1JcXBn0y3i+pihA00ksIhqkpDAP1bFoFd8KK1E54It02QA
	0rYGjAQH7FWdfmYUM+hu+S8RC3ZtC3iOwtjhAMZGmkikL5f95RsiwzpI6cIovfW5+CB1Z25oKeP
	XYTWtHkVb2eLXczJZyq/+8IOjSFF5
X-Received: by 2002:a17:907:b11:b0:9a5:ed5b:2418 with SMTP id h17-20020a1709070b1100b009a5ed5b2418mr1507619ejl.55.1693988284030;
        Wed, 06 Sep 2023 01:18:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0TCylGxUC7GNlvV2jjSG6jUCdlP8HrEHiV+5Wk9y+cG3aE3mI8cUjxW5EKW051M1JZnAfTQ==
X-Received: by 2002:a17:907:b11:b0:9a5:ed5b:2418 with SMTP id h17-20020a1709070b1100b009a5ed5b2418mr1507601ejl.55.1693988283606;
        Wed, 06 Sep 2023 01:18:03 -0700 (PDT)
Date: Wed, 6 Sep 2023 04:17:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: virtio-dev@lists.oasis-open.org, cong.wang@bytedance.com,
	Bobby Eshleman <bobby.eshleman@bytedance.com>,
	jiang.wang@bytedance.com, cohuck@redhat.com,
	virtualization@lists.linux-foundation.org, stefanha@redhat.com,
	virtio-comment@lists.oasis-open.org, arseny.krasnov@kaspersky.com
Message-ID: <20230906041708-mutt-send-email-mst@kernel.org>
References: <20230829212945.3420727-1-bobby.eshleman@bytedance.com>
 <20230829181549-mutt-send-email-mst@kernel.org>
 <ZO6Ql9iWi6a8vDyU@bullseye>
 <20230901091938-mutt-send-email-mst@kernel.org>
 <ZPK7/84QeSHtYGBQ@bullseye>
 <20230902043532-mutt-send-email-mst@kernel.org>
 <ZPL/Ss6sXmfU/0Mg@bullseye>
MIME-Version: 1.0
In-Reply-To: <ZPL/Ss6sXmfU/0Mg@bullseye>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH] virtio-vsock: add VIRTIO_VSOCK_F_DGRAM feature bit

On Sat, Sep 02, 2023 at 09:24:26AM +0000, Bobby Eshleman wrote:
> On Sat, Sep 02, 2023 at 04:41:28AM -0400, Michael S. Tsirkin wrote:
> > On Sat, Sep 02, 2023 at 04:37:19AM +0000, Bobby Eshleman wrote:
> > > On Fri, Sep 01, 2023 at 09:31:03AM -0400, Michael S. Tsirkin wrote:
> > > > On Wed, Aug 30, 2023 at 12:43:03AM +0000, Bobby Eshleman wrote:
> > > > > On Tue, Aug 29, 2023 at 06:21:35PM -0400, Michael S. Tsirkin wrote:
> > > > > > On Tue, Aug 29, 2023 at 09:29:45PM +0000, Bobby Eshleman wrote:
> > > > > > > This adds support for datagrams to the virtio-vsock device.
> > > > > > > 
> > > > > > > virtio-vsock already supports stream and seqpacket types. The existing
> > > > > > > message types and header fields are extended to support datagrams.
> > > > > > > Semantic differences between the flow types are stated, as well as any
> > > > > > > additional requirements for devices and drivers implementing this
> > > > > > > feature.
> > > > > > > 
> > > > > > > Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
> > > > > > > ---
> > > > > > >  device-types/vsock/description.tex | 95 +++++++++++++++++++++++++++---
> > > > > > >  1 file changed, 88 insertions(+), 7 deletions(-)
> > > > > > > 
> > > > > > > diff --git a/device-types/vsock/description.tex b/device-types/vsock/description.tex
> > > > > > > index 7d91d159872f..638dca8e5da1 100644
> > > > > > > --- a/device-types/vsock/description.tex
> > > > > > > +++ b/device-types/vsock/description.tex
> > > > > > > @@ -20,6 +20,7 @@ \subsection{Feature bits}\label{sec:Device Types / Socket Device / Feature bits}
> > > > > > >  \item[VIRTIO_VSOCK_F_STREAM (0)] stream socket type is supported.
> > > > > > >  \item[VIRTIO_VSOCK_F_SEQPACKET (1)] seqpacket socket type is supported.
> > > > > > >  \item[VIRTIO_VSOCK_F_NO_IMPLIED_STREAM (2)] stream socket type is not implied.
> > > > > > > +\item[VIRTIO_VSOCK_F_DGRAM (3)] datagram socket type is supported.
> > > > > > >  \end{description}
> > > > > > >  
> > > > > > >  \drivernormative{\subsubsection}{Feature bits}{Device Types / Socket Device / Feature bits}
> > > > > > > @@ -167,17 +168,22 @@ \subsubsection{Addressing}\label{sec:Device Types / Socket Device / Device Opera
> > > > > > >  consists of a (cid, port number) tuple. The header fields used for this are
> > > > > > >  \field{src_cid}, \field{src_port}, \field{dst_cid}, and \field{dst_port}.
> > > > > > >  
> > > > > > > -Currently stream and seqpacket sockets are supported. \field{type} is 1 (VIRTIO_VSOCK_TYPE_STREAM)
> > > > > > > -for stream socket types, and 2 (VIRTIO_VSOCK_TYPE_SEQPACKET) for seqpacket socket types.
> > > > > > > +
> > > > > > > +Currently stream, seqpacket, and datagram sockets are supported. \field{type} is
> > > > > > > +1 (VIRTIO_VSOCK_TYPE_STREAM) for stream socket types, 2 (VIRTIO_VSOCK_TYPE_SEQPACKET) for
> > > > > > > +seqpacket socket types, and 3 (VIRTIO_VSOCK_TYPE_DGRAM) for datagram socket types.
> > > > > > >  
> > > > > > >  \begin{lstlisting}
> > > > > > >  #define VIRTIO_VSOCK_TYPE_STREAM    1
> > > > > > >  #define VIRTIO_VSOCK_TYPE_SEQPACKET 2
> > > > > > > +#define VIRTIO_VSOCK_TYPE_DGRAM     3
> > > > > > >  \end{lstlisting}
> > > > > > >  
> > > > > > >  Stream sockets provide in-order, guaranteed, connection-oriented delivery
> > > > > > >  without message boundaries. Seqpacket sockets provide in-order, guaranteed,
> > > > > > > -connection-oriented delivery with message and record boundaries.
> > > > > > > +connection-oriented delivery with message and record boundaries. Datagram
> > > > > > > +sockets provide connection-less, best-effort delivery of messages, with no
> > > > > > > +order or reliability guarantees.
> > > > > > >  
> > > > > > >  \subsubsection{Buffer Space Management}\label{sec:Device Types / Socket Device / Device Operation / Buffer Space Management}
> > > > > > >  \field{buf_alloc} and \field{fwd_cnt} are used for buffer space management of
> > > > > > > @@ -203,16 +209,19 @@ \subsubsection{Buffer Space Management}\label{sec:Device Types / Socket Device /
> > > > > > >  previously receiving a VIRTIO_VSOCK_OP_CREDIT_REQUEST packet. This allows
> > > > > > >  communicating updates any time a change in buffer space occurs.
> > > > > > >  
> > > > > > > +\field{buf_alloc} and \field{fwd_cnt} are reserved for future use by datagram
> > > > > > > +sockets. These fields are not used for datagram buffer space management.
> > > > > > 
> > > > > > no limits on datagram size?
> > > > > > 
> > > > > 
> > > > > In the Linux proof-of-concept, it is 64KB. I can add that here too.
> > > > 
> > > > or device driven maybe ...
> > > > 
> > > 
> > > Ah yes, I think Stefano was suggesting something like Laura's proposal:
> > > https://lists.oasis-open.org/archives/virtio-comment/202206/msg00093.html
> > > 
> > > > > > also with no flow control at all there's a performance problem:
> > > > > > imagine queue gets full. now buffers begin to be dropped.
> > > > > > problem is, dropping is faster than delivering to application.
> > > > > > so now application sees its packets consumed super quickly
> > > > > > and starts sending even faster.
> > > > > > not good for performance.
> > > > > > 
> > > > > > yes datagram expects some way to drop packets but just disabling flow
> > > > > > control completely is not the right thing to do I think.
> > > > > > 
> > > > > 
> > > > > On the LKML I discussed using congestion notification as a way to handle
> > > > > this situation, but deferred it to a future feature bit. I can build
> > > > > it in from the beginning though.
> > > > 
> > > > as in messages to stop/start transmission? might work.
> > > > 
> > > 
> > > Yes, say for example that a flow is sending a large number of packets
> > > and the destination socket's receive queue becomes full. The destination
> > > sends a "stop" message with the destination address. More packets are
> > > likely to continue trailing in, and they may be dropped. The source
> > > device or driver will use the destination address to throttle further
> > > attempts of sockets to transmit to that destination, and the flow will
> > > stop.
> > > 
> > > After the socket's receive queue is no longer full, it may notify the
> > > device/driver which can then send a "start" message with the destination
> > > address to any previously "stopped" sources. The sources can then
> > > reenable flows to that destination.
> > 
> > Ah so control is actually per socket. Another idea is that does not have
> > to be completely full - we can start suppressing a bit before it's full
> > to reduce packet drops.
> > 
> 
> Totally, yes that makes sense.


I don't know how we prevent blocking traffic to unrelated
destinations in this case though.  Do we have to?

> > > 
> > > The other alternative I evaluated was using a single "stop for some
> > > time" message with an exponential or fibonacci backoff with a ceiling,
> > > but the downside is that a congested queue could block the "stop"
> > > message from reaching the source and eventually the source would become
> > > unthrottled even though the destination is *trying* to throttle it. I
> > > think this is bad for some pretty abusable cases, such as creating a
> > > socket that has no receiver. A stop/start message pair doesn't have this
> > > issue.
> > > > > > 
> > > > > > > +
> > > > > > >  \drivernormative{\paragraph}{Device Operation: Buffer Space Management}{Device Types / Socket Device / Device Operation / Buffer Space Management}
> > > > > > > -VIRTIO_VSOCK_OP_RW data packets MUST only be transmitted when the peer has
> > > > > > > -sufficient free buffer space for the payload.
> > > > > > > +For stream and seqpacket flows, VIRTIO_VSOCK_OP_RW data packets MUST only be
> > > > > > > +transmitted when the peer has sufficient free buffer space for the payload.
> > > > > > >  
> > > > > > >  All packets associated with a stream flow MUST contain valid information in
> > > > > > >  \field{buf_alloc} and \field{fwd_cnt} fields.
> > > > > > >  
> > > > > > >  \devicenormative{\paragraph}{Device Operation: Buffer Space Management}{Device Types / Socket Device / Device Operation / Buffer Space Management}
> > > > > > > -VIRTIO_VSOCK_OP_RW data packets MUST only be transmitted when the peer has
> > > > > > > -sufficient free buffer space for the payload.
> > > > > > > +For stream and seqpacket flows, VIRTIO_VSOCK_OP_RW data packets MUST only be
> > > > > > > +transmitted when the peer has sufficient free buffer space for the payload.
> > > > > > >  
> > > > > > >  All packets associated with a stream flow MUST contain valid information in
> > > > > > >  \field{buf_alloc} and \field{fwd_cnt} fields.
> > > > > > > @@ -299,6 +308,78 @@ \subsubsection{Seqpacket Sockets}\label{sec:Device Types / Socket Device / Devic
> > > > > > >  #define VIRTIO_VSOCK_SEQ_EOR (1 << 1)
> > > > > > >  \end{lstlisting}
> > > > > > >  
> > > > > > > +\subsubsection{Datagram Sockets}\label{sec:Device Types / Socket Device / Device Operation / Datagram Sockets}
> > > > > > > +
> > > > > > > +\drivernormative{\paragraph}{Device Operation: Packet Fragmentation}{Device Types / Socket Device / Datagram Sockets / Fragmentation}
> > > > > > > +
> > > > > > > +Drivers MAY disassemble packets into smaller fragments. If drivers fragment a
> > > > > > > +packet, they MUST follow the fragmentation rules described in section
> > > > > > > +\ref{sec:Device Types / Socket Device / Device Operation / Datagram Sockets / Fragmentation}.
> > > > > > > +
> > > > > > > +Drivers MUST support assembly of received packet fragments according to the
> > > > > > > +fragmentation rules described in section
> > > > > > > +\ref{sec:Device Types / Socket Device / Device Operation / Datagram Sockets / Fragmentation}.
> > > > > > > +
> > > > > > > +\devicenormative{\paragraph}{Device Operation: Packet Fragmentation}{Device Types / Socket Device / Datagram Sockets / Fragmentation}
> > > > > > > +
> > > > > > > +Devices MAY disassemble packets into smaller fragments. If devices fragment a
> > > > > > > +packet, they MUST follow the fragmentation rules described in section
> > > > > > > +\ref{sec:Device Types / Socket Device / Device Operation / Datagram Sockets / Fragmentation}.
> > > > > > > +
> > > > > > > +Devices MUST support assembly of received packet fragments according to the
> > > > > > > +fragmentation rules described in section
> > > > > > > +\ref{sec:Device Types / Socket Device / Device Operation / Datagram Sockets / Fragmentation}.
> > > > > > > +
> > > > > > > +\drivernormative{\paragraph}{Device Operation: Packet Dropping}{Device Types / Socket Device / Datagram Sockets / Dropping}
> > > > > > > +
> > > > > > > +The driver MAY drop received packets with no notification to the device. This
> > > > > > > +can happen if, for example, there are insufficient resources or no socket
> > > > > > > +exists for the destination address.
> > > > > > > +
> > > > > > > +\devicenormative{\paragraph}{Device Operation: Packet Dropping}{Device Types / Socket Device / Datagram Sockets / Dropping}
> > > > > > > +
> > > > > > > +The device MAY drop received packets with no notification to the driver. This
> > > > > > > +can happen if, for example, there are insufficient resources or no socket
> > > > > > > +exists for the destination address.
> > > > > > > +
> > > > > > > +\paragraph{Datagram Fragmentation}\label{sec:Device Types / Socket Device / Device Operation / Datagram Sockets / Fragmentation}
> > > > > > > +
> > > > > > > +\field{flags} may have the following bit set:
> > > > > > > +
> > > > > > > +\begin{lstlisting}
> > > > > > > +#define VIRTIO_VSOCK_DGRAM_EOM (1 << 0)
> > > > > > > +\end{lstlisting}
> > > > > > > +
> > > > > > > +When the header \field{flags} field bit VIRTIO_VSOCK_DGRAM_EOM (bit 0) is set,
> > > > > > > +it indicates that the current payload is the end of a datagram fragment OR that
> > > > > > > +the current payload is an entire datagram packet.
> > > > > > > +
> > > > > > > +Datagram fragmentation is subject to the following rules:
> > > > > > > +
> > > > > > > +The fragments for a datagram packet MUST be added to the virtqueue in
> > > > > > > +sequential order.
> > > > > > > +
> > > > > > > +If a packet is not a fragment, then the VIRTIO_VSOCK_DGRAM_EOM bit (bit 0) of
> > > > > > > +\field{flags} MUST be set.
> > > > > > > +
> > > > > > > +If a packet is the last fragment of a fragment sequence, then the
> > > > > > > +VIRTIO_VSOCK_DGRAM_EOM bit (bit 0) of \field{flags} MUST be set.
> > > > > > > +
> > > > > > > +If a packet is any fragment except the last fragment of a fragment sequence,
> > > > > > > +then the VIRTIO_VSOCK_DGRAM_EOM bit (bit 0) of \field{flags} MUST NOT be set.
> > > > > > > +
> > > > > > > +If a driver or device has already placed a fragment of a packet on the
> > > > > > > +virtqueue, it MUST add the remaining fragments of the packet to the virtqueue
> > > > > > > +before adding any additional packets or fragments to the virtqueue.
> > > > > > > +
> > > > > > > +If fragments for a packet are only partially received after an
> > > > > > > +implementation-specific amount of time, then the destination device or driver
> > > > > > > +MAY drop the fragments.
> > > > > > 
> > > > > > and how to detect this partial situation?
> > > > > > 
> > > > > > and if not then what happens?
> > > > > 
> > > > > All packets with EOM=0 should be added into a per-flow fragment list.
> > > > > 
> > > > > Once a packet with EOM=1 is received, they can all be concatenated and
> > > > > delivered to the destination socket.
> > > > > 
> > > > > If after X time no packet with EOM=1 is received, then we have detected
> > > > > this partial situation. The "then what happens part" is that the
> > > > > fragment list can be dropped and freed. Because the peer must send the
> > > > > remaining fragments, they will also be dropped and freed until EOM=1 is
> > > > > received.
> > > > 
> > > > aha. worth mentioning.
> > > > 
> > > > also all the must/may/should really belong in conformance
> > > > sections.
> > > > 
> > > 
> > > Got it, will do.
> > > 
> > > > 
> > > > > > 
> > > > > > > +Each buffer containing a fragment MUST begin with a valid struct
> > > > > > > +virtio_vsock_hdr. \field{len} MUST equal the length of the fragment payload
> > > > > > > +only.
> > > > > > 
> > > > > > what does this mean exactly?
> > > > > > 
> > > > > 
> > > > > It means that len only accounts for the fragment and not the whole
> > > > > (fragmented) packet. The second sentence means that the virtqueue buffer
> > > > > starts with the header.
> > > > > 
> > > > > For virtio-net mergable RX buffers the header is only in the first
> > > > > buffer and the length field accounts for the entire fragmented packet
> > > > > (that spans multiple bufers), so I suspected the specification was
> > > > > needed here too.
> > > > > 
> > > > > I'm happy to omit it.
> > > > > > >  \subsubsection{Device Events}\label{sec:Device Types / Socket Device / Device Operation / Device Events}
> > > > > > >  
> > > > > > >  Certain events are communicated by the device to the driver using the event
> > > > > > > -- 
> > > > > > > 2.20.1
> > > > > > 
> > > > > > _______________________________________________
> > > > > > Virtualization mailing list
> > > > > > Virtualization@lists.linux-foundation.org
> > > > > > https://lists.linuxfoundation.org/mailman/listinfo/virtualization
> > > > 
> > > > _______________________________________________
> > > > Virtualization mailing list
> > > > Virtualization@lists.linux-foundation.org
> > > > https://lists.linuxfoundation.org/mailman/listinfo/virtualization
> > 
> > _______________________________________________
> > Virtualization mailing list
> > Virtualization@lists.linux-foundation.org
> > https://lists.linuxfoundation.org/mailman/listinfo/virtualization


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

