Return-Path: <mgurtovoy@nvidia.com>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 1/1] virtio-blk: fix virtqueues accounting
Date: Wed, 21 Jul 2021 15:45:30 +0300
Message-ID: <20210721124530.37225-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
To: mst@redhat.com, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: cohuck@redhat.com, oren@nvidia.com, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Virtqueue index is zero based, thus virtqueue (N-1) refers to requestqN.

Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 content.tex | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/content.tex b/content.tex
index 5c70a3c..c266fd5 100644
--- a/content.tex
+++ b/content.tex
@@ -4398,7 +4398,7 @@ \subsection{Virtqueues}\label{sec:Device Types / Block Device / Virtqueues}
 \begin{description}
 \item[0] requestq1
 \item[\ldots]
-\item[N] requestqN
+\item[N-1] requestqN
 \end{description}
 
  N=1 if VIRTIO_BLK_F_MQ is not negotiated, otherwise N is set by
-- 
2.21.0

