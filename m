Return-Path: <virtio-dev-return-12428-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD18BC7618E
	for <virtio-dev@archiver.kernel.org>; Wed, 26 Apr 2023 07:42:43 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 0B4C82A83A
	for <virtio-dev@archiver.kernel.org>; Wed, 26 Apr 2023 07:42:43 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F4155986653
	for <virtio-dev@archiver.kernel.org>; Wed, 26 Apr 2023 07:42:42 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id E5B62986641; Wed, 26 Apr 2023 07:42:42 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D0A5998663C;
	Wed, 26 Apr 2023 07:42:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R261e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0Vh2DWc4_1682494953;
Message-ID: <1682494899.5691428-1-xuanzhuo@linux.alibaba.com>
Date: Wed, 26 Apr 2023 15:41:39 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtio-comment@lists.oasis-open.org
Cc: hans@linux.alibaba.com,
 herongguang@linux.alibaba.com,
 zmlcc@linux.alibaba.com,
 dust.li@linux.alibaba.com,
 tonylu@linux.alibaba.com,
 zhenzao@linux.alibaba.com,
 helinguo@linux.alibaba.com,
 gerry@linux.alibaba.com,
 mst@redhat.com,
 cohuck@redhat.com,
 jasowang@redhat.com,
 Jan Kiszka <jan.kiszka@siemens.com>,
 wintera@linux.ibm.com,
 kgraul@linux.ibm.com,
 wenjia@linux.ibm.com,
 jaka@linux.ibm.com,
 hca@linux.ibm.com,
 twinkler@linux.ibm.com,
 raspl@linux.ibm.com,
 virtio-dev@lists.oasis-open.org,
 pasic@linux.ibm.com
References: <20230209033056.96657-1-xuanzhuo@linux.alibaba.com>
 <20230209033056.96657-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20230209033056.96657-2-xuanzhuo@linux.alibaba.com>
Subject: [virtio-dev] Re: [PATCH v3 1/1] virtio-ism: introduce new device virtio-ism

Any commnets for this.

Thanks.

