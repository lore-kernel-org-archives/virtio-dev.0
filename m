Return-Path: <virtio-dev-return-9883-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id ED2819864EB
	for <virtio-dev@lists.oasis-open.org>; Fri,  2 Sep 2022 08:58:23 +0000 (UTC)
Message-ID: <94937aaa-e3c0-74fe-290c-59884c6eb9a4@linux.alibaba.com>
Date: Fri, 2 Sep 2022 16:58:16 +0800
MIME-Version: 1.0
References: <1660642495-104002-1-git-send-email-hengqi@linux.alibaba.com>
 <CACGkMEuy2m7PagJwccx3QSnasuJpnF0MtKn-1MQSJ3sPLjvjew@mail.gmail.com>
 <20220902023546-mutt-send-email-mst@kernel.org>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <20220902023546-mutt-send-email-mst@kernel.org>
Subject: [virtio-dev] Re: [PATCH v7] virtio_net: support split header
Content-Type: multipart/alternative;
 boundary="------------oeHSLkeAKef2KBw4Y0pkLMs2"
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, Jason Wang <jasowang@redhat.com>, xuanzhuo@linux.alibaba.com, kangjie.xu@linux.alibaba.com
List-ID: <virtio-dev.lists.oasis-open.org>

--------------oeHSLkeAKef2KBw4Y0pkLMs2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable


=E5=9C=A8 2022/9/2 =E4=B8=8B=E5=8D=882:41, Michael S. Tsirkin =E5=86=99=E9=
=81=93:
> On Fri, Sep 02, 2022 at 02:21:04PM +0800, Jason Wang wrote:
>> On Tue, Aug 16, 2022 at 5:35 PM Heng Qi<hengqi@linux.alibaba.com>  wrote=
:
>>> From: Xuan Zhuo<xuanzhuo@linux.alibaba.com>
>>>
>>> The purpose of this feature is to split the header and the payload of
>>> the packet.
>>>
>>> |                    receive buffer                                    =
|
>>> |                       0th descriptor             | 1th descriptor    =
|
>>> | virtnet hdr | mac | ip hdr | tcp hdr|<-- hold -->|   payload         =
|
>>>
>>> We can use a buffer plus a separate page when allocating the receive
>>> buffer. In this way, we can ensure that all payloads can be
>>> independently in a page, which is very beneficial for the zerocopy
>>> implemented by the upper layer.
>>>
>>> Signed-off-by: Xuan Zhuo<xuanzhuo@linux.alibaba.com>
>>> Signed-off-by: Heng Qi<hengqi@linux.alibaba.com>
>>> Reviewed-by: Kangjie Xu<kangjie.xu@linux.alibaba.com>
>>> ---
>>> v7:
>>>          1. Fix some presentation issues.
>>>          2. Use "split transport header". @Jason Wang
>>>          3. Clarify some paragraphs. @Cornelia Huck
>>>          4. determine the device what to do if it does not perform head=
er split on a packet.
>>>
>>> v6:
>>>          1. Fix some syntax issues. @Cornelia Huck
>>>          2. Clarify some paragraphs. @Cornelia Huck
>>>          3. Determine the device what to do if it does not perform head=
er split on a packet.
>>>
>>> v5:
>>>          1. Determine when hdr_len is credible in the process of rx
>>>          2. Clean up the use of buffers and descriptors
>>>          3. Clarify the meaning of used lenght if the first descriptor =
is skipped in the case of merge
>>>
>>> v4:
>>>          1. fix typo @Cornelia Huck @Jason Wang
>>>          2. do not split header for IP fragmentation packet. @Jason Wan=
g
>>>
>>> v3:
>>>          1. Fix some syntax issues
>>>          2. Fix some terminology issues
>>>          3. It is not unified with ip alignment, so ip alignment is not=
 included
