Return-Path: <virtio-dev-return-12753-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4F1CC7EE22
	for <virtio-dev@archiver.kernel.org>; Thu, 18 May 2023 08:09:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 5AD061090
	for <virtio-dev@archiver.kernel.org>; Thu, 18 May 2023 08:09:30 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 54D1E986701
	for <virtio-dev@archiver.kernel.org>; Thu, 18 May 2023 08:09:30 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 4381E9866F7; Thu, 18 May 2023 08:09:30 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 31CA89866FA;
	Thu, 18 May 2023 08:09:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R231e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0Viw104x_1684397360;
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
	xuanzhuo@linux.alibaba.com,
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
Date: Thu, 18 May 2023 16:09:19 +0800
Message-Id: <20230518080919.48797-2-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20230518080919.48797-1-xuanzhuo@linux.alibaba.com>
References: <20230518080919.48797-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: 7478fa9
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] [PATCH v4 1/1] virtio-ism: introduce new device virtio-ism

An ISM(Internal Shared Memory) device provides the ability to access memory
shared between multiple devices. This allows low-overhead communication in
presence of such memory. For example, memory can be shared with guests of
multiple virtual machines running on the same host, with each virtual machine
including an ism device and with the guests getting the shared memory by the ism
devices.

An ism device can communicate with multiple peers simultaneously. This
communication can be dynamically started and ended.

|-------------------------------------------------------------------------------------------------------------|
| |------------------------------------------------|       |------------------------------------------------| |
| | Guest                                          |       | Guest                                          | |
| |                                                |       |                                                | |
| |   ----------------                             |       |   ----------------                             | |
| |   |    driver    |     [M1]   [M2]   [M3]      |       |   |    driver    |             [M2]   [M3]     | |
| |   ----------------       |      |      |       |       |   ----------------               |      |      | |
| |    |cq|                  |map   |map   |map    |       |    |cq|                          |map   |map   | |
| |    |  |                  |      |      |       |       |    |  |                          |      |      | |
| |    |  |                -------------------     |       |    |  |                --------------------    | |
| |----|--|----------------|  device memory  |-----|       |----|--|----------------|  device memory   |----| |
| |    |  |                -------------------     |       |    |  |                --------------------    | |
| |                                |               |       |                               |                | |
| |                                |               |       |                               |                | |
| |                                |               |       |                               |                | |
| |--------------------------------+---------------|       |-------------------------------+----------------| |
|                                  |                                                       |                  |
|                                  |                                                       |                  |
|                                  |------------------------------+------------------------|                  |
|                                                                 |                                           |
|                                                                 |                                           |
|                                                   --------------------------                                |
|                                                    | M1 |   | M2 |   | M3 |                                 |
|                                                   --------------------------                                |
|                                                                                                             |
| HOST                                                                                                        |
---------------------------------------------------------------------------------------------------------------

Inside the guest, all operations of the ism region are implemented through the
driver, and the ism region can be used by other subsystems of the kernel
space, or directly used by user applications.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
Signed-off-by: Dust Li <dust.li@linux.alibaba.com>
Signed-off-by: Tony Lu <tonylu@linux.alibaba.com>
Signed-off-by: Helin Guo <helinguo@linux.alibaba.com>
Signed-off-by: Hans Zhang <hans@linux.alibaba.com>
Signed-off-by: He Rongguang <herongguang@linux.alibaba.com>
Suggested-by: Halil Pasic <pasic@linux.ibm.com>
---
 conformance.tex                         |   2 +
 content.tex                             |   1 +
 device-types/ism/description.tex        | 591 ++++++++++++++++++++++++
 device-types/ism/device-conformance.tex |  17 +
 device-types/ism/driver-conformance.tex |  13 +
 device-types/ism/layout-pic.tex         | 112 +++++
 virtio-html.tex                         |   9 +
 virtio.tex                              |   9 +
 8 files changed, 754 insertions(+)
 create mode 100644 device-types/ism/description.tex
 create mode 100644 device-types/ism/device-conformance.tex
 create mode 100644 device-types/ism/driver-conformance.tex
 create mode 100644 device-types/ism/layout-pic.tex

diff --git a/conformance.tex b/conformance.tex
index 01ccd69..8fd7da3 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -152,6 +152,7 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
 \input{device-types/scmi/driver-conformance.tex}
 \input{device-types/gpio/driver-conformance.tex}
 \input{device-types/pmem/driver-conformance.tex}
+\input{device-types/ism/driver-conformance.tex}
 
 \conformance{\section}{Device Conformance}\label{sec:Conformance / Device Conformance}
 
@@ -238,6 +239,7 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
 \input{device-types/scmi/device-conformance.tex}
 \input{device-types/gpio/device-conformance.tex}
 \input{device-types/pmem/device-conformance.tex}
+\input{device-types/ism/device-conformance.tex}
 
 \conformance{\section}{Legacy Interface: Transitional Device and Transitional Driver Conformance}\label{sec:Conformance / Legacy Interface: Transitional Device and Transitional Driver Conformance}
 A conformant implementation MUST be either transitional or
diff --git a/content.tex b/content.tex
index cff548a..737cdb1 100644
--- a/content.tex
+++ b/content.tex
@@ -710,6 +710,7 @@ \chapter{Device Types}\label{sec:Device Types}
 \input{device-types/scmi/description.tex}
 \input{device-types/gpio/description.tex}
 \input{device-types/pmem/description.tex}
