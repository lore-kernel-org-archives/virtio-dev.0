Return-Path: virtio-dev-return-3485-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 3F8F51CB8082
	for <virtio-dev@lists.oasis-open.org>; Thu,  8 Mar 2018 18:37:38 -0800 (PST)
From: Changpeng Liu <changpeng.liu@intel.com>
Date: Fri,  9 Mar 2018 10:44:23 +0800
Message-Id: <1520563463-27504-1-git-send-email-changpeng.liu@intel.com>
Subject: [virtio-dev] [PATCH v4] virtio-blk: add discard and write zeroes features to specification
To: virtio-dev@lists.oasis-open.org
Cc: changpeng.liu@intel.com, cavery@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, pawelx.wodkowski@intel.com, james.r.harris@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

Existing virtio-blk protocol doesn't have DISCARD/WRITE ZEROES support,
this will impact the performance when using SSD backend over file systems.

Here is the proposal to extend existing virtio-blk protocol to support
DISCARD/WRITE ZEROES commands.

Basic idea here is using 16 Bytes payload to support 1 descriptor, users
can put several segments together with 1 DISCARD/WRITE ZEROES command.

struct virtio_blk_discard_write_zeroes {
       le64 sector;
       le32 num_sectors;
       struct {
               le32 unmap:1;
               le32 reserved:31;
       } flags;
};

For the purpose to support such feature, we need to introduce 2 new feature
flags: VIRTIO_BLK_F_DISCARD/VIRTIO_BLK_F_WRITE_ZEROES, and 2 new command
types: VIRTIO_BLK_T_DISCARD/VIRTIO_BLK_T_WRITE_ZEROES. Also we introduce
several new parameters in the configuration space of virtio-blk:
max_discard_sectors/max_discard_seg/max_write_zeroes_sectors.
These parameters will tell the OS what's the granularity when
issuing such commands.

If both DISCARD and WRITE ZEROES are supported, unmap flag bit maybe used
for WRITE ZEROES command with DISCARD bit enabled.

Signed-off-by: Changpeng Liu <changpeng.liu@intel.com>
---
 content.tex | 84 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 81 insertions(+), 3 deletions(-)

diff --git a/content.tex b/content.tex
index c7ef7fd..def414c 100644
--- a/content.tex
+++ b/content.tex
@@ -4127,6 +4127,14 @@ device except where noted.
 
 \item[VIRTIO_BLK_F_CONFIG_WCE (11)] Device can toggle its cache between writeback
     and writethrough modes.
+
+\item[VIRTIO_BLK_F_DISCARD (13)] Device can support discard command, maximum
+    discard sectors size in \field{max_discard_sectors} and maximum discard
+    segment number in \field{max_discard_seg}.
+
+\item[VIRTIO_BLK_F_WRITE_ZEROES (14)] Device can support write zeroes command,
+     maximum write zeroes sectors size in \field{max_write_zeroes_sectors} and
+     maximum write zeroes segment number in \field{max_write_zeroes_seg}.
 \end{description}
 
 \subsubsection{Legacy Interface: Feature bits}\label{sec:Device Types / Block Device / Feature bits / Legacy Interface: Feature bits}
@@ -4148,6 +4156,12 @@ The \field{capacity} of the device (expressed in 512-byte sectors) is always
 present. The availability of the others all depend on various feature
 bits as indicated above.
 
+The parameters in the configuration space of the device \field{max_discard_sectors}
+\field{discard_sector_alignment} are expressed in 512-byte units if the
+VIRTIO_BLK_F_DISCARD feature bit is negotiated. The \field{max_write_zeroes_sectors}
+is expressed in 512-byte units if the VIRTIO_BLK_F_WRITE_ZEROES feature
+bit is negotiated.
+
 \begin{lstlisting}
 struct virtio_blk_config {
         le64 capacity;
@@ -4170,6 +4184,14 @@ struct virtio_blk_config {
                 le32 opt_io_size;
         } topology;
         u8 writeback;
+        u8 unused0[3];
+        le32 max_discard_sectors;
+        le32 max_discard_seg;
+        le32 discard_sector_alignment;
+        le32 max_write_zeroes_sectors;
+        le32 max_write_zeroes_seg;
+        u8 write_zeroes_may_unmap;
+        u8 unused1[3];
 };
 \end{lstlisting}
 
@@ -4211,6 +4233,17 @@ according to the native endian of the guest rather than
   after reset can be either writeback or writethrough.  The actual
   mode can be determined by reading \field{writeback} after feature
   negotiation.
