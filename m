Return-Path: virtio-dev-return-5488-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 18E609860C7
	for <virtio-dev@lists.oasis-open.org>; Thu, 21 Feb 2019 16:22:54 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Thu, 21 Feb 2019 16:22:19 +0000
Message-Id: <20190221162219.9790-6-stefanha@redhat.com>
In-Reply-To: <20190221162219.9790-1-stefanha@redhat.com>
References: <20190221162219.9790-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] [PATCH v3 5/5] virtio-blk: clarify semantics of multi-segment discard/write zeroes commands
To: virtio-dev@lists.oasis-open.org
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Stefan Hajnoczi <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Describe the failure case and maximum number of segments in a
multi-segment discard/write zeroes command.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 content.tex | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/content.tex b/content.tex
index c5fdc34..7bfcc78 100644
--- a/content.tex
+++ b/content.tex
@@ -3967,8 +3967,10 @@ read from the block device (in multiples of 512 bytes).  VIRTIO_BLK_T_OUT
 requests write the contents of \field{data} to the block device (in multiples
 of 512 bytes).
 
-The \field{data} used for discard or write zeroes command is described
-by one or more virtio_blk_discard_write_zeroes structs:
+The \field{data} used for discard or write zeroes commands consists of one or
+more segments.  The maximum number of segments is \field{max_discard_seg} for
+discard commands and \field{max_write_zeroes_seg} for write zeroes commands.
+Each segment is of form:
 
 \begin{lstlisting}
 struct virtio_blk_discard_write_zeroes {
@@ -3997,6 +3999,10 @@ error or VIRTIO_BLK_S_UNSUPP for a request unsupported by device:
 #define VIRTIO_BLK_S_UNSUPP    2
 \end{lstlisting}
 
+The status of individual segments is indeterminate when a discard or write zero
+command produces VIRTIO_BLK_S_IOERR.  A segment may have completed
+successfully, failed, or not been processed by the device.
+
 \drivernormative{\subsubsection}{Device Operation}{Device Types / Block Device / Device Operation}
 
 A driver MUST NOT submit a request which would cause a read or write
@@ -4014,6 +4020,14 @@ The length of \field{data} MUST be a multiple of the size of struct
 virtio_blk_discard_write_zeroes for VIRTIO_BLK_T_DISCARD and
 VIRTIO_BLK_T_WRITE_ZEROES requests.
 
+VIRTIO_BLK_T_DISCARD requests MUST NOT contain more than
+\field{max_discard_seg} struct virtio_blk_discard_write_zeroes segments in
+\field{data}.
+
+VIRTIO_BLK_T_WRITE_ZEROES requests MUST NOT contain more than
+\field{max_write_zeroes_seg} struct virtio_blk_discard_write_zeroes segments in
+\field{data}.
+
 If the VIRTIO_BLK_F_CONFIG_WCE feature is negotiated, the driver MAY
 switch to writethrough or writeback mode by writing respectively 0 and
 1 to the \field{writeback} field.  After writing a 0 to \field{writeback},
@@ -4024,6 +4038,11 @@ The \field{unmap} bit MUST be zero for discard commands.  The driver
 MUST NOT assume anything about the data returned by read requests after
 a range of sectors has been discarded.
 
+A driver MUST NOT assume that individual segments in a multi-segment
+VIRTIO_BLK_T_DISCARD or VIRTIO_BLK_T_WRITE_ZEROES request completed
+successfully, failed, or were processed by the device at all if the request
+failed with VIRTIO_BLK_S_IOERR.
+
 \devicenormative{\subsubsection}{Device Operation}{Device Types / Block Device / Device Operation}
 
 A device MUST set the \field{status} byte to VIRTIO_BLK_S_IOERR
-- 
2.20.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

