Return-Path: virtio-dev-return-5486-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 730749860C4
	for <virtio-dev@lists.oasis-open.org>; Thu, 21 Feb 2019 16:22:47 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Thu, 21 Feb 2019 16:22:17 +0000
Message-Id: <20190221162219.9790-4-stefanha@redhat.com>
In-Reply-To: <20190221162219.9790-1-stefanha@redhat.com>
References: <20190221162219.9790-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] [PATCH v3 3/5] virtio-blk: describe write zeroes unmap semantics
To: virtio-dev@lists.oasis-open.org
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
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

