Return-Path: virtio-dev-return-4953-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3267E985DDA
	for <virtio-dev@lists.oasis-open.org>; Tue, 13 Nov 2018 11:00:47 +0000 (UTC)
From: Wei Wang <wei.w.wang@intel.com>
Date: Tue, 13 Nov 2018 18:27:46 +0800
Message-Id: <1542104867-11143-2-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1542104867-11143-1-git-send-email-wei.w.wang@intel.com>
References: <1542104867-11143-1-git-send-email-wei.w.wang@intel.com>
Subject: [virtio-dev] [PATCH v1 1/2] content/virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT
To: virtio-dev@lists.oasis-open.org, mst@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

The VIRTIO_BALLOON_F_FREE_PAGE_HINT feature supports driver reporting
free page hints to the device.

Live migration can use the virtio-balloon device to get the guest free
page hints, and avoid sending those free pages. It is not concerned that
the memory pages are used (e.g. guest reclaimed some of them due to memory
pressure) after they are given to the device as hints of free pages,
because they will be tracked by the hypervisor and transferred in the
subsequent round if they are used and written.

Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 content.tex | 122 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 116 insertions(+), 6 deletions(-)

diff --git a/content.tex b/content.tex
index c346183..673c891 100644
--- a/content.tex
+++ b/content.tex
@@ -4367,9 +4367,9 @@ The traditional virtio memory balloon device is a primitive device for
 managing guest memory: the device asks for a certain amount of
 memory, and the driver supplies it (or withdraws it, if the device
 has more than it asks for). This allows the guest to adapt to
-changes in allowance of underlying physical memory. If the
-feature is negotiated, the device can also be used to communicate
-guest memory statistics to the host.
+changes in allowance of underlying physical memory. The device can
+also be used to communicate guest memory statistics and guest free
+memory pages to the host when the related features are negotiated.
 
 \subsection{Device ID}\label{sec:Device Types / Memory Balloon Device / Device ID}
   5
@@ -4378,11 +4378,14 @@ guest memory statistics to the host.
 \begin{description}
 \item[0] inflateq
 \item[1] deflateq
-\item[2] statsq.
+\item[2] statsq
+\item[3] freepageq
 \end{description}
 
   Virtqueue 2 only exists if VIRTIO_BALLON_F_STATS_VQ set.
 
+  Virtqueue 3 only exists if VIRTIO_BALLON_F_FREE_PAGE_HINT set.
+
 \subsection{Feature bits}\label{sec:Device Types / Memory Balloon Device / Feature bits}
 \begin{description}
 \item[VIRTIO_BALLOON_F_MUST_TELL_HOST (0)] Host has to be told before
@@ -4392,6 +4395,8 @@ guest memory statistics to the host.
     memory statistics is present.
 \item[VIRTIO_BALLOON_F_DEFLATE_ON_OOM (2) ] Deflate balloon on
     guest out of memory condition.
+\item[VIRTIO_BALLOON_F_FREE_PAGE_HINT(3) ] Guest reports free pages
+    to host.
 
 \end{description}
 
@@ -4415,16 +4420,32 @@ allow guest to use memory before notifying host if
 VIRTIO_BALLOON_F_MUST_TELL_HOST is not negotiated.
 
 \subsection{Device configuration layout}\label{sec:Device Types / Memory Balloon Device / Device configuration layout}
-  Both fields of this configuration
-  are always available.
+
+\begin{lstlisting}
+#define VIRTIO_BALLOON_CMD_ID_MIN 0x80000000
+#define VIRTIO_BALLOON_CMD_ID_STOP 0x0
+#define VIRTIO_BALLOON_CMD_ID_DONE 0x1
+\end{lstlisting}
 
 \begin{lstlisting}
 struct virtio_balloon_config {
         le32 num_pages;
         le32 actual;
+        le32 free_page_report_cmd_id;
 };
 \end{lstlisting}
 
+\field{num_pages} and \field{actual} are always available.
+
+\field{free_page_report_cmd_id} is available if
+VIRTIO_BALLON_F_FREE_PAGE_HINT negotiated.
+
+\devicenormative{\subsubsection}{Device configuration layout}{Device Types / Traditional Memory Balloon Device / Device configuration layout}
+
+The device MUST NOT set \field{free_page_report_cmd_id} to a value
+between \field{VIRTIO_BALLOON_CMD_ID_DONE} and
+\field{VIRTIO_BALLOON_CMD_ID_MIN} exclusive.
+
 \subparagraph{Legacy Interface: Device configuration layout}\label{sec:Device Types / Memory Balloon Device / Device
 configuration layout / Legacy Interface: Device configuration layout}
 When using the legacy interface, transitional devices and drivers
@@ -4448,8 +4469,20 @@ The device initialization process is outlined below:
   \item DRIVER_OK is set: device operation begins.
   \item Notify the device about the stats virtqueue buffer.
   \end{enumerate}
