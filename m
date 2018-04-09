Return-Path: virtio-return-3049-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Mon,  9 Apr 2018 20:58:41 +0200
In-Reply-To: <1523300322-21989-1-git-send-email-pasic@linux.vnet.ibm.com>
References: <1523300322-21989-1-git-send-email-pasic@linux.vnet.ibm.com>
Message-Id: <1523300322-21989-5-git-send-email-pasic@linux.vnet.ibm.com>
Subject: [virtio] [PATCH 4/5] packed-ring: reposition drivernormative on driver notifications
To: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>
List-ID: <virtio-dev.lists.oasis-open.org>

The drivernormative was simply in the wrong place. It does not belong
to the code example.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
---
 packed-ring.tex |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/packed-ring.tex b/packed-ring.tex
index d93df3b..388850b 100644
--- a/packed-ring.tex
+++ b/packed-ring.tex
@@ -600,6 +600,10 @@ Suppression Structure Format}.
 The driver has to be careful to expose the new \field{flags}
 value before checking if notifications are suppressed.
 
+\drivernormative{\paragraph}{Notifying The Device}{Basic Facilities of a Virtio Device / Packed Virtqueues / Supplying Buffers to The Device / Notifying The Device}
+The driver MUST perform a suitable memory barrier before reading
+the Driver Event Suppression structure, to avoid missing a notification.
+
 \subsubsection{Implementation Example}\label{sec:Basic Facilities of a Virtio Device / Packed Virtqueues / Supplying Buffers to The Device / Implementation Example}
 
 Below is a driver code example. It does not attempt to reduce
@@ -658,11 +662,6 @@ if (vq->device_event.flags != RING_EVENT_FLAGS_DISABLE) {
 
 \end{lstlisting}
 
-
-\drivernormative{\paragraph}{Notifying The Device}{Basic Facilities of a Virtio Device / Packed Virtqueues / Supplying Buffers to The Device / Notifying The Device}
-The driver MUST perform a suitable memory barrier before reading
-the Driver Event Suppression structure, to avoid missing a notification.
-
 \subsection{Receiving Used Buffers From The Device}\label{sec:Basic Facilities of a Virtio Device / Packed Virtqueues / Receiving Used Buffers From The Device}
 
 Once the device has used buffers referred to by a descriptor (read from or written to them, or
-- 
1.7.1


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

