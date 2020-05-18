Return-Path: virtio-dev-return-7365-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 81D6298615D
	for <virtio-dev@lists.oasis-open.org>; Mon, 18 May 2020 20:38:38 +0000 (UTC)
From: Nikos Dragazis <ndragazis@arrikto.com>
Date: Mon, 18 May 2020 23:37:16 +0300
Message-Id: <20200518203721.7625-6-ndragazis@arrikto.com>
In-Reply-To: <20200518203721.7625-1-ndragazis@arrikto.com>
References: <20200518203721.7625-1-ndragazis@arrikto.com>
Subject: [virtio-dev] [PATCH v5 05/10] vhost-user: add conformance targets and clauses
Content-Type: text/plain; charset=US-ASCII
To: virtio-dev@lists.oasis-open.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Signed-off-by: Nikos Dragazis <ndragazis@arrikto.com>
---
 conformance.tex       | 25 ++++++++++++++++++++++---
 virtio-vhost-user.tex |  4 ++--
 2 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/conformance.tex b/conformance.tex
index b6fdec0..dcd2199 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -15,7 +15,7 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
   \begin{itemize}
     \item Clause \ref{sec:Conformance / Driver Conformance}.
     \item One of clauses \ref{sec:Conformance / Driver Conformance / PCI Driver Conformance}, \ref{sec:Conformance / Driver Conformance / MMIO Driver Conformance} or \ref{sec:Conformance / Driver Conformance / Channel I/O Driver Conformance}.
-    \item One of clauses \ref{sec:Conformance / Driver Conformance / Network Driver Conformance}, \ref{sec:Conformance / Driver Conformance / Block Driver Conformance}, \ref{sec:Conformance / Driver Conformance / Console Driver Conformance}, \ref{sec:Conformance / Driver Conformance / Entropy Driver Conformance}, \ref{sec:Conformance / Driver Conformance / Traditional Memory Balloon Driver Conformance}, \ref{sec:Conformance / Driver Conformance / SCSI Host Driver Conformance}, \ref{sec:Conformance / Driver Conformance / Input Driver Conformance}, \ref{sec:Conformance / Driver Conformance / Crypto Driver Conformance}, \ref{sec:Conformance / Driver Conformance / Socket Driver Conformance} or \ref{sec:Conformance / Driver Conformance / IOMMU Driver Conformance}.
+    \item One of clauses \ref{sec:Conformance / Driver Conformance / Network Driver Conformance}, \ref{sec:Conformance / Driver Conformance / Block Driver Conformance}, \ref{sec:Conformance / Driver Conformance / Console Driver Conformance}, \ref{sec:Conformance / Driver Conformance / Entropy Driver Conformance}, \ref{sec:Conformance / Driver Conformance / Traditional Memory Balloon Driver Conformance}, \ref{sec:Conformance / Driver Conformance / SCSI Host Driver Conformance}, \ref{sec:Conformance / Driver Conformance / Input Driver Conformance}, \ref{sec:Conformance / Driver Conformance / Crypto Driver Conformance}, \ref{sec:Conformance / Driver Conformance / Socket Driver Conformance}, \ref{sec:Conformance / Driver Conformance / IOMMU Driver Conformance} or \ref{sec:Conformance / Driver Conformance / Vhost-user Backend Driver Conformance}.
     \item Clause \ref{sec:Conformance / Legacy Interface: Transitional Device and Transitional Driver Conformance}.
   \end{itemize}
 \item[Device] A device MUST conform to four conformance clauses:
@@ -32,8 +32,9 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
 \ref{sec:Conformance / Device Conformance / Input Device Conformance}, 
 \ref{sec:Conformance / Device Conformance / Crypto Device Conformance}, 
 \ref{sec:Conformance / Device Conformance / Socket Device Conformance}, 
