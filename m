Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: [PATCH v1 1/3] transport-pci: Refer to the vq by its number
Date: Sat, 25 Feb 2023 00:27:16 +0200
Message-ID: <20230224222718.339883-2-parav@nvidia.com>
In-Reply-To: <20230224222718.339883-1-parav@nvidia.com>
References: <20230224222718.339883-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
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
 transport-pci.tex | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/transport-pci.tex b/transport-pci.tex
index 01fb652..0642107 100644
--- a/transport-pci.tex
+++ b/transport-pci.tex
@@ -1005,7 +1005,7 @@ \subsubsection{Device Initialization}\label{sec:Virti=
o Transport Options / Virti
 The driver typically does this as follows, for each virtqueue a device has=
:
=20
 \begin{enumerate}
-\item Write the virtqueue index (first queue is 0) to \field{queue_select}=
.
+\item Write the virtqueue number (first queue is 0) to \field{queue_select=
}.
=20
 \item Read the virtqueue size from \field{queue_size}. This controls how b=
ig the virtqueue is
   (see \ref{sec:Basic Facilities of a Virtio Device / Virtqueues}~\nameref=
{sec:Basic Facilities of a Virtio Device / Virtqueues}). If this field is 0=
, the virtqueue does not exist.
@@ -1035,7 +1035,7 @@ \subsubsection{Available Buffer Notifications}\label{=
sec:Virtio Transport Option
=20
 When VIRTIO_F_NOTIFICATION_DATA has not been negotiated,
 the driver sends an available buffer notification to the device by writing
-the 16-bit virtqueue index
+the 16-bit virtqueue number
 of this virtqueue to the Queue Notify address.
=20
 When VIRTIO_F_NOTIFICATION_DATA has been negotiated,
@@ -1053,7 +1053,7 @@ \subsubsection{Available Buffer Notifications}\label{=
sec:Virtio Transport Option
 If VIRTIO_F_NOTIF_CONFIG_DATA has been negotiated:
 \begin{itemize}
 \item If VIRTIO_F_NOTIFICATION_DATA has not been negotiated, the driver MU=
ST use the
-\field{queue_notify_data} value instead of the virtqueue index.
+\field{queue_notify_data} value instead of the virtqueue number.
 \item If VIRTIO_F_NOTIFICATION_DATA has been negotiated, the driver MUST s=
et the
 \field{vqn} field to the \field{queue_notify_data} value.
 \end{itemize}
--=20
2.26.2

