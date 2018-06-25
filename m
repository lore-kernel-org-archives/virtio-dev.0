Return-Path: virtio-return-3147-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
From: Halil Pasic <pasic@linux.ibm.com>
Date: Mon, 25 Jun 2018 14:21:27 +0200
In-Reply-To: <1529929292-11900-1-git-send-email-pasic@linux.ibm.com>
References: <1529929292-11900-1-git-send-email-pasic@linux.ibm.com>
Message-Id: <1529929292-11900-2-git-send-email-pasic@linux.ibm.com>
Subject: [virtio] [PATCH v3 1/6] notifications: unify notifications wording in core
To: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Pawel Moll <pawel.moll@arm.com>, Stefan Hajnoczi <stefanha@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Let us unify the wording when talking about notifications. This change
establishes the terms available buffer notification for what was usually
simply called notification or virtqueue notification in v1.0 and used
buffer notification for what was usually called interrupt.

The term configuration change notification in kept where called so and
consolidated where it's called configuration change interrupt or
similar.

The changes done here are limited to the core part, and don't
conceptually involve neither the transports nor the devices (references
are updated though). Future changes should address these parts.

Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
---
v2 -> v3
* Addressed all comments by Connie and Stefan (changed both directions
with the my nonsensical "i.e.'s" that was pointed out by Stefan)
* Added unrelated grammar fix s/writes entry/writes an entry/ (Stefan)
---
 cl-os.tex       |    2 +-
 conformance.tex |    8 +++---
 content.tex     |   26 +++++++++++--------
 packed-ring.tex |   60 ++++++++++++++++++++++++++--------------------
 split-ring.tex  |   72 ++++++++++++++++++++++++++++++++-----------------------
 5 files changed, 96 insertions(+), 72 deletions(-)

diff --git a/cl-os.tex b/cl-os.tex
index da78bf8..fc12cdd 100644
--- a/cl-os.tex
+++ b/cl-os.tex
@@ -2,7 +2,7 @@
 trivial typo
 
 See
-\ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Interrupt Suppression}.
+\ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Used Buffer Notification Suppression}.
 } \\
 \hline
 541 & 11 Oct 2015 & Paolo Bonzini & {virtio-blk: fix typo
diff --git a/conformance.tex b/conformance.tex
index e4efe33..de33396 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -37,10 +37,10 @@ A driver MUST conform to the following normative statements:
 \item \ref{drivernormative:Basic Facilities of a Virtio Device / Message Framing}
 \item \ref{drivernormative:Basic Facilities of a Virtio Device / Virtqueues / The Virtqueue Descriptor Table}
 \item \ref{drivernormative:Basic Facilities of a Virtio Device / Virtqueues / The Virtqueue Descriptor Table / Indirect Descriptors}
-\item \ref{drivernormative:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Interrupt Suppression}
+\item \ref{drivernormative:Basic Facilities of a Virtio Device / Virtqueues / Used Buffer Notification Suppression}
 \item \ref{drivernormative:Basic Facilities of a Virtio Device / Virtqueues / The Virtqueue Available Ring}
 \item \ref{drivernormative:Basic Facilities of a Virtio Device / Virtqueues / The Virtqueue Used Ring}
-\item \ref{drivernormative:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Notification Suppression}
+\item \ref{drivernormative:Basic Facilities of a Virtio Device / Virtqueues / Available Buffer Notification Suppression}
 \item \ref{drivernormative:Basic Facilities of a Virtio Device / Virtqueues / Supplying Buffers to The Device / Updating idx}
 \item \ref{drivernormative:Basic Facilities of a Virtio Device / Virtqueues / Supplying Buffers to The Device / Notifying The Device}
 \item \ref{drivernormative:General Initialization And Device Operation / Device Initialization}
@@ -158,9 +158,9 @@ A device MUST conform to the following normative statements:
 \item \ref{devicenormative:Basic Facilities of a Virtio Device / Message Framing}
 \item \ref{devicenormative:Basic Facilities of a Virtio Device / Virtqueues / The Virtqueue Descriptor Table}
 \item \ref{devicenormative:Basic Facilities of a Virtio Device / Virtqueues / The Virtqueue Descriptor Table / Indirect Descriptors}
-\item \ref{devicenormative:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Interrupt Suppression}
+\item \ref{devicenormative:Basic Facilities of a Virtio Device / Virtqueues / Used Buffer Notification Suppression}
 \item \ref{devicenormative:Basic Facilities of a Virtio Device / Virtqueues / The Virtqueue Used Ring}
-\item \ref{devicenormative:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Notification Suppression}
+\item \ref{devicenormative:Basic Facilities of a Virtio Device / Virtqueues / Available Buffer Notification Suppression}
 \item \ref{devicenormative:Reserved Feature Bits}
 \end{itemize}
 
diff --git a/content.tex b/content.tex
index be18234..9b1f3e1 100644
--- a/content.tex
+++ b/content.tex
@@ -72,7 +72,8 @@ recover by issuing a reset.
 \devicenormative{\subsection}{Device Status Field}{Basic Facilities of a Virtio Device / Device Status Field}
 The device MUST initialize \field{device status} to 0 upon reset.
 
-The device MUST NOT consume buffers or notify the driver before DRIVER_OK.
+The device MUST NOT consume buffers or send any used buffer
+notifications to the driver before DRIVER_OK.
 
 \label{sec:Basic Facilities of a Virtio Device / Device Status Field / DEVICENEEDSRESET}The device SHOULD set DEVICE_NEEDS_RESET when it enters an error state
 that a reset is needed.  If DRIVER_OK is set, after it sets DEVICE_NEEDS_RESET, the device
@@ -235,12 +236,13 @@ transmit and one for receive.}.
 Driver makes requests available to device by adding
 an available buffer to the queue - i.e. adding a buffer
 describing the request to a virtqueue, and optionally triggering