>>>          4. Make it clear that the device must support four types, in t=
he case of successful negotiation.
>>>
>>>   conformance.tex |   2 ++
>>>   content.tex     | 102 +++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++
>>>   2 files changed, 104 insertions(+)
>>>
>>> diff --git a/conformance.tex b/conformance.tex
>>> index 2b86fc6..4e2b82e 100644
>>> --- a/conformance.tex
>>> +++ b/conformance.tex
>>> @@ -150,6 +150,7 @@ \section{Conformance Targets}\label{sec:Conformance=
 / Conformance Targets}
>>>   \item \ref{drivernormative:Device Types / Network Device / Device Ope=
ration / Control Virtqueue / Offloads State Configuration / Setting Offload=
s State}
>>>   \item \ref{drivernormative:Device Types / Network Device / Device Ope=
ration / Control Virtqueue / Receive-side scaling (RSS) }
>>>   \item \ref{drivernormative:Device Types / Network Device / Device Ope=
ration / Control Virtqueue / Notifications Coalescing}
>>> +\item \ref{drivernormative:Device Types / Network Device / Device Oper=
ation / Control Virtqueue / Split Transport Header}
>>>   \end{itemize}
>>>
>>>   \conformance{\subsection}{Block Driver Conformance}\label{sec:Conform=
ance / Driver Conformance / Block Driver Conformance}
>>> @@ -415,6 +416,7 @@ \section{Conformance Targets}\label{sec:Conformance=
 / Conformance Targets}