+
+\item If the VIRTIO_BALLOON_F_FREE_PAGE_HINT feature bit is
+  negotiated:
+  \begin{enumerate}
+  \item Identify the free page virtqueue.
+  \item Set \field{free_page_report_cmd_id} to
+    \field{VIRTIO_BALLOON_CMD_ID_MIN}.
+  \item Register a notifier with an external component (e.g. a live
+        migration agent) who will request for the free page reporting
+        from the driver.
+  \end{enumerate}
 \end{enumerate}
 
+
 \subsection{Device Operation}\label{sec:Device Types / Memory Balloon Device / Device Operation}
 
 The device is driven either by the receipt of a configuration
@@ -4718,6 +4751,83 @@ first buffer.
   allocations in the guest.
 \end{description}
 
+\subsubsection{Free Page Reporting}\label{sec:Device Types / Memory Balloon Device / Device Operation / Free Page Reporting}
+
+The free page reporting is driven by the device. The device MAY
+request the driver to start or stop the free page reporting.
+
+A request to start the free page reporting proceeds as follows:
+
+\begin{enumerate}
+\item The device updates \field{free_page_report_cmd_id}: if it has
+  reached the maximum value, 0xffffffff, resets it to
+  \field{VIRTIO_BALLOON_CMD_ID_MIN}. Otherwise, increments it by 1.
+\item The device sends a configuration notification to the driver.
+\item The driver reads \field{free_page_report_cmd_id}: if it is not
+  \field{VIRTIO_BALLOON_CMD_ID_STOP},
+  \field{VIRTIO_BALLOON_CMD_ID_DONE}, and different from the value it
+  read last time, start free page reporting as follows:
+  \begin{enumerate}
+  \item Write the received \field{free_page_report_cmd_id} to a
+    buffer and add it to the free page virtqueue to indicate the start
+    of the reporting.
+  \item Collect free pages and write each page address into an entry
+    of the virtqueue.
+  \item Write \field{VIRTIO_BALLOON_CMD_ID_STOP} into a buffer and add
+    it to the free page virtqueue, which signifies that all the free
+    pages are reported.
+  \end{enumerate}
+    A driver to device notification is sent in the above steps after
+    adding a buffer or address to the virtqueue if the notification
+    is not suppressed.
+\item The device pops entries from the virtqueue: it starts to consume
+  the addresses after it receives the buffer that stores a value which
+  equals to \field{free_page_report_cmd_id}, and stops the address
+  consumption after receiving a buffer which stores
+  \field{VIRTIO_BALLOON_CMD_ID_STOP}.
+\end{enumerate}
+
+A request to actively stop the free page reporting proceeds as
+follows:
+
+\begin{enumerate}
+\item The device sets \field{free_page_report_cmd_id} to
+  \field{VIRTIO_BALLOON_CMD_ID_STOP}, followed by a configuration
+  notification to the driver if not suppressed.
+\item The driver reads \field{free_page_report_cmd_id} and identifies
+  that it is \field{VIRTIO_BALLOON_CMD_ID_STOP}, then it stops
+  collecting free pages.
+\item The driver writes \field{VIRTIO_BALLOON_CMD_ID_STOP} into a
+  buffer and adds it to the virtqueue.
+\item The device stops poping entires from the virtqueue
+  after receiving the buffer that stores
+  \field{VIRTIO_BALLOON_CMD_ID_STOP}.
+\end{enumerate}
+
+
+The device can end the free page reporting by setting
+\field{free_page_report_cmd_id} to \field{VIRTIO_BALLOON_CMD_ID_DONE},
+followed by a configuration notification to the driver.
+
+\drivernormative{\paragraph}{Free Page Reporting}{Device Types / Memory Balloon Device / Device Operation / Free Page Reporting}
+Normative statements in this section apply if and only if the
+VIRTIO_BALLOON_F_FREE_PAGE_HINT feature has been negotiated.
+
+The driver SHOULD add the addresses of free pages as input buffers
+to the virtqueue.
+
+The driver SHOULD add the buffer that stores the value of
+\field{free_page_report_cmd_id} or \field{VIRTIO_BALLOON_CMD_ID_STOP}
+as an output buffer to the virtqueue.
+
+The driver SHOULD use different buffers to send the the value of
+\field{free_page_report_cmd_id} and
+\field{VIRTIO_BALLOON_CMD_ID_STOP} to avoid one being overwritten by
+another when the device has a delay in reading the command.
+
+The driver SHOULD release all the collected free pages after receiving
+\field{VIRTIO_BALLOON_CMD_ID_DONE}.
+
 \section{SCSI Host Device}\label{sec:Device Types / SCSI Host Device}
 
 The virtio SCSI host device groups together one or more virtual
-- 
2.7.4


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

