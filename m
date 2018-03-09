Return-Path: virtio-return-2999-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Fri, 9 Mar 2018 23:23:31 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1520629942-36324-5-git-send-email-mst@redhat.com>
References: <1520629942-36324-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520629942-36324-1-git-send-email-mst@redhat.com>
Subject: [virtio] [PATCH v10 04/13] content: move virtqueue operation description
To: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Tiwei Bie <tiwei.bie@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dhanoa, Kully" <kully.dhanoa@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

virtqueue operation description is specific to the virtqueue
format. Move it out to split-ring.tex and update all
references.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
---
 conformance.tex |   4 +-
 content.tex     | 171 +++-------------------------------------------------
 split-ring.tex  | 181 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 185 insertions(+), 171 deletions(-)

diff --git a/conformance.tex b/conformance.tex
index f59e360..55d17b4 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -40,9 +40,9 @@ A driver MUST conform to the following normative statements:
 \item \ref{drivernormative:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Interrupt Suppression}
 \item \ref{drivernormative:Basic Facilities of a Virtio Device / Virtqueues / The Virtqueue Used Ring}
 \item \ref{drivernormative:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Notification Suppression}
+\item \ref{drivernormative:Basic Facilities of a Virtio Device / Virtqueues / Supplying Buffers to The Device / Updating idx}
+\item \ref{drivernormative:Basic Facilities of a Virtio Device / Virtqueues / Supplying Buffers to The Device / Notifying The Device}
 \item \ref{drivernormative:General Initialization And Device Operation / Device Initialization}
-\item \ref{drivernormative:General Initialization And Device Operation / Device Operation / Supplying Buffers to The Device / Updating idx}
-\item \ref{drivernormative:General Initialization And Device Operation / Device Operation / Supplying Buffers to The Device / Notifying The Device}
 \item \ref{drivernormative:General Initialization And Device Operation / Device Cleanup}
 \item \ref{drivernormative:Reserved Feature Bits}
 \end{itemize}
diff --git a/content.tex b/content.tex
index 5b4c4e9..3b4579e 100644
--- a/content.tex
+++ b/content.tex
@@ -337,167 +337,14 @@ And Device Operation / Device Initialization / Set DRIVER-OK}.
 
 \section{Device Operation}\label{sec:General Initialization And Device Operation / Device Operation}
 
-There are two parts to device operation: supplying new buffers to
-the device, and processing used buffers from the device.
-
-\begin{note} As an
-example, the simplest virtio network device has two virtqueues: the
-transmit virtqueue and the receive virtqueue. The driver adds
-outgoing (device-readable) packets to the transmit virtqueue, and then
-frees them after they are used. Similarly, incoming (device-writable)
-buffers are added to the receive virtqueue, and processed after
-they are used.
-\end{note}
-
-\subsection{Supplying Buffers to The Device}\label{sec:General Initialization And Device Operation / Device Operation / Supplying Buffers to The Device}
-
-The driver offers buffers to one of the device's virtqueues as follows:
-
-\begin{enumerate}
-\item\label{itm:General Initialization And Device Operation / Device Operation / Supplying Buffers to The Device / Place Buffers} The driver places the buffer into free descriptor(s) in the
-   descriptor table, chaining as necessary (see \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / The Virtqueue Descriptor Table}~\nameref{sec:Basic Facilities of a Virtio Device / Virtqueues / The Virtqueue Descriptor Table}).
-
-\item\label{itm:General Initialization And Device Operation / Device Operation / Supplying Buffers to The Device / Place Index} The driver places the index of the head of the descriptor chain
-   into the next ring entry of the available ring.
-
-\item Steps \ref{itm:General Initialization And Device Operation / Device Operation / Supplying Buffers to The Device / Place Buffers} and \ref{itm:General Initialization And Device Operation / Device Operation / Supplying Buffers to The Device / Place Index} MAY be performed repeatedly if batching
-  is possible.
-
-\item The driver performs suitable a memory barrier to ensure the device sees
-  the updated descriptor table and available ring before the next
-  step.
-
-\item The available \field{idx} is increased by the number of
-  descriptor chain heads added to the available ring.
-
-\item The driver performs a suitable memory barrier to ensure that it updates
-  the \field{idx} field before checking for notification suppression.
-
-\item If notifications are not suppressed, the driver notifies the device
-    of the new available buffers.
-\end{enumerate}
-
-Note that the above code does not take precautions against the
-available ring buffer wrapping around: this is not possible since
-the ring buffer is the same size as the descriptor table, so step
-(1) will prevent such a condition.
-
-In addition, the maximum queue size is 32768 (the highest power
-of 2 which fits in 16 bits), so the 16-bit \field{idx} value can always
-distinguish between a full and empty buffer.
+When operating the device, each field in the device configuration
+space can be changed by either the driver or the device.
 
