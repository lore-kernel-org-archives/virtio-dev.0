Return-Path: <virtio-dev-return-13603-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EC79CA0FFC
	for <virtio-dev@archiver.kernel.org>; Sat,  2 Sep 2023 08:35:38 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 90670C6253
	for <virtio-dev@archiver.kernel.org>; Sat,  2 Sep 2023 08:35:37 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 834439865C8
	for <virtio-dev@archiver.kernel.org>; Sat,  2 Sep 2023 08:35:37 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 74D82983E52; Sat,  2 Sep 2023 08:35:37 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 64800986595
	for <virtio-dev@lists.oasis-open.org>; Sat,  2 Sep 2023 08:35:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: QKibJICEPJy7H-nJ8gdkfQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693643730; x=1694248530;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tx/R4Ypx48aYWYb22H8fWrmat8EAEjJNpuQqM8wuIOk=;
        b=VBFnbLEFot3BvrC8jkUM58PYOVKsD15Wxn3fAWUGkXDgUnA/776delGXMDSVVNRMfI
         nQVDTia5XLU2Hya90HJ6SsO8SNhGBlfKjkBpvG8MJCqejQtfRAzmkDqjs01g9gzfmzNy
         IWUnjbVRE/MUlawO21I1m/Vv7NXl4kvTVt/6CoZdaRIZVM8IvGCIYyvAROFpV/zDWxfy
         c5epcHCACf55gCLRYqADpculJu74eZ4ywEUlD23lr8rWzT3exACMOTBAszHqpcS7wj/Z
         NdsxEE4Y3Mey3LY7Sf1gxKOZSvXc7VC+dCon4eUmF7EiJ3YJm7POAFgfWmtKt3MQ4pA7
         8dig==
X-Gm-Message-State: AOJu0YzB7eZwVRBpeN0O12iNZCRnEznA/R7BD7b03kvJxdByPM0asXn1
	a2NRi2rtQlEytXZPcAyls+WE35hnjYvHlDQ8Z/kxdDcKmJXr90GcdjjBqp50PhhglpXD7ct0/Ey
	i1PDcDppwtJ/iCvoKwbfZMwTzJT3A
X-Received: by 2002:a2e:9a8e:0:b0:2bc:b0ae:a9e5 with SMTP id p14-20020a2e9a8e000000b002bcb0aea9e5mr3448380lji.42.1693643730054;
        Sat, 02 Sep 2023 01:35:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3zcbVZ6d3LCJHvU3yrSQgputZFAf847TTrPCn81lmpiszvcgxiC7s0VltNhGdY9owoKzF9w==
X-Received: by 2002:a2e:9a8e:0:b0:2bc:b0ae:a9e5 with SMTP id p14-20020a2e9a8e000000b002bcb0aea9e5mr3448365lji.42.1693643729668;
        Sat, 02 Sep 2023 01:35:29 -0700 (PDT)
Date: Sat, 2 Sep 2023 04:35:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	Bobby Eshleman <bobby.eshleman@bytedance.com>,
	virtio-dev@lists.oasis-open.org, cong.wang@bytedance.com,
	jiang.wang@bytedance.com, cohuck@redhat.com,
	virtualization@lists.linux-foundation.org, stefanha@redhat.com,
	virtio-comment@lists.oasis-open.org, arseny.krasnov@kaspersky.com
Message-ID: <20230902043334-mutt-send-email-mst@kernel.org>
References: <20230829212945.3420727-1-bobby.eshleman@bytedance.com>
 <h6wtvcglyw55enk6shdogbfnw3m6zbmb4lv65uhznpwzqjw5sc@vc7clkjbxfep>
 <ZPLAip/TWqvWZ0hv@bullseye>
MIME-Version: 1.0
In-Reply-To: <ZPLAip/TWqvWZ0hv@bullseye>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH] virtio-vsock: add VIRTIO_VSOCK_F_DGRAM feature bit

