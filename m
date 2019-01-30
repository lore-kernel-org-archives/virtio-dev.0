Return-Path: virtio-dev-return-5352-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1FBF1985F22
	for <virtio-dev@lists.oasis-open.org>; Wed, 30 Jan 2019 08:57:38 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed, 30 Jan 2019 16:57:18 +0800
Message-Id: <20190130085718.15931-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] [PATCH] virtio-blk: document data[] size constraints
To: virtio-dev@lists.oasis-open.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Changpeng Liu <changpeng.liu@intel.com>, Stefano Garzarella <sgarzare@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

The struct virtio_blk_req->data[] field is a multiple of 512 bytes long
for read and write requests.  Flush requests don't use data[] at all.

The new discard and write zeroes requests being introduced in VIRTIO 1.1
put struct virtio_blk_discard_write_zeroes elements into data[], so it
must be a multiple of the struct size.

The uint8_t data[][512] pseudo-code makes it look like discard and write
zeroes requests must pad to 512 bytes.  This wastes memory since struct
virtio_blk_discard_write_data is only 16 bytes long.

Furthermore, all known implementations wishing to take advantage of this
upcoming VIRTIO 1.1 feature do not use 512-byte padding (Linux
virtio_blk.ko, QEMU virtio-blk device emulation, the SPDK virtio-blk
driver, and the SPDK vhost-user-blk device backend).

This patch documents the data[] size constraints clearly in the driver
normative section.  This is clearer than the current pseudo-code.

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Changpeng Liu <changpeng.liu@intel.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 content.tex | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/content.tex b/content.tex
index 836ee52..b185bb0 100644
--- a/content.tex
+++ b/content.tex
@@ -3941,7 +3941,7 @@ struct virtio_blk_req {
         le32 type;
         le32 reserved;
         le64 sector;
-        u8 data[][512];
+        u8 data[];
         u8 status;
 };
 
@@ -3971,6 +3971,11 @@ The \field{sector} number indicates the offset (multiplied by 512) where
 the read or write is to occur. This field is unused and set to 0 for
 commands other than read or write.
 
+VIRTIO_BLK_T_IN requests populate \field{data} with the contents of sectors
+read from the block device (in multiples of 512 bytes).  VIRTIO_BLK_T_OUT
+requests write the contents of \field{data} to the block device (in multiples
+of 512 bytes).
+
 The \field{data} used for discard or write zeroes command is described
 by one or more virtio_blk_discard_write_zeroes structs. \field{sector}
 indicates the starting offset (in 512-byte units) of the segment, while
@@ -3997,6 +4002,13 @@ A driver SHOULD accept the VIRTIO_BLK_F_RO feature if offered.
 A driver MUST set \field{sector} to 0 for a VIRTIO_BLK_T_FLUSH request.
 A driver SHOULD NOT include any data in a VIRTIO_BLK_T_FLUSH request.
 
+The length of \field{data} MUST be a multiple of 512 bytes for VIRTIO_BLK_T_IN
+and VIRTIO_BLK_T_OUT requests.
+
+The length of \field{data} MUST be a multiple of the size of struct
+virtio_blk_discard_write_zeroes for VIRTIO_BLK_T_DISCARD and
+VIRTIO_BLK_T_WRITE_ZEROES requests.
+
 If the VIRTIO_BLK_F_CONFIG_WCE feature is negotiated, the driver MAY
 switch to writethrough or writeback mode by writing respectively 0 and
 1 to the \field{writeback} field.  After writing a 0 to \field{writeback},
-- 
2.20.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

