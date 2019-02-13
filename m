Return-Path: virtio-dev-return-5427-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D2795985E0D
	for <virtio-dev@lists.oasis-open.org>; Wed, 13 Feb 2019 06:33:30 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed, 13 Feb 2019 14:33:20 +0800
Message-Id: <20190213063322.25099-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] [PATCH v2 0/2] virtio-fs: add virtio file system device
To: virtio-dev@lists.oasis-open.org
Cc: Miklos Szeredi <mszeredi@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Sage Weil <sweil@redhat.com>, Steven Whitehouse <swhiteho@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

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

Michael Tsirkin has expressed an interest in security and live migration.  I
plan to add these sections in the next revision.

Please let me know which areas should be expanded or are missing.

Stefan Hajnoczi (2):
  content: add virtio file system device
  virtio-fs: add DAX window

 content.tex      |   3 +
 introduction.tex |   3 +
 virtio-fs.tex    | 223 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 229 insertions(+)
 create mode 100644 virtio-fs.tex

-- 
2.20.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