+
+\item If the VIRTIO_BLK_F_DISCARD feature is negotiated,
+    \field{max_discard_sectors} and \field{max_discard_seg} can be read
+    to determine the maximum discard sectors and maximum number of discard
+    segments for the block driver to use. \field{discard_sector_alignment}
+    can be used by OS when splitting a request based on alignment.
+
+\item if the VIRTIO_BLK_F_WRITE_ZEROES feature is negotiated,
+    \field{max_write_zeroes_sectors} and \field{max_write_zeroes_seg} can
+    be read to determine the maximum write zeroes sectors and maximum
+    number of write zeroes segments for the block driver to use.
 \end{enumerate}
 
 \drivernormative{\subsubsection}{Device Initialization}{Device Types / Block Device / Device Initialization}
@@ -4234,6 +4267,9 @@ if they offer VIRTIO_BLK_F_CONFIG_WCE.
 If VIRTIO_BLK_F_CONFIG_WCE is negotiated but VIRTIO_BLK_F_FLUSH
 is not, the device MUST initialize \field{writeback} to 0.
 
+The device MUST initialize padding bytes \field{unused0} and
+\field{unused1} to 0.
+
 \subsubsection{Legacy Interface: Device Initialization}\label{sec:Device Types / Block Device / Device Initialization / Legacy Interface: Device Initialization}
 
 Because legacy devices do not have FEATURES_OK, transitional devices
@@ -4270,20 +4306,38 @@ struct virtio_blk_req {
         u8 data[][512];
         u8 status;
 };
+
+struct virtio_blk_discard_write_zeroes {
+       le64 sector;
+       le32 num_sectors;
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
+#define VIRTIO_BLK_T_DISCARD      11
+#define VIRTIO_BLK_T_WRITE_ZEROES 13
 \end{lstlisting}
 
 The \field{sector} number indicates the offset (multiplied by 512) where
-the read or write is to occur. This field is unused and set to 0
-for scsi packet commands and for flush commands.
+the read or write is to occur. This field is unused and set to 0 for
+commands other than read or write.
+
+The \field{data} used for discard or write zeroes command is described
+by one or more virtio_blk_discard_write_zeroes structs. \field{sector}
+indicates the starting offset (in 512-byte units) of the segment, while
+\field{num_sectors} indicates the number of sectors in each discarded
+range. \field{unmap} is only used for write zeroes command.
 
 The final \field{status} byte is written by the device: either
 VIRTIO_BLK_S_OK for success, VIRTIO_BLK_S_IOERR for device or driver
@@ -4311,12 +4365,36 @@ switch to writethrough or writeback mode by writing respectively 0 and
 the driver MUST NOT assume that any volatile writes have been committed
 to persistent device backend storage.
 
+The \field{unmap} bit MUST be zero for discard commands.  The driver
+MUST NOT assume anything about the data returned by read requests after
+a range of sectors has been discarded.
+
 \devicenormative{\subsubsection}{Device Operation}{Device Types / Block Device / Device Operation}
 
 A device MUST set the \field{status} byte to VIRTIO_BLK_S_IOERR
 for a write request if the VIRTIO_BLK_F_RO feature if offered, and MUST NOT
 write any data.
 
+The device MUST set the \field{status} byte to VIRTIO_BLK_S_UNSUPP for
+discard and write zeroes commands if any unknown flag is set.
+Furthermore, the device MUST set the \field{status} byte to
+VIRTIO_BLK_S_UNSUPP for discard commands if the \field{unmap} flag is set.
+
+For discard commands, the device MAY deallocate the specified range of
+sectors in the device backend storage.
+
+For write zeroes commands, if the \field{unmap} is set, the device MAY
+deallocate the specified range of sectors in the device backend storage,
+as if the DISCARD command had been sent.  After a write zeroes command
+is completed, reads of the specified ranges of sectors MUST return
+zeroes.  This is true independent of whether \field{unmap} was set or clear.
+
+The device SHOULD clear the \field{write_zeroes_may_unmap} field of the
+virtio configuration space if and only if a write zeroes request cannot
+result in deallocating one or more sectors.  The device MAY change the
+content of the field during operation of the device; when this happens,
+the device SHOULD trigger a configuration change interrupt.
+
 A write is considered volatile when it is submitted; the contents of
 sectors covered by a volatile write are undefined in persistent device
 backend storage until the write becomes stable.  A write becomes stable
-- 
1.9.3


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

