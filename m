Return-Path: <virtio-dev-return-9302-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F024A986449
	for <virtio-dev@lists.oasis-open.org>; Wed, 16 Feb 2022 06:31:53 +0000 (UTC)
Message-ID: <1644991539.5814667-1-xuanzhuo@linux.alibaba.com>
Date: Wed, 16 Feb 2022 14:05:39 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20220216030103.60893-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEsTLpnAohVNtHV0i4-cMi4TP_jV9OmQrVxMOaNae_jUiQ@mail.gmail.com>
In-Reply-To: <CACGkMEsTLpnAohVNtHV0i4-cMi4TP_jV9OmQrVxMOaNae_jUiQ@mail.gmail.com>
Subject: [virtio-dev] Re: [PATCH] virtio_net: support split header
Content-Type: text/plain; charset="US-ASCII"
To: Jason Wang <jasowang@redhat.com>
Cc: Virtio-Dev <virtio-dev@lists.oasis-open.org>, "Michael S. Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, 16 Feb 2022 12:32:03 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Wed, Feb 16, 2022 at 11:01 AM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> >
> > The purpose of this feature is to write the payload of the packet to a
> > specified location in the receive buffer after the device receives the
> > packet.
> >
> > |                    receive buffer                             |
> > |                       offset                     |            |
> > | virtnet hdr | mac | ip hdr | tcp hdr|<-- hold -->|   payload  |
>
> This looks more like header padding instead of header split?
>
> I had something similar thought in the past, I wonder why not simply
> add the padding/hold via virtnet hdr?
>
> | virtnet hdr| <- hold -> | mac | ip | tcp | payload |
>
> >
> > Based on this feature, we can obtain two benefits.
> >
> > 1. We can use a buffer of size "offset" plus a separate page when
> >    allocating the receive buffer. In this way, we can ensure that all
> >    payloads can be independently in a page,
>
> Can we achieve this without this proposal today?
>
> It looks to me it's possible if we allocated a dedicated sg for vnet
> header + all the other headers.
>
> > which is very beneficial for
> >    the zerocopy implemented by the upper layer.
>
> Right, it allows us to use TCP RX zerocopy.
>
> So TCP zero copy requires header split which is kind of different from
> what is being proposed here. AFAIK, it requires the hardware to place
> the l4 payload in a descriptor. Is this something what you really
> want:
>
> VIRTIO_NET_F_HEADER_SPLIT: The device MUST place the l4 payload at the
> start of the next descriptor (or drop it if there's no descriptor in
> the chain).

Yes, in fact I am referring to such a function.

In order to make it more general, I introduced a mechanism such as offset.
Because in some cases, we can obtain continuous memory while meeting the
requirements, using offset can save a desc.

|     page    |    page    |
|      |offset|            |
       ^
    pointer

At the same time I want to specify which types of packages to use this function.
And I hope this may be dynamically switchable. So introduce cvq/command.


>
> Then we don't even need the stuff like, cvq/commands/protocol types.
>
>
> >
> > 2. We can include SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) when
> >    setting the offset, so that in the linux implementation, we can
> >    construct skb very efficiently based on build_skb(). No need to copy
> >    the network header.
>
> For spec patch, I think we need to avoid talking about any specific
> driver implementation but describe the logic behind that.

Yes.

