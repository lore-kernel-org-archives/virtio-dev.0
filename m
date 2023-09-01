Return-Path: <virtio-dev-return-13597-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5DDFCA0FE1
	for <virtio-dev@archiver.kernel.org>; Fri,  1 Sep 2023 13:31:14 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id D8BDB42D72
	for <virtio-dev@archiver.kernel.org>; Fri,  1 Sep 2023 13:31:13 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B5AA09865A6
	for <virtio-dev@archiver.kernel.org>; Fri,  1 Sep 2023 13:31:13 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 99DCC98658E; Fri,  1 Sep 2023 13:31:13 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 890D5986590
	for <virtio-dev@lists.oasis-open.org>; Fri,  1 Sep 2023 13:31:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: enIZGqXjPF6b4ef1BAy2Gw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693575068; x=1694179868;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BXyHGh3Rjg686bZVAQcRsKrfRjARZ47LdD6WNAEPvaM=;
        b=jFLczTVAXMyBNGuW/UPNmVRIe7FOEK2oESuWPd1CIuiBqxyKu5HmaFUYxTgknWl6cu
         mEwJYCwg91iVJssKg6vY8gL5/VPHPPPw6j5BhY2XfPzMvX6f2HxCZ7mQUfVOR9bmD/Zr
         P5PIp52jzgpOpqcSJOUGQtUGgvuIriGNIW+2rhG6nY/4BpDumB0q91x2/b++NZ8cG7Mr
         x5Faw2plZMgPwOWo1y8iaNxmpp+xPC4efP8vlzciF0T+zjQjCrSZFd30dOuFVHs+YrSc
         mY8A8YXa39tCOGSLJ80wyl3/mrHuqlkvbe2bi6Mr6m4ECFVTvK3O/bbqx8Z/PZf00qZF
         COyA==
X-Gm-Message-State: AOJu0YzvW7R+IsEJy0N/0KecG2CODOR20sRYX8Z+VEHqRrhZbAvWPV6F
	SZe9QmY1pMtY4ILar9meEAKgj5l5+knuXcxIiLMxzbHEy5kkIePnPToLyaJ2O9MtN9lRJZBVk9l
	f+a/6h/YJG0tCGWF5HK9j2qC66neN
X-Received: by 2002:aa7:c384:0:b0:523:ae0a:a446 with SMTP id k4-20020aa7c384000000b00523ae0aa446mr2334350edq.24.1693575068743;
        Fri, 01 Sep 2023 06:31:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLY0tuJD1WJszpQXunFN8M70befbfcgwb4jxN7POX5O8sDZD2N9Q1Iz55vPWyrafJeemXUbg==
X-Received: by 2002:aa7:c384:0:b0:523:ae0a:a446 with SMTP id k4-20020aa7c384000000b00523ae0aa446mr2334319edq.24.1693575068386;
        Fri, 01 Sep 2023 06:31:08 -0700 (PDT)
Date: Fri, 1 Sep 2023 09:31:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Bobby Eshleman <bobby.eshleman@bytedance.com>,
	virtio-dev@lists.oasis-open.org, cong.wang@bytedance.com,
	jiang.wang@bytedance.com, cohuck@redhat.com,
	virtualization@lists.linux-foundation.org, stefanha@redhat.com,
	virtio-comment@lists.oasis-open.org, arseny.krasnov@kaspersky.com
Message-ID: <20230901091938-mutt-send-email-mst@kernel.org>
References: <20230829212945.3420727-1-bobby.eshleman@bytedance.com>
 <20230829181549-mutt-send-email-mst@kernel.org>
 <ZO6Ql9iWi6a8vDyU@bullseye>
MIME-Version: 1.0
In-Reply-To: <ZO6Ql9iWi6a8vDyU@bullseye>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH] virtio-vsock: add VIRTIO_VSOCK_F_DGRAM feature bit

