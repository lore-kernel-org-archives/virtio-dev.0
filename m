Return-Path: virtio-dev-return-7717-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BA5549843EA
	for <virtio-dev@lists.oasis-open.org>; Mon, 24 Aug 2020 14:38:56 +0000 (UTC)
From: Nikos Dragazis <ndragazis@arrikto.com>
Date: Mon, 24 Aug 2020 17:37:08 +0300
Message-Id: <20200824143708.5664-12-ndragazis@arrikto.com>
In-Reply-To: <20200824143708.5664-1-ndragazis@arrikto.com>
References: <20200824143708.5664-1-ndragazis@arrikto.com>
Subject: [virtio-dev] [PATCH 11/11] content: Introduce device-specific notifications for MMIO
Content-Type: text/plain; charset=US-ASCII
To: virtio-dev@lists.oasis-open.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
List-ID: <virtio-dev.lists.oasis-open.org>

Signed-off-by: Nikos Dragazis <ndragazis@arrikto.com>
---
 content.tex | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/content.tex b/content.tex
index d141e92..b0949f9 100644
--- a/content.tex
+++ b/content.tex
@@ -1872,6 +1872,10 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio Transport Options / Vi
         in at least one of the active virtual queues.
       \item [Configuration Change Notification] - bit 1 - the interrupt was
         asserted because the configuration of the device has changed.
+      \item [Device-specific Notification] - bit 2 - the interrupt was
+        asserted because a device-specific event
+	\ref{sec:Basic Facilities of a Virtio Device / Notifications}
+	occurred.
     \end{description}
   }
   \hline 
@@ -2100,8 +2104,9 @@ \subsubsection{Notifications From The Device}\label{sec:Virtio Transport Options
 The memory mapped virtio device is using a single, dedicated
 interrupt signal, which is asserted when at least one of the
 bits described in the description of \field{InterruptStatus}
-is set. This is how the device sends a used buffer notification
-or a configuration change notification to the device.
+is set. This is how the device sends a
+used buffer/configuration change/device-specific notification to the
+device.
 
 \drivernormative{\paragraph}{Notifications From The Device}{Virtio Transport Options / Virtio Over MMIO / MMIO-specific Initialization And Device Operation / Notifications From The Device}
 After receiving an interrupt, the driver MUST read
-- 
2.17.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

