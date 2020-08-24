Return-Path: virtio-dev-return-7709-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 856C19843EA
	for <virtio-dev@lists.oasis-open.org>; Mon, 24 Aug 2020 14:38:38 +0000 (UTC)
From: Nikos Dragazis <ndragazis@arrikto.com>
Date: Mon, 24 Aug 2020 17:37:00 +0300
Message-Id: <20200824143708.5664-4-ndragazis@arrikto.com>
In-Reply-To: <20200824143708.5664-1-ndragazis@arrikto.com>
References: <20200824143708.5664-1-ndragazis@arrikto.com>
Subject: [virtio-dev] [PATCH 03/11] content: Update list of virtio cfg structures
Content-Type: text/plain; charset=US-ASCII
To: virtio-dev@lists.oasis-open.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
List-ID: <virtio-dev.lists.oasis-open.org>

Shared memory and vendor-specific configuration structures have been
introduced in previous commits.

Update the list of virtio configuration structures so that it includes
the shared memory and vendor-specific configuration structures.

Signed-off-by: Nikos Dragazis <ndragazis@arrikto.com>
---
 content.tex | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/content.tex b/content.tex
index 3ce768c..b5b2f79 100644
--- a/content.tex
+++ b/content.tex
@@ -634,6 +634,8 @@ \subsection{Virtio Structure PCI Capabilities}\label{sec:Virtio Transport Option
 \item ISR Status
 \item Device-specific configuration (optional)
 \item PCI configuration access
+\item Shared memory regions (optional)
+\item Vendor-specific data (optional)
 \end{itemize}
 
 Each structure can be mapped by a Base Address register (BAR) belonging to
-- 
2.17.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

