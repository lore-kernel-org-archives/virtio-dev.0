Return-Path: <virtio-dev-return-9364-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 013429864C6
	for <virtio-dev@lists.oasis-open.org>; Thu, 24 Mar 2022 10:34:24 +0000 (UTC)
Date: Thu, 24 Mar 2022 06:34:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20220324103412.2740-1-mst@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH] packed-ring: fix some typos
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: virtio@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

flag is misnamed in a couple of places.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 packed-ring.tex | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/packed-ring.tex b/packed-ring.tex
index e41f8bf..2accc23 100644
--- a/packed-ring.tex
+++ b/packed-ring.tex
@@ -518,7 +518,7 @@ \subsection{Event Suppression Structure Format}\label{sec:Basic
 list.
 
 \drivernormative{\subsection}{Indirect Descriptors}{Basic Facilities of a Virtio Device / Packed Virtqueues / The Virtqueue Descriptor Table / Indirect Descriptors}
-The driver MUST NOT set the DESC_F_INDIRECT flag unless the
+The driver MUST NOT set the VIRTQ_DESC_F_INDIRECT flag unless the
 VIRTIO_F_INDIRECT_DESC feature was negotiated.   The driver MUST NOT
 set any flags except DESC_F_WRITE within an indirect descriptor.
 
@@ -526,7 +526,7 @@ \subsection{Event Suppression Structure Format}\label{sec:Basic
 by the device.
 
 A driver MUST NOT write direct descriptors with
-DESC_F_INDIRECT set in a scatter-gather list linked by
+VIRTQ_DESC_F_INDIRECT set in a scatter-gather list linked by
 VIRTQ_DESC_F_NEXT.
 \field{flags}.
 
-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

