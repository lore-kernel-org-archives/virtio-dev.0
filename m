Return-Path: virtio-return-3019-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed, 14 Mar 2018 15:46:15 +0000
Message-Id: <20180314154618.13069-5-stefanha@redhat.com>
In-Reply-To: <20180314154618.13069-1-stefanha@redhat.com>
References: <20180314154618.13069-1-stefanha@redhat.com>
Subject: [virtio] [PATCH 4/7] packed-ring: fix capitalization of names
To: virtio@lists.oasis-open.org
Cc: virtio-dev@lists.oasis-open.org, Tiwei Bie <tiwei.bie@intel.com>, Cornelia Huck <cohuck@redhat.com>, "Dhanoa, Kully" <kully.dhanoa@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Names are capitalized, like the Element Length field.  General terms
like descriptor are not capitalized.

This patch fixes two instances where this is inconsistent.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 packed-ring.tex | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/packed-ring.tex b/packed-ring.tex
index 8640192..4e5c9b2 100644
--- a/packed-ring.tex
+++ b/packed-ring.tex
@@ -167,7 +167,7 @@ In a used descriptor, Element Address is unused. Element Length
 specifies the length of the buffer that has been initialized
 (written to) by the device.
 
-Element length is reserved for used descriptors without the
+Element Length is reserved for used descriptors without the
 VIRTQ_DESC_F_WRITE flag, and is ignored by drivers.
 
 \subsection{Scatter-Gather Support}
@@ -269,7 +269,7 @@ only valid flag for descriptors in the indirect table. Others
 are reserved and are ignored by the device.
 Buffer ID is also reserved and is ignored by the device.
 
-In Descriptors with VIRTQ_DESC_F_INDIRECT set VIRTQ_DESC_F_WRITE
+In descriptors with VIRTQ_DESC_F_INDIRECT set VIRTQ_DESC_F_WRITE
 is reserved and is ignored by the device.
 
 \subsection{In-order use of descriptors}
-- 
2.14.3


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

