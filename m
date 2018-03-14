Return-Path: virtio-return-3016-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed, 14 Mar 2018 15:46:14 +0000
Message-Id: <20180314154618.13069-4-stefanha@redhat.com>
In-Reply-To: <20180314154618.13069-1-stefanha@redhat.com>
References: <20180314154618.13069-1-stefanha@redhat.com>
Subject: [virtio] [PATCH 3/7] packed-ring: fix 'contigious' typo
To: virtio@lists.oasis-open.org
Cc: virtio-dev@lists.oasis-open.org, Tiwei Bie <tiwei.bie@intel.com>, Cornelia Huck <cohuck@redhat.com>, "Dhanoa, Kully" <kully.dhanoa@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 packed-ring.tex | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/packed-ring.tex b/packed-ring.tex
index bb29619..8640192 100644
--- a/packed-ring.tex
+++ b/packed-ring.tex
@@ -161,7 +161,7 @@ data has been written by the device into any parts of the buffer.
 
 In an available descriptor, Element Address corresponds to the
 physical address of the buffer element. The length of the element assumed
-to be physically contigious is stored in Element Length.
+to be physically contiguous is stored in Element Length.
 
 In a used descriptor, Element Address is unused. Element Length
 specifies the length of the buffer that has been initialized
@@ -178,7 +178,7 @@ elements (also known as a scatter/gather list) with a request.
 Two features support this: descriptor chaining and indirect descriptors.
 
 If neither feature is in use by the driver, each buffer is
-physically-contigious, either read-only or write-only and is
+physically-contiguous, either read-only or write-only and is
 described completely by a single descriptor.
 
 While unusual (most implementations either create all lists
-- 
2.14.3


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

