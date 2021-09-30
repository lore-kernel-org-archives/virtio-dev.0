Return-Path: <jean-philippe@linaro.org>
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH] content: Remove duplicate paragraph
Date: Thu, 30 Sep 2021 13:58:48 +0100
Message-Id: <20210930125847.28823-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
To: virtio-dev@lists.oasis-open.org
Cc: cohuck@redhat.com, mst@redhat.com, Jean-Philippe Brucker <jean-philippe@linaro.org>
List-ID: <virtio-dev.lists.oasis-open.org>

It looks like commit 356aeeb40d7a ("content: add vendor specific cfg
type") had a merge issue. It includes the device normative paragraph for
Shared memory capability, which was already added right above it by
commit 855ad7af2bd6 ("shared memory: Define PCI capability"). Remove the
duplicate paragraph.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
This applies onto "Fix copy/paste bug in PCI transport paragraph", that
fixes both paragraph titles.
https://lists.oasis-open.org/archives/virtio-comment/202108/msg00097.html
---
 content.tex | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/content.tex b/content.tex
index 4418ac8..54f7441 100644
--- a/content.tex
+++ b/content.tex
@@ -1149,14 +1149,6 @@ \subsubsection{Shared memory capability}\label{sec:Virtio Transport Options / Vi
 
 The \field{cap.id} MUST be unique for any one device instance.
 
-\devicenormative{\paragraph}{Shared memory capability}{Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Shared memory capability}
-
-The region defined by the combination of the \field {cap.offset},
-\field {cap.offset_hi}, and \field {cap.length}, \field
-{cap.length_hi} fields MUST be contained within the declared bar.
-
-The \field{cap.id} MUST be unique for any one device instance.
-
 \subsubsection{Vendor data capability}\label{sec:Virtio
 Transport Options / Virtio Over PCI Bus / PCI Device Layout /
 Vendor data capability}
-- 
2.33.0

