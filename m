Return-Path: <virtio-comment-return-4514-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Parav Pandit <parav@nvidia.com>
Date: Sat, 25 Feb 2023 00:27:18 +0200
Message-ID: <20230224222718.339883-4-parav@nvidia.com>
In-Reply-To: <20230224222718.339883-1-parav@nvidia.com>
References: <20230224222718.339883-1-parav@nvidia.com>
MIME-Version: 1.0
Subject: [virtio-comment] [PATCH v1 3/3] transport-mmio: Refer to the vq by its number
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
To: mst@redhat.com, virtio-dev@lists.oasis-open.org, cohuck@redhat.com
Cc: virtio-comment@lists.oasis-open.org, shahafs@nvidia.com, Parav Pandit <parav@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Currently specification uses virtqueue index and
number interchangeably to refer to the virtqueue.

Instead refer to it by its number.

This patch is on top of [1].

[1] https://lists.oasis-open.org/archives/virtio-dev/202302/msg00527.html

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
 transport-mmio.tex | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/transport-mmio.tex b/transport-mmio.tex
index 1bcc194..7181d3e 100644
--- a/transport-mmio.tex
+++ b/transport-mmio.tex
@@ -108,7 +108,7 @@ \subsection{MMIO Device Register Layout}\label{sec:Virt=
io Transport Options / Vi
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
@@ -142,7 +142,7 @@ \subsection{MMIO Device Register Layout}\label{sec:Virt=
io Transport Options / Vi
     there are new buffers to process in a queue.
=20
     When VIRTIO_F_NOTIFICATION_DATA has not been negotiated,
-    the value written is the queue index.
+    the value written is the queue number.
=20
     When VIRTIO_F_NOTIFICATION_DATA has been negotiated,
     the \field{Notification data} value has the following format:
@@ -385,7 +385,7 @@ \subsubsection{Available Buffer Notifications}\label{se=
c:Virtio Transport Option
=20
 When VIRTIO_F_NOTIFICATION_DATA has not been negotiated,
 the driver sends an available buffer notification to the device by writing
-the 16-bit virtqueue index
+the 16-bit virtqueue number
 of the queue to be notified to \field{QueueNotify}.
=20
 When VIRTIO_F_NOTIFICATION_DATA has been negotiated,
@@ -463,7 +463,7 @@ \subsection{Legacy interface}\label{sec:Virtio Transpor=
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


This publicly archived list offers a means to provide input to the
OASIS Virtual I/O Device (VIRTIO) TC.

In order to verify user consent to the Feedback License terms and
to minimize spam in the list archive, subscription is required
before posting.

Subscribe: virtio-comment-subscribe@lists.oasis-open.org
Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
List help: virtio-comment-help@lists.oasis-open.org
List archive: https://lists.oasis-open.org/archives/virtio-comment/
Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lis=
ts
Committee: https://www.oasis-open.org/committees/virtio/
Join OASIS: https://www.oasis-open.org/join/

