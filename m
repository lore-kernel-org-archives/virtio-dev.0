Return-Path: virtio-return-3048-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Mon,  9 Apr 2018 20:58:39 +0200
In-Reply-To: <1523300322-21989-1-git-send-email-pasic@linux.vnet.ibm.com>
References: <1523300322-21989-1-git-send-email-pasic@linux.vnet.ibm.com>
Message-Id: <1523300322-21989-3-git-send-email-pasic@linux.vnet.ibm.com>
Subject: [virtio] [PATCH 2/5] consistency: clean up stale  wording for v1.1 terms
To: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Occasionally we still use used and available ring instead of Device and
Driver Area respectively. Same goes for descriptor table with the
difference that depending on the context we need either Descriptor Area
or descriptor ring.

Let's clean these up, at least where the cleanup is trivial.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
---
 content.tex     |   14 +++++++-------
 packed-ring.tex |   10 ++++++----
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/content.tex b/content.tex
index 7a92cb1..e3ac662 100644
--- a/content.tex
+++ b/content.tex
@@ -1247,7 +1247,7 @@ The driver typically does this as follows, for each virtqueue a device has:
 
 \item Optionally, select a smaller virtqueue size and write it to \field{queue_size}.
 
-\item Allocate and zero Descriptor Table, Available and Used rings for the
+\item Allocate and zero Descriptor Area, Device Area and Driver Area for the
    virtqueue in contiguous physical memory.
 
 \item Optionally, if MSI-X capability is present and enabled on the
@@ -1769,9 +1769,9 @@ nor behaviour:
     writing to \field{QueueSel}.
   }
   \hline
-  \mmioreg{QueueAlign}{Used Ring alignment in the virtual queue}{0x03c}{W}{%
+  \mmioreg{QueueAlign}{Device Area alignment in the virtual queue}{0x03c}{W}{%
     Writing to this register notifies the device about alignment
-    boundary of the Used Ring in bytes. This value should be a power
+    boundary of the Device Area in bytes. This value should be a power
     of 2 and applies to the queue selected by writing to \field{QueueSel}.
   }
   \hline
@@ -1779,7 +1779,7 @@ nor behaviour:
     Writing to this register notifies the device about location of the
     virtual queue in the Guest's physical address space. This value
     is the index number of a page starting with the queue
-    Descriptor Table. Value zero (0x0) means physical address zero
+    Descriptor Area. Value zero (0x0) means physical address zero
     (0x00000000) and is illegal. When the driver stops using the
     queue it writes zero (0x0) to this register.
     Reading from this register returns the currently used page
@@ -1830,7 +1830,7 @@ The virtual queue is configured as follows:
    queue is not available.
 
 \item Allocate and zero the queue pages in contiguous virtual
-   memory, aligning the Used Ring to an optimal boundary (usually
+   memory, aligning the Device Area to an optimal boundary (usually
    page size). The driver should choose a queue size smaller than or
    equal to \field{QueueNumMax}.
 
@@ -2066,8 +2066,8 @@ struct vq_info_block {
 \end{lstlisting}
 
 \field{desc}, \field{driver} and \field{device} contain the guest
-addresses for the descriptor area,
-available area and used area for queue \field{index}, respectively. The actual
+addresses for the Descriptor Area,
+Driver Area and Device Area for queue \field{index}, respectively. The actual
 virtqueue size (number of allocated buffers) is transmitted in \field{num}.
 
 \devicenormative{\paragraph}{Configuring a Virtqueue}{Virtio Transport Options / Virtio over channel I/O / Device Initialization / Configuring a Virtqueue}
diff --git a/packed-ring.tex b/packed-ring.tex
index eb006b0..e656fed 100644
--- a/packed-ring.tex
+++ b/packed-ring.tex
@@ -445,7 +445,9 @@ struct pvirtq_event_suppress {
 };
 \end{lstlisting}
 
-\devicenormative{\subsection}{The Virtqueue Descriptor Table}{Basic Facilities of a Virtio Device / Packed Virtqueues / The Virtqueue Descriptor Table}
+\devicenormative{\subsection}{The Virtqueue Descriptor Ring}{Basic
+Facilities of a Virtio Device / Packed Virtqueues / The Virtqueue
+Descriptor Ring}
 A device MUST NOT write to a device-readable buffer, and a device SHOULD NOT
 read a device-writable buffer.
 A device MUST NOT use a descriptor unless it observes
@@ -454,7 +456,7 @@ the VIRTQ_DESC_F_AVAIL bit in its \field{flags} being changed
 A device MUST NOT change a descriptor after changing it's
 the VIRTQ_DESC_F_USED bit in its \field{flags}.
 
-\drivernormative{\subsection}{The Virtqueue Descriptor Table}{Basic Facilities of a Virtio Device / PAcked Virtqueues / The Virtqueue Descriptor Table}
+\drivernormative{\subsection}{The Virtqueue Descriptor Ring}{Basic Facilities of a Virtio Device / PAcked Virtqueues / The Virtqueue Descriptor Ring}
 A driver MUST NOT change a descriptor unless it observes
 the VIRTQ_DESC_F_USED bit in its \field{flags} being changed.
 A driver MUST NOT change a descriptor after changing
@@ -498,7 +500,7 @@ were made available by the driver.
 The device MAY limit the number of buffers it will allow in a
 list.
 
-\drivernormative{\subsection}{Indirect Descriptors}{Basic Facilities of a Virtio Device / Packed Virtqueues / The Virtqueue Descriptor Table / Indirect Descriptors}
+\drivernormative{\subsection}{Indirect Descriptors}{Basic Facilities of a Virtio Device / Packed Virtqueues / The Virtqueue Descriptor Ring / Indirect Descriptors}
 The driver MUST NOT set the DESC_F_INDIRECT flag unless the
 VIRTIO_F_INDIRECT_DESC feature was negotiated.   The driver MUST NOT
 set any flags except DESC_F_WRITE within an indirect descriptor.
@@ -541,7 +543,7 @@ What follows are the requirements of each stage in more detail.
 For each buffer element, b:
 
 \begin{enumerate}
-\item Get the next descriptor table entry, d
+\item Get the next descriptor ring entry, d
 \item Get the next free buffer id value
 \item Set \field{d.addr} to the physical address of the start of b
 \item Set \field{d.len} to the length of b.
-- 
1.7.1


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

