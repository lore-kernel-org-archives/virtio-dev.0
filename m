Return-Path: virtio-return-2836-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Tue, 23 Jan 2018 02:01:04 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1516665617-30748-5-git-send-email-mst@redhat.com>
References: <1515577653-9336-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1515577653-9336-1-git-send-email-mst@redhat.com>
Subject: [virtio] [PATCH v7 05/11] content: generalize transport ring part naming
To: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

Replace descriptor table/available ring/used ring
with descriptor area/driver area/device area
in all transports.

Document what's in which area.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 content.tex    | 61 ++++++++++++++++++++++++++++++++++++++--------------------
 split-ring.tex |  6 +++---
 2 files changed, 43 insertions(+), 24 deletions(-)

diff --git a/content.tex b/content.tex
index 4350ecf..9fc9673 100644
--- a/content.tex
+++ b/content.tex
@@ -245,6 +245,24 @@ a device event - i.e. send an interrupt to the driver.
 Device reports the number of bytes it has written to memory for
 each buffer it uses. This is referred to as ``used length''.
 
+Each virtqueue can consist of up to 3 parts:
+\begin{itemize}
+\item Descriptor Area - used for describing buffers
+\item Driver Area - extra data supplied by driver to the device
+\item Device Area - extra data supplied by device to driver
+\end{itemize}
+
+\begin{note}
+Note that previous versions of this spec used different names for
+these parts (following \ref{sec:Basic Facilities of a Virtio Device / Split Virtqueues}):
+\begin{itemize}
+\item Descriptor Table - for the Descriptor Area
+\item Available Ring - for the Driver Area
+\item Used Ring - for the Device Area
+\end{itemize}
+
+\end{note}
+
 \input{split-ring.tex}
 
 \chapter{General Initialization And Device Operation}\label{sec:General Initialization And Device Operation}
@@ -667,8 +685,8 @@ struct virtio_pci_common_cfg {
         le16 queue_enable;              /* read-write */
         le16 queue_notify_off;          /* read-only for driver */
         le64 queue_desc;                /* read-write */
-        le64 queue_avail;               /* read-write */
-        le64 queue_used;                /* read-write */
+        le64 queue_driver;              /* read-write */
+        le64 queue_device;              /* read-write */
 };
 \end{lstlisting}
 
@@ -728,13 +746,13 @@ struct virtio_pci_common_cfg {
         \end{note}
 
 \item[\field{queue_desc}]
-        The driver writes the physical address of Descriptor Table here.  See section \ref{sec:Basic Facilities of a Virtio Device / Virtqueues}.
+        The driver writes the physical address of Descriptor Area here.  See section \ref{sec:Basic Facilities of a Virtio Device / Virtqueues}.
 
-\item[\field{queue_avail}]
-        The driver writes the physical address of Available Ring here.  See section \ref{sec:Basic Facilities of a Virtio Device / Virtqueues}.
+\item[\field{queue_driver}]
+        The driver writes the physical address of Driver Area here.  See section \ref{sec:Basic Facilities of a Virtio Device / Virtqueues}.
 
-\item[\field{queue_used}]
-        The driver writes the physical address of Used Ring here.  See section \ref{sec:Basic Facilities of a Virtio Device / Virtqueues}.
+\item[\field{queue_device}]
+        The driver writes the physical address of Device Area here.  See section \ref{sec:Basic Facilities of a Virtio Device / Virtqueues}.
 \end{description}
 
 \devicenormative{\paragraph}{Common configuration structure layout}{Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Common configuration structure layout}
@@ -1496,24 +1514,24 @@ All register values are organized as Little Endian.
     See also p. \ref{sec:Virtio Transport Options / Virtio Over MMIO / MMIO-specific Initialization And Device Operation / Device Initialization}~\nameref{sec:Virtio Transport Options / Virtio Over MMIO / MMIO-specific Initialization And Device Operation / Device Initialization}.
   }
   \hline 
