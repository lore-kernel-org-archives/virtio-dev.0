Return-Path: <jasowang@redhat.com>
MIME-Version: 1.0
References: <20220617071601.42447-1-xuanzhuo@linux.alibaba.com>
 <20220617053424-mutt-send-email-mst@kernel.org> <1655694827.4273274-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1655694827.4273274-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 21 Jun 2022 15:12:04 +0800
Message-ID: <CACGkMEvTU4et3SQ=ucv=J0P66_hYRKjNmR1Eg7H9Z=t8r7yB3w@mail.gmail.com>
Subject: Re: [PATCH v4] virtio_net: support split header
Content-Type: text/plain; charset="UTF-8"
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, kangjie.xu@linux.alibaba.com, Virtio-Dev <virtio-dev@lists.oasis-open.org>, hengqi@linux.alibaba.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Jun 20, 2022 at 3:05 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>
> On Fri, 17 Jun 2022 05:58:11 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Fri, Jun 17, 2022 at 03:16:01PM +0800, Xuan Zhuo wrote:
> > > The purpose of this feature is to split the header and the payload of
> > > the packet.
> > >
> > > |                    receive buffer                                    |
> > > |                       0th descriptor             | 1th descriptor    |
> > > | virtnet hdr | mac | ip hdr | tcp hdr|<-- hold -->|   payload         |
> > >
> > > We can use a buffer plus a separate page when allocating the receive
> > > buffer. In this way, we can ensure that all payloads can be
> > > independently in a page, which is very beneficial for the zerocopy
> > > implemented by the upper layer.
> > >
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > Reviewed-by: Heng Qi <hengqi@linux.alibaba.com>
> > > Reviewed-by: Kangjie Xu <kangjie.xu@linux.alibaba.com>
> > > ---
> > > v4:
> > >     1. fix typo @Cornelia Huck @Jason Wang
> > >     2. do not split header for IP fragmentation packet. @Jason Wang
> > >
> > > v3:
> > >     1. Fix some syntax issues
> > >     2. Fix some terminology issues
> > >     3. It is not unified with ip alignment, so ip alignment is not included
> > >     4. Make it clear that the device must support four types, in the case of
> > >     successful negotiation.
> > >
> > >  conformance.tex |  2 ++
> > >  content.tex     | 88 +++++++++++++++++++++++++++++++++++++++++++++++++
> > >  2 files changed, 90 insertions(+)
> > >
> > > diff --git a/conformance.tex b/conformance.tex
> > > index 663e7c3..6f561fb 100644
> > > --- a/conformance.tex
> > > +++ b/conformance.tex
> > > @@ -149,6 +149,7 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
> > >  \item \ref{drivernormative:Device Types / Network Device / Device Operation / Control Virtqueue / Automatic receive steering in multiqueue mode}
> > >  \item \ref{drivernormative:Device Types / Network Device / Device Operation / Control Virtqueue / Offloads State Configuration / Setting Offloads State}
> > >  \item \ref{drivernormative:Device Types / Network Device / Device Operation / Control Virtqueue / Receive-side scaling (RSS) }
> > > +\item \ref{drivernormative:Device Types / Network Device / Device Operation / Control Virtqueue / Split Header}
> > >  \end{itemize}
> > >
> > >  \conformance{\subsection}{Block Driver Conformance}\label{sec:Conformance / Driver Conformance / Block Driver Conformance}
> > > @@ -411,6 +412,7 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
> > >  \item \ref{devicenormative:Device Types / Network Device / Device Operation / Control Virtqueue / Gratuitous Packet Sending}
> > >  \item \ref{devicenormative:Device Types / Network Device / Device Operation / Control Virtqueue / Automatic receive steering in multiqueue mode}
> > >  \item \ref{devicenormative:Device Types / Network Device / Device Operation / Control Virtqueue / Receive-side scaling (RSS) / RSS processing}
> > > +\item \ref{devicenormative:Device Types / Network Device / Device Operation / Control Virtqueue / Split Header}
> > >  \end{itemize}
> > >
> > >  \conformance{\subsection}{Block Device Conformance}\label{sec:Conformance / Device Conformance / Block Device Conformance}
> > > diff --git a/content.tex b/content.tex
> > > index 7508dd1..78e0ce8 100644
> > > --- a/content.tex
> > > +++ b/content.tex
> > > @@ -3084,6 +3084,9 @@ \subsection{Feature bits}\label{sec:Device Types / Network Device / Feature bits
> > >  \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through control
> > >      channel.
> > >
> > > +\item[VIRTIO_NET_F_SPLIT_HEADER (55)] Device supports splitting the protocol
> > > +    header and the payload.
> > > +
> >
> >
> > What is split exactly? The name makes it sound like header is split,
> > and you repeat this everywhere. I suspect it's actually something like
> > protocol split.
>
>
> This name comes from other network cards, if you think other names are better, I
> also feel ok.

I wonder if HEADER_SPLIT is better since it is the terminology used by
NIC vendors and ethtool

>
>
> > So something like "supports TCP/UDP protocol split
> > - writing out protocol payload
> > and header parts of incoming packets into separate buffers"?
>
> I don't want to stress tcp/udp here I want to leave room for other protocols in
> the future.
>
> >
> > I propose we just add 4 bits:
> >
> > VIRTIO_NET_F_SPLIT_TCP4
> > VIRTIO_NET_F_SPLIT_TCP6
> > VIRTIO_NET_F_SPLIT_UDP4
> > VIRTIO_NET_F_SPLIT_UDP6
> >
> > Accordingly below we say everywhere:
> >       if one of
> > VIRTIO_NET_F_SPLIT_TCP4,VIRTIO_NET_F_SPLIT_TCP6,VIRTIO_NET_F_SPLIT_UDP4,VIRTIO_NET_F_SPLIT_UDP6
> >
> >
> > >  \item[VIRTIO_NET_F_HOST_USO (56)] Device can receive USO packets. Unlike UFO
> > >   (fragmenting the packet) the USO splits large UDP packet
> > >   to several segments when each of these smaller packets has UDP header.
> > > @@ -3131,6 +3134,7 @@ \subsubsection{Feature bit requirements}\label{sec:Device Types / Network Device
> > >  \item[VIRTIO_NET_F_CTRL_MAC_ADDR] Requires VIRTIO_NET_F_CTRL_VQ.
> > >  \item[VIRTIO_NET_F_RSC_EXT] Requires VIRTIO_NET_F_HOST_TSO4 or VIRTIO_NET_F_HOST_TSO6.
> > >  \item[VIRTIO_NET_F_RSS] Requires VIRTIO_NET_F_CTRL_VQ.
> > > +\item[VIRTIO_NET_F_SPLIT_HEADER] Requires VIRTIO_NET_F_CTRL_VQ.
> > >  \end{description}
> > >
> > >  \subsubsection{Legacy Interface: Feature bits}\label{sec:Device Types / Network Device / Feature bits / Legacy Interface: Feature bits}
> > > @@ -3362,6 +3366,7 @@ \subsection{Device Operation}\label{sec:Device Types / Network Device / Device O
> > >  #define VIRTIO_NET_HDR_F_NEEDS_CSUM    1
> > >  #define VIRTIO_NET_HDR_F_DATA_VALID    2
> > >  #define VIRTIO_NET_HDR_F_RSC_INFO      4
> > > +#define VIRTIO_NET_HDR_F_SPLIT_HEADER  8
> > >          u8 flags;
> > >  #define VIRTIO_NET_HDR_GSO_NONE        0
> > >  #define VIRTIO_NET_HDR_GSO_TCPV4       1
> > > @@ -4463,6 +4468,89 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
> > >  according to the native endian of the guest rather than
> > >  (necessarily when not using the legacy interface) little-endian.
> > >
> > > +\paragraph{Split Header}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Split Header}
> > > +
> > > +If the VIRTIO_NET_F_SPLIT_HEADER feature is negotiated,
> > > +the device supports splitting the protocol header and the payload.
> > > +The protocol header and the payload will be separated into different
> > > +descriptors.
> >
> > Descriptors or buffers? I think for mergeable buffers you want
> > buffers. For non mergeable trickier. Maybe just make these
> > flags depend on mergeable?
> >
> >
> > > +
> > > +\subparagraph{Split Header}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Split Header / Setting Split Header}
> > > +
> > > +To configure the split header, the following layout structure and definitions
> > > +are used:
> > > +
> > > +\begin{lstlisting}
> > > +struct virtio_net_split_header_config {
> > > +#define VIRTIO_NET_SPLIT_HEADER_TYPE_TCP4     (1 << 0)
> > > +#define VIRTIO_NET_SPLIT_HEADER_TYPE_TCP6     (1 << 1)
> > > +#define VIRTIO_NET_SPLIT_HEADER_TYPE_UDP4     (1 << 2)
> > > +#define VIRTIO_NET_SPLIT_HEADER_TYPE_UDP6     (1 << 3)
> > > +    le64 type;
> > > +};
> > > +
> > > +#define VIRTIO_NET_CTRL_SPLIT_HEADER       6
> > > + #define VIRTIO_NET_CTRL_SPLIT_HEADER_SET   0
> > > +\end{lstlisting}
> > > +
> > > +The class VIRTIO_NET_CTRL_SPLIT_HEADER has one command:
> > > +VIRTIO_NET_CTRL_SPLIT_HEADER_SET applies the new split header configuration.
> > > +
> > > +The driver can enable or disable split header for different protocols by
> > > +setting or clearing corresponding bits in \field{type}.
> > > +
> > > +\begin{itemize}
> > > +    \item VIRTIO_NET_SPLIT_HEADER_TYPE_TCP4: split after ipv4 tcp header
> > > +    \item VIRTIO_NET_SPLIT_HEADER_TYPE_TCP6: split after ipv6 tcp header
> > > +    \item VIRTIO_NET_SPLIT_HEADER_TYPE_UDP4: split after ipv4 udp header
> > > +    \item VIRTIO_NET_SPLIT_HEADER_TYPE_UDP6: split after ipv6 udp header
> > > +\end{itemize}
> >
> > and what is the default?
> >
> > > +
> > > +\devicenormative{\subparagraph}{Setting Split Header}{Device Types / Network Device / Device Operation / Control Virtqueue / Split Header}
> > > +
> > > +A device MUST initialize \field{type} to 0, and MUST set it to 0
> > > +upon device reset.
> > > +
> > > +If VIRTIO_NET_F_SPLIT_HEADER is negotiated, the device MUST support
> > > +VIRTIO_NET_SPLIT_HEADER_TYPE_TCP4, VIRTIO_NET_SPLIT_HEADER_TYPE_TCP6,
> > > +VIRTIO_NET_SPLIT_HEADER_TYPE_UDP4, VIRTIO_NET_SPLIT_HEADER_TYPE_UDP6.
> >
> > pls move or copy all MUST/SHALL etc to a conformance section.
> >
> >
> >
> > > +
> > > +A device MUST NOT split the header in the following cases:
> >
> > if all of the following apply? if one of these applies?
> >
> > > +\begin{itemize}
> > > +    \item the device does not recognize the protocol of the packet.
> > > +    \item the packet is an IP fragmentation.
> > > +    \item \field{type} does not include the protocol of the packet.
> > > +    \item the buffer consists of only one descriptor.
> > > +    \item the total size of the virtio net header and the protocol header exceeds
> > > +        the size of the first descriptor.
> > > +    \item when VIRTIO_NET_F_MRG_RXBUF is not negotiated and the size of the
> > > +        payload exceeds the size of the descriptor chain starting from the 2nd
> > > +        descriptor.
> > > +\end{itemize}
> >
> >
> > Pls spell out what it should do in this case.
> >
> > > +
> > > +If the header is split by the device, the \field{flags} of structure
> > > +virtio_net_hdr MUST contain VIRTIO_NET_HDR_F_SPLIT_HEADER.
> >
> > Not contain. This bit must be set.
>
> Yes, will fix.
>
>
> >
> > > The protocol header
> > > +MUST be on the buffer specified by the first descriptor,
> >
> > buffers?descriptors? this uses both of them, we need clarity.
>
> Yes.
>
> >
> > > following the virtio
> > > +net header. The payload MUST start from the second descriptor. The device MUST
> > > +set \field{hdr_len} of structure virtio_net_hdr to the length of the protocol
> > > +header.
> > > +
> > > +If the header is split by the device, VIRTIO_NET_F_MRG_RXBUF is negotiated,
> > > +and the received packet is spread over multiple buffers, when the device uses a
> > > +buffer other than the first, if the buffer consists of multiple descriptors, the
> > > +device MUST skip the first descriptor of the buffer, because the first
> > > +descriptor is used to carry the protocol header.
> >
> > This is a layering violation in that device suddenly cares how
> > buffers are described in the ring structure. We don't even guarantee
> > we will have descriptors going forward ...
>
>
> The problem with using merge to implement this function is that the size of the
> hdr buf prepared by the driver and the payload buffer are inconsistent. For
> example, the size of the hdr buf is 128 and the payload buf is 4k.
>
> If you use merge to implement it, the avali queue will look like the following,
> so if you want to process a package that cannot be split, but there is an hdr
> buf in the queue, it will be very inappropriate to process.
>
> | 128 buf | 4k buf | 128 buf | 4k buf | 128 buf | 4k buf | 128 buf | 4k buf |
>
> If the size of all bufs in the queue is 4k, using one page to store a small
> protocol header is also a waste of memory.
>
> So using descriptor to concatenate hdr buf and payload buf is a better way.
> Do you have other better ideas? Or maybe I don't understand what you mean.
>
> As for the problem of desciptors without guarantees, it should be a very big
> reform. I don't know what it will look like.
>
> But I think that there are always scenarios where a large buffer is formed by
> multiple small buffers.
>
> > Switching to next descriptor before first one is used is also
> > problematic since it's unclear what will the length be.
>
> Yes, this is a problem, I don't have a clear definition of this behavior.

It is just the length of the buffer that we used to store (partial of)
the packet?

Thanks

>
>
> > How does driver find out the header length?
>
>  +The device MUST
>  +set \field{hdr_len} of structure virtio_net_hdr to the length of the protocol
>  +header.
>
> >
> >
> >
> > I propose we just assume VIRTIO_NET_F_MRG_RXBUF is set, and
> > drop the multiple descriptors in the buffer idea.
> >
> >
> > What happens if header does not fit in a single buffer?
>
>  +    \item the total size of the virtio net header and the protocol header exceeds
>  +        the size of the first descriptor.
>
> > How does driver
> > find out where does the header end?
>
>  +The device MUST
>  +set \field{hdr_len} of structure virtio_net_hdr to the length of the protocol
>  +header.
>
> >
> >
> > > +
> > > +\drivernormative{\subparagraph}{Setting Split Header}{Device Types / Network Device / Device Operation / Control Virtqueue / Split Header}
> > > +
> > > +If the VIRTIO_NET_HDR_F_SPLIT_HEADER bit in \field{flags} is set, the driver
> > > +MUST treat the contents of \field{hdr_len} as the length of the protocol header
> > > +inside the first descriptor.
> > > +
> > > +If the split header is enabled, the buffers submitted to receiveq by the
> > > +driver SHOULD be composed of at least two descriptors. The buffer specified by
> > > +the first descriptor SHOULD be able to accommodate the virtio net header and the
> > > +protocol header.
> >
> > What does this mean? How is driver supposed to know?
> >
> >
> > >  \subsubsection{Legacy Interface: Framing Requirements}\label{sec:Device
> > >  Types / Network Device / Legacy Interface: Framing Requirements}
> > > --
> > > 2.31.0
> >
>

