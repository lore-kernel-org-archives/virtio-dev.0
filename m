Return-Path: virtio-return-2936-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Thu, 1 Mar 2018 01:10:32 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180301005944-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio] [PATCH v8 to v9 incremental] packed ring layout spec
To: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Tiwei Bie <tiwei.bie@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dhanoa, Kully" <kully.dhanoa@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Here's an incremental patch since v8, for ease of review.
I did my best to address all outstanding comments.

Changelog:

 packed-ring: clarify wording on s/g conformance
 split-ring: typo: aligment
 packed-ring: typo: aligment
 packed-ring: clarify multi-buffer requests
 packed-ring: necessary, not sufficient condition
 packed-ring: support skipping used descritors
 packed-ring: fix pseudo code
 packed-ring: format pseudocode using spaces
 packed-ring: drop << in pseudocode
 packed-ring: clarify event suppression format
 packed-ring: chained descriptors are always on
 VIRTIO_F_NOTIFICATION_DATA: switch to bitfields
 introduction: document bitfield notation
 VIRTIO_F_NOTIFICATION_DATA: minor cleanups
 content: VIRTIO_F_NOTIFICATION_DATA is option
 VIRTIO_F_NOTIFICATION_DATA: improve formatting

Note that I had to move notification format for ccw and mmio out to a
separate file - latex seems to get confused otherwise.  A clean patchset
to follow.

Incrementally redlined pdf is available at the
virtio-doc repository as virtio-v1.1-w08-to-wd09-diff.pdf

---

diff --git a/content.tex b/content.tex
index ca6d2d9..4261913 100644
--- a/content.tex
+++ b/content.tex
@@ -300,9 +300,9 @@ To help with these optimizations, when VIRTIO_F_NOTIFICATION_DATA
 has been negotiated, driver notifications to the device include
 the following information:
 
-\begin{itemize}
-\item VQ number
-\item Offset
+\begin{description}
+\item [VQ number]
+\item [Offset]
       Within the ring where the next available ring entry
       will be written.
       Without VIRTIO_F_RING_PACKED this refers to the
@@ -311,15 +311,16 @@ the following information:
       (in units of descritor entries)
       within the descriptor ring where the next available
       descriptor will be written.
-\item Wrap Counter
+\item [Wrap Counter]
       With VIRTIO_F_RING_PACKED this is the wrap counter
       referring to the next available descriptor.
       Without VIRTIO_F_RING_PACKED this is the most significant bit
       of the available index.
-\end{itemize}
+\end{description}
 
 Note that driver can trigger multiple notifications even without
-making any more changes to the ring. These would then have
+making any more changes to the ring. When VIRTIO_F_NOTIFICATION_DATA
+has been negotiated, these notifications would then have
 identical \field{Offset} and \field{Wrap Counter} values.
 
 \input{split-ring.tex}
@@ -1363,11 +1364,14 @@ When VIRTIO_F_NOTIFICATION_DATA has been negotiated,
 the driver notifies the device by writing the following
 32-bit value to the Queue Notify address:
 \begin{lstlisting}
-__le16 vqn;
-__le16 next_off : 15;
-u8    next_wrap : 1;
+le32 vqn : 16,
+     next_off : 15,
+     next_wrap : 1;
 \end{lstlisting}
 
+See \ref{sec:Virtqueues / Driver notifications}~\nameref{sec:Virtqueues / Driver notifications}
+for the definition of the components.
+
 See \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Notification capability} for how to calculate the
 Queue Notify address.
 
@@ -1607,10 +1611,12 @@ All register values are organized as Little Endian.
     the value written is the queue index.
 
     When VIRTIO_F_NOTIFICATION_DATA has been negotiated,
