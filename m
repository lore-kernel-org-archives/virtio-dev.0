Return-Path: <xuanzhuo@linux.alibaba.com>
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH 2/2] virtio-ism: introduce new device virtio-ism
Date: Mon, 17 Oct 2022 15:47:24 +0800
Message-Id: <20221017074724.89569-3-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20221017074724.89569-1-xuanzhuo@linux.alibaba.com>
References: <20221017074724.89569-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
To: virtio-dev@lists.oasis-open.org
Cc: hans@linux.alibaba.com, herongguang@linux.alibaba.com, zmlcc@linux.alibaba.com, dust.li@linux.alibaba.com, tonylu@linux.alibaba.com, zhenzao@linux.alibaba.com, helinguo@linux.alibaba.com, gerry@linux.alibaba.com, xuanzhuo@linux.alibaba.com, mst@redhat.com, cohuck@redhat.com, jasowang@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

The virtio ism device provides and manages many memory ism regions in
host. These ism regions can be alloc/attach/detach by driver. Every
ism region can be shared by token with other VM after allocation.
The driver obtains the memory region on the host through the memory on
the device.

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
| | Qemu                           |               |       | Qemu                          |                | |
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

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
Signed-off-by: Dust Li <dust.li@linux.alibaba.com>
Signed-off-by: Tony Lu <tonylu@linux.alibaba.com>
Signed-off-by: Helin Guo <helinguo@linux.alibaba.com>
Signed-off-by: Hans Zhang <hans@linux.alibaba.com>
Signed-off-by: He Rongguang <herongguang@linux.alibaba.com>
---
 content.tex    |   1 +
 virtio-ism.tex | 340 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 341 insertions(+)
 create mode 100644 virtio-ism.tex

