Return-Path: virtio-comment-return-803-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Fri, 12 Jul 2019 13:20:02 +0100
Message-Id: <20190712122002.10793-6-dgilbert@redhat.com>
In-Reply-To: <20190712122002.10793-1-dgilbert@redhat.com>
References: <20190712122002.10793-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [virtio-comment] [PATCH v7 5/5] shared memory: Define mmio registers
To: virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org, stefanha@redhat.com, cohuck@redhat.com
Cc: vgoyal@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Define an MMIO interface to discover and map shared
memory regions.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
---
 content.tex | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/content.tex b/content.tex
index 1476b0e..ee0d7c9 100644
--- a/content.tex
+++ b/content.tex
@@ -1736,6 +1736,33 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio Transport Options / Vi
     selected by writing to \field{QueueSel}.
   }
   \hline 
+  \mmioreg{SHMSel}{Shared memory id}{0x0ac}{W}{%
+    Writing to this register selects the shared memory region \ref{sec:Basic Facilities of a Virtio Device / Shared Memory Regions}
+    following operations on \field{SHMLenLow}, \field{SHMLenHigh},
+    \field{SHMBaseLow} and \field{SHMBaseHigh} apply to.
+  }
+  \hline 
+  \mmiodreg{SHMLenLow}{SHMLenHigh}{Shared memory region 64 bit long length}{0x0b0}{0x0xb4}{R}{%
+    These registers return the length of the shared memory
+    region in bytes, as defined by the device for the region selected by
+    the \field{SHMSel} register.  The lower 32 bits of the length
+    are read from \field{SHMLenLow} and the higher 32 bits from
+    \field{SHMLenHigh}.  Reading from a non-existent
+    region (i.e. where the ID written to \field{SHMSel} is unused)
+    results in a length of -1.
+  }
+  \hline 
+  \mmiodreg{SHMBaseLow}{SHMBaseHigh}{Shared memory region 64 bit long physical address}{0x0b8}{0x0xbc}{R}{%
+    The driver reads these registers to discover the base address
+    of the region in physical address space.  This address is
+    chosen by the device (or other part of the VMM).
+    The lower 32 bits of the address are read from \field{SHMBaseLow}
+    with the higher 32 bits from \field{SHMBaseHigh}.  Reading
+    from a non-existent region (i.e. where the ID written to
+    \field{SHMSel} is unused) results in a base address of
+    0xffffffffffffffff.
+  }
+  \hline 
   \mmioreg{ConfigGeneration}{Configuration atomicity value}{0x0fc}{R}{
     Reading from this register returns a value describing a version of the device-specific configuration space (see \field{Config}).
     The driver can then access the configuration space and, when finished, read \field{ConfigGeneration} again.
@@ -1825,6 +1852,9 @@ \subsubsection{Device Initialization}\label{sec:Virtio Transport Options / Virti
 and if its value is zero (0x0) MUST abort initialization and
 MUST NOT access any other register.
 
+Drivers not expecting shared memory MUST NOT use the shared
+memory registers.
+
 Further initialization MUST follow the procedure described in
 \ref{sec:General Initialization And Device Operation / Device Initialization}~\nameref{sec:General Initialization And Device Operation / Device Initialization}.
 
-- 
2.21.0


This publicly archived list offers a means to provide input to the
OASIS Virtual I/O Device (VIRTIO) TC.

In order to verify user consent to the Feedback License terms and
to minimize spam in the list archive, subscription is required
before posting.

Subscribe: virtio-comment-subscribe@lists.oasis-open.org
Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
List help: virtio-comment-help@lists.oasis-open.org
List archive: https://lists.oasis-open.org/archives/virtio-comment/
Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
Committee: https://www.oasis-open.org/committees/virtio/
Join OASIS: https://www.oasis-open.org/join/