-\ref{sec:Conformance / Device Conformance / RPMB Device Conformance} or 
-\ref{sec:Conformance / Device Conformance / IOMMU Device Conformance}.
+\ref{sec:Conformance / Device Conformance / RPMB Device Conformance}, 
+\ref{sec:Conformance / Device Conformance / IOMMU Device Conformance} or 
+\ref{sec:Conformance / Device Conformance / Vhost-user Backend Device Conformance}.
     \item Clause \ref{sec:Conformance / Legacy Interface: Transitional Device and Transitional Driver Conformance}.
   \end{itemize}
 \end{description}
@@ -219,6 +220,14 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
 \item \ref{drivernormative:Device Types / IOMMU Device / Device operations / PROBE properties / RESVMEM}
 \item \ref{drivernormative:Device Types / IOMMU Device / Device operations / Fault reporting}
 \end{itemize}
+\conformance{\subsection}{Vhost-user Backend Driver Conformance}\label{sec:Conformance / Driver Conformance / Vhost-user Backend Driver Conformance}
+
+A vhost-user backend driver MUST conform to the following normative statements:
+
+\begin{itemize}
+\item \ref{drivernormative:Device Types / Vhost-user Device Backend / Device configuration layout}
+\item \ref{drivernormative:Device Types / Vhost-user Device Backend / Additional Device Resources over PCI / Notification capability}
+\end{itemize}
 
 \conformance{\section}{Device Conformance}\label{sec:Conformance / Device Conformance}
 
@@ -407,6 +416,16 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
 \item \ref{devicenormative:Device Types / IOMMU Device / Device operations / PROBE properties / RESVMEM}
 \item \ref{devicenormative:Device Types / IOMMU Device / Device operations / Fault reporting}
 \end{itemize}
+\conformance{\subsection}{Vhost-user Backend Device Conformance}\label{sec:Conformance / Device Conformance / Vhost-user Backend Device Conformance}
+
+A vhost-user backend device MUST conform to the following normative statements:
+
+\begin{itemize}
+\item \ref{devicenormative:Device Types / Vhost-user Device Backend / Device Initialization}
+\item \ref{devicenormative:Device Types / Vhost-user Device Backend / Additional Device Resources over PCI / Doorbell capability}
+\item \ref{devicenormative:Device Types / Vhost-user Device Backend / Additional Device Resources over PCI / Notification capability}
+\item \ref{devicenormative:Device Types / Vhost-user Device Backend / Additional Device Resources over PCI / Shared memory capability}
+\end{itemize}
 
 \conformance{\section}{Legacy Interface: Transitional Device and Transitional Driver Conformance}\label{sec:Conformance / Legacy Interface: Transitional Device and Transitional Driver Conformance}
 A conformant implementation MUST be either transitional or
diff --git a/virtio-vhost-user.tex b/virtio-vhost-user.tex
index d1305dd..678d018 100644
--- a/virtio-vhost-user.tex
+++ b/virtio-vhost-user.tex
@@ -298,7 +298,7 @@ \subsubsection{Notification structure layout}\label{sec:Device Types / Vhost-use
 
 \drivernormative{\paragraph}{Notification capability}{Device Types /
 Vhost-user Device Backend / Additional Device Resources over PCI /
-Noification capability}
+Notification capability}
 
 Driver MUST support device with any MSI-X Table Size 0 to 0x7FF. Driver
 MAY fall back on using INT\#x interrupts for a device which only
@@ -337,7 +337,7 @@ \subsubsection{Shared memory capability}\label{sec:Device Types / Vhost-user Dev
 The \field{cap.offset} and \field{cap.length} fields are taken from the
 SHARED_MEMORY_CFG capability structure.
 
-\devicenormative{\paragraph}{Shared Memory capability}{Device Types / Vhost-user Device Backend / Additional Device Resources over PCI / Shared Memory capability}
+\devicenormative{\paragraph}{Shared memory capability}{Device Types / Vhost-user Device Backend / Additional Device Resources over PCI / Shared memory capability}
 The device MUST present exactly one shared memory capability.
 
 The device MUST locate shared memory in a Memory Space BAR.
-- 
2.17.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

