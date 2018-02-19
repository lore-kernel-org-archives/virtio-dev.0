Return-Path: virtio-dev-return-3235-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 7887858191F8
	for <virtio-dev@lists.oasis-open.org>; Mon, 19 Feb 2018 05:10:42 -0800 (PST)
From: =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>
Date: Mon, 19 Feb 2018 14:10:29 +0100
Message-Id: <61ea318df06f6e50c5f9cfffaaae85aa51ae5b58.1519045824.git.tgolembi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] [PATCH] content: document balloon memory statistics
To: virtio-dev@lists.oasis-open.org
Cc: Jonathan Helman <jonathan.helman@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Linux kernel provides some balloon memory statistics that were not
included in the specs. Include them to avoid any ID clashes in the
future.

Signed-off-by: Tomáš Golembiovský <tgolembi@redhat.com>
---
 content.tex | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/content.tex b/content.tex
index c7ef7fd..74d351c 100644
--- a/content.tex
+++ b/content.tex
@@ -5028,6 +5028,8 @@ struct virtio_balloon_stat {
 #define VIRTIO_BALLOON_S_MINFLT   3
 #define VIRTIO_BALLOON_S_MEMFREE  4
 #define VIRTIO_BALLOON_S_MEMTOT   5
+#define VIRTIO_BALLOON_S_AVAIL    6
+#define VIRTIO_BALLOON_S_CACHES   7
         le16 tag;
         le64 val;
 } __attribute__((packed));
@@ -5109,6 +5111,12 @@ first buffer.
 
 \item[VIRTIO_BALLOON_S_MEMTOT (5)] The total amount of memory available
   (in bytes).
+
+\item[VIRTIO_BALLOON_S_AVAIL (6)] An estimate of how much memory is available
+  (in bytes) for starting new applications, without pushing the system to swap.
+
+\item[VIRTIO_BALLOON_S_CACHES (7)] The amount of memory currently used for
+  caching files and other data from disk (in bytes).
 \end{description}
 
 \section{SCSI Host Device}\label{sec:Device Types / SCSI Host Device}
-- 
2.16.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