On Wed, Aug 30, 2023 at 12:43:03AM +0000, Bobby Eshleman wrote:
> On Tue, Aug 29, 2023 at 06:21:35PM -0400, Michael S. Tsirkin wrote:
> > On Tue, Aug 29, 2023 at 09:29:45PM +0000, Bobby Eshleman wrote:
> > > This adds support for datagrams to the virtio-vsock device.
> > > 
> > > virtio-vsock already supports stream and seqpacket types. The existing
> > > message types and header fields are extended to support datagrams.
> > > Semantic differences between the flow types are stated, as well as any
> > > additional requirements for devices and drivers implementing this
> > > feature.
> > > 
> > > Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
> > > ---
> > >  device-types/vsock/description.tex | 95 +++++++++++++++++++++++++++---
> > >  1 file changed, 88 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/device-types/vsock/description.tex b/device-types/vsock/description.tex
> > > index 7d91d159872f..638dca8e5da1 100644
> > > --- a/device-types/vsock/description.tex
> > > +++ b/device-types/vsock/description.tex
> > > @@ -20,6 +20,7 @@ \subsection{Feature bits}\label{sec:Device Types / Socket Device / Feature bits}
> > >  \item[VIRTIO_VSOCK_F_STREAM (0)] stream socket type is supported.
> > >  \item[VIRTIO_VSOCK_F_SEQPACKET (1)] seqpacket socket type is supported.
> > >  \item[VIRTIO_VSOCK_F_NO_IMPLIED_STREAM (2)] stream socket type is not implied.
> > > +\item[VIRTIO_VSOCK_F_DGRAM (3)] datagram socket type is supported.
> > >  \end{description}
> > >  
> > >  \drivernormative{\subsubsection}{Feature bits}{Device Types / Socket Device / Feature bits}
> > > @@ -167,17 +168,22 @@ \subsubsection{Addressing}\label{sec:Device Types / Socket Device / Device Opera
> > >  consists of a (cid, port number) tuple. The header fields used for this are
> > >  \field{src_cid}, \field{src_port}, \field{dst_cid}, and \field{dst_port}.
> > >  
> > > -Currently stream and seqpacket sockets are supported. \field{type} is 1 (VIRTIO_VSOCK_TYPE_STREAM)
> > > -for stream socket types, and 2 (VIRTIO_VSOCK_TYPE_SEQPACKET) for seqpacket socket types.
> > > +
> > > +Currently stream, seqpacket, and datagram sockets are supported. \field{type} is
> > > +1 (VIRTIO_VSOCK_TYPE_STREAM) for stream socket types, 2 (VIRTIO_VSOCK_TYPE_SEQPACKET) for
> > > +seqpacket socket types, and 3 (VIRTIO_VSOCK_TYPE_DGRAM) for datagram socket types.
> > >  
> > >  \begin{lstlisting}
> > >  #define VIRTIO_VSOCK_TYPE_STREAM    1
> > >  #define VIRTIO_VSOCK_TYPE_SEQPACKET 2
> > > +#define VIRTIO_VSOCK_TYPE_DGRAM     3
> > >  \end{lstlisting}
> > >  
> > >  Stream sockets provide in-order, guaranteed, connection-oriented delivery
> > >  without message boundaries. Seqpacket sockets provide in-order, guaranteed,
> > > -connection-oriented delivery with message and record boundaries.
> > > +connection-oriented delivery with message and record boundaries. Datagram
> > > +sockets provide connection-less, best-effort delivery of messages, with no
> > > +order or reliability guarantees.
> > >  
> > >  \subsubsection{Buffer Space Management}\label{sec:Device Types / Socket Device / Device Operation / Buffer Space Management}
> > >  \field{buf_alloc} and \field{fwd_cnt} are used for buffer space management of
> > > @@ -203,16 +209,19 @@ \subsubsection{Buffer Space Management}\label{sec:Device Types / Socket Device /
> > >  previously receiving a VIRTIO_VSOCK_OP_CREDIT_REQUEST packet. This allows
> > >  communicating updates any time a change in buffer space occurs.
> > >  
> > > +\field{buf_alloc} and \field{fwd_cnt} are reserved for future use by datagram
> > > +sockets. These fields are not used for datagram buffer space management.
> > 
> > no limits on datagram size?
> > 
> 
> In the Linux proof-of-concept, it is 64KB. I can add that here too.

or device driven maybe ...

> > also with no flow control at all there's a performance problem:
> > imagine queue gets full. now buffers begin to be dropped.
> > problem is, dropping is faster than delivering to application.
> > so now application sees its packets consumed super quickly
> > and starts sending even faster.
> > not good for performance.
> > 
> > yes datagram expects some way to drop packets but just disabling flow
> > control completely is not the right thing to do I think.
> > 
> 
> On the LKML I discussed using congestion notification as a way to handle
> this situation, but deferred it to a future feature bit. I can build
> it in from the beginning though.

as in messages to stop/start transmission? might work.

> > 
> > > +
> > >  \drivernormative{\paragraph}{Device Operation: Buffer Space Management}{Device Types / Socket Device / Device Operation / Buffer Space Management}
> > > -VIRTIO_VSOCK_OP_RW data packets MUST only be transmitted when the peer has
> > > -sufficient free buffer space for the payload.
> > > +For stream and seqpacket flows, VIRTIO_VSOCK_OP_RW data packets MUST only be
> > > +transmitted when the peer has sufficient free buffer space for the payload.
> > >  
> > >  All packets associated with a stream flow MUST contain valid information in
> > >  \field{buf_alloc} and \field{fwd_cnt} fields.
> > >  
> > >  \devicenormative{\paragraph}{Device Operation: Buffer Space Management}{Device Types / Socket Device / Device Operation / Buffer Space Management}
> > > -VIRTIO_VSOCK_OP_RW data packets MUST only be transmitted when the peer has
> > > -sufficient free buffer space for the payload.
> > > +For stream and seqpacket flows, VIRTIO_VSOCK_OP_RW data packets MUST only be
> > > +transmitted when the peer has sufficient free buffer space for the payload.
> > >  
> > >  All packets associated with a stream flow MUST contain valid information in
> > >  \field{buf_alloc} and \field{fwd_cnt} fields.
> > > @@ -299,6 +308,78 @@ \subsubsection{Seqpacket Sockets}\label{sec:Device Types / Socket Device / Devic
> > >  #define VIRTIO_VSOCK_SEQ_EOR (1 << 1)
> > >  \end{lstlisting}
> > >  
> > > +\subsubsection{Datagram Sockets}\label{sec:Device Types / Socket Device / Device Operation / Datagram Sockets}
> > > +
> > > +\drivernormative{\paragraph}{Device Operation: Packet Fragmentation}{Device Types / Socket Device / Datagram Sockets / Fragmentation}
> > > +
> > > +Drivers MAY disassemble packets into smaller fragments. If drivers fragment a
> > > +packet, they MUST follow the fragmentation rules described in section
> > > +\ref{sec:Device Types / Socket Device / Device Operation / Datagram Sockets / Fragmentation}.
> > > +
> > > +Drivers MUST support assembly of received packet fragments according to the
> > > +fragmentation rules described in section
> > > +\ref{sec:Device Types / Socket Device / Device Operation / Datagram Sockets / Fragmentation}.
> > > +
> > > +\devicenormative{\paragraph}{Device Operation: Packet Fragmentation}{Device Types / Socket Device / Datagram Sockets / Fragmentation}
> > > +
> > > +Devices MAY disassemble packets into smaller fragments. If devices fragment a
> > > +packet, they MUST follow the fragmentation rules described in section
> > > +\ref{sec:Device Types / Socket Device / Device Operation / Datagram Sockets / Fragmentation}.
> > > +
> > > +Devices MUST support assembly of received packet fragments according to the
> > > +fragmentation rules described in section
> > > +\ref{sec:Device Types / Socket Device / Device Operation / Datagram Sockets / Fragmentation}.
> > > +
> > > +\drivernormative{\paragraph}{Device Operation: Packet Dropping}{Device Types / Socket Device / Datagram Sockets / Dropping}
> > > +
> > > +The driver MAY drop received packets with no notification to the device. This
> > > +can happen if, for example, there are insufficient resources or no socket
> > > +exists for the destination address.
> > > +
> > > +\devicenormative{\paragraph}{Device Operation: Packet Dropping}{Device Types / Socket Device / Datagram Sockets / Dropping}
> > > +
> > > +The device MAY drop received packets with no notification to the driver. This
> > > +can happen if, for example, there are insufficient resources or no socket
> > > +exists for the destination address.
> > > +
> > > +\paragraph{Datagram Fragmentation}\label{sec:Device Types / Socket Device / Device Operation / Datagram Sockets / Fragmentation}
> > > +
> > > +\field{flags} may have the following bit set:
> > > +
> > > +\begin{lstlisting}
> > > +#define VIRTIO_VSOCK_DGRAM_EOM (1 << 0)
> > > +\end{lstlisting}
> > > +
> > > +When the header \field{flags} field bit VIRTIO_VSOCK_DGRAM_EOM (bit 0) is set,
> > > +it indicates that the current payload is the end of a datagram fragment OR that
> > > +the current payload is an entire datagram packet.
> > > +
> > > +Datagram fragmentation is subject to the following rules:
> > > +
> > > +The fragments for a datagram packet MUST be added to the virtqueue in
> > > +sequential order.
> > > +
> > > +If a packet is not a fragment, then the VIRTIO_VSOCK_DGRAM_EOM bit (bit 0) of
> > > +\field{flags} MUST be set.
> > > +
> > > +If a packet is the last fragment of a fragment sequence, then the
> > > +VIRTIO_VSOCK_DGRAM_EOM bit (bit 0) of \field{flags} MUST be set.
> > > +
> > > +If a packet is any fragment except the last fragment of a fragment sequence,
> > > +then the VIRTIO_VSOCK_DGRAM_EOM bit (bit 0) of \field{flags} MUST NOT be set.
> > > +
> > > +If a driver or device has already placed a fragment of a packet on the
> > > +virtqueue, it MUST add the remaining fragments of the packet to the virtqueue
> > > +before adding any additional packets or fragments to the virtqueue.
> > > +
> > > +If fragments for a packet are only partially received after an
> > > +implementation-specific amount of time, then the destination device or driver
> > > +MAY drop the fragments.
> > 
> > and how to detect this partial situation?
> > 
> > and if not then what happens?
> 
> All packets with EOM=0 should be added into a per-flow fragment list.
> 
> Once a packet with EOM=1 is received, they can all be concatenated and
> delivered to the destination socket.
> 
> If after X time no packet with EOM=1 is received, then we have detected
> this partial situation. The "then what happens part" is that the
> fragment list can be dropped and freed. Because the peer must send the
> remaining fragments, they will also be dropped and freed until EOM=1 is
> received.

aha. worth mentioning.

also all the must/may/should really belong in conformance
sections.


> > 
> > > +Each buffer containing a fragment MUST begin with a valid struct
> > > +virtio_vsock_hdr. \field{len} MUST equal the length of the fragment payload
> > > +only.
> > 
> > what does this mean exactly?
> > 
> 
> It means that len only accounts for the fragment and not the whole
> (fragmented) packet. The second sentence means that the virtqueue buffer
> starts with the header.
> 
> For virtio-net mergable RX buffers the header is only in the first
> buffer and the length field accounts for the entire fragmented packet
> (that spans multiple bufers), so I suspected the specification was
> needed here too.
> 
> I'm happy to omit it.
> > >  \subsubsection{Device Events}\label{sec:Device Types / Socket Device / Device Operation / Device Events}
> > >  
> > >  Certain events are communicated by the device to the driver using the event
> > > -- 
> > > 2.20.1
> > 
> > _______________________________________________
> > Virtualization mailing list
> > Virtualization@lists.linux-foundation.org
> > https://lists.linuxfoundation.org/mailman/listinfo/virtualization


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

