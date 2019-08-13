Return-Path: virtio-dev-return-5969-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 34C32985E5C
	for <virtio-dev@lists.oasis-open.org>; Tue, 13 Aug 2019 13:13:28 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue, 13 Aug 2019 14:13:20 +0100
Message-Id: <20190813131320.30829-3-stefanha@redhat.com>
In-Reply-To: <20190813131320.30829-1-stefanha@redhat.com>
References: <20190813131320.30829-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] [PATCH v6 2/2] virtio-fs: add DAX window
To: virtio-dev@lists.oasis-open.org
Cc: Sage Weil <sweil@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Steven Whitehouse <swhiteho@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Miklos Szeredi <mszeredi@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Describe how shared memory region ID 0 is the DAX window and how
FUSE_SETUPMAPPING maps file ranges into the window.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
The FUSE_SETUPMAPPING message is part of the virtio-fs Linux patches:
https://gitlab.com/virtio-fs/linux/blob/virtio-fs/include/uapi/linux/fuse.h

v6:
 * Document timing side-channel attacks [Michael]
---
 virtio-fs.tex | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/virtio-fs.tex b/virtio-fs.tex
index 81adf85..154b043 100644
--- a/virtio-fs.tex
+++ b/virtio-fs.tex
@@ -178,6 +178,51 @@ \subsubsection{Device Operation: High Priority Queue}\label{sec:Device Types / F
 
 The driver MUST anticipate that request queues are processed concurrently with the hiprio queue.
 
+\subsubsection{Device Operation: DAX Window}\label{sec:Device Types / File System Device / Device Operation / Device Operation: DAX Window}
+
+FUSE\_READ and FUSE\_WRITE requests transfer file contents between the
+driver-provided buffer and the device.  In cases where data transfer is
+undesirable, the device can map file contents into the DAX window shared memory
+region.  The driver then accesses file contents directly in device-owned memory
+without a data transfer.
+
+Shared memory region ID 0 is called the DAX window.  Drivers map this shared
+memory region with writeback caching as if it were regular RAM.  The contents
+of the DAX window are undefined unless a mapping exists for that range.
+
+The driver maps a file range into the DAX window using the FUSE\_SETUPMAPPING
+request.  Alignment constraints for FUSE\_SETUPMAPPING and FUSE\_REMOVEMAPPING
+requests are communicated during FUSE\_INIT negotiation.
+
+When a FUSE\_SETUPMAPPING request perfectly overlaps a previous mapping, the
+previous mapping is replaced.  When a mapping partially overlaps a previous
+mapping, the previous mapping is split into one or two smaller mappings.  When
+a mapping is partially unmapped it is also split into one or two smaller
+mappings.
+
+Establishing new mappings or splitting existing mappings consumes resources.
+If the device runs out of resources the FUSE\_SETUPMAPPING request fails until
+resources are available again following FUSE\_REMOVEMAPPING.
+
+After FUSE\_SETUPMAPPING has completed successfully the file range is
+accessible from the DAX window at the offset provided by the driver in the
+request.  A mapping is removed using the FUSE\_REMOVEMAPPING request.
+
+Data is only guaranteed to be persistent when a FUSE\_FSYNC request is used by
+the device after having been made available by the driver following the write.
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
+The driver MUST NOT access DAX window areas that have not been mapped.
+
 \subsubsection{Security Considerations}\label{sec:Device Types / File System Device / Security Considerations}
 
 The device provides access to a file system containing files owned by one or
@@ -206,6 +251,16 @@ \subsubsection{Security Considerations}\label{sec:Device Types / File System Dev
 virtio-fs.  They are typically managed at the file system administration level
 by providing shared access only to mutually trusted users.
 
+Multiple machines sharing access to a file system are susceptible to timing
+side-channel attacks.  By measuring the latency of accesses to file contents or
+file system metadata it is possible to infer whether other machines also
+accessed the same information.  Short latencies indicate that the information
+was cached due to a previous access.  This can reveal sensitive information,
+such as whether certain code paths were taken.  The DAX Window provides direct
+access to file contents and is therefore a likely target of such attacks.
+These attacks are also possible with traditional FUSE requests.  The safest
+approach is to avoid sharing file systems between untrusted machines.
+
 \subsubsection{Live migration considerations}\label{sec:Device Types / File System Device / Live Migration Considerations}
 
 When a driver is migrated to a new device it is necessary to consider the FUSE
-- 
2.21.0


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

