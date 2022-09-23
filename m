Return-Path: <virtio-dev-return-9975-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4A35D986602
	for <virtio-dev@lists.oasis-open.org>; Fri, 23 Sep 2022 05:59:42 +0000 (UTC)
Date: Fri, 23 Sep 2022 01:59:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20220923013341-mutt-send-email-mst@kernel.org>
References: <1663297006-64248-1-git-send-email-hengqi@linux.alibaba.com>
 <3c3cc916-c605-1ed2-d3ff-d8d8ce668f17@redhat.com>
 <20220920032824.GA125047@h68b04307.sqa.eu95>
 <CACGkMEtOHXtNtG13Zxpc+bhYJVyefp999kttz4YcPi22nMBSpQ@mail.gmail.com>
 <1663903426.8765974-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEsmqngS-HYPzzV8b9dmv95=W6dJebAa=asXGmo7VEAnoA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEsmqngS-HYPzzV8b9dmv95=W6dJebAa=asXGmo7VEAnoA@mail.gmail.com>
Subject: Re: [virtio-dev] [PATCH v8] virtio_net: support for split transport
 header
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
To: Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Kangjie Xu <kangjie.xu@linux.alibaba.com>, Heng Qi <hengqi@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Sep 23, 2022 at 12:04:28PM +0800, Jason Wang wrote:
> On Fri, Sep 23, 2022 at 11:33 AM Xuan Zhuo <xuanzhuo@linux.alibaba.com> w=
rote:
> >
> > On Wed, 21 Sep 2022 14:20:19 +0800, Jason Wang <jasowang@redhat.com> wr=
ote:
> > > On Tue, Sep 20, 2022 at 11:28 AM Heng Qi <hengqi@linux.alibaba.com> w=
rote:
> > > >
> > > > On Tue, Sep 20, 2022 at 09:59:22AM +0800, Jason Wang wrote:
> > > > >
> > > > > =E5=9C=A8 2022/9/16 10:56, hengqi =E5=86=99=E9=81=93:
> > > > > >From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > >
> > > > > >The purpose of this feature is to split the transport header and=
 the payload
> > > > > >of the packet.
> > > > > >
> > > > > >|                     receive buffer1(page)            | receive=
 buffer2(page) |