-  \mmiodreg{QueueDescLow}{QueueDescHigh}{Virtual queue's Descriptor Table 64 bit long physical address}{0x080}{0x084}{W}{%
+  \mmiodreg{QueueDescLow}{QueueDescHigh}{Virtual queue's Descriptor Area 64 bit long physical address}{0x080}{0x084}{W}{%
     Writing to these two registers (lower 32 bits of the address
     to \field{QueueDescLow}, higher 32 bits to \field{QueueDescHigh}) notifies
-    the device about location of the Descriptor Table of the queue
+    the device about location of the Descriptor Area of the queue
     selected by writing to \field{QueueSel} register.
   }
   \hline 
-  \mmiodreg{QueueAvailLow}{QueueAvailHigh}{Virtual queue's Available Ring 64 bit long physical address}{0x090}{0x094}{W}{%
+  \mmiodreg{QueueDriverLow}{QueueDriverHigh}{Virtual queue's Driver Area 64 bit long physical address}{0x090}{0x094}{W}{%
     Writing to these two registers (lower 32 bits of the address
     to \field{QueueAvailLow}, higher 32 bits to \field{QueueAvailHigh}) notifies
-    the device about location of the Available Ring of the queue
+    the device about location of the Driver Area of the queue
     selected by writing to \field{QueueSel}.
   }
   \hline 
-  \mmiodreg{QueueUsedLow}{QueueUsedHigh}{Virtual queue's Used Ring 64 bit long physical address}{0x0a0}{0x0a4}{W}{%
+  \mmiodreg{QueueDeviceLow}{QueueDeviceHigh}{Virtual queue's Device Area 64 bit long physical address}{0x0a0}{0x0a4}{W}{%
     Writing to these two registers (lower 32 bits of the address
     to \field{QueueUsedLow}, higher 32 bits to \field{QueueUsedHigh}) notifies
-    the device about location of the Used Ring of the queue
+    the device about location of the Device Area of the queue
     selected by writing to \field{QueueSel}.
   }
   \hline 
@@ -1631,11 +1649,11 @@ The driver will typically initialize the virtual queue in the following way:
 \item Notify the device about the queue size by writing the size to
    \field{QueueNum}.
 
-\item Write physical addresses of the queue's Descriptor Table,
-   Available Ring and Used Ring to (respectively) the
+\item Write physical addresses of the queue's Descriptor Area,
+   Driver Area and Device Area to (respectively) the
    \field{QueueDescLow}/\field{QueueDescHigh},
-   \field{QueueAvailLow}/\field{QueueAvailHigh} and
-   \field{QueueUsedLow}/\field{QueueUsedHigh} register pairs.
+   \field{QueueDriverLow}/\field{QueueDriverHigh} and
+   \field{QueueDeviceLow}/\field{QueueDeviceHigh} register pairs.
 
 \item Write 0x1 to \field{QueueReady}.
 \end{enumerate}
@@ -2025,13 +2043,14 @@ struct vq_info_block {
         be32 res0;
         be16 index;
         be16 num;
-        be64 avail;
-        be64 used;
+        be64 driver;
+        be64 device;
 };
 \end{lstlisting}
 
-\field{desc}, \field{avail} and \field{used} contain the guest addresses for the descriptor table,
-available ring and used ring for queue \field{index}, respectively. The actual
+\field{desc}, \field{driver} and \field{device} contain the guest
+addresses for the descriptor area,
+available area and used area for queue \field{index}, respectively. The actual
 virtqueue size (number of allocated buffers) is transmitted in \field{num}.
 
 \devicenormative{\paragraph}{Configuring a Virtqueue}{Virtio Transport Options / Virtio over channel I/O / Device Initialization / Configuring a Virtqueue}
diff --git a/split-ring.tex b/split-ring.tex
index 724bb82..acdee7d 100644
--- a/split-ring.tex
+++ b/split-ring.tex
@@ -15,9 +15,9 @@ of the queue.
 Each virtqueue consists of three parts:
 
 \begin{itemize}
-\item Descriptor Table
-\item Available Ring
-\item Used Ring
+\item Descriptor Table - occupies the Descriptor Area
+\item Available Ring - occupies the Driver Area
+\item Used Ring - occupies the Device Area
 \end{itemize}
 
 where each part is physically-contiguous in guest memory,
-- 
MST


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

