Return-Path: virtio-return-3018-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed, 14 Mar 2018 15:46:18 +0000
Message-Id: <20180314154618.13069-8-stefanha@redhat.com>
In-Reply-To: <20180314154618.13069-1-stefanha@redhat.com>
References: <20180314154618.13069-1-stefanha@redhat.com>
Subject: [virtio] [PATCH 7/7] packed-ring: rephrase "an example driver code"
To: virtio@lists.oasis-open.org
Cc: virtio-dev@lists.oasis-open.org, Tiwei Bie <tiwei.bie@intel.com>, Cornelia Huck <cohuck@redhat.com>, "Dhanoa, Kully" <kully.dhanoa@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Either "an example of driver code" or "a driver code example" would
work.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 packed-ring.tex | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/packed-ring.tex b/packed-ring.tex
index 60b5559..2ef9559 100644
--- a/packed-ring.tex
+++ b/packed-ring.tex
@@ -594,7 +594,7 @@ value before checking if notifications are suppressed.
 
 \subsubsection{Implementation Example}\label{sec:Basic Facilities of a Virtio Device / Packed Virtqueues / Supplying Buffers to The Device / Implementation Example}
 
-Below is an example driver code. It does not attempt to reduce
+Below is a driver code example. It does not attempt to reduce
 the number of device interrupts, neither does it support
 the VIRTIO_F_RING_EVENT_IDX feature.
 
-- 
2.14.3


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

