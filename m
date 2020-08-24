Return-Path: virtio-dev-return-7712-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 23E9798432E
	for <virtio-dev@lists.oasis-open.org>; Mon, 24 Aug 2020 14:38:46 +0000 (UTC)
From: Nikos Dragazis <ndragazis@arrikto.com>
Date: Mon, 24 Aug 2020 17:37:02 +0300
Message-Id: <20200824143708.5664-6-ndragazis@arrikto.com>
In-Reply-To: <20200824143708.5664-1-ndragazis@arrikto.com>
References: <20200824143708.5664-1-ndragazis@arrikto.com>
Subject: [virtio-dev] [PATCH 05/11] doorbells: Introduce doorbells
Content-Type: text/plain; charset=US-ASCII
To: virtio-dev@lists.oasis-open.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
List-ID: <virtio-dev.lists.oasis-open.org>

Introduce doorbells as a new virtio device resource.

Signed-off-by: Nikos Dragazis <ndragazis@arrikto.com>
---
 content.tex   |  2 ++
 doorbells.tex | 12 ++++++++++++
 2 files changed, 14 insertions(+)
 create mode 100644 doorbells.tex

diff --git a/content.tex b/content.tex
index 94a3693..38ed709 100644
--- a/content.tex
+++ b/content.tex
@@ -373,6 +373,8 @@ \section{Driver Notifications} \label{sec:Virtqueues / Driver notifications}
 
 \input{shared-mem.tex}
 
+\input{doorbells.tex}
+
 \chapter{General Initialization And Device Operation}\label{sec:General Initialization And Device Operation}
 
 We start with an overview of device initialization, then expand on the
diff --git a/doorbells.tex b/doorbells.tex
new file mode 100644
index 0000000..e917536
--- /dev/null
+++ b/doorbells.tex
@@ -0,0 +1,12 @@
+\section{Doorbells}\label{sec:Basic Facilities of a Virtio device / Doorbells}
+
+A doorbell is a device register that triggers a notification to the
+device when accessed by the driver.
+
+Doorbells are an additional facility available to devices that need to
+support receiving driver notifications for events other than virtqueue
+activity (i.e., notifications that are device-specific).
+
+A device may be exporting multiple doorbells to the driver.
+
+The location of doorbells is found in a transport-specific way.
-- 
2.17.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

