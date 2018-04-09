Return-Path: virtio-return-3050-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Mon,  9 Apr 2018 20:58:42 +0200
In-Reply-To: <1523300322-21989-1-git-send-email-pasic@linux.vnet.ibm.com>
References: <1523300322-21989-1-git-send-email-pasic@linux.vnet.ibm.com>
Message-Id: <1523300322-21989-6-git-send-email-pasic@linux.vnet.ibm.com>
Subject: [virtio] [PATCH 5/5] packed-ring: tweak driver code example
To: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>
List-ID: <virtio-dev.lists.oasis-open.org>

This patch does three things. Emphasises that the example is pseudo-code
as we tend to stick to C otherwise and tweaks the wording, fixes
a typo in the pseudo code, and removes a line of code that I neither can
see the necessity for nor the sense of.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
---
 packed-ring.tex |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/packed-ring.tex b/packed-ring.tex
index 388850b..f619069 100644
--- a/packed-ring.tex
+++ b/packed-ring.tex
@@ -604,9 +604,11 @@ value before checking if notifications are suppressed.
 The driver MUST perform a suitable memory barrier before reading
 the Driver Event Suppression structure, to avoid missing a notification.
 
-\subsubsection{Implementation Example}\label{sec:Basic Facilities of a Virtio Device / Packed Virtqueues / Supplying Buffers to The Device / Implementation Example}
+\subsubsection{Pseudo-Code Example}\label{sec:Basic Facilities of a
+Virtio Device / Packed Virtqueues / Supplying Buffers to The Device /
+Pseudo-Code Example}
 
-Below is a driver code example. It does not attempt to reduce
+Below is driver pseudo-code example supplying buffers to the device. It does not attempt to reduce
 the number of device interrupts, neither does it support
 the VIRTIO_F_RING_EVENT_IDX feature.
 
@@ -621,7 +623,6 @@ sgs = 0;
 for (each buffer element b) {
         sgs++;
 
-        vq->ids[vq->next_avail] = -1;
         vq->desc[vq->next_avail].address = get_addr(b);
         vq->desc[vq->next_avail].len = get_len(b);
 
@@ -645,7 +646,7 @@ for (each buffer element b) {
 
         if (vq->next_avail >= vq->size) {
                 vq->next_avail = 0;
-                vq->avail_wrap_count \^= 1;
+                vq->avail_wrap_count ^= 1;
         }
 }
 vq->sgs[id] = sgs;
-- 
1.7.1


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

