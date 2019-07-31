Return-Path: virtio-dev-return-5903-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3BDD8985BC1
	for <virtio-dev@lists.oasis-open.org>; Wed, 31 Jul 2019 12:13:26 +0000 (UTC)
From: Nikos Dragazis <ndragazis@arrikto.com>
Date: Wed, 31 Jul 2019 15:12:14 +0300
Message-Id: <20190731121214.14099-1-ndragazis@arrikto.com>
In-Reply-To: <20190729154841.GH2756@work-vm>
References: <20190729154841.GH2756@work-vm>
Subject: [virtio-dev] [PATCH] content: fix typo
To: virtio-dev@lists.oasis-open.org
Cc: dgilbert@redhat.com, stefanha@redhat.com, cohuck@redhat.com, vgoyal@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

Signed-off-by: Nikos Dragazis <ndragazis@arrikto.com>
---
 content.tex | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/content.tex b/content.tex
index ee0d7c9..f8ebf14 100644
--- a/content.tex
+++ b/content.tex
@@ -749,7 +749,7 @@ \subsection{Virtio Structure PCI Capabilities}\label{sec:Virtio Transport Option
 \end{description}
 
 A variant of this type, struct virtio_pci_cap64, is defined for
-those capaibilites that require offsets or lengths larger than
+those capabilities that require offsets or lengths larger than
 4GiB:
 
 \begin{lstlisting}
-- 
2.17.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

