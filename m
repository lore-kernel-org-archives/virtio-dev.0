Return-Path: SRS0=KMw5=FK=redhat.com=mst@kernel.org
Date: Fri, 16 Feb 2018 09:21:05 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v8 01/16] content: move 1.0 queue format out to a separate
 section
Message-ID: <20180216092105-mutt-send-email-mst@kernel.org>
References: <1518765602-8739-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518765602-8739-1-git-send-email-mst@redhat.com>
To: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Tiwei Bie <tiwei.bie@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dhanoa, Kully" <kully.dhanoa@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
---
 content.tex | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/content.tex b/content.tex
index c7ef7fd..4483a4b 100644
--- a/content.tex
+++ b/content.tex
@@ -230,7 +230,30 @@ result.
 The mechanism for bulk data transport on virtio devices is
 pretentiously called a virtqueue. Each device can have zero or more
 virtqueues\footnote{For example, the simplest network device has one virtqueue for
-transmit and one for receive.}.  Each queue has a 16-bit queue size
+transmit and one for receive.}.
+
+Driver makes requests available to device by adding
+an available buffer to the queue - i.e. adding a buffer
+describing the request to a virtqueue, and optionally triggering
+a driver event - i.e. sending a notification to the device.
+
+Device executes the requests and - when complete - adds
+a used buffer to the queue - i.e. lets the driver
+know by marking the buffer as used. Device can then trigger
+a device event - i.e. send an interrupt to the driver.
+
+For queue operation detail, see \ref{sec:Basic Facilities of a Virtio Device / Split Virtqueues}~\nameref{sec:Basic Facilities of a Virtio Device / Split Virtqueues}.
+
+\section{Split Virtqueues}\label{sec:Basic Facilities of a Virtio Device / Split Virtqueues}
+The split virtqueue format is the original format used by legacy
+virtio devices.  The split virtqueue format separates the
+virtqueue into several parts, where each part is write-able by
+either the driver or the device, but not both. Multiple
+locations need to be updated when making a buffer available
+and when marking it as used.
+
+
+Each queue has a 16-bit queue size
 parameter, which sets the number of entries and implies the total size
 of the queue.
 
-- 
MST

