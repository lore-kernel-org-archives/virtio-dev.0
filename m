Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: [PATCH 2/3] transport-mmio: Rename QueueNum register
Date: Thu, 23 Feb 2023 07:46:23 +0200
Message-ID: <20230223054624.168042-3-parav@nvidia.com>
In-Reply-To: <20230223054624.168042-1-parav@nvidia.com>
References: <20230223054624.168042-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
To: mst@redhat.com, virtio-dev@lists.oasis-open.org, cohuck@redhat.com
Cc: virtio-comment@lists.oasis-open.org, shahafs@nvidia.com, Parav Pandit <parav@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Currently, the specification uses virtqueue index and number
interchangeably to refer to the virtqueue.

It is better to identify it using one terminology.

Two registers QueueNumMax and QueueNum actually reflect the queue size
or queue depth indicating max and actual number of entries in the queue.
Equivalent register in PCI transport is named differently as queue_size.

To bring consistency between pci and mmio transport, and to avoid
confusion between number and index, rename the QueueNumMax and QueueNum
registers to QueueSizeMax and QueueSize respectively.

[1] https://lists.oasis-open.org/archives/virtio-dev/202302/msg00527.html

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
 transport-mmio.tex | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/transport-mmio.tex b/transport-mmio.tex
index 65bae54..c59975e 100644
--- a/transport-mmio.tex
+++ b/transport-mmio.tex
@@ -104,14 +104,14 @@ \subsection{MMIO Device Register Layout}\label{sec:Vi=
rtio Transport Options / Vi
     number of the first queue is zero (0x0).
   }
   \hline
-  \mmioreg{QueueNumMax}{Maximum virtual queue size}{0x034}{R}{%
+  \mmioreg{QueueSizeMax}{Maximum virtual queue size}{0x034}{R}{%
     Reading from the register returns the maximum size (number of
     elements) of the queue the device is ready to process or
     zero (0x0) if the queue is not available. This applies to the
     queue selected by writing to \field{QueueSel}.
   }
   \hline
-  \mmioreg{QueueNum}{Virtual queue size}{0x038}{W}{%
+  \mmioreg{QueueSize}{Virtual queue size}{0x038}{W}{%
     Queue size is the number of elements in the queue.
     Writing to this register notifies the device what size of the
     queue the driver will use. This applies to the queue selected by
@@ -459,7 +459,7 @@ \subsection{Legacy interface}\label{sec:Virtio Transpor=
t Options / Virtio Over M
 .
   }
   \hline
-  \mmioreg{QueueNumMax}{Maximum virtual queue size}{0x034}{R}{%
+  \mmioreg{QueueSizeMax}{Maximum virtual queue size}{0x034}{R}{%
     Reading from the register returns the maximum size of the queue
     the device is ready to process or zero (0x0) if the queue is not
     available. This applies to the queue selected by writing to
@@ -467,7 +467,7 @@ \subsection{Legacy interface}\label{sec:Virtio Transpor=
t Options / Virtio Over M
     (0x0), so when the queue is not actively used.
   }
   \hline
-  \mmioreg{QueueNum}{Virtual queue size}{0x038}{W}{%
+  \mmioreg{QueueSize}{Virtual queue size}{0x038}{W}{%
     Queue size is the number of elements in the queue.
     Writing to this register notifies the device what size of the
     queue the driver will use. This applies to the queue selected by
--=20
2.26.2