On Thu,  9 Feb 2023 11:30:56 +0800, Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> An ISM(Internal Shared Memory) device provides the ability to access memory
> shared between multiple devices. This allows low-overhead communication in
> presence of such memory. For example, memory can be shared with guests of
> multiple virtual machines running on the same host, with each virtual machine
> including an ism device and with the guests getting the shared memory by the ism
> devices.
>
> An ism device can communicate with multiple peers simultaneously. This
> communication can be dynamically started and ended.
>
> |-------------------------------------------------------------------------------------------------------------|
> | |------------------------------------------------|       |------------------------------------------------| |
> | | Guest                                          |       | Guest                                          | |
> | |                                                |       |                                                | |
> | |   ----------------                             |       |   ----------------                             | |
> | |   |    driver    |     [M1]   [M2]   [M3]      |       |   |    driver    |             [M2]   [M3]     | |
> | |   ----------------       |      |      |       |       |   ----------------               |      |      | |
> | |    |cq|                  |map   |map   |map    |       |    |cq|                          |map   |map   | |
> | |    |  |                  |      |      |       |       |    |  |                          |      |      | |
> | |    |  |                -------------------     |       |    |  |                --------------------    | |
> | |----|--|----------------|  device memory  |-----|       |----|--|----------------|  device memory   |----| |
> | |    |  |                -------------------     |       |    |  |                --------------------    | |
> | |                                |               |       |                               |                | |
> | |                                |               |       |                               |                | |
> | | Qemu                           |               |       | Qemu                          |                | |
> | |--------------------------------+---------------|       |-------------------------------+----------------| |
> |                                  |                                                       |                  |
> |                                  |                                                       |                  |
> |                                  |------------------------------+------------------------|                  |
> |                                                                 |                                           |
> |                                                                 |                                           |
> |                                                   --------------------------                                |
> |                                                    | M1 |   | M2 |   | M3 |                                 |
> |                                                   --------------------------                                |
> |                                                                                                             |
> | HOST                                                                                                        |
> ---------------------------------------------------------------------------------------------------------------
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
> Signed-off-by: Dust Li <dust.li@linux.alibaba.com>
> Signed-off-by: Tony Lu <tonylu@linux.alibaba.com>
> Signed-off-by: Helin Guo <helinguo@linux.alibaba.com>
> Signed-off-by: Hans Zhang <hans@linux.alibaba.com>
> Signed-off-by: He Rongguang <herongguang@linux.alibaba.com>
> Suggested-by: Halil Pasic <pasic@linux.ibm.com>
> ---
>  conformance.tex |  26 +++
>  content.tex     |   1 +
>  virtio-ism.tex  | 573 ++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 600 insertions(+)
>  create mode 100644 virtio-ism.tex
>
> diff --git a/conformance.tex b/conformance.tex
> index c3c1d3e..0a1456a 100644
> --- a/conformance.tex
> +++ b/conformance.tex
> @@ -335,6 +335,17 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
>  \item \ref{drivernormative:Device Types / PMEM Device / Device Initialization}
>  \end{itemize}
>
> +\conformance{\subsection}{ISM Driver Conformance}\label{sec:Conformance / Driver Conformance / ISM Driver Conformance}
> +
> +A ISM driver MUST conform to the following normative statements:
> +
> +\begin{itemize}
> +\item \ref{drivernormative:Device Types / ISM Device / Device Initialization}
> +\item \ref{drivernormative:Device Types / ISM Device / Device Operation / Alloc ISM Region}
> +\item \ref{drivernormative:Device Types / ISM Device / Device Operation / Attach ISM Region}
> +\item \ref{drivernormative:Device Types / ISM Device / Device Operation / Detach ISM Region}
> +\end{itemize}
> +
>  \conformance{\section}{Device Conformance}\label{sec:Conformance / Device Conformance}
>
>  A device MUST conform to the following normative statements:
> @@ -621,6 +632,21 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
>  \item \ref{devicenormative:Device Types / PMEM Device / Device Operation / Virtqueue return}
>  \end{itemize}
>
> +\conformance{\subsection}{ISM Device Conformance}\label{sec:Conformance / Device Conformance / ISM Device Conformance}
> +
> +A ISM device MUST conform to the following normative statements:
> +
> +\begin{itemize}
> +\item \ref{devicenormative:Device Types / ISM Device / Device configuration layout}
> +\item \ref{devicenormative:Device Types / ISM Device / Device Initialization}
> +\item \ref{devicenormative:Device Types / ISM Device / Device Operation / Alloc ISM Region}
> +\item \ref{devicenormative:Device Types / ISM Device / Device Operation / Query ISM Region}
> +\item \ref{devicenormative:Device Types / ISM Device / Device Operation / Attach ISM Region}
> +\item \ref{devicenormative:Device Types / ISM Device / Device Operation / Detach ISM Region}
> +\item \ref{devicenormative:Device Types / ISM Device / Device Operation / Grant ISM Region}
> +\item \ref{devicenormative:Device Types / ISM Device / Device Operation / Inform Event IRQ Vector}
> +\end{itemize}
> +
>  \conformance{\section}{Legacy Interface: Transitional Device and Transitional Driver Conformance}\label{sec:Conformance / Legacy Interface: Transitional Device and Transitional Driver Conformance}
>  A conformant implementation MUST be either transitional or
>  non-transitional, see \ref{intro:Legacy
> diff --git a/content.tex b/content.tex
> index 96f4723..fe02aec 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -7545,6 +7545,7 @@ \subsubsection{Legacy Interface: Framing Requirements}\label{sec:Device
>  \input{virtio-scmi.tex}
>  \input{virtio-gpio.tex}
>  \input{virtio-pmem.tex}
> +\input{virtio-ism.tex}
>
>  \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
>
> diff --git a/virtio-ism.tex b/virtio-ism.tex
> new file mode 100644
> index 0000000..a1720d8
> --- /dev/null
> +++ b/virtio-ism.tex
> @@ -0,0 +1,573 @@
> +\section{ISM Device}\label{sec:Device Types / ISM Device}
> +
> +\begin{lstlisting}
> +|-------------------------------------------------------------------------------------------------------------|
> +| |------------------------------------------------|    |------------------------------------------------|    |
> +| | VM                      [M1]   [M2]   [M3]     |    | VM                             [M2]   [M3]     |    |
> +| |                          |      |      |       |    |                                 |      |       |    |
> +| |   -----------------------|------|------|---    |    |   ------------------------------|------|---    |    |
> +| |   |             driver   |      |      |  |    |    |   |             driver          |      |  |    |    |
> +| |   -----------------------|------|------|---    |    |   ------------------------------|------|---    |    |
> +| |    |cq|                  |map   |map   |map    |    |    |cq|                         |map   |map    |    |
> +| |    |  |                  |      |      |       |    |    |  |                         |      |       |    |
> +| |    |  |                -------------------     |    |    |  |                -------------------     |    |
> +| |----|--|----------------|  device memory  |-----|    |----|--|----------------|  device memory  |-----|    |
> +| |    |  |                -------------------     |    |    |  |                -------------------     |    |
> +| |                                |               |    |                                |               |    |
> +| |                                |               |    |                                |               |    |
> +| |                                |               |    |                                |               |    |
> +| |--------------------------------+---------------|    |--------------------------------+---------------|    |
> +|                                  |                                                       |                  |
> +|                                  |                                                       |                  |
> +|                                  |------------------------------+------------------------|                  |
> +|                                                                 |                                           |
> +|                                                                 |                                           |
> +|                                                   --------------------------                                |
> +|                                                    | M1 |   | M2 |   | M3 |                                 |
> +|                                                   --------------------------                                |
> +|                                                                                                             |
> +|                                                                                                             |
> +|-------------------------------------------------------------------------------------------------------------|
> +\end{lstlisting}
> +
> +An ISM(Internal Shared Memory) device provides the ability to access memory
> +shared between multiple devices. This allows low-overhead communication in
> +presence of such memory. For example, memory can be shared with guests of
> +multiple virtual machines running on the same host, with each virtual machine
> +including an ism device and with the guests getting the shared memory by the ism
> +devices.
> +
> +An ism device can communicate with multiple peers simultaneously. This
> +communication can be dynamically started and ended.
> +
> +All the devices with the ability to communicate with each other form a
> +communication domain. Two devices from different communication domains can't
> +communicate.
> +
> +The device memory of the ism device is divided into multiple chunks with the
> +same size. Every ism region contains multiple chunks. When communicating between
> +two devices, an ism region is used as a shared memory.
> +
> +The ism region is the basis for communication between ism devices.
> +
> +The process of communication between two drivers is that one driver allocates an
> +ism region and obtains a token. Then the peer uses this token to attach the same
> +ism region, the two drivers realize the memory(ism region) sharing. The driver
> +can also notify peer by kick notify-address the ism region has been updated.
> +
> +An ism region can be referred by its \field{token}, or the \field{offset}.
> +The \field{offset} is the offset of the first chunk inside the ism region
> +starting from the device memory head.
> +
> +\subsection{Device ID}\label{sec:Device Types / ISM Device / Device ID}
> +	44
> +
> +\subsection{Virtqueues}\label{sec:Device Types / ISM Device / Virtqueues}
> +\begin{description}
> +\item[0] controlq
> +\item[1] eventq
> +\end{description}
> +
> +\subsection{Feature bits}\label{sec:Device Types / ISM Device / Feature bits}
> +\begin{description}
> +\item[VIRTIO_ISM_F_DEV_MEM(0)] Device provide memory for ism region, driver
> +    don't need to provide memory for alloc/attach operation.
> +
> +\end{description}
> +
> +\subsection{Device configuration layout}\label{sec:Device Types / ISM Device / Device configuration layout}
> +
> +\begin{lstlisting}
> +struct virtio_ism_config {
> +	le128 cdid;
> +	le64 devid;
> +	le64 chunk_size;
> +	le64 notify_size;
> +};
> +\end{lstlisting}
> +
> +\begin{description}
> +    \item[\field{cdid}] This is used to identify the communication domain. Only
> +        ism devices with the same \field{cdid} can communicate. A \field{cdid}
> +        is world-wide unique in a sense that there not be another communication
> +        domain with the same \field{cdid}.
> +
> +    \item[\field{devid}] This is used to identify the ism device in the single
> +        communication domain.
> +
> +    \item[\field{chunk_size}] This is the size of the ism chunk. The device
> +        memory is divided into multiple chunks. Every ism chunk has the same
> +        size.
> +
> +    \item[\field{notify_size}] This is the size of the ism notify-address. The
> +        notify-address is used to notify the device that the content of the
> +        ism region has been updated.
> +
> +\end{description}
> +
> +\devicenormative{\subsubsection}{Device configuration layout}{Device Types / ISM Device / Device configuration layout}
> +
> +The device MUST ensure that the \field{cdid} of the device on the same
> +communication domain is same. The \field{cdid} MUST be a version 4 UUID as
> +specified by \hyperref[intro:rfc4122]{[RFC4122]}.
> +
> +In the single communication domain, the device MUST ensure that the \field{devid}
> +is unique.
> +
> +\field{chunk_size} MUST be a power of two.
> +
> +\subsection{Physical Memory}\label{sec:Device Types / ISM Device / Event}
> +
> +The ism region is on the device memory. It is a physical memory for driver, but
> +it is not for device. The device has the ability to modify the physical memory
> +corresponding to the device memory.
> +
> +If VIRTIO_ISM_F_DEV_MEM is not negotiated, physical memory comes from driver.
> +The driver pass its memory to the device when alloc a new ism region. The
> +device map this physical memory into an ism region. If VIRTIO_ISM_F_DEV_MEM
> +is negotiated, physical memory is provided by the device.
> +
> +For attach operation, if VIRTIO_ISM_F_DEV_MEM is not negotiated, the driver also
> +provides memory to device. Under normal circumstances, this memory will not be
> +used. This is to limit driver to take up too much memory based on attach
> +operation.
> +
> +\subsection{Event}\label{sec:Device Types / ISM Device / Event}
> +
> +The ism device supports event notification of the ism region. When a device
> +kick/attach/detach a region, other ism region referrers will receive related
> +events.
> +
> +A buffer received from eventq can contain multiple event structures.
> +
> +\begin{lstlisting}
> +#define   VIRTIO_ISM_EVENT_UPDATE (1 << 0)
> +#define   VIRTIO_ISM_EVENT_ATTACH (1 << 1)
> +#define   VIRTIO_ISM_EVENT_DETACH (1 << 2)
> +#define   VIRTIO_ISM_EVENT_BUFFER_FREE (1 << 3)  // Only if VIRTIO_ISM_F_DEV_MEM is not negotiated
> +\end{lstlisting}
> +
> +\begin{description}
> +    \item[VIRTIO_ISM_EVENT_UPDATE] The driver kick the notify-address to notify
> +        other peers of the update event of the ism region content.
> +
> +    \item[VIRTIO_ISM_EVENT_ATTACH] A new device attaches the ism region.
> +    \item[VIRTIO_ISM_EVENT_DETACH] A device detaches the ism region.
> +    \item[VIRTIO_ISM_EVENT_BUFFER_FREE] The buffer allocated by this driver has been free.
> +\end{description}
> +
> +The event structures:
> +\begin{lstlisting}
> +struct virtio_ism_event_update {
> +	le64 ev_type;
> +	le64 offset;
> +	le64 devid;
> +};
> +
> +struct virtio_ism_event_attach_detach {
> +	le64 ev_type;
> +	le64 offset;
> +	le64 devid;
> +	le64 peers;
> +};
> +
> +struct virtio_ism_event_buffer_free {
> +	le64 ev_type;
> +    void *buffer;
> +};
> +
> +\end{lstlisting}
> +
> +\begin{description}
> +\item[\field{ev_type}] The type of event, the driver can get the size of the
> +    structure based on this.
> +
> +        If \field{ev_type} is VIRTIO_ISM_EVENT_UPDATE, the corresponding structure is struct virtio_ism_event_update.
> +        If \field{ev_type} is VIRTIO_ISM_EVENT_ATTACH or VIRTIO_ISM_EVENT_DETACH, the corresponding structure struct virtio_ism_event_attach_detach.
> +        If \field{ev_type} is VIRTIO_ISM_EVENT_BUFFER_FREE, the corresponding structure is struct virtio_ism_event_buffer_free.
> +
> +\item[\field{offset}] The offset of ism regions with the event.
> +
> +\item[\field{devid}] \field{devid} of the device that generated events.
> +\item[\field{peers}] The number of the peers referring to this ism region. (does not include the
> +    device that receiving this event)
> +
> +\item[\field{buffer}] The buffer passed to device when alloc/attach a new ism region.
> +
> +\end{description}
> +
> +\subsection{Permissions}\label{sec:Device Types / ISM Device / Permission}
> +
> +The permissions of an ism region determine whether this ism region can be
> +attached and the read and write permissions after attach. The driver can set the
> +default permissions for all devices, or set the dedicated permissions for a
> +certain device. If there are dedicated permissions for a device, the default
> +permissions are invalid for this device.
> +
> +For example, the driver can set the default permission of an ism region as
> +read-only, and set the dedicated permissions as writable for a device with devid
> +0xff. Then all devices except 0xff in such a communication domain can attach
> +this ism region and only have read-only permission. And the device 0xff can
> +write to the ism region after attaching.
> +
> +When a driver has the management permission of the ism region, then it can
> +modify the permissions of this ism region. By default, only the device that
> +allocated the ism region has this permission.
> +
> +\subsection{Device Initialization}\label{sec:Device Types / ISM Device / Device Initialization}
> +
> +\devicenormative{\subsubsection}{Device Initialization}{Device Types / ISM Device / Device Initialization}
> +
> +The device MUST generate a \field{devid}. \field{devid} remains unchanged
> +during reset. \field{devid} MUST NOT be 0.
> +
> +The device exposes memory to the driver based on Shared Memory Regions
> +\ref{sec:Basic Facilities of a Virtio Device / Shared Memory Regions}.
> +However, it does not need to allocate physical memory during initialization.
> +
> +The \field{shmid} of a region MUST be one of the following
> +\begin{lstlisting}
> +enum virtio_ism_shm_id {
> +	VIRTIO_ISM_SHM_ID_UNDEFINED = 0,
> +	VIRTIO_ISM_SHM_ID_REGIONS   = 1,
> +	VIRTIO_ISM_SHM_ID_NOTIFY    = 2,
> +};
> +\end{lstlisting}
> +
> +The device memory area with VIRTIO_ISM_SHM_ID_REGIONS is used to provide ism regions.
> +
> +The device MUST also provide a memory area with VIRTIO_ISM_SHM_ID_NOTIFY to the
> +driver. This memory area is used to notify the device with update event, and
> +each ism region MUST have a corresponding notify-address inside this area, and
> +the size of the notify-address is \field{notify_size}.
> +
> +\drivernormative{\subsubsection}{Device Initialization}{Device Types / ISM Device / Device Initialization}
> +
> +The driver MUST NOT access any chunk before it is referred by one ism region.
> +
> +\subsection{Control Virtqueue}\label{sec:Device Types / ISM Device / Control Virtqueue}
> +
> +The driver uses the control virtqueue send commands to implement operations on
> +the ism region and some global configurations.
> +
> +All commands are of the following form:
> +\begin{lstlisting}
> +struct virtio_ism_ctrl {
> +	u8 class;
> +	u8 command;
> +	u8 command_specific_data[];
> +	u8 ack;
> +	u8 command_specific_data_reply[];
> +};
> +
> +/* ack values */
> +#define VIRTIO_ISM_OK      0
> +#define VIRTIO_ISM_ERR     255
> +
> +#define VIRTIO_ISM_ENOENT  2
> +#define VIRTIO_ISM_E2BIG   7
> +#define VIRTIO_ISM_ENOMEM  12
> +#define VIRTIO_ISM_ENOSPEC 28
> +
> +#define VIRTIO_ISM_PERM_EATTACH 100
> +#define VIRTIO_ISM_PERM_EREAD   101
> +#define VIRTIO_ISM_PERM_EWRITE  102
> +\end{lstlisting}
> +
> +The \field{class}, \field{command} and command-specific-data are set by the
> +driver, and the device sets the \field{ack} byte and optionally
> +\field{command-specific-data-reply}.
> +
> +\subsection{Device Operation}\label{sec:Device Types / ISM Driver / Device Operation}
> +
> +\subsubsection{Alloc ISM Region}\label{sec:Device Types / ISM Device / Device Operation / Alloc ISM Region}
> +
> +Based on controlq, the driver can request to allocate an ism region.
> +
> +The reply from the device will carry a token, which can be passed
> +to other driver for attaching to this ism region.
> +
> +The \field{command_specific_data} has the following format:
> +\begin{lstlisting}
> +struct virtio_ism_ctrl_alloc {
> +	le64 size;
> +    void *buffer; // Only if VIRTIO_ISM_F_DEV_MEM is not negotiated
> +};
> +\end{lstlisting}
> +
> +The \field{command_specific_data_reply} has the following format:
> +\begin{lstlisting}
> +struct virtio_ism_ctrl_alloc_reply {
> +	le64 token;
> +	le64 num;
> +    le64 chunks[];
> +};
> +\end{lstlisting}
> +
> +The \field{class} and \field{command}:
> +\begin{lstlisting}
> +#define VIRTIO_ISM_CTRL_ALLOC  0
> +	#define VIRTIO_ISM_CTRL_ALLOC_REGION 0
> +\end{lstlisting}
> +
> +
> +\devicenormative{\subparagraph}{Alloc ISM Region}{Device Types / ISM Device / Device Operation / Alloc ISM Region}
> +
> +For the command VIRTIO_ISM_CTRL_ALLOC_REGION, the device MUST first look for the
> +free chunks from the device memory. And the physical memory is mapped to these
> +chunks in order. If VIRTIO_ISM_F_DEV_MEM is negotiated, then the device MUST
> +provide physical memory by itself. Otherwise, the memory provided by the driver
> +will be used. If there is no enough free chunk, the device MUST set \field{ack}
> +to VIRTIO_ISM_NOSPEC. If new physical memory cannot be allocated by the device,
> +the device MUST set \field{ack} to VIRTIO_ISM_NOMEM.
> +
> +The device sets \field{ack} to VIRTIO_ISM_OK after successfully allocating the
> +ism region. A new token MUST be dynamically created for this ism region
> +simultaneously. The token MUST be unique inside this communication domain. And
> +the device MUST fill \filed{chunks} with the offset of each chunk. \field{num}
> +is the number of the chunks.
> +
> +The device MUST clear the memory of this ism region before committing to the
> +driver.
> +
> +If \field{size} is smaller than \field{chunk_size}, the ism region also
> +occupies one chunk.
> +
> +If virtio_ism_ctrl_alloc_reply is not enough, the device MUST set the \field{ack}
> +to VIRTIO_ISM_E2BIG.
> +
> +\drivernormative{\subparagraph}{Alloc ISM Region}{Device Types / ISM Device / Device Operation / Alloc ISM Region}
> +
> +If VIRTIO_ISM_F_DEV_MEM is not negotiated, the driver MUST provide the buffer
> +with \field{buffer}. The size of the buffer MUST equal to the size of the ism
> +region that we want to allocate.
> +
> +\subsubsection{Query ISM Region}\label{sec:Device Types / ISM Device / Device Operation / Query ISM Region}
> +Based on controlq, the driver can query the information of an ism region.
> +
> +The \field{command_specific_data} has the following format:
> +\begin{lstlisting}
> +struct virtio_ism_ctrl_query {
> +	le64 token;
> +};
> +\end{lstlisting}
> +
> +The \field{command_specific_data_reply} has the following format:
> +\begin{lstlisting}
> +struct virtio_ism_ctrl_query_reply {
> +	le64 size;
> +	le64 permissions;
> +};
> +\end{lstlisting}
> +
> +The \field{class} and \field{command}:
> +\begin{lstlisting}
> +#define VIRTIO_ISM_CTRL_QUERY  1
> +	#define VIRTIO_ISM_CTRL_QUERY_INFO 0
> +\end{lstlisting}
> +
> +\devicenormative{\subparagraph}{Query ISM Region}{Device Types / ISM Device / Device Operation / Query ISM Region}
> +
> +If the ism region specified by \field{token} does not exist, the device MUST set
> +\field{ack} to VIRTIO_ISM_ENOENT. Otherwise, the device MUST fill the
> +\field{size} with the size of the ism region. The device MUST get the
> +permissions of this ism region for the device-self, then fill in the
> +\field{permissions}.
> +
> +\subsubsection{Attach ISM Region}\label{sec:Device Types / ISM Device / Device Operation / Attach ISM Region}
> +
> +Based on controlq, the driver can request to attach an ism region with a
> +specified token.
> +
> +The \field{command_specific_data} has the following format:
> +\begin{lstlisting}
> +struct virtio_ism_ctrl_attach {
> +	le64 token;
> +	le64 rw_perm;
> +    void *buffer; // Only if VIRTIO_ISM_F_DEV_MEM is not negotiated
> +};
> +\end{lstlisting}
> +
> +The \field{command_specific_data_reply} has the following format:
> +\begin{lstlisting}
> +struct virtio_ism_ctrl_attach_reply {
> +	le64 size;
> +	le64 num;
> +    le64 chunks[];
> +};
> +\end{lstlisting}
> +
> +The \field{class} and \field{command}:
> +\begin{lstlisting}
> +#define VIRTIO_ISM_CTRL_ATTACH  2
> +	#define VIRTIO_ISM_CTRL_ATTACH_REGION 0
> +\end{lstlisting}
> +
> +\devicenormative{\subparagraph}{Attach ISM Region}{Device Types / ISM Device / Device Operation / Attach ISM Region}
> +
> +If the ism region specified by \field{token} does not exist, the device MUST set
> +\field{ack} to VIRTIO_ISM_ENOENT.
> +
> +The device MUST first look for the free chunks from the device memory. And the
> +physical memory of the ism region is mapped to these chunks in order. If there is
> +no enough free chunk, the device MUST set \field{ack} to VIRTIO_ISM_NOSPEC.
> +The device MUST fill \filed{chunks} with the offset of each chunk. \field{num}
> +is the number of the chunks. \field{size} is the size of this ism region.
> +
> +The device MUST set \field{ack} to VIRTIO_ISM_OK after successfully finding and
> +assigning the physical memory of this ism region into the device memory.
> +
> +If the device does not have the VIRTIO_ISM_PERM_ATTACH permission for this ism
> +region, the device MUST set \field{ack} to VIRTIO_ISM_PERM_EATTACH. If
> +\field{rw_perm} include VIRTIO_ISM_PERM_READ, but the device does not have the
> +VIRTIO_ISM_PERM_READ permission for this region, the device MUST set \field{ack}
> +to VIRTIO_ISM_PERM_EREAD. If \field{rw_perm} include VIRTIO_ISM_PERM_WRITE, but
> +the device does not have the VIRTIO_ISM_PERM_WRITE permission for this region,
> +the device MUST set \field{ack} to VIRTIO_ISM_PERM_EWRITE.
> +
> +The device MUST set the read and write permissions of the physical memory inside
> +the device memory based on \field{rw_perm}.
> +
> +If virtio_ism_ctrl_alloc_reply is not enough, the device MUST set the \field{ack}
> +to VIRTIO_ISM_E2BIG and set the \field{num} for next request.
> +
> +The device MUST generate a VIRTIO_ISM_EVENT_ATTACH event to other peers.
> +
> +\drivernormative{\subparagraph}{Attach ISM Region}{Device Types / ISM Device / Device Operation / Attach ISM Region}
> +
> +If VIRTIO_ISM_F_DEV_MEM is not negotiated, the driver MUST provide the buffer
> +with \field{buffer}. The size of the buffer MUST equal to the size of the ism
> +region that we want to allocate.
> +
> +If \field {size} is less than \field{num} times \field {chunk_size}, then only
> +header part of the last chunk is effective.
> +
> +\subsubsection{Detach ISM Region}\label{sec:Device Types / ISM Device / Device Operation / Detach ISM Region}
> +Based on controlq, the device can release references to the ism region.
> +
> +The \field{command_specific_data} has the following format:
> +\begin{lstlisting}
> +struct virtio_ism_ctrl_detach {
> +	le64 token;
> +};
> +\end{lstlisting}
> +
> +The \field{class} and \field{command}:
> +\begin{lstlisting}
> +#define VIRTIO_ISM_CTRL_DETACH  3
> +	#define VIRTIO_ISM_CTRL_DETACH_REGION 0
> +\end{lstlisting}
> +
> +\devicenormative{\subparagraph}{Detach ISM Region}{Device Types / ISM Device / Device Operation / Detach ISM Region}
> +
> +If the ism region specified by \field{token} is not attached, the device MUST set
> +\field{ack} to VIRTIO_ISM_ENOENT.
> +
> +The device MUST generate a VIRTIO_ISM_EVENT_DETACH event to other peers.
> +
> +If VIRTIO_ISM_F_DEV_MEM is not negotiated and no one is referred to this ism
> +region, the device who allocated this ism region MUST generate a
> +VIRTIO_ISM_EVENT_BUFFER_FREE event to the driver.
> +
> +\drivernormative{\subparagraph}{Detach ISM Region}{Device Types / ISM Device / Device Operation / Detach ISM Region}
> +
> +If VIRTIO_ISM_F_DEV_MEM is not negotiated and the driver got the ism region by
> +attach operation, then the buffer is free after the detach operation.
> +
> +\subsubsection{Grant ISM Region}\label{sec:Device Types / ISM Device / Device Operation / Grant ISM Region}
> +Based on controlq, the driver can set the permissions for each ism
> +region.
> +
> +The \field{command_specific_data} has the following format:
> +\begin{lstlisting}
> +struct virtio_ism_ctrl_grant_default {
> +	le64 token;
> +	le64 permissions;
> +};
> +
> +struct virtio_ism_ctrl_grant_dev {
> +	le64 token;
> +	le64 permissions;
> +	le64 peer_devid;
> +};
> +\end{lstlisting}
> +
> +The \field{class} and \field{command}:
> +\begin{lstlisting}
> +#define VIRTIO_ISM_CTRL_GRANT  4
> +	#define VIRTIO_ISM_CTRL_GRANT_SET_DEFAULT    0
> +	#define VIRTIO_ISM_CTRL_GRANT_SET_FOR_DEVICE 1
> +\end{lstlisting}
> +
> +The permissions:
> +\begin{lstlisting}
> +#define VIRTIO_ISM_PERM_READ       (1 << 0)
> +#define VIRTIO_ISM_PERM_WRITE      (1 << 1)
> +
> +#define VIRTIO_ISM_PERM_ATTACH     (1 << 2)
> +
> +#define VIRTIO_ISM_PERM_MANAGE     (1 << 3)
> +#define VIRTIO_ISM_PERM_CLEAN_DEFAULT     (1 << 4)
> +\end{lstlisting}
> +
> +\begin{description}
> +\item[VIRTIO_ISM_PERM_READ] read permission
> +\item[VIRTIO_ISM_PERM_WRITE] write permission
> +\item[VIRTIO_ISM_PERM_ATTACH] attach permission
> +
> +\item[VIRTIO_ISM_PERM_MANAGE] Management permission, the device with this
> +	permission can modify the permission of this ism region. By default, only
> +	the device that allocated the region has this permission.
> +
> +\item[VIRTIO_ISM_PERM_DENY_DEFAULT] Clean all permissions of default, just used
> +    with VIRTIO_ISM_CTRL_GRANT_SET_FOR_DEVICE.
> +
> +\end{description}
> +
> +VIRTIO_ISM_CTRL_GRANT_SET_DEFAULT corresponds to virtio_ism_ctrl_grant_default;
> +VIRTIO_ISM_CTRL_GRANT_SET_FOR_DEVICE corresponds to virtio_ism_ctrl_grant_dev;
> +
> +Permission control is divided into two categories, one is the dedicated
> +permissions for a certain device, and the other is the default permissions for
> +all device.
> +
> +\devicenormative{\subparagraph}{Grant ISM Region}{Device Types / ISM Device / Device Operation / Grant ISM Region}
> +
> +If the ism region specified by \field{token} is not attached, the device MUST set
> +\field{ack} to VIRTIO_ISM_ENOENT.
> +
> +The default permissions of the newly allocated ism region MUST be  (VIRTIO_ISM_PERM_READ | VIRTIO_ISM_PERM_WRITE | VIRTIO_ISM_PERM_ATTACH).
> +The device that allocated the ism region MUST have the permissions (VIRTIO_ISM_PERM_READ | VIRTIO_ISM_PERM_WRITE | VIRTIO_ISM_PERM_ATTACH | VIRTIO_ISM_PERM_MANAGE) for this region.
> +
> +For a certain device, if there is dedicated permissions, the default
> +permissions are illegal to this device.
> +
> +\subsubsection{Inform Update Event IRQ Vector}\label{sec:Device Types / ISM Device / Device Operation / Inform Update Event IRQ Vector}
> +
> +For the ism region update event, the driver can bind an interrupt to the ism
> +region. Then this ism region's update event will no longer be passed through
> +eventq, but the interrupt will be directly triggered.
> +
> +The \field{command_specific_data} has the following format:
> +\begin{lstlisting}
> +struct virtio_ism_ctrl_irq_vector {
> +	le64 token;
> +	le64 vector;
> +};
> +\end{lstlisting}
> +
> +The \field{class} and \field{command}:
> +\begin{lstlisting}
> +#define VIRTIO_ISM_CTRL_EVENT_VECTOR  5
> +	#define VIRTIO_ISM_CTRL_EVENT_VECTOR_SET 0
> +\end{lstlisting}
> +
> +
> +\devicenormative{\subparagraph}{Inform Event IRQ Vector}{Device Types / ISM Device / Device Operation / Inform Event IRQ Vector}
> +
> +The device MUST record the relationship between the ism region and the vector
> +notified by the driver, and notify the update event of this region to driver
> +by the corresponding vector. And the device MUST NOT use eventq to send the
> +update event of this ism region.
> +
> +
> --
> 2.32.0.3.g01195cf9f
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

