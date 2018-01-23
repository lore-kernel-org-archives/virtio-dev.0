Return-Path: virtio-return-2842-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Tue, 23 Jan 2018 02:01:03 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1516665617-30748-4-git-send-email-mst@redhat.com>
References: <1515577653-9336-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1515577653-9336-1-git-send-email-mst@redhat.com>
Subject: [virtio] [PATCH v7 04/11] content: replace mentions of len with used length
To: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

Document buffer used len and use that terminology everywhere in the
generic section.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 content.tex | 39 ++++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/content.tex b/content.tex
index 3b4579e..4350ecf 100644
--- a/content.tex
+++ b/content.tex
@@ -242,7 +242,8 @@ a used buffer to the queue - i.e. lets the driver
 know by marking the buffer as used. Device can then trigger
 a device event - i.e. send an interrupt to the driver.
 
-For queue operation detail, see \ref{sec:Basic Facilities of a Virtio Device / Split Virtqueues}~\nameref{sec:Basic Facilities of a Virtio Device / Split Virtqueues}.
+Device reports the number of bytes it has written to memory for
+each buffer it uses. This is referred to as ``used length''.
 
 \input{split-ring.tex}
 
@@ -1304,7 +1305,7 @@ The driver interrupt handler would typically:
     \begin{itemize}
       \item Read the ISR Status field, which will reset it to zero.
       \item If the lower bit is set:
-        look through the used rings of all virtqueues for the
+        look through all virtqueues for the
         device, to see if any progress has been made by the device
         which requires servicing.
       \item If the second lower bit is set:
@@ -1313,8 +1314,7 @@ The driver interrupt handler would typically:
   \item If MSI-X capability is enabled:
     \begin{itemize}
       \item
-        Look through the used rings of
-        all virtqueues mapped to that MSI-X vector for the
+        Look through all virtqueues mapped to that MSI-X vector for the
         device, to see if any progress has been made by the device
         which requires servicing.
       \item
@@ -1728,8 +1728,7 @@ nor behaviour:
   }
   \hline
   \mmioreg{QueueNum}{Virtual queue size}{0x038}{W}{%
-    Queue size is the number of elements in the queue, therefore size
-    of the descriptor table and both available and used rings.
+    Queue size is the number of elements in the queue.
     Writing to this register notifies the device what size of the
     queue the driver will use. This applies to the queue selected by
     writing to \field{QueueSel}.
@@ -2709,7 +2708,7 @@ when VIRTIO_NET_F_MRG_RXBUF was negotiated; without that feature the
 structure was 2 bytes shorter.
 
 When using the legacy interface, the driver SHOULD ignore the
-\field{len} value in used ring entries for the transmit queues
+used length for the transmit queues
 and the controlq queue.
 \begin{note}
 Historically, some devices put
@@ -2868,8 +2867,8 @@ Often a driver will suppress transmission virtqueue interrupts
 and check for used packets in the transmit path of following
 packets.
 
-The normal behavior in this interrupt handler is to retrieve and
-new descriptors from the used ring and free the corresponding
+The normal behavior in this interrupt handler is to retrieve
+used buffers from the virtqueue and free the corresponding
 headers and packets.
 
 \subsubsection{Setting Up Receive Buffers}\label{sec:Device Types / Network Device / Device Operation / Setting Up Receive Buffers}
@@ -2936,7 +2935,7 @@ Processing incoming packets involves:
   This allows receipt of large packets without having to allocate large
   buffers: a packet that does not fit in a single buffer can flow
   over to the next buffer, and so on. In this case, there will be
-  at least \field{num_buffers} in the used ring, and the device
+  at least \field{num_buffers} used buffers in the virtqueue, and the device
   chains them together to form a single packet in a way similar to
   how it would store it in a single buffer spread over multiple
   descriptors.
@@ -2990,8 +2989,8 @@ MUST use all buffers but the last (i.e. the first $num_buffers -
 supplied by the driver.
 
 The device MUST use all buffers used by a single receive
-packet together, by atomically incrementing \field{idx} in the
-used ring by the \field{num_buffers} value.
+packet together, such that at least \field{num_buffers} are
+observed by driver as used.
 
 If VIRTIO_NET_F_GUEST_CSUM is not negotiated, the device MUST set
 \field{flags} to zero and SHOULD supply a fully checksummed
@@ -3378,7 +3377,8 @@ The device MUST queue packets only on any receiveq1 before the
 VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET command.
 
 The device MUST NOT queue packets on receive queues greater than
-\field{virtqueue_pairs} once it has placed the VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET command in the used ring.
+\field{virtqueue_pairs} once it has placed the
+VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET command in a used buffer.
 
 \subparagraph{Legacy Interface: Automatic receive steering in multiqueue mode}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Automatic receive steering in multiqueue mode / Legacy Interface: Automatic receive steering in multiqueue mode}
 When using the legacy interface, transitional devices and drivers
@@ -3744,7 +3744,7 @@ according to the native endian of the guest rather than
 (necessarily when not using the legacy interface) little-endian.
 
 When using the legacy interface, transitional drivers
-SHOULD ignore the \field{len} value in used ring entries.
+SHOULD ignore the used length values.
 \begin{note}
 Historically, some devices put the total descriptor length,
 or the total length of device-writable buffers there,
@@ -4081,7 +4081,7 @@ according to the native endian of the guest rather than
 (necessarily when not using the legacy interface) little-endian.
 
 When using the legacy interface, the driver SHOULD ignore the
-\field{len} value in used ring entries for the transmit queues
+used length values for the transmit queues
 and the control transmitq.
 \begin{note}
 Historically, some devices put the total descriptor length there,
@@ -4337,7 +4337,8 @@ and acknowledging the deflate request.
 \paragraph{Legacy Interface: Device Operation}\label{sec:Device
 Types / Memory Balloon Device / Device Operation / Legacy
 Interface: Device Operation}
-When using the legacy interface, the driver SHOULD ignore the \field{len} value in used ring entries.
+When using the legacy interface, the driver SHOULD ignore the
+used length values.
 \begin{note}
 Historically, some devices put the total descriptor length there,
 even though no data was actually written.
@@ -4370,8 +4371,7 @@ and notifies the device. A request for memory statistics proceeds
 as follows:
 
 \begin{enumerate}
-\item The device pushes the buffer onto the used ring and sends an
-  interrupt.
+\item The device uses the buffer and sends an interrupt.
 
 \item The driver pops the used buffer and discards it.
 
@@ -4632,7 +4632,8 @@ queue and the event queue.
 \paragraph{Legacy Interface: Device Operation}\label{sec:Device
 Types / SCSI Host Device / Device Operation / Legacy
 Interface: Device Operation}
-When using the legacy interface, the driver SHOULD ignore the \field{len} value in used ring entries.
+When using the legacy interface, the driver SHOULD ignore the
+used length values.
 \begin{note}
 Historically, devices put the total descriptor length,
 or the total length of device-writable buffers there,
-- 
MST


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

