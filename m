Return-Path: virtio-comment-return-768-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Thu, 27 Jun 2019 20:28:28 +0100
Message-Id: <20190627192830.5285-4-dgilbert@redhat.com>
In-Reply-To: <20190627192830.5285-1-dgilbert@redhat.com>
References: <20190627192830.5285-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [virtio-comment] [PATCH v5 3/5] pci: Define virtio_pci_cap64
To: virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org, stefanha@redhat.com, cohuck@redhat.com
Cc: vgoyal@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Define 'virtio_pci_cap64' to allow capabilities to describe
memory regions larger than, or with an offset larger than 4GiB.

This will be used by the shared memory region capability.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 content.tex | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/content.tex b/content.tex
index 41926c0..63e9179 100644
--- a/content.tex
+++ b/content.tex
@@ -744,6 +744,23 @@ \subsection{Virtio Structure PCI Capabilities}\label{sec:Virtio Transport Option
         \end{note}
 \end{description}
 
+A variant of this type, struct virtio_pci_cap64, is defined for
+those capaibilites that require offsets or lengths larger than
+4GiB:
+
+\begin{lstlisting}
+struct virtio_pci_cap64 {
+        struct virtio_pci_cap cap;
+        u32 offset_hi;
+        u32 length_hi;
+};
+\end{lstlisting}
+
+Given that the \field{cap.length} and \field{cap.offset} fields
+are only 32 bit, the additional \field{offset_hi} and \field {length_hi}
+fields provide the most significant 32 bits of a total 64 bit offset and
+length within the bar specified by \field{cap.bar}.
+
 \drivernormative{\subsubsection}{Virtio Structure PCI Capabilities}{Virtio Transport Options / Virtio Over PCI Bus / Virtio Structure PCI Capabilities}
 
 The driver MUST ignore any vendor-specific capability structure which has
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

