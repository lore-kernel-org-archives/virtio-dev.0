Return-Path: <hengqi@linux.alibaba.com>
Message-ID: <732d5b5c-e5c2-ac57-05a7-8b26bbcb7015@linux.alibaba.com>
Date: Wed, 10 Aug 2022 17:10:37 +0800
MIME-Version: 1.0
Subject: Re: [virtio-dev] Re: [PATCH] virtio_net: support split header
References: <1659337182-128890-1-git-send-email-hengqi@linux.alibaba.com>
 <CACGkMEsmCnj3WqG6QkHYFH3JOvhucQ03ftax4Yow6O74QnvsVg@mail.gmail.com>
 <4ea77b4a-2571-2b12-433c-2f1a8ceaeff8@linux.alibaba.com>
 <CACGkMEvTr44xhziEwMhCpAVp4dWDPvGHfkwGm+o4WRqsKBX=gw@mail.gmail.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <CACGkMEvTr44xhziEwMhCpAVp4dWDPvGHfkwGm+o4WRqsKBX=gw@mail.gmail.com>
Content-Type: multipart/alternative;
 boundary="------------mShuajNYujUCRzc3igK4fTAM"
To: Jason Wang <jasowang@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, mst@redhat.com, xuanzhuo@linux.alibaba.com, kangjie.xu@linux.alibaba.com, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

This is a multi-part message in MIME format.
--------------mShuajNYujUCRzc3igK4fTAM
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit


在 2022/8/9 下午5:18, Jason Wang 写道:
> On Thu, Aug 4, 2022 at 8:48 PM Heng Qi<hengqi@linux.alibaba.com>  wrote:
>>
>> 在 2022/8/4 下午2:27, Jason Wang 写道:
>>
>> On Mon, Aug 1, 2022 at 2:59 PM Heng Qi<hengqi@linux.alibaba.com>  wrote:
>>
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
>>      3. Determine the device what to do if it does not perform header split on a packet.
>>
>> v5:
>>      1. Determine when hdr_len is credible in the process of rx
>>      2. Clean up the use of buffers and descriptors
>>      3. Clarify the meaning of used lenght if the first descriptor is skipped in the case of merge
>>
>> v4:
>>      1. fix typo @Cornelia Huck @Jason Wang
>>      2. do not split header for IP fragmentation packet. @Jason Wang
>>
>> v3:
>>      1. Fix some syntax issues
>>      2. Fix some terminology issues
>>      3. It is not unified with ip alignment, so ip alignment is not included
>>      4. Make it clear that the device must support four types, in the case of
>>      successful negotiation.
>>
>>   conformance.tex |   2 +
>>   content.tex     | 111 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--
>>   2 files changed, 109 insertions(+), 4 deletions(-)
>>
>> diff --git a/conformance.tex b/conformance.tex
>> index 2b86fc6..bd0f463 100644
>> --- a/conformance.tex
>> +++ b/conformance.tex
>> @@ -150,6 +150,7 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
>>   \item \ref{drivernormative:Device Types / Network Device / Device Operation / Control Virtqueue / Offloads State Configuration / Setting Offloads State}
>>   \item \ref{drivernormative:Device Types / Network Device / Device Operation / Control Virtqueue / Receive-side scaling (RSS) }
>>   \item \ref{drivernormative:Device Types / Network Device / Device Operation / Control Virtqueue / Notifications Coalescing}
>> +\item \ref{drivernormative:Device Types / Network Device / Device Operation / Control Virtqueue / Split Header}
>>   \end{itemize}
>>
>>   \conformance{\subsection}{Block Driver Conformance}\label{sec:Conformance / Driver Conformance / Block Driver Conformance}
>> @@ -415,6 +416,7 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
>>   \item \ref{devicenormative:Device Types / Network Device / Device Operation / Control Virtqueue / Automatic receive steering in multiqueue mode}
>>   \item \ref{devicenormative:Device Types / Network Device / Device Operation / Control Virtqueue / Receive-side scaling (RSS) / RSS processing}
>>   \item \ref{devicenormative:Device Types / Network Device / Device Operation / Control Virtqueue / Notifications Coalescing}
>> +\item \ref{devicenormative:Device Types / Network Device / Device Operation / Control Virtqueue / Split Header}
>>   \end{itemize}
>>
>>   \conformance{\subsection}{Block Device Conformance}\label{sec:Conformance / Device Conformance / Block Device Conformance}
>> diff --git a/content.tex b/content.tex
>> index e863709..74c36fe 100644
>> --- a/content.tex
>> +++ b/content.tex
>> @@ -3084,6 +3084,9 @@ \subsection{Feature bits}\label{sec:Device Types / Network Device / Feature bits
>>   \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through control
>>       channel.
>>
>> +\item[VIRTIO_NET_F_SPLIT_HEADER (52)] Device supports splitting the protocol
>> +    header and the payload.
>> +
>>   \item[VIRTIO_NET_F_NOTF_COAL(53)] Device supports notifications coalescing.
>>
>>   \item[VIRTIO_NET_F_GUEST_USO4 (54)] Driver can receive USOv4 packets.
>> @@ -3140,6 +3143,7 @@ \subsubsection{Feature bit requirements}\label{sec:Device Types / Network Device
>>   \item[VIRTIO_NET_F_NOTF_COAL] Requires VIRTIO_NET_F_CTRL_VQ.
>>   \item[VIRTIO_NET_F_RSC_EXT] Requires VIRTIO_NET_F_HOST_TSO4 or VIRTIO_NET_F_HOST_TSO6.
>>   \item[VIRTIO_NET_F_RSS] Requires VIRTIO_NET_F_CTRL_VQ.
>> +\item[VIRTIO_NET_F_SPLIT_HEADER] Requires VIRTIO_NET_F_CTRL_VQ.
>>   \end{description}
>>
>>   \subsubsection{Legacy Interface: Feature bits}\label{sec:Device Types / Network Device / Feature bits / Legacy Interface: Feature bits}
>> @@ -3371,6 +3375,7 @@ \subsection{Device Operation}\label{sec:Device Types / Network Device / Device O
>>   #define VIRTIO_NET_HDR_F_NEEDS_CSUM    1
>>   #define VIRTIO_NET_HDR_F_DATA_VALID    2
>>   #define VIRTIO_NET_HDR_F_RSC_INFO      4
>> +#define VIRTIO_NET_HDR_F_SPLIT_HEADER  8
>>           u8 flags;
>>   #define VIRTIO_NET_HDR_GSO_NONE        0
>>   #define VIRTIO_NET_HDR_GSO_TCPV4       1
>> @@ -3799,9 +3804,10 @@ \subsubsection{Processing of Incoming Packets}\label{sec:Device Types / Network
>>   not set VIRTIO_NET_HDR_F_RSC_INFO bit in \field{flags}.
>>
>>   If one of the VIRTIO_NET_F_GUEST_TSO4, TSO6, UFO, USO4 or USO6 options have
>> -been negotiated, the device SHOULD set \field{hdr_len} to a value
>> +been negotiated and the VIRTIO_NET_HDR_F_SPLIT_HEADER bit in \field{flags}
>> +is not set, the device SHOULD set \field{hdr_len} to a value
>>   not less than the length of the headers, including the transport
>> -header.
>> +header \ref{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Split Header / Setting Split Header}.
>>
>>   If the VIRTIO_NET_F_GUEST_CSUM feature has been negotiated, the
>>   device MAY set the VIRTIO_NET_HDR_F_DATA_VALID bit in
>> @@ -3820,9 +3826,13 @@ \subsubsection{Processing of Incoming Packets}\label{sec:Device Types / Network
>>   driver MUST NOT use the \field{csum_start} and \field{csum_offset}.
>>
>>   If one of the VIRTIO_NET_F_GUEST_TSO4, TSO6, UFO, USO4 or USO6 options have
>> -been negotiated, the driver MAY use \field{hdr_len} only as a hint about the
>> +been negotiated and the VIRTIO_NET_HDR_F_SPLIT_HEADER bit in \field{flags}
>> +is not set, the driver MAY use \field{hdr_len} only as a hint about the
>>   transport header size.
>> -The driver MUST NOT rely on \field{hdr_len} to be correct.
>> +
>> +If the VIRTIO_NET_HDR_F_SPLIT_HEADER bit in \field{flags} is not set, the driver
>> +MUST NOT rely on \field{hdr_len} to be correct.
>>
>> I think we should keep the above description as-is. For whatever case,
>> the driver must not trust the metadata set by the device and must
>> perform necessary sanity tests on them.
>>
>>
>> My idea is to keep the current description as it is, but to emphasize in the next version :
>> "If the VIRTIO_NET_HDR_F_SPLIT_HEADER bit in \field{flags} is set, the driver MAY treat
>> the \field{hdr_len} as the length of the protocol header inside the first descriptor."
> I'm not sure this is useful, the original description looks fine:
>
> 1) It says hdr_len is a hint about the transport header size when
> _F_SPLIT_HEADER is set. So this means the device has successfully
> split the header in the first descriptor.
> 2) driver MUST NOT rely on it.
>
> Btw, since the spec said it is the transport header size, it might be
> better to rename the feature as "split transport header"? So we can
> use another feature for network header split in the future otherwise
> there will be a conflict.
>
>>
>> +
>>   \begin{note}
>>   This is due to various bugs in implementations.
>>   \end{note}
>> @@ -4483,6 +4493,99 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
>>   according to the native endian of the guest rather than
>>   (necessarily when not using the legacy interface) little-endian.
>>
>> +\paragraph{Split Header}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Split Header}
>> +
>> +If the VIRTIO_NET_F_SPLIT_HEADER feature is negotiated,
>> +the device supports splitting the protocol header and the payload.
>> +The protocol header and the payload will be separated into different
>> +descriptors.
>> +
>> +\subparagraph{Split Header}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Split Header / Setting Split Header}
>> +
>> +To configure the split header, the following layout structure and definitions
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
>> +VIRTIO_NET_CTRL_SPLIT_HEADER_SET applies the new split header configuration.
>> +
>> +The driver can enable or disable split header for different protocols by
>> +setting or clearing corresponding bits in \field{type}.
>> +
>> +\begin{itemize}
>> +    \item VIRTIO_NET_SPLIT_HEADER_TYPE_TCP4: split after ipv4 tcp header
>> +    \item VIRTIO_NET_SPLIT_HEADER_TYPE_TCP6: split after ipv6 tcp header
>> +    \item VIRTIO_NET_SPLIT_HEADER_TYPE_UDP4: split after ipv4 udp header
>> +    \item VIRTIO_NET_SPLIT_HEADER_TYPE_UDP6: split after ipv6 udp header
>> +\end{itemize}
>> +
>> +\devicenormative{\subparagraph}{Setting Split Header}{Device Types / Network Device / Device Operation / Control Virtqueue / Split Header}
>> +
>> +A device MUST initialize \field{type} to 0, and MUST set it to 0
>> +upon device reset.
>> +
>> +If VIRTIO_NET_F_SPLIT_HEADER is negotiated, the device MUST support
>> +VIRTIO_NET_SPLIT_HEADER_TYPE_TCP4, VIRTIO_NET_SPLIT_HEADER_TYPE_TCP6,
>> +VIRTIO_NET_SPLIT_HEADER_TYPE_UDP4, VIRTIO_NET_SPLIT_HEADER_TYPE_UDP6.
>> +
>> +A device MUST NOT split the header if it encounters any of the following cases:
>> +\begin{itemize}
>> +    \item the device does not recognize the protocol of the packet.
>> +    \item the packet is an IP fragmentation.
>> +    \item \field{type} does not include the protocol of the packet.
>> +    \item the buffer consists of only one descriptor.
>> +    \item the total size of the virtio net header and the protocol header exceeds
>> +        the size of the first descriptor.
>> +    \item when VIRTIO_NET_F_MRG_RXBUF is not negotiated and the size of the
>> +        payload exceeds the size of the descriptor chain starting from the 2nd
>> +        descriptor.
>>
>> When MRG_RXBUF is negotiated, what if the rest of the buffers don't
>> fit for the payload?
>>
>>
>> When VIRTIO_NET_F_SPLIT_HEADER is not negotiated, the device will also face
>> this situation, and we keep the same as the previous processing logic.
> The previous logic only applies for a single buffer not the case for a
> packet that can occupy multiple buffers?

I'm not quite sure what you mean. But I guess you mean something like this:

For example, the device we use is DPDK vhost-user, and the packet receiving
mode of the virtio-net driver is MRG_RXBUF. In this environment, when
VIRTIO_NET_F_SPLIT_HEADER is not negotiated, a buffer in the device consists
of only one descriptor, but a packet may be spread over multiple buffers.
The previous logic is that if the rest of the buffers don't fit for the payload,
it will return an error code and discard the remaining packets of the batch.
When VIRTIO_NET_F_SPLIT_HEADER is negotiated, a buffer consists of 2 descriptors,
the first for the header (the virtio net header and the protocol header) and
the second for the payload. Now, a packet is spread over multiple buffers and if the
rest of the buffers don't fit for the payload, we use the same logic as before
without negotiating VIRTIO_NET_F_SPLIT_HEADER, which is to return an error code
and discard the remaining packets of the batch.

Or do you mean something else? Can you help clarify the question？

Thanks.


>>
>> +\end{itemize}
>> +
>> +If the header is split by the device, the VIRTIO_NET_HDR_F_SPLIT_HEADER bit
>> +in \field{flags} MUST be set. The protocol header MUST be on the first
>> +descriptor, following the virtio net header. The payload MUST start from the
>> +second descriptor. The device MUST set \field{hdr_len} of structure
>> +virtio_net_hdr to the length of the protocol header.
>> +
>> +If all of the following applies:
>> +\begin{itemize}
>> +    \item the header is split by the device.
>> +    \item VIRTIO_NET_F_MRG_RXBUF has been negotiated.
>> +    \item the received packet is spread over multiple buffers.
>> +\end {itemize}
>> +then if the device uses the buffers after the 1st buffer, and the buffer
>> +consists of multiple descriptors, the device MUST skip the first descriptor,
>> +because the first descriptor is used to carry the protocol header.
>> +The used length still reports the number of bytes it has written to memory.
>>
>> Does this mean, in order to get best performance, driver needs to
>> prepare buffer like
>>
>> [small descriptor for header] + [large descriptor for payload] ?
>>
>>
>> Yes, that's it.
> Let's add something in the driver normatives then. And I wonder if

Okay, we can do this later.


> this will have any side effects for the packet that can be splitted.

Currently when a packet is split, we haven't seen side effects on performance.

In the environment where the device uses OVS-DPDK vhost-user and the driver uses
virtio-net, we perform TCP receive zero-copy testing based on the
'tools/testing/selftests/net/tcp_mmap.c' test program by our split header implement.

Compared with the way that packets pass through the network stack by copying,
the efficiency of zero-copy packet receiving is improved by at least 50%.

>>
>> +
>> +If VIRTIO_NET_F_SPLIT_HEADER is negotiated, but the device does not split the header
>> +and the buffer consists of at least two descriptors, the device MUST put the virtio net header
>> +in the first descriptor, and MUST NOT set the VIRTIO_NET_HDR_F_SPLIT_HEADER bit in \field{flags}.
>> +The device MUST use the second descriptor to store the packet, since the first descriptor
>> +is designed to accommodate the header and is tiny for the packet.
>>
>> Which header did you mean here, is it the protocol header or the vnet header?
>>
>> Btw I don't get why we need this, maybe you can give an example for this?
>>
>> "the header" means the virtio net header and the protocol header.
> Okay, let's clarify it in the next version.
>
> Thanks

Okay. Thanks.

--------------mShuajNYujUCRzc3igK4fTAM
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">在 2022/8/9 下午5:18, Jason Wang 写道:<br>
    </div>
    <blockquote type="cite"
cite="mid:CACGkMEvTr44xhziEwMhCpAVp4dWDPvGHfkwGm+o4WRqsKBX=gw@mail.gmail.com">
      <pre class="moz-quote-pre" wrap="">On Thu, Aug 4, 2022 at 8:48 PM Heng Qi <a class="moz-txt-link-rfc2396E" href="mailto:hengqi@linux.alibaba.com">&lt;hengqi@linux.alibaba.com&gt;</a> wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">

在 2022/8/4 下午2:27, Jason Wang 写道:

On Mon, Aug 1, 2022 at 2:59 PM Heng Qi <a class="moz-txt-link-rfc2396E" href="mailto:hengqi@linux.alibaba.com">&lt;hengqi@linux.alibaba.com&gt;</a> wrote:

From: Xuan Zhuo <a class="moz-txt-link-rfc2396E" href="mailto:xuanzhuo@linux.alibaba.com">&lt;xuanzhuo@linux.alibaba.com&gt;</a>

The purpose of this feature is to split the header and the payload of
the packet.

|                    receive buffer                                    |
|                       0th descriptor             | 1th descriptor    |
| virtnet hdr | mac | ip hdr | tcp hdr|&lt;-- hold --&gt;|   payload         |

We can use a buffer plus a separate page when allocating the receive
buffer. In this way, we can ensure that all payloads can be
independently in a page, which is very beneficial for the zerocopy
implemented by the upper layer.

Signed-off-by: Xuan Zhuo <a class="moz-txt-link-rfc2396E" href="mailto:xuanzhuo@linux.alibaba.com">&lt;xuanzhuo@linux.alibaba.com&gt;</a>
Signed-off-by: Heng Qi <a class="moz-txt-link-rfc2396E" href="mailto:hengqi@linux.alibaba.com">&lt;hengqi@linux.alibaba.com&gt;</a>
Reviewed-by: Kangjie Xu <a class="moz-txt-link-rfc2396E" href="mailto:kangjie.xu@linux.alibaba.com">&lt;kangjie.xu@linux.alibaba.com&gt;</a>
---

v6:
    1. Fix some syntax issues. @Cornelia Huck
    2. Clarify some paragraphs. @Cornelia Huck
    3. Determine the device what to do if it does not perform header split on a packet.

v5:
    1. Determine when hdr_len is credible in the process of rx
    2. Clean up the use of buffers and descriptors
    3. Clarify the meaning of used lenght if the first descriptor is skipped in the case of merge

v4:
    1. fix typo @Cornelia Huck @Jason Wang
    2. do not split header for IP fragmentation packet. @Jason Wang

v3:
    1. Fix some syntax issues
    2. Fix some terminology issues
    3. It is not unified with ip alignment, so ip alignment is not included
    4. Make it clear that the device must support four types, in the case of
    successful negotiation.

 conformance.tex |   2 +
 content.tex     | 111 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 109 insertions(+), 4 deletions(-)

diff --git a/conformance.tex b/conformance.tex
index 2b86fc6..bd0f463 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -150,6 +150,7 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
 \item \ref{drivernormative:Device Types / Network Device / Device Operation / Control Virtqueue / Offloads State Configuration / Setting Offloads State}
 \item \ref{drivernormative:Device Types / Network Device / Device Operation / Control Virtqueue / Receive-side scaling (RSS) }
 \item \ref{drivernormative:Device Types / Network Device / Device Operation / Control Virtqueue / Notifications Coalescing}
+\item \ref{drivernormative:Device Types / Network Device / Device Operation / Control Virtqueue / Split Header}
 \end{itemize}

 \conformance{\subsection}{Block Driver Conformance}\label{sec:Conformance / Driver Conformance / Block Driver Conformance}
@@ -415,6 +416,7 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
 \item \ref{devicenormative:Device Types / Network Device / Device Operation / Control Virtqueue / Automatic receive steering in multiqueue mode}
 \item \ref{devicenormative:Device Types / Network Device / Device Operation / Control Virtqueue / Receive-side scaling (RSS) / RSS processing}
 \item \ref{devicenormative:Device Types / Network Device / Device Operation / Control Virtqueue / Notifications Coalescing}
+\item \ref{devicenormative:Device Types / Network Device / Device Operation / Control Virtqueue / Split Header}
 \end{itemize}

 \conformance{\subsection}{Block Device Conformance}\label{sec:Conformance / Device Conformance / Block Device Conformance}
diff --git a/content.tex b/content.tex
index e863709..74c36fe 100644
--- a/content.tex
+++ b/content.tex
@@ -3084,6 +3084,9 @@ \subsection{Feature bits}\label{sec:Device Types / Network Device / Feature bits
 \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through control
     channel.

+\item[VIRTIO_NET_F_SPLIT_HEADER (52)] Device supports splitting the protocol
+    header and the payload.
+
 \item[VIRTIO_NET_F_NOTF_COAL(53)] Device supports notifications coalescing.

 \item[VIRTIO_NET_F_GUEST_USO4 (54)] Driver can receive USOv4 packets.
@@ -3140,6 +3143,7 @@ \subsubsection{Feature bit requirements}\label{sec:Device Types / Network Device
 \item[VIRTIO_NET_F_NOTF_COAL] Requires VIRTIO_NET_F_CTRL_VQ.
 \item[VIRTIO_NET_F_RSC_EXT] Requires VIRTIO_NET_F_HOST_TSO4 or VIRTIO_NET_F_HOST_TSO6.
 \item[VIRTIO_NET_F_RSS] Requires VIRTIO_NET_F_CTRL_VQ.
+\item[VIRTIO_NET_F_SPLIT_HEADER] Requires VIRTIO_NET_F_CTRL_VQ.
 \end{description}

 \subsubsection{Legacy Interface: Feature bits}\label{sec:Device Types / Network Device / Feature bits / Legacy Interface: Feature bits}
@@ -3371,6 +3375,7 @@ \subsection{Device Operation}\label{sec:Device Types / Network Device / Device O
 #define VIRTIO_NET_HDR_F_NEEDS_CSUM    1
 #define VIRTIO_NET_HDR_F_DATA_VALID    2
 #define VIRTIO_NET_HDR_F_RSC_INFO      4
+#define VIRTIO_NET_HDR_F_SPLIT_HEADER  8
         u8 flags;
 #define VIRTIO_NET_HDR_GSO_NONE        0
 #define VIRTIO_NET_HDR_GSO_TCPV4       1
@@ -3799,9 +3804,10 @@ \subsubsection{Processing of Incoming Packets}\label{sec:Device Types / Network
 not set VIRTIO_NET_HDR_F_RSC_INFO bit in \field{flags}.

 If one of the VIRTIO_NET_F_GUEST_TSO4, TSO6, UFO, USO4 or USO6 options have
-been negotiated, the device SHOULD set \field{hdr_len} to a value
+been negotiated and the VIRTIO_NET_HDR_F_SPLIT_HEADER bit in \field{flags}
+is not set, the device SHOULD set \field{hdr_len} to a value
 not less than the length of the headers, including the transport
-header.
+header \ref{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Split Header / Setting Split Header}.

 If the VIRTIO_NET_F_GUEST_CSUM feature has been negotiated, the
 device MAY set the VIRTIO_NET_HDR_F_DATA_VALID bit in
@@ -3820,9 +3826,13 @@ \subsubsection{Processing of Incoming Packets}\label{sec:Device Types / Network
 driver MUST NOT use the \field{csum_start} and \field{csum_offset}.

 If one of the VIRTIO_NET_F_GUEST_TSO4, TSO6, UFO, USO4 or USO6 options have
-been negotiated, the driver MAY use \field{hdr_len} only as a hint about the
+been negotiated and the VIRTIO_NET_HDR_F_SPLIT_HEADER bit in \field{flags}
+is not set, the driver MAY use \field{hdr_len} only as a hint about the
 transport header size.
-The driver MUST NOT rely on \field{hdr_len} to be correct.
+
+If the VIRTIO_NET_HDR_F_SPLIT_HEADER bit in \field{flags} is not set, the driver
+MUST NOT rely on \field{hdr_len} to be correct.

I think we should keep the above description as-is. For whatever case,
the driver must not trust the metadata set by the device and must
perform necessary sanity tests on them.


My idea is to keep the current description as it is, but to emphasize in the next version :
"If the VIRTIO_NET_HDR_F_SPLIT_HEADER bit in \field{flags} is set, the driver MAY treat
the \field{hdr_len} as the length of the protocol header inside the first descriptor."
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
I'm not sure this is useful, the original description looks fine:

1) It says hdr_len is a hint about the transport header size when
_F_SPLIT_HEADER is set. So this means the device has successfully
split the header in the first descriptor.
2) driver MUST NOT rely on it.

Btw, since the spec said it is the transport header size, it might be
better to rename the feature as "split transport header"? So we can
use another feature for network header split in the future otherwise
there will be a conflict.

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">

+
 \begin{note}
 This is due to various bugs in implementations.
 \end{note}
@@ -4483,6 +4493,99 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
 according to the native endian of the guest rather than
 (necessarily when not using the legacy interface) little-endian.

+\paragraph{Split Header}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Split Header}
+
+If the VIRTIO_NET_F_SPLIT_HEADER feature is negotiated,
+the device supports splitting the protocol header and the payload.
+The protocol header and the payload will be separated into different
+descriptors.
+
+\subparagraph{Split Header}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Split Header / Setting Split Header}
+
+To configure the split header, the following layout structure and definitions
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
+VIRTIO_NET_CTRL_SPLIT_HEADER_SET applies the new split header configuration.
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
+\devicenormative{\subparagraph}{Setting Split Header}{Device Types / Network Device / Device Operation / Control Virtqueue / Split Header}
+
+A device MUST initialize \field{type} to 0, and MUST set it to 0
+upon device reset.
+
+If VIRTIO_NET_F_SPLIT_HEADER is negotiated, the device MUST support
+VIRTIO_NET_SPLIT_HEADER_TYPE_TCP4, VIRTIO_NET_SPLIT_HEADER_TYPE_TCP6,
+VIRTIO_NET_SPLIT_HEADER_TYPE_UDP4, VIRTIO_NET_SPLIT_HEADER_TYPE_UDP6.
+
+A device MUST NOT split the header if it encounters any of the following cases:
+\begin{itemize}
+    \item the device does not recognize the protocol of the packet.
+    \item the packet is an IP fragmentation.
+    \item \field{type} does not include the protocol of the packet.
+    \item the buffer consists of only one descriptor.
+    \item the total size of the virtio net header and the protocol header exceeds
+        the size of the first descriptor.
+    \item when VIRTIO_NET_F_MRG_RXBUF is not negotiated and the size of the
+        payload exceeds the size of the descriptor chain starting from the 2nd
+        descriptor.

When MRG_RXBUF is negotiated, what if the rest of the buffers don't
fit for the payload?


When VIRTIO_NET_F_SPLIT_HEADER is not negotiated, the device will also face
this situation, and we keep the same as the previous processing logic.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
The previous logic only applies for a single buffer not the case for a
packet that can occupy multiple buffers?
</pre>
    </blockquote>
    <pre>
<pre>I'm not quite sure what you mean. But I guess you mean something like this:
</pre></pre>
    <pre>For example, the device we use is DPDK vhost-user, and the packet receiving
mode of the virtio-net driver is MRG_RXBUF. In this environment, when
VIRTIO_NET_F_SPLIT_HEADER is not negotiated, a buffer in the device consists
of only one descriptor, but a packet may be spread over multiple buffers.
The previous logic is that if the rest of the buffers don't fit for the payload,
it will return an error code and discard the remaining packets of the batch.
When VIRTIO_NET_F_SPLIT_HEADER is negotiated, a buffer consists of 2 descriptors,
the first for the header (the virtio net header and the protocol header) and
the second for the payload. Now, a packet is spread over multiple buffers and if the
rest of the buffers don't fit for the payload, we use the same logic as before
without negotiating VIRTIO_NET_F_SPLIT_HEADER, which is to return an error code
and discard the remaining packets of the batch.

Or do you mean something else? Can you help clarify the question？

Thanks.</pre>
    <pre>

</pre>
    <blockquote type="cite"
cite="mid:CACGkMEvTr44xhziEwMhCpAVp4dWDPvGHfkwGm+o4WRqsKBX=gw@mail.gmail.com">
      <pre class="moz-quote-pre" wrap="">
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">

+\end{itemize}
+
+If the header is split by the device, the VIRTIO_NET_HDR_F_SPLIT_HEADER bit
+in \field{flags} MUST be set. The protocol header MUST be on the first
+descriptor, following the virtio net header. The payload MUST start from the
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
+consists of multiple descriptors, the device MUST skip the first descriptor,
+because the first descriptor is used to carry the protocol header.
+The used length still reports the number of bytes it has written to memory.

Does this mean, in order to get best performance, driver needs to
prepare buffer like

[small descriptor for header] + [large descriptor for payload] ?


Yes, that's it.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Let's add something in the driver normatives then. And I wonder if</pre>
    </blockquote>
    <pre>
Okay, we can do this later.


</pre>
    <blockquote type="cite"
cite="mid:CACGkMEvTr44xhziEwMhCpAVp4dWDPvGHfkwGm+o4WRqsKBX=gw@mail.gmail.com">
      <pre class="moz-quote-pre" wrap="">
this will have any side effects for the packet that can be splitted.
</pre>
    </blockquote>
    <pre>
Currently when a packet is split, we haven't seen side effects on performance.

In the environment where the device uses OVS-DPDK vhost-user and the driver uses
virtio-net, we perform TCP receive zero-copy testing based on the
'tools/testing/selftests/net/tcp_mmap.c' test program by our split header implement. 

Compared with the way that packets pass through the network stack by copying,
the efficiency of zero-copy packet receiving is improved by at least 50%.

</pre>
    <blockquote type="cite"
cite="mid:CACGkMEvTr44xhziEwMhCpAVp4dWDPvGHfkwGm+o4WRqsKBX=gw@mail.gmail.com">
      <pre class="moz-quote-pre" wrap="">
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">

+
+If VIRTIO_NET_F_SPLIT_HEADER is negotiated, but the device does not split the header
+and the buffer consists of at least two descriptors, the device MUST put the virtio net header
+in the first descriptor, and MUST NOT set the VIRTIO_NET_HDR_F_SPLIT_HEADER bit in \field{flags}.
+The device MUST use the second descriptor to store the packet, since the first descriptor
+is designed to accommodate the header and is tiny for the packet.

Which header did you mean here, is it the protocol header or the vnet header?

Btw I don't get why we need this, maybe you can give an example for this?

"the header" means the virtio net header and the protocol header.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Okay, let's clarify it in the next version.

Thanks</pre>
    </blockquote>
    <pre>
Okay. Thanks.
</pre>
    <blockquote type="cite"
cite="mid:CACGkMEvTr44xhziEwMhCpAVp4dWDPvGHfkwGm+o4WRqsKBX=gw@mail.gmail.com">
      <pre class="moz-quote-pre" wrap="">
</pre>
    </blockquote>
  </body>
</html>

--------------mShuajNYujUCRzc3igK4fTAM--