-a driver event - i.e. sending a notification to the device.
+a driver event - i.e. sending an available buffer notification
+to the device.
 
 Device executes the requests and - when complete - adds
 a used buffer to the queue - i.e. lets the driver
 know by marking the buffer as used. Device can then trigger
-a device event - i.e. send an interrupt to the driver.
+a device event - i.e. send a used buffer notification to the driver.
 
 Device reports the number of bytes it has written to memory for
 each buffer it uses. This is referred to as ``used length''.
@@ -330,7 +332,8 @@ set the FAILED status bit to indicate that it has given up on the
 device (it can reset the device later to restart if desired).  The
 driver MUST NOT continue initialization in that case.
 
-The driver MUST NOT notify the device before setting DRIVER_OK.
+The driver MUST NOT send any buffer available notifications to
+the device before setting DRIVER_OK.
 
 \subsection{Legacy Interface: Device Initialization}\label{sec:General Initialization And Device Operation / Device Initialization / Legacy Interface: Device Initialization}
 Legacy devices did not support the FEATURES_OK status bit, and thus did
@@ -388,10 +391,11 @@ reads unless notified.
 
 \subsection{Notification of Device Configuration Changes}\label{sec:General Initialization And Device Operation / Device Operation / Notification of Device Configuration Changes}
 
-For devices where the device-specific configuration information can be changed, an
-interrupt is delivered when a device-specific configuration change occurs.
+For devices where the device-specific configuration information can be
+changed, a configuration change notification is sent when a
+device-specific configuration change occurs.
 
-In addition, this interrupt is triggered by the device setting
+In addition, this notification is triggered by the device setting
 DEVICE_NEEDS_RESET (see \ref{sec:Basic Facilities of a Virtio Device / Device Status Field / DEVICENEEDSRESET}).
 
 \section{Device Cleanup}\label{sec:General Initialization And Device Operation / Device Cleanup}
@@ -5339,7 +5343,7 @@ Virtqueues / The Virtqueue Descriptor Table / Indirect
 Descriptors} and \ref{sec:Packed Virtqueues / Indirect Flag: Scatter-Gather Support}~\nameref{sec:Packed Virtqueues / Indirect Flag: Scatter-Gather Support}.
   \item[VIRTIO_F_RING_EVENT_IDX(29)] This feature enables the \field{used_event}
   and the \field{avail_event} fields as described in