> > > > > >|<- offset ->| virtnet hdr | mac | ip | tcp |<- hold ->|        =
payload        |
> > > > > >              |<------------------------------->|
> > > > > >                               ^
> > > > > >                               |
> > > > > >                            max_len
> > > > > >
> > > > > >We can use one page for every receive buffer. In this way, we ca=
n ensure that
> > > > > >all payloads can be independently in a page, which is very benef=
icial for
> > > > > >the zerocopy implemented by the upper layer.
> > > > > >
> > > > > >Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > >Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> > > > > >Reviewed-by: Kangjie Xu <kangjie.xu@linux.alibaba.com>
> > > > > >---
> > > > > >v8:
> > > > > >     1. Do not depend on descriptor chain. @Michael S. Tsirkin
> > > > > >     2. Add \field{offset} and \field{max_len}.
> > > > > >     3. Fix some presentation issues. @Jason Wang
> > > > > >     4. Clarify some paragraphs.
> > > > > >
> > > > > >v7:
> > > > > >     1. Fix some presentation issues.
> > > > > >     2. Use "split transport header". @Jason Wang
> > > > > >     3. Clarify some paragraphs. @Cornelia Huck
> > > > > >     4. determine the device what to do if it does not perform h=
eader split on a packet.
> > > > > >
> > > > > >v6:
> > > > > >     1. Fix some syntax issues. @Cornelia Huck
> > > > > >     2. Clarify some paragraphs. @Cornelia Huck
> > > > > >     3. Determine the device what to do if it does not perform h=
eader split on a packet.
> > > > > >
> > > > > >v5:
> > > > > >     1. Determine when hdr_len is credible in the process of rx
> > > > > >     2. Clean up the use of buffers and descriptors
> > > > > >     3. Clarify the meaning of used lenght if the first descript=
or is skipped in the case of merge
> > > > > >
> > > > > >v4:
> > > > > >     1. fix typo @Cornelia Huck @Jason Wang
> > > > > >     2. do not split header for IP fragmentation packet. @Jason =
Wang
> > > > > >
> > > > > >  conformance.tex |  2 ++
> > > > > >  content.tex     | 91 +++++++++++++++++++++++++++++++++++++++++=
++++++++++++++++
> > > > > >  2 files changed, 93 insertions(+)
> > > > > >
> > > > > >diff --git a/conformance.tex b/conformance.tex
> > > > > >index 2b86fc6..4e2b82e 100644
> > > > > >--- a/conformance.tex
> > > > > >+++ b/conformance.tex
> > > > > >@@ -150,6 +150,7 @@ \section{Conformance Targets}\label{sec:Conf=
ormance / Conformance Targets}
> > > > > >  \item \ref{drivernormative:Device Types / Network Device / Dev=
ice Operation / Control Virtqueue / Offloads State Configuration / Setting =
Offloads State}
> > > > > >  \item \ref{drivernormative:Device Types / Network Device / Dev=
ice Operation / Control Virtqueue / Receive-side scaling (RSS) }
> > > > > >  \item \ref{drivernormative:Device Types / Network Device / Dev=
ice Operation / Control Virtqueue / Notifications Coalescing}
> > > > > >+\item \ref{drivernormative:Device Types / Network Device / Devi=
ce Operation / Control Virtqueue / Split Transport Header}
> > > > > >  \end{itemize}
> > > > > >  \conformance{\subsection}{Block Driver Conformance}\label{sec:=
Conformance / Driver Conformance / Block Driver Conformance}
> > > > > >@@ -415,6 +416,7 @@ \section{Conformance Targets}\label{sec:Conf=
ormance / Conformance Targets}
> > > > > >  \item \ref{devicenormative:Device Types / Network Device / Dev=
ice Operation / Control Virtqueue / Automatic receive steering in multiqueu=
e mode}
> > > > > >  \item \ref{devicenormative:Device Types / Network Device / Dev=
ice Operation / Control Virtqueue / Receive-side scaling (RSS) / RSS proces=
sing}
> > > > > >  \item \ref{devicenormative:Device Types / Network Device / Dev=
ice Operation / Control Virtqueue / Notifications Coalescing}
> > > > > >+\item \ref{devicenormative:Device Types / Network Device / Devi=
ce Operation / Control Virtqueue / Split Transport Header}
> > > > > >  \end{itemize}
> > > > > >  \conformance{\subsection}{Block Device Conformance}\label{sec:=
Conformance / Device Conformance / Block Device Conformance}
> > > > > >diff --git a/content.tex b/content.tex
> > > > > >index e863709..fad9dea 100644
> > > > > >--- a/content.tex
> > > > > >+++ b/content.tex
> > > > > >@@ -3084,6 +3084,9 @@ \subsection{Feature bits}\label{sec:Device=
 Types / Network Device / Feature bits
> > > > > >  \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through =
control
> > > > > >      channel.
> > > > > >+\item[VIRTIO_NET_F_SPLIT_TRANSPORT_HEADER (52)] Device supports=
 splitting
> > > > > >+    the transport header and the payload.
> > > > > >+
> > > > > >  \item[VIRTIO_NET_F_NOTF_COAL(53)] Device supports notification=
s coalescing.
> > > > > >  \item[VIRTIO_NET_F_GUEST_USO4 (54)] Driver can receive USOv4 p=
ackets.
> > > > > >@@ -3140,6 +3143,7 @@ \subsubsection{Feature bit requirements}\l=
abel{sec:Device Types / Network Device
> > > > > >  \item[VIRTIO_NET_F_NOTF_COAL] Requires VIRTIO_NET_F_CTRL_VQ.
> > > > > >  \item[VIRTIO_NET_F_RSC_EXT] Requires VIRTIO_NET_F_HOST_TSO4 or=
 VIRTIO_NET_F_HOST_TSO6.
> > > > > >  \item[VIRTIO_NET_F_RSS] Requires VIRTIO_NET_F_CTRL_VQ.
> > > > > >+\item[VIRTIO_NET_F_SPLIT_TRANSPORT_HEADER] Requires VIRTIO_NET_=
F_CTRL_VQ and VIRTIO_NET_F_MRG_RXBUF.
> > > > > >  \end{description}
> > > > > >  \subsubsection{Legacy Interface: Feature bits}\label{sec:Devic=
e Types / Network Device / Feature bits / Legacy Interface: Feature bits}
> > > > > >@@ -3371,6 +3375,7 @@ \subsection{Device Operation}\label{sec:De=
vice Types / Network Device / Device O
> > > > > >  #define VIRTIO_NET_HDR_F_NEEDS_CSUM    1
> > > > > >  #define VIRTIO_NET_HDR_F_DATA_VALID    2
> > > > > >  #define VIRTIO_NET_HDR_F_RSC_INFO      4
> > > > > >+#define VIRTIO_NET_HDR_F_SPLIT_TRANSPORT_HEADER  8
> > > > > >          u8 flags;
> > > > > >  #define VIRTIO_NET_HDR_GSO_NONE        0
> > > > > >  #define VIRTIO_NET_HDR_GSO_TCPV4       1
> > > > > >@@ -3823,6 +3828,11 @@ \subsubsection{Processing of Incoming Pac=
kets}\label{sec:Device Types / Network
> > > > > >  been negotiated, the driver MAY use \field{hdr_len} only as a =
hint about the
> > > > > >  transport header size.
> > > > > >  The driver MUST NOT rely on \field{hdr_len} to be correct.
> > > > > >+
> > > > > >+If the VIRTIO_NET_HDR_F_SPLIT_TRANSPORT_HEADER bit in \field{fl=
ags} is set,
> > > > > >+the driver SHOULD treat the \field{hdr_len} as the length of th=
e transport
> > > > > >+header inside the first buffer.
> > > > > >+
> > > > > >  \begin{note}
> > > > > >  This is due to various bugs in implementations.
> > > > > >  \end{note}
> > > > > >@@ -4483,6 +4493,87 @@ \subsubsection{Control Virtqueue}\label{s=
ec:Device Types / Network Device / Devi
> > > > > >  according to the native endian of the guest rather than
> > > > > >  (necessarily when not using the legacy interface) little-endia=
n.
> > > > > >+\paragraph{Split Transport Header}\label{sec:Device Types / Net=
work Device / Device Operation / Control Virtqueue / Split Transport Header=
}
> > > > > >+
> > > > > >+If the VIRTIO_NET_F_SPLIT_TRANSPORT_HEADER feature is negotiate=
d,
> > > > > >+the device supports splitting the transport header and the payl=
oad.
> > > > > >+The transport header and the payload will be separated into dif=
ferent
> > > > > >+buffers.
> > > > > >+
> > > > > >+\subparagraph{Split Transport Header}\label{sec:Device Types / =
Network Device / Device Operation / Control Virtqueue / Split Transport Hea=
der / Setting Split Transport Header}
> > > > > >+
> > > > > >+To configure the split transport header, the following layout s=
tructure
> > > > > >+and definitions are used:
> > > > > >+
> > > > > >+\begin{lstlisting}
> > > > > >+struct virtio_net_split_transport_header_config {
> > > > > >+#define VIRTIO_NET_SPLIT_TRANSPORT_HEADER_TYPE_TCP4     (1 << 0=
)
> > > > > >+#define VIRTIO_NET_SPLIT_TRANSPORT_HEADER_TYPE_TCP6     (1 << 1=
)
> > > > > >+#define VIRTIO_NET_SPLIT_TRANSPORT_HEADER_TYPE_UDP4     (1 << 2=
)
> > > > > >+#define VIRTIO_NET_SPLIT_TRANSPORT_HEADER_TYPE_UDP6     (1 << 3=
)
> > > > > >+    le64 type;
> > > > > >+    le16 offset;
> > > > > >+    le16 max_len;
> > > > > >+};
> > > > > >+
> > > > > >+#define VIRTIO_NET_CTRL_SPLIT_TRANSPORT_HEADER       6
> > > > > >+ #define VIRTIO_NET_CTRL_SPLIT_TRANSPORT_HEADER_SET   0
> > > > > >+\end{lstlisting}
> > > > > >+
> > > > > >+The class VIRTIO_NET_CTRL_SPLIT_TRANSPORT_HEADER has one comman=
d:
> > > > > >+VIRTIO_NET_CTRL_SPLIT_TRANSPORT_HEADER_SET applies the new spli=
t
> > > > > >+header configuration.
> > > > > >+
> > > > > >+The driver can enable or disable split transport header for dif=
ferent transport
> > > > > >+protocols by setting or clearing corresponding bits in \field{t=
ype}.
> > > > > >+
> > > > > >+\begin{itemize}
> > > > > >+    \item VIRTIO_NET_SPLIT_TRANSPORT_HEADER_TYPE_TCP4: split af=
ter ipv4 tcp header
> > > > > >+    \item VIRTIO_NET_SPLIT_TRANSPORT_HEADER_TYPE_TCP6: split af=
ter ipv6 tcp header
> > > > > >+    \item VIRTIO_NET_SPLIT_TRANSPORT_HEADER_TYPE_UDP4: split af=
ter ipv4 udp header
> > > > > >+    \item VIRTIO_NET_SPLIT_TRANSPORT_HEADER_TYPE_UDP6: split af=
ter ipv6 udp header
> > > > > >+\end{itemize}
> > > > > >+
> > > > > >+\devicenormative{\subparagraph}{Setting Split Transport Header}=
{Device Types / Network Device / Device Operation / Control Virtqueue / Spl=
it Transport Header}
> > > > > >+
> > > > > >+A device MUST disable transport header splitting upon reset and=
 initialization.
> > > > > >+
> > > > > >+If VIRTIO_NET_F_SPLIT_TRANSPORT_HEADER is negotiated, the devic=
e MUST support
> > > > > >+VIRTIO_NET_SPLIT_TRANSPORT_HEADER_TYPE_TCP4, VIRTIO_NET_SPLIT_T=
RANSPORT_HEADER_TYPE_TCP6,
> > > > > >+VIRTIO_NET_SPLIT_TRANSPORT_HEADER_TYPE_UDP4, VIRTIO_NET_SPLIT_T=
RANSPORT_HEADER_TYPE_UDP6.
> > > > > >+
> > > > > >+A device MUST NOT split the transport header if it encounters a=
ny of the following cases:
> > > > > >+\begin{itemize}
> > > > > >+    \item The device does not recognize the transport protocol =
of the packet.
> > > > > >+    \item The packet is an IP fragmentation.
> > > > > >+    \item The splitting of the specific transport protocol is n=
ot enabled via
> > > > > >+        VIRTIO_NET_CTRL_SPLIT_TRANSPORT_HEADER_SET.
> > > > > >+    \item At most one buffer is available.
> > > > >
> > > > >
> > > > > So this means the feature is disabled for the device without
> > > > > merge-able buffer? Note that, even in the case of mergeable buffe=
r,
> > > > > it doesn't mean a buffer that only contains a single descriptor.
> > > > >
> > > > >
> > > >
> > > > Yes, since the purpose of this scheme is to no longer depend on des=
criptor chains,
> > > > the buffer submitted to the receiveq can be thought of as containin=
g only one descriptor.
> > > > So this feature depends on the mergeable buffer.
> > >
> > > To tell the truth, I'm not sure this is a good choice. We never had a
> > > feature that depends solely on the mergeable rx buffer before.
> > > Especially considering that using a descriptor chain is not hard. And
> > > I'm not sure we should care too much on the overhead since the
> > > splitting is enabled by the administrator when it needs e.g zerocopy.
> >
> >
> > It's overwhelmed us, and we haven't been able to agree on this.
>=20
> Sorry for this but let's make an agreement before posting a new version.

Right, let's do that.
Jason I think the issue with previous proposals is that they conflict
with VIRTIO_F_ANY_LAYOUT. We have repeatedly found that giving the
driver flexibility in arranging the packet in memory is benefitial.



> >
> > Michael doesn't want to use desc chain, it's not just a performance iss=
ue. In an
> > early email, he mentioned that desc chain may be abandoned in the futur=
e. So we
> > have been trying not to rely on desc chain.
>=20
> This seems to be a very large change which seems a little bit too
> early to be considered.

I'd like to put it in other terms. Fundamentally devices are not
supposed to talk about descriptors at all. Descriptors are
a way to describe buffers, and devices should all work in terms
of buffers. I am working on cleaning up the spec from confusion
and terminology mixups. We have several major sources all over the spec:
- descriptor/buffer used inconsistently
- feature negotiated/offered used inconsistently
- field exists/valid used inconsistently

My way to address the first issue is to make sure devices all work
with buffers. And buffers are described by descriptors (makes sense,
right?) and made available to device by driver and used by device.

The advantage of this is layering - we can change the way buffers
are passed around without changing devices. And, it matches
the virtio API nicely.

Existing devices are all fine with this - they do not pass any
information in the descriptor. Yes, this seems like an option to
pass some information around, but I am not convinced it is worth
the layering violation.

By comparison, ability to write data at an offset seems generally
useful, in particular we have a very old issue even without
the split header feature where with mergeable buffers
if we attempt to align the data in the 1st buffer at a cache line
boundary by adding an offset before ETH header, then when it spills
over to the second buffer it will be misaligned there. Wastes
an extra cache line for such packets. Offsets can allow fixing this.


I don't see architecturally what is wrong with making feature just
depend on mergeable buffers for now. We can always allow a combination
down the road. Let's just make it clear that if drivers see SPLIT &&
!MERGEABLE they should not fail probe, they should instead clear the
split header feature.




> >
> > If we can't make a feature depend only on mergeable, should we use solu=
tion B?
> >
> >      2. Scheme B ( refer to your suggestion )
> >
> >      Our rethinking approach is no longer based on descriptor chain.
> >
> >      We refer to your proposed offset-based scheme as scheme B.
>=20
> The offset seems to be the suggestion of Michael.
>=20
> I think I like the design of v7 for several reasons:
>=20
> 1) easy to reserve head/tailroom without any extension of the spec
> 2) easy to work with mergeable rx buffer
> 3) it is the model used by modern NIC like e810 [1]
>=20
> [1] e810 manual 2.4 Figure 10-4 have a nic diagram to demonstrate how
> it works which is similar to v7
>=20
> Thanks
>=20
> >      As you suggested, scheme B gives the device a buffer, using offset=
 to
