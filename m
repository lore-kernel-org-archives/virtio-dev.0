Return-Path: virtio-return-3047-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Mon,  9 Apr 2018 20:58:38 +0200
In-Reply-To: <1523300322-21989-1-git-send-email-pasic@linux.vnet.ibm.com>
References: <1523300322-21989-1-git-send-email-pasic@linux.vnet.ibm.com>
Message-Id: <1523300322-21989-2-git-send-email-pasic@linux.vnet.ibm.com>
Subject: [virtio] [PATCH 1/5] packed-ring: fix used descriptors but meant buffers
To: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>
List-ID: <virtio-dev.lists.oasis-open.org>

The subsection is talking about virtio buffers, that is possibly as
scatter-gather list mapped by multiple descriptors. Mistakenly we
at places we say descriptors instead of buffers.

While at it fix the title case capitalization. We seem to use
title case capitalization for subsections in most cases.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
---
 packed-ring.tex |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/packed-ring.tex b/packed-ring.tex
index 2ef9559..eb006b0 100644
--- a/packed-ring.tex
+++ b/packed-ring.tex
@@ -272,10 +272,10 @@ Buffer ID is also reserved and is ignored by the device.
 In descriptors with VIRTQ_DESC_F_INDIRECT set VIRTQ_DESC_F_WRITE
 is reserved and is ignored by the device.
 
-\subsection{In-order use of descriptors}
-\label{sec:Packed Virtqueues / In-order use of descriptors}
+\subsection{In-Order Use of Buffers}
+\label{sec:Packed Virtqueues / In-Order Use of Buffers}
 
-Some devices always use descriptors in the same order in which
+Some devices always use buffers in the same order in which
 they have been made available. These devices can offer the
 VIRTIO_F_IN_ORDER feature. If negotiated, this knowledge allows
 devices to notify the use of a batch of buffers to the driver by
-- 
1.7.1


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

