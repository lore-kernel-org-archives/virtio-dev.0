Return-Path: <virtio-dev-return-9698-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1AB4698658D
	for <virtio-dev@lists.oasis-open.org>; Thu,  4 Aug 2022 13:01:38 +0000 (UTC)
Message-ID: <8ab46a3e-8f00-e05f-0dca-d0009164aa16@linux.alibaba.com>
Date: Thu, 4 Aug 2022 21:01:30 +0800
MIME-Version: 1.0
References: <1659337182-128890-1-git-send-email-hengqi@linux.alibaba.com>
 <CACGkMEsmCnj3WqG6QkHYFH3JOvhucQ03ftax4Yow6O74QnvsVg@mail.gmail.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <CACGkMEsmCnj3WqG6QkHYFH3JOvhucQ03ftax4Yow6O74QnvsVg@mail.gmail.com>
Subject: Re: [virtio-dev] Re: [PATCH] virtio_net: support split header
Content-Type: multipart/alternative;
 boundary="------------LMboU8VrTiCv7sda5Y08kAjE"
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, kangjie.xu@linux.alibaba.com, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

--------------LMboU8VrTiCv7sda5Y08kAjE
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable


=E5=9C=A8 2022/8/4 =E4=B8=8B=E5=8D=882:27, Jason Wang =E5=86=99=E9=81=93:
> On Mon, Aug 1, 2022 at 2:59 PM Heng Qi<hengqi@linux.alibaba.com>  wrote:
>> From: Xuan Zhuo<xuanzhuo@linux.alibaba.com>
>>
>> The purpose of this feature is to split the header and the payload of
>> the packet.
>>
>> |                    receive buffer                                    |
>> |                       0th descriptor             | 1th descriptor    |
>> | virtnet hdr | mac | ip hdr | tcp hdr|<-- hold -->|   payload         |
>>
>> We can use a buffer plus a separate page when allocating the receive
>> buffer. In this way, we can ensure that all payloads can be
>> independently in a page, which is very beneficial for the zerocopy
>> implemented by the upper layer.
>>
>> Signed-off-by: Xuan Zhuo<xuanzhuo@linux.alibaba.com>
>> Signed-off-by: Heng Qi<hengqi@linux.alibaba.com>
>> Reviewed-by: Kangjie Xu<kangjie.xu@linux.alibaba.com>
>> ---
>>
>> v6:
>>      1. Fix some syntax issues. @Cornelia Huck
>>      2. Clarify some paragraphs. @Cornelia Huck
>>      3. Determine the device what to do if it does not perform header sp=
lit on a packet.
>>
>> v5:
>>      1. Determine when hdr_len is credible in the process of rx
>>      2. Clean up the use of buffers and descriptors
>>      3. Clarify the meaning of used lenght if the first descriptor is sk=
ipped in the case of merge
>>
>> v4:
>>      1. fix typo @Cornelia Huck @Jason Wang
>>      2. do not split header for IP fragmentation packet. @Jason Wang
>>
>> v3:
>>      1. Fix some syntax issues
>>      2. Fix some terminology issues
>>      3. It is not unified with ip alignment, so ip alignment is not incl=
uded
>>      4. Make it clear that the device must support four types, in the ca=
se of
>>      successful negotiation.
>>
>>   conformance.tex |   2 +
>>   content.tex     | 111 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++++--
>>   2 files changed, 109 insertions(+), 4 deletions(-)
>>
>> diff --git a/conformance.tex b/conformance.tex
>> index 2b86fc6..bd0f463 100644
>> --- a/conformance.tex
>> +++ b/conformance.tex
>> @@ -150,6 +150,7 @@ \section{Conformance Targets}\label{sec:Conformance =
/ Conformance Targets}
>>   \item \ref{drivernormative:Device Types / Network Device / Device Oper=
ation / Control Virtqueue / Offloads State Configuration / Setting Offloads=
 State}
