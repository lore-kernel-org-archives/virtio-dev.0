Return-Path: virtio-dev-return-5470-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9F1EA985D6E
	for <virtio-dev@lists.oasis-open.org>; Wed, 20 Feb 2019 12:46:29 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed, 20 Feb 2019 12:46:13 +0000
Message-Id: <20190220124613.22661-3-stefanha@redhat.com>
In-Reply-To: <20190220124613.22661-1-stefanha@redhat.com>
References: <20190220124613.22661-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] [PATCH v3 2/2] virtio-fs: add DAX window
To: virtio-dev@lists.oasis-open.org
Cc: Miklos Szeredi <mszeredi@redhat.com>, Sage Weil <sweil@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Steven Whitehouse <swhiteho@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Describe how shared memory region ID 0 is the DAX window and how
FUSE_SETUPMAPPING maps file ranges into the window.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
Note that this depends on the shared memory resource specification
extension that David Gilbert is working on.
https://lists.oasis-open.org/archives/virtio-comment/201901/msg00000.html

The FUSE_SETUPMAPPING message is part of the virtio-fs Linux patches:
https://gitlab.com/virtio-fs/linux/blob/virtio-fs/include/uapi/linux/fuse.h
---
 virtio-fs.tex | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/virtio-fs.tex b/virtio-fs.tex
index 5df5b9c..abb1e48 100644
--- a/virtio-fs.tex
+++ b/virtio-fs.tex
@@ -157,6 +157,31 @@ The driver MUST submit FUSE_INTERRUPT, FUSE_FORGET, and FUSE_BATCH_FORGET reques
 
 The driver MUST anticipate that request queues are processed concurrently with the hiprio queue.
 
+\subsubsection{Device Operation: DAX Window}\label{sec:Device Types / File System Device / Device Operation / Device Operation: DAX Window}
+
+FUSE\_READ and FUSE\_WRITE requests transfer file contents between the
+driver-provided buffer and the device.  In cases where data transfer is
+undesirable, the device can map file contents into the DAX window shared memory
+region.  The driver then accesses file contents directly in device-owned memory
+without a data transfer.
+
+Shared memory region ID 0 is called the DAX window.  The driver maps a file
+range into the DAX window using the FUSE\_SETUPMAPPING request.  The mapping is
+removed using the FUSE\_REMOVEMAPPING request.
+
+After FUSE\_SETUPMAPPING has completed successfully the file range is accessible
+from the DAX window at the offset provided by the driver in the request.
+
+\devicenormative{\paragraph}{Device Operation: DAX Window}{Device Types / File System Device / Device Operation / Device Operation: DAX Window}
+
+The device MUST allow mappings that completely or partially overlap existing mappings within the DAX window.
+
+The device MUST reject mappings that would go beyond the end of the DAX window.
+
+\drivernormative{\paragraph}{Device Operation: DAX Window}{Device Types / File System Device / Device Operation / Device Operation: DAX Window}
+
+The driver SHOULD be prepared to find shared memory region ID 0 absent and fall back to FUSE\_READ and FUSE\_WRITE requests.
+
 \subsubsection{Security Considerations}\label{sec:Device Types / File System Device / Security Considerations}
 
 The device provides access to a file system that may contain files owned by
-- 
2.20.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