+\input{device-types/ism/description.tex}
 
 \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
 
diff --git a/device-types/ism/description.tex b/device-types/ism/description.tex
new file mode 100644
index 0000000..8ea0c57
--- /dev/null
+++ b/device-types/ism/description.tex
@@ -0,0 +1,591 @@
+\section{ISM Device}\label{sec:Device Types / ISM Device}
+
+\resizebox{\textwidth}{!}{%
+\input{device-types/ism/layout-pic.tex}
+}%
+
+An ISM(Internal Shared Memory) device provides the ability to access memory
+shared between multiple devices. This allows low-overhead communication in
+presence of such memory. For example, memory can be shared with guests of
+multiple virtual machines running on the same host, with each virtual machine
+including an ism device and with the guests getting the shared memory by the ism
+devices.
+
+An ism device can communicate with multiple peer devices simultaneously. This
+communication can be dynamically started and ended.
+
+\subsection{Device ID}\label{sec:Device Types / ISM Device / Device ID}
+	44
+
+\subsection{Virtqueues}\label{sec:Device Types / ISM Device / Virtqueues}
+\begin{description}
+\item[0] controlq
+\item[1] eventq
+\end{description}
+
+\subsection{Feature bits}\label{sec:Device Types / ISM Device / Feature bits}
+
+\subsection{Communication Domain}\label{sec:Device Types / ISM Device / Communication Domain}
+
+All the devices with the ability to communicate with each other form a
+communication domain. Two devices from different communication domains can't
+communicate.
+
+\devicenormative{\subsubsection}{Communication Domain}{Device Types / ISM Device / Communication Domain}
+
+Only ism devices on the same communication domain can communicate. Every
+communication domain has an identification called \field{cdid}. The \field{cdid}
+is world-wide unique in a sense that there not be another communication domain
+with the same \field{cdid}.
+
+The \field{cdid} MUST be a version 4 UUID as specified by \hyperref[intro:
+rfc4122]{[RFC4122]}.
+
+\subsection{Memory}\label{sec:Device Types / ISM Device / Memory}
+
+\subsubsection{Shared Memory Regions}\label{sec:Device Types / ISM Device / Memory / Shared Memory Regions}
+
+The device exposes memory to the driver based on Shared Memory Regions
+\ref{sec:Basic Facilities of a Virtio Device / Shared Memory Regions}.
+
+The \field{shmid} of a shared memory region MUST be one of the following
+\begin{lstlisting}
+enum virtio_ism_shm_id {
+	VIRTIO_ISM_SHM_ID_UNDEFINED = 0,
+	VIRTIO_ISM_SHM_ID_REGIONS   = 1,
+	VIRTIO_ISM_SHM_ID_NOTIFY    = 2,
+};
+\end{lstlisting}
+
+The shared memory region with VIRTIO_ISM_SHM_ID_REGIONS is the ism regions
+area. The ism regions are located in here.
+
+The device MUST also provide a shared memory region with
+VIRTIO_ISM_SHM_ID_NOTIFY to the driver. This is the notification area.
+This area is used to notify the device with update event. Each ism chunk
+have a corresponding notify-address inside this area in order, and the size
+of the notify-address is \field{notify_size}.
+
+\subsubsection{Chunk And ISM Region}\label{sec:Device Types / ISM Device / Memory / Chunk And ISM Region}
+
+The ism regions area is divided into multiple chunks with the same size.
+
+The object of each driver operation is an ism region. It consists of at least
+one chunk.
+
+An ism region can be referred by its \field{token}, or the \field{offset}.
+The \field{offset} is the offset of the first chunk inside the ism regions area.
+
+\devicenormative{\paragraph}{Chunk And ISM Region}{Device Types / ISM Device / Memory / Chunk And ISM Region}
+
+\field{chunk_size} MUST be a multiple of the page size.
+
+
+\subsubsection{Physical Memory}\label{sec:Device Types / ISM Device / Memory / Physical Memory}
+
+The ism region is located in the ism regions area. For the driver, the ism
+regions area is physical memory. But for the device, it is a virtual space that
+devices can map into using different physical memory, as determined by the
+device. The device can manage whether each chunk is mapped to a physical memory,
+or modify the memory it mapped.
+
+For example, for a certain chunk A on the driver A's ism regions area, the
+device can use a physical memory A to map into chunk A, so that driver A's
+modification on the chunk A will be reflected in this physical memory A. When a
+physical memory B is mapped to chunk A by the device, the modification on chunk
+A will be reflected on physical memory B. If another device maps physical memory
+B simultaneously to its ism regions area chunk C, then the driver corresponding
+to this device can see the modification of the driver A on chunk C.
+
+\subsubsection{Swap Buffer}\label{sec:Device Types / ISM Device / Memory / Chunk And ISM Region}
+
+For attach/alloc operations, the driver also provides a buffer of the same size
+as the ism region to the device. This buffer is the swap buffer. This is to
+limit the driver to take up too much memory through the virtio ism device. And
+the swap buffer may be used by the device.
+
+For the alloc operation, the device need to choose a physical memory to map,
+which can be the swap buffer or memory from the device. If the memory of the
+device is used to map, the current driver can do detach at any time and the swap
+buffer is free immediately. But if the device use the swap buffer to map, after
+this driver detached the ism region, it needs to wait for other users to release
+the reference to the swap buffer before reclaiming the swap buffer.
+
+\devicenormative{\paragraph}{Swap Buffer}{Device Types / ISM Device / Memory / Swap Buffer}
+Before the swap buffer is free, the driver MUST NOT access the swap buffer.
+
+After the detach operation, if the swap buffer is not free, the driver MUST NOT
+access the swap buffer until it receives the VIRTIO_ISM_EVENT_SWAPBUF_RELEASE
+event.
+
+\drivernormative{\paragraph}{Swap Buffer}{Device Types / ISM Device / Memory / Swap Buffer}
+The swap buffer MUST be page-aligned.
+
+\subsection{Event}\label{sec:Device Types / ISM Device / Event}
+
+The ism device supports event notification of the ism region. When a device
+kick/attach/detach a region, other ism region referrers will receive related
+events.
+
+A buffer received from eventq can contain multiple event structures.
+
+\begin{lstlisting}
+#define VIRTIO_ISM_EVENT_UPDATE			(1 << 0)
+#define VIRTIO_ISM_EVENT_ATTACH			(1 << 1)
+#define VIRTIO_ISM_EVENT_DETACH			(1 << 2)
+#define VIRTIO_ISM_EVENT_SWAPBUF_RELEASE	(1 << 3)
+\end{lstlisting}
+
+\begin{description}
+    \item[VIRTIO_ISM_EVENT_UPDATE] The driver kick the notify-address to notify
+        other peers of the update event of the ism region content.
+
+    \item[VIRTIO_ISM_EVENT_ATTACH] A new device attaches the ism region.
+    \item[VIRTIO_ISM_EVENT_DETACH] A device detaches the ism region.
+    \item[VIRTIO_ISM_EVENT_SWAPBUF_RELEASE] The swap buffer has been free.
+\end{description}
+
+The event structures:
+\begin{lstlisting}
+struct virtio_ism_event_update {
+	le64 ev_type;
+	le64 offset;
+	le64 devid;
+};
+
+struct virtio_ism_event_attach_detach {
+	le64 ev_type;
+	le64 offset;
+	le64 devid;
+	le64 peers;
+};
+
+struct virtio_ism_event_buffer_free {
+	le64 ev_type;
+	le64 swap_buffer;
+};
+
+\end{lstlisting}
+
+\begin{description}
+\item[\field{ev_type}] The type of event, the driver can get the size of the
+    structure based on this.
+
+        If \field{ev_type} is VIRTIO_ISM_EVENT_UPDATE, the corresponding structure is struct virtio_ism_event_update.
+        If \field{ev_type} is VIRTIO_ISM_EVENT_ATTACH or VIRTIO_ISM_EVENT_DETACH, the corresponding structure struct virtio_ism_event_attach_detach.
+        If \field{ev_type} is VIRTIO_ISM_EVENT_SWAPBUF_RELEASE, the corresponding structure is struct virtio_ism_event_buffer_free.
+
+\item[\field{offset}] The offset of the first chunk of the ism region with the event.
+
+\item[\field{devid}] \field{devid} of the device that generated this event.
+\item[\field{peers}] The number of the peers referring to this ism region. (does not include the
+    device that receiving this event)
+
+\item[\field{swap_buffer}] The swap buffer passed to device when alloc/attach a new ism region.
+
+\end{description}
+
+\drivernormative{\subsubsection}{Event}{Device Types / ISM Device / Event}
+
+The driver MUST generate update events with the notify-address corresponding to
+the first chunk of the ism region.
+
+\subsection{Process Of Sharing Memory}\label{sec:Device Types / ISM Device / Process Of Sharing Memory}
+
+The process of sharing memory between two drivers is:
+
+\begin{itemize}
+\item One driver allocates an ism region and obtains a token.
+\item The peer driver uses this token to attach the same ism region.
+    Then the two drivers realize the memory(ism region) sharing.
+\item One driver can notify the peer driver an update event by kick notify-address.
+\item The driver can detach the ism region to stop the sharing.
+\end{itemize}
+
+\subsection{Permission}\label{sec:Device Types / ISM Device / Permission}
+
+The permissions of an ism region determine whether this ism region can be
+attached and the read and write permissions after attach. The driver can set the
+default permissions for all devices, or set the dedicated permissions for a
+certain device. If there are dedicated permissions for a device, the default
+permissions are invalid for this device.
+
+For example, the driver can set the default permission of an ism region as
+read-only, and set the dedicated permissions as writable for a device with devid
+0xff. Then all devices except 0xff in such a communication domain can attach
+this ism region and only have read-only permission. And the device 0xff can
+write to the ism region after attaching.
+
+When a driver has the management permission of the ism region, then it can
+modify the permissions of this ism region. By default, only the device that
+allocated the ism region has this permission.
+
+\subsection{Device configuration layout}\label{sec:Device Types / ISM Device / Device configuration layout}
+
+\begin{lstlisting}
+struct virtio_ism_config {
+	u8 cdid[16];
+	le64 devid;
+	le64 chunk_size;
+	le64 notify_size;
+};
+\end{lstlisting}
+
+\begin{description}
+    \item[\field{cdid}] This is the identification of the communication domain to which the device belongs.
+    \item[\field{devid}] This is the identification of the ism device in the communication domain.
+    \item[\field{chunk_size}] This is the size of the chunk.
+    \item[\field{notify_size}] This is the size of the ism notify-address.
+\end{description}
+
+\devicenormative{\subsubsection}{Device configuration layout}{Device Types / ISM Device / Device configuration layout}
+
+The device MUST ensure that the \field{cdid} of the device on the same
+communication domain is same.
+
+In the single communication domain, the device MUST ensure that the \field{devid}
+is unique.
+
+\subsection{Device Initialization}\label{sec:Device Types / ISM Device / Device Initialization}
+
+\devicenormative{\subsubsection}{Device Initialization}{Device Types / ISM Device / Device Initialization}
+
+The device MUST generate a \field{devid}. \field{devid} remains unchanged
+during reset. \field{devid} MUST NOT be 0.
+
+\drivernormative{\subsubsection}{Device Initialization}{Device Types / ISM Device / Device Initialization}
+
+The driver MUST NOT access any chunk before it is referred by one ism region.
+
+\subsection{Control Virtqueue}\label{sec:Device Types / ISM Device / Control Virtqueue}
+
+The driver uses the control virtqueue to send commands to implement operations
+on the ism region and some global configurations.
+
+All commands are of the following form:
+\begin{lstlisting}
+struct virtio_ism_ctrl {
+	u8 class;
+	u8 command;
+	u8 command_specific_data[];
+
+#define VIRTIO_ISM_OK      0
+#define VIRTIO_ISM_ERR     255
+
+#define VIRTIO_ISM_WAIT_SWAP_BUFF     254
+
+#define VIRTIO_ISM_ENOENT  2
+#define VIRTIO_ISM_E2BIG   7
+#define VIRTIO_ISM_ENOMEM  12
+#define VIRTIO_ISM_ENOSPEC 28
+
+#define VIRTIO_ISM_PERM_EATTACH 100
+#define VIRTIO_ISM_PERM_EREAD   101
+#define VIRTIO_ISM_PERM_EWRITE  102
+	u8 ack;
+	u8 command_specific_data_reply[];
+};
+
+\end{lstlisting}
+
+The \field{class}, \field{command} and command-specific-data are set by the
+driver, and the device sets the \field{ack} byte and optionally
+\field{command-specific-data-reply}.
+
+%% device operations
+
+\subsection{Device Operation}\label{sec:Device Types / ISM Driver / Device Operation}
+
+\subsubsection{Alloc ISM Region}\label{sec:Device Types / ISM Device / Device Operation / Alloc ISM Region}
+
+Based on controlq, the driver can request to allocate an ism region.
+
+The reply from the device will carry a token, which can be passed
+to other driver for attaching to this ism region.
+
+The \field{command_specific_data} has the following format:
+\begin{lstlisting}
+struct virtio_ism_ctrl_alloc {
+	le64 size;
+	le64 swap_buffer;
+};
+\end{lstlisting}
+
+The \field{command_specific_data_reply} has the following format:
+\begin{lstlisting}
+struct virtio_ism_ctrl_alloc_reply {
+	le64 token;
+	le64 num;
+	le64 chunks[];
+};
+\end{lstlisting}
+
+The \field{class} and \field{command}:
+\begin{lstlisting}
+#define VIRTIO_ISM_CTRL_ALLOC  0
+	#define VIRTIO_ISM_CTRL_ALLOC_REGION 0
+\end{lstlisting}
+
+
+\devicenormative{\paragraph}{Alloc ISM Region}{Device Types / ISM Device / Device Operation / Alloc ISM Region}
+
+For the command VIRTIO_ISM_CTRL_ALLOC_REGION, the device MUST look for the
+free chunks from the ism regions area firstly, then maps the physical memory to
+these chunks in order. If there is no enough free chunk, the device MUST set
+\field{ack} to VIRTIO_ISM_NOSPEC. If no physical memory can be allocated by the
+device, the device MUST set \field{ack} to VIRTIO_ISM_NOMEM.
+
+A new token MUST be dynamically created for this ism region simultaneously. The
+token MUST be unique inside this communication domain. And the device MUST fill
+\field{chunks} with the offset of each chunk. \field{num} is the number of the
+chunks.
+
+The device MUST clear the memory of this ism region before committing to the
+driver.
+
+If \field{size} is smaller than \field{chunk_size}, the ism region also
+occupies one chunk.
+
+If \field{virtio_ism_ctrl_alloc_reply} is not enough, the device MUST set the \field{ack}
+to VIRTIO_ISM_E2BIG.
+
+The device sets \field{ack} to VIRTIO_ISM_OK after successfully allocating the
+ism region.
+
+\drivernormative{\paragraph}{Alloc ISM Region}{Device Types / ISM Device / Device Operation / Alloc ISM Region}
+
+The driver MUST provide the swap buffer. The size of the swap buffer MUST equal
+to the size of the ism region that we want to allocate.
+
+
+\subsubsection{Query ISM Region}\label{sec:Device Types / ISM Device / Device Operation / Query ISM Region}
+Based on controlq, the driver can query the information of an ism region.
+
+The \field{command_specific_data} has the following format:
+\begin{lstlisting}
+struct virtio_ism_ctrl_query {
+	le64 token;
+};
+\end{lstlisting}
+
+The \field{command_specific_data_reply} has the following format:
+\begin{lstlisting}
+struct virtio_ism_ctrl_query_reply {
+	le64 size;
+	le64 permissions;
+    le64 peers;
+};
+\end{lstlisting}
+
+The \field{class} and \field{command}:
+\begin{lstlisting}
+#define VIRTIO_ISM_CTRL_QUERY  1
+	#define VIRTIO_ISM_CTRL_QUERY_INFO 0
+\end{lstlisting}
+
+\devicenormative{\paragraph}{Query ISM Region}{Device Types / ISM Device / Device Operation / Query ISM Region}
+
+If the ism region specified by \field{token} does not exist, the device MUST set
+\field{ack} to VIRTIO_ISM_ENOENT. Otherwise, the device MUST fill the
+\field{size} with the size of the ism region. The device MUST get the
+permissions of this ism region for the device-self, then fill in the
+\field{permissions}.
+
+The device MUST fill the \field{peers} with the number of the peers referring to
+this ism region. (does not include the device that receiving this event)
+
+\subsubsection{Attach ISM Region}\label{sec:Device Types / ISM Device / Device Operation / Attach ISM Region}
+
+Based on controlq, the driver can request to attach an ism region with a
+specified token.
+
+The \field{command_specific_data} has the following format:
+\begin{lstlisting}
+struct virtio_ism_ctrl_attach {
+	le64 token;
+	le64 permissions;
+	le64 swap_buffer;
+	le64 swap_buffer_size;
+};
+\end{lstlisting}
+
+The \field{command_specific_data_reply} has the following format:
+\begin{lstlisting}
+struct virtio_ism_ctrl_attach_reply {
+	le64 size;
+	le64 num;
+	le64 chunks[];
+};
+\end{lstlisting}
+
+The \field{class} and \field{command}:
+\begin{lstlisting}
+#define VIRTIO_ISM_CTRL_ATTACH  2
+	#define VIRTIO_ISM_CTRL_ATTACH_REGION 0
+\end{lstlisting}
+
+\devicenormative{\paragraph}{Attach ISM Region}{Device Types / ISM Device / Device Operation / Attach ISM Region}
+
+If the ism region specified by \field{token} does not exist, the device MUST set
+\field{ack} to VIRTIO_ISM_ENOENT.
+
+The device MUST first look for the free chunks from the ism regions area. And
+the physical memory of the ism region is mapped to these chunks in order. If
+there is no enough free chunk, the device MUST set \field{ack} to
+VIRTIO_ISM_NOSPEC. The device MUST fill \field{chunks} with the offset of each
+chunk. \field{num} is the number of the chunks. \field{size} is the size of this
+ism region.
+
+If the device does not have the VIRTIO_ISM_PERM_ATTACH permission for this ism
+region, the device MUST set \field{ack} to VIRTIO_ISM_PERM_EATTACH. If
+\field{permissions} include VIRTIO_ISM_PERM_READ, but the device does not have
+the VIRTIO_ISM_PERM_READ permission for this region, the device MUST set
+\field{ack} to VIRTIO_ISM_PERM_EREAD. If \field{permissions} include
+VIRTIO_ISM_PERM_WRITE, but the device does not have the VIRTIO_ISM_PERM_WRITE
+permission for this region, the device MUST set \field{ack} to
+VIRTIO_ISM_PERM_EWRITE.
+
+The device MUST set the read and write permissions of the physical memory inside
+the ism regions area based on \field{permissions}.
+
+If \field{virtio_ism_ctrl_attach_reply} is not enough or \field{swap_buffer_size}
+is less than the size of the ism region, the device MUST set the
+\field{ack} to VIRTIO_ISM_E2BIG and set the \field{size} for next request.
+
+If the attach operation is successful, the device MUST generate a
+VIRTIO_ISM_EVENT_ATTACH event to other devices and MUST set \field{ack} to
+VIRTIO_ISM_OK.
+
+\drivernormative{\paragraph}{Attach ISM Region}{Device Types / ISM Device / Device Operation / Attach ISM Region}
+
+The driver MUST provide the swap buffer with \field{swap_buffer}. The size of
+the swap buffer MUST equal to the size of the ism region that we want to
+allocate.
+
+If \field{size} is less than \field{num} times \field {chunk_size}, then only
+header part of the last chunk is effective.
+
+If \field{ack} is VIRTIO_ISM_E2BIG, the \field{size} is valid, that this value
+represents the size of the ism region.
+
+\subsubsection{Detach ISM Region}\label{sec:Device Types / ISM Device / Device Operation / Detach ISM Region}
+Based on controlq, the device can release references to the ism region.
+
+The \field{command_specific_data} has the following format:
+\begin{lstlisting}
+struct virtio_ism_ctrl_detach {
+	le64 token;
+};
+\end{lstlisting}
+
+The \field{class} and \field{command}:
+\begin{lstlisting}
+#define VIRTIO_ISM_CTRL_DETACH  3
+	#define VIRTIO_ISM_CTRL_DETACH_REGION 0
+\end{lstlisting}
+
+\devicenormative{\paragraph}{Detach ISM Region}{Device Types / ISM Device / Device Operation / Detach ISM Region}
+
+If the ism region specified by \field{token} is not attached, the device MUST set
+\field{ack} to VIRTIO_ISM_ENOENT.
+
+If the detach operation is successful, the device MUST generate a
+VIRTIO_ISM_EVENT_DETACH event to other devices.
+
+If no one refers to the swap buffer, the device MUST set the \field{ack} to
+VIRTIO_ISM_OK. If the swap buffer is referred by other device, the device MUST
+set the \field{ack} to VIRTIO_ISM_WAIT_SWAP_BUFF.
+
+If no one refers to the swap buffer, the device that allocated this ism region
+MUST generate a VIRTIO_ISM_EVENT_SWAPBUF_RELEASE event to the driver.
+
+\drivernormative{\paragraph}{Detach ISM Region}{Device Types / ISM Device / Device Operation / Detach ISM Region}
+
+If the \field{ack} is VIRTIO_ISM_OK, the swap buffer is free.
+If the \field{ack} is VIRTIO_ISM_WAIT_SWAP_BUFF, the driver MUST NOT access the
+swap buffer until it receives the VIRTIO_ISM_EVENT_SWAPBUF_RELEASE event.
+
+\subsubsection{Grant ISM Region}\label{sec:Device Types / ISM Device / Device Operation / Grant ISM Region}
+Based on controlq, the driver can set the permissions for each ism
+region.
+
+The \field{command_specific_data} has the following format:
+\begin{lstlisting}
+struct virtio_ism_ctrl_grant_default {
+	le64 token;
+
+#define VIRTIO_ISM_PERM_READ	(1 << 0)
+#define VIRTIO_ISM_PERM_WRITE	(1 << 1)
+#define VIRTIO_ISM_PERM_ATTACH	(1 << 2)
+#define VIRTIO_ISM_PERM_MANAGE	(1 << 3)
+	le64 permissions;
+};
+
+struct virtio_ism_ctrl_grant_dev {
+	le64 token;
+	le64 permissions;
+	le64 peer_devid;
+};
+\end{lstlisting}
+
+The \field{class} and \field{command}:
+\begin{lstlisting}
+#define VIRTIO_ISM_CTRL_GRANT  4
+	#define VIRTIO_ISM_CTRL_GRANT_SET_DEFAULT    0
+	#define VIRTIO_ISM_CTRL_GRANT_SET_FOR_DEVICE 1
+\end{lstlisting}
+
+\begin{description}
+\item[VIRTIO_ISM_PERM_READ] read permission
+\item[VIRTIO_ISM_PERM_WRITE] write permission
+\item[VIRTIO_ISM_PERM_ATTACH] attach permission
+\item[VIRTIO_ISM_PERM_MANAGE] management permission, the device with this
+	permission can modify the permission of this ism region. By default, only
+	the device that allocated the region has this permission.
+\end{description}
+
+VIRTIO_ISM_CTRL_GRANT_SET_DEFAULT corresponds to virtio_ism_ctrl_grant_default;
+VIRTIO_ISM_CTRL_GRANT_SET_FOR_DEVICE corresponds to virtio_ism_ctrl_grant_dev;
+
+Permission control is divided into two categories, one is the dedicated
+permissions for a certain device, and the other is the default permissions for
+all device.
+
+\devicenormative{\paragraph}{Grant ISM Region}{Device Types / ISM Device / Device Operation / Grant ISM Region}
+
+If the ism region specified by \field{token} is not attached, the device MUST set
+\field{ack} to VIRTIO_ISM_ENOENT.
+
+The default permissions of the newly allocated ism region MUST be (VIRTIO_ISM_PERM_READ | VIRTIO_ISM_PERM_WRITE | VIRTIO_ISM_PERM_ATTACH).
+The device that allocated the ism region MUST have the permissions (VIRTIO_ISM_PERM_READ | VIRTIO_ISM_PERM_WRITE | VIRTIO_ISM_PERM_ATTACH | VIRTIO_ISM_PERM_MANAGE) for this region.
+
+For a certain device, if there is dedicated permissions, the default
+permissions are illegal to this device.
+
+\subsubsection{Inform Update Event IRQ Vector}\label{sec:Device Types / ISM Device / Device Operation / Inform Update Event IRQ Vector}
+
+The update event is a frequent event, and eventq is a relatively slow form. The
+driver can assign an independent interrupt to the ism region. Then this ism
+region's update event will no longer receive from the eventq, but the interrupt
+will be directly triggered.
+
+The \field{command_specific_data} has the following format:
+\begin{lstlisting}
+struct virtio_ism_ctrl_irq_vector {
+	le64 token;
+	le64 vector;
+};
+\end{lstlisting}
+
+The \field{class} and \field{command}:
+\begin{lstlisting}
+#define VIRTIO_ISM_CTRL_EVENT_VECTOR  5
+	#define VIRTIO_ISM_CTRL_EVENT_VECTOR_SET 0
+\end{lstlisting}
+
+\devicenormative{\paragraph}{Inform Event IRQ Vector}{Device Types / ISM Device / Device Operation / Inform Event IRQ Vector}
+
+The device MUST record the vector of this ism region, and MUST notify the update
+event of this ism region to the driver by triggering an interrupt by this vector.
+
+
diff --git a/device-types/ism/device-conformance.tex b/device-types/ism/device-conformance.tex
new file mode 100644
index 0000000..f2bef5c
--- /dev/null
+++ b/device-types/ism/device-conformance.tex
@@ -0,0 +1,17 @@
+\conformance{\subsection}{ISM Device Conformance}\label{sec:Conformance / Device Conformance / ISM Device Conformance}
+
+A ISM device MUST conform to the following normative statements:
+
+\begin{itemize}
+\item \ref{devicenormative:Device Types / ISM Device / Communication Domain}
+\item \ref{devicenormative:Device Types / ISM Device / Memory / Swap Buffer}
+\item \ref{devicenormative:Device Types / ISM Device / Memory / Chunk And ISM Region}
+\item \ref{devicenormative:Device Types / ISM Device / Device configuration layout}
+\item \ref{devicenormative:Device Types / ISM Device / Device Initialization}
+\item \ref{devicenormative:Device Types / ISM Device / Device Operation / Alloc ISM Region}
+\item \ref{devicenormative:Device Types / ISM Device / Device Operation / Query ISM Region}
+\item \ref{devicenormative:Device Types / ISM Device / Device Operation / Attach ISM Region}
+\item \ref{devicenormative:Device Types / ISM Device / Device Operation / Detach ISM Region}
+\item \ref{devicenormative:Device Types / ISM Device / Device Operation / Grant ISM Region}
+\item \ref{devicenormative:Device Types / ISM Device / Device Operation / Inform Event IRQ Vector}
+\end{itemize}
diff --git a/device-types/ism/driver-conformance.tex b/device-types/ism/driver-conformance.tex
new file mode 100644
index 0000000..2cb5d76
--- /dev/null
+++ b/device-types/ism/driver-conformance.tex
@@ -0,0 +1,13 @@
+\conformance{\subsection}{ISM Driver Conformance}\label{sec:Conformance / Driver Conformance / ISM Driver Conformance}
+
+A ISM driver MUST conform to the following normative statements:
+
+\begin{itemize}
+\item \ref{drivernormative:Device Types / ISM Device / Memory / Swap Buffer}
+\item \ref{drivernormative:Device Types / ISM Device / Event}
+\item \ref{drivernormative:Device Types / ISM Device / Device Initialization}
+\item \ref{drivernormative:Device Types / ISM Device / Device Operation / Alloc ISM Region}
+\item \ref{drivernormative:Device Types / ISM Device / Device Operation / Attach ISM Region}
+\item \ref{drivernormative:Device Types / ISM Device / Device Operation / Detach ISM Region}
+\end{itemize}
+
diff --git a/device-types/ism/layout-pic.tex b/device-types/ism/layout-pic.tex
new file mode 100644
index 0000000..c40aa79
--- /dev/null
+++ b/device-types/ism/layout-pic.tex
@@ -0,0 +1,112 @@
+\begin{tikzpicture}
+\definecolor{rg1}{RGB}{153,210,160}
+\definecolor{rg2}{RGB}{206,219,188}
+\definecolor{rg3}{RGB}{210,204,165}
+% vm A
+ \node[block,text width=10cm,align=left] (driverA) {virtio-ism driver};
+
+ \node[block,above=of driverA.north east,text width=2cm,anchor=east,fill=rg3] (M3A) {region M3};
+ \node[block,left=of M3A,text width=2cm,fill=rg2] (M2A) {region M2};
+ \node[block,left=of M2A.north west,anchor=south east,yshift=1cm,text width=2cm,fill=rg1] (M1A) {region M1};
+
+ \node[draw,inner xsep=4mm,inner ysep=7mm,fit=(driverA)(M1A)(M2A)(M3A),
+    draw=blue!80,line width=0.5mm,label={100:Guest A}](vmA){};
+
+% device A
+ \node[block,below=of driverA.south west, yshift=-1cm, xshift=1cm,
+    anchor=north west,text width=2cm] (deviceCoreA) {device core};
+
+ \node[right=of deviceCoreA,name=block,rectangle split,rectangle split horizontal,
+    rectangle split parts=4,draw,label=below:{device memory}] (deviceMemA)
+  {
+    \nodepart{one} chunk
+    \nodepart{two} chunk
+    \nodepart{three} chunk
+    \nodepart{four} chunk
+  };
+
+ \node[draw,inner xsep=4mm,inner ysep=7mm,fit=(deviceMemA)(deviceCoreA),
+    draw=green!80,line width=0.5mm,label={225:virtio-ism device A}](deviceA){};
+
+% lines A
+  \draw[line] (deviceMemA.four north) -- (M1A);
+  \draw[line] (deviceMemA.two north)  -- (M1A);
+  \draw[line] (deviceMemA.three north)-- (M2A);
+  \draw[line] (deviceMemA.one north)  -- (M3A);
+
+  \draw[-] ($(vmA.north west) + (0, -2.5cm)$) node[above=2pt, anchor=south west] {user space}
+    node[below=5pt, anchor=north west] {kernel space}-- ($(vmA.north east) + (0, -2.5cm)$);
+
+  \draw[line] (deviceCoreA.north west)-- node[above=1pt,sloped] {control vq} ($(driverA.south west) + (1.1cm,0)$);
+  \draw[line] (deviceCoreA.north)     -- node[below=1pt,sloped] {event vq} ($(driverA.south west) + (2.2cm,0)$);
+
+% vm B
+ \node[block,text width=10cm,align=right,right=of driverA] (driverB) {virtio-ism driver};
+
+ \node[block,above=of driverB.north west,text width=2cm, anchor=west,fill=rg3] (M3B) {region M3};
+ \node[block,right=of M3B.north east,anchor=south west,yshift=1cm,text
+    width=2cm,fill=rg1] (M1B) {region M1};
+
+ \node[draw,inner xsep=4mm,inner ysep=7mm,fit=(driverB)(M1B)(M3B),
+    draw=blue!80,line width=0.5mm,label={100:Guest B}](vmB){};
+
+
+% device B
+
+ \node[block, below=of driverB.south east, yshift=-1cm, xshift=-1cm,
+    anchor=north east,text width=2cm] (deviceCoreB) {device core};
+
+ \node[left=of deviceCoreB,name=block,rectangle split,rectangle split horizontal,
+    rectangle split parts=4,draw,label=below:{device memory}] (deviceMemB)
+  {
+    \nodepart{one} chunk
+    \nodepart{two} chunk
+    \nodepart{three} chunk
+  };
+
+ \node[draw,inner xsep=4mm,inner ysep=7mm,fit=(deviceMemB)(deviceCoreB),
+    draw=green!80,line width=0.5mm,label={305:virtio-ism device B}](deviceB){};
+
+% lines B
+
+  \draw[line] (deviceMemB.one north)  -- (M1B);
+  \draw[line] (deviceMemB.two north)  -- (M1B);
+  \draw[line] (deviceMemB.three north)-- (M3B);
+
+  \draw[-] ($(vmB.north west) + (0, -2.5cm)$) --  ($(vmB.north east) + (0, -2.5cm)$)
+node[anchor=south east] {user space}
+    node[anchor=north east] {kernel space}
+  ;
+
+  \draw[line] (deviceCoreB.north west)-- node[above=1pt,sloped] {control vq} ($(driverB.south east) - (2.2cm,0)$);
+  \draw[line] (deviceCoreB.north)     -- node[below=1pt,sloped] {event vq} ($(driverB.south east) - (1.1cm,0)$);
+
+% host memory
+ \node[right=of deviceA.north east,anchor=north west,name=block,rectangle split,
+    rectangle split parts=10, draw,label=below:{host memory}] (HostMem)
+  {
+    \nodepart{one} chunk
+    \nodepart{two} chunk
+    \nodepart{three} chunk
+    \nodepart{four} chunk
+    \nodepart{five} chunk
+    \nodepart{six} chunk
+    \nodepart{seven} chunk
+    \nodepart{eight} chunk
+    \nodepart{nine} chunk
+    \nodepart{ten} chunk
+  };
+
+  \draw[line] (HostMem.seven east) -| (deviceMemB.one south);
+  \draw[line] (HostMem.eight east)-| (deviceMemB.two south);
+  \draw[line] (HostMem.ten east)-| (deviceMemB.three south);
+
+  \draw[line] (HostMem.seven west)-| (deviceMemA.two south);
+  \draw[line] (HostMem.eight west)-| (deviceMemA.four south);
+  \draw[line] (HostMem.nine west)-| (deviceMemA.three south);
+  \draw[line] (HostMem.ten west)-| (deviceMemA.one south);
+
+ \node[draw,inner xsep=4mm,inner ysep=7mm,fit=(deviceA)(vmA)(deviceB)(vmB)
+ (HostMem),draw=cyan,line width=0.5mm,label=below:{Host}](host){};
+
+\end{tikzpicture}
diff --git a/virtio-html.tex b/virtio-html.tex
index c822a99..17c1639 100644
--- a/virtio-html.tex
+++ b/virtio-html.tex
@@ -32,6 +32,15 @@
 \usepackage{underscore}
 \usepackage{xstring}
 \usepackage{chngcntr}
+
+%config tikz
+\usepackage{tikz}
+\usetikzlibrary{shapes,positioning,fit,calc}
+\tikzset{block/.style={draw, thick, text width=3cm, minimum height=1cm, align=center},
+line/.style={-latex},
+}
+%end of config tikz
+
 \counterwithout{footnote}{chapter}
 
 \usepackage[utf8x]{inputenc}
diff --git a/virtio.tex b/virtio.tex
index a99bb3f..ffd2bf3 100644
--- a/virtio.tex
+++ b/virtio.tex
@@ -37,6 +37,15 @@
 \usepackage{tabularx}
 \usepackage{underscore}
 \usepackage{xstring}
+
+%config tikz
+\usepackage{tikz}
+\usetikzlibrary{shapes,positioning,fit,calc}
+\tikzset{block/.style={draw, thick, text width=3cm, minimum height=1cm, align=center},
+line/.style={-latex},
+}
+%end of config tikz
+
 \IfFileExists{ellipsis.sty}{\usepackage{ellipsis}}{
 \message{!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!}
 \message{LaTeX Warning: Missing ellipsis.sty: dots (...) will look ugly}
-- 
2.32.0.3.g01195cf9f



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

