Return-Path: <jean-philippe@linaro.org>
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v2] content: Remove duplicate paragraph
Date: Wed,  6 Oct 2021 12:28:19 +0100
Message-Id: <20211006112816.71892-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
To: virtio-dev@lists.oasis-open.org
Cc: cohuck@redhat.com, mst@redhat.com, stefanha@redhat.com, Jean-Philippe Brucker <jean-philippe@linaro.org>
List-ID: <virtio-dev.lists.oasis-open.org>

It looks like commit 356aeeb40d7a ("content: add vendor specific cfg
type") had a merge issue. It includes the device normative paragraph for
Shared memory capability, which was already added right above it by
commit 855ad7af2bd6 ("shared memory: Define PCI capability").

The two paragraphs differ, and the first paragraph is correct. It refers
to struct virtio_pci_cap64 which embeds struct virtio_pci_cap:

  struct virtio_pci_cap64 {
    struct virtio_pci_cap {
      ...
      le32 offset;
      le32 length;
    } cap;
    u32 offset_hi;
    u32 length_hi;
  }

Merge the two paragraph while keeping the best of both. Drop the spaces
after \field to stay consistent with the rest of the document.

Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
v1: https://www.mail-archive.com/virtio-dev@lists.oasis-open.org/msg07815.html
---
 content.tex | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/content.tex b/content.tex
index 288e62f..39fe12b 100644
--- a/content.tex
+++ b/content.tex
@@ -1143,17 +1143,10 @@ \subsubsection{Shared memory capability}\label{sec:Virtio Transport Options / Vi
 
 \devicenormative{\paragraph}{Shared memory capability}{Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Shared memory capability}
 
-The region defined by the combination of \field{cap.offset},
-\field{offset_hi}, and \field {cap.length}, \field{length_hi}
-MUST be contained within the BAR specified by \field{cap.bar}.
-
-The \field{cap.id} MUST be unique for any one device instance.
-
-\devicenormative{\paragraph}{Shared memory capability}{Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Shared memory capability}
-
-The region defined by the combination of the \field {cap.offset},
-\field {cap.offset_hi}, and \field {cap.length}, \field
-{cap.length_hi} fields MUST be contained within the declared bar.
+The region defined by the combination of the \field{cap.offset},
+\field{offset_hi}, and \field{cap.length}, \field{length_hi}
+fields MUST be contained within the BAR specified by
+\field{cap.bar}.
 
 The \field{cap.id} MUST be unique for any one device instance.
 
-- 
2.33.0

