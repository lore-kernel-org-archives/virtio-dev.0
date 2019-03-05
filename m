Return-Path: virtio-dev-return-5567-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0E733985E59
	for <virtio-dev@lists.oasis-open.org>; Tue,  5 Mar 2019 16:12:40 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue,  5 Mar 2019 16:12:34 +0000
Message-Id: <20190305161236.15402-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] [PATCH v4 0/2] virtio-fs: add virtio file system device
To: virtio-dev@lists.oasis-open.org
Cc: Vivek Goyal <vgoyal@redhat.com>, Miklos Szeredi <mszeredi@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Steven Whitehouse <swhiteho@redhat.com>, Sage Weil <sweil@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

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

 content.tex      |   3 +
 introduction.tex |   3 +
 virtio-fs.tex    | 226 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 232 insertions(+)
 create mode 100644 virtio-fs.tex

-- 
2.20.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

