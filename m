Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: [PATCH] virtio-blk: Define dev cfg layout before its fields
Date: Thu, 23 Feb 2023 15:52:05 +0200
Message-ID: <20230223135205.175949-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
To: mst@redhat.com, virtio-dev@lists.oasis-open.org, cohuck@redhat.com
Cc: virtio-comment@lists.oasis-open.org, shahafs@nvidia.com, Parav Pandit <parav@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Define device configuration layout structure before describing its
individual fields.

This is an editorial change.

Suggested-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
 device-types/blk/description.tex | 95 ++++++++++++++++----------------
 1 file changed, 48 insertions(+), 47 deletions(-)

diff --git a/device-types/blk/description.tex b/device-types/blk/descriptio=
n.tex
index 20007e3..517b012 100644
--- a/device-types/blk/description.tex
+++ b/device-types/blk/description.tex
@@ -83,6 +83,54 @@ \subsubsection{Legacy Interface: Feature bits}\label{sec=
:Device Types / Block De
=20
 \subsection{Device configuration layout}\label{sec:Device Types / Block De=
vice / Device configuration layout}
=20
+The block device has the following device configuration layout.
+
+\begin{lstlisting}
+struct virtio_blk_config {
+        le64 capacity;
+        le32 size_max;
+        le32 seg_max;
+        struct virtio_blk_geometry {
+                le16 cylinders;
+                u8 heads;
+                u8 sectors;
+        } geometry;
+        le32 blk_size;
+        struct virtio_blk_topology {
+                // # of logical blocks per physical block (log2)
+                u8 physical_block_exp;
+                // offset of first aligned logical block
+                u8 alignment_offset;
+                // suggested minimum I/O size in blocks
+                le16 min_io_size;
+                // optimal (suggested maximum) I/O size in blocks
+                le32 opt_io_size;
+        } topology;
+        u8 writeback;
+        u8 unused0;
+        u16 num_queues;
+        le32 max_discard_sectors;
+        le32 max_discard_seg;
+        le32 discard_sector_alignment;
+        le32 max_write_zeroes_sectors;
+        le32 max_write_zeroes_seg;
+        u8 write_zeroes_may_unmap;
+        u8 unused1[3];
+        le32 max_secure_erase_sectors;
+        le32 max_secure_erase_seg;
+        le32 secure_erase_sector_alignment;
+        struct virtio_blk_zoned_characteristics {
+                le32 zone_sectors;
+                le32 max_open_zones;
+                le32 max_active_zones;
+                le32 max_append_sectors;
+                le32 write_granularity;
+                u8 model;
+                u8 unused2[3];
+        } zoned;
+};
+\end{lstlisting}
+
 The \field{capacity} of the device (expressed in 512-byte sectors) is alwa=
ys
 present. The availability of the others all depend on various feature
 bits as indicated above.
@@ -167,53 +215,6 @@ \subsection{Device configuration layout}\label{sec:Dev=
ice Types / Block Device /
 terminated by the device with a "zone resources exceeded" error as defined=
 for
 specific commands later.
=20
-\begin{lstlisting}
-struct virtio_blk_config {
-        le64 capacity;
-        le32 size_max;
-        le32 seg_max;
-        struct virtio_blk_geometry {
-                le16 cylinders;
-                u8 heads;
-                u8 sectors;
-        } geometry;
-        le32 blk_size;
-        struct virtio_blk_topology {
-                // # of logical blocks per physical block (log2)
-                u8 physical_block_exp;
-                // offset of first aligned logical block
-                u8 alignment_offset;
-                // suggested minimum I/O size in blocks
-                le16 min_io_size;
-                // optimal (suggested maximum) I/O size in blocks
-                le32 opt_io_size;
-        } topology;
-        u8 writeback;
-        u8 unused0;
-        u16 num_queues;
-        le32 max_discard_sectors;
-        le32 max_discard_seg;
-        le32 discard_sector_alignment;
-        le32 max_write_zeroes_sectors;
-        le32 max_write_zeroes_seg;
-        u8 write_zeroes_may_unmap;
-        u8 unused1[3];
-        le32 max_secure_erase_sectors;
-        le32 max_secure_erase_seg;
-        le32 secure_erase_sector_alignment;
-        struct virtio_blk_zoned_characteristics {
-                le32 zone_sectors;
-                le32 max_open_zones;
-                le32 max_active_zones;
-                le32 max_append_sectors;
-                le32 write_granularity;
-                u8 model;
-                u8 unused2[3];
-        } zoned;
-};
-\end{lstlisting}
-
-
 \subsubsection{Legacy Interface: Device configuration layout}\label{sec:De=
vice Types / Block Device / Device configuration layout / Legacy Interface:=
 Device configuration layout}
 When using the legacy interface, transitional devices and drivers
 MUST format the fields in struct virtio_blk_config
--=20
2.26.2

