Return-Path: <virtio-dev-return-9566-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 194179861B0
	for <virtio-dev@lists.oasis-open.org>; Tue, 31 May 2022 04:38:30 +0000 (UTC)
MIME-Version: 1.0
References: <20220507071533.104000-1-xuanzhuo@linux.alibaba.com>
 <2a597a0d-29b2-adc9-75e2-cc1c552384f4@redhat.com> <1653544991.258558-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEsYOpHXhDukZsLw4hkLTAudFBQ5PNo+mtaBNiFiHk69SQ@mail.gmail.com> <20220530141708-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220530141708-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 31 May 2022 12:38:14 +0800
Message-ID: <CACGkMEsLSVushWad0TZgM2MbT_5RkL_Z3-7shMq0Kzf4TMXqxg@mail.gmail.com>
Subject: Re: [virtio-dev] Re: [PATCH v2] virtio_net: support split header
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Virtio-Dev <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, May 31, 2022 at 2:23 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, May 30, 2022 at 01:56:06PM +0800, Jason Wang wrote:
> > On Thu, May 26, 2022 at 2:31 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> =
wrote:
> > >
> > > On Mon, 9 May 2022 16:41:11 +0800, Jason Wang <jasowang@redhat.com> w=
rote:
> > > >
> > > > =E5=9C=A8 2022/5/7 15:15, Xuan Zhuo =E5=86=99=E9=81=93:
> > > > > The purpose of this feature is to split the header and the payloa=
d of
> > > > > the packet.
> > > > >
> > > > > |                    receive buffer                              =
      |
> > > > > |                       0th descriptor             | 1th descript=
or    |
> > > > > | virtnet hdr | mac | ip hdr | tcp hdr|<-- hold -->|   payload   =
      |
> > > > >
> > > > > We can use a buffer plus a separate page when allocating the rece=
ive
> > > > > buffer. In this way, we can ensure that all payloads can be
> > > > > independently in a page, which is very beneficial for the zerocop=
y
> > > > > implemented by the upper layer.
> > > > >
> > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > ---
> > > > >   conformance.tex |  2 ++
> > > > >   content.tex     | 72 ++++++++++++++++++++++++++++++++++++++++++=
+++++++
> > > > >   2 files changed, 74 insertions(+)
> > > > >
> > > > > diff --git a/conformance.tex b/conformance.tex
> > > > > index 663e7c3..6f561fb 100644
> > > > > --- a/conformance.tex
> > > > > +++ b/conformance.tex
> > > > > @@ -149,6 +149,7 @@ \section{Conformance Targets}\label{sec:Confo=
rmance / Conformance Targets}
> > > > >   \item \ref{drivernormative:Device Types / Network Device / Devi=
ce Operation / Control Virtqueue / Automatic receive steering in multiqueue=
 mode}
> > > > >   \item \ref{drivernormative:Device Types / Network Device / Devi=
ce Operation / Control Virtqueue / Offloads State Configuration / Setting O=
ffloads State}
> > > > >   \item \ref{drivernormative:Device Types / Network Device / Devi=
ce Operation / Control Virtqueue / Receive-side scaling (RSS) }
> > > > > +\item \ref{drivernormative:Device Types / Network Device / Devic=
e Operation / Control Virtqueue / Split Header}
> > > > >   \end{itemize}
> > > > >
> > > > >   \conformance{\subsection}{Block Driver Conformance}\label{sec:C=
onformance / Driver Conformance / Block Driver Conformance}
> > > > > @@ -411,6 +412,7 @@ \section{Conformance Targets}\label{sec:Confo=
rmance / Conformance Targets}
> > > > >   \item \ref{devicenormative:Device Types / Network Device / Devi=
ce Operation / Control Virtqueue / Gratuitous Packet Sending}
> > > > >   \item \ref{devicenormative:Device Types / Network Device / Devi=
ce Operation / Control Virtqueue / Automatic receive steering in multiqueue=
 mode}
