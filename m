Return-Path: virtio-comment-return-794-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 10 Jul 2019 19:32:11 +0100
Message-Id: <20190710183212.29420-5-dgilbert@redhat.com>
In-Reply-To: <20190710183212.29420-1-dgilbert@redhat.com>
References: <20190710183212.29420-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [virtio-comment] [PATCH v6 4/5] shared memory: Define PCI capability
To: virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org, stefanha@redhat.com, cohuck@redhat.com
Cc: vgoyal@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Define the PCI capability used for enumerating shared memory regions.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 content.tex | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/content.tex b/content.tex
index d481359..1476b0e 100644
--- a/content.tex
+++ b/content.tex
@@ -689,6 +689,8 @@ \subsection{Virtio Structure PCI Capabilities}\label{sec:Virtio Transport Option
 #define VIRTIO_PCI_CAP_DEVICE_CFG        4
 /* PCI configuration access */
 #define VIRTIO_PCI_CAP_PCI_CFG           5
+/* Shared memory region */
+#define VIRTIO_PCI_CAP_SHARED_MEMORY_CFG 8
 \end{lstlisting}
 
         Any other value is reserved for future use.
@@ -1077,6 +1079,26 @@ \subsubsection{Device-specific configuration}\label{sec:Virtio Transport Options
 
 The \field{offset} for the device-specific configuration MUST be 4-byte aligned.
 
+\subsubsection{Shared memory capability}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Shared memory capability}
+
+Shared memory regions \ref{sec:Basic Facilities of a Virtio
+Device / Shared Memory Regions} are enumerated on the PCI transport
+as a sequence of VIRTIO_PCI_CAP_SHARED_MEMORY_CFG capabilities, one per region.
+
+The capability is defined by a struct virtio_pci_cap64 and
+utilises the \field{cap.id} to allow multiple shared memory
+regions per device.
+The identifier in \field{cap.id} does not denote a certain order of
+preference; it is only used to uniquely identify a region.
+
+\devicenormative{\paragraph}{Device-specific configuration}{Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Shared memory capability}
+
+The region defined by the combination of the \field {cap.offset},
+\field {cap.offset_hi}, and \field {cap.length}, \field
+{cap.length_hi} fields MUST be contained within the declared bar.
+
+The \field{cap.id} MUST be unique for any one device instance.
+
 \subsubsection{PCI configuration access capability}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / PCI configuration access capability}
 
 The VIRTIO_PCI_CAP_PCI_CFG capability
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

