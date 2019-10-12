Return-Path: virtio-dev-return-6229-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 35B5D985E3C
	for <virtio-dev@lists.oasis-open.org>; Sat, 12 Oct 2019 07:09:31 +0000 (UTC)
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <6c2e6e45-6b73-2fdd-c3d2-27fe8b6e640e@siemens.com>
Date: Sat, 12 Oct 2019 09:09:16 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] [PATCH] Console Device: Add a missing word
To: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 content.tex | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/content.tex b/content.tex
index f55e23f..a0435b9 100644
--- a/content.tex
+++ b/content.tex
@@ -4471,7 +4471,7 @@ \subsection{Device Operation}\label{sec:Device Types / Console Device / Device O
 
 \drivernormative{\subsubsection}{Device Operation}{Device Types / Console Device / Device Operation}
 
-The driver MUST NOT put a device-readable in a receiveq. The driver
+The driver MUST NOT put a device-readable buffer in a receiveq. The driver
 MUST NOT put a device-writable buffer in a transmitq.
 
 \subsubsection{Multiport Device Operation}\label{sec:Device Types / Console Device / Device Operation / Multiport Device Operation}
-- 
2.16.4


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