>>>   \item \ref{devicenormative:Device Types / Network Device / Device Ope=
ration / Control Virtqueue / Automatic receive steering in multiqueue mode}
>>>   \item \ref{devicenormative:Device Types / Network Device / Device Ope=
ration / Control Virtqueue / Receive-side scaling (RSS) / RSS processing}
>>>   \item \ref{devicenormative:Device Types / Network Device / Device Ope=
ration / Control Virtqueue / Notifications Coalescing}
>>> +\item \ref{devicenormative:Device Types / Network Device / Device Oper=
ation / Control Virtqueue / Split Transport Header}
>>>   \end{itemize}
>>>
>>>   \conformance{\subsection}{Block Device Conformance}\label{sec:Conform=
ance / Device Conformance / Block Device Conformance}
>>> diff --git a/content.tex b/content.tex
>>> index e863709..5676da9 100644
>>> --- a/content.tex
>>> +++ b/content.tex
>>> @@ -3084,6 +3084,9 @@ \subsection{Feature bits}\label{sec:Device Types =
/ Network Device / Feature bits
>>>   \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through control
>>>       channel.
>>>
>>> +\item[VIRTIO_NET_F_SPLIT_TRANSPORT_HEADER (52)] Device supports splitt=
ing
>>> +    the transport header and the payload.
>>> +
>>>   \item[VIRTIO_NET_F_NOTF_COAL(53)] Device supports notifications coale=
scing.
>>>
>>>   \item[VIRTIO_NET_F_GUEST_USO4 (54)] Driver can receive USOv4 packets.
>>> @@ -3140,6 +3143,7 @@ \subsubsection{Feature bit requirements}\label{se=
c:Device Types / Network Device
>>>   \item[VIRTIO_NET_F_NOTF_COAL] Requires VIRTIO_NET_F_CTRL_VQ.
>>>   \item[VIRTIO_NET_F_RSC_EXT] Requires VIRTIO_NET_F_HOST_TSO4 or VIRTIO=
_NET_F_HOST_TSO6.
>>>   \item[VIRTIO_NET_F_RSS] Requires VIRTIO_NET_F_CTRL_VQ.
>>> +\item[VIRTIO_NET_F_SPLIT_TRANSPORT_HEADER] Requires VIRTIO_NET_F_CTRL_=
VQ.
>>>   \end{description}
>>>
>>>   \subsubsection{Legacy Interface: Feature bits}\label{sec:Device Types=
 / Network Device / Feature bits / Legacy Interface: Feature bits}
>>> @@ -3371,6 +3375,7 @@ \subsection{Device Operation}\label{sec:Device Ty=
pes / Network Device / Device O
>>>   #define VIRTIO_NET_HDR_F_NEEDS_CSUM    1
>>>   #define VIRTIO_NET_HDR_F_DATA_VALID    2
>>>   #define VIRTIO_NET_HDR_F_RSC_INFO      4
>>> +#define VIRTIO_NET_HDR_F_SPLIT_TRANSPORT_HEADER  8
>>>           u8 flags;
>>>   #define VIRTIO_NET_HDR_GSO_NONE        0
>>>   #define VIRTIO_NET_HDR_GSO_TCPV4       1
>>> @@ -3823,6 +3828,11 @@ \subsubsection{Processing of Incoming Packets}\l=
abel{sec:Device Types / Network
>>>   been negotiated, the driver MAY use \field{hdr_len} only as a hint ab=
out the
>>>   transport header size.
>>>   The driver MUST NOT rely on \field{hdr_len} to be correct.
>>> +
>>> +If the VIRTIO_NET_HDR_F_SPLIT_TRANSPORT_HEADER bit in \field{flags} is=
 set,
>>> +the driver SHOULD treat the \field{hdr_len} as the length of the trans=
port header
>>> +inside the first descriptor.
>>> +
>>>   \begin{note}
>>>   This is due to various bugs in implementations.
>>>   \end{note}
>>> @@ -4483,6 +4493,98 @@ \subsubsection{Control Virtqueue}\label{sec:Devi=
ce Types / Network Device / Devi
>>>   according to the native endian of the guest rather than
>>>   (necessarily when not using the legacy interface) little-endian.
>>>
>>> +\paragraph{Split Transport Header}\label{sec:Device Types / Network De=
vice / Device Operation / Control Virtqueue / Split Transport Header}
>>> +
>>> +If the VIRTIO_NET_F_SPLIT_TRANSPORT_HEADER feature is negotiated,
>>> +the device supports splitting the transport header and the payload.
>>> +The transport header and the payload will be separated into different
>>> +descriptors.
>>> +
>>> +\subparagraph{Split Transport Header}\label{sec:Device Types / Network=
 Device / Device Operation / Control Virtqueue / Split Transport Header / S=
etting Split Transport Header}
>>> +
>>> +To configure the split transport header, the following layout structur=
e and definitions
>>> +are used:
>>> +
>>> +\begin{lstlisting}
>>> +struct virtio_net_split_transport_header_config {
>>> +#define VIRTIO_NET_SPLIT_TRANSPORT_HEADER_TYPE_TCP4     (1 << 0)
>>> +#define VIRTIO_NET_SPLIT_TRANSPORT_HEADER_TYPE_TCP6     (1 << 1)
>>> +#define VIRTIO_NET_SPLIT_TRANSPORT_HEADER_TYPE_UDP4     (1 << 2)
>>> +#define VIRTIO_NET_SPLIT_TRANSPORT_HEADER_TYPE_UDP6     (1 << 3)
>>> +    le64 type;
>>> +};
>>> +
>>> +#define VIRTIO_NET_CTRL_SPLIT_TRANSPORT_HEADER       6
>>> + #define VIRTIO_NET_CTRL_SPLIT_TRANSPORT_HEADER_SET   0
>>> +\end{lstlisting}
>>> +
>>> +The class VIRTIO_NET_CTRL_SPLIT_TRANSPORT_HEADER has one command:
>>> +VIRTIO_NET_CTRL_SPLIT_TRANSPORT_HEADER_SET applies the new split trans=
port header configuration.
>>> +
>>> +The driver can enable or disable split transport header for different =
protocols by
>>> +setting or clearing corresponding bits in \field{type}.
>>> +
>>> +\begin{itemize}
>>> +    \item VIRTIO_NET_SPLIT_TRANSPORT_HEADER_TYPE_TCP4: split after ipv=
4 tcp header
>>> +    \item VIRTIO_NET_SPLIT_TRANSPORT_HEADER_TYPE_TCP6: split after ipv=
6 tcp header
>>> +    \item VIRTIO_NET_SPLIT_TRANSPORT_HEADER_TYPE_UDP4: split after ipv=
4 udp header
>>> +    \item VIRTIO_NET_SPLIT_TRANSPORT_HEADER_TYPE_UDP6: split after ipv=
6 udp header
>>> +\end{itemize}
>>> +
>>> +\devicenormative{\subparagraph}{Setting Split Transport Header}{Device=
 Types / Network Device / Device Operation / Control Virtqueue / Split Tran=
sport Header}
>>> +
>>> +A device MUST initialize \field{type} to 0, and MUST set it to 0
>>> +upon device reset.
>> Nit: type is a field of the command, not something belongs to the
>> device. (though an implementation should record the types internally).
>> maybe it's better to say
>>
>> A device MUST disable header splitting upon reset and initialization?
> I don't know what that will mean, either.
>
> just what are you trying to say here?

This states that if the VIRTIO_NET_F_SPLIT_TRANSPORT_HEADER feature is nego=
tiated
and the driver does not use the VIRTIO_NET_CTRL_SPLIT_TRANSPORT_HEADER comm=
and to
tell the device which protocol types to split, the device must disable head=
er
splitting upon reset and initialization.

I will take the Jason' suggestion in the next version.

>
>>> +
>>> +If VIRTIO_NET_F_SPLIT_TRANSPORT_HEADER is negotiated, the device MUST =
support
>>> +VIRTIO_NET_SPLIT_TRANSPORT_HEADER_TYPE_TCP4, VIRTIO_NET_SPLIT_TRANSPOR=
T_HEADER_TYPE_TCP6,
>>> +VIRTIO_NET_SPLIT_TRANSPORT_HEADER_TYPE_UDP4, VIRTIO_NET_SPLIT_TRANSPOR=
T_HEADER_TYPE_UDP6.
>>> +
>>> +A device MUST NOT split the transport header if it encounters any of t=
he following cases:
>>> +\begin{itemize}
>>> +    \item the device does not recognize the protocol of the packet.
>>> +    \item the packet is an IP fragmentation.
>>> +    \item \field{type} does not include the protocol of the packet.
>> "The splitting of the specific transport protocol is not enabled via
>> VIRTIO_NET_CTRL_SPLIT_TRANSPORT_HEADER_SET?"
>>
>>> +    \item the buffer consists of only one descriptor.
>>> +    \item the total size of the virtio net header and the transport he=
ader exceeds
>>> +        the size of the first descriptor.
>>> +    \item when VIRTIO_NET_F_MRG_RXBUF is not negotiated and the size o=
f the
>>> +        payload exceeds the size of the descriptor chain starting from=
 the 2nd
>>> +        descriptor.
>>> +\end{itemize}
>>> +
>>> +If the header is split by the device, the VIRTIO_NET_HDR_F_SPLIT_TRANS=
PORT_HEADER bit
>>> +in \field{flags} MUST be set. The transport header MUST be on the firs=
t
>>> +descriptor, following the virtio net header. The payload MUST start fr=
om the
>>> +second descriptor. The device MUST set \field{hdr_len} of structure
>>> +virtio_net_hdr to the length of the transport header.
>>> +
>>> +If all of the following applies:
>>> +\begin{itemize}
>>> +    \item the header is split by the device.
>>> +    \item VIRTIO_NET_F_MRG_RXBUF has been negotiated.
>>> +    \item the received packet is spread over multiple buffers.
>>> +\end {itemize}
>>> +then if the device uses the buffers after the 1st buffer, and the buff=
er
>> "the following buffers"?
>>
>>> +consists of multiple descriptors, the device MUST skip the first descr=
iptor,
>> "skip the first descriptor of the following buffers"?
>>
>>> +because the first descriptor is used to carry the transport header.
>>> +The used length still reports the number of bytes it has written to me=
mory.
>>> +
>>> +If VIRTIO_NET_F_SPLIT_TRANSPORT_HEADER is negotiated, but the device d=
oes not split the
>>> +virtio net header and the transport header, and the buffer consists of=
 at least two
>>> +descriptors, the device MUST start with the first descriptor to store =
the packet, and
>>> +MUST NOT set the VIRTIO_NET_HDR_F_SPLIT_TRANSPORT_HEADER bit in \field=
{flags}.
>> Is this intended to describe what happens if the device doesn't split
>> the header? If yes, I wonder if it's better to just drop this.
>> (Duplicated with message framing part?)
> Jason maybe you understand what is going on here?
> The use of descriptors here in the device description just confuses
> me to the point where I don't understand what is going on.
> Devices should ever only deal with buffers and offsets
> within buffers.
>
>
When VIRTIO_NET_F_SPLIT_TRANSPORT_HEADER is negotiated,
the driver requires that the buffers submitted to receiveq
MUST be composed of at least two descriptors,
which means that each buffer the device gets is a descriptor chain,
even if the device does not split the header for some packets.

To store packet in the descriptor chain without header splitting
by the device, the device MUST start with the first descriptor of
the descriptor chain to store the packet, and MUST NOT set the
VIRTIO_NET_HDR_F_SPLIT_TRANSPORT_HEADER bit in \field{flags}.

Thanks.

>>> +
>>> +\drivernormative{\subparagraph}{Setting Split Transport Header}{Device=
 Types / Network Device / Device Operation / Control Virtqueue / Split Tran=
sport Header}
>>> +
>>> +If the VIRTIO_NET_HDR_F_SPLIT_TRANSPORT_HEADER bit in \field{flags} is=
 set, the driver
>>> +MUST treat the contents of \field{hdr_len} as the length of the transp=
ort header
>> I'd change "MUST" to "SHOULD" as the driver needs to validate the
>> hdr_len before trying to use it.
>>
>>> +inside the first descriptor.
>>> +
>>> +If the split transport header is enabled, the buffers submitted to rec=
eiveq by the
>>> +driver MUST be composed of at least two descriptors.
>>> +When the buffer consists of two descriptors, the length of the first
>>> +descriptor MUST be greater than the one of the virtio net header.
>> Similarly, should we use "SHOULD" here. Or maybe we can see, if the
>> driver want the device to split the header, it MUST ....
>>
>> Thanks
>>
>>>   \paragraph{Notifications Coalescing}\label{sec:Device Types / Network=
 Device / Device Operation / Control Virtqueue / Notifications Coalescing}
>>>
>>> --
>>> 1.8.3.1
>>>
--------------oeHSLkeAKef2KBw4Y0pkLMs2
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DUTF-8=
">
  </head>
  <body>
    <p><br>
    </p>
    <div class=3D"moz-cite-prefix">=E5=9C=A8 2022/9/2 =E4=B8=8B=E5=8D=882:4=
1, Michael S. Tsirkin
      =E5=86=99=E9=81=93:<br>
    </div>
    <blockquote type=3D"cite"
      cite=3D"mid:20220902023546-mutt-send-email-mst@kernel.org">
      <pre class=3D"moz-quote-pre" wrap=3D"">On Fri, Sep 02, 2022 at 02:21:=
04PM +0800, Jason Wang wrote:
</pre>
      <blockquote type=3D"cite">
        <pre class=3D"moz-quote-pre" wrap=3D"">On Tue, Aug 16, 2022 at 5:35=
 PM Heng Qi <a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:hengqi@linux.=
alibaba.com">&lt;hengqi@linux.alibaba.com&gt;</a> wrote:
</pre>
        <blockquote type=3D"cite">
          <pre class=3D"moz-quote-pre" wrap=3D"">
From: Xuan Zhuo <a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:xuanzhuo@=
linux.alibaba.com">&lt;xuanzhuo@linux.alibaba.com&gt;</a>

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
        1. Fix some presentation issues.
        2. Use "split transport header". @Jason Wang
        3. Clarify some paragraphs. @Cornelia Huck
        4. determine the device what to do if it does not perform header sp=
lit on a packet.

v6:
        1. Fix some syntax issues. @Cornelia Huck
        2. Clarify some paragraphs. @Cornelia Huck
        3. Determine the device what to do if it does not perform header sp=
lit on a packet.

v5:
        1. Determine when hdr_len is credible in the process of rx
        2. Clean up the use of buffers and descriptors
        3. Clarify the meaning of used lenght if the first descriptor is sk=
ipped in the case of merge

v4:
        1. fix typo @Cornelia Huck @Jason Wang
        2. do not split header for IP fragmentation packet. @Jason Wang

v3:
        1. Fix some syntax issues
        2. Fix some terminology issues
        3. It is not unified with ip alignment, so ip alignment is not incl=
uded
        4. Make it clear that the device must support four types, in the ca=
se of successful negotiation.

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

+\item[VIRTIO_NET_F_SPLIT_TRANSPORT_HEADER (52)] Device supports splitting
+    the transport header and the payload.
+
 \item[VIRTIO_NET_F_NOTF_COAL(53)] Device supports notifications coalescing=
.

 \item[VIRTIO_NET_F_GUEST_USO4 (54)] Driver can receive USOv4 packets.
@@ -3140,6 +3143,7 @@ \subsubsection{Feature bit requirements}\label{sec:De=
vice Types / Network Device
 \item[VIRTIO_NET_F_NOTF_COAL] Requires VIRTIO_NET_F_CTRL_VQ.
 \item[VIRTIO_NET_F_RSC_EXT] Requires VIRTIO_NET_F_HOST_TSO4 or VIRTIO_NET_=
F_HOST_TSO6.
 \item[VIRTIO_NET_F_RSS] Requires VIRTIO_NET_F_CTRL_VQ.
+\item[VIRTIO_NET_F_SPLIT_TRANSPORT_HEADER] Requires VIRTIO_NET_F_CTRL_VQ.
 \end{description}

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
</pre>
        </blockquote>
        <pre class=3D"moz-quote-pre" wrap=3D"">
Nit: type is a field of the command, not something belongs to the
device. (though an implementation should record the types internally).
maybe it's better to say

A device MUST disable header splitting upon reset and initialization?
</pre>
      </blockquote>
      <pre class=3D"moz-quote-pre" wrap=3D"">
I don't know what that will mean, either.

just what are you trying to say here?</pre>
    </blockquote>
    <pre>
This states that if the VIRTIO_NET_F_SPLIT_TRANSPORT_HEADER feature is nego=
tiated
and the driver does not use the VIRTIO_NET_CTRL_SPLIT_TRANSPORT_HEADER comm=
and to
tell the device which protocol types to split, the device must disable head=
er
splitting upon reset and initialization.

I will take the Jason' suggestion in the next version.

</pre>
    <blockquote type=3D"cite"
      cite=3D"mid:20220902023546-mutt-send-email-mst@kernel.org">
      <pre class=3D"moz-quote-pre" wrap=3D"">

</pre>
      <blockquote type=3D"cite">
        <blockquote type=3D"cite">
          <pre class=3D"moz-quote-pre" wrap=3D"">+
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
</pre>
        </blockquote>
        <pre class=3D"moz-quote-pre" wrap=3D"">
"The splitting of the specific transport protocol is not enabled via
VIRTIO_NET_CTRL_SPLIT_TRANSPORT_HEADER_SET?"

</pre>
        <blockquote type=3D"cite">
          <pre class=3D"moz-quote-pre" wrap=3D"">+    \item the buffer cons=
ists of only one descriptor.
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
</pre>
        </blockquote>
        <pre class=3D"moz-quote-pre" wrap=3D"">
"the following buffers"?

</pre>
        <blockquote type=3D"cite">
          <pre class=3D"moz-quote-pre" wrap=3D"">+consists of multiple desc=
riptors, the device MUST skip the first descriptor,
</pre>
        </blockquote>
        <pre class=3D"moz-quote-pre" wrap=3D"">
"skip the first descriptor of the following buffers"?

</pre>
        <blockquote type=3D"cite">
          <pre class=3D"moz-quote-pre" wrap=3D"">+because the first descrip=
tor is used to carry the transport header.
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
</pre>
        </blockquote>
        <pre class=3D"moz-quote-pre" wrap=3D"">
Is this intended to describe what happens if the device doesn't split
the header? If yes, I wonder if it's better to just drop this.
(Duplicated with message framing part?)
</pre>
      </blockquote>
      <pre class=3D"moz-quote-pre" wrap=3D"">
Jason maybe you understand what is going on here?
The use of descriptors here in the device description just confuses
me to the point where I don't understand what is going on.
Devices should ever only deal with buffers and offsets
within buffers.


</pre>
    </blockquote>
    <pre>
When VIRTIO_NET_F_SPLIT_TRANSPORT_HEADER is negotiated,
the driver requires that the buffers submitted to receiveq
MUST be composed of at least two descriptors,
which means that each buffer the device gets is a descriptor chain,
even if the device does not split the header for some packets.

To store packet in the descriptor chain without header splitting
by the device, the device MUST start with the first descriptor of
the descriptor chain to store the packet, and MUST NOT set the
VIRTIO_NET_HDR_F_SPLIT_TRANSPORT_HEADER bit in \field{flags}.

Thanks.

</pre>
    <blockquote type=3D"cite"
      cite=3D"mid:20220902023546-mutt-send-email-mst@kernel.org">
      <pre class=3D"moz-quote-pre" wrap=3D"">
</pre>
      <blockquote type=3D"cite">
        <pre class=3D"moz-quote-pre" wrap=3D"">
</pre>
        <blockquote type=3D"cite">
          <pre class=3D"moz-quote-pre" wrap=3D"">+
+\drivernormative{\subparagraph}{Setting Split Transport Header}{Device Typ=
es / Network Device / Device Operation / Control Virtqueue / Split Transpor=
t Header}
+
+If the VIRTIO_NET_HDR_F_SPLIT_TRANSPORT_HEADER bit in \field{flags} is set=
, the driver
+MUST treat the contents of \field{hdr_len} as the length of the transport =
header
</pre>
        </blockquote>
        <pre class=3D"moz-quote-pre" wrap=3D"">
I'd change "MUST" to "SHOULD" as the driver needs to validate the
hdr_len before trying to use it.

</pre>
        <blockquote type=3D"cite">
          <pre class=3D"moz-quote-pre" wrap=3D"">+inside the first descript=
or.
+
+If the split transport header is enabled, the buffers submitted to receive=
q by the
+driver MUST be composed of at least two descriptors.
+When the buffer consists of two descriptors, the length of the first
+descriptor MUST be greater than the one of the virtio net header.
</pre>
        </blockquote>
        <pre class=3D"moz-quote-pre" wrap=3D"">
Similarly, should we use "SHOULD" here. Or maybe we can see, if the
driver want the device to split the header, it MUST ....

Thanks

</pre>
        <blockquote type=3D"cite">
          <pre class=3D"moz-quote-pre" wrap=3D"">
 \paragraph{Notifications Coalescing}\label{sec:Device Types / Network Devi=
ce / Device Operation / Control Virtqueue / Notifications Coalescing}

--
1.8.3.1

</pre>
        </blockquote>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------oeHSLkeAKef2KBw4Y0pkLMs2--

