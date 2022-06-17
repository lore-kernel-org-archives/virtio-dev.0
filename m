Return-Path: <virtio-dev-return-9598-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1B37F98674B
	for <virtio-dev@lists.oasis-open.org>; Fri, 17 Jun 2022 02:38:47 +0000 (UTC)
Message-ID: <1655433495.2388463-2-xuanzhuo@linux.alibaba.com>
Date: Fri, 17 Jun 2022 10:38:15 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20220606121046.70163-1-xuanzhuo@linux.alibaba.com>
 <875ylcbow5.fsf@redhat.com>
In-Reply-To: <875ylcbow5.fsf@redhat.com>
Subject: Re: [virtio-dev] [PATCH v3] virtio_net: support split header
Content-Type: text/plain; charset="US-ASCII"; x-default=true
To: Cornelia Huck <cohuck@redhat.com>
Cc: jasowang@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, hengqi@linux.alibaba.com, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, 07 Jun 2022 15:10:18 +0200, Cornelia Huck <cohuck@redhat.com> wrote:
> On Mon, Jun 06 2022, Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
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
> > ---
> >
> > 1. Fix some syntax issues
> > 2. Fix some terminology issues
> > 3. It is not unified with ip alignment, so ip alignment is not included
> > 4. Make it clear that the device must support four types, in the case of
> > successful negotiation.
> >
> >  conformance.tex |  2 ++
> >  content.tex     | 82 +++++++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 84 insertions(+)
> >
>
> (...)
>
> > diff --git a/content.tex b/content.tex
> > index 7508dd1..a5a29d2 100644
> > --- a/content.tex
> > +++ b/content.tex
> > @@ -3084,6 +3084,9 @@ \subsection{Feature bits}\label{sec:Device Types / Network Device / Feature bits
> >  \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through control
> >      channel.
> >
> > +\item[VIRTIO_NET_F_SPLIT_HEADER (55)] Device supports to split the protocol
> > +    header and the payload.
>
> Maybe s/supports to split/supports splitting/ ?
>
> > +
> >  \item[VIRTIO_NET_F_HOST_USO (56)] Device can receive USO packets. Unlike UFO
> >   (fragmenting the packet) the USO splits large UDP packet
> >   to several segments when each of these smaller packets has UDP header.
> > @@ -3131,6 +3134,7 @@ \subsubsection{Feature bit requirements}\label{sec:Device Types / Network Device
> >  \item[VIRTIO_NET_F_CTRL_MAC_ADDR] Requires VIRTIO_NET_F_CTRL_VQ.
> >  \item[VIRTIO_NET_F_RSC_EXT] Requires VIRTIO_NET_F_HOST_TSO4 or VIRTIO_NET_F_HOST_TSO6.
> >  \item[VIRTIO_NET_F_RSS] Requires VIRTIO_NET_F_CTRL_VQ.
> > +\item[VIRTIO_NET_F_SPLIT_HEADER] Requires VIRTIO_NET_F_CTRL_VQ.
> >  \end{description}
> >
> >  \subsubsection{Legacy Interface: Feature bits}\label{sec:Device Types / Network Device / Feature bits / Legacy Interface: Feature bits}
> > @@ -3362,6 +3366,7 @@ \subsection{Device Operation}\label{sec:Device Types / Network Device / Device O
> >  #define VIRTIO_NET_HDR_F_NEEDS_CSUM    1
> >  #define VIRTIO_NET_HDR_F_DATA_VALID    2
> >  #define VIRTIO_NET_HDR_F_RSC_INFO      4
> > +#define VIRTIO_NET_HDR_F_SPLIT_HEADER  8
> >          u8 flags;
> >  #define VIRTIO_NET_HDR_GSO_NONE        0
> >  #define VIRTIO_NET_HDR_GSO_TCPV4       1
> > @@ -4463,6 +4468,83 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
> >  according to the native endian of the guest rather than
> >  (necessarily when not using the legacy interface) little-endian.
> >
> > +\paragraph{Split Header}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Split Header}
> > +
> > +If the VIRTIO_NET_F_SPLIT_HEADER feature is negotiated,
> > +the device supports to split the protocol header and the payload.
>
> s/supports to split/supports splitting/ ?
>
> > +The protocol header and the payload will be separated into different
> > +descriptors.
> > +
> > +\subparagraph{Split Header}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Split Header / Setting Split Header}
> > +
> > +To configure the split header, the following layout structure and definitions
> > +are used:
> > +
> > +\begin{lstlisting}
> > +struct virtio_net_split_header_config {
> > +#define VIRTIO_NET_SPLIT_HEADER_TYPE_TCP4     1
> > +#define VIRTIO_NET_SPLIT_HEADER_TYPE_TCP6     2
> > +#define VIRTIO_NET_SPLIT_HEADER_TYPE_UDP4     4
> > +#define VIRTIO_NET_SPLIT_HEADER_TYPE_UDP6     8
>
> Maybe use the (1 << 0) etc. notation to make it clearer that these are
> bits which can be set in different combinations?
>
> > +    le64 type;
> > +};
> > +
> > +#define VIRTIO_NET_CTRL_SPLIT_HEADER       6
> > + #define VIRTIO_NET_CTRL_SPLIT_HEADER_SET   0
> > +\end{lstlisting}
> > +
> > +The class VIRTIO_NET_CTRL_SPLIT_HEADER has one command:
> > +VIRTIO_NET_CTRL_SPLIT_HEADER_SET applies the new split header configuration.
> > +
> > +The driver can enable or disable the split header by setting or clearing
>
> Maybe better "The driver can enable or disable split header for
> different protocols by..."?
>
> > +corresponding bits in \field{type}.
> > +
> > +The protocol header contains all headers before level 4 payload. For ip
> > +fragmented packets, except for the first fragment, the protocol header only
> > +contains all headers before level 3 payload.
> > +
> > +\devicenormative{\subparagraph}{Setting Split Header}{Device Types / Network Device / Device Operation / Control Virtqueue / Split Header}
> > +
> > +Split header MUST be disabled upon device reset.
>
> Maybe "A device MUST initialize \field{type} to 0, and MUST set it to 0
> upon device reset." ?
>
> > +
> > +If VIRTIO_NET_F_SPLIT_HEADER is negotiated, the device MUST support
> > +VIRTIO_NET_SPLIT_HEADER_TYPE_TCP4, VIRTIO_NET_SPLIT_HEADER_TYPE_TCP6,
> > +VIRTIO_NET_SPLIT_HEADER_TYPE_UDP4, VIRTIO_NET_SPLIT_HEADER_TYPE_UDP6.
> > +
> > +A device MUST NOT perform split header in the following cases:
>
> Maybe s/perform split header/split the header/ ?
>
> > +\begin{itemize}
> > +    \item device does not recognize the protocol of the packet.
> > +    \item \field{type} does not include the protocol of the packet.
> > +    \item the buffer consists of only one descriptor.
> > +    \item the virtio net header and the protocol header exceeds the size
> > +        of the first descriptor.
>
> The sum of both, or either of them?
>
> > +    \item If VIRTIO_NET_F_MRG_RXBUF is not negotiated and the size of the
>
> s/If/when/ ?
>
> > +        payload exceeds the size of the buffer chain starting from the 2nd
> > +        descriptor.
> > +\end{itemize}
> > +
> > +If the header is split by the device, the \field{flags} of structure
> > +virtio_net_hdr MUST contains VIRTIO_NET_HDR_F_SPLIT_HEADER. The protocol header
> > +MUST be on the buffer specified by the first descriptor, following the virtio
> > +net header. The payload MUST starts from the buffer of the second descriptor.
> > +The device MUST set \field{hdr_len} of structure virtio_net_hdr to the length of
> > +the protocol header.
> > +
> > +If the header is split by the device, VIRTIO_NET_F_MRG_RXBUF is negotiated,
> > +and the receive packet is spread over multiple buffers, when the device uses a
> > +buffer other than the first, if the buffer consists of multiple descriptors, the
> > +device MUST skip the buffer of the first descriptor, because the buffer of the
> > +first descriptor is used to carry the protocol header.
> > +
> > +\drivernormative{\subparagraph}{Setting Split Header}{Device Types / Network Device / Device Operation / Control Virtqueue / Split Header}
> > +
> > +If VIRTIO_NET_HDR_F_SPLIT_HEADER bit in \field{flags} is set, the driver MUST
>
> s/If/If the/
>
> > +trust \field{hdr_len}.
>
> What does "trust" mean? Something like "the driver MUST treat the
> contents of \field{hdr_len} as the length of the packet"?
>
> > +
> > +If the split header is enabled, the buffers submitted to receiveq by the
> > +driver SHOULD at least be composed of two descriptors. The buffer specified by
>
> "SHOULD be composed of at least two descriptors"

Thanks. The next version will fix these issues.

>
> > +the first descriptor SHOULD be able to accommodate the virtio net header and the
> > +protocol header.
> >
> >  \subsubsection{Legacy Interface: Framing Requirements}\label{sec:Device
> >  Types / Network Device / Legacy Interface: Framing Requirements}
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

