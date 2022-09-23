Return-Path: <virtio-dev-return-9973-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B089D986602
	for <virtio-dev@lists.oasis-open.org>; Fri, 23 Sep 2022 03:33:43 +0000 (UTC)
Message-ID: <1663903426.8765974-1-xuanzhuo@linux.alibaba.com>
Date: Fri, 23 Sep 2022 11:23:46 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <1663297006-64248-1-git-send-email-hengqi@linux.alibaba.com>
 <3c3cc916-c605-1ed2-d3ff-d8d8ce668f17@redhat.com>
 <20220920032824.GA125047@h68b04307.sqa.eu95>
 <CACGkMEtOHXtNtG13Zxpc+bhYJVyefp999kttz4YcPi22nMBSpQ@mail.gmail.com>
In-Reply-To: <CACGkMEtOHXtNtG13Zxpc+bhYJVyefp999kttz4YcPi22nMBSpQ@mail.gmail.com>
Subject: Re: [virtio-dev] [PATCH v8] virtio_net: support for split transport header
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Jason Wang <jasowang@redhat.com>
Cc: Virtio-Dev <virtio-dev@lists.oasis-open.org>, "Michael S. Tsirkin" <mst@redhat.com>, Kangjie Xu <kangjie.xu@linux.alibaba.com>, Heng Qi <hengqi@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, 21 Sep 2022 14:20:19 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Tue, Sep 20, 2022 at 11:28 AM Heng Qi <hengqi@linux.alibaba.com> wrote=
:
> >
> > On Tue, Sep 20, 2022 at 09:59:22AM +0800, Jason Wang wrote:
> > >
> > > =E5=9C=A8 2022/9/16 10:56, hengqi =E5=86=99=E9=81=93:
> > > >From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > >
> > > >The purpose of this feature is to split the transport header and the=
 payload
