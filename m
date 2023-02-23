Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: [PATCH 3/3] transport-mmio: Refer to the vq by its number
Date: Thu, 23 Feb 2023 07:46:24 +0200
Message-ID: <20230223054624.168042-4-parav@nvidia.com>
In-Reply-To: <20230223054624.168042-1-parav@nvidia.com>
References: <20230223054624.168042-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
To: mst@redhat.com, virtio-dev@lists.oasis-open.org, cohuck@redhat.com
Cc: virtio-comment@lists.oasis-open.org, shahafs@nvidia.com, Parav Pandit <parav@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Currently specification uses virtqueue index and
number interchangeably to refer to the virtqueue.

Instead refer to it by its number.

This patch is on top of [1].

[1] https://lists.oasis-open.org/archives/virtio-dev/202302/msg00527.html

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
 transport-mmio.tex | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/transport-mmio.tex b/transport-mmio.tex
index c59975e..324cecf 100644
--- a/transport-mmio.tex
+++ b/transport-mmio.tex
@@ -96,7 +96,7 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio=
 Transport Options / Vi
     bits accessible by writing to \field{DriverFeatures}.
   }
   \hline
-  \mmioreg{QueueSel}{Virtual queue index}{0x030}{W}{%
+  \mmioreg{QueueSel}{Virtual queue number}{0x030}{W}{%
     Writing to this register selects the virtual queue that the
     following operations on \field{QueueNumMax}, \field{QueueNum}, \field{=
QueueReady},
     \field{QueueDescLow}, \field{QueueDescHigh}, \field{QueueDriverlLow}, =
\field{QueueDriverHigh},
@@ -130,7 +130,7 @@ \subsection{MMIO Device Register Layout}\label{sec:Virt=
io Transport Options / Vi
     there are new buffers to process in a queue.
=20
     When VIRTIO_F_NOTIFICATION_DATA has not been negotiated,
-    the value written is the queue index.
+    the value written is the queue number.
=20
     When VIRTIO_F_NOTIFICATION_DATA has been negotiated,
     the \field{Notification data} value has the following format:
@@ -373,7 +373,7 @@ \subsubsection{Available Buffer Notifications}\label{se=
c:Virtio Transport Option
=20
 When VIRTIO_F_NOTIFICATION_DATA has not been negotiated,
 the driver sends an available buffer notification to the device by writing
-the 16-bit virtqueue index
+the 16-bit virtqueue number
 of the queue to be notified to \field{QueueNotify}.
=20
 When VIRTIO_F_NOTIFICATION_DATA has been negotiated,
@@ -451,7 +451,7 @@ \subsection{Legacy interface}\label{sec:Virtio Transpor=
t Options / Virtio Over M
     (see QueuePFN).
   }
   \hline
-  \mmioreg{QueueSel}{Virtual queue index}{0x030}{W}{%
+  \mmioreg{QueueSel}{Virtual queue number}{0x030}{W}{%
     Writing to this register selects the virtual queue that the
     following operations on the \field{QueueNumMax}, \field{QueueNum}, \fi=
eld{QueueAlign}
     and \field{QueuePFN} registers apply to. The index
--=20
2.26.2

