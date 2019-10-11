Return-Path: virtio-dev-return-6226-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 870C0985DD5
	for <virtio-dev@lists.oasis-open.org>; Fri, 11 Oct 2019 11:43:44 +0000 (UTC)
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <1170e604-7d65-1c97-33f7-741054ecf5e0@siemens.com>
Date: Fri, 11 Oct 2019 13:43:41 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] [PATCH] Fix ^= in example code
To: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

Trying to escaping ^ here only leaves the backslash in the output.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 packed-ring.tex | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/packed-ring.tex b/packed-ring.tex
index caf47a5..ea92543 100644
--- a/packed-ring.tex
+++ b/packed-ring.tex
@@ -634,7 +634,7 @@ \subsubsection{Implementation Example}\label{sec:Basic Facilities of a Virtio De
 
         if (vq->next_avail >= vq->size) {
                 vq->next_avail = 0;
-                vq->avail_wrap_count \^= 1;
+                vq->avail_wrap_count ^= 1;
         }
 }
 vq->sgs[id] = sgs;
@@ -727,7 +727,7 @@ \subsection{Receiving Used Buffers From The Device}\label{sec:Basic Facilities o
         vq->next_used += sgs;
         if (vq->next_used >= vq->size) {
                 vq->next_used -= vq->size;
-                vq->used_wrap_count \^= 1;
+                vq->used_wrap_count ^= 1;
         }
 
         free_id(vq, id);
-- 
2.16.4

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