> >      indicate where to place the payload. Like this:
> >
> >      <header>...<padding>... <beginning of page><data>
> >
> >      But how to apply for this buffer?
> >      Since we want the payload to be placed on a separate page, the met=
hod
> >      we consider is to directly alloc two pages from driver of contiguo=
us memory.
> >
> >      Then the beginning of this contiguous memory is used to store the =
headroom,
> >      and the contiguous memory after the headroom is directly handed ov=
er to the device.
> >      Similar to the following:
> >
> >      [------------------ receive buffer(2 pages) ----------------------=
--------]
> >      [<------------first page -------------------><------ second page -=
------->]
> >      [<-----><virtnet hdr> <mac,ip,tcp>..<padding><       payload      =
       >]
> >         ^    ^
> >         |    |
> >         |    pointer to device
> >         |
> >         |
> >         Driver reserved, the later part is filled
> >
> > We have already entered v8, but we have not been able to reach an agree=
ment on
> > the basic capabilities. I want to solve this problem first.
> >
> > @Jason @Michael
> >
> > Thanks.
> >
> >
> >
> >
> >
> > >
> > > >
> > > > > >+    \item The total size of the virtio net header and the trans=
port header exceeds \field{max_len}.
> > > > >
> > > > >
> > > > > I don't get the reason why we need max_len. Can't it implied in t=
he
> > > > > length of the first descriptor?
> > > > >
> > > >
> > > > Split transport header is usually used in high-throughput scenarios=
, such as GSO-enabled cases.
> > > > Therefore, it is best to reserve tailroom with $ (the length of the=
 buffer) - (\field{offset} + \filed{max_len}) $