-\ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Interrupt Suppression}, \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / The Virtqueue Used Ring} and \ref{sec:Packed Virtqueues / Driver and Device Event Suppression}.
+\ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Used Buffer Notification Suppression}, \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / The Virtqueue Used Ring} and \ref{sec:Packed Virtqueues / Driver and Device Event Suppression}.
 
 
   \item[VIRTIO_F_VERSION_1(32)] This indicates compliance with this
@@ -5413,16 +5417,16 @@ Transitional devices MAY offer the following:
 \begin{description}
 \item[VIRTIO_F_NOTIFY_ON_EMPTY (24)] If this feature
   has been negotiated by driver, the device MUST issue
-  an interrupt if the device runs
+  a used buffer notification if the device runs
   out of available descriptors on a virtqueue, even though
-  interrupts are suppressed using the VIRTQ_AVAIL_F_NO_INTERRUPT
+  notifications are suppressed using the VIRTQ_AVAIL_F_NO_INTERRUPT
   flag or the \field{used_event} field.
 \begin{note}
   An example of a driver using this feature is the legacy
   networking driver: it doesn't need to know every time a packet
   is transmitted, but it does need to free the transmitted
   packets a finite time after they are transmitted. It can avoid
-  using a timer if the device interrupts it when all the packets
+  using a timer if the device notifies it when all the packets
   are transmitted.
 \end{note}
 \end{description}
diff --git a/packed-ring.tex b/packed-ring.tex
index 2ef9559..ebbad95 100644
--- a/packed-ring.tex
+++ b/packed-ring.tex
@@ -42,8 +42,8 @@ the descriptor.
 The driver then notifies the device. When the device has finished
 processing the buffer, it writes a used device descriptor
 including the Buffer ID into the Descriptor Ring (overwriting a
-driver descriptor previously made available), and sends an
-interrupt.
+driver descriptor previously made available), and sends a
+used event notification.
 
 The Descriptor Ring is used in a circular manner: the driver writes
 descriptors into the ring in order. After reaching the end of the ring,
@@ -65,11 +65,13 @@ in which their processing is complete.
 
 The Device Event Suppression data structure is write-only by the
 device. It includes information for reducing the number of
-device events - i.e. driver notifications to device.
+device events - i.e. sending fewer available buffer notifications
+to the device.
 
 The Driver Event Suppression data structure is read-only by the
 device. It includes information for reducing the number of
-driver events - i.e. device interrupts to driver.
+driver events - i.e. sending fewer used buffer notifications 
+to the driver.
 
 \subsection{Driver and Device Ring Wrap Counters}
 \label{sec:Packed Virtqueues / Driver and Device Ring Wrap Counters}
@@ -309,22 +311,20 @@ in the ring.
 
 \subsection{Driver and Device Event Suppression}
 \label{sec:Packed Virtqueues / Driver and Device Event Suppression}
-In many systems driver and device notifications involve
+In many systems used and available buffer notifications involve
 significant overhead. To mitigate this overhead,
 each virtqueue includes two identical structures used for
 controlling notifications between the device and the driver.
 
 The Driver Event Suppression structure is read-only by the
-device and controls the events sent by the device
-to the driver (e.g. interrupts).
+device and controls the used buffer notifications sent by the device
+to the driver.
 
 The Device Event Suppression structure is read-only by
-the driver and controls the events sent by the driver
-to the device (e.g. IO).
+the driver and controls the available buffer notifications sent by the
+driver to the device.
 
-Each of these Event Suppression structures controls
-both Descriptor Ring events and structure events, and
-each includes the following fields:
+Each of these Event Suppression structures includes the following fields:
 
 \begin{description}
 \item [Descriptor Ring Change Event Flags] Takes values:
@@ -354,7 +354,7 @@ made available/used respectively.
 
 After writing out some descriptors, both the device and the driver
 are expected to consult the relevant structure to find out
-whether an interrupt/notification should be sent.
+whether a used respectively an available buffer notification should be sent.
 
 \subsubsection{Structure Size and Alignment}
 \label{sec:Packed Virtqueues / Structure Size and Alignment}
@@ -463,7 +463,7 @@ When notifying the device, driver MUST set
 \field{next_off} and
 \field{next_wrap} to match the next descriptor
 not yet made available to the device.
