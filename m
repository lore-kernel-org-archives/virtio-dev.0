Return-Path: <xuanzhuo@linux.alibaba.com>
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH v7 3/3] virtio: mmio support virtqueue reset
Date: Mon,  8 Nov 2021 14:22:43 +0800
Message-Id: <20211108062243.102360-4-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20211108062243.102360-1-xuanzhuo@linux.alibaba.com>
References: <20211108062243.102360-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
To: cohuck@redhat.com, jasowang@redhat.com
Cc: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

mmio support virtqueue reset.

MMIO Device Register Layout "QueueReady" to support virtqueue reset.
The driver uses this to selectively reset the queue.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 content.tex | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/content.tex b/content.tex
index 219ad2f..c2ed496 100644
--- a/content.tex
+++ b/content.tex
@@ -1853,7 +1853,7 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio Transport Options / Vi
     Writing to this register selects the virtual queue that the
     following operations on \field{QueueNumMax}, \field{QueueNum}, \field{QueueReady},
     \field{QueueDescLow}, \field{QueueDescHigh}, \field{QueueDriverlLow}, \field{QueueDriverHigh},
-    \field{QueueDeviceLow} and \field{QueueDeviceHigh} apply to. The index
+    \field{QueueDeviceLow}, \field{QueueDeviceHigh} and \field{QueueReset} apply to. The index
     number of the first queue is zero (0x0). 
   }
   \hline 
@@ -1970,6 +1970,12 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio Transport Options / Vi
     0xffffffffffffffff.
   }
   \hline 
+  \mmioreg{QueueReset}{Virtual queue reset bit}{0x0c0}{RW}{%
+    If VIRTIO_F_RING_RESET has been negotiated, writing one (0x1) to this
+    register selectively resets the queue. Both read and write accesses
+    apply to the queue selected by writing to \field{QueueSel}.
+  }
+  \hline
   \mmioreg{ConfigGeneration}{Configuration atomicity value}{0x0fc}{R}{
     Reading from this register returns a value describing a version of the device-specific configuration space (see \field{Config}).
     The driver can then access the configuration space and, when finished, read \field{ConfigGeneration} again.
@@ -2005,6 +2011,22 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio Transport Options / Vi
 
 The device MUST NOT access virtual queue contents when \field{QueueReady} is zero (0x0).
 
+If VIRTIO_F_RING_RESET has been negotiated, the device MUST present a 0 in
+\field{QueueReady} after the driver has reset the virtqueue via
+\field{QueueReset}.
+
+If VIRTIO_F_RING_RESET has been negotiated, the device MUST present a 0 in
+\field{QueueReset} on reset.
+
+If VIRTIO_F_RING_RESET has been negotiated, The device MUST present a 0 in
+\field{QueueReset} after the virtqueue is enabled with \field{QueueReady}.
+
+The device MUST reset the queue when 1 is written to \field{QueueReset}, and
+present a 1 in \field{QueueReset} after the queue has been reset, until the
+driver re-enables the queue via \field{QueueReady} or until the device is reset.
+The device MUST present consistent default values after queue reset.
+(see \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}).
+
 \drivernormative{\subsubsection}{MMIO Device Register Layout}{Virtio Transport Options / Virtio Over MMIO / MMIO Device Register Layout}
 The driver MUST NOT access memory locations not described in the
 table \ref{tab:Virtio Trasport Options / Virtio Over MMIO / MMIO Device Register Layout}
@@ -2047,6 +2069,15 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio Transport Options / Vi
 The driver MUST write a value with a bit mask describing events it handled into \field{InterruptACK} when
 it finishes handling an interrupt and MUST NOT set any of the undefined bits in the value.
 
+If VIRTIO_F_RING_RESET has been negotiated, after the driver writes 1 to
+\field{QueueReset} to reset the queue, it MUST verify that the queue
+has been reset by reading back \field{QueueReset} and ensuring that it
+is 1. The driver MAY re-enable the queue by writing a 1 to
+\field{QueueReady} after ensuring that the other virtqueue fields have
+been set up correctly. The driver MAY set driver-writeable queue configuration
+values to different values than those that were used before the queue reset.
+(see \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}).
+
 \subsection{MMIO-specific Initialization And Device Operation}\label{sec:Virtio Transport Options / Virtio Over MMIO / MMIO-specific Initialization And Device Operation}
 
 \subsubsection{Device Initialization}\label{sec:Virtio Transport Options / Virtio Over MMIO / MMIO-specific Initialization And Device Operation / Device Initialization}
-- 
2.31.0

