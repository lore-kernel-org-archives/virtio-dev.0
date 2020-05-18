Return-Path: virtio-dev-return-7363-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 751C498604E
	for <virtio-dev@lists.oasis-open.org>; Mon, 18 May 2020 20:38:37 +0000 (UTC)
From: Nikos Dragazis <ndragazis@arrikto.com>
Date: Mon, 18 May 2020 23:37:17 +0300
Message-Id: <20200518203721.7625-7-ndragazis@arrikto.com>
In-Reply-To: <20200518203721.7625-1-ndragazis@arrikto.com>
References: <20200518203721.7625-1-ndragazis@arrikto.com>
Subject: [virtio-dev] [PATCH v5 06/10] vhost-user: change the device id
Content-Type: text/plain; charset=US-ASCII
To: virtio-dev@lists.oasis-open.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Change the device id from 28 to 32.

Signed-off-by: Nikos Dragazis <ndragazis@arrikto.com>
---
 content.tex           | 2 +-
 virtio-vhost-user.tex | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/content.tex b/content.tex
index 9f3e86d..8b4aa88 100644
--- a/content.tex
+++ b/content.tex
@@ -2801,7 +2801,7 @@ \chapter{Device Types}\label{sec:Device Types}
 \hline
 31         &   Video decoder device \\
 \hline
-28         &   vhost-user device backend \\
+32         &   vhost-user device backend \\
 \hline
 \end{tabular}
 
diff --git a/virtio-vhost-user.tex b/virtio-vhost-user.tex
index 678d018..29e7323 100644
--- a/virtio-vhost-user.tex
+++ b/virtio-vhost-user.tex
@@ -27,7 +27,7 @@ \section{Vhost-user Device Backend}\label{sec:Device Types / Vhost-user Device B
 because the pre-existing vhost-user wire protocol is used.
 
 \subsection{Device ID}\label{sec:Device Types / Vhost-user Device Backend / Device ID}
-  28
+  32
 
 \subsection{Virtqueues}\label{sec:Device Types / Vhost-user Device Backend / Virtqueues}
 
-- 
2.17.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

