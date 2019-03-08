Return-Path: virtio-return-3252-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Fri, 8 Mar 2019 00:41:26 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190308054122.8834-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio] [PATCH] format: replace "- i.e." with ", i.e.,"
To: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

This seems to be preferred by native speakers, and
seems just as effective as a sentence device.

Fixes: https://issues.oasis-open.org/browse/VIRTIO-171
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 content.tex     | 12 ++++++------
 packed-ring.tex |  4 ++--
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/content.tex b/content.tex
index ede0ef6..4180296 100644
--- a/content.tex
+++ b/content.tex
@@ -277,15 +277,15 @@ virtqueues\footnote{For example, the simplest network device has one virtqueue f
 transmit and one for receive.}.
 
 Driver makes requests available to device by adding
-an available buffer to the queue - i.e. adding a buffer
+an available buffer to the queue, i.e., adding a buffer
 describing the request to a virtqueue, and optionally triggering
-a driver event - i.e. sending an available buffer notification
+a driver event, i.e., sending an available buffer notification
 to the device.
 
 Device executes the requests and - when complete - adds
-a used buffer to the queue - i.e. lets the driver
+a used buffer to the queue, i.e., lets the driver
 know by marking the buffer as used. Device can then trigger
-a device event - i.e. send a used buffer notification to the driver.
+a device event, i.e., send a used buffer notification to the driver.
 
 Device reports the number of bytes it has written to memory for
 each buffer it uses. This is referred to as ``used length''.
@@ -489,8 +489,8 @@ of a device are live once the device has been reset.
 
 \drivernormative{\subsection}{Device Cleanup}{General Initialization And Device Operation / Device Cleanup}
 
-A driver MUST NOT alter virtqueue entries for exposed buffers -
-i.e. buffers which have been
+A driver MUST NOT alter virtqueue entries for exposed buffers,
+i.e., buffers which have been
 made available to the device (and not been used by the device)
 of a live virtqueue.
 
diff --git a/packed-ring.tex b/packed-ring.tex
index e10d87f..caf47a5 100644
--- a/packed-ring.tex
+++ b/packed-ring.tex
@@ -65,12 +65,12 @@ in which their processing is complete.
 
 The Device Event Suppression data structure is write-only by the
 device. It includes information for reducing the number of
-device events - i.e. sending fewer available buffer notifications
+device events, i.e., sending fewer available buffer notifications
 to the device.
 
 The Driver Event Suppression data structure is read-only by the
 device. It includes information for reducing the number of
-driver events - i.e. sending fewer used buffer notifications 
+driver events, i.e., sending fewer used buffer notifications 
 to the driver.
 
 \subsection{Driver and Device Ring Wrap Counters}
-- 
MST

---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

