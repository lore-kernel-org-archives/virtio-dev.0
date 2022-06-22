Return-Path: <virtio-dev-return-9623-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7794C986519
	for <virtio-dev@lists.oasis-open.org>; Wed, 22 Jun 2022 06:25:39 +0000 (UTC)
Message-ID: <1655878285.0271184-1-xuanzhuo@linux.alibaba.com>
Date: Wed, 22 Jun 2022 14:11:25 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20220617071601.42447-1-xuanzhuo@linux.alibaba.com>
 <20220617053424-mutt-send-email-mst@kernel.org>
 <1655694827.4273274-1-xuanzhuo@linux.alibaba.com>
 <20220621062752-mutt-send-email-mst@kernel.org>
 <aaaf8a80-f30b-9e36-cc83-809d992c93cb@redhat.com>
 <20220622020715-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220622020715-mutt-send-email-mst@kernel.org>
Subject: [virtio-dev] Re: [PATCH v4] virtio_net: support split header
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: cohuck@redhat.com, kangjie.xu@linux.alibaba.com, virtio-dev@lists.oasis-open.org, hengqi@linux.alibaba.com, Jason Wang <jasowang@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, 22 Jun 2022 02:08:19 -0400, "Michael S. Tsirkin" <mst@redhat.com> w=
rote:
> On Wed, Jun 22, 2022 at 11:52:30AM +0800, Jason Wang wrote:
> >
> > =E5=9C=A8 2022/6/21 18:54, Michael S. Tsirkin =E5=86=99=E9=81=93:
> > > On Mon, Jun 20, 2022 at 11:13:47AM +0800, Xuan Zhuo wrote:
> > > > On Fri, 17 Jun 2022 05:58:11 -0400, "Michael S. Tsirkin" <mst@redha=
t.com> wrote:
> > > > > On Fri, Jun 17, 2022 at 03:16:01PM +0800, Xuan Zhuo wrote:
> > > > > > The purpose of this feature is to split the header and the payl=
oad of
> > > > > > the packet.
> > > > > >
> > > > > > |                    receive buffer                            =
        |
> > > > > > |                       0th descriptor             | 1th descri=
ptor    |
> > > > > > | virtnet hdr | mac | ip hdr | tcp hdr|<-- hold -->|   payload =
        |
> > > > > >
> > > > > > We can use a buffer plus a separate page when allocating the re=
ceive
> > > > > > buffer. In this way, we can ensure that all payloads can be
> > > > > > independently in a page, which is very beneficial for the zeroc=
opy
> > > > > > implemented by the upper layer.
> > > > > >
> > > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > > Reviewed-by: Heng Qi <hengqi@linux.alibaba.com>
> > > > > > Reviewed-by: Kangjie Xu <kangjie.xu@linux.alibaba.com>
> > >
> > > Could you describe the zerocopy in more detail? I'd like to understan=
d
> > > e.g. whether it mixes with mergeable buffers.
> > >
> > > I actually have an idea. Driver could specify an offset from start of=
 buffer
> > > at which payload is written. This works with mergeable and without,
> >
> >
> > I don't see any difference compared to the current proposal. The only
> > difference is whether or not we should explicit tell the device about t=
he
> > offset.
>
> The current proposal seems to rely on descriptor framing,
> this is using an offset instead.

Yes, we can use offset instead, and don't use descriptor in spec. But in
implementation, we must use multiple descriptors to combine hdr buf and pay=
load
buf(page).

Thanks.

>
> >
> > > and if header is > offset then flag in packet will simply not be set.
> > > And I think we will want another knob to specify an offset for packet=
s
> > > which can't be split.
> > >
> > > What do you think?
> > >
> > >
> > >
> > > > > > ---
> > > > > > v4:
> > > > > >      1. fix typo @Cornelia Huck @Jason Wang
> > > > > >      2. do not split header for IP fragmentation packet. @Jason=
 Wang
> > > > > >
> > > > > > v3:
> > > > > >      1. Fix some syntax issues
> > > > > >      2. Fix some terminology issues
> > > > > >      3. It is not unified with ip alignment, so ip alignment is=
 not included
