Return-Path: virtio-dev-return-6670-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 34092985F03
	for <virtio-dev@lists.oasis-open.org>; Tue, 21 Jan 2020 06:19:50 +0000 (UTC)
From: Jing Liu <jing2.liu@linux.intel.com>
Date: Tue, 21 Jan 2020 21:54:30 +0800
Message-Id: <1579614873-21907-3-git-send-email-jing2.liu@linux.intel.com>
In-Reply-To: <1579614873-21907-1-git-send-email-jing2.liu@linux.intel.com>
References: <1579614873-21907-1-git-send-email-jing2.liu@linux.intel.com>
Subject: [virtio-dev] [PATCH v2 2/5] virtio-mmio: Enhance queue notification support
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
To: virtio-dev@lists.oasis-open.org
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, Jing Liu <jing2.liu@linux.intel.com>, Chao Peng <chao.p.peng@linux.intel.com>, Liu Jiang <gerry@linux.alibaba.com>, Zha Bin <zhabin@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>

With VIRTIO_F_MMIO_NOTIFICATION feature bit offered, the notification
mechanism is enhanced. Driver reads QueueNotify register to get
notification structure and calculate notification addresses of
each virtqueue.

Co-developed-by: Chao Peng <chao.p.peng@linux.intel.com>
Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
Co-developed-by: Liu Jiang <gerry@linux.alibaba.com>
Signed-off-by: Liu Jiang <gerry@linux.alibaba.com>
Co-developed-by: Zha Bin <zhabin@linux.alibaba.com>
Signed-off-by: Zha Bin <zhabin@linux.alibaba.com>
Signed-off-by: Jing Liu <jing2.liu@linux.intel.com>
---
 content.tex | 53 ++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 40 insertions(+), 13 deletions(-)

diff --git a/content.tex b/content.tex
index 826bc7d..5881253 100644
--- a/content.tex
+++ b/content.tex
@@ -1671,20 +1671,18 @@ \subsection{MMIO Device Register Layout}\label{sec:=
Virtio Transport Options / Vi
     accesses apply to the queue selected by writing to \field{QueueSel}.
   }
   \hline=20
-  \mmioreg{QueueNotify}{Queue notifier}{0x050}{W}{%
-    Writing a value to this register notifies the device that
-    there are new buffers to process in a queue.
+  \mmioreg{QueueNotify}{Queue notifier}{0x050}{RW}{%
+    When VIRTIO_F_MMIO_NOTIFICATION has not been negotiated, writing to th=
is
+    register notifies the device that there are new buffers to process in =
a queue.
=20
-    When VIRTIO_F_NOTIFICATION_DATA has not been negotiated,
-    the value written is the queue index.
+    When VIRTIO_F_MMIO_NOTIFICATION has been negotiated, reading this regi=
ster
+    returns the virtqueue notification structure for calculating notificat=
ion location.
=20
-    When VIRTIO_F_NOTIFICATION_DATA has been negotiated,
-    the \field{Notification data} value has the following format:
+    See \ref{sec:Virtio Transport Options / Virtio Over MMIO / MMIO-specif=
ic Initialization And Device Operation / Notification Structure Layout}
+    for the notification structure format.
=20
-    \lstinputlisting{notifications-le.c}
-
-    See \ref{sec:Virtqueues / Driver notifications}~\nameref{sec:Virtqueue=
s / Driver notifications}
-    for the definition of the components.
+    See \ref{sec:Virtio Transport Options / Virtio Over MMIO / MMIO-specif=
ic Initialization And Device Operation / Available Buffer Notifications}
+    for the notification data format.
   }
   \hline=20
   \mmioreg{InterruptStatus}{Interrupt status}{0x60}{R}{%
@@ -1858,6 +1856,31 @@ \subsubsection{Device Initialization}\label{sec:Virt=
io Transport Options / Virti
 Further initialization MUST follow the procedure described in
 \ref{sec:General Initialization And Device Operation / Device Initializati=
on}~\nameref{sec:General Initialization And Device Operation / Device Initi=
alization}.
=20
+\subsubsection{Notification Structure Layout}\label{sec:Virtio Transport O=
ptions / Virtio Over MMIO / MMIO-specific Initialization And Device Operati=
on / Notification Structure Layout}
+
+When VIRTIO_F_MMIO_NOTIFICATION has been negotiated, the notification loca=
tion is calculated
+by notification structure. Driver reads \field{QueueNotify} to get this st=
ructure formatted
+as follows.
+
+\begin{lstlisting}
+le32 {
+        notify_base : 16;
+        notify_multiplier : 16;
+};
+\end{lstlisting}
+
+\field{notify_multiplier} is combined with virtqueue index to derive the Q=
ueue Notify address
+within a memory mapped control registers for a virtqueue:
+
+\begin{lstlisting}
+        notify_base + queue_index * notify_multiplier
+\end{lstlisting}
+
+\begin{note}
+For example, if notify_multiplier is 0, the device uses the same Queue Not=
ify address for all
+queues.
+\end{note}
+
 \subsubsection{Virtqueue Configuration}\label{sec:Virtio Transport Options=
 / Virtio Over MMIO / MMIO-specific Initialization And Device Operation / V=
irtqueue Configuration}
=20
 The driver will typically initialize the virtual queue in the following wa=
y:
@@ -1893,16 +1916,20 @@ \subsubsection{Available Buffer Notifications}\labe=
l{sec:Virtio Transport Option
 When VIRTIO_F_NOTIFICATION_DATA has not been negotiated,
 the driver sends an available buffer notification to the device by writing
 the 16-bit virtqueue index
-of the queue to be notified to \field{QueueNotify}.
+of the queue to be notified to Queue Notify address.
=20
 When VIRTIO_F_NOTIFICATION_DATA has been negotiated,
 the driver sends an available buffer notification to the device by writing
-the following 32-bit value to \field{QueueNotify}:
+the following 32-bit value to Queue Notify address:
 \lstinputlisting{notifications-le.c}
=20
 See \ref{sec:Virtqueues / Driver notifications}~\nameref{sec:Virtqueues / =
Driver notifications}
 for the definition of the components.
=20
+For device not offering VIRTIO_F_MMIO_NOTIFICATION, the Queue Notify addre=
ss is \field{QueueNotify}.
+For device offering VIRTIO_F_MMIO_NOTIFICATION, see \ref{sec:Virtio Transp=
ort Options / Virtio Over MMIO / MMIO-specific Initialization And Device Op=
eration / Notification Structure Layout}
+for how to calculate the Queue Notify address.
+
 \subsubsection{Notifications From The Device}\label{sec:Virtio Transport O=
ptions / Virtio Over MMIO / MMIO-specific Initialization And Device Operati=
on / Notifications From The Device}
=20
 The memory mapped virtio device is using a single, dedicated
--=20
2.7.4


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

