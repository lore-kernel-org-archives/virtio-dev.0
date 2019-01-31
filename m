Return-Path: virtio-dev-return-5357-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 12BD3985F2F
	for <virtio-dev@lists.oasis-open.org>; Thu, 31 Jan 2019 02:36:49 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Thu, 31 Jan 2019 10:36:16 +0800
Message-Id: <20190131023617.23007-4-stefanha@redhat.com>
In-Reply-To: <20190131023617.23007-1-stefanha@redhat.com>
References: <20190131023617.23007-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] [PATCH v2 3/4] virtio-blk: describe write zeroes unmap semantics
To: virtio-dev@lists.oasis-open.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Explain the meaning of the unmap flag.  The details are already covered
in the device normative section but mentioning it here makes the text
easier to understand.

Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 content.tex | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/content.tex b/content.tex
index 4201c7e..8ea8320 100644
--- a/content.tex
+++ b/content.tex
@@ -3983,7 +3983,9 @@ struct virtio_blk_discard_write_zeroes {
 
 \field{sector} indicates the starting offset (in 512-byte units) of the
 segment, while \field{num_sectors} indicates the number of sectors in each
-discarded range. \field{unmap} is only used for write zeroes command.
+discarded range. \field{unmap} is only used in write zeroes commands and allows
+the device to discard the specified range, provided that following reads return
+zeroes.
 
 The final \field{status} byte is written by the device: either
 VIRTIO_BLK_S_OK for success, VIRTIO_BLK_S_IOERR for device or driver
-- 
2.20.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

