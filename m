Return-Path: virtio-dev-return-5354-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A35D4985F77
	for <virtio-dev@lists.oasis-open.org>; Thu, 31 Jan 2019 02:36:22 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Thu, 31 Jan 2019 10:36:13 +0800
Message-Id: <20190131023617.23007-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] [PATCH v2 0/4] virtio-blk: discard and write zeroes clarifications
To: virtio-dev@lists.oasis-open.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Several clarifications have been requested for the VIRTIO 1.1 virtio-blk
discard and write zeroes commands.  This series takes care of them.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/32

Stefan Hajnoczi (4):
  virtio-blk: document data[] size constraints
  virtio-blk: move virtio_blk_discard_write_zeroes definition
  virtio-blk: describe write zeroes unmap semantics
  virtio-blk: avoid inconsistent "DISCARD" term

 content.tex | 47 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 32 insertions(+), 15 deletions(-)

-- 
2.20.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