-A driver MAY send multiple notifications without making
+A driver MAY send multiple available buffer notifications without making
 any new descriptors available to the device.
 
 \drivernormative{\subsection}{Scatter-Gather Support}{Basic Facilities of a
@@ -579,13 +579,14 @@ The driver MUST perform a suitable memory barrier before the
 \field{flags} update, to ensure the
 device sees the most up-to-date copy.
 
-\subsubsection{Notifying The Device}\label{sec:Basic Facilities
-of a Virtio Device / Packed Virtqueues / Supplying Buffers to The Device / Notifying The Device}
+\subsubsection{Sending Available Buffer Notifications}\label{sec:Basic Facilities
+of a Virtio Device / Packed Virtqueues / Supplying Buffers to The Device
+/ Sending Available Buffer Notifications}
 
 The actual method of device notification is bus-specific, but generally
 it can be expensive.  So the device MAY suppress such notifications if it
-doesn't need them, using the Driver Event Suppression structure
-as detailed in section \ref{sec:Basic
+doesn't need them, using the Event Suppression structure comprising the
+Device Area as detailed in section \ref{sec:Basic
 Facilities of a Virtio Device / Packed Virtqueues / Event
 Suppression Structure Format}.
 
@@ -595,7 +596,7 @@ value before checking if notifications are suppressed.
 \subsubsection{Implementation Example}\label{sec:Basic Facilities of a Virtio Device / Packed Virtqueues / Supplying Buffers to The Device / Implementation Example}
 
 Below is a driver code example. It does not attempt to reduce
-the number of device interrupts, neither does it support
+the number of available buffer notifications, neither does it support
 the VIRTIO_F_RING_EVENT_IDX feature.
 
 \begin{lstlisting}
@@ -651,24 +652,31 @@ if (vq->device_event.flags != RING_EVENT_FLAGS_DISABLE) {
 \end{lstlisting}
 
 
-\drivernormative{\paragraph}{Notifying The Device}{Basic Facilities of a Virtio Device / Packed Virtqueues / Supplying Buffers to The Device / Notifying The Device}
+\drivernormative{\paragraph}{Sending Available Buffer Notifications}
+{Basic Facilities of a Virtio Device / Packed Virtqueues / Supplying
+Buffers to The Device / Sending Available Buffer Notifications}
 The driver MUST perform a suitable memory barrier before reading
-the Driver Event Suppression structure, to avoid missing a notification.
+the Event Suppression structure occupying the Device Area. Failing
+to do so could result in mandatory available buffer notifications
+not being sent.
 
 \subsection{Receiving Used Buffers From The Device}\label{sec:Basic Facilities of a Virtio Device / Packed Virtqueues / Receiving Used Buffers From The Device}
 
 Once the device has used buffers referred to by a descriptor (read from or written to them, or
 parts of both, depending on the nature of the virtqueue and the
-device), it interrupts the driver
+device), it sends a used buffer notification to the driver
 as detailed in section \ref{sec:Basic
 Facilities of a Virtio Device / Packed Virtqueues / Event
 Suppression Structure Format}.
 
 \begin{note}
-For optimal performance, a driver MAY disable interrupts while processing
-the used buffers, but beware the problem of missing interrupts between
-emptying the ring and reenabling interrupts.  This is usually handled by
-re-checking for more used buffers after interrups are re-enabled:
+
+For optimal performance, a driver MAY disable used buffer notifications
+while processing the used buffers, but beware the problem of missing
+notifications between emptying the ring and reenabling used buffer
+notifications.  This is usually handled by re-checking for more used
+buffers after notifications are re-enabled:
+
 \end{note}
 
 \begin{lstlisting}
diff --git a/split-ring.tex b/split-ring.tex
index 2267863..be0cd2f 100644
--- a/split-ring.tex
+++ b/split-ring.tex
@@ -54,7 +54,8 @@ When the driver wants to send a buffer to the device, it fills in
 a slot in the descriptor table (or chains several together), and
 writes the descriptor index into the available ring.  It then
 notifies the device. When the device has finished a buffer, it
-writes the descriptor index into the used ring, and sends an interrupt.
+writes the descriptor index into the used ring, and sends a
+used buffer notification.
 
 \drivernormative{\subsection}{Virtqueues}{Basic Facilities of a Virtio Device / Virtqueues}
 The driver MUST ensure that the physical address of the first byte
@@ -318,44 +319,47 @@ VRING_AVAIL_F_NO_INTERRUPT, but the layout and value were identical.
 A driver MUST NOT decrement the available \field{idx} on a virtqueue (ie.
 there is no way to ``unexpose'' buffers).
 
-\subsection{Virtqueue Interrupt Suppression}\label{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Interrupt Suppression}
+\subsection{Used Buffer Notification Suppression}\label{sec:Basic
+Facilities of a Virtio Device / Virtqueues / Used Buffer Notification Suppression}
 
 If the VIRTIO_F_EVENT_IDX feature bit is not negotiated,
 the \field{flags} field in the available ring offers a crude mechanism for the driver to inform
-the device that it doesn't want interrupts when buffers are used.  Otherwise
+the device that it doesn't want notifications when buffers are used.  Otherwise
 \field{used_event} is a more performant alternative where the driver
-specifies how far the device can progress before interrupting.
+specifies how far the device can progress before a notification is
+required.
 
-Neither of these interrupt suppression methods are reliable, as they
+Neither of these notification suppression methods are reliable, as they
 are not synchronized with the device, but they serve as
 useful optimizations.
 
-\drivernormative{\subsubsection}{Virtqueue Interrupt Suppression}{Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Interrupt Suppression}
+\drivernormative{\subsubsection}{Used Buffer Notification Suppression}{Basic Facilities of a Virtio Device / Virtqueues / Used Buffer Notification Suppression}
 If the VIRTIO_F_EVENT_IDX feature bit is not negotiated:
 \begin{itemize}
 \item The driver MUST set \field{flags} to 0 or 1.
 \item The driver MAY set \field{flags} to 1 to advise
-the device that interrupts are not needed.
+the device that notifications are not needed.
 \end{itemize}
 
 Otherwise, if the VIRTIO_F_EVENT_IDX feature bit is negotiated:
 \begin{itemize}
 \item The driver MUST set \field{flags} to 0.
-\item The driver MAY use \field{used_event} to advise the device that interrupts are unnecessary until the device writes entry with an index specified by \field{used_event} into the used ring (equivalently, until \field{idx} in the
+\item The driver MAY use \field{used_event} to advise the device that
+notifications are unnecessary until the device writes an entry with an index specified by \field{used_event} into the used ring (equivalently, until \field{idx} in the
 used ring will reach the value \field{used_event} + 1).
 \end{itemize}
 
-The driver MUST handle spurious interrupts from the device.
+The driver MUST handle spurious notifications from the device.
 
-\devicenormative{\subsubsection}{Virtqueue Interrupt Suppression}{Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Interrupt Suppression}
+\devicenormative{\subsubsection}{Used Buffer Notification Suppression}{Basic Facilities of a Virtio Device / Virtqueues / Used Buffer Notification Suppression}
 
 If the VIRTIO_F_EVENT_IDX feature bit is not negotiated:
 \begin{itemize}
 \item The device MUST ignore the \field{used_event} value.
 \item After the device writes a descriptor index into the used ring:
   \begin{itemize}
-  \item If \field{flags} is 1, the device SHOULD NOT send an interrupt.
-  \item If \field{flags} is 0, the device MUST send an interrupt.
+  \item If \field{flags} is 1, the device SHOULD NOT send a notification.
+  \item If \field{flags} is 0, the device MUST send a notification.
   \end{itemize}
 \end{itemize}
 
@@ -366,14 +370,16 @@ Otherwise, if the VIRTIO_F_EVENT_IDX feature bit is negotiated:
   \begin{itemize}
   \item If the \field{idx} field in the used ring (which determined
     where that descriptor index was placed) was equal to
-    \field{used_event}, the device MUST send an interrupt.
-  \item Otherwise the device SHOULD NOT send an interrupt.
+    \field{used_event}, the device MUST send a notification.
+  \item Otherwise the device SHOULD NOT send a notification.
   \end{itemize}
 \end{itemize}
 
 \begin{note}
 For example, if \field{used_event} is 0, then a device using
-  VIRTIO_F_EVENT_IDX would interrupt after the first buffer is
+
+  VIRTIO_F_EVENT_IDX would send a used buffer notification
+  to the driver after the first buffer is
   used (and again after the 65536th buffer, etc).
 \end{note}
 
@@ -460,14 +466,16 @@ that uninitialized memory has been overwritten when it has not.
 The driver MUST NOT make assumptions about data in device-writable buffers
 beyond the first \field{len} bytes, and SHOULD ignore this data.
 
-\subsection{Virtqueue Notification Suppression}\label{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Notification Suppression}
+\subsection{Available Buffer Notification Suppression}\label{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Notification Suppression}
 
-The device can suppress notifications in a manner analogous to the way
-drivers can suppress interrupts as detailed in section \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Interrupt Suppression}.
+The device can suppress available buffer notifications in a manner
+analogous to the way drivers can suppress used buffer notifications as
+detailed in section \ref{sec:Basic Facilities of a Virtio Device /
+Virtqueues / Used Buffer Notification Suppression}.
 The device manipulates \field{flags} or \field{avail_event} in the used ring the
 same way the driver manipulates \field{flags} or \field{used_event} in the available ring.
 
-\drivernormative{\subsubsection}{Virtqueue Notification Suppression}{Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Notification Suppression}
+\drivernormative{\subsubsection}{Available Buffer Notification Suppression}{Basic Facilities of a Virtio Device / Virtqueues / Available Buffer Notification Suppression}
 
 The driver MUST initialize \field{flags} in the used ring to 0 when
 allocating the used ring.
@@ -494,7 +502,7 @@ Otherwise, if the VIRTIO_F_EVENT_IDX feature bit is negotiated:
   \end{itemize}
 \end{itemize}
 
-\devicenormative{\subsubsection}{Virtqueue Notification Suppression}{Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Notification Suppression}
+\devicenormative{\subsubsection}{Available Buffer Notification Suppression}{Basic Facilities of a Virtio Device / Virtqueues / Available Buffer Notification Suppression}
 If the VIRTIO_F_EVENT_IDX feature bit is not negotiated:
 \begin{itemize}
 \item The device MUST set \field{flags} to 0 or 1.
@@ -562,8 +570,8 @@ The driver offers buffers to one of the device's virtqueues as follows:
 \item The driver performs a suitable memory barrier to ensure that it updates
   the \field{idx} field before checking for notification suppression.
 
-\item If notifications are not suppressed, the driver notifies the device
-    of the new available buffers.
+\item The driver sends an available buffer notification to the device if
+    such notifications are not suppressed.
 \end{enumerate}
 
 Note that the above code does not take precautions against the
@@ -659,26 +667,30 @@ The driver MUST perform a suitable memory barrier before reading \field{flags} o
 
 Once the device has used buffers referred to by a descriptor (read from or written to them, or
 parts of both, depending on the nature of the virtqueue and the
-device), it interrupts the driver as detailed in section \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Interrupt Suppression}.
+device), it sends a used buffer notification to the driver as detailed
+in section \ref{sec:Basic Facilities of a Virtio Device / Virtqueues /
+Used Buffer Notification Suppression}.
 
 \begin{note}
-For optimal performance, a driver MAY disable interrupts while processing
-the used ring, but beware the problem of missing interrupts between
-emptying the ring and reenabling interrupts.  This is usually handled by
-re-checking for more used buffers after interrups are re-enabled:
+
+For optimal performance, a driver MAY disable used buffer notifications
+while processing the used ring, but beware the problem of missing
+notifications between emptying the ring and reenabling notifications.  This
+is usually handled by re-checking for more used buffers after
+notifications are re-enabled:
 
 \begin{lstlisting}
-virtq_disable_interrupts(vq);
+virtq_disable_used_buffer_notifications(vq);
 
 for (;;) {
         if (vq->last_seen_used != le16_to_cpu(virtq->used.idx)) {
-                virtq_enable_interrupts(vq);
+                virtq_enable_used_buffer_notifications(vq);
                 mb();
 
                 if (vq->last_seen_used != le16_to_cpu(virtq->used.idx))
                         break;
 
-                virtq_disable_interrupts(vq);
+                virtq_disable_used_buffer_notifications(vq);
         }
 
         struct virtq_used_elem *e = virtq.used->ring[vq->last_seen_used%vsz];
-- 
1.7.1


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

