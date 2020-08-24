Return-Path: virtio-dev-return-7711-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 61FE898435E
	for <virtio-dev@lists.oasis-open.org>; Mon, 24 Aug 2020 14:38:42 +0000 (UTC)
From: Nikos Dragazis <ndragazis@arrikto.com>
Date: Mon, 24 Aug 2020 17:37:01 +0300
Message-Id: <20200824143708.5664-5-ndragazis@arrikto.com>
In-Reply-To: <20200824143708.5664-1-ndragazis@arrikto.com>
References: <20200824143708.5664-1-ndragazis@arrikto.com>
Subject: [virtio-dev] [PATCH 04/11] content: Minor layout fix
Content-Type: text/plain; charset=US-ASCII
To: virtio-dev@lists.oasis-open.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
List-ID: <virtio-dev.lists.oasis-open.org>

Fix the device/driver requirements of the vendor data capability so that
they are subsections of the vendor data capability section.

Signed-off-by: Nikos Dragazis <ndragazis@arrikto.com>
---
 content.tex | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/content.tex b/content.tex
index b5b2f79..94a3693 100644
--- a/content.tex
+++ b/content.tex
@@ -1142,7 +1142,7 @@ \subsubsection{Vendor data capability}\label{sec:Virtio
 To make it safe for a generic driver to access the capability,
 reads from this capability MUST NOT have any side effects.
 
-\devicenormative{\subsection}{Vendor data capability}{Virtio
+\devicenormative{\paragraph}{Vendor data capability}{Virtio
 Transport Options / Virtio Over PCI Bus / PCI Device Layout /
 Vendor data capability}
 
@@ -1159,7 +1159,7 @@ \subsubsection{Vendor data capability}\label{sec:Virtio
 Reads of the Vendor data capability by the driver MUST NOT have any
 side effects.
 
-\drivernormative{\subsection}{Vendor data capability}{Virtio
+\drivernormative{\paragraph}{Vendor data capability}{Virtio
 Transport Options / Virtio Over PCI Bus / PCI Device Layout /
 Vendor data capability}
 
-- 
2.17.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

