Return-Path: SRS0=KMw5=FK=redhat.com=mst@kernel.org
Date: Fri, 16 Feb 2018 09:26:22 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v8 14/16] VIRTIO_F_NOTIFICATION_DATA: extra data to devices
Message-ID: <20180216092622-mutt-send-email-mst@kernel.org>
References: <1518765602-8739-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518765602-8739-1-git-send-email-mst@redhat.com>
To: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Tiwei Bie <tiwei.bie@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dhanoa, Kully" <kully.dhanoa@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Motivation for the new feature is included in the text.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 content.tex | 136 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 130 insertions(+), 6 deletions(-)

diff --git a/content.tex b/content.tex
index c57a918..ca6d2d9 100644
--- a/content.tex
+++ b/content.tex
@@ -283,9 +283,76 @@ Packed Virtqueues}).
 Every driver and device supports either the Packed or the Split
 Virtqueue format, or both.
 
+\subsection{Driver notifications} \label{sec:Virtqueues / Driver notifications}
+Driver is sometimes required to notify the device after
+making changes to the virtqueue.
+
+When VIRTIO_F_NOTIFICATION_DATA has not been negotiated,
+this notification involves sending the
+virtqueue number to the device (depending on the transport).
+
+However, some devices benefit from ability to find out the number of
+available descriptors in the ring, and whether to send
+interrupts to drivers without accessing virtqueue in memory:
+for efficiency or as a debugging aid.
+
+To help with these optimizations, when VIRTIO_F_NOTIFICATION_DATA
+has been negotiated, driver notifications to the device include
+the following information:
+
+\begin{itemize}
+\item VQ number
+\item Offset
+      Within the ring where the next available ring entry
+      will be written.
+      Without VIRTIO_F_RING_PACKED this refers to the
+      15 least significant bits of the available index.
+      With VIRTIO_F_RING_PACKED this refers to the offset
+      (in units of descritor entries)
+      within the descriptor ring where the next available
+      descriptor will be written.
+\item Wrap Counter
+      With VIRTIO_F_RING_PACKED this is the wrap counter
+      referring to the next available descriptor.
+      Without VIRTIO_F_RING_PACKED this is the most significant bit
+      of the available index.
+\end{itemize}
+
+Note that driver can trigger multiple notifications even without
+making any more changes to the ring. These would then have
+identical \field{Offset} and \field{Wrap Counter} values.
+
 \input{split-ring.tex}
 
 \input{packed-ring.tex}
+
+\subsubsection{Driver notifications}
+
+\label{sec:Packed Virtqueues / Driver notifications}
+Whenever not suppressed by Device Event Suppression,
+driver is required to notify the device after
+making changes to the virtqueue.
+
+Some devices benefit from ability to find out the number of
+available descriptors in the ring, and whether to send
+interrupts to drivers without accessing virtqueue in memory:
+for efficiency or as a debugging aid.
+
+To help with these optimizations, driver notifications
+to the device include the following information:
+
+\begin{itemize}
+\item VQ number
+\item Offset (in units of descriptor size) within the ring
+      where the next available descriptor will be written
+\item Wrap Counter referring to the next available
+      descriptor
+\end{itemize}
+
+Note that driver can trigger multiple notifications even without
+making any more changes to the ring. These would then have
+identical \field{Offset} and \field{Wrap Counter} values.
+
 \chapter{General Initialization And Device Operation}\label{sec:General Initialization And Device Operation}
 
 We start with an overview of device initialization, then expand on the
@@ -862,7 +929,9 @@ the same Queue Notify address for all queues.
 \devicenormative{\paragraph}{Notification capability}{Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Notification capability}
 The device MUST present at least one notification capability.
 
-The \field{cap.offset} MUST be 2-byte aligned.  
+For devices not offering VIRTIO_F_NOTIFICATION_DATA:
+
+The \field{cap.offset} MUST be 2-byte aligned.
 
 The device MUST either present \field{notify_off_multiplier} as an even power of 2,
 or present \field{notify_off_multiplier} as 0.
@@ -876,6 +945,23 @@ For all queues, the value \field{cap.length} presented by the device MUST satisf
 cap.length >= queue_notify_off * notify_off_multiplier + 2
 \end{lstlisting}
 
