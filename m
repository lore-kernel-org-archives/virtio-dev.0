Return-Path: virtio-comment-return-684-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Mon,  4 Mar 2019 13:25:30 +0000
Message-Id: <20190304132531.10507-3-dgilbert@redhat.com>
In-Reply-To: <20190304132531.10507-1-dgilbert@redhat.com>
References: <20190304132531.10507-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [virtio-comment] [PATCH v3 2/3] shared memory: Define PCI capability
To: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: stefanha@redhat.com, cohuck@redhat.com, sebastien.boeuf@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Define the PCI capability used for enumerating shared memory regions.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
---
 content.tex | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/content.tex b/content.tex
index 3dd504c..9838208 100644
--- a/content.tex
+++ b/content.tex
@@ -688,6 +688,8 @@ The fields are interpreted as follows:
 #define VIRTIO_PCI_CAP_DEVICE_CFG        4
 /* PCI configuration access */
 #define VIRTIO_PCI_CAP_PCI_CFG           5
+/* Shared memory region */
+#define VIRTIO_PCI_CAP_SHARED_MEMORY_CFG 8
 \end{lstlisting}
 
         Any other value is reserved for future use.
@@ -1052,6 +1054,41 @@ any device type which has a device-specific configuration.
 
 The \field{offset} for the device-specific configuration MUST be 4-byte aligned.
 
+\subsubsection{Shared memory capability}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Shared memory capability}
+
+Shared memory regions \ref{sec:Basic Facilities of a Virtio
+Device / Shared Memory Regions} are enumerated on the PCI transport
+as a sequence of VIRTIO_PCI_CAP_SHARED_MEMORY_CFG capabilities, one per region.
+
+The capability is immediately followed by an additional field like so:
+
+\begin{lstlisting}
+struct virtio_pci_shm_cap {
+        struct virtio_pci_cap cap;
+        u32 offset_hi;
+        u32 length_hi;
+        u8  id;
+};
+\end{lstlisting}
+
+Given that the \field{cap.length} and \field{cap.offset} fields
+are only 32 bit, the additional \field{offset_hi} and \field {length_hi}
+fields provide the most significant 32 bits of a total 64 bit offset and
+length within the bar specified by \field{cap.bar}.  \field{id}
+uniquely identifies the given shared memory region using a device
+specific identifier.
+
+While most capabilities can not be repeated, multiple
+VIRTIO_PCI_CAP_SHARED_MEMORY_CFG capabilities are allowed as long
+as the \field{id} is unique.
+
+\devicenormative{\paragraph}{Device-specific configuration}{Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Shared memory capability}
+
+The region defined by the combination of the offsets and length
+fields MUST be contained within the declared bar.
+
+The \field{id} MUST be unique for any one device instance.
+
 \subsubsection{PCI configuration access capability}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / PCI configuration access capability}
 
 The VIRTIO_PCI_CAP_PCI_CFG capability
-- 
2.20.1


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

