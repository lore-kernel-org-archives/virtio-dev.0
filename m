Return-Path: virtio-return-3277-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Mon, 11 Mar 2019 14:11:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190311181151.7475-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio] [PATCH] conformance: tweak to match OASIS requirements
To: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

Number clauses as required by OASIS.

Also reference the transitional clause.

VIRTIO-168

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 commands.tex    |  5 ++++
 conformance.tex | 67 ++++++++++++++++++++++++-------------------------
 2 files changed, 38 insertions(+), 34 deletions(-)

diff --git a/commands.tex b/commands.tex
index 65c9a33..25ea8ee 100644
--- a/commands.tex
+++ b/commands.tex
@@ -10,4 +10,9 @@
 % Mark a normative section (driver or device)
 \newcommand{\drivernormative}[3]{#1{Driver Requirements: #2}\label{drivernormative:#3}}
 \newcommand{\devicenormative}[3]{#1{Device Requirements: #2}\label{devicenormative:#3}}
+\newcounter{clausecounter}
+\newcommand{\conformance}[2]{
+	\stepcounter{clausecounter}
+	#1{Clause \theclausecounter: #2}
+}
 \newenvironment{DIFnomarkup}{}{}
diff --git a/conformance.tex b/conformance.tex
index c0df2a2..ca0747c 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -11,21 +11,23 @@ implementations!
 
 Conformance targets:
 \begin{description}
-\item[Driver] A driver MUST conform to three conformance clauses:
+\item[Driver] A driver MUST conform to four conformance clauses:
   \begin{itemize}
-    \item Clause \ref{sec:Conformance / Driver Conformance},
+    \item Clause \ref{sec:Conformance / Driver Conformance}.
     \item One of clauses \ref{sec:Conformance / Driver Conformance / PCI Driver Conformance}, \ref{sec:Conformance / Driver Conformance / MMIO Driver Conformance} or \ref{sec:Conformance / Driver Conformance / Channel I/O Driver Conformance}.
     \item One of clauses \ref{sec:Conformance / Driver Conformance / Network Driver Conformance}, \ref{sec:Conformance / Driver Conformance / Block Driver Conformance}, \ref{sec:Conformance / Driver Conformance / Console Driver Conformance}, \ref{sec:Conformance / Driver Conformance / Entropy Driver Conformance}, \ref{sec:Conformance / Driver Conformance / Traditional Memory Balloon Driver Conformance}, \ref{sec:Conformance / Driver Conformance / SCSI Host Driver Conformance}, \ref{sec:Conformance / Driver Conformance / Input Driver Conformance}, \ref{sec:Conformance / Driver Conformance / Crypto Driver Conformance} or \ref{sec:Conformance / Driver Conformance / Socket Driver Conformance}.
+    \item Clause \ref{sec:Conformance / Legacy Interface: Transitional Device and Transitional Driver Conformance}.
   \end{itemize}
-\item[Device] A device MUST conform to three conformance clauses:
+\item[Device] A device MUST conform to four conformance clauses:
   \begin{itemize}
-    \item Clause \ref{sec:Conformance / Device Conformance},
+    \item Clause \ref{sec:Conformance / Device Conformance}.
     \item One of clauses \ref{sec:Conformance / Device Conformance / PCI Device Conformance}, \ref{sec:Conformance / Device Conformance / MMIO Device Conformance} or \ref{sec:Conformance / Device Conformance / Channel I/O Device Conformance}.
     \item One of clauses \ref{sec:Conformance / Device Conformance / Network Device Conformance}, \ref{sec:Conformance / Device Conformance / Block Device Conformance}, \ref{sec:Conformance / Device Conformance / Console Device Conformance}, \ref{sec:Conformance / Device Conformance / Entropy Device Conformance}, \ref{sec:Conformance / Device Conformance / Traditional Memory Balloon Device Conformance}, \ref{sec:Conformance / Device Conformance / SCSI Host Device Conformance}, \ref{sec:Conformance / Device Conformance / Input Device Conformance}, \ref{sec:Conformance / Device Conformance / Crypto Device Conformance} or \ref{sec:Conformance / Device Conformance / Socket Device Conformance}.
+    \item Clause \ref{sec:Conformance / Legacy Interface: Transitional Device and Transitional Driver Conformance}.
   \end{itemize}
 \end{description}
 
-\section{Driver Conformance}\label{sec:Conformance / Driver Conformance}
+\conformance{\section}{Driver Conformance}\label{sec:Conformance / Driver Conformance}
 
 A driver MUST conform to the following normative statements:
 
@@ -48,7 +50,7 @@ A driver MUST conform to the following normative statements:
 \item \ref{drivernormative:Reserved Feature Bits}
 \end{itemize}
 
-\subsection{PCI Driver Conformance}\label{sec:Conformance / Driver Conformance / PCI Driver Conformance}
+\conformance{\subsection}{PCI Driver Conformance}\label{sec:Conformance / Driver Conformance / PCI Driver Conformance}
 
 A PCI driver MUST conform to the following normative statements:
 
@@ -63,7 +65,7 @@ A PCI driver MUST conform to the following normative statements:
 \item \ref{drivernormative:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Notification of Device Configuration Changes}
 \end{itemize}
 
-\subsection{MMIO Driver Conformance}\label{sec:Conformance / Driver Conformance / MMIO Driver Conformance}
+\conformance{\subsection}{MMIO Driver Conformance}\label{sec:Conformance / Driver Conformance / MMIO Driver Conformance}
 
 An MMIO driver MUST conform to the following normative statements:
 
@@ -73,7 +75,7 @@ An MMIO driver MUST conform to the following normative statements:
 \item \ref{drivernormative:Virtio Transport Options / Virtio Over MMIO / MMIO-specific Initialization And Device Operation / Notifications From The Device}
 \end{itemize}
 
-\subsection{Channel I/O Driver Conformance}\label{sec:Conformance / Driver Conformance / Channel I/O Driver Conformance}
+\conformance{\subsection}{Channel I/O Driver Conformance}\label{sec:Conformance / Driver Conformance / Channel I/O Driver Conformance}
 
 A Channel I/O driver MUST conform to the following normative statements:
 
@@ -85,7 +87,7 @@ A Channel I/O driver MUST conform to the following normative statements:
 \item \ref{drivernormative:Virtio Transport Options / Virtio over channel I/O / Device Operation / Guest->Host Notification}
 \end{itemize}
 
-\subsection{Network Driver Conformance}\label{sec:Conformance / Driver Conformance / Network Driver Conformance}
+\conformance{\subsection}{Network Driver Conformance}\label{sec:Conformance / Driver Conformance / Network Driver Conformance}
 
 A network driver MUST conform to the following normative statements:
 
@@ -101,7 +103,7 @@ A network driver MUST conform to the following normative statements:
 \item \ref{drivernormative:Device Types / Network Device / Device Operation / Control Virtqueue / Offloads State Configuration / Setting Offloads State}
 \end{itemize}
 
-\subsection{Block Driver Conformance}\label{sec:Conformance / Driver Conformance / Block Driver Conformance}
+\conformance{\subsection}{Block Driver Conformance}\label{sec:Conformance / Driver Conformance / Block Driver Conformance}
 
 A block driver MUST conform to the following normative statements:
 
@@ -110,7 +112,7 @@ A block driver MUST conform to the following normative statements:
 \item \ref{drivernormative:Device Types / Block Device / Device Operation}
 \end{itemize}
 
-\subsection{Console Driver Conformance}\label{sec:Conformance / Driver Conformance / Console Driver Conformance}
+\conformance{\subsection}{Console Driver Conformance}\label{sec:Conformance / Driver Conformance / Console Driver Conformance}
 
 A console driver MUST conform to the following normative statements:
 
@@ -119,7 +121,7 @@ A console driver MUST conform to the following normative statements:
 \item \ref{drivernormative:Device Types / Console Device / Device Operation / Multiport Device Operation}
 \end{itemize}
 
-\subsection{Entropy Driver Conformance}\label{sec:Conformance / Driver Conformance / Entropy Driver Conformance}
+\conformance{\subsection}{Entropy Driver Conformance}\label{sec:Conformance / Driver Conformance / Entropy Driver Conformance}
 
 An entropy driver MUST conform to the following normative statements:
 
@@ -127,7 +129,7 @@ An entropy driver MUST conform to the following normative statements:
 \item \ref{drivernormative:Device Types / Entropy Device / Device Operation}
 \end{itemize}
 
-\subsection{Traditional Memory Balloon Driver Conformance}\label{sec:Conformance / Driver Conformance / Traditional Memory Balloon Driver Conformance}
+\conformance{\subsection}{Traditional Memory Balloon Driver Conformance}\label{sec:Conformance / Driver Conformance / Traditional Memory Balloon Driver Conformance}
 
 A traditional memory balloon driver MUST conform to the following normative statements:
 
@@ -137,7 +139,7 @@ A traditional memory balloon driver MUST conform to the following normative stat
 \item \ref{drivernormative:Device Types / Memory Balloon Device / Device Operation / Memory Statistics}
 \end{itemize}
 
-\subsection{SCSI Host Driver Conformance}\label{sec:Conformance / Driver Conformance / SCSI Host Driver Conformance}
+\conformance{\subsection}{SCSI Host Driver Conformance}\label{sec:Conformance / Driver Conformance / SCSI Host Driver Conformance}
 
 An SCSI host driver MUST conform to the following normative statements:
 
@@ -147,7 +149,7 @@ An SCSI host driver MUST conform to the following normative statements:
 \item \ref{drivernormative:Device Types / SCSI Host Device / Device Operation / Device Operation: eventq}
 \end{itemize}
 
-\subsection{Input Driver Conformance}\label{sec:Conformance / Driver Conformance / Input Driver Conformance}
+\conformance{\subsection}{Input Driver Conformance}\label{sec:Conformance / Driver Conformance / Input Driver Conformance}
 
 An input driver MUST conform to the following normative statements:
 
@@ -156,7 +158,7 @@ An input driver MUST conform to the following normative statements:
 \item \ref{drivernormative:Device Types / Input Device / Device Operation}
 \end{itemize}
 
-\subsection{Crypto Driver Conformance}\label{sec:Conformance / Driver Conformance / Crypto Driver Conformance}
+\conformance{\subsection}{Crypto Driver Conformance}\label{sec:Conformance / Driver Conformance / Crypto Driver Conformance}
 
 A Crypto driver MUST conform to the following normative statements:
 
@@ -171,7 +173,7 @@ A Crypto driver MUST conform to the following normative statements:
 \item \ref{drivernormative:Device Types / Crypto Device / Device Operation / AEAD Service Operation}
 \end{itemize}
 
-\subsection{Socket Driver Conformance}\label{sec:Conformance / Driver Conformance / Socket Driver Conformance}
+\conformance{\subsection}{Socket Driver Conformance}\label{sec:Conformance / Driver Conformance / Socket Driver Conformance}
 
 A socket driver MUST conform to the following normative statements:
 
@@ -181,7 +183,7 @@ A socket driver MUST conform to the following normative statements:
 \item \ref{drivernormative:Device Types / Socket Device / Device Operation / Device Events}
 \end{itemize}
 
-\section{Device Conformance}\label{sec:Conformance / Device Conformance}
+\conformance{\section}{Device Conformance}\label{sec:Conformance / Device Conformance}
 
 A device MUST conform to the following normative statements:
 
@@ -198,7 +200,7 @@ A device MUST conform to the following normative statements:
 \item \ref{devicenormative:Reserved Feature Bits}
 \end{itemize}
 
-\subsection{PCI Device Conformance}\label{sec:Conformance / Device Conformance / PCI Device Conformance}
+\conformance{\subsection}{PCI Device Conformance}\label{sec:Conformance / Device Conformance / PCI Device Conformance}
 
 A PCI device MUST conform to the following normative statements:
 
@@ -218,7 +220,7 @@ A PCI device MUST conform to the following normative statements:
 \item \ref{devicenormative:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Notification of Device Configuration Changes}
 \end{itemize}
 
-\subsection{MMIO Device Conformance}\label{sec:Conformance / Device Conformance / MMIO Device Conformance}
+\conformance{\subsection}{MMIO Device Conformance}\label{sec:Conformance / Device Conformance / MMIO Device Conformance}
 
 An MMIO device MUST conform to the following normative statements:
 
@@ -226,7 +228,7 @@ An MMIO device MUST conform to the following normative statements:
 \item \ref{devicenormative:Virtio Transport Options / Virtio Over MMIO / MMIO Device Register Layout}
 \end{itemize}
 
-\subsection{Channel I/O Device Conformance}\label{sec:Conformance / Device Conformance / Channel I/O Device Conformance}
+\conformance{\subsection}{Channel I/O Device Conformance}\label{sec:Conformance / Device Conformance / Channel I/O Device Conformance}
 
 A Channel I/O device MUST conform to the following normative statements:
 
@@ -240,7 +242,7 @@ A Channel I/O device MUST conform to the following normative statements:
 \item \ref{devicenormative:Virtio Transport Options / Virtio over channel I/O / Device Operation / Guest->Host Notification}
 \end{itemize}
 
-\subsection{Network Device Conformance}\label{sec:Conformance / Device Conformance / Network Device Conformance}
+\conformance{\subsection}{Network Device Conformance}\label{sec:Conformance / Device Conformance / Network Device Conformance}
 
 A network device MUST conform to the following normative statements:
 
@@ -255,7 +257,7 @@ A network device MUST conform to the following normative statements:
 \item \ref{devicenormative:Device Types / Network Device / Device Operation / Control Virtqueue / Automatic receive steering in multiqueue mode}
 \end{itemize}
 
-\subsection{Block Device Conformance}\label{sec:Conformance / Device Conformance / Block Device Conformance}
+\conformance{\subsection}{Block Device Conformance}\label{sec:Conformance / Device Conformance / Block Device Conformance}
 
 A block device MUST conform to the following normative statements:
 
@@ -264,7 +266,7 @@ A block device MUST conform to the following normative statements:
 \item \ref{devicenormative:Device Types / Block Device / Device Operation}
 \end{itemize}
 
-\subsection{Console Device Conformance}\label{sec:Conformance / Device Conformance / Console Device Conformance}
+\conformance{\subsection}{Console Device Conformance}\label{sec:Conformance / Device Conformance / Console Device Conformance}
 
 A console device MUST conform to the following normative statements:
 
@@ -273,7 +275,7 @@ A console device MUST conform to the following normative statements:
 \item \ref{devicenormative:Device Types / Console Device / Device Operation / Multiport Device Operation}
 \end{itemize}
 
-\subsection{Entropy Device Conformance}\label{sec:Conformance / Device Conformance / Entropy Device Conformance}
+\conformance{\subsection}{Entropy Device Conformance}\label{sec:Conformance / Device Conformance / Entropy Device Conformance}
 
 An entropy device MUST conform to the following normative statements:
 
@@ -281,7 +283,7 @@ An entropy device MUST conform to the following normative statements:
 \item \ref{devicenormative:Device Types / Entropy Device / Device Operation}
 \end{itemize}
 
-\subsection{Traditional Memory Balloon Device Conformance}\label{sec:Conformance / Device Conformance / Traditional Memory Balloon Device Conformance}
+\conformance{\subsection}{Traditional Memory Balloon Device Conformance}\label{sec:Conformance / Device Conformance / Traditional Memory Balloon Device Conformance}
 
 A traditional memory balloon device MUST conform to the following normative statements:
 
@@ -291,7 +293,7 @@ A traditional memory balloon device MUST conform to the following normative stat
 \item \ref{devicenormative:Device Types / Memory Balloon Device / Device Operation / Memory Statistics}
 \end{itemize}
 
-\subsection{SCSI Host Device Conformance}\label{sec:Conformance / Device Conformance / SCSI Host Device Conformance}
+\conformance{\subsection}{SCSI Host Device Conformance}\label{sec:Conformance / Device Conformance / SCSI Host Device Conformance}
 
 An SCSI host device MUST conform to the following normative statements:
 
@@ -302,7 +304,7 @@ An SCSI host device MUST conform to the following normative statements:
 \item \ref{devicenormative:Device Types / SCSI Host Device / Device Operation / Device Operation: eventq}
 \end{itemize}
 
-\subsection{Input Device Conformance}\label{sec:Conformance / Device Conformance / Input Device Conformance}
+\conformance{\subsection}{Input Device Conformance}\label{sec:Conformance / Device Conformance / Input Device Conformance}
 
 An input device MUST conform to the following normative statements:
 
@@ -311,7 +313,7 @@ An input device MUST conform to the following normative statements:
 \item \ref{devicenormative:Device Types / Input Device / Device Operation}
 \end{itemize}
 
-\subsection{Crypto Device Conformance}\label{sec:Conformance / Device Conformance / Crypto Device Conformance}
+\conformance{\subsection}{Crypto Device Conformance}\label{sec:Conformance / Device Conformance / Crypto Device Conformance}
 
 A Crypto device MUST conform to the following normative statements:
 
@@ -325,7 +327,7 @@ A Crypto device MUST conform to the following normative statements:
 \item \ref{devicenormative:Device Types / Crypto Device / Device Operation / AEAD Service Operation}
 \end{itemize}
 
-\subsection{Socket Device Conformance}\label{sec:Conformance / Device Conformance / Socket Device Conformance}
+\conformance{\subsection}{Socket Device Conformance}\label{sec:Conformance / Device Conformance / Socket Device Conformance}
 
 A socket device MUST conform to the following normative statements:
 
@@ -334,10 +336,7 @@ A socket device MUST conform to the following normative statements:
 \item \ref{devicenormative:Device Types / Socket Device / Device Operation / Receive and Transmit}
 \end{itemize}
 
-\section{Legacy Interface: Transitional Device and
-Transitional Driver Conformance}\label{sec:Conformance / Legacy
-Interface: Transitional Device and 
-Transitional Driver Conformance}
+\conformance{\section}{Legacy Interface: Transitional Device and Transitional Driver Conformance}\label{sec:Conformance / Legacy Interface: Transitional Device and Transitional Driver Conformance}
 A conformant implementation MUST be either transitional or
 non-transitional, see \ref{intro:Legacy
 Interface: Terminology}.
-- 
MST

---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

