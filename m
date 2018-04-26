Return-Path: virtio-return-3091-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
From: Halil Pasic <pasic@linux.ibm.com>
Date: Thu, 26 Apr 2018 13:00:01 +0200
In-Reply-To: <1524740402-18934-1-git-send-email-pasic@linux.ibm.com>
References: <1524740402-18934-1-git-send-email-pasic@linux.ibm.com>
Message-Id: <1524740402-18934-6-git-send-email-pasic@linux.ibm.com>
Subject: [virtio] [PATCH 5/6] mmio: map common notifications terminology to MMIO
To: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Pawel Moll <pawel.moll@arm.com>, Halil Pasic <pasic@linux.ibm.com>
List-ID: <virtio-dev.lists.oasis-open.org>

The various notifications are introduced and specified in the common
(i.e. transport agnostic) portion of this specification. How
notifications are realised for a given transport is something each
transport has to specify.

Let's make the relationship between the virtio over MIIO terms and the
common terms more obvious.

Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
---
 content.tex |   26 ++++++++++++++------------
 1 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/content.tex b/content.tex
index ffd0c94..ed34495 100644
--- a/content.tex
+++ b/content.tex
@@ -1550,10 +1550,10 @@ All register values are organized as Little Endian.
     caused the device interrupt to be asserted.
     The following events are possible:
     \begin{description}
-      \item[Used Buffer Update] - bit 0 - the interrupt was asserted
+      \item[Used Buffer Notification] - bit 0 - the interrupt was asserted
         because the device has used a buffer
         in at least one of the active virtual queues.
-      \item [Configuration Change] - bit 1 - the interrupt was
+      \item [Configuration Change Notification] - bit 1 - the interrupt was
         asserted because the configuration of the device has changed.
     \end{description}
   }
@@ -1716,26 +1716,28 @@ The driver will typically initialize the virtual queue in the following way:
 \item Write 0x1 to \field{QueueReady}.
 \end{enumerate}
 
-\subsubsection{Notifying The Device}\label{sec:Virtio Transport Options / Virtio Over MMIO / MMIO-specific Initialization And Device Operation / Notifying The Device}
+\subsubsection{Available Buffer Notifications}\label{sec:Virtio Transport Options / Virtio Over MMIO / MMIO-specific Initialization And Device Operation / Available Buffer Notifications}
 
-The driver notifies the device about new buffers being available in
-a queue by writing the index of the updated queue to \field{QueueNotify}.
+The driver sends an available buffer notification to the device a by
+writing the index of the queue to \field{QueueNotify} to be notified.
 
 \subsubsection{Notifications From The Device}\label{sec:Virtio Transport Options / Virtio Over MMIO / MMIO-specific Initialization And Device Operation / Notifications From The Device}
 
 The memory mapped virtio device is using a single, dedicated
 interrupt signal, which is asserted when at least one of the
 bits described in the description of \field{InterruptStatus}
-is set. This is how the device notifies the
-driver about a new used buffer being available in the queue
-or about a change in the device configuration.
+is set. This is how the device sends an used buffer notification
+or a configuration change notifaciton to the device.
 
 \drivernormative{\paragraph}{Notifications From The Device}{Virtio Transport Options / Virtio Over MMIO / MMIO-specific Initialization And Device Operation / Notifications From The Device}
 After receiving an interrupt, the driver MUST read
-\field{InterruptStatus} to check what caused the interrupt
-(see the register description). After the interrupt is handled,
-the driver MUST acknowledge it by writing a bit mask
-corresponding to the handled events to the InterruptACK register.
+
+\field{InterruptStatus} to check what caused the interrupt (see the
+register description).  The used buffer notification bit being set,
+SHOULD be interpreted as a used buffer notification for each active
+virtqueue.  After the interrupt is handled, the driver MUST acknowledge
+it by writing a bit mask corresponding to the handled events to the
+InterruptACK register.
 
 \subsection{Legacy interface}\label{sec:Virtio Transport Options / Virtio Over MMIO / Legacy interface}
 
-- 
1.7.1


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

