Return-Path: <mgurtovoy@nvidia.com>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 3/5] virtio-blk: add support for VIRTIO_F_ADMIN_VQ
Date: Thu, 13 Jan 2022 16:51:01 +0200
Message-ID: <20220113145103.26894-4-mgurtovoy@nvidia.com>
In-Reply-To: <20220113145103.26894-1-mgurtovoy@nvidia.com>
References: <20220113145103.26894-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
To: virtio-comment@lists.oasis-open.org, mst@redhat.com, cohuck@redhat.com, virtio-dev@lists.oasis-open.org, jasowang@redhat.com
Cc: parav@nvidia.com, shahafs@nvidia.com, oren@nvidia.com, stefanha@redhat.com, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Set the relevant index in case of VIRTIO_F_ADMIN_VQ negotiation.

Reviewed-by: Parav Pandit <parav@nvidia.com>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 content.tex | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/content.tex b/content.tex
index cc3e648..0ae4b68 100644
--- a/content.tex
+++ b/content.tex
@@ -4518,10 +4518,19 @@ \subsection{Device ID}\label{sec:Device Types / Block Device / Device ID}
   2
 
 \subsection{Virtqueues}\label{sec:Device Types / Block Device / Virtqueues}
+ if VIRTIO_F_ADMIN_VQ is not negotiated, the request queues layout is as follows:
 \begin{description}
 \item[0] requestq1
 \item[\ldots]
 \item[N-1] requestqN
+\end{description}
+
+ If VIRTIO_F_ADMIN_VQ is negotiated, the queues layout is as follows:
+\begin{description}
+\item[0] requestq1
+\item[\ldots]
+\item[N-1] requestqN
+\item[N] adminq
 \end{description}
 
  N=1 if VIRTIO_BLK_F_MQ is not negotiated, otherwise N is set by
@@ -4590,7 +4599,7 @@ \subsection{Device configuration layout}\label{sec:Device Types / Block Device /
 bits as indicated above.
 
 The field \field{num_queues} only exists if VIRTIO_BLK_F_MQ is set. This field specifies
-the number of queues.
+the number of request queues. This field doesn't account admin virtqueue.
 
 The parameters in the configuration space of the device \field{max_discard_sectors}
 \field{discard_sector_alignment} are expressed in 512-byte units if the
-- 
2.21.0

