Return-Path: virtio-dev-return-7708-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8CD9298432C
	for <virtio-dev@lists.oasis-open.org>; Mon, 24 Aug 2020 14:38:34 +0000 (UTC)
From: Nikos Dragazis <ndragazis@arrikto.com>
Date: Mon, 24 Aug 2020 17:36:58 +0300
Message-Id: <20200824143708.5664-2-ndragazis@arrikto.com>
In-Reply-To: <20200824143708.5664-1-ndragazis@arrikto.com>
References: <20200824143708.5664-1-ndragazis@arrikto.com>
Subject: [virtio-dev] [PATCH 01/11] content: Remove duplicate content
Content-Type: text/plain; charset=US-ASCII
To: virtio-dev@lists.oasis-open.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
List-ID: <virtio-dev.lists.oasis-open.org>

Signed-off-by: Nikos Dragazis <ndragazis@arrikto.com>
---
 content.tex | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/content.tex b/content.tex
index 91735e3..d505e94 100644
--- a/content.tex
+++ b/content.tex
@@ -1101,14 +1101,6 @@ \subsubsection{Shared memory capability}\label{sec:Virtio Transport Options / Vi
 
 The \field{cap.id} MUST be unique for any one device instance.
 
-\devicenormative{\paragraph}{Device-specific configuration}{Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Shared memory capability}
-
-The region defined by the combination of the \field {cap.offset},
-\field {cap.offset_hi}, and \field {cap.length}, \field
-{cap.length_hi} fields MUST be contained within the declared bar.
-
-The \field{cap.id} MUST be unique for any one device instance.
-
 \subsubsection{Vendor data capability}\label{sec:Virtio
 Transport Options / Virtio Over PCI Bus / PCI Device Layout /
 Vendor data capability}
-- 
2.17.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

