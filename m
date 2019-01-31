Return-Path: virtio-dev-return-5358-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F33F8985F77
	for <virtio-dev@lists.oasis-open.org>; Thu, 31 Jan 2019 02:36:57 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Thu, 31 Jan 2019 10:36:17 +0800
Message-Id: <20190131023617.23007-5-stefanha@redhat.com>
In-Reply-To: <20190131023617.23007-1-stefanha@redhat.com>
References: <20190131023617.23007-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] [PATCH v2 4/4] virtio-blk: avoid inconsistent "DISCARD" term
To: virtio-dev@lists.oasis-open.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

"discard" (lowercase) is used throughout the text.  Remove a lone
instance of "DISCARD" (uppercase).

Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 content.tex | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/content.tex b/content.tex
index 8ea8320..c5fdc34 100644
--- a/content.tex
+++ b/content.tex
@@ -4040,7 +4040,7 @@ sectors in the device backend storage.
 
 For write zeroes commands, if the \field{unmap} is set, the device MAY
 deallocate the specified range of sectors in the device backend storage,
-as if the DISCARD command had been sent.  After a write zeroes command
+as if the discard command had been sent.  After a write zeroes command
 is completed, reads of the specified ranges of sectors MUST return
 zeroes.  This is true independent of whether \field{unmap} was set or clear.
 
-- 
2.20.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

