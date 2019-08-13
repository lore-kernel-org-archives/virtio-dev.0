Return-Path: virtio-dev-return-5967-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 25E13985E4D
	for <virtio-dev@lists.oasis-open.org>; Tue, 13 Aug 2019 13:13:23 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue, 13 Aug 2019 14:13:18 +0100
Message-Id: <20190813131320.30829-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] [PATCH v6 0/2] virtio-fs: add virtio file system device
To: virtio-dev@lists.oasis-open.org
Cc: Sage Weil <sweil@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Steven Whitehouse <swhiteho@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Miklos Szeredi <mszeredi@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

v6:
 * Clarify that num_queues only counts request queues [Cornelia]
 * State that only high priority requests go on the hiprio queue [Cornelia]
 * Expand on how endianness works [Cornelia]
 * Use "driver" and "device" instead of "guest" and "host" [Michael]
 * Explain how setuid files and device nodes can be a security issue [Michael]
 * Clarify that security issues with shared file systems involve multiple machines [Michael]
 * Document timing side-channel attacks [Michael]

v5:
 * Explain multiqueue semantics: no ordering, identical functionality on each queue, one FUSE session state shared between all queues
 * Explain how the FUSE session is started with a FUSE_INIT request
 * Consistently use "submit" vs "made available" and "complete" vs "used" terminology [Michael]
 * Explain endianness [Michael]
 * Clarify hiprio vs normal queue usage [Michael]
 * Move SHOULD, MUST, etc wording into normative sections [Michael]
 * Mention that FUSE_INIT negotiated state needs to be transferred during live migration [Michael]
 * State that the DAX window is mapped with writeback caching like RAM [Michael]
 * Mention DAX window mapping alignment constraints (they are communicated via the FUSE protocol) [Michael]
 * Explain that FUSE_SETUPMAPPING fails when device resources are exhausted and that splitting mappings consumes resources too [Michael]
 * Clarify access rules to DAX window - only touch memory that has a mapping establised
 * Document that DAX data persistence is achieved via FUSE_FSYNC

v4:
 * Clarify that there are no request ordering guarantees between requests in a
   single queue [vgoyal]
 * Add explanation of FUSE session endianness detection [dgilbert]

v3:
 * Remove notifications virtqueue, it's unimplemented and can be added when
   needed [Miklos]
 * Add Security Considerations and Live Migration Considerations sections
   [Michael]
v2:
 * Clean up core virtio file system device spec
 * Add DAX window

These patches add the virtio file system device, which is based on Linux FUSE
but includes the DAX window extension.  Similar to virtio-scsi, which
transports SCSI commands, virtio-fs transports FUSE requests and the protocol
documentation is not duplicated here.

The DAX window allows file contents to be accessed directly from shared memory.
This eliminates copying of data, reduces the number of vmexits, and reduces the
guest's memory footprint.  It also allows coherent mmap MAP_SHARED semantics
between guests on the same host.

Stefan Hajnoczi (2):
  content: add virtio file system device
  virtio-fs: add DAX window

 content.tex      |   1 +
 introduction.tex |   3 +
 virtio-fs.tex    | 279 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 283 insertions(+)
 create mode 100644 virtio-fs.tex

-- 
2.21.0


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