diff --git a/content.tex b/content.tex
index cd006c3..dc99f77 100644
--- a/content.tex
+++ b/content.tex
@@ -6853,6 +6853,7 @@ \subsubsection{Legacy Interface: Framing Requirements}\label{sec:Device
 \input{virtio-scmi.tex}
 \input{virtio-gpio.tex}
 \input{virtio-pmem.tex}
+\input{virtio-ism.tex}
 
 \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
 
diff --git a/virtio-ism.tex b/virtio-ism.tex
new file mode 100644
index 0000000..28ce8ec
--- /dev/null
+++ b/virtio-ism.tex
@@ -0,0 +1,340 @@
+\section{ISM Device}\label{sec:Device Types / ISM Device}
+
+ISM devices provide the ability to share memory between different guests on a
+host. A guest's memory got from ism device can be shared with multiple peers at
+the same time. This shared relationship can be dynamically created and released.
+
+The shared memory obtained from the device is divided into multiple ism regions for
+share. The size of each ism region is \field{region_size}(the actual available
+memory may be smaller). The unit of operation of the driver to the shared memory
+is the ism region.
+
+ISM device provides a mechanism to notify other ism region referrers of
+content update events.
+
+
+\subsection{Device ID}\label{sec:Device Types / ISM Device / Device ID}
+  43
+
+\subsection{Virtqueues}\label{sec:Device Types / ISM Device / Virtqueues}
+\begin{description}
+\item[0] controlq
+\item[1] eventq
+\end{description}
+
+eventq only exists if VIRTIO_ISM_F_EVENT_VQ is negotiated.
+
+\subsection{Feature bits}\label{sec:Device Types / ISM Device / Feature bits}
+
+\begin{description}
+\item[VIRTIO_ISM_F_EVENT_VQ (0)] The ISM driver uses eventq to receive the ism regions update event.
+\item[VIRTIO_ISM_F_EVENT_IRQ (1)] Each ism region is directly bound to an interrupt to receive update events.
+\end{description}
+
+\subsection{Device configuration layout}\label{sec:Device Types / ISM Device / Device configuration layout}
+
+\begin{lstlisting}
+struct virtio_ism_config {
+	le64 dev_id;
+	le64 region_size;
+	le64 notify_size;
+};
+\end{lstlisting}
+
+\begin{description}
+\item[\field{dev_id}]      the id of the device.
+\item[\field{region_size}] the size of the every ism region.
+\item[\field{notify_size}] the size of the notify address.
+
+\end{description}
+
+\subsection{Event}\label{sec:Device Types / Network Device / Device Operation / Event}
+
+When VIRTIO_ISM_F_EVENT_VQ or VIRTIO_ISM_F_EVENT_IRQ is negotiated, the ism
+device supports event notification of ism region update. After the device
+receives the notification from the driver, it MUST notify other guests that
+refer to this ism region.
+
+Such a structure will be received if VIRTIO_ISM_F_EVENT_VQ is negotiated.
+
+\begin{lstlisting}
+enum virtio_ism_event {
+    le64 num;
+    le64 offset[];
+};
+\end{lstlisting}
+
+\begin{description}
+\item[\field{num}] The number of ism regions with update events.
+\item[\field{offset}] The offset of ism regions with update events.
+\end{description}
+
+If VIRTIO_ISM_F_EVENT_IRQ is negotiated, when the driver receives an interrupt,
+it means that the ism region associated with it has been updated.
+
+
+\subsection{Permissions}\label{sec:Device Types / Network Device / Device Operation / Permission}
+
+The driver can set independent permissions for a certain ism region. Restrict
+which devices can execute attach or read and write permissions after attach.
+
+By default, the ism region can be attached by any device, and the driver can set
+it to not allow attachment or only allow the specified device to attach.
+
+The driver can set the read and write permissions after it is attached by
+default, and can also set independent read and write permissions for some
+devices.
+
+When a driver has the management permission of the ism region,
+then it can modify the permissions of this ism region.
+By default, only the device that created the ism region has this permission.
+
+
+\subsection{Device Initialization}\label{sec:Device Types / ISM Device / Device Initialization}
+
+\devicenormative{\subsubsection}{Device Initialization}{Device Types / ISM Device / Device Initialization}
+
+The device MUST regenerate a \field{dev_id}. \field{dev_id} remains unchanged
+during reset. \field{dev_id} MUST NOT be 0;
+
+The device shares memory to the guest based on shared memory regions
+\ref{sec:Basic Facilities of a Virtio Device / Shared Memory Regions}.
+However, it does not need to allocate physical memory during initialization.
+
+The \field{shmid} of a region MUST be one of the following
+\begin{lstlisting}
+enum virtio_ism_shm_id {
+        VIRTIO_ISM_SHM_ID_UNDEFINED = 0,
+        VIRTIO_ISM_SHM_ID_REGIONS   = 1,
+        VIRTIO_ISM_SHM_ID_NOTIFY    = 2,
+};
+\end{lstlisting}
+
+The shared memory whose shmid is VIRTIO_ISM_SHM_ID_REGIONS is used to implement
+ism regions. If there are multiple shared memory whose shmid is
+VIRTIO_ISM_SHM_ID_REGIONS, they are used as contiguous memory in the order of
+acquisition.
+
+If VIRTIO_ISM_F_EVENT_VQ or VIRTIO_ISM_F_EVENT_IRQ is negotiated, the device
+MUST also provides a shared memory with VIRTIO_ISM_SHM_ID_NOTIFY to the driver.
+This memory area is used for notify, and each ism region MUST have a
+corresponding notify address inside this area, and the size of the notify
+address is \field{notify_size};
+
+\drivernormative{\subsubsection}{Device Initialization}{Device Types / ISM Device / Device Initialization}
+
+The driver MUST query all shared memory regions supported by the device.
+(see \ref{sec:Basic Facilities of a Virtio Device / Shared Memory Regions})
+
+Use \field{offset} to reference the ism region.
+
+If VIRTIO_ISM_F_EVENT_VQ is negotiated, then the driver MUST initialize eventq
+to get update events for the ism region.
+
+If VIRTIO_ISM_F_EVENT_IRQ is negotiated, the driver MUST initiate interrupts to
+obtain update events for the ism region. And the driver MUST inform the device
+the interrupt vectors for one ism region.
+
+\subsection{Control Virtqueue}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue}
+
+The driver uses the control virtqueue send commands to implement operations on
+the ism region and some global configurations.
+
+All commands are of the following form:
+\begin{lstlisting}
+struct virtio_ism_ctrl {
+        u8 class;
+        u8 command;
+        u8 command-specific-data[];
+        u8 ack;
+        u8 command-specific-data-reply[];
+};
+
+/* ack values */
+#define VIRTIO_ISM_OK     0
+#define VIRTIO_NET_ERR    1
+\end{lstlisting}
+
+The \field{class}, \field{command} and command-specific-data are set by the
+driver, and the device sets the \field{ack} byte and optionally
+\field{command-specific-data-reply}. There is little the driver can
+do except issue a diagnostic if \field{ack} is not VIRTIO_NET_OK.
+
+\subsection{Device Operation}  \label{sec:Device Types / ISM Driver / Device Operation}
+
+\subsubsection{Alloc ISM Region}\label{sec:Device Types / ISM Device / Device Operation / Alloc ISM Region}
+
+Based on controlq, the driver can request an ism region to be allocated.
+
+The ism region obtained from the device will carry a token, which can be passed
+to other guests for attaching to this ism region.
+
+\begin{lstlisting}
+
+#define VIRTIO_ISM_TOKEN_SIZE 64
+
+struct virtio_ism_ctrl_alloc {
+       le64 size;
+};
+
+struct virtio_ism_ctrl_alloc_reply {
+       u8 token[VIRTIO_ISM_TOKEN_SIZE];
+       le64 offset;
+};
+
+#define VIRTIO_ISM_CTRL_ALLOC  0
+ #define VIRTIO_ISM_CTRL_ALLOC_REGION 0
+\end{lstlisting}
+
+
+\devicenormative{\subparagraph}{Alloc ISM Region}{Device Types / ISM Device / Device Operation / Alloc ISM Region}
+
+The device sets \field{ack} to VIRTIO_ISM_OK after successfully assigning the
+physical ism region. At the same time, a new token MUST be dynamically created
+for this ism region. \field{offset} is the location of this ism region in shared
+memory.
+
+If there is no free area of the shared memory space, the device MUST set
+\field{ack} to VIRTIO_ISM_ERR.
+
+If new physical memory cannot be allocated, the device MUST set
+\field{ack} to VIRTIO_ISM_ERR.
+
+The device MUST clear the new ism region before committing to the guest.
+
+If \field{size} is greater than \field{region_size}, the device MUST set
+\field{ack} to VIRTIO_ISM_ERR.
+
+If \field{size} is smaller than \field{region_size}, the ism region also
+occupies \field{region_size} in the shared memory space.
+
+\drivernormative{\subparagraph}{Alloc ISM Region}{Device Types / ISM Device / Device Operation / Alloc ISM Region}
+
+After the alloc request is successful, the driver MUST only use the range
+\field{offset} to \field{offset} + \field{size} - 1.
+
+\subsubsection{Attach ISM Region}\label{sec:Device Types / ISM Device / Device Operation / Attach ISM Region}
+
+Based on controlq, the driver can request to attach an ism region with a
+specified token.
+
+\begin{lstlisting}
+struct virtio_ism_ctrl_attach {
+       u8 token[VIRTIO_ISM_TOKEN_SIZE];
+};
+
+struct virtio_ism_ctrl_attach_reply {
+       le64 offset;
+};
+
+#define VIRTIO_ISM_CTRL_ATTACH  1
+ #define VIRTIO_ISM_CTRL_ATTACH_REGION 0
+\end{lstlisting}
+\devicenormative{\subparagraph}{Attach ISM Region}{Device Types / ISM Device / Device Operation / Attach ISM Region}
+
+If there is no free area of the shared memory space, the device MUST set
+\field{ack} to VIRTIO_ISM_ERR.
+
+If the ism region specified by \field{token} does not exist, the device MUST set
+\field{ack} to VIRTIO_ISM_ERR.
+
+After the attach operation, an ism region can ONLY be shared between these two
+guests, even if one of them operates detach, but as long as the ism region is
+not completely released, the ism region can only be re-attached by the previous
+guest and cannot share with other guests.
+
+\subsubsection{Detach ISM Region}\label{sec:Device Types / ISM Device / Device Operation / Detach ISM Region}
+Based on controlq, the device can release references to the ism region.
+
+\begin{lstlisting}
+struct virtio_ism_ctrl_detach {
+       le64 offset;
+};
+
+#define VIRTIO_ISM_CTRL_DETACH  2
+ #define VIRTIO_ISM_CTRL_DETACH_REGION 0
+\end{lstlisting}
+
+\devicenormative{\subparagraph}{Detach ISM Region}{Device Types / ISM Device / Device Operation / Detach ISM Region}
+
+If the location specified by \field{offset} is not assigned an ism region,
+the device MUST set \field{ack} to VIRTIO_ISM_ERR.
+
+The device MUST release the physical memory of the ism region specified by
+\field{offset} from the guest.
+
+The device can only fully release an ism region after all devices have released
+references to the ism region.
+
+\subsubsection{Grant ISM Region}\label{sec:Device Types / ISM Device / Device Operation / Grant ISM Region}
+Based on controlq, the driver can set the access permissions for each ism
+region.
+
+\begin{lstlisting}
+struct virtio_ism_ctrl_grant {
+       le64 offset;
+       le64 peer_dev_id;
+       le64 permissions;
+};
+
+#define VIRTIO_ISM_CTRL_GRANT  3
+ #define VIRTIO_ISM_CTRL_GRANT_SET 0
+
+#define VIRTIO_ISM_PERM_READ       (1 << 0)
+#define VIRTIO_ISM_PERM_WRITE      (1 << 1)
+#define VIRTIO_ISM_PERM_ATTACH     (1 << 2)
+#define VIRTIO_ISM_PERM_MANAGE     (1 << 3)
+#define VIRTIO_ISM_PERM_DENY_OTHER (1 << 4)
+
+\end{lstlisting}
+
+\begin{description}
+\item[VIRTIO_ISM_PERM_READ] read permission
+\item[VIRTIO_ISM_PERM_WRITE] write permission
+\item[VIRTIO_ISM_PERM_ATTACH] attach permission
+\item[VIRTIO_ISM_PERM_MANAGE] Management permission, the device with this
+    permission can modify the permission of this ism region. By default, only
+    the alloc device has this permission.
+\item[VIRTIO_ISM_PERM_DENY_OTHER] Unspecified devices do not have attach
+    permission.
+
+\end{description}
+
+Permission control is divided into two categories, one is the permission for the
+specified device, and the other is the default permission that does not specify
+the device.
+
+If \field{peer_dev_id} is 0, it is used to configure the default device
+permissions.
+
+\devicenormative{\subparagraph}{Grant ISM Region}{Device Types / ISM Device / Device Operation / Grant ISM Region}
+
+If the location specified by \field{offset} is not assigned an ism region,
+the device MUST set \field{ack} to VIRTIO_ISM_ERR.
+
+The device MUST respond to the driver's request based on the permissions the
+device has.
+
+\subsubsection{Inform Event IRQ Vector}\label{sec:Device Types / ISM Device / Device Operation / Inform Event IRQ Vector}
+
+If VIRTIO_ISM_F_EVENT_IRQ is negotiated, the driver should tell which interrupt
+vector to use for event notification.
+
+\begin{lstlisting}
+struct virtio_ism_ctrl_irq_vector {
+       le64 offset;
+       le64 vector;
+};
+
+#define VIRTIO_ISM_CTRL_EVENT_VECTOR  4
+ #define VIRTIO_ISM_CTRL_EVENT_VECTOR_SET 0
+\end{lstlisting}
+
+
+\devicenormative{\subparagraph}{Inform Event IRQ Vector}{Device Types / ISM Device / Device Operation / Inform Event IRQ Vector}
+
+The device MUST record the relationship between the ism region and the vector
+notified by the driver, and notify the driver based on the corresponding vector
+when the ism region is updated.
+
+
-- 
2.32.0.3.g01195cf9f

