Return-Path: <xuanzhuo@linux.alibaba.com>
Message-ID: <1658747308.7691371-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [virtio-dev] [PATCH v5] virtio_net: support split header
Date: Mon, 25 Jul 2022 19:08:28 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20220720094140.123106-1-xuanzhuo@linux.alibaba.com>
 <87leshmp1y.fsf@redhat.com>
In-Reply-To: <87leshmp1y.fsf@redhat.com>
Content-Type: text/plain; charset="US-ASCII"; x-default=true
To: Cornelia Huck <cohuck@redhat.com>
Cc: jasowang@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, hengqi@linux.alibaba.com, Kangjie Xu <kangjie.xu@linux.alibaba.com>, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, 25 Jul 2022 13:04:09 +0200, Cornelia Huck <cohuck@redhat.com> wrote:
> On Wed, Jul 20 2022, Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>
> > The purpose of this feature is to split the header and the payload of
> > the packet.
> >
> > |                    receive buffer                                    |
> > |                       0th descriptor             | 1th descriptor    |
> > | virtnet hdr | mac | ip hdr | tcp hdr|<-- hold -->|   payload         |
> >
> > We can use a buffer plus a separate page when allocating the receive
> > buffer. In this way, we can ensure that all payloads can be
> > independently in a page, which is very beneficial for the zerocopy
> > implemented by the upper layer.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > Reviewed-by: Heng Qi <hengqi@linux.alibaba.com>
> > Reviewed-by: Kangjie Xu <kangjie.xu@linux.alibaba.com>
> > ---
> > v5:
> >     1. Determine when hdr_len is credible in the process of rx
> >     2. Clean up the use of buffers and descriptors
> >     3. Clarify the meaning of used lenght if the first descriptor is skipped in the case of merge
> >
> > v4:
> >     1. fix typo @Cornelia Huck @Jason Wang
> >     2. do not split header for IP fragmentation packet. @Jason Wang
> >
> > v3:
> >     1. Fix some syntax issues
> >     2. Fix some terminology issues
> >     3. It is not unified with ip alignment, so ip alignment is not included
> >     4. Make it clear that the device must support four types, in the case of
> >     successful negotiation.
> >
> >
> >
> >  conformance.tex |  2 +
> >  content.tex     | 97 +++++++++++++++++++++++++++++++++++++++++++++++--
> >  2 files changed, 96 insertions(+), 3 deletions(-)
>
> (...)
>
> > @@ -3786,7 +3791,8 @@ \subsubsection{Processing of Incoming Packets}\label{sec:Device Types / Network
> >  not set VIRTIO_NET_HDR_F_RSC_INFO bit in \field{flags}.
> >
> >  If one of the VIRTIO_NET_F_GUEST_TSO4, TSO6 or UFO options have
> > -been negotiated, the device SHOULD set \field{hdr_len} to a value
> > +been negotiated and the VIRTIO_NET_HDR_F_SPLIT_HEADER bit in \field{flags}
> > +is not set, the device SHOULD set \field{hdr_len} to a value
> >  not less than the length of the headers, including the transport
> >  header.
>
> One thing I find a bit hard to figure out is what hdr_len is supposed to
> look like if the SPLIT_HEADER flag is actually on. It is explained in
> the split header section, but I feel like the reader is left a bit
> hanging here.
>
> Not sure how to solve this; maybe simply add a pointer to the split
> header specification below?

OK, I will try.


>
> (...)
>
> > +A device MUST NOT split the header encounter any of the following cases:
>
> Maybe "A device MUST NOT split the header if it encounters any of the
> following cases"?

Will fix.

>
> > +\begin{itemize}
> > +    \item the device does not recognize the protocol of the packet.
> > +    \item the packet is an IP fragmentation.
> > +    \item \field{type} does not include the protocol of the packet.
> > +    \item the buffer consists of only one descriptor.
> > +    \item the total size of the virtio net header and the protocol header exceeds
> > +        the size of the first descriptor.
> > +    \item when VIRTIO_NET_F_MRG_RXBUF is not negotiated and the size of the
> > +        payload exceeds the size of the descriptor chain starting from the 2nd
> > +        descriptor.
> > +\end{itemize}
> > +
> > +If the header is split by the device, the VIRTIO_NET_HDR_F_SPLIT_HEADER bit
> > +in \field{flags} MUST be set. The protocol header MUST be on the first
> > +descriptor, following the virtio net header. The payload MUST start from the
> > +second descriptor. The device MUST set \field{hdr_len} of structure
> > +virtio_net_hdr to the length of the protocol header.
> > +
> > +If the header is split by the device, VIRTIO_NET_F_MRG_RXBUF is negotiated,
> > +and the received packet is spread over multiple buffers, when the device uses a
> > +buffer other than the first, if the buffer consists of multiple descriptors, the
> > +device MUST skip the first descriptor, because the first descriptor is used to
> > +carry the protocol header. The used length still reports the number of bytes it
> > +has written to memory.
>
> Personally, I find this paragraph hard to follow... maybe something like
> the following:
>
> "If all of the following applies:
> \begin{itemize}
>     \item the header is split by the device,
>     \item VIRTIO_NET_F_MRG_RXBUF has been negotiated,
>     \item the received packet is split over multiple buffers,
>     \item the device uses a buffer other than the first, [*]
>     \item the buffer consists of multiple descriptors
> \end {itemize}
> the device MUST skip the first descriptor, because the first descriptor
> is used to carry the protocol header. The used length still reports the
> number of bytes it has written to memory."

Will fix.

>
> Although I'm not quite sure what [*] means, the first of what?


I mean:
	the device uses a buffer other than the first buffer.

I will fix it in next version.


Thanks.

