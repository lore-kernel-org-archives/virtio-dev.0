Return-Path: virtio-return-3438-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Tue, 1 Sep 2020 10:23:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20200901142315.39001-1-mst@redhat.com>
MIME-Version: 1.0
Subject: [virtio] [PATCH] virtio-net: fix speed, duplex
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: virtio@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

Speed values have an extra "f" - they are 32 bit, not 36 bit.  Duplex is
implemented in Linux and QEMU as 0x01 for full duplex and 0x00 for half
duplex.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/75
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 content.tex | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/content.tex b/content.tex
index bc26674..47a4c6a 100644
--- a/content.tex
+++ b/content.tex
@@ -2994,9 +2994,9 @@ \subsection{Device configuration layout}\label{sec:Device Types / Network Device
 exist if VIRTIO_NET_F_SPEED_DUPLEX is set.
 
 \field{speed} contains the device speed, in units of 1 MBit per
-second, 0 to 0x7ffffffff, or 0xfffffffff for unknown speed.
+second, 0 to 0x7fffffff, or 0xffffffff for unknown speed.
 
-\field{duplex} has the values of 0x00 for full duplex, 0x01 for
+\field{duplex} has the values of 0x01 for full duplex, 0x00 for
 half duplex and 0xff for unknown duplex state.
 
 Both \field{speed} and \field{duplex} can change, thus the driver
-- 
MST


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

