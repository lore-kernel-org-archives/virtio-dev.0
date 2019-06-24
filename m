Return-Path: virtio-dev-return-5807-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C6B11985A3D
	for <virtio-dev@lists.oasis-open.org>; Mon, 24 Jun 2019 23:30:08 +0000 (UTC)
From: Nikos Dragazis <ndragazis@arrikto.com>
Date: Tue, 25 Jun 2019 02:29:57 +0300
Message-Id: <1561418997-24608-6-git-send-email-ndragazis@arrikto.com>
In-Reply-To: <1561418997-24608-1-git-send-email-ndragazis@arrikto.com>
References: <1561418997-24608-1-git-send-email-ndragazis@arrikto.com>
Subject: [virtio-dev] [PATCH v4 5/5] vhost-user: add conformance targets and clauses
To: virtio-dev@lists.oasis-open.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Vangelis Koukis <vkoukis@arrikto.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Signed-off-by: Nikos Dragazis <ndragazis@arrikto.com>
---
 conformance.tex       | 24 ++++++++++++++++++++++--
 virtio-vhost-user.tex |  4 ++--
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/conformance.tex b/conformance.tex
index 42f702a..e83cd5c 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -15,14 +15,14 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
   \begin{itemize}
     \item Clause \ref{sec:Conformance / Driver Conformance}.
     \item One of clauses \ref{sec:Conformance / Driver Conformance / PCI Driver Conformance}, \ref{sec:Conformance / Driver Conformance / MMIO Driver Conformance} or \ref{sec:Conformance / Driver Conformance / Channel I/O Driver Conformance}.
-    \item One of clauses \ref{sec:Conformance / Driver Conformance / Network Driver Conformance}, \ref{sec:Conformance / Driver Conformance / Block Driver Conformance}, \ref{sec:Conformance / Driver Conformance / Console Driver Conformance}, \ref{sec:Conformance / Driver Conformance / Entropy Driver Conformance}, \ref{sec:Conformance / Driver Conformance / Traditional Memory Balloon Driver Conformance}, \ref{sec:Conformance / Driver Conformance / SCSI Host Driver Conformance}, \ref{sec:Conformance / Driver Conformance / Input Driver Conformance}, \ref{sec:Conformance / Driver Conformance / Crypto Driver Conformance} or \ref{sec:Conformance / Driver Conformance / Socket Driver Conformance}.
+    \item One of clauses \ref{sec:Conformance / Driver Conformance / Network Driver Conformance}, \ref{sec:Conformance / Driver Conformance / Block Driver Conformance}, \ref{sec:Conformance / Driver Conformance / Console Driver Conformance}, \ref{sec:Conformance / Driver Conformance / Entropy Driver Conformance}, \ref{sec:Conformance / Driver Conformance / Traditional Memory Balloon Driver Conformance}, \ref{sec:Conformance / Driver Conformance / SCSI Host Driver Conformance}, \ref{sec:Conformance / Driver Conformance / Input Driver Conformance}, \ref{sec:Conformance / Driver Conformance / Crypto Driver Conformance}, \ref{sec:Conformance / Driver Conformance / Socket Driver Conformance} or \ref{sec:Conformance / Driver Conformance / Vhost-user Backend Driver Conformance}.
     \item Clause \ref{sec:Conformance / Legacy Interface: Transitional Device and Transitional Driver Conformance}.
   \end{itemize}
 \item[Device] A device MUST conform to four conformance clauses:
   \begin{itemize}
     \item Clause \ref{sec:Conformance / Device Conformance}.
     \item One of clauses \ref{sec:Conformance / Device Conformance / PCI Device Conformance}, \ref{sec:Conformance / Device Conformance / MMIO Device Conformance} or \ref{sec:Conformance / Device Conformance / Channel I/O Device Conformance}.
-    \item One of clauses \ref{sec:Conformance / Device Conformance / Network Device Conformance}, \ref{sec:Conformance / Device Conformance / Block Device Conformance}, \ref{sec:Conformance / Device Conformance / Console Device Conformance}, \ref{sec:Conformance / Device Conformance / Entropy Device Conformance}, \ref{sec:Conformance / Device Conformance / Traditional Memory Balloon Device Conformance}, \ref{sec:Conformance / Device Conformance / SCSI Host Device Conformance}, \ref{sec:Conformance / Device Conformance / Input Device Conformance}, \ref{sec:Conformance / Device Conformance / Crypto Device Conformance} or \ref{sec:Conformance / Device Conformance / Socket Device Conformance}.
+    \item One of clauses \ref{sec:Conformance / Device Conformance / Network Device Conformance}, \ref{sec:Conformance / Device Conformance / Block Device Conformance}, \ref{sec:Conformance / Device Conformance / Console Device Conformance}, \ref{sec:Conformance / Device Conformance / Entropy Device Conformance}, \ref{sec:Conformance / Device Conformance / Traditional Memory Balloon Device Conformance}, \ref{sec:Conformance / Device Conformance / SCSI Host Device Conformance}, \ref{sec:Conformance / Device Conformance / Input Device Conformance}, \ref{sec:Conformance / Device Conformance / Crypto Device Conformance}, \ref{sec:Conformance / Device Conformance / Socket Device Conformance} or \ref{sec:Conformance / Device Conformance / Vhost-user Backend Device Conformance}.
     \item Clause \ref{sec:Conformance / Legacy Interface: Transitional Device and Transitional Driver Conformance}.
   \end{itemize}
 \end{description}
@@ -183,6 +183,15 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
 \item \ref{drivernormative:Device Types / Socket Device / Device Operation / Device Events}
 \end{itemize}
 
+\conformance{\subsection}{Vhost-user Backend Driver Conformance}\label{sec:Conformance / Driver Conformance / Vhost-user Backend Driver Conformance}
+
+A vhost-user backend driver MUST conform to the following normative statements:
+
+\begin{itemize}
+\item \ref{drivernormative:Device Types / Vhost-user Device Backend / Device configuration layout}
+\item \ref{drivernormative:Device Types / Vhost-user Device Backend / Additional Device Resources over PCI / Notification capability}
+\end{itemize}
+
 \conformance{\section}{Device Conformance}\label{sec:Conformance / Device Conformance}
 
 A device MUST conform to the following normative statements:
@@ -336,6 +345,17 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
 \item \ref{devicenormative:Device Types / Socket Device / Device Operation / Receive and Transmit}
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
+
 \conformance{\section}{Legacy Interface: Transitional Device and Transitional Driver Conformance}\label{sec:Conformance / Legacy Interface: Transitional Device and Transitional Driver Conformance}
 A conformant implementation MUST be either transitional or
 non-transitional, see \ref{intro:Legacy
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
2.7.4


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

