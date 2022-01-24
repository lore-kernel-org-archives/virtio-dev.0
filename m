Return-Path: <virtio-comment-return-2612-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
Date: Mon, 24 Jan 2022 11:39:16 +0200
Message-ID: <20220124093918.34371-3-mgurtovoy@nvidia.com>
In-Reply-To: <20220124093918.34371-1-mgurtovoy@nvidia.com>
References: <20220124093918.34371-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Subject: [virtio-comment] [PATCH v2 2/4] virtio-blk: add support for VIRTIO_F_ADMIN_VQ
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
index c524fab..f5f95fb 100644
--- a/content.tex
+++ b/content.tex
@@ -4517,10 +4517,19 @@ \subsection{Device ID}\label{sec:Device Types / Block Device / Device ID}
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
@@ -4589,7 +4598,7 @@ \subsection{Device configuration layout}\label{sec:Device Types / Block Device /
 bits as indicated above.
 
 The field \field{num_queues} only exists if VIRTIO_BLK_F_MQ is set. This field specifies
-the number of queues.
+the number of request queues. This field doesn't account admin virtqueue.
 
 The parameters in the configuration space of the device \field{max_discard_sectors}
 \field{discard_sector_alignment} are expressed in 512-byte units if the
-- 
2.21.0


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
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
Committee: https://www.oasis-open.org/committees/virtio/
Join OASIS: https://www.oasis-open.org/join/