-    the value is calculated as follows:
-    $
-    u32 notification\_data = vqn | (next\_off << 16) | (next\_wrap << 31);
-    $
+    the value has the following format:
+
+    \lstinputlisting{notifications.c}
+
+    See \ref{sec:Virtqueues / Driver notifications}~\nameref{sec:Virtqueues / Driver notifications}
+    for the definition of the components.
   }
   \hline 
   \mmioreg{InterruptStatus}{Interrupt status}{0x60}{R}{%
@@ -2459,12 +2465,11 @@ When VIRTIO_F_NOTIFICATION_DATA has not been negotiated,
 the \field{Notification data} includes the Virtqueue number.
 
 When VIRTIO_F_NOTIFICATION_DATA has been negotiated,
-the \field{Notification data} is calculated as follows:
-
-\begin{lstlisting}
-u32 notification_data = vqn | (next_off << 16) | (next_wrap << 31);
-\end{lstlisting}
+the value has the following format:
+\lstinputlisting{notifications.c}
 
+See \ref{sec:Virtqueues / Driver notifications}~\nameref{sec:Virtqueues / Driver notifications}
+for the definition of the components.
 
 \devicenormative{\paragraph}{Guest->Host Notification}{Virtio Transport Options / Virtio over channel I/O / Device Operation / Guest->Host Notification}
 The device MUST ignore bits 0-31 (counting from the left) of GPR2.
diff --git a/introduction.tex b/introduction.tex
index 979881e..d0b770e 100644
--- a/introduction.tex
+++ b/introduction.tex
@@ -157,5 +157,23 @@ in little-endian byte order.
 in big-endian byte order.
 \end{description}
 
+When documenting sub-byte data fields, C-like bitfield notation
+is used. Fields within an integer are always listed in order,
+from the least significant to the most significant bit.
+
+For example:
+\begin{lstlisting}
+be16 A : 15,
+     B : 1;
+\end{lstlisting}
+documents the value A stored in the low 15 bit of a 16 bit
+integer and the value B stored in the high bit of the 16 bit
+integer, the integer in turn using the big-endian byte order.
+
+Note that this notation typically matches the way bitfields are
+packed by C compilers on little-endian architectures but not the
+way bitfields are packed by C compilers on big-endian
+architectures.
+
 \newpage
 
diff --git a/notifications.c b/notifications.c
new file mode 100644
index 0000000..2ae96d4
--- /dev/null
+++ b/notifications.c
@@ -0,0 +1,3 @@
+u32 vqn : 16,
+    next_off : 15,
+    next_wrap : 1;
diff --git a/packed-ring.tex b/packed-ring.tex
index 14e137d..12bab67 100644
--- a/packed-ring.tex
+++ b/packed-ring.tex
@@ -112,6 +112,15 @@ Ring Wrap Counter.  It also sets the VIRTQ_DESC_F_AVAIL bit to match the
 Thus VIRTQ_DESC_F_AVAIL and VIRTQ_DESC_F_USED bits are different
 for an available descriptor and equal for a used descriptor.
 
+Note that this observation is mostly useful for sanity-checking
+as these are necessary but not sufficient conditions - for
+example, all descriptors are zero-initialized. To detect used and
+available descriptors it is possible for drivers and devices to
+keep track of the last observed value of
+VIRTQ_DESC_F_USED/VIRTQ_DESC_F_AVAIL.  Other techniques to detect
+VIRTQ_DESC_F_AVAIL/VIRTQ_DESC_F_USED bit changes might also be
+possible.
+
 \subsection{Polling of available and used descriptors}
 \label{sec:Packed Virtqueues / Polling of available and used descriptors}
 
@@ -166,10 +175,9 @@ VIRTQ_DESC_F_WRITE flag, and is ignored by drivers.
 
 Some drivers need an ability to supply a list of multiple buffer
 elements (also known as a scatter/gather list) with a request.
-Two optional features support this: descriptor
-chaining and indirect descriptors.
+Two features support this: descriptor chaining and indirect descriptors.
 
-If neither feature has been negotiated, each buffer is
+If neither feature is in use by the driver, each buffer is
 physically-contigious, either read-only or write-only and is
 described completely by a single descriptor.
 
@@ -289,13 +297,15 @@ are assumed to have been used (read or written) by the
 device completely.
 
 \subsection{Multi-buffer requests}
-\label{sec:Packed Virtqueues / Multi-descriptor batches}
+\label{sec:Packed Virtqueues / Multi-buffer requests}
 Some devices combine multiple buffers as part of processing of a
-single request.  These devices always mark the first descriptor
-in the request used after the rest of the descriptors in the
-request has been written out into the ring. This guarantees that
-the driver will never observe a partial request in the ring.
-
+single request.  These devices always mark the descriptor
+corresponding to the first buffer in the request used after the
+rest of the descriptors (corresponding to rest of the buffers) in
+the request - which follow the first descriptor in ring order -
+has been marked used and written out into the ring.  This
+guarantees that the driver will never observe a partial request
+in the ring.
 
 \subsection{Driver and Device Event Suppression}
 \label{sec:Packed Virtqueues / Driver and Device Event Suppression}
@@ -318,14 +328,19 @@ each includes the following fields:
 
 \begin{description}
 \item [Descriptor Ring Change Event Flags] Takes values:
-\begin{itemize}
-\item 00b enable events
-\item 01b disable events
-\item 10b enable events for a specific descriptor
-(as specified by Descriptor Ring Change Event Offset/Wrap Counter).
-Only valid if VIRTIO_F_RING_EVENT_IDX has been negotiated.
-\item 11b reserved
-\end{itemize}
+\begin{lstlisting}
+/* Enable events */
+#define RING_EVENT_FLAGS_ENABLE 0x0
+/* Disable events */
+#define RING_EVENT_FLAGS_DISABLE 0x1
+/*
+ * Enable events for a specific descriptor
+ * (as specified by Descriptor Ring Change Event Offset/Wrap Counter).
+ * Only valid if VIRTIO_F_RING_EVENT_IDX has been negotiated.
+ */
+#define RING_EVENT_FLAGS_DESC 0x2
+/* The value 0x3 is reserved */
+\end{lstlisting}
 \item [Descriptor Ring Change Event Offset] If Event Flags set to descriptor
 specific event: offset within the ring (in units of descriptor
 size). Event will only trigger when this descriptor is
@@ -347,7 +362,7 @@ whether interrupt/notification should be sent.
 Each part of the virtqueue is physically-contiguous in guest memory,
 and has different alignment requirements.
 
-The memory aligment and size requirements, in bytes, of each part of the
+The memory alignment and size requirements, in bytes, of each part of the
 virtqueue are summarized in the following table:
 
 \begin{tabular}{|l|l|l|}
@@ -418,16 +433,18 @@ The following structure is used to reduce the number of
 notifications sent between driver and device.
 
 \begin{lstlisting}
-__le16 desc_event_off : 15; /* Descriptor Event Offset */
-int    desc_event_wrap : 1; /* Descriptor Event Wrap Counter */
-__le16 desc_event_flags : 2; /* Descriptor Event Flags */
+le16 desc_event_off : 15, /* Descriptor Event Offset */
+     desc_event_wrap : 1; /* Descriptor Event Wrap Counter */
+le16 desc_event_flags : 2, /* Descriptor Event Flags */
+     reserved : 14; /* Reserved, set to 0 */
 \end{lstlisting}
 
 \devicenormative{\subsection}{The Virtqueue Descriptor Table}{Basic Facilities of a Virtio Device / Packed Virtqueues / The Virtqueue Descriptor Table}
 A device MUST NOT write to a device-readable buffer, and a device SHOULD NOT
 read a device-writable buffer.
 A device MUST NOT use a descriptor unless it observes
-VIRTQ_DESC_F_AVAIL bit in its \field{flags} being changed.
+VIRTQ_DESC_F_AVAIL bit in its \field{flags} being changed
+(e.g. as compared to the initial zero value).
 A device MUST NOT change a descriptor after changing it's
 VIRTQ_DESC_F_USED bit in its \field{flags}.
 
@@ -435,7 +452,7 @@ VIRTQ_DESC_F_USED bit in its \field{flags}.
 A driver MUST NOT change a descriptor unless it observes
 VIRTQ_DESC_F_USED bit in its \field{flags} being changed.
 A driver MUST NOT change a descriptor after changing
-VIRTQ_DESC_F_USED bit in its \field{flags}.
+VIRTQ_DESC_F_AVAIL bit in its \field{flags}.
 When notifying the device, driver MUST set
 \field{next_off} and
 \field{next_wrap} to match the next descriptor
@@ -462,8 +479,9 @@ MUST make sure there's enough space in the ring
 for the whole list before making the first descriptor in the list
 available to the device.
 
-A driver MUST NOT make the first descriptor in the list
-available before initializing the rest of the descriptors.
+A driver MUST NOT make the first descriptor in the list available
+before all subsequent descriptors comprising the list are made
+available.
 
 \devicenormative{\subsection}{Scatter-Gather Support}{Basic Facilities of a
 Virtio Device / Packed Virtqueues / Scatter-Gather Support}
@@ -575,41 +593,50 @@ the number of device interrupts, neither does it support
 the VIRTIO_F_RING_EVENT_IDX feature.
 
 \begin{lstlisting}
+/* Note: vq->avail_wrap_count is initialized to 1 */
+/* Note: vq->ids is an array same size as the ring */
 
 first = vq->next_avail;
 id = alloc_id(vq);
 
 for (each buffer element b) {
+        vq->ids[vq->next_avail] = -1;
         vq->desc[vq->next_avail].address = get_addr(b);
         vq->desc[vq->next_avail].len = get_len(b);
-        init_desc(vq->next_avail, b);
-        avail = vq->avail_wrap_count;
-        used = !vq->avail_wrap_count;
-        f = get_flags(b) | (avail << VIRTQ_DESC_F_AVAIL) | (used << VIRTQ_DESC_F_USED);
-	/* Don't mark the 1st descriptor available until all of them are ready. */
+
+        avail = vq->avail_wrap_count ? VIRTQ_DESC_F_AVAIL : 0;
+        used = !vq->avail_wrap_count ? VIRTQ_DESC_F_USED : 0;
+        f = get_flags(b) | avail | used;
+	if (b is not the last buffer element) {
+		f |= VIRTQ_DESC_F_NEXT;
+	}
+
+        /* Don't mark the 1st descriptor available until all of them are ready. */
         if (vq->next_avail == first) {
                 flags = f;
         } else {
                 vq->desc[vq->next_avail].flags = f;
         }
 
-	vq->next_avail++;
+        last = vq->next_avail;
 
-	if (vq->next_avail >= vq->size) {
-		vq->next_avail = 0;
-		vq->avail_wrap_count \^= 1;
-	}
+        vq->next_avail++;
+
+        if (vq->next_avail >= vq->size) {
+                vq->next_avail = 0;
+                vq->avail_wrap_count \^= 1;
+        }
 
 
 }
 /* ID included in the last descriptor in the list */
-vq->desc[vq->next_avail].id = id;
+vq->ids[last] = vq->desc[last].id = id;
 write_memory_barrier();
 vq->desc[first].flags = flags;
 
 memory_barrier();
 
-if (vq->device_event.flags != 0x2) {
+if (vq->device_event.flags != RING_EVENT_FLAGS_DISABLE) {
         notify_device(vq);
 }
 
@@ -637,34 +664,41 @@ re-checking for more used buffers after interrups are re-enabled:
 \end{note}
 
 \begin{lstlisting}
-vq->driver_event.flags = 0x2;
+/* Note: vq->used_wrap_count is initialized to 1 */
+
+vq->driver_event.flags = RING_EVENT_FLAGS_DISABLE;
 
 for (;;) {
         struct virtq_desc *d = vq->desc[vq->next_used];
 
         flags = d->flags;
-        bool avail = flags & (1 << VIRTQ_DESC_F_AVAIL);
-        bool used = flags & (1 << VIRTQ_DESC_F_USED);
+        bool used = flags & VIRTQ_DESC_F_USED;
 
-        if (avail != used) {
-                vq->driver_event.flags = 0x1;
+        if (used != vq->used_wrap_count) {
+                vq->driver_event.flags = RING_EVENT_FLAGS_ENABLE;
                 memory_barrier();
 
                 flags = d->flags;
-                bool avail = flags & (1 << VIRTQ_DESC_F_AVAIL);
-                bool used = flags & (1 << VIRTQ_DESC_F_USED);
-                if (avail != used) {
+                bool used = flags & VIRTQ_DESC_F_USED;
+                if (used != vq->used_wrap_count) {
                         break;
                 }
 
-                vq->driver_event.flags = 0x2;
+                vq->driver_event.flags = RING_EVENT_FLAGS_DISABLE;
         }
 
-	read_memory_barrier();
+        read_memory_barrier();
+
+	/* skip descriptors until we find the correct ID */
+        do {
+		found = vq->ids[vq->next_used] == d->id;
+                vq->next_used++;
+                if (vq->next_used >= vq->size) {
+                        vq->next_used = 0;
+                        vq->used_wrap_count \^= 1;
+                }
+        } while (!found);
+
         process_buffer(d);
-        vq->next_used++;
-        if (vq->next_used >= vq->size) {
-                vq->next_used = 0;
-        }
 }
 \end{lstlisting}
diff --git a/split-ring.tex b/split-ring.tex
index 5572958..df278fe 100644
--- a/split-ring.tex
+++ b/split-ring.tex
@@ -23,7 +23,7 @@ Each virtqueue consists of three parts:
 where each part is physically-contiguous in guest memory,
 and has different alignment requirements.
 
-The memory aligment and size requirements, in bytes, of each part of the
+The memory alignment and size requirements, in bytes, of each part of the
 virtqueue are summarized in the following table:
 
 \begin{tabular}{|l|l|l|}

---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