>>   \item \ref{drivernormative:Device Types / Network Device / Device Oper=
ation / Control Virtqueue / Receive-side scaling (RSS) }
>>   \item \ref{drivernormative:Device Types / Network Device / Device Oper=
ation / Control Virtqueue / Notifications Coalescing}
>> +\item \ref{drivernormative:Device Types / Network Device / Device Opera=
tion / Control Virtqueue / Split Header}
>>   \end{itemize}
>>
>>   \conformance{\subsection}{Block Driver Conformance}\label{sec:Conforma=
nce / Driver Conformance / Block Driver Conformance}
>> @@ -415,6 +416,7 @@ \section{Conformance Targets}\label{sec:Conformance =
/ Conformance Targets}
>>   \item \ref{devicenormative:Device Types / Network Device / Device Oper=
ation / Control Virtqueue / Automatic receive steering in multiqueue mode}
>>   \item \ref{devicenormative:Device Types / Network Device / Device Oper=
ation / Control Virtqueue / Receive-side scaling (RSS) / RSS processing}
>>   \item \ref{devicenormative:Device Types / Network Device / Device Oper=
ation / Control Virtqueue / Notifications Coalescing}
>> +\item \ref{devicenormative:Device Types / Network Device / Device Opera=
tion / Control Virtqueue / Split Header}
>>   \end{itemize}
>>
>>   \conformance{\subsection}{Block Device Conformance}\label{sec:Conforma=
nce / Device Conformance / Block Device Conformance}
>> diff --git a/content.tex b/content.tex
>> index e863709..74c36fe 100644
>> --- a/content.tex
>> +++ b/content.tex
>> @@ -3084,6 +3084,9 @@ \subsection{Feature bits}\label{sec:Device Types /=
 Network Device / Feature bits
>>   \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through control
>>       channel.
>>
>> +\item[VIRTIO_NET_F_SPLIT_HEADER (52)] Device supports splitting the pro=
tocol
>> +    header and the payload.
>> +
>>   \item[VIRTIO_NET_F_NOTF_COAL(53)] Device supports notifications coales=
cing.
>>
>>   \item[VIRTIO_NET_F_GUEST_USO4 (54)] Driver can receive USOv4 packets.
>> @@ -3140,6 +3143,7 @@ \subsubsection{Feature bit requirements}\label{sec=
:Device Types / Network Device
>>   \item[VIRTIO_NET_F_NOTF_COAL] Requires VIRTIO_NET_F_CTRL_VQ.
>>   \item[VIRTIO_NET_F_RSC_EXT] Requires VIRTIO_NET_F_HOST_TSO4 or VIRTIO_=
NET_F_HOST_TSO6.
>>   \item[VIRTIO_NET_F_RSS] Requires VIRTIO_NET_F_CTRL_VQ.
>> +\item[VIRTIO_NET_F_SPLIT_HEADER] Requires VIRTIO_NET_F_CTRL_VQ.
>>   \end{description}
>>
>>   \subsubsection{Legacy Interface: Feature bits}\label{sec:Device Types =
/ Network Device / Feature bits / Legacy Interface: Feature bits}
>> @@ -3371,6 +3375,7 @@ \subsection{Device Operation}\label{sec:Device Typ=
es / Network Device / Device O
>>   #define VIRTIO_NET_HDR_F_NEEDS_CSUM    1
>>   #define VIRTIO_NET_HDR_F_DATA_VALID    2
>>   #define VIRTIO_NET_HDR_F_RSC_INFO      4
>> +#define VIRTIO_NET_HDR_F_SPLIT_HEADER  8
>>           u8 flags;
>>   #define VIRTIO_NET_HDR_GSO_NONE        0
>>   #define VIRTIO_NET_HDR_GSO_TCPV4       1
>> @@ -3799,9 +3804,10 @@ \subsubsection{Processing of Incoming Packets}\la=
bel{sec:Device Types / Network
>>   not set VIRTIO_NET_HDR_F_RSC_INFO bit in \field{flags}.
>>
>>   If one of the VIRTIO_NET_F_GUEST_TSO4, TSO6, UFO, USO4 or USO6 options=
 have
>> -been negotiated, the device SHOULD set \field{hdr_len} to a value
>> +been negotiated and the VIRTIO_NET_HDR_F_SPLIT_HEADER bit in \field{fla=
gs}
>> +is not set, the device SHOULD set \field{hdr_len} to a value
>>   not less than the length of the headers, including the transport
>> -header.
>> +header \ref{sec:Device Types / Network Device / Device Operation / Cont=
rol Virtqueue / Split Header / Setting Split Header}.
>>
>>   If the VIRTIO_NET_F_GUEST_CSUM feature has been negotiated, the
>>   device MAY set the VIRTIO_NET_HDR_F_DATA_VALID bit in
>> @@ -3820,9 +3826,13 @@ \subsubsection{Processing of Incoming Packets}\la=
bel{sec:Device Types / Network
>>   driver MUST NOT use the \field{csum_start} and \field{csum_offset}.
>>
>>   If one of the VIRTIO_NET_F_GUEST_TSO4, TSO6, UFO, USO4 or USO6 options=
 have
>> -been negotiated, the driver MAY use \field{hdr_len} only as a hint abou=
t the
>> +been negotiated and the VIRTIO_NET_HDR_F_SPLIT_HEADER bit in \field{fla=
gs}
>> +is not set, the driver MAY use \field{hdr_len} only as a hint about the
>>   transport header size.
>> -The driver MUST NOT rely on \field{hdr_len} to be correct.
>> +
>> +If the VIRTIO_NET_HDR_F_SPLIT_HEADER bit in \field{flags} is not set, t=
he driver
>> +MUST NOT rely on \field{hdr_len} to be correct.
> I think we should keep the above description as-is. For whatever case,
> the driver must not trust the metadata set by the device and must
> perform necessary sanity tests on them.


My idea is to keep the current description as it is,
but to emphasize in the next version:
"If the VIRTIO_NET_HDR_F_SPLIT_HEADER bit in \field{flags} is set,
the driver MAY treat the \field{hdr_len} as the length of the
protocol header inside the first descriptor."


>
>> +
>>   \begin{note}
>>   This is due to various bugs in implementations.
>>   \end{note}
>> @@ -4483,6 +4493,99 @@ \subsubsection{Control Virtqueue}\label{sec:Devic=
e Types / Network Device / Devi
>>   according to the native endian of the guest rather than
>>   (necessarily when not using the legacy interface) little-endian.
>>
>> +\paragraph{Split Header}\label{sec:Device Types / Network Device / Devi=
ce Operation / Control Virtqueue / Split Header}
>> +
>> +If the VIRTIO_NET_F_SPLIT_HEADER feature is negotiated,
>> +the device supports splitting the protocol header and the payload.
>> +The protocol header and the payload will be separated into different
>> +descriptors.
>> +
>> +\subparagraph{Split Header}\label{sec:Device Types / Network Device / D=
evice Operation / Control Virtqueue / Split Header / Setting Split Header}
>> +
>> +To configure the split header, the following layout structure and defin=
itions
>> +are used:
>> +
>> +\begin{lstlisting}
>> +struct virtio_net_split_header_config {
>> +#define VIRTIO_NET_SPLIT_HEADER_TYPE_TCP4     (1 << 0)
>> +#define VIRTIO_NET_SPLIT_HEADER_TYPE_TCP6     (1 << 1)
>> +#define VIRTIO_NET_SPLIT_HEADER_TYPE_UDP4     (1 << 2)
>> +#define VIRTIO_NET_SPLIT_HEADER_TYPE_UDP6     (1 << 3)
>> +    le64 type;
>> +};
>> +
>> +#define VIRTIO_NET_CTRL_SPLIT_HEADER       6
>> + #define VIRTIO_NET_CTRL_SPLIT_HEADER_SET   0
>> +\end{lstlisting}
>> +
>> +The class VIRTIO_NET_CTRL_SPLIT_HEADER has one command:
>> +VIRTIO_NET_CTRL_SPLIT_HEADER_SET applies the new split header configura=
tion.
>> +
>> +The driver can enable or disable split header for different protocols b=
y
>> +setting or clearing corresponding bits in \field{type}.
>> +
>> +\begin{itemize}
>> +    \item VIRTIO_NET_SPLIT_HEADER_TYPE_TCP4: split after ipv4 tcp heade=
r
>> +    \item VIRTIO_NET_SPLIT_HEADER_TYPE_TCP6: split after ipv6 tcp heade=
r
>> +    \item VIRTIO_NET_SPLIT_HEADER_TYPE_UDP4: split after ipv4 udp heade=
r
>> +    \item VIRTIO_NET_SPLIT_HEADER_TYPE_UDP6: split after ipv6 udp heade=
r
>> +\end{itemize}
>> +
>> +\devicenormative{\subparagraph}{Setting Split Header}{Device Types / Ne=
twork Device / Device Operation / Control Virtqueue / Split Header}
>> +
>> +A device MUST initialize \field{type} to 0, and MUST set it to 0
>> +upon device reset.
>> +
>> +If VIRTIO_NET_F_SPLIT_HEADER is negotiated, the device MUST support
>> +VIRTIO_NET_SPLIT_HEADER_TYPE_TCP4, VIRTIO_NET_SPLIT_HEADER_TYPE_TCP6,
>> +VIRTIO_NET_SPLIT_HEADER_TYPE_UDP4, VIRTIO_NET_SPLIT_HEADER_TYPE_UDP6.
>> +
>> +A device MUST NOT split the header if it encounters any of the followin=
g cases:
>> +\begin{itemize}
>> +    \item the device does not recognize the protocol of the packet.
>> +    \item the packet is an IP fragmentation.
>> +    \item \field{type} does not include the protocol of the packet.
>> +    \item the buffer consists of only one descriptor.
>> +    \item the total size of the virtio net header and the protocol head=
er exceeds
>> +        the size of the first descriptor.
>> +    \item when VIRTIO_NET_F_MRG_RXBUF is not negotiated and the size of=
 the
>> +        payload exceeds the size of the descriptor chain starting from =
the 2nd
>> +        descriptor.
> When MRG_RXBUF is negotiated, what if the rest of the buffers don't
> fit for the payload?

When VIRTIO_NET_F_SPLIT_HEADER is not negotiated, the device will also face
this situation, and we keep the same as the previous processing logic.

>> +\end{itemize}
>> +
>> +If the header is split by the device, the VIRTIO_NET_HDR_F_SPLIT_HEADER=
 bit
>> +in \field{flags} MUST be set. The protocol header MUST be on the first
>> +descriptor, following the virtio net header. The payload MUST start fro=
m the
>> +second descriptor. The device MUST set \field{hdr_len} of structure
>> +virtio_net_hdr to the length of the protocol header.
>> +
>> +If all of the following applies:
>> +\begin{itemize}
>> +    \item the header is split by the device.
>> +    \item VIRTIO_NET_F_MRG_RXBUF has been negotiated.
>> +    \item the received packet is spread over multiple buffers.
>> +\end {itemize}
>> +then if the device uses the buffers after the 1st buffer, and the buffe=
r
>> +consists of multiple descriptors, the device MUST skip the first descri=
ptor,
>> +because the first descriptor is used to carry the protocol header.
>> +The used length still reports the number of bytes it has written to mem=
ory.
> Does this mean, in order to get best performance, driver needs to
> prepare buffer like
>
> [small descriptor for header] + [large descriptor for payload] ?

Yes, that's it.

>> +
>> +If VIRTIO_NET_F_SPLIT_HEADER is negotiated, but the device does not spl=
it the header
>> +and the buffer consists of at least two descriptors, the device MUST pu=
t the virtio net header
>> +in the first descriptor, and MUST NOT set the VIRTIO_NET_HDR_F_SPLIT_HE=
ADER bit in \field{flags}.
>> +The device MUST use the second descriptor to store the packet, since th=
e first descriptor
>> +is designed to accommodate the header and is tiny for the packet.
> Which header did you mean here, is it the protocol header or the vnet hea=
der?
>
> Btw I don't get why we need this, maybe you can give an example for this?

"the header" means the virtio net header and the protocol header.


Why does virtio net header MUST be placed in the first descriptor by the de=
vice?

When VIRTIO_NET_F_SPLIT_HEADER is negotiated and the packet received by
the driver consists of at least 2 descriptors, the driver MUST use the firs=
t
descriptor in order to determine whether the packet is header-splitted by t=
he device.
Otherwise, if virtio net header is placed on the second descriptor, but the=
 packet has been
header-splitted by the device, such processing is unreasonable.


Why does the device MUST skip the first descriptor and use the second
descriptor to store the packet?

There are three points in total.

1. the semantic of the first descriptor:

When VIRTIO_NET_F_SPLIT_HEADER is negotiated, the first descriptor
is designed to store the virtio net header and the protocol header. If the =
first
descriptor stores the data of the packet at this time, then the semantic of=
 the first
descriptor has changed.

2. the performance of the driver while receiving the packets.

First, it is worth noting that the size of the first descriptor is small.

Second, imagine a situation where if a packet is exactly one byte larger th=
an the size
of the first descriptor, and the device stores the packet starting from
the first descriptor,the packet will be placed on two descriptors, but thes=
e two descriptors
not continuous in physical addresses, which will affect the performance of =
the driver when
receiving packets.

3. compatibility of driver's receiving packet logic:

If the device stores the packet in the second descriptor, the
driver's existing packet receiving logic is minimally affected.

>> +
>> +\drivernormative{\subparagraph}{Setting Split Header}{Device Types / Ne=
twork Device / Device Operation / Control Virtqueue / Split Header}
>> +
>> +If the VIRTIO_NET_HDR_F_SPLIT_HEADER bit in \field{flags} is set, the d=
river
>> +MUST treat the contents of \field{hdr_len} as the length of the protoco=
l header
>> +inside the first descriptor.
> Not sure MUST is appropriate here, driver needs to validate the hdr_len a=
nyhow.

I will use "SHOULD" instead of "MUST".

>> +
>> +If the split header is enabled, the buffers submitted to receiveq by th=
e
>> +driver SHOULD be composed of at least two descriptors.
> It looks to me the "SHOULD" here is somehow conflict with the previous
> description about when the device can't perform a split.
>
I will use "MUST" instead of "SHOULD".

>> +When the buffer consists of two descriptors, the length of the first
>> +descriptor MUST be greater than the one of the virtio net header.
> So I think we'd better have guidance on how to achieve the best
> performance and move the above there instead of using the normatives.
>
Will fix.

I will fix these in the next version.

Thanks.


--------------LMboU8VrTiCv7sda5Y08kAjE
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DUTF-8=
">
  </head>
  <body>
    <p><br>
    </p>
    <div class=3D"moz-cite-prefix">=E5=9C=A8 2022/8/4 =E4=B8=8B=E5=8D=882:2=
7, Jason Wang =E5=86=99=E9=81=93:<br>
    </div>
    <blockquote type=3D"cite"
cite=3D"mid:CACGkMEsmCnj3WqG6QkHYFH3JOvhucQ03ftax4Yow6O74QnvsVg@mail.gmail.=
com">
      <pre class=3D"moz-quote-pre" wrap=3D"">On Mon, Aug 1, 2022 at 2:59 PM=
 Heng Qi <a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:hengqi@linux.ali=
baba.com">&lt;hengqi@linux.alibaba.com&gt;</a> wrote:
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

v6:
    1. Fix some syntax issues. @Cornelia Huck
    2. Clarify some paragraphs. @Cornelia Huck
    3. Determine the device what to do if it does not perform header split =
on a packet.

v5:
    1. Determine when hdr_len is credible in the process of rx
    2. Clean up the use of buffers and descriptors
    3. Clarify the meaning of used lenght if the first descriptor is skippe=
d in the case of merge

v4:
    1. fix typo @Cornelia Huck @Jason Wang
    2. do not split header for IP fragmentation packet. @Jason Wang

v3:
    1. Fix some syntax issues
    2. Fix some terminology issues
    3. It is not unified with ip alignment, so ip alignment is not included
    4. Make it clear that the device must support four types, in the case o=
f
    successful negotiation.

 conformance.tex |   2 +
 content.tex     | 111 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
++--
 2 files changed, 109 insertions(+), 4 deletions(-)

diff --git a/conformance.tex b/conformance.tex
index 2b86fc6..bd0f463 100644
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
n / Control Virtqueue / Split Header}
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
n / Control Virtqueue / Split Header}
 \end{itemize}

 \conformance{\subsection}{Block Device Conformance}\label{sec:Conformance =
/ Device Conformance / Block Device Conformance}
diff --git a/content.tex b/content.tex
index e863709..74c36fe 100644
--- a/content.tex
+++ b/content.tex
@@ -3084,6 +3084,9 @@ \subsection{Feature bits}\label{sec:Device Types / Ne=
twork Device / Feature bits
 \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through control
     channel.

+\item[VIRTIO_NET_F_SPLIT_HEADER (52)] Device supports splitting the protoc=
ol
+    header and the payload.
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
+\item[VIRTIO_NET_F_SPLIT_HEADER] Requires VIRTIO_NET_F_CTRL_VQ.
 \end{description}

 \subsubsection{Legacy Interface: Feature bits}\label{sec:Device Types / Ne=
twork Device / Feature bits / Legacy Interface: Feature bits}
@@ -3371,6 +3375,7 @@ \subsection{Device Operation}\label{sec:Device Types =
/ Network Device / Device O
 #define VIRTIO_NET_HDR_F_NEEDS_CSUM    1
 #define VIRTIO_NET_HDR_F_DATA_VALID    2
 #define VIRTIO_NET_HDR_F_RSC_INFO      4
+#define VIRTIO_NET_HDR_F_SPLIT_HEADER  8
         u8 flags;
 #define VIRTIO_NET_HDR_GSO_NONE        0
 #define VIRTIO_NET_HDR_GSO_TCPV4       1
@@ -3799,9 +3804,10 @@ \subsubsection{Processing of Incoming Packets}\label=
{sec:Device Types / Network
 not set VIRTIO_NET_HDR_F_RSC_INFO bit in \field{flags}.

 If one of the VIRTIO_NET_F_GUEST_TSO4, TSO6, UFO, USO4 or USO6 options hav=
e
-been negotiated, the device SHOULD set \field{hdr_len} to a value
+been negotiated and the VIRTIO_NET_HDR_F_SPLIT_HEADER bit in \field{flags}
+is not set, the device SHOULD set \field{hdr_len} to a value
 not less than the length of the headers, including the transport
-header.
+header \ref{sec:Device Types / Network Device / Device Operation / Control=
 Virtqueue / Split Header / Setting Split Header}.

 If the VIRTIO_NET_F_GUEST_CSUM feature has been negotiated, the
 device MAY set the VIRTIO_NET_HDR_F_DATA_VALID bit in
@@ -3820,9 +3826,13 @@ \subsubsection{Processing of Incoming Packets}\label=
{sec:Device Types / Network
 driver MUST NOT use the \field{csum_start} and \field{csum_offset}.

 If one of the VIRTIO_NET_F_GUEST_TSO4, TSO6, UFO, USO4 or USO6 options hav=
e
-been negotiated, the driver MAY use \field{hdr_len} only as a hint about t=
he
+been negotiated and the VIRTIO_NET_HDR_F_SPLIT_HEADER bit in \field{flags}
+is not set, the driver MAY use \field{hdr_len} only as a hint about the
 transport header size.
-The driver MUST NOT rely on \field{hdr_len} to be correct.
+
+If the VIRTIO_NET_HDR_F_SPLIT_HEADER bit in \field{flags} is not set, the =
driver
+MUST NOT rely on \field{hdr_len} to be correct.
</pre>
      </blockquote>
      <pre class=3D"moz-quote-pre" wrap=3D"">
I think we should keep the above description as-is. For whatever case,
the driver must not trust the metadata set by the device and must
perform necessary sanity tests on them.</pre>
    </blockquote>
    <p><br>
    </p>
    <pre>My idea is to keep the current description as it is,
but to emphasize in the next version:
"If the VIRTIO_NET_HDR_F_SPLIT_HEADER bit in \field{flags} is set,
the driver MAY treat the \field{hdr_len} as the length of the
protocol header inside the first descriptor."
</pre>
    <p><br>
    </p>
    <blockquote type=3D"cite"
cite=3D"mid:CACGkMEsmCnj3WqG6QkHYFH3JOvhucQ03ftax4Yow6O74QnvsVg@mail.gmail.=
com">
      <pre class=3D"moz-quote-pre" wrap=3D"">

</pre>
      <blockquote type=3D"cite">
        <pre class=3D"moz-quote-pre" wrap=3D"">+
 \begin{note}
 This is due to various bugs in implementations.
 \end{note}
@@ -4483,6 +4493,99 @@ \subsubsection{Control Virtqueue}\label{sec:Device T=
ypes / Network Device / Devi
 according to the native endian of the guest rather than
 (necessarily when not using the legacy interface) little-endian.

+\paragraph{Split Header}\label{sec:Device Types / Network Device / Device =
Operation / Control Virtqueue / Split Header}
+
+If the VIRTIO_NET_F_SPLIT_HEADER feature is negotiated,
+the device supports splitting the protocol header and the payload.
+The protocol header and the payload will be separated into different
+descriptors.
+
+\subparagraph{Split Header}\label{sec:Device Types / Network Device / Devi=
ce Operation / Control Virtqueue / Split Header / Setting Split Header}
+
+To configure the split header, the following layout structure and definiti=
ons
+are used:
+
+\begin{lstlisting}
+struct virtio_net_split_header_config {
+#define VIRTIO_NET_SPLIT_HEADER_TYPE_TCP4     (1 &lt;&lt; 0)
+#define VIRTIO_NET_SPLIT_HEADER_TYPE_TCP6     (1 &lt;&lt; 1)
+#define VIRTIO_NET_SPLIT_HEADER_TYPE_UDP4     (1 &lt;&lt; 2)
+#define VIRTIO_NET_SPLIT_HEADER_TYPE_UDP6     (1 &lt;&lt; 3)
+    le64 type;
+};
+
+#define VIRTIO_NET_CTRL_SPLIT_HEADER       6
+ #define VIRTIO_NET_CTRL_SPLIT_HEADER_SET   0
+\end{lstlisting}
+
+The class VIRTIO_NET_CTRL_SPLIT_HEADER has one command:
+VIRTIO_NET_CTRL_SPLIT_HEADER_SET applies the new split header configuratio=
n.
+
+The driver can enable or disable split header for different protocols by
+setting or clearing corresponding bits in \field{type}.
+
+\begin{itemize}
+    \item VIRTIO_NET_SPLIT_HEADER_TYPE_TCP4: split after ipv4 tcp header
+    \item VIRTIO_NET_SPLIT_HEADER_TYPE_TCP6: split after ipv6 tcp header
+    \item VIRTIO_NET_SPLIT_HEADER_TYPE_UDP4: split after ipv4 udp header
+    \item VIRTIO_NET_SPLIT_HEADER_TYPE_UDP6: split after ipv6 udp header
+\end{itemize}
+
+\devicenormative{\subparagraph}{Setting Split Header}{Device Types / Netwo=
rk Device / Device Operation / Control Virtqueue / Split Header}
+
+A device MUST initialize \field{type} to 0, and MUST set it to 0
+upon device reset.
+
+If VIRTIO_NET_F_SPLIT_HEADER is negotiated, the device MUST support
+VIRTIO_NET_SPLIT_HEADER_TYPE_TCP4, VIRTIO_NET_SPLIT_HEADER_TYPE_TCP6,
+VIRTIO_NET_SPLIT_HEADER_TYPE_UDP4, VIRTIO_NET_SPLIT_HEADER_TYPE_UDP6.
+
+A device MUST NOT split the header if it encounters any of the following c=
ases:
+\begin{itemize}
+    \item the device does not recognize the protocol of the packet.
+    \item the packet is an IP fragmentation.
+    \item \field{type} does not include the protocol of the packet.
+    \item the buffer consists of only one descriptor.
+    \item the total size of the virtio net header and the protocol header =
exceeds
+        the size of the first descriptor.
+    \item when VIRTIO_NET_F_MRG_RXBUF is not negotiated and the size of th=
e
+        payload exceeds the size of the descriptor chain starting from the=
 2nd
+        descriptor.
</pre>
      </blockquote>
      <pre class=3D"moz-quote-pre" wrap=3D"">
When MRG_RXBUF is negotiated, what if the rest of the buffers don't
fit for the payload?
</pre>
    </blockquote>
    <pre>
When VIRTIO_NET_F_SPLIT_HEADER is not negotiated, the device will also face
this situation, and we keep the same as the previous processing logic.

</pre>
    <blockquote type=3D"cite"
cite=3D"mid:CACGkMEsmCnj3WqG6QkHYFH3JOvhucQ03ftax4Yow6O74QnvsVg@mail.gmail.=
com">
      <pre class=3D"moz-quote-pre" wrap=3D"">
</pre>
      <blockquote type=3D"cite">
        <pre class=3D"moz-quote-pre" wrap=3D"">+\end{itemize}
+
+If the header is split by the device, the VIRTIO_NET_HDR_F_SPLIT_HEADER bi=
t
+in \field{flags} MUST be set. The protocol header MUST be on the first
+descriptor, following the virtio net header. The payload MUST start from t=
he
+second descriptor. The device MUST set \field{hdr_len} of structure
+virtio_net_hdr to the length of the protocol header.
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
+because the first descriptor is used to carry the protocol header.
+The used length still reports the number of bytes it has written to memory=
.
</pre>
      </blockquote>
      <pre class=3D"moz-quote-pre" wrap=3D"">
Does this mean, in order to get best performance, driver needs to
prepare buffer like

[small descriptor for header] + [large descriptor for payload] ?
</pre>
    </blockquote>
    <pre>
Yes, that's it.
</pre>
    <pre>
</pre>
    <blockquote type=3D"cite"
cite=3D"mid:CACGkMEsmCnj3WqG6QkHYFH3JOvhucQ03ftax4Yow6O74QnvsVg@mail.gmail.=
com">
      <pre class=3D"moz-quote-pre" wrap=3D"">
</pre>
      <blockquote type=3D"cite">
        <pre class=3D"moz-quote-pre" wrap=3D"">+
+If VIRTIO_NET_F_SPLIT_HEADER is negotiated, but the device does not split =
the header
+and the buffer consists of at least two descriptors, the device MUST put t=
he virtio net header
+in the first descriptor, and MUST NOT set the VIRTIO_NET_HDR_F_SPLIT_HEADE=
R bit in \field{flags}.
+The device MUST use the second descriptor to store the packet, since the f=
irst descriptor
+is designed to accommodate the header and is tiny for the packet.
</pre>
      </blockquote>
      <pre class=3D"moz-quote-pre" wrap=3D"">
Which header did you mean here, is it the protocol header or the vnet heade=
r?

Btw I don't get why we need this, maybe you can give an example for this?
</pre>
    </blockquote>
    <pre>
</pre>
    <pre>"the header" means the virtio net header and the protocol header.


Why does virtio net header MUST be placed in the first descriptor by the de=
vice?

When VIRTIO_NET_F_SPLIT_HEADER is negotiated and the packet received by=20
the driver consists of at least 2 descriptors, the driver MUST use the firs=
t=20
descriptor in order to determine whether the packet is header-splitted by t=
he device.=20
Otherwise, if virtio net header is placed on the second descriptor, but the=
 packet has been=20
header-splitted by the device, such processing is unreasonable.


Why does the device MUST skip the first descriptor and use the second=20
descriptor to store the packet?

There are three points in total.

1. the semantic of the first descriptor:

When VIRTIO_NET_F_SPLIT_HEADER is negotiated, the first descriptor=20
is designed to store the virtio net header and the protocol header. If the =
first=20
descriptor stores the data of the packet at this time, then the semantic of=
 the first=20
descriptor has changed.

2. the performance of the driver while receiving the packets.

First, it is worth noting that the size of the first descriptor is small.

Second, imagine a situation where if a packet is exactly one byte larger th=
an the size
of the first descriptor, and the device stores the packet starting from=20
the first descriptor,the packet will be placed on two descriptors, but thes=
e two descriptors=20
not continuous in physical addresses, which will affect the performance of =
the driver when=20
receiving packets.

3. compatibility of driver's receiving packet logic:

If the device stores the packet in the second descriptor, the=20
driver's existing packet receiving logic is minimally affected.

</pre>
    <blockquote type=3D"cite"
cite=3D"mid:CACGkMEsmCnj3WqG6QkHYFH3JOvhucQ03ftax4Yow6O74QnvsVg@mail.gmail.=
com">
      <pre class=3D"moz-quote-pre" wrap=3D"">
</pre>
      <blockquote type=3D"cite">
        <pre class=3D"moz-quote-pre" wrap=3D"">+
+\drivernormative{\subparagraph}{Setting Split Header}{Device Types / Netwo=
rk Device / Device Operation / Control Virtqueue / Split Header}
+
+If the VIRTIO_NET_HDR_F_SPLIT_HEADER bit in \field{flags} is set, the driv=
er
+MUST treat the contents of \field{hdr_len} as the length of the protocol h=
eader
+inside the first descriptor.
</pre>
      </blockquote>
      <pre class=3D"moz-quote-pre" wrap=3D"">
Not sure MUST is appropriate here, driver needs to validate the hdr_len any=
how.
</pre>
    </blockquote>
    <pre>
</pre>
    <pre class=3D"moz-quote-pre" wrap=3D"">I will use "SHOULD" instead of "=
MUST".

</pre>
    <blockquote type=3D"cite"
cite=3D"mid:CACGkMEsmCnj3WqG6QkHYFH3JOvhucQ03ftax4Yow6O74QnvsVg@mail.gmail.=
com">
      <blockquote type=3D"cite">
        <pre class=3D"moz-quote-pre" wrap=3D"">+
+If the split header is enabled, the buffers submitted to receiveq by the
+driver SHOULD be composed of at least two descriptors.
</pre>
      </blockquote>
      <pre class=3D"moz-quote-pre" wrap=3D"">
It looks to me the "SHOULD" here is somehow conflict with the previous
description about when the device can't perform a split.

</pre>
    </blockquote>
    <pre>
</pre>
    <pre>I will use "MUST" instead of "SHOULD".
</pre>
    <pre>
</pre>
    <blockquote type=3D"cite"
cite=3D"mid:CACGkMEsmCnj3WqG6QkHYFH3JOvhucQ03ftax4Yow6O74QnvsVg@mail.gmail.=
com">
      <blockquote type=3D"cite">
        <pre class=3D"moz-quote-pre" wrap=3D"">+When the buffer consists of=
 two descriptors, the length of the first
+descriptor MUST be greater than the one of the virtio net header.
</pre>
      </blockquote>
      <pre class=3D"moz-quote-pre" wrap=3D"">
So I think we'd better have guidance on how to achieve the best
performance and move the above there instead of using the normatives.

</pre>
    </blockquote>
    <pre>
</pre>
    <pre>Will fix.

I will fix these in the next version.

Thanks.


</pre>
  </body>
</html>

--------------LMboU8VrTiCv7sda5Y08kAjE--

