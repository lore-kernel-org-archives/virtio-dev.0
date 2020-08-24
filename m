Return-Path: virtio-dev-return-7715-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0444F985CB5
	for <virtio-dev@lists.oasis-open.org>; Mon, 24 Aug 2020 14:38:56 +0000 (UTC)
From: Nikos Dragazis <ndragazis@arrikto.com>
Date: Mon, 24 Aug 2020 17:37:07 +0300
Message-Id: <20200824143708.5664-11-ndragazis@arrikto.com>
In-Reply-To: <20200824143708.5664-1-ndragazis@arrikto.com>
References: <20200824143708.5664-1-ndragazis@arrikto.com>
Subject: [virtio-dev] [PATCH 10/11] content: Fix typo
Content-Type: text/plain; charset=US-ASCII
To: virtio-dev@lists.oasis-open.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
List-ID: <virtio-dev.lists.oasis-open.org>

Signed-off-by: Nikos Dragazis <ndragazis@arrikto.com>
---
 content.tex | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/content.tex b/content.tex
index 7541a91..d141e92 100644
--- a/content.tex
+++ b/content.tex
@@ -1550,7 +1550,7 @@ \subsubsection{Device Initialization}\label{sec:Virtio Transport Options / Virti
 Driver MAY fall back on using INT\#x interrupts for a device
 which only supports one MSI-X vector (MSI-X Table Size = 0).
 
-Driver MAY intepret the Table Size as a hint from the device
+Driver MAY interpret the Table Size as a hint from the device
 for the suggested number of MSI-X vectors to use.
 
 Driver MUST NOT attempt to map an event to a vector
-- 
2.17.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

