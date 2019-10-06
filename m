Return-Path: virtio-dev-return-6200-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AC54C983B7F
	for <virtio-dev@lists.oasis-open.org>; Sun,  6 Oct 2019 16:41:35 +0000 (UTC)
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <e0fb8838-c6c2-4c1e-4a14-d0b2671c524a@siemens.com>
Date: Sun, 6 Oct 2019 18:41:32 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] [PATCH] virtio-mmio: Rename remaining QueueAvail/Used references
To: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

These have been changed in ae98c6bc21bc. Convert the rest.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 content.tex | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/content.tex b/content.tex
index 679391e..2325236 100644
--- a/content.tex
+++ b/content.tex
@@ -1645,8 +1645,8 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio Transport Options / Vi
   \mmioreg{QueueSel}{Virtual queue index}{0x030}{W}{%
     Writing to this register selects the virtual queue that the
     following operations on \field{QueueNumMax}, \field{QueueNum}, \field{QueueReady},
-    \field{QueueDescLow}, \field{QueueDescHigh}, \field{QueueAvailLow}, \field{QueueAvailHigh},
-    \field{QueueUsedLow} and \field{QueueUsedHigh} apply to. The index
+    \field{QueueDescLow}, \field{QueueDescHigh}, \field{QueueDriverlLow}, \field{QueueDriverHigh},
+    \field{QueueDeviceLow} and \field{QueueDeviceHigh} apply to. The index
     number of the first queue is zero (0x0). 
   }
   \hline 
@@ -1724,14 +1724,14 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio Transport Options / Vi
   \hline 
   \mmiodreg{QueueDriverLow}{QueueDriverHigh}{Virtual queue's Driver Area 64 bit long physical address}{0x090}{0x094}{W}{%
     Writing to these two registers (lower 32 bits of the address
-    to \field{QueueAvailLow}, higher 32 bits to \field{QueueAvailHigh}) notifies
+    to \field{QueueDriverLow}, higher 32 bits to \field{QueueDriverHigh}) notifies
     the device about location of the Driver Area of the queue
     selected by writing to \field{QueueSel}.
   }
   \hline 
   \mmiodreg{QueueDeviceLow}{QueueDeviceHigh}{Virtual queue's Device Area 64 bit long physical address}{0x0a0}{0x0a4}{W}{%
     Writing to these two registers (lower 32 bits of the address
-    to \field{QueueUsedLow}, higher 32 bits to \field{QueueUsedHigh}) notifies
+    to \field{QueueDeviceLow}, higher 32 bits to \field{QueueDeviceHigh}) notifies
     the device about location of the Device Area of the queue
     selected by writing to \field{QueueSel}.
   }
@@ -1829,7 +1829,7 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio Transport Options / Vi
 
 When \field{QueueReady} is not zero, the driver MUST NOT access
 \field{QueueNum}, \field{QueueDescLow}, \field{QueueDescHigh},
-\field{QueueAvailLow}, \field{QueueAvailHigh}, \field{QueueUsedLow}, \field{QueueUsedHigh}.
+\field{QueueDriverLow}, \field{QueueDriverHigh}, \field{QueueDeviceLow}, \field{QueueDeviceHigh}.
 
 To stop using the queue the driver MUST write zero (0x0) to this
 \field{QueueReady} and MUST read the value back to ensure
-- 
2.16.4

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