On Sat, Sep 02, 2023 at 04:56:42AM +0000, Bobby Eshleman wrote:
> On Fri, Sep 01, 2023 at 02:45:14PM +0200, Stefano Garzarella wrote:
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
> > > device-types/vsock/description.tex | 95 +++++++++++++++++++++++++++---
> > > 1 file changed, 88 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/device-types/vsock/description.tex b/device-types/vsock/description.tex
> > > index 7d91d159872f..638dca8e5da1 100644
> > > --- a/device-types/vsock/description.tex
> > > +++ b/device-types/vsock/description.tex
> > > @@ -20,6 +20,7 @@ \subsection{Feature bits}\label{sec:Device Types / Socket Device / Feature bits}
> > > \item[VIRTIO_VSOCK_F_STREAM (0)] stream socket type is supported.
> > > \item[VIRTIO_VSOCK_F_SEQPACKET (1)] seqpacket socket type is supported.
> > > \item[VIRTIO_VSOCK_F_NO_IMPLIED_STREAM (2)] stream socket type is not implied.
> > > +\item[VIRTIO_VSOCK_F_DGRAM (3)] datagram socket type is supported.
> > > \end{description}
> > > 
> > > \drivernormative{\subsubsection}{Feature bits}{Device Types / Socket Device / Feature bits}
> > > @@ -167,17 +168,22 @@ \subsubsection{Addressing}\label{sec:Device Types / Socket Device / Device Opera
> > > consists of a (cid, port number) tuple. The header fields used for this are
> > > \field{src_cid}, \field{src_port}, \field{dst_cid}, and \field{dst_port}.
> > > 
> > > -Currently stream and seqpacket sockets are supported. \field{type} is 1 (VIRTIO_VSOCK_TYPE_STREAM)
> > > -for stream socket types, and 2 (VIRTIO_VSOCK_TYPE_SEQPACKET) for seqpacket socket types.
> > > +
> > > +Currently stream, seqpacket, and datagram sockets are supported. \field{type} is
> > > +1 (VIRTIO_VSOCK_TYPE_STREAM) for stream socket types, 2 (VIRTIO_VSOCK_TYPE_SEQPACKET) for
> > > +seqpacket socket types, and 3 (VIRTIO_VSOCK_TYPE_DGRAM) for datagram socket types.
> > > 
> > > \begin{lstlisting}
> > > #define VIRTIO_VSOCK_TYPE_STREAM    1
> > > #define VIRTIO_VSOCK_TYPE_SEQPACKET 2
> > > +#define VIRTIO_VSOCK_TYPE_DGRAM     3
> > > \end{lstlisting}
> > > 
> > > Stream sockets provide in-order, guaranteed, connection-oriented delivery
> > > without message boundaries. Seqpacket sockets provide in-order, guaranteed,
> > > -connection-oriented delivery with message and record boundaries.
> > > +connection-oriented delivery with message and record boundaries. Datagram
> > > +sockets provide connection-less, best-effort delivery of messages, with no
> > > +order or reliability guarantees.
> > > 
> > > \subsubsection{Buffer Space Management}\label{sec:Device Types / Socket Device / Device Operation / Buffer Space Management}
> > > \field{buf_alloc} and \field{fwd_cnt} are used for buffer space management of
> > > @@ -203,16 +209,19 @@ \subsubsection{Buffer Space Management}\label{sec:Device Types / Socket Device /
> > > previously receiving a VIRTIO_VSOCK_OP_CREDIT_REQUEST packet. This allows
> > > communicating updates any time a change in buffer space occurs.
> > > 
> > > +\field{buf_alloc} and \field{fwd_cnt} are reserved for future use by datagram
> > > +sockets. These fields are not used for datagram buffer space management.
> > > +
> > > \drivernormative{\paragraph}{Device Operation: Buffer Space Management}{Device Types / Socket Device / Device Operation / Buffer Space Management}
> > > -VIRTIO_VSOCK_OP_RW data packets MUST only be transmitted when the peer has
> > > -sufficient free buffer space for the payload.
> > > +For stream and seqpacket flows, VIRTIO_VSOCK_OP_RW data packets MUST only be
> > > +transmitted when the peer has sufficient free buffer space for the payload.
> > > 
> > > All packets associated with a stream flow MUST contain valid information in
> > > \field{buf_alloc} and \field{fwd_cnt} fields.
> > > 
> > > \devicenormative{\paragraph}{Device Operation: Buffer Space
> > > Management}{Device Types / Socket Device / Device Operation / Buffer
> > > Space Management}
> > > -VIRTIO_VSOCK_OP_RW data packets MUST only be transmitted when the peer has
> > > -sufficient free buffer space for the payload.
> > > +For stream and seqpacket flows, VIRTIO_VSOCK_OP_RW data packets MUST only be
> > > +transmitted when the peer has sufficient free buffer space for the payload.
> > > 
> > > All packets associated with a stream flow MUST contain valid information in
> > > \field{buf_alloc} and \field{fwd_cnt} fields.
> > > @@ -299,6 +308,78 @@ \subsubsection{Seqpacket Sockets}\label{sec:Device Types / Socket Device / Devic
> > > #define VIRTIO_VSOCK_SEQ_EOR (1 << 1)
> > > \end{lstlisting}
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
> > > +\ref{sec:Device Types / Socket Device / Device Operation / Datagram
> > > Sockets / Fragmentation}.
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
> > 
> > Should we provide some notification if the socket does not exist at the
> > destination?
> > 
> 
> Yes, I think so. I believe a start/stop congestion notification scheme
> actually manages this issue well.
> 
> For example, the source begins sending packets to a destination.
> 
> The destination finds that there exists no socket for that destination
> address. The destination sends a "stop" notification to the source that
> contains the address in question. Meanwhile, packets are still coming in
> but they are being dropped.
> 
> The source receives the "stop" notification with the address and adds it
> to the "stopped destinations" list. Any new packet destination address
> will be compared to that list. Any matches will be dropped before
> sending (and ideally, before wasting time allocating the packet).
> 
> Only when a socket is bound to an address that matches a "stopped"
> address does the destination send a "start" notification to any source
> it has previusly sent a "stop" notification to.
> 
> Once "start" is received, flow may resume as normal.

Again, dropping as control flow tactic has a bunch of problems.
Blocking senders sounds more reasonable.


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
> > > +it indicates that the current payload is the end of a datagram fragment
> > > OR that
> > > +the current payload is an entire datagram packet.
> > 
> > In the destination, if we discard some fragments, then could we
> > reconstruct a different datagram from the one sent?
> > 
> > Is that anything acceptable?
> > 
> 
> Dropping fragments should be explicitly disallowed. The sender is
> explicitly disallowed from NOT placing fragments on the virtqueue, but I
> see that I am missing the piece that states that they may not be dropped
> on the receive side.
> 
> I think it is worth mentioning that implicit in this spec is that
> socket-to-socket dgram communication is unreliable, but device-to-driver
> (and vice versa) is still reliable. That is, we can rely at least on the
> virtqueues to work... and if they fail then the device/driver can simply
> requeue (think send_pkt_queue in Linux)... so there is some reliability
> at the lowest layer.

Well you have this weird timeout thing for some reason.

> > Thanks,
> > Stefano
> > 
> 
> Thanks!
> Bobby


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

