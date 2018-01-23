Return-Path: virtio-return-2843-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Tue, 23 Jan 2018 02:01:06 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1516665617-30748-7-git-send-email-mst@redhat.com>
References: <1515577653-9336-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1515577653-9336-1-git-send-email-mst@redhat.com>
Subject: [virtio] [PATCH v7 07/11] split-ring: generalize text
To: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

Update generic text to talk about available/used buffers, not rings.
Move some split-ring specific text to the correct section.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 content.tex    | 12 +++++-------
 split-ring.tex |  4 ++++
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/content.tex b/content.tex
index 5634c7d..0f7c2b9 100644
--- a/content.tex
+++ b/content.tex
@@ -381,12 +381,10 @@ of a device are live once the device has been reset.
 
 \drivernormative{\subsection}{Device Cleanup}{General Initialization And Device Operation / Device Cleanup}
 
-A driver MUST NOT alter descriptor table entries which have been
-exposed in the available ring (and not marked consumed by the device
-in the used ring) of a live virtqueue.
-
-A driver MUST NOT decrement the available \field{idx} on a live virtqueue (ie.
-there is no way to ``unexpose'' buffers).
+A driver MUST NOT alter virtqueue entries for exposed buffers -
+i.e. buffers which have been
+made available to the device (and not been used by the device)
+of a live virtqueue.
 
 Thus a driver MUST ensure a virtqueue isn't live (by device reset) before removing exposed buffers.
 
@@ -4652,7 +4650,7 @@ Interface: Device Operation}
 When using the legacy interface, the driver SHOULD ignore the
 used length values.
 \begin{note}
-Historically, devices put the total descriptor length,
+Historically, devices put the total length,
 or the total length of device-writable buffers there,
 even when only part of the buffers were actually written.
 \end{note}
diff --git a/split-ring.tex b/split-ring.tex
index acdee7d..f976e45 100644
--- a/split-ring.tex
+++ b/split-ring.tex
@@ -296,6 +296,10 @@ referred to this structure as vring_avail, and the constant as
 VRING_AVAIL_F_NO_INTERRUPT, but the layout and value were identical.
 \end{note}
 
+\drivernormative{\subsubsection}{The Virtqueue Available Ring}{Basic Facilities of a Virtio Device / Virtqueues / The Virtqueue Available Ring}
+A driver MUST NOT decrement the available \field{idx} on a virtqueue (ie.
+there is no way to ``unexpose'' buffers).
+
 \subsection{Virtqueue Interrupt Suppression}\label{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Interrupt Suppression}
 
 If the VIRTIO_F_EVENT_IDX feature bit is not negotiated,
-- 
MST


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