-What follows is the requirements of each stage in more detail.
-
-\subsubsection{Placing Buffers Into The Descriptor Table}\label{sec:General Initialization And Device Operation / Device Operation / Supplying Buffers to The Device / Placing Buffers Into The Descriptor Table}
-
-A buffer consists of zero or more device-readable physically-contiguous
-elements followed by zero or more physically-contiguous
-device-writable elements (each has at least one element). This
-algorithm maps it into the descriptor table to form a descriptor
-chain:
-
-for each buffer element, b:
-
-\begin{enumerate}
-\item Get the next free descriptor table entry, d
-\item Set \field{d.addr} to the physical address of the start of b
-\item Set \field{d.len} to the length of b.
-\item If b is device-writable, set \field{d.flags} to VIRTQ_DESC_F_WRITE,
-    otherwise 0.
-\item If there is a buffer element after this:
-    \begin{enumerate}
-    \item Set \field{d.next} to the index of the next free descriptor
-      element.
-    \item Set the VIRTQ_DESC_F_NEXT bit in \field{d.flags}.
-    \end{enumerate}
-\end{enumerate}
-
-In practice, \field{d.next} is usually used to chain free
-descriptors, and a separate count kept to check there are enough
-free descriptors before beginning the mappings.
-
-\subsubsection{Updating The Available Ring}\label{sec:General Initialization And Device Operation / Device Operation / Supplying Buffers to The Device / Updating The Available Ring}
-
-The descriptor chain head is the first d in the algorithm
-above, ie. the index of the descriptor table entry referring to the first
-part of the buffer.  A naive driver implementation MAY do the following (with the
-appropriate conversion to-and-from little-endian assumed):
-
-\begin{lstlisting}
-avail->ring[avail->idx % qsz] = head;
-\end{lstlisting}
+Whenever such a configuration change is triggered by the device,
+driver is notified. This makes it possible for drivers to
+cache device configuration, avoiding expensive configuration
+reads unless notified.
 