>
> >
> >    For MRG_RX, we require that all payloads are placed in the position
> >    specified by offset in each receive buffer. So we can also use
> >    build_skb() without wasting memory. Because we can reuse the
> >    "offset" parts that are not used.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  conformance.tex |  2 ++
> >  content.tex     | 59 +++++++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 61 insertions(+)
> >
> > diff --git a/conformance.tex b/conformance.tex
> > index 42f8537..e5d2ca8 100644
> > --- a/conformance.tex
> > +++ b/conformance.tex
> > @@ -142,6 +142,7 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
> >  \item \ref{drivernormative:Device Types / Network Device / Device Operation / Control Virtqueue / Automatic receive steering in multiqueue mode}
> >  \item \ref{drivernormative:Device Types / Network Device / Device Operation / Control Virtqueue / Offloads State Configuration / Setting Offloads State}
> >  \item \ref{drivernormative:Device Types / Network Device / Device Operation / Control Virtqueue / Receive-side scaling (RSS) }
> > +\item \ref{drivernormative:Device Types / Network Device / Device Operation / Control Virtqueue / Split Header}
> >  \end{itemize}
> >
> >  \conformance{\subsection}{Block Driver Conformance}\label{sec:Conformance / Driver Conformance / Block Driver Conformance}
> > @@ -401,6 +402,7 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
> >  \item \ref{devicenormative:Device Types / Network Device / Device Operation / Control Virtqueue / Gratuitous Packet Sending}
> >  \item \ref{devicenormative:Device Types / Network Device / Device Operation / Control Virtqueue / Automatic receive steering in multiqueue mode}
> >  \item \ref{devicenormative:Device Types / Network Device / Device Operation / Control Virtqueue / Receive-side scaling (RSS) / RSS processing}
> > +\item \ref{devicenormative:Device Types / Network Device / Device Operation / Control Virtqueue / Split Header}
> >  \end{itemize}
> >
> >  \conformance{\subsection}{Block Device Conformance}\label{sec:Conformance / Device Conformance / Block Device Conformance}
> > diff --git a/content.tex b/content.tex
> > index c6f116c..02cde55 100644
> > --- a/content.tex
> > +++ b/content.tex
> > @@ -3092,6 +3092,9 @@ \subsection{Feature bits}\label{sec:Device Types / Network Device / Feature bits
> >  \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through control
> >      channel.
> >
> > +\item[VIRTIO_NET_F_SPLIT_HEADER (55)] Device can separate the header and the
> > +    payload. The payload will be placed at the specified offset.
> > +
> >  \item[VIRTIO_NET_F_HOST_USO (56)] Device can receive USO packets. Unlike UFO
> >   (fragmenting the packet) the USO splits large UDP packet
> >   to several segments when each of these smaller packets has UDP header.
> > @@ -3139,6 +3142,7 @@ \subsubsection{Feature bit requirements}\label{sec:Device Types / Network Device
> >  \item[VIRTIO_NET_F_CTRL_MAC_ADDR] Requires VIRTIO_NET_F_CTRL_VQ.
> >  \item[VIRTIO_NET_F_RSC_EXT] Requires VIRTIO_NET_F_HOST_TSO4 or VIRTIO_NET_F_HOST_TSO6.
> >  \item[VIRTIO_NET_F_RSS] Requires VIRTIO_NET_F_CTRL_VQ.
> > +\item[VIRTIO_NET_F_SPLIT_HEADER] Requires VIRTIO_NET_F_CTRL_VQ.
> >  \end{description}
> >
> >  \subsubsection{Legacy Interface: Feature bits}\label{sec:Device Types / Network Device / Feature bits / Legacy Interface: Feature bits}
> > @@ -3370,6 +3374,7 @@ \subsection{Device Operation}\label{sec:Device Types / Network Device / Device O
> >  #define VIRTIO_NET_HDR_F_NEEDS_CSUM    1
> >  #define VIRTIO_NET_HDR_F_DATA_VALID    2
> >  #define VIRTIO_NET_HDR_F_RSC_INFO      4
> > +#define VIRTIO_NET_HDR_F_SPLIT_HEADER  8
> >          u8 flags;
> >  #define VIRTIO_NET_HDR_GSO_NONE        0
> >  #define VIRTIO_NET_HDR_GSO_TCPV4       1
> > @@ -4471,6 +4476,60 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
> >  according to the native endian of the guest rather than
> >  (necessarily when not using the legacy interface) little-endian.
> >
> > +\paragraph{Split Header}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Split Header}
> > +
> > +If the VIRTIO_NET_F_SPLIT_HEADER feature is negotiated, the device can separate
> > +the header and the payload. The payload will be placed at the specified offset.
> > +
> > +\subparagraph{Split Header}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Split Header / Setting Split Header}
> > +
> > +To configure the split header, the following layout structure and definitions
> > +are used:
> > +
> > +\begin{lstlisting}
> > +struct virtio_net_split_header_config {
> > +#define VIRTIO_NET_SPLIT_HEADER_TYPE_TCPv4     1
> > +#define VIRTIO_NET_SPLIT_HEADER_TYPE_TCPv6     2
> > +#define VIRTIO_NET_SPLIT_HEADER_TYPE_UDPv4     4
> > +#define VIRTIO_NET_SPLIT_HEADER_TYPE_UDPv6     8
> > +    le64 type
> > +    le64 offset;
> > +};
>
> Can the offset be calculated automatically by the device?
>

No

> > +
> > +#define VIRTIO_NET_CTRL_SPLIT_HEADER       6
> > + #define VIRTIO_NET_CTRL_SPLIT_HEADER_SET   0
> > +\end{lstlisting}
> > +
> > +The class VIRTIO_NET_CTRL_SPLIT_HEADER has one command:
> > +VIRTIO_NET_CTRL_SPLIT_HEADER_SET applies the new split header configuration.
> > +
> > +\field{type} passed as command data is a bitmask, bits set define
> > +packet types to split header, bits cleared - split header to be disabled.
> > +
> > +\field{offset}(from the beginning of the receive buffer) specifies where the
> > +payload is placed.
> > +
> > +\devicenormative{\subparagraph}{Setting Split Header}{Device Types / Network Device / Device Operation / Control Virtqueue / Split Header}
> > +
> > +Split header MUST be disabled after device initialization.
> > +
> > +If the packet header plus virtnet hdr exceeds \field{offset}, the device does
> > +not need to split the header for this packet.
>
> So the driver needs to deal with this "corner case".

Yes, the driver will always receive some packets that are not header split. Use
virtnet hdr type to distinguish.


>
> > +
> > +If the size of the payload is greater than the size of the receive buffer minus
> > +\field{offset}, the device does not need to split the header for this packet.
> > +
> > +If the packet is successfully split header, then the type of virtnet hdr MUST
> > +contains VIRTIO_NET_HDR_F_SPLIT_HEADER.
> > +
> > +If VIRTIO_NET_F_MRG_RXBUF is negotiated and the device is to use multiple
> > +receive buffers, each subsequent receive buffer MUST skip the beginning of
> > +offset.
>
> This prevents the driver from coalsing pages.

In fact, when we allocate, the header part and the payload part can be allocated
separately, so that the payload part of multiple receive buffers can come from
consecutive pages, so that merged pages can be achieved.


     | header0 | header1 | header2 |
     | page0 | page1 | page2 |

receive buf0 => header0 + page0
receive buf1 => header1 + page1
receive buf2 => header2 + page2

Thanks.


>
> Thanks
>
> > +
> > +\drivernormative{\subparagraph}{Setting Split Header}{Device Types / Network Device / Device Operation / Control Virtqueue / Split Header}
> > +
> > +If VIRTIO_NET_F_SPLIT_HEADER negotiation is successful, the driver MUST be able
> > +to properly handle packets containing VIRTIO_NET_HDR_F_SPLIT_HEADER.
> >
> >  \subsubsection{Legacy Interface: Framing Requirements}\label{sec:Device
> >  Types / Network Device / Legacy Interface: Framing Requirements}
> > --
> > 2.31.0
> >
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

