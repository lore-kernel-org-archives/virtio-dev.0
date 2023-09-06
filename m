Return-Path: <virtio-dev-return-13643-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59392EB8FD6
	for <virtio-dev@archiver.kernel.org>; Wed,  6 Sep 2023 14:28:23 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 8867C613DD
	for <virtio-dev@archiver.kernel.org>; Wed,  6 Sep 2023 14:28:22 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7AFF59865FD
	for <virtio-dev@archiver.kernel.org>; Wed,  6 Sep 2023 14:28:22 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 6BB069865E1; Wed,  6 Sep 2023 14:28:22 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5ADAB9865E9
	for <virtio-dev@lists.oasis-open.org>; Wed,  6 Sep 2023 14:28:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: Ub1p7s1tPtqtY3ILvZGyUQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694010497; x=1694615297;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aHdVspGi7s+wvB5Iso+GOeNjG9LwQeHcnA9Ys8DT76I=;
        b=hhOSDAK2EcSwpHM5OM8X1zjQ2rlGyjtMOkRmsfqNGBVH40jtnrNb4Pz9/isBZcczwg
         TyOrwTfecx8MWNmgnRHojqWqpKDpnClb3WPjNWP3A8SxVOlGthfuGUpyzhNKc0HhHhPN
         Wo8Ih2wIT7/prVVQeS2i+GaIN5WS82G+q15LOU74SZ6f2oRl4eOKAHjNOaSpaBkoPRWH
         tPMzK0kDE8ikTCPhqg4Uj4kvHoC5yyT8PY9ECoiCEBZYE8Y8yYAdseLGPUfHzW0K9/gM
         Mh6hUOWO0c8pWjt3eZB00p7UDA+xnuivoMV+qqz0HO4/BqYbv97zD+zVeLpT/Bx4xuAB
         /+2g==
X-Gm-Message-State: AOJu0YyhFz96wprzbQ3tOvvSNsOzB0O74Avm5ho47OGc7Pgx3GSHkk+/
	kLYtnplrU6EI8e4wg8jOiqzCHNL3bYWkpoV2tPP6rdljp5idEBjLqrhfJ+H77IDLXKny3+B9wsF
	x0Q5UIdNJt/AL8si6U8V9EdEU7VCT
X-Received: by 2002:a0c:e493:0:b0:64a:7da3:a700 with SMTP id n19-20020a0ce493000000b0064a7da3a700mr15502329qvl.20.1694010497310;
        Wed, 06 Sep 2023 07:28:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGr50o8YS0XxnQ/09J921eumLo6lvaepN/VP09UlyPciN8m0FUlbx2hbhLHf4VnzsY19ma2Xw==
X-Received: by 2002:a0c:e493:0:b0:64a:7da3:a700 with SMTP id n19-20020a0ce493000000b0064a7da3a700mr15502294qvl.20.1694010496717;
        Wed, 06 Sep 2023 07:28:16 -0700 (PDT)
Date: Wed, 6 Sep 2023 16:28:12 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Bobby Eshleman <bobbyeshleman@gmail.com>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, virtio-dev@lists.oasis-open.org, cong.wang@bytedance.com, 
	jiang.wang@bytedance.com, cohuck@redhat.com, virtualization@lists.linux-foundation.org, 
	stefanha@redhat.com, virtio-comment@lists.oasis-open.org, 
	arseny.krasnov@kaspersky.com
Message-ID: <6hwqps3x554jcanr2i6kv7u4jmz3lfwcoesuyzxbr3sh3xsnd7@2embgkcj264f>
References: <20230829212945.3420727-1-bobby.eshleman@bytedance.com>
 <h6wtvcglyw55enk6shdogbfnw3m6zbmb4lv65uhznpwzqjw5sc@vc7clkjbxfep>
 <ZPLAip/TWqvWZ0hv@bullseye>
 <20230902043334-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230902043334-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH] virtio-vsock: add VIRTIO_VSOCK_F_DGRAM feature bit

