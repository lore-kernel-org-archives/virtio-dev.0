Return-Path: virtio-dev-return-4015-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id EA5DE5818F45
	for <virtio-dev@lists.oasis-open.org>; Mon, 30 Apr 2018 08:58:35 -0700 (PDT)
From: Sameeh Jubran <sameeh@daynix.com>
Date: Mon, 30 Apr 2018 18:58:15 +0300
Message-Id: <20180430155816.4687-3-sameeh@daynix.com>
In-Reply-To: <20180430155816.4687-1-sameeh@daynix.com>
References: <20180430155816.4687-1-sameeh@daynix.com>
Subject: [virtio-dev] [PATCH v4 2/3] conformance: net: Add steering mode
To: virtio-dev@lists.oasis-open.org
Cc: Amnon Ilan <ailan@redhat.com>, Yan Vugenfirer <yan@daynix.com>
List-ID: <virtio-dev.lists.oasis-open.org>

From: Sameeh Jubran <sjubran@redhat.com>

Signed-off-by: Sameeh Jubran <sjubran@redhat.com>
---
 conformance.tex | 1 +
 1 file changed, 1 insertion(+)

diff --git a/conformance.tex b/conformance.tex
index f59e360..f68911d 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -97,6 +97,7 @@ A network driver MUST conform to the following normative statements:
 \item \ref{drivernormative:Device Types / Network Device / Device Operation / Control Virtqueue / Setting MAC Address Filtering}
 \item \ref{drivernormative:Device Types / Network Device / Device Operation / Control Virtqueue / Gratuitous Packet Sending}
 \item \ref{drivernormative:Device Types / Network Device / Device Operation / Control Virtqueue / Automatic receive steering in multiqueue mode}
+\item \ref{drivernormative:Device Types / Network Device / Device Operation / Control Virtqueue / Steering mode}
 \item \ref{drivernormative:Device Types / Network Device / Device Operation / Control Virtqueue / Offloads State Configuration / Setting Offloads State}
 \end{itemize}
 
-- 
2.13.6


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

