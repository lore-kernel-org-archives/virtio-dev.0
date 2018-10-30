Return-Path: virtio-dev-return-4923-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 62BD8985B7B
	for <virtio-dev@lists.oasis-open.org>; Tue, 30 Oct 2018 09:29:13 +0000 (UTC)
From: Daniel Marcovitch <danielm@mellanox.com>
Date: Tue, 30 Oct 2018 11:28:31 +0200
Message-Id: <1540891712-10001-2-git-send-email-danielm@mellanox.com>
In-Reply-To: <1540891712-10001-1-git-send-email-danielm@mellanox.com>
References: <1540891712-10001-1-git-send-email-danielm@mellanox.com>
Subject: [virtio-dev] [PATCH 1/2] packed-ring/split-ring/content: fixed misc typos
To: mst@redhat.com, virtio-dev@lists.oasis-open.org
Cc: Daniel Marcovitch <danielm@mellanox.com>
List-ID: <virtio-dev.lists.oasis-open.org>

---
 content.tex     | 2 +-
 packed-ring.tex | 2 +-
 split-ring.tex  | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/content.tex b/content.tex
index c346183..fb168a0 100644
--- a/content.tex
+++ b/content.tex
@@ -346,7 +346,7 @@ The driver MUST follow this sequence to initialize a device:
 \begin{enumerate}
 \item Reset the device.
 
-\item Set the ACKNOWLEDGE status bit: the guest OS has notice the device.
+\item Set the ACKNOWLEDGE status bit: the guest OS has noticed the device.
 
 \item Set the DRIVER status bit: the guest OS knows how to drive the device.
 
diff --git a/packed-ring.tex b/packed-ring.tex
index ebbad95..f24f49b 100644
--- a/packed-ring.tex
+++ b/packed-ring.tex
@@ -186,7 +186,7 @@ described completely by a single descriptor.
 While unusual (most implementations either create all lists
 solely using non-indirect descriptors, or always use a single
 indirect element), if both features have been negotiated, mixing
-direct and direct descriptors in a ring is valid, as long as each
+indirect and non-indirect descriptors in a ring is valid, as long as each
 list only contains descriptors of a given type.
 
 Scatter/gather lists only apply to available descriptors. A
diff --git a/split-ring.tex b/split-ring.tex
index be0cd2f..7b75b1a 100644
--- a/split-ring.tex
+++ b/split-ring.tex
@@ -220,7 +220,7 @@ read a device-writable buffer (it MAY do so for debugging or diagnostic
 purposes).
 
 \drivernormative{\subsubsection}{The Virtqueue Descriptor Table}{Basic Facilities of a Virtio Device / Virtqueues / The Virtqueue Descriptor Table}
-Drivers MUST NOT add a descriptor chain over than $2^{32}$ bytes long in total;
+Drivers MUST NOT add a descriptor chain over $2^{32}$ bytes long in total;
 this implies that loops in the descriptor chain are forbidden!
 
 If VIRTIO_F_IN_ORDER has been negotiated, and when making a
@@ -560,7 +560,7 @@ The driver offers buffers to one of the device's virtqueues as follows:
 \item Steps \ref{itm:Basic Facilities of a Virtio Device / Virtqueues / Supplying Buffers to The Device / Place Buffers} and \ref{itm:Basic Facilities of a Virtio Device / Virtqueues / Supplying Buffers to The Device / Place Index} MAY be performed repeatedly if batching
   is possible.
 
-\item The driver performs suitable a memory barrier to ensure the device sees
+\item The driver performs a suitable memory barrier to ensure the device sees
   the updated descriptor table and available ring before the next
   step.
 
-- 
1.8.3.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

