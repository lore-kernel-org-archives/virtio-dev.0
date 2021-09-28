Return-Path: <xuanzhuo@linux.alibaba.com>
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH v4 2/3] virtio: pci support virtqueue reset
Date: Tue, 28 Sep 2021 15:55:34 +0800
Message-Id: <20210928075535.100384-3-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20210928075535.100384-1-xuanzhuo@linux.alibaba.com>
References: <20210928075535.100384-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
To: cohuck@redhat.com, jasowang@redhat.com
Cc: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

PCI support virtqueue reset.

virtio_pci_common_cfg add "queue_reset" to support virtqueue reset.
The driver uses this to selectively reset the queue.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 content.tex | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/content.tex b/content.tex
index 05b05ba..1c35df5 100644
--- a/content.tex
+++ b/content.tex
@@ -900,6 +900,7 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
         le64 queue_driver;              /* read-write */
         le64 queue_device;              /* read-write */
         le16 queue_notify_data;         /* read-only for driver */
+        le16 queue_reset;               /* read-write */
 };
 \end{lstlisting}
 
@@ -979,6 +980,12 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
         may benefit from providing another value, for example an internal virtqueue
         identifier, or an internal offset related to the virtqueue number.
         \end{note}
+
+\item[\field{queue_reset}]
+        The driver uses this to selectively reset the queue.
+        This field exists only if VIRTIO_F_RING_RESET has been
+        negotiated. (see \ref{sec:Virtqueues / Virtqueue Reset}).
+
 \end{description}
 
 \devicenormative{\paragraph}{Common configuration structure layout}{Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Common configuration structure layout}
@@ -1020,6 +1027,20 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
 
 The device MUST present a 0 in \field{queue_enable} on reset.
 
+If VIRTIO_F_RING_RESET has been negotiated, the device MUST present a 0 in
+\field{queue_enable} after the driver has reset the virtqueue via
+\field{queue_reset}.
+
+If VIRTIO_F_RING_RESET has been negotiated, the device MUST present a 0 in
+\field{queue_reset} on reset.
+
+If VIRTIO_F_RING_RESET has been negotiated, The device MUST present a 0 in
+\field{queue_reset} after the virtqueue is enabled with \field{queue_enable}.
+
+The device MUST reset the queue when 1 is written to \field{queue_reset}, and
+present a 1 in \field{queue_reset} after the queue has been reset, until the
+driver re-enables the queue via \field{queue_enable}. (see \ref{sec:Virtqueues / Virtqueue Reset}).
+
 The device MUST present a 0 in \field{queue_size} if the virtqueue
 corresponding to the current \field{queue_select} is unavailable.
 
@@ -1044,6 +1065,13 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
 
 The driver MUST NOT write a 0 to \field{queue_enable}.
 
+If VIRTIO_F_RING_RESET has been negotiated, after the driver writes 1 to
+\field{queue_reset} to reset the queue, it MUST verify that the queue
+has been reset by reading back \field{queue_reset} and ensuring that it
+is 1. The driver MAY re-enable the queue by writing a 1 to
+\field{queue_enable} after ensuring that the other virtqueue fields have
+been set up correctly. (see \ref{sec:Virtqueues / Virtqueue Reset}).
+
 \subsubsection{Notification structure layout}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Notification capability}
 
 The notification location is found using the VIRTIO_PCI_CAP_NOTIFY_CFG
-- 
2.31.0

