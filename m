Return-Path: virtio-return-2769-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
From: Cornelia Huck <cohuck@redhat.com>
Date: Wed, 12 Jul 2017 11:50:16 +0200
Message-Id: <20170712095016.9926-1-cohuck@redhat.com>
Subject: [virtio] [PATCH v2] virtio-net: fix virtqueue numbering error
To: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

receiveq(n) is at position 2(n-1), not 2n. Same error for transmitq(n)
and controlq.

VIRTIO-161

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
v1->v2: fix description
        use 2N for controlq [Stefan]
---
 content.tex | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/content.tex b/content.tex
index d8bde3a..19f84c8 100644
--- a/content.tex
+++ b/content.tex
@@ -3064,9 +3064,9 @@ features.
 \item[0] receiveq1
 \item[1] transmitq1
 \item[\ldots]
-\item[2N] receiveqN
-\item[2N+1] transmitqN
-\item[2N+2] controlq
+\item[2(N-1)] receiveqN
+\item[2(N-1)+1] transmitqN
+\item[2N] controlq
 \end{description}
 
  N=1 if VIRTIO_NET_F_MQ is not negotiated, otherwise N is set by
-- 
2.13.0


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

