Return-Path: <virtio-dev-return-9877-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C23249864EB
	for <virtio-dev@lists.oasis-open.org>; Fri,  2 Sep 2022 04:12:57 +0000 (UTC)
Message-ID: <86eb87af-66f2-0c3e-73d0-a116a8df1bdf@linux.alibaba.com>
Date: Fri, 2 Sep 2022 12:12:50 +0800
MIME-Version: 1.0
From: Heng Qi <hengqi@linux.alibaba.com>
References: <1660642495-104002-1-git-send-email-hengqi@linux.alibaba.com>
In-Reply-To: <1660642495-104002-1-git-send-email-hengqi@linux.alibaba.com>
Subject: Re: [virtio-dev] [PATCH v7] virtio_net: support split header
Content-Type: multipart/alternative;
 boundary="------------BYNVv1Z5AKGCO4lovvwImO17"
To: virtio-dev@lists.oasis-open.org
Cc: Jason Wang <jasowang@redhat.com>, mst@redhat.com, Cornelia Huck <cohuck@redhat.com>, xuanzhuo@linux.alibaba.com, kangjie.xu@linux.alibaba.com
List-ID: <virtio-dev.lists.oasis-open.org>

--------------BYNVv1Z5AKGCO4lovvwImO17
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

=E5=9C=A8 2022/8/16 =E4=B8=8B=E5=8D=885:34, Heng Qi =E5=86=99=E9=81=93:
> From: Xuan Zhuo<xuanzhuo@linux.alibaba.com>
>
> The purpose of this feature is to split the header and the payload of
> the packet.
>
> |                    receive buffer                                    |
> |                       0th descriptor             | 1th descriptor    |
> | virtnet hdr | mac | ip hdr | tcp hdr|<-- hold -->|   payload         |
>
> We can use a buffer plus a separate page when allocating the receive
> buffer. In this way, we can ensure that all payloads can be
> independently in a page, which is very beneficial for the zerocopy
> implemented by the upper layer.
>
> Signed-off-by: Xuan Zhuo<xuanzhuo@linux.alibaba.com>
> Signed-off-by: Heng Qi<hengqi@linux.alibaba.com>
> Reviewed-by: Kangjie Xu<kangjie.xu@linux.alibaba.com>
> ---
> v7:
> =091. Fix some presentation issues.
> =092. Use "split transport header". @Jason Wang
> =093. Clarify some paragraphs. @Cornelia Huck
> =094. determine the device what to do if it does not perform header split=
 on a packet.
>
> v6:
> =091. Fix some syntax issues. @Cornelia Huck
> =092. Clarify some paragraphs. @Cornelia Huck
> =093. Determine the device what to do if it does not perform header split=
 on a packet.
>
> v5:
> =091. Determine when hdr_len is credible in the process of rx
> =092. Clean up the use of buffers and descriptors
> =093. Clarify the meaning of used lenght if the first descriptor is skipp=
ed in the case of merge
>
> v4:
> =091. fix typo @Cornelia Huck @Jason Wang
> =092. do not split header for IP fragmentation packet. @Jason Wang
>
> v3:
> =091. Fix some syntax issues
> =092. Fix some terminology issues
> =093. It is not unified with ip alignment, so ip alignment is not include=
d
> =094. Make it clear that the device must support four types, in the case =
of successful negotiation.
>
>   conformance.tex |   2 ++
>   content.tex     | 102 +++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++
>   2 files changed, 104 insertions(+)
>
> diff --git a/conformance.tex b/conformance.tex
> index 2b86fc6..4e2b82e 100644
> --- a/conformance.tex
> +++ b/conformance.tex
> @@ -150,6 +150,7 @@ \section{Conformance Targets}\label{sec:Conformance /=
 Conformance Targets}
>   \item \ref{drivernormative:Device Types / Network Device / Device Opera=
tion / Control Virtqueue / Offloads State Configuration / Setting Offloads =
State}
>   \item \ref{drivernormative:Device Types / Network Device / Device Opera=
tion / Control Virtqueue / Receive-side scaling (RSS) }
>   \item \ref{drivernormative:Device Types / Network Device / Device Opera=
tion / Control Virtqueue / Notifications Coalescing}
> +\item \ref{drivernormative:Device Types / Network Device / Device Operat=
ion / Control Virtqueue / Split Transport Header}
>   \end{itemize}
>  =20
>   \conformance{\subsection}{Block Driver Conformance}\label{sec:Conforman=
ce / Driver Conformance / Block Driver Conformance}
> @@ -415,6 +416,7 @@ \section{Conformance Targets}\label{sec:Conformance /=
 Conformance Targets}
