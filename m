Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: [PATCH v1 6/6] transport-channelio: Correct spelling errors
Date: Fri, 17 Feb 2023 03:30:08 +0200
Message-ID: <20230217013008.16062-7-parav@nvidia.com>
In-Reply-To: <20230217013008.16062-1-parav@nvidia.com>
References: <20230217013008.16062-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
To: mst@redhat.com, virtio-dev@lists.oasis-open.org, cohuck@redhat.com
Cc: virtio-comment@lists.oasis-open.org, shahafs@nvidia.com, Parav Pandit <parav@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Now that we have individual files, fix reported spelling errors.

Signed-off-by: Parav Pandit <parav@nvidia.com>
---
 transport-channelio.tex | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/transport-channelio.tex b/transport-channelio.tex
index 93401a4..e25a7c1 100644
--- a/transport-channelio.tex
+++ b/transport-channelio.tex
@@ -413,7 +413,7 @@ \subsubsection{Setting Up Indicators}\label{sec:Virtio =
Transport Options / Virti
 \begin{itemize}
 \item a summary indicator byte covering the virtqueues for one or more
   virtio-ccw proxy devices
-\item a set of contigous indicator bits for the virtqueues for a
+\item a set of contiguous indicator bits for the virtqueues for a
   virtio-ccw proxy device
 \end{itemize}
=20
@@ -563,7 +563,7 @@ \subsubsection{Guest->Host Notification}\label{sec:Virt=
io Transport Options / Vi
=20
 \drivernormative{\paragraph}{Guest->Host Notification}{Virtio Transport Op=
tions / Virtio over channel I/O / Device Operation / Guest->Host Notificati=
on}
=20
-For each notification, the driver SHOULD use GPR4 to pass the host cookie =
received in GPR2 from the previous notication.
+For each notification, the driver SHOULD use GPR4 to pass the host cookie =
received in GPR2 from the previous notification.
=20
 \begin{note}
 For example:
--=20
2.26.2

