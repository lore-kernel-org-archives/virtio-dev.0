Return-Path: virtio-return-2951-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Thu, 1 Mar 2018 01:31:33 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1519860484-7936-9-git-send-email-mst@redhat.com>
References: <1519860484-7936-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519860484-7936-1-git-send-email-mst@redhat.com>
Subject: [virtio] [PATCH v9 08/16] split-ring: generalize text
To: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Tiwei Bie <tiwei.bie@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dhanoa, Kully" <kully.dhanoa@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Update generic text to talk about available/used buffers, not rings.
Move some split-ring specific text to the correct section.

Update conformance section with link to the new conformance clause.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 conformance.tex |  1 +
 content.tex     | 10 ++++------
 split-ring.tex  |  4 ++++
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/conformance.tex b/conformance.tex
index 55d17b4..e4efe33 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -38,6 +38,7 @@ A driver MUST conform to the following normative statements:
 \item \ref{drivernormative:Basic Facilities of a Virtio Device / Virtqueues / The Virtqueue Descriptor Table}
 \item \ref{drivernormative:Basic Facilities of a Virtio Device / Virtqueues / The Virtqueue Descriptor Table / Indirect Descriptors}
 \item \ref{drivernormative:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Interrupt Suppression}
+\item \ref{drivernormative:Basic Facilities of a Virtio Device / Virtqueues / The Virtqueue Available Ring}
 \item \ref{drivernormative:Basic Facilities of a Virtio Device / Virtqueues / The Virtqueue Used Ring}
 \item \ref{drivernormative:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Notification Suppression}
 \item \ref{drivernormative:Basic Facilities of a Virtio Device / Virtqueues / Supplying Buffers to The Device / Updating idx}
diff --git a/content.tex b/content.tex
index 5634c7d..e1e30a0 100644
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
 
diff --git a/split-ring.tex b/split-ring.tex
index 9601a53..a594d41 100644
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