> > > >of the packet.
> > > >
> > > >|                     receive buffer1(page)            | receive buf=
fer2(page) |
> > > >|<- offset ->| virtnet hdr | mac | ip | tcp |<- hold ->|        payl=
oad        |
> > > >              |<------------------------------->|
> > > >                               ^
> > > >                               |
> > > >                            max_len
> > > >
> > > >We can use one page for every receive buffer. In this way, we can en=
sure that
> > > >all payloads can be independently in a page, which is very beneficia=
l for
> > > >the zerocopy implemented by the upper layer.
> > > >
> > > >Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > >Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> > > >Reviewed-by: Kangjie Xu <kangjie.xu@linux.alibaba.com>
> > > >---
> > > >v8:
> > > >     1. Do not depend on descriptor chain. @Michael S. Tsirkin
> > > >     2. Add \field{offset} and \field{max_len}.
> > > >     3. Fix some presentation issues. @Jason Wang
> > > >     4. Clarify some paragraphs.
> > > >
> > > >v7:
> > > >     1. Fix some presentation issues.
> > > >     2. Use "split transport header". @Jason Wang
> > > >     3. Clarify some paragraphs. @Cornelia Huck
> > > >     4. determine the device what to do if it does not perform heade=
r split on a packet.
> > > >
> > > >v6:
> > > >     1. Fix some syntax issues. @Cornelia Huck
> > > >     2. Clarify some paragraphs. @Cornelia Huck
> > > >     3. Determine the device what to do if it does not perform heade=
r split on a packet.
> > > >
> > > >v5:
> > > >     1. Determine when hdr_len is credible in the process of rx
> > > >     2. Clean up the use of buffers and descriptors
> > > >     3. Clarify the meaning of used lenght if the first descriptor i=
s skipped in the case of merge
> > > >
> > > >v4:
> > > >     1. fix typo @Cornelia Huck @Jason Wang
> > > >     2. do not split header for IP fragmentation packet. @Jason Wang
> > > >
> > > >  conformance.tex |  2 ++
> > > >  content.tex     | 91 +++++++++++++++++++++++++++++++++++++++++++++=
++++++++++++
> > > >  2 files changed, 93 insertions(+)
> > > >
> > > >diff --git a/conformance.tex b/conformance.tex
> > > >index 2b86fc6..4e2b82e 100644
> > > >--- a/conformance.tex
> > > >+++ b/conformance.tex
> > > >@@ -150,6 +150,7 @@ \section{Conformance Targets}\label{sec:Conforma=
nce / Conformance Targets}
> > > >  \item \ref{drivernormative:Device Types / Network Device / Device =
Operation / Control Virtqueue / Offloads State Configuration / Setting Offl=
oads State}
> > > >  \item \ref{drivernormative:Device Types / Network Device / Device =
Operation / Control Virtqueue / Receive-side scaling (RSS) }
> > > >  \item \ref{drivernormative:Device Types / Network Device / Device =
Operation / Control Virtqueue / Notifications Coalescing}
> > > >+\item \ref{drivernormative:Device Types / Network Device / Device O=
peration / Control Virtqueue / Split Transport Header}
> > > >  \end{itemize}
> > > >  \conformance{\subsection}{Block Driver Conformance}\label{sec:Conf=
ormance / Driver Conformance / Block Driver Conformance}
> > > >@@ -415,6 +416,7 @@ \section{Conformance Targets}\label{sec:Conforma=
nce / Conformance Targets}
> > > >  \item \ref{devicenormative:Device Types / Network Device / Device =
Operation / Control Virtqueue / Automatic receive steering in multiqueue mo=
de}
> > > >  \item \ref{devicenormative:Device Types / Network Device / Device =
Operation / Control Virtqueue / Receive-side scaling (RSS) / RSS processing=
}
> > > >  \item \ref{devicenormative:Device Types / Network Device / Device =
Operation / Control Virtqueue / Notifications Coalescing}
> > > >+\item \ref{devicenormative:Device Types / Network Device / Device O=
peration / Control Virtqueue / Split Transport Header}
> > > >  \end{itemize}
> > > >  \conformance{\subsection}{Block Device Conformance}\label{sec:Conf=
ormance / Device Conformance / Block Device Conformance}
> > > >diff --git a/content.tex b/content.tex
> > > >index e863709..fad9dea 100644
> > > >--- a/content.tex
> > > >+++ b/content.tex
> > > >@@ -3084,6 +3084,9 @@ \subsection{Feature bits}\label{sec:Device Typ=
es / Network Device / Feature bits
> > > >  \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through cont=
rol
> > > >      channel.
> > > >+\item[VIRTIO_NET_F_SPLIT_TRANSPORT_HEADER (52)] Device supports spl=
itting
> > > >+    the transport header and the payload.
> > > >+
> > > >  \item[VIRTIO_NET_F_NOTF_COAL(53)] Device supports notifications co=
alescing.
> > > >  \item[VIRTIO_NET_F_GUEST_USO4 (54)] Driver can receive USOv4 packe=
ts.
> > > >@@ -3140,6 +3143,7 @@ \subsubsection{Feature bit requirements}\label=
{sec:Device Types / Network Device
> > > >  \item[VIRTIO_NET_F_NOTF_COAL] Requires VIRTIO_NET_F_CTRL_VQ.
> > > >  \item[VIRTIO_NET_F_RSC_EXT] Requires VIRTIO_NET_F_HOST_TSO4 or VIR=
TIO_NET_F_HOST_TSO6.
> > > >  \item[VIRTIO_NET_F_RSS] Requires VIRTIO_NET_F_CTRL_VQ.
> > > >+\item[VIRTIO_NET_F_SPLIT_TRANSPORT_HEADER] Requires VIRTIO_NET_F_CT=
RL_VQ and VIRTIO_NET_F_MRG_RXBUF.
> > > >  \end{description}
> > > >  \subsubsection{Legacy Interface: Feature bits}\label{sec:Device Ty=
pes / Network Device / Feature bits / Legacy Interface: Feature bits}
> > > >@@ -3371,6 +3375,7 @@ \subsection{Device Operation}\label{sec:Device=
 Types / Network Device / Device O
> > > >  #define VIRTIO_NET_HDR_F_NEEDS_CSUM    1
> > > >  #define VIRTIO_NET_HDR_F_DATA_VALID    2
> > > >  #define VIRTIO_NET_HDR_F_RSC_INFO      4
> > > >+#define VIRTIO_NET_HDR_F_SPLIT_TRANSPORT_HEADER  8
> > > >          u8 flags;
> > > >  #define VIRTIO_NET_HDR_GSO_NONE        0
> > > >  #define VIRTIO_NET_HDR_GSO_TCPV4       1
> > > >@@ -3823,6 +3828,11 @@ \subsubsection{Processing of Incoming Packets=
}\label{sec:Device Types / Network
> > > >  been negotiated, the driver MAY use \field{hdr_len} only as a hint=
 about the
> > > >  transport header size.
> > > >  The driver MUST NOT rely on \field{hdr_len} to be correct.
> > > >+
> > > >+If the VIRTIO_NET_HDR_F_SPLIT_TRANSPORT_HEADER bit in \field{flags}=
 is set,
> > > >+the driver SHOULD treat the \field{hdr_len} as the length of the tr=
ansport
> > > >+header inside the first buffer.
> > > >+
> > > >  \begin{note}
> > > >  This is due to various bugs in implementations.
> > > >  \end{note}
> > > >@@ -4483,6 +4493,87 @@ \subsubsection{Control Virtqueue}\label{sec:D=
evice Types / Network Device / Devi
> > > >  according to the native endian of the guest rather than
> > > >  (necessarily when not using the legacy interface) little-endian.
> > > >+\paragraph{Split Transport Header}\label{sec:Device Types / Network=
 Device / Device Operation / Control Virtqueue / Split Transport Header}
> > > >+
> > > >+If the VIRTIO_NET_F_SPLIT_TRANSPORT_HEADER feature is negotiated,
> > > >+the device supports splitting the transport header and the payload.
> > > >+The transport header and the payload will be separated into differe=
nt
> > > >+buffers.
> > > >+
> > > >+\subparagraph{Split Transport Header}\label{sec:Device Types / Netw=
ork Device / Device Operation / Control Virtqueue / Split Transport Header =
/ Setting Split Transport Header}
> > > >+
> > > >+To configure the split transport header, the following layout struc=
ture
> > > >+and definitions are used:
> > > >+
> > > >+\begin{lstlisting}
> > > >+struct virtio_net_split_transport_header_config {
> > > >+#define VIRTIO_NET_SPLIT_TRANSPORT_HEADER_TYPE_TCP4     (1 << 0)
> > > >+#define VIRTIO_NET_SPLIT_TRANSPORT_HEADER_TYPE_TCP6     (1 << 1)
> > > >+#define VIRTIO_NET_SPLIT_TRANSPORT_HEADER_TYPE_UDP4     (1 << 2)
> > > >+#define VIRTIO_NET_SPLIT_TRANSPORT_HEADER_TYPE_UDP6     (1 << 3)
> > > >+    le64 type;
> > > >+    le16 offset;
> > > >+    le16 max_len;
> > > >+};
> > > >+
> > > >+#define VIRTIO_NET_CTRL_SPLIT_TRANSPORT_HEADER       6
> > > >+ #define VIRTIO_NET_CTRL_SPLIT_TRANSPORT_HEADER_SET   0
> > > >+\end{lstlisting}
> > > >+
> > > >+The class VIRTIO_NET_CTRL_SPLIT_TRANSPORT_HEADER has one command:
> > > >+VIRTIO_NET_CTRL_SPLIT_TRANSPORT_HEADER_SET applies the new split
> > > >+header configuration.
> > > >+
> > > >+The driver can enable or disable split transport header for differe=
nt transport
> > > >+protocols by setting or clearing corresponding bits in \field{type}=
.
> > > >+
> > > >+\begin{itemize}
> > > >+    \item VIRTIO_NET_SPLIT_TRANSPORT_HEADER_TYPE_TCP4: split after =
ipv4 tcp header
> > > >+    \item VIRTIO_NET_SPLIT_TRANSPORT_HEADER_TYPE_TCP6: split after =
ipv6 tcp header
> > > >+    \item VIRTIO_NET_SPLIT_TRANSPORT_HEADER_TYPE_UDP4: split after =
ipv4 udp header
> > > >+    \item VIRTIO_NET_SPLIT_TRANSPORT_HEADER_TYPE_UDP6: split after =
ipv6 udp header
> > > >+\end{itemize}
> > > >+
> > > >+\devicenormative{\subparagraph}{Setting Split Transport Header}{Dev=
ice Types / Network Device / Device Operation / Control Virtqueue / Split T=
ransport Header}
> > > >+
> > > >+A device MUST disable transport header splitting upon reset and ini=
tialization.
> > > >+
> > > >+If VIRTIO_NET_F_SPLIT_TRANSPORT_HEADER is negotiated, the device MU=
ST support
> > > >+VIRTIO_NET_SPLIT_TRANSPORT_HEADER_TYPE_TCP4, VIRTIO_NET_SPLIT_TRANS=
PORT_HEADER_TYPE_TCP6,
> > > >+VIRTIO_NET_SPLIT_TRANSPORT_HEADER_TYPE_UDP4, VIRTIO_NET_SPLIT_TRANS=
PORT_HEADER_TYPE_UDP6.
> > > >+
> > > >+A device MUST NOT split the transport header if it encounters any o=
f the following cases:
> > > >+\begin{itemize}
> > > >+    \item The device does not recognize the transport protocol of t=
he packet.
> > > >+    \item The packet is an IP fragmentation.
> > > >+    \item The splitting of the specific transport protocol is not e=
nabled via
> > > >+        VIRTIO_NET_CTRL_SPLIT_TRANSPORT_HEADER_SET.
> > > >+    \item At most one buffer is available.
> > >
> > >
> > > So this means the feature is disabled for the device without
> > > merge-able buffer? Note that, even in the case of mergeable buffer,
> > > it doesn't mean a buffer that only contains a single descriptor.
> > >
> > >
> >
> > Yes, since the purpose of this scheme is to no longer depend on descrip=
tor chains,
> > the buffer submitted to the receiveq can be thought of as containing on=
ly one descriptor.
> > So this feature depends on the mergeable buffer.
>
> To tell the truth, I'm not sure this is a good choice. We never had a
> feature that depends solely on the mergeable rx buffer before.
> Especially considering that using a descriptor chain is not hard. And
> I'm not sure we should care too much on the overhead since the
> splitting is enabled by the administrator when it needs e.g zerocopy.


It's overwhelmed us, and we haven't been able to agree on this.

Michael doesn't want to use desc chain, it's not just a performance issue. =
In an
early email, he mentioned that desc chain may be abandoned in the future. S=
o we
have been trying not to rely on desc chain.

If we can't make a feature depend only on mergeable, should we use solution=
 B?

     2. Scheme B ( refer to your suggestion )

     Our rethinking approach is no longer based on descriptor chain.

     We refer to your proposed offset-based scheme as scheme B.
     As you suggested, scheme B gives the device a buffer, using offset to
     indicate where to place the payload. Like this:

     <header>...<padding>... <beginning of page><data>

     But how to apply for this buffer?
     Since we want the payload to be placed on a separate page, the method
     we consider is to directly alloc two pages from driver of contiguous m=
emory.

     Then the beginning of this contiguous memory is used to store the head=
room,
     and the contiguous memory after the headroom is directly handed over t=
o the device.
     Similar to the following:

     [------------------ receive buffer(2 pages) --------------------------=
----]
     [<------------first page -------------------><------ second page -----=
--->]
     [<-----><virtnet hdr> <mac,ip,tcp>..<padding><       payload          =
   >]
        ^    ^
        |    |
        |    pointer to device
        |
        |
        Driver reserved, the later part is filled

We have already entered v8, but we have not been able to reach an agreement=
 on
the basic capabilities. I want to solve this problem first.

@Jason @Michael

Thanks.





>
> >
> > > >+    \item The total size of the virtio net header and the transport=
 header exceeds \field{max_len}.
> > >
> > >
> > > I don't get the reason why we need max_len. Can't it implied in the
> > > length of the first descriptor?
> > >
> >
> > Split transport header is usually used in high-throughput scenarios, su=
ch as GSO-enabled cases.
> > Therefore, it is best to reserve tailroom with $ (the length of the buf=
fer) - (\field{offset} + \filed{max_len}) $
> > in the first buffer to build the non-linear data area of the socket buf=
fer.
> >
> > >
> > > >+\end{itemize}
> > > >+
> > > >+If the transport header is split by the device, the VIRTIO_NET_HDR_=
F_SPLIT_TRANSPORT_HEADER
> > > >+bit in \field{flags} MUST be set. The transport header MUST be on t=
he first
> > > >+buffer, following the virtio net header. The payload MUST start fro=
m the
> > > >+second buffer. The device MUST set \field{hdr_len} of structure
> > > >+virtio_net_hdr to the length of the transport header.
> > > >+The used length still reports the number of bytes it has written to=
 memory.
> > > >+
> > > >+\field{offset} and \field{max_len} are valid when device uses the f=
irst buffer.
> > > >+The device MUST reserve space in the first buffer using \filed{offs=
et}.
> > > >+If \field{offset} exceeds the length of the buffer, the device MUST=
 drop
> > > >+the receive packets.
> > >
> > >
> > > Can the device simply don't split the packet in this case? Anyhow we
> > > need synchronize the driver with the device in the case (e.g when
> > > driver is try to having a new max_len).
> > >
> >
> > We think that \field{offset} is actively set by the driver, so the driv=
er
> > will also receive packets according to this offset.
> > But if the case is considered to be caused by driver error settings,
> > the device can do not split the packet.
>
> Note that protocol like ipv6 allows variable length of the header,
> falling back to not split the header seems better to me.
>
> Thanks
>
> >
> > > (I wonder if the offset deserves a independent feature (but depends
> > > on the merge able) in this case).
> > >
> >
> > Okay, we can consider later.
> >
> > >
> > > >  The maximum available length of the first buffer
> > > >+used by the device is specified by \field{max_len}.
> > >
> > >
> > > Similarly the max length seems to be implied by length - offset?
> > >
> >
> > You can refer to the above answer about \field{max_len} similarly.
> >
> > Thanks.
> >
> >
> > > Thanks
> > >
> > >
> > > >  If \field{max_len} is 0 or
> > > >+$ \field{offset} + \field{max_len} $ is greater than the length of =
the buffer,
> > > >+the device can use the entire buffer starting at \field{offset}.
> > > >+
> > > >+\drivernormative{\subparagraph}{Setting Split Transport Header}{Dev=
ice Types / Network Device / Device Operation / Control Virtqueue / Split T=
ransport Header}
> > > >+
> > > >+If the VIRTIO_NET_HDR_F_SPLIT_TRANSPORT_HEADER bit in \field{flags}=
 is set, the driver
> > > >+SHOULD treat the contents of \field{hdr_len} as the length of the t=
ransport header
> > > >+inside the first buffer.
> > > >+
> > > >+If \field{max_len} is not equal to 0, it MUST be greater than the s=
ize of the virtio net header.
> > > >  \paragraph{Notifications Coalescing}\label{sec:Device Types / Netw=
ork Device / Device Operation / Control Virtqueue / Notifications Coalescin=
g}
> >
>
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

