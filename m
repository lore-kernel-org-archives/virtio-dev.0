Return-Path: <mgurtovoy@nvidia.com>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH v6 4/5] Add admin_queue_index register to PCI common configuration structure
Date: Sun, 31 Jul 2022 18:43:53 +0300
Message-ID: <20220731154354.15698-5-mgurtovoy@nvidia.com>
In-Reply-To: <20220731154354.15698-1-mgurtovoy@nvidia.com>
References: <20220731154354.15698-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
To: jasowang@redhat.com, virtio-comment@lists.oasis-open.org, mst@redhat.com, cohuck@redhat.com, virtio-dev@lists.oasis-open.org
Cc: oren@nvidia.com, parav@nvidia.com, shahafs@nvidia.com, aadam@redhat.com, virtio@lists.oasis-open.org, eperezma@redhat.com, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

This new register will be used for querying the index of the admin
virtqueue of a virtio device. To configure, reset or enable the admin
virtqueue, the driver should follow existing queue configuration/setup
sequence.

Reviewed-by: Parav Pandit <parav@nvidia.com>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 content.tex | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/content.tex b/content.tex
index c15423e..5fda1a0 100644
--- a/content.tex
+++ b/content.tex
@@ -904,6 +904,9 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
         le64 queue_device;              /* read-write */
         le16 queue_notify_data;         /* read-only for driver */
         le16 queue_reset;               /* read-write */
+
+        /* About admin virtqueue. */
+        le16 admin_queue_index;         /* read-only for driver */
 };
 \end{lstlisting}
 
@@ -989,6 +992,10 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
         This field exists only if VIRTIO_F_RING_RESET has been
         negotiated. (see \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}).
 
+\item[\field{admin_queue_index}]
+        The device uses this to report the index of the admin virtqueue.
+        This field always exists. Its value is valid only if VIRTIO_F_ADMIN_VQ has been negotiated.
+
 \end{description}
 
 \devicenormative{\paragraph}{Common configuration structure layout}{Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Common configuration structure layout}
@@ -1075,6 +1082,9 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
 were used before the queue reset.
 (see \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}).
 
+For configuring the admin virtqueue, the driver MUST use the value of \field{admin_queue_index}.
+For more details on virtqueue configuration see section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Device Initialization / Virtqueue Configuration}.
+
 \subsubsection{Notification structure layout}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Notification capability}
 
 The notification location is found using the VIRTIO_PCI_CAP_NOTIFY_CFG
-- 
2.21.0

