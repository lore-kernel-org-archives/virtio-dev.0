Return-Path: virtio-dev-return-6227-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BDDDC985DD5
	for <virtio-dev@lists.oasis-open.org>; Fri, 11 Oct 2019 11:50:55 +0000 (UTC)
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <977476fd-34f9-057a-f6f7-81cfdc2f9d94@siemens.com>
Date: Fri, 11 Oct 2019 13:50:53 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] [PATCH] Lift "Driver Notifications" to section level
To: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

Currently, it slips under the Packed Virtqueues section while it is not
specific to this format.

At this chance, capitalize "Notifications".

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 content.tex | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/content.tex b/content.tex
index 2325236..f55e23f 100644
--- a/content.tex
+++ b/content.tex
@@ -332,7 +332,7 @@ \section{Virtqueues}\label{sec:Basic Facilities of a Virtio Device / Virtqueues}
 
 \input{packed-ring.tex}
 
-\subsection{Driver notifications} \label{sec:Virtqueues / Driver notifications}
+\section{Driver Notifications} \label{sec:Virtqueues / Driver notifications}
 The driver is sometimes required to send an available buffer
 notification to the device.
 
-- 
2.16.4

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

