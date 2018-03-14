Return-Path: virtio-return-3014-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed, 14 Mar 2018 15:46:13 +0000
Message-Id: <20180314154618.13069-3-stefanha@redhat.com>
In-Reply-To: <20180314154618.13069-1-stefanha@redhat.com>
References: <20180314154618.13069-1-stefanha@redhat.com>
Subject: [virtio] [PATCH 2/7] packed-ring: add missing comma
To: virtio@lists.oasis-open.org
Cc: virtio-dev@lists.oasis-open.org, Tiwei Bie <tiwei.bie@intel.com>, Cornelia Huck <cohuck@redhat.com>, "Dhanoa, Kully" <kully.dhanoa@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 packed-ring.tex | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/packed-ring.tex b/packed-ring.tex
index 211a989..bb29619 100644
--- a/packed-ring.tex
+++ b/packed-ring.tex
@@ -55,7 +55,7 @@ available.
 
 Similarly, the device reads descriptors from the ring in order and
 detects that a driver descriptor has been made available.  As
-processing of descriptors is completed used descriptors are
+processing of descriptors is completed, used descriptors are
 written by the device back into the ring.
 
 Note: after reading driver descriptors and starting their
-- 
2.14.3


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