> > > > in the first buffer to build the non-linear data area of the socket=
 buffer.
> > > >
> > > > >
> > > > > >+\end{itemize}
> > > > > >+
> > > > > >+If the transport header is split by the device, the VIRTIO_NET_=
HDR_F_SPLIT_TRANSPORT_HEADER
> > > > > >+bit in \field{flags} MUST be set. The transport header MUST be =
on the first
> > > > > >+buffer, following the virtio net header. The payload MUST start=
 from the
> > > > > >+second buffer. The device MUST set \field{hdr_len} of structure
> > > > > >+virtio_net_hdr to the length of the transport header.
> > > > > >+The used length still reports the number of bytes it has writte=
n to memory.
> > > > > >+
> > > > > >+\field{offset} and \field{max_len} are valid when device uses t=
he first buffer.
> > > > > >+The device MUST reserve space in the first buffer using \filed{=
offset}.
> > > > > >+If \field{offset} exceeds the length of the buffer, the device =
MUST drop
> > > > > >+the receive packets.
> > > > >
> > > > >
> > > > > Can the device simply don't split the packet in this case? Anyhow=
 we
> > > > > need synchronize the driver with the device in the case (e.g when
> > > > > driver is try to having a new max_len).
> > > > >
> > > >
> > > > We think that \field{offset} is actively set by the driver, so the =
driver
> > > > will also receive packets according to this offset.
> > > > But if the case is considered to be caused by driver error settings=
,
> > > > the device can do not split the packet.
> > >
> > > Note that protocol like ipv6 allows variable length of the header,
> > > falling back to not split the header seems better to me.
> > >
> > > Thanks
> > >
> > > >
> > > > > (I wonder if the offset deserves a independent feature (but depen=
ds
> > > > > on the merge able) in this case).
> > > > >
> > > >
> > > > Okay, we can consider later.
> > > >
> > > > >
> > > > > >  The maximum available length of the first buffer
> > > > > >+used by the device is specified by \field{max_len}.
> > > > >
> > > > >
> > > > > Similarly the max length seems to be implied by length - offset?
> > > > >
> > > >
> > > > You can refer to the above answer about \field{max_len} similarly.
> > > >
> > > > Thanks.
> > > >
> > > >
> > > > > Thanks
> > > > >
> > > > >
> > > > > >  If \field{max_len} is 0 or
> > > > > >+$ \field{offset} + \field{max_len} $ is greater than the length=
 of the buffer,
> > > > > >+the device can use the entire buffer starting at \field{offset}=
.
> > > > > >+
> > > > > >+\drivernormative{\subparagraph}{Setting Split Transport Header}=
{Device Types / Network Device / Device Operation / Control Virtqueue / Spl=
it Transport Header}
> > > > > >+
> > > > > >+If the VIRTIO_NET_HDR_F_SPLIT_TRANSPORT_HEADER bit in \field{fl=
ags} is set, the driver
> > > > > >+SHOULD treat the contents of \field{hdr_len} as the length of t=
he transport header
> > > > > >+inside the first buffer.
> > > > > >+
> > > > > >+If \field{max_len} is not equal to 0, it MUST be greater than t=
he size of the virtio net header.
> > > > > >  \paragraph{Notifications Coalescing}\label{sec:Device Types / =
Network Device / Device Operation / Control Virtqueue / Notifications Coale=
scing}
> > > >
> > >
> > >
> > > ---------------------------------------------------------------------
> > > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> > >
> >


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