+For devices offering VIRTIO_F_NOTIFICATION_DATA:
+
+The device MUST either present \field{notify_off_multiplier} as a
+number that is a power of 2 that is also a multiple 4,
+or present \field{notify_off_multiplier} as 0.
+
+The \field{cap.offset} MUST be 4-byte aligned.
+
+The value \field{cap.length} presented by the device MUST be at least 4
+and MUST be large enough to support queue notification offsets
+for all supported queues in all possible configurations.
+
+For all queues, the value \field{cap.length} presented by the device MUST satisfy:
+\begin{lstlisting}
+cap.length >= queue_notify_off * notify_off_multiplier + 4
+\end{lstlisting}
+
 \subsubsection{ISR status capability}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / ISR status capability}
 
 The VIRTIO_PCI_CAP_ISR_CFG capability
@@ -1268,8 +1354,22 @@ separate cache lines.
 
 \subsubsection{Notifying The Device}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Notifying The Device}
 
-The driver notifies the device by writing the 16-bit virtqueue index
-of this virtqueue to the Queue Notify address.  See \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Notification capability} for how to calculate this address.
+When VIRTIO_F_NOTIFICATION_DATA has not been negotiated,
+the driver notifies the device by writing the 16-bit virtqueue index
+of this virtqueue (in little-endian byte order format)
+to the Queue Notify address.
+
+When VIRTIO_F_NOTIFICATION_DATA has been negotiated,
+the driver notifies the device by writing the following
+32-bit value to the Queue Notify address:
+\begin{lstlisting}
+__le16 vqn;
+__le16 next_off : 15;
+u8    next_wrap : 1;
+\end{lstlisting}
+
+See \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Notification capability} for how to calculate the
+Queue Notify address.
 
 \subsubsection{Virtqueue Interrupts From The Device}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Virtqueue Interrupts From The Device}
 
@@ -1500,8 +1600,17 @@ All register values are organized as Little Endian.
   }
   \hline 
   \mmioreg{QueueNotify}{Queue notifier}{0x050}{W}{%
-    Writing a queue index to this register notifies the device that
-    there are new buffers to process in the queue.
+    Writing a value this register notifies the device that
+    there are new buffers to process in a queue.
+
+    When VIRTIO_F_NOTIFICATION_DATA has not been negotiated,
+    the value written is the queue index.
+
+    When VIRTIO_F_NOTIFICATION_DATA has been negotiated,
+    the value is calculated as follows:
+    $
+    u32 notification\_data = vqn | (next\_off << 16) | (next\_wrap << 31);
+    $
   }
   \hline 
   \mmioreg{InterruptStatus}{Interrupt status}{0x60}{R}{%
@@ -2340,12 +2449,23 @@ GPR  &   Input Value     & Output Value \\
 \hline
   2   &  Subchannel ID    & Host Cookie  \\
 \hline
-  3   & Virtqueue number  &              \\
+  3   & Notification data &              \\
 \hline
   4   &   Host Cookie     &              \\
 \hline
 \end{tabular}
 
+When VIRTIO_F_NOTIFICATION_DATA has not been negotiated,
+the \field{Notification data} includes the Virtqueue number.
+
+When VIRTIO_F_NOTIFICATION_DATA has been negotiated,
+the \field{Notification data} is calculated as follows:
+
+\begin{lstlisting}
+u32 notification_data = vqn | (next_off << 16) | (next_wrap << 31);
+\end{lstlisting}
+
+
 \devicenormative{\paragraph}{Guest->Host Notification}{Virtio Transport Options / Virtio over channel I/O / Device Operation / Guest->Host Notification}
 The device MUST ignore bits 0-31 (counting from the left) of GPR2.
 This aligns passing the subchannel ID with the way it is passed
@@ -5260,6 +5380,10 @@ Descriptors} and \ref{sec:Packed Virtqueues / Indirect Flag: Scatter-Gather Supp
   \item[VIRTIO_F_IN_ORDER(35)] This feature indicates
   that all buffers are used by the device in the same
   order in which they have been made available.
+  \item[VIRTIO_F_NOTIFICATION_DATA(36)] This feature indicates
+  that drivers pass extra data (besides identifying the Virtqueue)
+  in their device notifications.
+  See \ref{sec:Virtqueues / Driver notifications}~\nameref{sec:Virtqueues / Driver notifications}.
 \end{description}
 
 \drivernormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}
-- 
MST