-However, in general the driver MAY add many descriptor chains before it updates
-\field{idx} (at which point they become visible to the
-device), so it is common to keep a counter of how many the driver has added:
-
-\begin{lstlisting}
-avail->ring[(avail->idx + added++) % qsz] = head;
-\end{lstlisting}
-
-\subsubsection{Updating \field{idx}}\label{sec:General Initialization And Device Operation / Device Operation / Supplying Buffers to The Device / Updating idx}
-
-\field{idx} always increments, and wraps naturally at
-65536:
-
-\begin{lstlisting}
-avail->idx += added;
-\end{lstlisting}
-
-Once available \field{idx} is updated by the driver, this exposes the
-descriptor and its contents.  The device MAY
-access the descriptor chains the driver created and the
-memory they refer to immediately.
-
-\drivernormative{\paragraph}{Updating idx}{General Initialization And Device Operation / Device Operation / Supplying Buffers to The Device / Updating idx}
-The driver MUST perform a suitable memory barrier before the \field{idx} update, to ensure the
-device sees the most up-to-date copy.
-
-\subsubsection{Notifying The Device}\label{sec:General Initialization And Device Operation / Device Operation / Supplying Buffers to The Device / Notifying The Device}
-
-The actual method of device notification is bus-specific, but generally
-it can be expensive.  So the device MAY suppress such notifications if it
-doesn't need them, as detailed in section \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Notification Suppression}.
-
-The driver has to be careful to expose the new \field{idx}
-value before checking if notifications are suppressed.
-
-\drivernormative{\paragraph}{Notifying The Device}{General Initialization And Device Operation / Device Operation / Supplying Buffers to The Device / Notifying The Device}
-The driver MUST perform a suitable memory barrier before reading \field{flags} or
-\field{avail_event}, to avoid missing a notification.
-
-\subsection{Receiving Used Buffers From The Device}\label{sec:General Initialization And Device Operation / Device Operation / Receiving Used Buffers From The Device}
-
-Once the device has used buffers referred to by a descriptor (read from or written to them, or
-parts of both, depending on the nature of the virtqueue and the
-device), it interrupts the driver as detailed in section \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Interrupt Suppression}.
-
-\begin{note}
-For optimal performance, a driver MAY disable interrupts while processing
-the used ring, but beware the problem of missing interrupts between
-emptying the ring and reenabling interrupts.  This is usually handled by
-re-checking for more used buffers after interrups are re-enabled:
-
-\begin{lstlisting}
-virtq_disable_interrupts(vq);
-
-for (;;) {
-        if (vq->last_seen_used != le16_to_cpu(virtq->used.idx)) {
-                virtq_enable_interrupts(vq);
-                mb();
-
-                if (vq->last_seen_used != le16_to_cpu(virtq->used.idx))
-                        break;
-
-                virtq_disable_interrupts(vq);
-        }
-
-        struct virtq_used_elem *e = virtq.used->ring[vq->last_seen_used%vsz];
-        process_buffer(e);
-        vq->last_seen_used++;
-}
-\end{lstlisting}
-\end{note}
 
 \subsection{Notification of Device Configuration Changes}\label{sec:General Initialization And Device Operation / Device Operation / Notification of Device Configuration Changes}
 
@@ -3017,9 +2864,7 @@ If VIRTIO_NET_HDR_F_NEEDS_CSUM is not set, the device MUST NOT
 rely on the packet checksum being correct.
 \paragraph{Packet Transmission Interrupt}\label{sec:Device Types / Network Device / Device Operation / Packet Transmission / Packet Transmission Interrupt}
 
-Often a driver will suppress transmission interrupts using the
-VIRTQ_AVAIL_F_NO_INTERRUPT flag
- (see \ref{sec:General Initialization And Device Operation / Device Operation / Receiving Used Buffers From The Device}~\nameref{sec:General Initialization And Device Operation / Device Operation / Receiving Used Buffers From The Device})
+Often a driver will suppress transmission virtqueue interrupts
 and check for used packets in the transmit path of following
 packets.
 
@@ -3079,7 +2924,7 @@ if VIRTIO_NET_F_MRG_RXBUF is not negotiated.}
 
 When a packet is copied into a buffer in the receiveq, the
 optimal path is to disable further interrupts for the receiveq
-(see \ref{sec:General Initialization And Device Operation / Device Operation / Receiving Used Buffers From The Device}~\nameref{sec:General Initialization And Device Operation / Device Operation / Receiving Used Buffers From The Device}) and process
+and process
 packets until no more are found, then re-enable them.
 
 Processing incoming packets involves:
diff --git a/split-ring.tex b/split-ring.tex
index 418f63d..404660b 100644
--- a/split-ring.tex
+++ b/split-ring.tex
@@ -1,11 +1,12 @@
 \section{Split Virtqueues}\label{sec:Basic Facilities of a Virtio Device / Split Virtqueues}
-The split virtqueue format is the original format used by legacy
-virtio devices.  The split virtqueue format separates the
-virtqueue into several parts, where each part is write-able by
-either the driver or the device, but not both. Multiple
-locations need to be updated when making a buffer available
-and when marking it as used.
+The split virtqueue format was the only format supported
+by the version 1.0 (and earlier) of this standard.
 
+The split virtqueue format separates the virtqueue into several
+parts, where each part is write-able by either the driver or the
+device, but not both. Multiple parts and/or locations within
+a part need to be updated when making a buffer
+available and when marking it as used.
 
 Each queue has a 16-bit queue size
 parameter, which sets the number of entries and implies the total size
