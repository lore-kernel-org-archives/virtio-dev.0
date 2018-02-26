Return-Path: virtio-dev-return-3279-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
From: Changpeng Liu <changpeng.liu@intel.com>
Date: Mon, 26 Feb 2018 16:16:54 +0800
Message-Id: <1519633014-8683-1-git-send-email-changpeng.liu@intel.com>
Subject: [virtio-dev] [RFC] virtio-blk: add discard and write zeroes features to specification
To: virtio-dev@lists.oasis-open.org, virtio@lists.oasis-open.org
Cc: changpeng.liu@intel.com, cavery@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, pawelx.wodkowski@intel.com, james.r.harris@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

Existing virtio-blk protocol doesn't have DISCARD/WRITE ZEROES support,
this will impact the performance when using SSD backend over file systems.

Here is the proposal to extend existing virtio-blk protocol to support
DISCARD/WRITE ZEROES commands.

Basic idea here is using 16 Bytes payload to support 1 descriptor, users
can put several segments together with 1 DISCARD command.

struct virtio_blk_discard_write_zeroes {
       le64 slba;
       le32 nlba;
       struct {
               le32 unmap:1;
               le32 reserved:31;
       } flags;
};

For the purpose to support such feature, we need to introduce 2 new feature
flags: VIRTIO_BLK_F_DISCARD/VIRTIO_BLK_F_WRITE_ZEROES, and 2 new command
types: VIRTIO_BLK_T_DISCARD/VIRTIO_BLK_T_WRITE_ZEROES. Also we introduce
3 new parameters in the configuration space of virtio-blk: max_discard_sectors/
max_discard_seg/max_write_zeroes_sectors. These parameters will tell the
OS what's the granularity when issuing such commands.

If both DISCARD and WRITE ZEROES are supported, unmap flag bit maybe used
for WRITE ZEROES command with DISCARD bit enabled.

Signed-off-by: Changpeng Liu <changpeng.liu@intel.com>
---
 content.tex | 41 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/content.tex b/content.tex
index c7ef7fd..5555b18 100644
--- a/content.tex
+++ b/content.tex
@@ -4127,6 +4127,13 @@ device except where noted.
 
 \item[VIRTIO_BLK_F_CONFIG_WCE (11)] Device can toggle its cache between writeback
     and writethrough modes.
+
+\item[VIRTIO_BLK_F_DISCARD (13)] Device can support discard command, maximum
+    discard sectors size in \field{max_discard_sectors} and maximum discard
+    segment number in field{max_discard_seg}.
+
+\item[VIRTIO_BLK_F_WRITE_ZEROES (14)] Device can support write zeroes command,
+	maximum write zeroes sectors size in \field{max_write_zeroes_sectors}.
 \end{description}
 
 \subsubsection{Legacy Interface: Feature bits}\label{sec:Device Types / Block Device / Feature bits / Legacy Interface: Feature bits}
@@ -4170,6 +4177,9 @@ struct virtio_blk_config {
                 le32 opt_io_size;
         } topology;
         u8 writeback;
+        le32 max_discard_sectors;
+        le32 max_discard_seg;
+        le32 max_write_zeroes_sectors;
 };
 \end{lstlisting}
 
@@ -4211,6 +4221,15 @@ according to the native endian of the guest rather than
   after reset can be either writeback or writethrough.  The actual
   mode can be determined by reading \field{writeback} after feature
   negotiation.
+
+\item If the VIRTIO_BLK_F_DISCARD feature is negotiated,
+    \field{max_discard_sectors} and \field{max_discard_seg} can be read
+    to determine the maximum discard sectors and maximum number of discard
+    segments for the block driver to use.
+
+\item if the VIRTIO_BLK_F_WRITE_ZEROES feature is negotiated,
+    \field{max_write_zeroes_sectors} can be read to determine the maximum
+    write zeroes sectors for the block driver to use.
 \end{enumerate}
 
 \drivernormative{\subsubsection}{Device Initialization}{Device Types / Block Device / Device Initialization}
@@ -4270,21 +4289,41 @@ struct virtio_blk_req {
         u8 data[][512];
         u8 status;
 };
+
+struct virtio_blk_discard_write_zeroes {
+       le64 slba;
+       le32 nlba;
+       struct {
+               le32 unmap:1;
+               le32 reserved:31;
+       } flags;
+};
 \end{lstlisting}
 
 The type of the request is either a read (VIRTIO_BLK_T_IN), a write
-(VIRTIO_BLK_T_OUT), or a flush (VIRTIO_BLK_T_FLUSH).
+(VIRTIO_BLK_T_OUT), a discard (VIRTIO_BLK_T_DISCARD), a write zeroes
+(VIRTIO_BLK_T_WRITE_ZEROES) or a flush (VIRTIO_BLK_T_FLUSH).
 
 \begin{lstlisting}
 #define VIRTIO_BLK_T_IN           0
 #define VIRTIO_BLK_T_OUT          1
 #define VIRTIO_BLK_T_FLUSH        4
+#define VIRTIO_BLK_T_DISCARD      16
+#define VIRTIO_BLK_T_WRITE_ZEROES 32
 \end{lstlisting}
 
 The \field{sector} number indicates the offset (multiplied by 512) where
 the read or write is to occur. This field is unused and set to 0
 for scsi packet commands and for flush commands.
 
+The \field{data} used for discard or write zeroes command can be
+described by structure virtio_blk_discard_write_zeroes, while here,
+\field{sector} is not used for the two commands. \field{slba} indicates
+the starting sector of the segment, \field{nlba} indicates the number
+of sectors for discard/write zeroes commands, \field{unmap} only used
+for write zeroes command, which means write zeroes to specified sectors
+while keep these sectors discarded.
+
 The final \field{status} byte is written by the device: either
 VIRTIO_BLK_S_OK for success, VIRTIO_BLK_S_IOERR for device or driver
 error or VIRTIO_BLK_S_UNSUPP for a request unsupported by device:
-- 
1.9.3


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