> > > > >   \item \ref{devicenormative:Device Types / Network Device / Devi=
ce Operation / Control Virtqueue / Receive-side scaling (RSS) / RSS process=
ing}
> > > > > +\item \ref{devicenormative:Device Types / Network Device / Devic=
e Operation / Control Virtqueue / Split Header}
> > > > >   \end{itemize}
> > > > >
> > > > >   \conformance{\subsection}{Block Device Conformance}\label{sec:C=
onformance / Device Conformance / Block Device Conformance}
> > > > > diff --git a/content.tex b/content.tex
> > > > > index 060bdab..3340402 100644
> > > > > --- a/content.tex
> > > > > +++ b/content.tex
> > > > > @@ -3092,6 +3092,9 @@ \subsection{Feature bits}\label{sec:Device =
Types / Network Device / Feature bits
> > > > >   \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through c=
ontrol
> > > > >       channel.
> > > > >
> > > > > +\item[VIRTIO_NET_F_SPLIT_HEADER (55)] Device supports to split t=
he header and
> > > > > +    the payload.
> > > > > +
> > > > >   \item[VIRTIO_NET_F_HOST_USO (56)] Device can receive USO packet=
s. Unlike UFO
> > > > >    (fragmenting the packet) the USO splits large UDP packet
> > > > >    to several segments when each of these smaller packets has UDP=
 header.
> > > > > @@ -3139,6 +3142,7 @@ \subsubsection{Feature bit requirements}\la=
bel{sec:Device Types / Network Device
> > > > >   \item[VIRTIO_NET_F_CTRL_MAC_ADDR] Requires VIRTIO_NET_F_CTRL_VQ=
.
> > > > >   \item[VIRTIO_NET_F_RSC_EXT] Requires VIRTIO_NET_F_HOST_TSO4 or =
VIRTIO_NET_F_HOST_TSO6.
> > > > >   \item[VIRTIO_NET_F_RSS] Requires VIRTIO_NET_F_CTRL_VQ.
> > > > > +\item[VIRTIO_NET_F_SPLIT_HEADER] Requires VIRTIO_NET_F_CTRL_VQ.
> > > > >   \end{description}
> > > > >
> > > > >   \subsubsection{Legacy Interface: Feature bits}\label{sec:Device=
 Types / Network Device / Feature bits / Legacy Interface: Feature bits}
> > > > > @@ -3370,6 +3374,7 @@ \subsection{Device Operation}\label{sec:Dev=
ice Types / Network Device / Device O
> > > > >   #define VIRTIO_NET_HDR_F_NEEDS_CSUM    1
> > > > >   #define VIRTIO_NET_HDR_F_DATA_VALID    2
> > > > >   #define VIRTIO_NET_HDR_F_RSC_INFO      4
> > > > > +#define VIRTIO_NET_HDR_F_SPLIT_HEADER  8
> > > > >           u8 flags;
> > > > >   #define VIRTIO_NET_HDR_GSO_NONE        0
> > > > >   #define VIRTIO_NET_HDR_GSO_TCPV4       1
> > > > > @@ -4471,6 +4476,73 @@ \subsubsection{Control Virtqueue}\label{se=
c:Device Types / Network Device / Devi
> > > > >   according to the native endian of the guest rather than
> > > > >   (necessarily when not using the legacy interface) little-endian=
.
> > > > >
> > > > > +\paragraph{Split Header}\label{sec:Device Types / Network Device=
 / Device Operation / Control Virtqueue / Split Header}
> > > > > +
> > > > > +If the VIRTIO_NET_F_SPLIT_HEADER feature is negotiated,
> > > > > +the device supports to split the header and the payload.
> > > > > +The header and payload will be separated into different buffers.
> > > >
> > > >
> > > > I think you meant "descriptors" instead of "buffers".
> > >
> > > Will fix.
>
> No, actually, I think this is exactly buffers.
> device is always in terms of buffers, descriptors is
> a means to implement buffers.
>
> And the feature should
> depend on mergeable buffers. Without mergeable buffers you do not
> need these tricks, just add two descriptors and be done
> with it.

How do we know the length of a header in advance to allocate the exact
descriptor properly in this case?

Thanks

>
> Right?
>
> > >
> > > >
> > > >
> > > > > +
> > > > > +\subparagraph{Split Header}\label{sec:Device Types / Network Dev=
ice / Device Operation / Control Virtqueue / Split Header / Setting Split H=
eader}
> > > > > +
> > > > > +To configure the split header, the following layout structure an=
d definitions
> > > > > +are used:
> > > > > +
> > > > > +\begin{lstlisting}
> > > > > +struct virtio_net_split_header_config {
> > > > > +#define VIRTIO_NET_SPLIT_HEADER_TYPE_TCPv4     1
> > > >
> > > >
> > > > I think it's better to capitalize: TCPV4 or TCP4.
> > >
> > > OK.
> > >
> > > >
> > > >
> > > > > +#define VIRTIO_NET_SPLIT_HEADER_TYPE_TCPv6     2
> > > > > +#define VIRTIO_NET_SPLIT_HEADER_TYPE_UDPv4     4
> > > > > +#define VIRTIO_NET_SPLIT_HEADER_TYPE_UDPv6     8
> > > > > +    le64 type;
> > > > > +};
> > > > > +
> > > > > +#define VIRTIO_NET_CTRL_SPLIT_HEADER       6
> > > > > + #define VIRTIO_NET_CTRL_SPLIT_HEADER_SET   0
> > > > > +\end{lstlisting}
> > > > > +
> > > > > +The class VIRTIO_NET_CTRL_SPLIT_HEADER has one command:
> > > > > +VIRTIO_NET_CTRL_SPLIT_HEADER_SET applies the new split header co=
nfiguration.
> > > > > +
> > > > > +\field{type} passed as command data is a bitmask, bits set defin=
e
> > > > > +packet types to split header, bits cleared - split header to be =
disabled.
> > > >
> > > >
> > > > (Not a native speaker, try my best to help)
> > > >
> > > > This sentence might need some tweaks:
> > > >
> > > > The driver can enable or disable the split by setting or clearing
> > > > corresponding bits in \field{type}.
> > >
> > > Thanks.
> > >
> > > >
> > > >
> > > > > +
> > > > > +The header contains the struct virtio_net_hdr and the header of =
the package.
> > > > > +Such as \field{VIRTIO_NET_SPLIT_HEADER_TYPE_TCPv4} specified hea=
der contains
> > > > > +virtio_net_hdr, MAC header, IPv4 header (including IPv4 options)=
, TCP header
> > > > > +(include TCP options). The back part is the payload.
> > > >
> > > >
> > > > I think it's better to either explain each type one by one instead =
of
> > > > only describing the TCPv4. Or we can simply say the head contains a=
ll
> > > > headers before level 4 payload?
> > >
> > > OK. Thanks.
> >
>
> So this always splits out at protocol level?
> What if device wants to align e.g. IP protocol header?
> Ethernet?
>
>
> Also, what about aligning at an offset?
> E.g. NET_IP_ALIGN?
>
>
> > >
> > > >
> > > >
> > > > > +
> > > > > +\devicenormative{\subparagraph}{Setting Split Header}{Device Typ=
es / Network Device / Device Operation / Control Virtqueue / Split Header}
> > > > > +
> > > > > +Split header MUST be disabled after device initialization.
> > > >
> > > >
> > > > I think you actually mean "upon device reset"?
> > >
> > > Yes.
> > >
> > >
> > > >
> > > >
> > > > > +
> > > > > +A device MUST NOT perform split header in the following cases:
> > > > > +\begin{itemize}
> > > > > +    \item device does not recognize protocol of the packet.
> > > > > +    \item \field{type} does not include the protocol of the pack=
et.
> > > > > +    \item the packet is a IP fragmentation.
> > > >
> > > >
> > > > What's the reason for this limit?
> > >
> > > Rethinking this problem, some implementation difficulties that I orig=
inally
> > > thought can be solved. So I think this limitation can be removed.
> > >
> > > >
> > > >
> > > > > +    \item the receive buffer consists of only one descriptor.
> > > >
> > > >
> > > > descriptor actually.
> > >
> > > Will fix.
> > >
> > > >
> > > >
> > > > > +    \item the header exceeds the size of the 0th descriptor.
> > > >
> > > >
> > > > It looks to me the spec count from the first.
> > >
> > > Will fix.
> > >
> > > >
> > > >
> > > > > +    \item If VIRTIO_NET_F_MRG_RXBUF is not negotiated and the si=
ze of the
> > > > > +        payload is greater than the total size of the 1th\ldots =
Nth descriptor.
> > > >
> > > >
> > > > Maybe something like the following is better:
> > > >
> > > > The size of the payload exceeds the length of the descriptor or buf=
fer
> > > > chain starting from the 2nd descriptor.
> > >
> > > OK.
> > >
> > > >
> > > >
> > > > > +\end{itemize}
> > > > > +
> > > > > +If the split header completed,
> > > >
> > > >
> > > > If the header is split by the device?
> > >
> > > Yes.
> > >
> > > >
> > > >
> > > > >   then the \field{flags} of virtnet hdr MUST
> > > >
> > > >
> > > > We can drop "then" here and it's better to use structure virtio_net=
_hdr
> > >
> > > Will fix.
> > >
> > > >
> > > >
> > > > > +contains VIRTIO_NET_HDR_F_SPLIT_HEADER. The header MUST is on th=
e buffer of the
> > > > > +0th descriptor,
> > > >
> > > >
> > > > first and second should be used here.
> > >
> > > OK
> > >
> > > >
> > > >
> > > > >   and the payload MUST starts from the buffer of the 1th descript=
or.
> > > > > +The device MUST set \field{hdr_len} of virtnet hdr.
> > > >
> > > >
> > > > To what value?
> > >
> > > I'll make it clear in the next version.
> > >
> > > >
> > > >
> > > > > +
> > > > > +If VIRTIO_NET_F_MRG_RXBUF is negotiated and the device is to use=
 multiple
> > > > > +receive buffers, each subsequent receive buffer MUST skip the 0t=
h descriptor.
> > > >
> > > >
> > > > I don't see why we need this.
> > >
> > > If used to implement zerocopy, the second desc points to a page-align=
ed buffer.
> > > The first desc points to a small buffer for saving the header. The fi=
rst buffer
> > > and subsequent buffers are generally discontinuous. So giving up the =
first
> > > buffer and directly guaranteeing the data to the page-aligned buffer =
can achieve
> > > better performance. And the driver can reuse the first buffer.
> >
> > I see, it might be better if we can explain this here.
> >
> > Thanks
> >
> > >
> > > >
> > > >
> > > > > +
> > > > > +\drivernormative{\subparagraph}{Setting Split Header}{Device Typ=
es / Network Device / Device Operation / Control Virtqueue / Split Header}
> > > > > +
> > > > > +If VIRTIO_NET_HDR_F_SPLIT_HEADER bit in \field{flags} is set, th=
e driver MUST
> > > > > +believe \field{hdr_len}, the length of the header in the 0th des=
criptor is equal
> > > > > +to the length of struct virtio_net_hdr plus \field{hdr_len}.
> > > >
> > > >
> > > > See above we can reuse the device normative an drop the second part
> > > > starting from " the length of the header ..."
> > >
> > > OK
> > >
> > > >
> > > >
> > > > > +
> > > > > +If the split header function is enable, the buffers submitted by=
 the driver
> > > > > +SHOULD at least be composed of two descriptors.
> > > >
> > > >
> > > > Do we need to mention it's only used for RX? (I think we don't need=
 this
> > > > for TX).
> > >
> > > Yes.
> > >
> > > >
> > > >
> > > > > The buffer specified by the 0th
> > > > > +descriptor SHOULD be able to accommodate the header.
> > > >
> > > >
> > > > We probably need to clarify that the header here means both the vir=
tio
> > > > net header and the protocol header.
> > >
> > > Will fix.
> > >
> > > Thanks.
> > >
> > > >
> > > > Thanks
> > > >
> > > >
> > > > >
> > > > >   \subsubsection{Legacy Interface: Framing Requirements}\label{se=
c:Device
> > > > >   Types / Network Device / Legacy Interface: Framing Requirements=
}
> > > >
> > > >
> > > > -------------------------------------------------------------------=
--
> > > > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > > > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.o=
rg
> > > >
> > >
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

