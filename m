Return-Path: virtio-return-3152-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
From: Halil Pasic <pasic@linux.ibm.com>
Date: Mon, 25 Jun 2018 14:21:32 +0200
In-Reply-To: <1529929292-11900-1-git-send-email-pasic@linux.ibm.com>
References: <1529929292-11900-1-git-send-email-pasic@linux.ibm.com>
Message-Id: <1529929292-11900-7-git-send-email-pasic@linux.ibm.com>
Subject: [virtio] [PATCH v3 6/6] notifications: update notifications terminology for devices
To: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Pawel Moll <pawel.moll@arm.com>, Stefan Hajnoczi <stefanha@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
List-ID: <virtio-dev.lists.oasis-open.org>

The specifications of some virtio device types are still using the old
terminology for used buffer notifications and configuration change
notifications calling these interrupts.

Let us fix that.

Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 content.tex |   22 +++++++++++-----------
 1 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/content.tex b/content.tex
index 5919cc1..097af44 100644
--- a/content.tex
+++ b/content.tex
@@ -3043,9 +3043,9 @@ if VIRTIO_NET_F_MRG_RXBUF is not negotiated.}
 \label{sec:Device Types / Network Device / Device Operation / Processing of Packets}%old label for latexdiff
 
 When a packet is copied into a buffer in the receiveq, the
-optimal path is to disable further interrupts for the receiveq
-and process
-packets until no more are found, then re-enable them.
+optimal path is to disable further used buffer notifications for the
+receiveq and process packets until no more are found, then re-enable
+them.
 
 Processing incoming packets involves:
 
@@ -3885,7 +3885,7 @@ The device SHOULD clear the \field{write_zeroes_may_unmap} field of the
 virtio configuration space if and only if a write zeroes request cannot
 result in deallocating one or more sectors.  The device MAY change the
 content of the field during operation of the device; when this happens,
-the device SHOULD trigger a configuration change interrupt.
+the device SHOULD trigger a configuration change notification.
 
 A write is considered volatile when it is submitted; the contents of
 sectors covered by a volatile write are undefined in persistent device
@@ -4177,20 +4177,20 @@ an appropriate log or output method.
 \begin{enumerate}
 \item For output, a buffer containing the characters is placed in
   the port's transmitq\footnote{Because this is high importance and low bandwidth, the current
-Linux implementation polls for the buffer to be used, rather than
-waiting for an interrupt, simplifying the implementation
+Linux implementation polls for the buffer to become used, rather than
+waiting for a used buffer notification, simplifying the implementation
 significantly. However, for generic serial ports with the
 O_NONBLOCK flag set, the polling limitation is relaxed and the
 consumed buffers are freed upon the next write or poll call or
 when a port is closed or hot-unplugged.
 }.
 
-\item When a buffer is used in the receiveq (signalled by an
-  interrupt), the contents is the input to the port associated
+\item When a buffer is used in the receiveq (signalled by a
+  used buffer notification), the contents is the input to the port associated
   with the virtqueue for which the notification was received.
 
 \item If the driver negotiated the VIRTIO_CONSOLE_F_SIZE feature, a
-  configuration change interrupt indicates that the updated size can
+  configuration change notification indicates that the updated size can
   be read from the configuration fields.  This size applies to port 0 only.
 
 \item If the driver negotiated the VIRTIO_CONSOLE_F_MULTIPORT
@@ -4433,7 +4433,7 @@ The device initialization process is outlined below:
 \subsection{Device Operation}\label{sec:Device Types / Memory Balloon Device / Device Operation}
 
 The device is driven either by the receipt of a configuration
-change interrupt, or by changing guest memory needs, such as
+change notification, or by changing guest memory needs, such as
 performing memory compaction or responding to out of memory
 conditions.
 
@@ -4570,7 +4570,7 @@ and notifies the device. A request for memory statistics proceeds
 as follows:
 
 \begin{enumerate}
-\item The device uses the buffer and sends an interrupt.
+\item The device uses the buffer and sends a used buffer notification.
 
 \item The driver pops the used buffer and discards it.
 
-- 
1.7.1


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