> > > > > >      4. Make it clear that the device must support four types, =
in the case of
> > > > > >      successful negotiation.
> > > > > >
> > > > > >   conformance.tex |  2 ++
> > > > > >   content.tex     | 88 ++++++++++++++++++++++++++++++++++++++++=
+++++++++
> > > > > >   2 files changed, 90 insertions(+)
> > > > > >
> > > > > > diff --git a/conformance.tex b/conformance.tex
> > > > > > index 663e7c3..6f561fb 100644
> > > > > > --- a/conformance.tex
> > > > > > +++ b/conformance.tex
> > > > > > @@ -149,6 +149,7 @@ \section{Conformance Targets}\label{sec:Con=
formance / Conformance Targets}
> > > > > >   \item \ref{drivernormative:Device Types / Network Device / De=
vice Operation / Control Virtqueue / Automatic receive steering in multique=
ue mode}
> > > > > >   \item \ref{drivernormative:Device Types / Network Device / De=
vice Operation / Control Virtqueue / Offloads State Configuration / Setting=
 Offloads State}
> > > > > >   \item \ref{drivernormative:Device Types / Network Device / De=
vice Operation / Control Virtqueue / Receive-side scaling (RSS) }
> > > > > > +\item \ref{drivernormative:Device Types / Network Device / Dev=
ice Operation / Control Virtqueue / Split Header}
> > > > > >   \end{itemize}
> > > > > >
> > > > > >   \conformance{\subsection}{Block Driver Conformance}\label{sec=
:Conformance / Driver Conformance / Block Driver Conformance}
> > > > > > @@ -411,6 +412,7 @@ \section{Conformance Targets}\label{sec:Con=
formance / Conformance Targets}
> > > > > >   \item \ref{devicenormative:Device Types / Network Device / De=
vice Operation / Control Virtqueue / Gratuitous Packet Sending}
> > > > > >   \item \ref{devicenormative:Device Types / Network Device / De=
vice Operation / Control Virtqueue / Automatic receive steering in multique=
ue mode}
> > > > > >   \item \ref{devicenormative:Device Types / Network Device / De=
vice Operation / Control Virtqueue / Receive-side scaling (RSS) / RSS proce=
ssing}
> > > > > > +\item \ref{devicenormative:Device Types / Network Device / Dev=
ice Operation / Control Virtqueue / Split Header}
> > > > > >   \end{itemize}
> > > > > >
> > > > > >   \conformance{\subsection}{Block Device Conformance}\label{sec=
:Conformance / Device Conformance / Block Device Conformance}
> > > > > > diff --git a/content.tex b/content.tex
> > > > > > index 7508dd1..78e0ce8 100644
> > > > > > --- a/content.tex
> > > > > > +++ b/content.tex
> > > > > > @@ -3084,6 +3084,9 @@ \subsection{Feature bits}\label{sec:Devic=
e Types / Network Device / Feature bits
> > > > > >   \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through=
 control
> > > > > >       channel.
> > > > > >
> > > > > > +\item[VIRTIO_NET_F_SPLIT_HEADER (55)] Device supports splittin=
g the protocol
> > > > > > +    header and the payload.
> > > > > > +
> > > > >
> > > > > What is split exactly? The name makes it sound like header is spl=
it,
> > > > > and you repeat this everywhere. I suspect it's actually something=
 like
> > > > > protocol split.
> > > >
> > > > This name comes from other network cards, if you think other names =
are better, I
> > > > also feel ok.
> > > So ethtool calls it "TCP header/data split" and the macro is
> > > ETHTOOL_TCP_DATA_SPLIT.
> >
> >
> > Just FYI, e810 called it "header split" and it support split at various
> > layers (l2/l3/l4 or even inner header).
> >
> >
> > >
> > > > > So something like "supports TCP/UDP protocol split
> > > > > - writing out protocol payload
> > > > > and header parts of incoming packets into separate buffers"?
> > > > I don't want to stress tcp/udp here I want to leave room for other =
protocols in
> > > > the future.
> > > Then we'll add more feature flags (we'll need to, anyway).
> > > Separating TCP and UDP is a good idea, e.g. ethtool only seems
> > > to support TCP ...
> > >
> > > > > I propose we just add 4 bits:
> > > > >
> > > > > VIRTIO_NET_F_SPLIT_TCP4
> > > > > VIRTIO_NET_F_SPLIT_TCP6
> > > > > VIRTIO_NET_F_SPLIT_UDP4
> > > > > VIRTIO_NET_F_SPLIT_UDP6
> > > > >
> > > > > Accordingly below we say everywhere:
> > > > > =09if one of
> > > > > VIRTIO_NET_F_SPLIT_TCP4,VIRTIO_NET_F_SPLIT_TCP6,VIRTIO_NET_F_SPLI=
T_UDP4,VIRTIO_NET_F_SPLIT_UDP6
> > > > >
> > > > >
> > > > > >   \item[VIRTIO_NET_F_HOST_USO (56)] Device can receive USO pack=
ets. Unlike UFO
> > > > > >    (fragmenting the packet) the USO splits large UDP packet
> > > > > >    to several segments when each of these smaller packets has U=
DP header.
> > > > > > @@ -3131,6 +3134,7 @@ \subsubsection{Feature bit requirements}\=
label{sec:Device Types / Network Device
> > > > > >   \item[VIRTIO_NET_F_CTRL_MAC_ADDR] Requires VIRTIO_NET_F_CTRL_=
VQ.
> > > > > >   \item[VIRTIO_NET_F_RSC_EXT] Requires VIRTIO_NET_F_HOST_TSO4 o=
r VIRTIO_NET_F_HOST_TSO6.
> > > > > >   \item[VIRTIO_NET_F_RSS] Requires VIRTIO_NET_F_CTRL_VQ.
> > > > > > +\item[VIRTIO_NET_F_SPLIT_HEADER] Requires VIRTIO_NET_F_CTRL_VQ=
.
> > > > > >   \end{description}
> > > > > >
> > > > > >   \subsubsection{Legacy Interface: Feature bits}\label{sec:Devi=
ce Types / Network Device / Feature bits / Legacy Interface: Feature bits}
> > > > > > @@ -3362,6 +3366,7 @@ \subsection{Device Operation}\label{sec:D=
evice Types / Network Device / Device O
> > > > > >   #define VIRTIO_NET_HDR_F_NEEDS_CSUM    1
> > > > > >   #define VIRTIO_NET_HDR_F_DATA_VALID    2
> > > > > >   #define VIRTIO_NET_HDR_F_RSC_INFO      4
> > > > > > +#define VIRTIO_NET_HDR_F_SPLIT_HEADER  8
> > > > > >           u8 flags;
> > > > > >   #define VIRTIO_NET_HDR_GSO_NONE        0
> > > > > >   #define VIRTIO_NET_HDR_GSO_TCPV4       1
> > > > > > @@ -4463,6 +4468,89 @@ \subsubsection{Control Virtqueue}\label{=
sec:Device Types / Network Device / Devi
> > > > > >   according to the native endian of the guest rather than
> > > > > >   (necessarily when not using the legacy interface) little-endi=
an.
> > > > > >
> > > > > > +\paragraph{Split Header}\label{sec:Device Types / Network Devi=
ce / Device Operation / Control Virtqueue / Split Header}
> > > > > > +
> > > > > > +If the VIRTIO_NET_F_SPLIT_HEADER feature is negotiated,
> > > > > > +the device supports splitting the protocol header and the payl=
oad.
> > > > > > +The protocol header and the payload will be separated into dif=
ferent
> > > > > > +descriptors.
> > > > > Descriptors or buffers? I think for mergeable buffers you want
> > > > > buffers. For non mergeable trickier. Maybe just make these
> > > > > flags depend on mergeable?
> > > > >
> > > > >
> > > > > > +
> > > > > > +\subparagraph{Split Header}\label{sec:Device Types / Network D=
evice / Device Operation / Control Virtqueue / Split Header / Setting Split=
 Header}
> > > > > > +
> > > > > > +To configure the split header, the following layout structure =
and definitions
> > > > > > +are used:
> > > > > > +
> > > > > > +\begin{lstlisting}
> > > > > > +struct virtio_net_split_header_config {
> > > > > > +#define VIRTIO_NET_SPLIT_HEADER_TYPE_TCP4     (1 << 0)
> > > > > > +#define VIRTIO_NET_SPLIT_HEADER_TYPE_TCP6     (1 << 1)
> > > > > > +#define VIRTIO_NET_SPLIT_HEADER_TYPE_UDP4     (1 << 2)
> > > > > > +#define VIRTIO_NET_SPLIT_HEADER_TYPE_UDP6     (1 << 3)
> > > > > > +    le64 type;
> > > > > > +};
> > > > > > +
> > > > > > +#define VIRTIO_NET_CTRL_SPLIT_HEADER       6
> > > > > > + #define VIRTIO_NET_CTRL_SPLIT_HEADER_SET   0
> > > > > > +\end{lstlisting}
> > > > > > +
> > > > > > +The class VIRTIO_NET_CTRL_SPLIT_HEADER has one command:
> > > > > > +VIRTIO_NET_CTRL_SPLIT_HEADER_SET applies the new split header =
configuration.
> > > > > > +
> > > > > > +The driver can enable or disable split header for different pr=
otocols by
> > > > > > +setting or clearing corresponding bits in \field{type}.
> > > > > > +
> > > > > > +\begin{itemize}
> > > > > > +    \item VIRTIO_NET_SPLIT_HEADER_TYPE_TCP4: split after ipv4 =
tcp header
> > > > > > +    \item VIRTIO_NET_SPLIT_HEADER_TYPE_TCP6: split after ipv6 =
tcp header
> > > > > > +    \item VIRTIO_NET_SPLIT_HEADER_TYPE_UDP4: split after ipv4 =
udp header
> > > > > > +    \item VIRTIO_NET_SPLIT_HEADER_TYPE_UDP6: split after ipv6 =
udp header
> > > > > > +\end{itemize}
> > > > > and what is the default?
> > > > >
> > > > > > +
> > > > > > +\devicenormative{\subparagraph}{Setting Split Header}{Device T=
ypes / Network Device / Device Operation / Control Virtqueue / Split Header=
}
> > > > > > +
> > > > > > +A device MUST initialize \field{type} to 0, and MUST set it to=
 0
> > > > > > +upon device reset.
> > > > > > +
> > > > > > +If VIRTIO_NET_F_SPLIT_HEADER is negotiated, the device MUST su=
pport
> > > > > > +VIRTIO_NET_SPLIT_HEADER_TYPE_TCP4, VIRTIO_NET_SPLIT_HEADER_TYP=
E_TCP6,
> > > > > > +VIRTIO_NET_SPLIT_HEADER_TYPE_UDP4, VIRTIO_NET_SPLIT_HEADER_TYP=
E_UDP6.
> > > > > pls move or copy all MUST/SHALL etc to a conformance section.
> > > > >
> > > > >
> > > > >
> > > > > > +
> > > > > > +A device MUST NOT split the header in the following cases:
> > > > > if all of the following apply? if one of these applies?
> > > > >
> > > > > > +\begin{itemize}
> > > > > > +    \item the device does not recognize the protocol of the pa=
cket.
> > > > > > +    \item the packet is an IP fragmentation.
> > > > > > +    \item \field{type} does not include the protocol of the pa=
cket.
> > > > > > +    \item the buffer consists of only one descriptor.
> > > > > > +    \item the total size of the virtio net header and the prot=
ocol header exceeds
> > > > > > +        the size of the first descriptor.
> > > > > > +    \item when VIRTIO_NET_F_MRG_RXBUF is not negotiated and th=
e size of the
> > > > > > +        payload exceeds the size of the descriptor chain start=
ing from the 2nd
> > > > > > +        descriptor.
> > > > > > +\end{itemize}
> > > > >
> > > > > Pls spell out what it should do in this case.
> > > > >
> > > > > > +
> > > > > > +If the header is split by the device, the \field{flags} of str=
ucture
> > > > > > +virtio_net_hdr MUST contain VIRTIO_NET_HDR_F_SPLIT_HEADER.
> > > > > Not contain. This bit must be set.
> > > > Yes, will fix.
> > > >
> > > >
> > > > > > The protocol header
> > > > > > +MUST be on the buffer specified by the first descriptor,
> > > > > buffers?descriptors? this uses both of them, we need clarity.
> > > > Yes.
> > > >
> > > > > > following the virtio
> > > > > > +net header. The payload MUST start from the second descriptor.=
 The device MUST
> > > > > > +set \field{hdr_len} of structure virtio_net_hdr to the length =
of the protocol
> > > > > > +header.
> > > > > > +
> > > > > > +If the header is split by the device, VIRTIO_NET_F_MRG_RXBUF i=
s negotiated,
> > > > > > +and the received packet is spread over multiple buffers, when =
the device uses a
> > > > > > +buffer other than the first, if the buffer consists of multipl=
e descriptors, the
> > > > > > +device MUST skip the first descriptor of the buffer, because t=
he first
> > > > > > +descriptor is used to carry the protocol header.
> > > > > This is a layering violation in that device suddenly cares how
> > > > > buffers are described in the ring structure. We don't even guaran=
tee
> > > > > we will have descriptors going forward ...
> > > >
> > > > The problem with using merge to implement this function is that the=
 size of the
> > > > hdr buf prepared by the driver and the payload buffer are inconsist=
ent. For
> > > > example, the size of the hdr buf is 128 and the payload buf is 4k.
> > > >
> > > > If you use merge to implement it, the avali queue will look like th=
e following,
> > > > so if you want to process a package that cannot be split, but there=
 is an hdr
> > > > buf in the queue, it will be very inappropriate to process.
> > > >
> > > > | 128 buf | 4k buf | 128 buf | 4k buf | 128 buf | 4k buf | 128 buf =
| 4k buf |
> > > >
> > > > If the size of all bufs in the queue is 4k, using one page to store=
 a small
> > > > protocol header is also a waste of memory.
> > > Right. However
> > > - we can use learning/statistics tricks like we do currently to guess
> > >    whether splitting is good or not and size buffers accordingly
> >
> >
> > I'm not sure this is good design. And it basically means if the driver =
can't
> > do learning stuffs, header split doesn't make too much sense for them.
> >
> > What's more, taking Linux driver as an example, if we learn the packet
> > should be 64K, do we want to allocate 64K buffer? (which is not sub-opt=
imal
> > because of the high order allocation). And in the future we may want to
> > support big ipv6 TCP packets (larger than 64K).
> >
> > Thanks
> >
> > > - if buffer s too big headers can be copied and buffer released (they=
 are hot in cache
> > >    anyway)
> > >
> > > > So using descriptor to concatenate hdr buf and payload buf is a bet=
ter way.
> > > Well with options there's no real limit on the header size, is there?
> > >
> > > > Do you have other better ideas?
> > > Not at the moment
> > >
> > > > Or maybe I don't understand what you mean.
> > > >
> > > >
> > > > As for the problem of desciptors without guarantees, it should be a=
 very big
> > > > reform. I don't know what it will look like.
> > > >
> > > > But I think that there are always scenarios where a large buffer is=
 formed by
> > > > multiple small buffers.
> > > >
> > > > > Switching to next descriptor before first one is used is also
> > > > > problematic since it's unclear what will the length be.
> > > > Yes, this is a problem, I don't have a clear definition of this beh=
avior.
> > > >
> > > >
> > > > > How does driver find out the header length?
> > > >   +The device MUST
> > > >   +set \field{hdr_len} of structure virtio_net_hdr to the length of=
 the protocol
> > > >   +header.
> > > > >
> > > > >
> > > > > I propose we just assume VIRTIO_NET_F_MRG_RXBUF is set, and
> > > > > drop the multiple descriptors in the buffer idea.
> > > > >
> > > > >
> > > > > What happens if header does not fit in a single buffer?
> > > >   +    \item the total size of the virtio net header and the protoc=
ol header exceeds
> > > >   +        the size of the first descriptor.
> > > might be tricky to always guarantee. what's the plan?
> > >
> > >
> > > > > How does driver
> > > > > find out where does the header end?
> > > >   +The device MUST
> > > >   +set \field{hdr_len} of structure virtio_net_hdr to the length of=
 the protocol
> > > >   +header.
> > > So we need to clarify virtio_net_hdr fits in the 1st buffer, and audi=
t
> > > references to hdr_len to ensure there are no contradictions.
> > > E.g. we say "the driver MUST NOT rely on \field{hdr_len} to be correc=
t."
> > >
> > > > >
> > > > > > +
> > > > > > +\drivernormative{\subparagraph}{Setting Split Header}{Device T=
ypes / Network Device / Device Operation / Control Virtqueue / Split Header=
}
> > > > > > +
> > > > > > +If the VIRTIO_NET_HDR_F_SPLIT_HEADER bit in \field{flags} is s=
et, the driver
> > > > > > +MUST treat the contents of \field{hdr_len} as the length of th=
e protocol header
> > > > > > +inside the first descriptor.
> > > > > > +
> > > > > > +If the split header is enabled, the buffers submitted to recei=
veq by the
> > > > > > +driver SHOULD be composed of at least two descriptors. The buf=
fer specified by
> > > > > > +the first descriptor SHOULD be able to accommodate the virtio =
net header and the
> > > > > > +protocol header.
> > > > > What does this mean? How is driver supposed to know?
> > > > >
> > > > >
> > > > > >   \subsubsection{Legacy Interface: Framing Requirements}\label{=
sec:Device
> > > > > >   Types / Network Device / Legacy Interface: Framing Requiremen=
ts}
> > > > > > --
> > > > > > 2.31.0
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