>   \item \ref{devicenormative:Device Types / Network Device / Device Opera=
tion / Control Virtqueue / Automatic receive steering in multiqueue mode}
>   \item \ref{devicenormative:Device Types / Network Device / Device Opera=
tion / Control Virtqueue / Receive-side scaling (RSS) / RSS processing}
>   \item \ref{devicenormative:Device Types / Network Device / Device Opera=
tion / Control Virtqueue / Notifications Coalescing}
> +\item \ref{devicenormative:Device Types / Network Device / Device Operat=
ion / Control Virtqueue / Split Transport Header}
>   \end{itemize}
>  =20
>   \conformance{\subsection}{Block Device Conformance}\label{sec:Conforman=
ce / Device Conformance / Block Device Conformance}
> diff --git a/content.tex b/content.tex
> index e863709..5676da9 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -3084,6 +3084,9 @@ \subsection{Feature bits}\label{sec:Device Types / =
Network Device / Feature bits
>   \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through control
>       channel.
>  =20
> +\item[VIRTIO_NET_F_SPLIT_TRANSPORT_HEADER (52)] Device supports splittin=
g
> +    the transport header and the payload.
> +
>   \item[VIRTIO_NET_F_NOTF_COAL(53)] Device supports notifications coalesc=
ing.
>  =20
>   \item[VIRTIO_NET_F_GUEST_USO4 (54)] Driver can receive USOv4 packets.
> @@ -3140,6 +3143,7 @@ \subsubsection{Feature bit requirements}\label{sec:=
Device Types / Network Device
>   \item[VIRTIO_NET_F_NOTF_COAL] Requires VIRTIO_NET_F_CTRL_VQ.
>   \item[VIRTIO_NET_F_RSC_EXT] Requires VIRTIO_NET_F_HOST_TSO4 or VIRTIO_N=
ET_F_HOST_TSO6.
>   \item[VIRTIO_NET_F_RSS] Requires VIRTIO_NET_F_CTRL_VQ.
> +\item[VIRTIO_NET_F_SPLIT_TRANSPORT_HEADER] Requires VIRTIO_NET_F_CTRL_VQ=
.
>   \end{description}
>  =20
>   \subsubsection{Legacy Interface: Feature bits}\label{sec:Device Types /=
 Network Device / Feature bits / Legacy Interface: Feature bits}
> @@ -3371,6 +3375,7 @@ \subsection{Device Operation}\label{sec:Device Type=
s / Network Device / Device O
>   #define VIRTIO_NET_HDR_F_NEEDS_CSUM    1
>   #define VIRTIO_NET_HDR_F_DATA_VALID    2
>   #define VIRTIO_NET_HDR_F_RSC_INFO      4
> +#define VIRTIO_NET_HDR_F_SPLIT_TRANSPORT_HEADER  8
>           u8 flags;
>   #define VIRTIO_NET_HDR_GSO_NONE        0
>   #define VIRTIO_NET_HDR_GSO_TCPV4       1
> @@ -3823,6 +3828,11 @@ \subsubsection{Processing of Incoming Packets}\lab=
el{sec:Device Types / Network
>   been negotiated, the driver MAY use \field{hdr_len} only as a hint abou=
t the
>   transport header size.
>   The driver MUST NOT rely on \field{hdr_len} to be correct.
> +
> +If the VIRTIO_NET_HDR_F_SPLIT_TRANSPORT_HEADER bit in \field{flags} is s=
et,
> +the driver SHOULD treat the \field{hdr_len} as the length of the transpo=
rt header
> +inside the first descriptor.
> +
>   \begin{note}
>   This is due to various bugs in implementations.
>   \end{note}
> @@ -4483,6 +4493,98 @@ \subsubsection{Control Virtqueue}\label{sec:Device=
 Types / Network Device / Devi
>   according to the native endian of the guest rather than
>   (necessarily when not using the legacy interface) little-endian.
>  =20
> +\paragraph{Split Transport Header}\label{sec:Device Types / Network Devi=
ce / Device Operation / Control Virtqueue / Split Transport Header}
> +
> +If the VIRTIO_NET_F_SPLIT_TRANSPORT_HEADER feature is negotiated,
> +the device supports splitting the transport header and the payload.
> +The transport header and the payload will be separated into different
> +descriptors.
> +
> +\subparagraph{Split Transport Header}\label{sec:Device Types / Network D=
evice / Device Operation / Control Virtqueue / Split Transport Header / Set=
ting Split Transport Header}
> +
> +To configure the split transport header, the following layout structure =
and definitions
> +are used:
> +
> +\begin{lstlisting}
> +struct virtio_net_split_transport_header_config {
> +#define VIRTIO_NET_SPLIT_TRANSPORT_HEADER_TYPE_TCP4     (1 << 0)
> +#define VIRTIO_NET_SPLIT_TRANSPORT_HEADER_TYPE_TCP6     (1 << 1)
> +#define VIRTIO_NET_SPLIT_TRANSPORT_HEADER_TYPE_UDP4     (1 << 2)
> +#define VIRTIO_NET_SPLIT_TRANSPORT_HEADER_TYPE_UDP6     (1 << 3)
> +    le64 type;
> +};
> +
> +#define VIRTIO_NET_CTRL_SPLIT_TRANSPORT_HEADER       6
> + #define VIRTIO_NET_CTRL_SPLIT_TRANSPORT_HEADER_SET   0
> +\end{lstlisting}
> +
> +The class VIRTIO_NET_CTRL_SPLIT_TRANSPORT_HEADER has one command:
> +VIRTIO_NET_CTRL_SPLIT_TRANSPORT_HEADER_SET applies the new split transpo=
rt header configuration.
> +
> +The driver can enable or disable split transport header for different pr=
otocols by
> +setting or clearing corresponding bits in \field{type}.
> +
> +\begin{itemize}
> +    \item VIRTIO_NET_SPLIT_TRANSPORT_HEADER_TYPE_TCP4: split after ipv4 =
tcp header
> +    \item VIRTIO_NET_SPLIT_TRANSPORT_HEADER_TYPE_TCP6: split after ipv6 =
tcp header
> +    \item VIRTIO_NET_SPLIT_TRANSPORT_HEADER_TYPE_UDP4: split after ipv4 =
udp header
> +    \item VIRTIO_NET_SPLIT_TRANSPORT_HEADER_TYPE_UDP6: split after ipv6 =
udp header
> +\end{itemize}
> +
> +\devicenormative{\subparagraph}{Setting Split Transport Header}{Device T=
ypes / Network Device / Device Operation / Control Virtqueue / Split Transp=
ort Header}
> +
> +A device MUST initialize \field{type} to 0, and MUST set it to 0
> +upon device reset.
> +
> +If VIRTIO_NET_F_SPLIT_TRANSPORT_HEADER is negotiated, the device MUST su=
pport
> +VIRTIO_NET_SPLIT_TRANSPORT_HEADER_TYPE_TCP4, VIRTIO_NET_SPLIT_TRANSPORT_=
HEADER_TYPE_TCP6,
> +VIRTIO_NET_SPLIT_TRANSPORT_HEADER_TYPE_UDP4, VIRTIO_NET_SPLIT_TRANSPORT_=
HEADER_TYPE_UDP6.
> +
> +A device MUST NOT split the transport header if it encounters any of the=
 following cases:
> +\begin{itemize}
> +    \item the device does not recognize the protocol of the packet.
> +    \item the packet is an IP fragmentation.
> +    \item \field{type} does not include the protocol of the packet.
> +    \item the buffer consists of only one descriptor.
> +    \item the total size of the virtio net header and the transport head=
er exceeds
> +        the size of the first descriptor.
> +    \item when VIRTIO_NET_F_MRG_RXBUF is not negotiated and the size of =
the
> +        payload exceeds the size of the descriptor chain starting from t=
he 2nd
> +        descriptor.
> +\end{itemize}
> +
> +If the header is split by the device, the VIRTIO_NET_HDR_F_SPLIT_TRANSPO=
RT_HEADER bit
> +in \field{flags} MUST be set. The transport header MUST be on the first
> +descriptor, following the virtio net header. The payload MUST start from=
 the
> +second descriptor. The device MUST set \field{hdr_len} of structure
> +virtio_net_hdr to the length of the transport header.
> +
> +If all of the following applies:
> +\begin{itemize}
> +    \item the header is split by the device.
> +    \item VIRTIO_NET_F_MRG_RXBUF has been negotiated.
> +    \item the received packet is spread over multiple buffers.
> +\end {itemize}
> +then if the device uses the buffers after the 1st buffer, and the buffer
> +consists of multiple descriptors, the device MUST skip the first descrip=
tor,
> +because the first descriptor is used to carry the transport header.
> +The used length still reports the number of bytes it has written to memo=
ry.
> +
> +If VIRTIO_NET_F_SPLIT_TRANSPORT_HEADER is negotiated, but the device doe=
s not split the
> +virtio net header and the transport header, and the buffer consists of a=
t least two
> +descriptors, the device MUST start with the first descriptor to store th=
e packet, and
> +MUST NOT set the VIRTIO_NET_HDR_F_SPLIT_TRANSPORT_HEADER bit in \field{f=
lags}.
> +
> +\drivernormative{\subparagraph}{Setting Split Transport Header}{Device T=
ypes / Network Device / Device Operation / Control Virtqueue / Split Transp=
ort Header}
> +
> +If the VIRTIO_NET_HDR_F_SPLIT_TRANSPORT_HEADER bit in \field{flags} is s=
et, the driver
> +MUST treat the contents of \field{hdr_len} as the length of the transpor=
t header
> +inside the first descriptor.
> +
> +If the split transport header is enabled, the buffers submitted to recei=
veq by the
> +driver MUST be composed of at least two descriptors.
> +When the buffer consists of two descriptors, the length of the first
> +descriptor MUST be greater than the one of the virtio net header.
>  =20
>   \paragraph{Notifications Coalescing}\label{sec:Device Types / Network D=
evice / Device Operation / Control Virtqueue / Notifications Coalescing}
>  =20

If the reviewers do not have more comments on "split header v7",
then I submit an issue in the virtio-spec repository.
Please vote on whether the new "split header" feature is added
to the virtio specification.


The link ishttps://github.com/oasis-tcs/virtio-spec/issues/144.


Thanks.

--------------BYNVv1Z5AKGCO4lovvwImO17
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DUTF-8=
">
  </head>
  <body>
    <pre>
</pre>
    <div class=3D"moz-cite-prefix">=E5=9C=A8 2022/8/16 =E4=B8=8B=E5=8D=885:=
34, Heng Qi =E5=86=99=E9=81=93:<br>
    </div>
    <blockquote type=3D"cite"
      cite=3D"mid:1660642495-104002-1-git-send-email-hengqi@linux.alibaba.c=
om">
      <pre class=3D"moz-quote-pre" wrap=3D"">From: Xuan Zhuo <a class=3D"mo=
z-txt-link-rfc2396E" href=3D"mailto:xuanzhuo@linux.alibaba.com">&lt;xuanzhu=
o@linux.alibaba.com&gt;</a>

The purpose of this feature is to split the header and the payload of
the packet.

|                    receive buffer                                    |
|                       0th descriptor             | 1th descriptor    |
| virtnet hdr | mac | ip hdr | tcp hdr|&lt;-- hold --&gt;|   payload       =
  |

We can use a buffer plus a separate page when allocating the receive
buffer. In this way, we can ensure that all payloads can be
independently in a page, which is very beneficial for the zerocopy
implemented by the upper layer.

Signed-off-by: Xuan Zhuo <a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:=
xuanzhuo@linux.alibaba.com">&lt;xuanzhuo@linux.alibaba.com&gt;</a>
Signed-off-by: Heng Qi <a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:he=
ngqi@linux.alibaba.com">&lt;hengqi@linux.alibaba.com&gt;</a>
Reviewed-by: Kangjie Xu <a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:k=
angjie.xu@linux.alibaba.com">&lt;kangjie.xu@linux.alibaba.com&gt;</a>
---
v7:
=091. Fix some presentation issues.
=092. Use "split transport header". @Jason Wang
=093. Clarify some paragraphs. @Cornelia Huck
=094. determine the device what to do if it does not perform header split o=
n a packet.

v6:
=091. Fix some syntax issues. @Cornelia Huck
=092. Clarify some paragraphs. @Cornelia Huck
=093. Determine the device what to do if it does not perform header split o=
n a packet.

v5:
=091. Determine when hdr_len is credible in the process of rx
=092. Clean up the use of buffers and descriptors
=093. Clarify the meaning of used lenght if the first descriptor is skipped=
 in the case of merge

v4:
=091. fix typo @Cornelia Huck @Jason Wang
=092. do not split header for IP fragmentation packet. @Jason Wang

v3:
=091. Fix some syntax issues
=092. Fix some terminology issues
=093. It is not unified with ip alignment, so ip alignment is not included
=094. Make it clear that the device must support four types, in the case of=
 successful negotiation.

 conformance.tex |   2 ++
 content.tex     | 102 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 104 insertions(+)

diff --git a/conformance.tex b/conformance.tex
index 2b86fc6..4e2b82e 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -150,6 +150,7 @@ \section{Conformance Targets}\label{sec:Conformance / C=
onformance Targets}
 \item \ref{drivernormative:Device Types / Network Device / Device Operatio=
n / Control Virtqueue / Offloads State Configuration / Setting Offloads Sta=
te}
 \item \ref{drivernormative:Device Types / Network Device / Device Operatio=
n / Control Virtqueue / Receive-side scaling (RSS) }
 \item \ref{drivernormative:Device Types / Network Device / Device Operatio=
n / Control Virtqueue / Notifications Coalescing}
+\item \ref{drivernormative:Device Types / Network Device / Device Operatio=
n / Control Virtqueue / Split Transport Header}
 \end{itemize}
=20
 \conformance{\subsection}{Block Driver Conformance}\label{sec:Conformance =
/ Driver Conformance / Block Driver Conformance}
@@ -415,6 +416,7 @@ \section{Conformance Targets}\label{sec:Conformance / C=
onformance Targets}
 \item \ref{devicenormative:Device Types / Network Device / Device Operatio=
n / Control Virtqueue / Automatic receive steering in multiqueue mode}
 \item \ref{devicenormative:Device Types / Network Device / Device Operatio=
n / Control Virtqueue / Receive-side scaling (RSS) / RSS processing}
 \item \ref{devicenormative:Device Types / Network Device / Device Operatio=
n / Control Virtqueue / Notifications Coalescing}
+\item \ref{devicenormative:Device Types / Network Device / Device Operatio=
n / Control Virtqueue / Split Transport Header}
 \end{itemize}
=20
 \conformance{\subsection}{Block Device Conformance}\label{sec:Conformance =
/ Device Conformance / Block Device Conformance}
diff --git a/content.tex b/content.tex
index e863709..5676da9 100644
--- a/content.tex
+++ b/content.tex
@@ -3084,6 +3084,9 @@ \subsection{Feature bits}\label{sec:Device Types / Ne=
twork Device / Feature bits
 \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through control
     channel.
=20
+\item[VIRTIO_NET_F_SPLIT_TRANSPORT_HEADER (52)] Device supports splitting
+    the transport header and the payload.
+
 \item[VIRTIO_NET_F_NOTF_COAL(53)] Device supports notifications coalescing=
.
=20
 \item[VIRTIO_NET_F_GUEST_USO4 (54)] Driver can receive USOv4 packets.
@@ -3140,6 +3143,7 @@ \subsubsection{Feature bit requirements}\label{sec:De=
vice Types / Network Device
 \item[VIRTIO_NET_F_NOTF_COAL] Requires VIRTIO_NET_F_CTRL_VQ.
 \item[VIRTIO_NET_F_RSC_EXT] Requires VIRTIO_NET_F_HOST_TSO4 or VIRTIO_NET_=
F_HOST_TSO6.
 \item[VIRTIO_NET_F_RSS] Requires VIRTIO_NET_F_CTRL_VQ.
+\item[VIRTIO_NET_F_SPLIT_TRANSPORT_HEADER] Requires VIRTIO_NET_F_CTRL_VQ.
 \end{description}
=20
 \subsubsection{Legacy Interface: Feature bits}\label{sec:Device Types / Ne=
twork Device / Feature bits / Legacy Interface: Feature bits}
@@ -3371,6 +3375,7 @@ \subsection{Device Operation}\label{sec:Device Types =
/ Network Device / Device O
 #define VIRTIO_NET_HDR_F_NEEDS_CSUM    1
 #define VIRTIO_NET_HDR_F_DATA_VALID    2
 #define VIRTIO_NET_HDR_F_RSC_INFO      4
+#define VIRTIO_NET_HDR_F_SPLIT_TRANSPORT_HEADER  8
         u8 flags;
 #define VIRTIO_NET_HDR_GSO_NONE        0
 #define VIRTIO_NET_HDR_GSO_TCPV4       1
@@ -3823,6 +3828,11 @@ \subsubsection{Processing of Incoming Packets}\label=
{sec:Device Types / Network
 been negotiated, the driver MAY use \field{hdr_len} only as a hint about t=
he
 transport header size.
 The driver MUST NOT rely on \field{hdr_len} to be correct.
+
+If the VIRTIO_NET_HDR_F_SPLIT_TRANSPORT_HEADER bit in \field{flags} is set=
,
+the driver SHOULD treat the \field{hdr_len} as the length of the transport=
 header
+inside the first descriptor.
+
 \begin{note}
 This is due to various bugs in implementations.
 \end{note}
@@ -4483,6 +4493,98 @@ \subsubsection{Control Virtqueue}\label{sec:Device T=
ypes / Network Device / Devi
 according to the native endian of the guest rather than
 (necessarily when not using the legacy interface) little-endian.
=20
+\paragraph{Split Transport Header}\label{sec:Device Types / Network Device=
 / Device Operation / Control Virtqueue / Split Transport Header}
+
+If the VIRTIO_NET_F_SPLIT_TRANSPORT_HEADER feature is negotiated,
+the device supports splitting the transport header and the payload.
+The transport header and the payload will be separated into different
+descriptors.
+
+\subparagraph{Split Transport Header}\label{sec:Device Types / Network Dev=
ice / Device Operation / Control Virtqueue / Split Transport Header / Setti=
ng Split Transport Header}
+
+To configure the split transport header, the following layout structure an=
d definitions
+are used:
+
+\begin{lstlisting}
+struct virtio_net_split_transport_header_config {
+#define VIRTIO_NET_SPLIT_TRANSPORT_HEADER_TYPE_TCP4     (1 &lt;&lt; 0)
+#define VIRTIO_NET_SPLIT_TRANSPORT_HEADER_TYPE_TCP6     (1 &lt;&lt; 1)
+#define VIRTIO_NET_SPLIT_TRANSPORT_HEADER_TYPE_UDP4     (1 &lt;&lt; 2)
+#define VIRTIO_NET_SPLIT_TRANSPORT_HEADER_TYPE_UDP6     (1 &lt;&lt; 3)
+    le64 type;
+};
+
+#define VIRTIO_NET_CTRL_SPLIT_TRANSPORT_HEADER       6
+ #define VIRTIO_NET_CTRL_SPLIT_TRANSPORT_HEADER_SET   0
+\end{lstlisting}
+
+The class VIRTIO_NET_CTRL_SPLIT_TRANSPORT_HEADER has one command:
+VIRTIO_NET_CTRL_SPLIT_TRANSPORT_HEADER_SET applies the new split transport=
 header configuration.
+
+The driver can enable or disable split transport header for different prot=
ocols by
+setting or clearing corresponding bits in \field{type}.
+
+\begin{itemize}
+    \item VIRTIO_NET_SPLIT_TRANSPORT_HEADER_TYPE_TCP4: split after ipv4 tc=
p header
+    \item VIRTIO_NET_SPLIT_TRANSPORT_HEADER_TYPE_TCP6: split after ipv6 tc=
p header
+    \item VIRTIO_NET_SPLIT_TRANSPORT_HEADER_TYPE_UDP4: split after ipv4 ud=
p header
+    \item VIRTIO_NET_SPLIT_TRANSPORT_HEADER_TYPE_UDP6: split after ipv6 ud=
p header
+\end{itemize}
+
+\devicenormative{\subparagraph}{Setting Split Transport Header}{Device Typ=
es / Network Device / Device Operation / Control Virtqueue / Split Transpor=
t Header}
+
+A device MUST initialize \field{type} to 0, and MUST set it to 0
+upon device reset.
+
+If VIRTIO_NET_F_SPLIT_TRANSPORT_HEADER is negotiated, the device MUST supp=
ort
+VIRTIO_NET_SPLIT_TRANSPORT_HEADER_TYPE_TCP4, VIRTIO_NET_SPLIT_TRANSPORT_HE=
ADER_TYPE_TCP6,
+VIRTIO_NET_SPLIT_TRANSPORT_HEADER_TYPE_UDP4, VIRTIO_NET_SPLIT_TRANSPORT_HE=
ADER_TYPE_UDP6.
+
+A device MUST NOT split the transport header if it encounters any of the f=
ollowing cases:
+\begin{itemize}
+    \item the device does not recognize the protocol of the packet.
+    \item the packet is an IP fragmentation.
+    \item \field{type} does not include the protocol of the packet.
+    \item the buffer consists of only one descriptor.
+    \item the total size of the virtio net header and the transport header=
 exceeds
+        the size of the first descriptor.
+    \item when VIRTIO_NET_F_MRG_RXBUF is not negotiated and the size of th=
e
+        payload exceeds the size of the descriptor chain starting from the=
 2nd
+        descriptor.
+\end{itemize}
+
+If the header is split by the device, the VIRTIO_NET_HDR_F_SPLIT_TRANSPORT=
_HEADER bit
+in \field{flags} MUST be set. The transport header MUST be on the first
+descriptor, following the virtio net header. The payload MUST start from t=
he
+second descriptor. The device MUST set \field{hdr_len} of structure
+virtio_net_hdr to the length of the transport header.
+
+If all of the following applies:
+\begin{itemize}
+    \item the header is split by the device.
+    \item VIRTIO_NET_F_MRG_RXBUF has been negotiated.
+    \item the received packet is spread over multiple buffers.
+\end {itemize}
+then if the device uses the buffers after the 1st buffer, and the buffer
+consists of multiple descriptors, the device MUST skip the first descripto=
r,
+because the first descriptor is used to carry the transport header.
+The used length still reports the number of bytes it has written to memory=
.
+
+If VIRTIO_NET_F_SPLIT_TRANSPORT_HEADER is negotiated, but the device does =
not split the
+virtio net header and the transport header, and the buffer consists of at =
least two
+descriptors, the device MUST start with the first descriptor to store the =
packet, and
+MUST NOT set the VIRTIO_NET_HDR_F_SPLIT_TRANSPORT_HEADER bit in \field{fla=
gs}.
+
+\drivernormative{\subparagraph}{Setting Split Transport Header}{Device Typ=
es / Network Device / Device Operation / Control Virtqueue / Split Transpor=
t Header}
+
+If the VIRTIO_NET_HDR_F_SPLIT_TRANSPORT_HEADER bit in \field{flags} is set=
, the driver
+MUST treat the contents of \field{hdr_len} as the length of the transport =
header
+inside the first descriptor.
+
+If the split transport header is enabled, the buffers submitted to receive=
q by the
+driver MUST be composed of at least two descriptors.
+When the buffer consists of two descriptors, the length of the first
+descriptor MUST be greater than the one of the virtio net header.
=20
 \paragraph{Notifications Coalescing}\label{sec:Device Types / Network Devi=
ce / Device Operation / Control Virtqueue / Notifications Coalescing}
=20
</pre>
    </blockquote>
    <pre>
If the reviewers do not have more comments on "split header v7",
then I submit an issue in the virtio-spec repository.
Please vote on whether the new "split header" feature is added
to the virtio specification.


The link is <a moz-do-not-send=3D"true" href=3D"https://github.com/oasis-tc=
s/virtio-spec/issues/144" class=3D"moz-txt-link-freetext">https://github.co=
m/oasis-tcs/virtio-spec/issues/144</a>.


Thanks.
</pre>
  </body>
</html>

--------------BYNVv1Z5AKGCO4lovvwImO17--