On Sat, Sep 02, 2023 at 04:35:25AM -0400, Michael S. Tsirkin wrote:
>On Sat, Sep 02, 2023 at 04:56:42AM +0000, Bobby Eshleman wrote:
>> On Fri, Sep 01, 2023 at 02:45:14PM +0200, Stefano Garzarella wrote:
>> > On Tue, Aug 29, 2023 at 09:29:45PM +0000, Bobby Eshleman wrote:
>> > > This adds support for datagrams to the virtio-vsock device.
>> > >
>> > > virtio-vsock already supports stream and seqpacket types. The existing
>> > > message types and header fields are extended to support datagrams.
>> > > Semantic differences between the flow types are stated, as well as any
>> > > additional requirements for devices and drivers implementing this
>> > > feature.
>> > >
>> > > Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
>> > > ---
>> > > device-types/vsock/description.tex | 95 +++++++++++++++++++++++++++---
>> > > 1 file changed, 88 insertions(+), 7 deletions(-)
>> > >
>> > > diff --git a/device-types/vsock/description.tex b/device-types/vsock/description.tex
>> > > index 7d91d159872f..638dca8e5da1 100644
>> > > --- a/device-types/vsock/description.tex
>> > > +++ b/device-types/vsock/description.tex
>> > > @@ -20,6 +20,7 @@ \subsection{Feature bits}\label{sec:Device Types / Socket Device / Feature bits}
>> > > \item[VIRTIO_VSOCK_F_STREAM (0)] stream socket type is supported.
>> > > \item[VIRTIO_VSOCK_F_SEQPACKET (1)] seqpacket socket type is supported.
>> > > \item[VIRTIO_VSOCK_F_NO_IMPLIED_STREAM (2)] stream socket type is not implied.
>> > > +\item[VIRTIO_VSOCK_F_DGRAM (3)] datagram socket type is supported.
>> > > \end{description}
>> > >
>> > > \drivernormative{\subsubsection}{Feature bits}{Device Types / Socket Device / Feature bits}
>> > > @@ -167,17 +168,22 @@ \subsubsection{Addressing}\label{sec:Device Types / Socket Device / Device Opera
>> > > consists of a (cid, port number) tuple. The header fields used for this are
>> > > \field{src_cid}, \field{src_port}, \field{dst_cid}, and \field{dst_port}.
>> > >
>> > > -Currently stream and seqpacket sockets are supported. \field{type} is 1 (VIRTIO_VSOCK_TYPE_STREAM)
>> > > -for stream socket types, and 2 (VIRTIO_VSOCK_TYPE_SEQPACKET) for seqpacket socket types.
>> > > +
>> > > +Currently stream, seqpacket, and datagram sockets are supported. \field{type} is
>> > > +1 (VIRTIO_VSOCK_TYPE_STREAM) for stream socket types, 2 (VIRTIO_VSOCK_TYPE_SEQPACKET) for
>> > > +seqpacket socket types, and 3 (VIRTIO_VSOCK_TYPE_DGRAM) for datagram socket types.
>> > >
>> > > \begin{lstlisting}
>> > > #define VIRTIO_VSOCK_TYPE_STREAM    1
>> > > #define VIRTIO_VSOCK_TYPE_SEQPACKET 2
>> > > +#define VIRTIO_VSOCK_TYPE_DGRAM     3
>> > > \end{lstlisting}
>> > >
>> > > Stream sockets provide in-order, guaranteed, connection-oriented delivery
>> > > without message boundaries. Seqpacket sockets provide in-order, guaranteed,
>> > > -connection-oriented delivery with message and record boundaries.
>> > > +connection-oriented delivery with message and record boundaries. Datagram
>> > > +sockets provide connection-less, best-effort delivery of messages, with no
>> > > +order or reliability guarantees.
>> > >
>> > > \subsubsection{Buffer Space Management}\label{sec:Device Types / Socket Device / Device Operation / Buffer Space Management}
>> > > \field{buf_alloc} and \field{fwd_cnt} are used for buffer space management of
>> > > @@ -203,16 +209,19 @@ \subsubsection{Buffer Space Management}\label{sec:Device Types / Socket Device /
>> > > previously receiving a VIRTIO_VSOCK_OP_CREDIT_REQUEST packet. This allows
>> > > communicating updates any time a change in buffer space occurs.
>> > >
>> > > +\field{buf_alloc} and \field{fwd_cnt} are reserved for future use by datagram
>> > > +sockets. These fields are not used for datagram buffer space management.
>> > > +
>> > > \drivernormative{\paragraph}{Device Operation: Buffer Space Management}{Device Types / Socket Device / Device Operation / Buffer Space Management}
>> > > -VIRTIO_VSOCK_OP_RW data packets MUST only be transmitted when the peer has
>> > > -sufficient free buffer space for the payload.
>> > > +For stream and seqpacket flows, VIRTIO_VSOCK_OP_RW data packets MUST only be
>> > > +transmitted when the peer has sufficient free buffer space for the payload.
>> > >
>> > > All packets associated with a stream flow MUST contain valid information in
>> > > \field{buf_alloc} and \field{fwd_cnt} fields.
>> > >
>> > > \devicenormative{\paragraph}{Device Operation: Buffer Space
>> > > Management}{Device Types / Socket Device / Device Operation / Buffer
>> > > Space Management}
>> > > -VIRTIO_VSOCK_OP_RW data packets MUST only be transmitted when the peer has
>> > > -sufficient free buffer space for the payload.
>> > > +For stream and seqpacket flows, VIRTIO_VSOCK_OP_RW data packets MUST only be
>> > > +transmitted when the peer has sufficient free buffer space for the payload.
>> > >
>> > > All packets associated with a stream flow MUST contain valid information in
>> > > \field{buf_alloc} and \field{fwd_cnt} fields.
>> > > @@ -299,6 +308,78 @@ \subsubsection{Seqpacket Sockets}\label{sec:Device Types / Socket Device / Devic
>> > > #define VIRTIO_VSOCK_SEQ_EOR (1 << 1)
>> > > \end{lstlisting}
>> > >
>> > > +\subsubsection{Datagram Sockets}\label{sec:Device Types / Socket Device / Device Operation / Datagram Sockets}
>> > > +
>> > > +\drivernormative{\paragraph}{Device Operation: Packet Fragmentation}{Device Types / Socket Device / Datagram Sockets / Fragmentation}
>> > > +
>> > > +Drivers MAY disassemble packets into smaller fragments. If drivers fragment a
>> > > +packet, they MUST follow the fragmentation rules described in section
>> > > +\ref{sec:Device Types / Socket Device / Device Operation / Datagram Sockets / Fragmentation}.
>> > > +
>> > > +Drivers MUST support assembly of received packet fragments according to the
>> > > +fragmentation rules described in section
>> > > +\ref{sec:Device Types / Socket Device / Device Operation / Datagram
>> > > Sockets / Fragmentation}.
>> > > +
>> > > +\devicenormative{\paragraph}{Device Operation: Packet Fragmentation}{Device Types / Socket Device / Datagram Sockets / Fragmentation}
>> > > +
>> > > +Devices MAY disassemble packets into smaller fragments. If devices fragment a
>> > > +packet, they MUST follow the fragmentation rules described in section
>> > > +\ref{sec:Device Types / Socket Device / Device Operation / Datagram Sockets / Fragmentation}.
>> > > +
>> > > +Devices MUST support assembly of received packet fragments according to the
>> > > +fragmentation rules described in section
>> > > +\ref{sec:Device Types / Socket Device / Device Operation / Datagram Sockets / Fragmentation}.
>> > > +
>> > > +\drivernormative{\paragraph}{Device Operation: Packet Dropping}{Device Types / Socket Device / Datagram Sockets / Dropping}
>> > > +
>> > > +The driver MAY drop received packets with no notification to the device. This
>> > > +can happen if, for example, there are insufficient resources or no socket
>> > > +exists for the destination address.
>> > > +
>> > > +\devicenormative{\paragraph}{Device Operation: Packet Dropping}{Device Types / Socket Device / Datagram Sockets / Dropping}
>> > > +
>> > > +The device MAY drop received packets with no notification to the driver. This
>> > > +can happen if, for example, there are insufficient resources or no socket
>> > > +exists for the destination address.
>> >
>> > Should we provide some notification if the socket does not exist at the
>> > destination?
>> >
>>
>> Yes, I think so. I believe a start/stop congestion notification scheme
>> actually manages this issue well.
>>
>> For example, the source begins sending packets to a destination.
>>
>> The destination finds that there exists no socket for that destination
>> address. The destination sends a "stop" notification to the source that
>> contains the address in question. Meanwhile, packets are still coming in
>> but they are being dropped.
>>
>> The source receives the "stop" notification with the address and adds it
>> to the "stopped destinations" list. Any new packet destination address
>> will be compared to that list. Any matches will be dropped before
>> sending (and ideally, before wasting time allocating the packet).
>>
>> Only when a socket is bound to an address that matches a "stopped"
>> address does the destination send a "start" notification to any source
>> it has previusly sent a "stop" notification to.

mmm, keeping the state forever could facilitate a DoS, perhaps we
should provide a timeout after which to try again

>>
>> Once "start" is received, flow may resume as normal.
>
>Again, dropping as control flow tactic has a bunch of problems.
>Blocking senders sounds more reasonable.

Yep, I think so.

>
>
>> > > +
>> > > +\paragraph{Datagram Fragmentation}\label{sec:Device Types / Socket Device / Device Operation / Datagram Sockets / Fragmentation}
>> > > +
>> > > +\field{flags} may have the following bit set:
>> > > +
>> > > +\begin{lstlisting}
>> > > +#define VIRTIO_VSOCK_DGRAM_EOM (1 << 0)
>> > > +\end{lstlisting}
>> > > +
>> > > +When the header \field{flags} field bit VIRTIO_VSOCK_DGRAM_EOM (bit 0) is set,
>> > > +it indicates that the current payload is the end of a datagram fragment
>> > > OR that
>> > > +the current payload is an entire datagram packet.
>> >
>> > In the destination, if we discard some fragments, then could we
>> > reconstruct a different datagram from the one sent?
>> >
>> > Is that anything acceptable?
>> >
>>
>> Dropping fragments should be explicitly disallowed. The sender is
>> explicitly disallowed from NOT placing fragments on the virtqueue, but I
>> see that I am missing the piece that states that they may not be dropped
>> on the receive side.
>>
>> I think it is worth mentioning that implicit in this spec is that
>> socket-to-socket dgram communication is unreliable, but device-to-driver
>> (and vice versa) is still reliable. That is, we can rely at least on the
>> virtqueues to work... and if they fail then the device/driver can simply
>> requeue (think send_pkt_queue in Linux)... so there is some reliability
>> at the lowest layer.

Yep, we should clarify this better.

Thanks,
Stefano


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