@@ -496,3 +497,171 @@ include/uapi/linux/virtio_ring.h. This was explicitly licensed by IBM
 and Red Hat under the (3-clause) BSD license so that it can be
 freely used by all other projects, and is reproduced (with slight
 variation) in \ref{sec:virtio-queue.h}~\nameref{sec:virtio-queue.h}.
+
+\subsection{Virtqueue Operation}\label{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Operation}
+
+There are two parts to virtqueue operation: supplying new
+available buffers to the device, and processing used buffers from
+the device.
+
+\begin{note} As an
+example, the simplest virtio network device has two virtqueues: the
+transmit virtqueue and the receive virtqueue. The driver adds
+outgoing (device-readable) packets to the transmit virtqueue, and then
+frees them after they are used. Similarly, incoming (device-writable)
+buffers are added to the receive virtqueue, and processed after
+they are used.
+\end{note}
+
+What follows is the requirements of each of these two parts
+when using the split virtqueue format in more detail.
+
+\subsection{Supplying Buffers to The Device}\label{sec:Basic Facilities of a Virtio Device / Virtqueues / Supplying Buffers to The Device}
+
+The driver offers buffers to one of the device's virtqueues as follows:
+
+\begin{enumerate}
+\item\label{itm:Basic Facilities of a Virtio Device / Virtqueues / Supplying Buffers to The Device / Place Buffers} The driver places the buffer into free descriptor(s) in the
+   descriptor table, chaining as necessary (see \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / The Virtqueue Descriptor Table}~\nameref{sec:Basic Facilities of a Virtio Device / Virtqueues / The Virtqueue Descriptor Table}).
+
+\item\label{itm:Basic Facilities of a Virtio Device / Virtqueues / Supplying Buffers to The Device / Place Index} The driver places the index of the head of the descriptor chain
+   into the next ring entry of the available ring.
+
+\item Steps \ref{itm:Basic Facilities of a Virtio Device / Virtqueues / Supplying Buffers to The Device / Place Buffers} and \ref{itm:Basic Facilities of a Virtio Device / Virtqueues / Supplying Buffers to The Device / Place Index} MAY be performed repeatedly if batching
+  is possible.
+
+\item The driver performs suitable a memory barrier to ensure the device sees
+  the updated descriptor table and available ring before the next
+  step.
+
+\item The available \field{idx} is increased by the number of
+  descriptor chain heads added to the available ring.
+
+\item The driver performs a suitable memory barrier to ensure that it updates
+  the \field{idx} field before checking for notification suppression.
+
+\item If notifications are not suppressed, the driver notifies the device
+    of the new available buffers.
+\end{enumerate}
+
+Note that the above code does not take precautions against the
+available ring buffer wrapping around: this is not possible since
+the ring buffer is the same size as the descriptor table, so step
+(1) will prevent such a condition.
+
+In addition, the maximum queue size is 32768 (the highest power
+of 2 which fits in 16 bits), so the 16-bit \field{idx} value can always
+distinguish between a full and empty buffer.
+
+What follows is the requirements of each stage in more detail.
+
+\subsubsection{Placing Buffers Into The Descriptor Table}\label{sec:Basic Facilities of a Virtio Device / Virtqueues / Supplying Buffers to The Device / Placing Buffers Into The Descriptor Table}
+
+A buffer consists of zero or more device-readable physically-contiguous
+elements followed by zero or more physically-contiguous
+device-writable elements (each has at least one element). This
+algorithm maps it into the descriptor table to form a descriptor
+chain:
+
+for each buffer element, b:
+
+\begin{enumerate}
+\item Get the next free descriptor table entry, d
+\item Set \field{d.addr} to the physical address of the start of b
+\item Set \field{d.len} to the length of b.
+\item If b is device-writable, set \field{d.flags} to VIRTQ_DESC_F_WRITE,
+    otherwise 0.
+\item If there is a buffer element after this:
+    \begin{enumerate}
+    \item Set \field{d.next} to the index of the next free descriptor
+      element.
+    \item Set the VIRTQ_DESC_F_NEXT bit in \field{d.flags}.
+    \end{enumerate}
+\end{enumerate}
+
+In practice, \field{d.next} is usually used to chain free
+descriptors, and a separate count kept to check there are enough
+free descriptors before beginning the mappings.
+
+\subsubsection{Updating The Available Ring}\label{sec:Basic Facilities of a Virtio Device / Virtqueues / Supplying Buffers to The Device / Updating The Available Ring}
+
+The descriptor chain head is the first d in the algorithm
+above, ie. the index of the descriptor table entry referring to the first
+part of the buffer.  A naive driver implementation MAY do the following (with the
+appropriate conversion to-and-from little-endian assumed):
+
+\begin{lstlisting}
+avail->ring[avail->idx % qsz] = head;
+\end{lstlisting}
+
+However, in general the driver MAY add many descriptor chains before it updates
+\field{idx} (at which point they become visible to the
+device), so it is common to keep a counter of how many the driver has added:
+
+\begin{lstlisting}
+avail->ring[(avail->idx + added++) % qsz] = head;
+\end{lstlisting}
+
+\subsubsection{Updating \field{idx}}\label{sec:Basic Facilities of a Virtio Device / Virtqueues / Supplying Buffers to The Device / Updating idx}
+
+\field{idx} always increments, and wraps naturally at
+65536:
+
+\begin{lstlisting}
+avail->idx += added;
+\end{lstlisting}
+
+Once available \field{idx} is updated by the driver, this exposes the
+descriptor and its contents.  The device MAY
+access the descriptor chains the driver created and the
+memory they refer to immediately.
+
+\drivernormative{\paragraph}{Updating idx}{Basic Facilities of a Virtio Device / Virtqueues / Supplying Buffers to The Device / Updating idx}
+The driver MUST perform a suitable memory barrier before the \field{idx} update, to ensure the
+device sees the most up-to-date copy.
+
+\subsubsection{Notifying The Device}\label{sec:Basic Facilities of a Virtio Device / Virtqueues / Supplying Buffers to The Device / Notifying The Device}
+
+The actual method of device notification is bus-specific, but generally
+it can be expensive.  So the device MAY suppress such notifications if it
+doesn't need them, as detailed in section \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Notification Suppression}.
+
+The driver has to be careful to expose the new \field{idx}
+value before checking if notifications are suppressed.
+
+\drivernormative{\paragraph}{Notifying The Device}{Basic Facilities of a Virtio Device / Virtqueues / Supplying Buffers to The Device / Notifying The Device}
+The driver MUST perform a suitable memory barrier before reading \field{flags} or
+\field{avail_event}, to avoid missing a notification.
+
+\subsection{Receiving Used Buffers From The Device}\label{sec:Basic Facilities of a Virtio Device / Virtqueues / Receiving Used Buffers From The Device}
+
+Once the device has used buffers referred to by a descriptor (read from or written to them, or
+parts of both, depending on the nature of the virtqueue and the
+device), it interrupts the driver as detailed in section \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Interrupt Suppression}.
+
+\begin{note}
+For optimal performance, a driver MAY disable interrupts while processing
+the used ring, but beware the problem of missing interrupts between
+emptying the ring and reenabling interrupts.  This is usually handled by
+re-checking for more used buffers after interrups are re-enabled:
+
+\begin{lstlisting}
+virtq_disable_interrupts(vq);
+
+for (;;) {
+        if (vq->last_seen_used != le16_to_cpu(virtq->used.idx)) {
+                virtq_enable_interrupts(vq);
+                mb();
+
+                if (vq->last_seen_used != le16_to_cpu(virtq->used.idx))
+                        break;
+
+                virtq_disable_interrupts(vq);
+        }
+
+        struct virtq_used_elem *e = virtq.used->ring[vq->last_seen_used%vsz];
+        process_buffer(e);
+        vq->last_seen_used++;
+}
+\end{lstlisting}
+\end{note}
-- 
MST


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

