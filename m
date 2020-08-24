Return-Path: virtio-dev-return-7714-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5AF66985E82
	for <virtio-dev@lists.oasis-open.org>; Mon, 24 Aug 2020 14:38:55 +0000 (UTC)
From: Nikos Dragazis <ndragazis@arrikto.com>
Date: Mon, 24 Aug 2020 17:37:04 +0300
Message-Id: <20200824143708.5664-8-ndragazis@arrikto.com>
In-Reply-To: <20200824143708.5664-1-ndragazis@arrikto.com>
References: <20200824143708.5664-1-ndragazis@arrikto.com>
Subject: [virtio-dev] [PATCH 07/11] content: Introduce Doorbell register for MMIO
Content-Type: text/plain; charset=US-ASCII
To: virtio-dev@lists.oasis-open.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
List-ID: <virtio-dev.lists.oasis-open.org>

Signed-off-by: Nikos Dragazis <ndragazis@arrikto.com>
---
 content.tex | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/content.tex b/content.tex
index 628265e..d6fc17e 100644
--- a/content.tex
+++ b/content.tex
@@ -1884,6 +1884,18 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio Transport Options / Vi
     \field{SHMSel} is unused) results in a base address of
     0xffffffffffffffff.
   }
+  \hline
+  \mmioreg{Doorbell}{Doorbell Notifier}{0xc0}{W}{
+    Writing a value to this register
+    \ref{sec:Basic Facilities of a Virtio device / Doorbells} triggers a
+    notification to the device. The value written to this register is
+    interpreted as a doorbell index and the corresponding notification
+    concerns this specific doorbell. The mapping of doorbells to
+    doorbell indices is device-specific. One possible mapping would be
+    to use the integers 0 to N-1 as the doorbell indices for a total of
+    N doorbells. The total number of doorbells exposed by the device is
+    also device-specific.
+  }
   \hline 
   \mmioreg{ConfigGeneration}{Configuration atomicity value}{0x0fc}{R}{
     Reading from this register returns a value describing a version of the device-specific configuration space (see \field{Config}).
@@ -1920,6 +1932,9 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio Transport Options / Vi
 
 The device MUST NOT access virtual queue contents when \field{QueueReady} is zero (0x0).
 
+The device MUST ignore doorbell notifications for invalid doorbell
+indices.
+
 \drivernormative{\subsubsection}{MMIO Device Register Layout}{Virtio Transport Options / Virtio Over MMIO / MMIO Device Register Layout}
 The driver MUST NOT access memory locations not described in the
 table \ref{tab:Virtio Trasport Options / Virtio Over MMIO / MMIO Device Register Layout}
@@ -1977,6 +1992,8 @@ \subsubsection{Device Initialization}\label{sec:Virtio Transport Options / Virti
 Drivers not expecting shared memory MUST NOT use the shared
 memory registers.
 
+Drivers not expecting doorbells MUST NOT use the doorbell register.
+
 Further initialization MUST follow the procedure described in
 \ref{sec:General Initialization And Device Operation / Device Initialization}~\nameref{sec:General Initialization And Device Operation / Device Initialization}.
 
-- 
2.17.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

