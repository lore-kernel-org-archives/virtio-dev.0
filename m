Return-Path: virtio-return-3259-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Fri, 8 Mar 2019 09:11:23 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190308141120.19066-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio] [PATCH] conformance: add links to crypto and input devices
To: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

VIRTIO-174

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 conformance.tex | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/conformance.tex b/conformance.tex
index ad7e82e..1577c0c 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -15,13 +15,13 @@ Conformance targets:
   \begin{itemize}
     \item Clause \ref{sec:Conformance / Driver Conformance},
     \item One of clauses \ref{sec:Conformance / Driver Conformance / PCI Driver Conformance}, \ref{sec:Conformance / Driver Conformance / MMIO Driver Conformance} or \ref{sec:Conformance / Driver Conformance / Channel I/O Driver Conformance}.
-    \item One of clauses \ref{sec:Conformance / Driver Conformance / Network Driver Conformance}, \ref{sec:Conformance / Driver Conformance / Block Driver Conformance}, \ref{sec:Conformance / Driver Conformance / Console Driver Conformance}, \ref{sec:Conformance / Driver Conformance / Entropy Driver Conformance}, \ref{sec:Conformance / Driver Conformance / Traditional Memory Balloon Driver Conformance}, \ref{sec:Conformance / Driver Conformance / SCSI Host Driver Conformance}, or \ref{sec:Conformance / Driver Conformance / Socket Driver Conformance}.
+    \item One of clauses \ref{sec:Conformance / Driver Conformance / Network Driver Conformance}, \ref{sec:Conformance / Driver Conformance / Block Driver Conformance}, \ref{sec:Conformance / Driver Conformance / Console Driver Conformance}, \ref{sec:Conformance / Driver Conformance / Entropy Driver Conformance}, \ref{sec:Conformance / Driver Conformance / Traditional Memory Balloon Driver Conformance}, \ref{sec:Conformance / Driver Conformance / SCSI Host Driver Conformance}, \ref{sec:Conformance / Driver Conformance / Input Driver Conformance}, \ref{sec:Conformance / Driver Conformance / Crypto Driver Conformance} or \ref{sec:Conformance / Driver Conformance / Socket Driver Conformance}.
   \end{itemize}
 \item[Device] A device MUST conform to three conformance clauses:
   \begin{itemize}
     \item Clause \ref{sec:Conformance / Device Conformance},
     \item One of clauses \ref{sec:Conformance / Device Conformance / PCI Device Conformance}, \ref{sec:Conformance / Device Conformance / MMIO Device Conformance} or \ref{sec:Conformance / Device Conformance / Channel I/O Device Conformance}.
-    \item One of clauses \ref{sec:Conformance / Device Conformance / Network Device Conformance}, \ref{sec:Conformance / Device Conformance / Block Device Conformance}, \ref{sec:Conformance / Device Conformance / Console Device Conformance}, \ref{sec:Conformance / Device Conformance / Entropy Device Conformance}, \ref{sec:Conformance / Device Conformance / Traditional Memory Balloon Device Conformance}, \ref{sec:Conformance / Device Conformance / SCSI Host Device Conformance}, or \ref{sec:Conformance / Device Conformance / Socket Device Conformance}.
+    \item One of clauses \ref{sec:Conformance / Device Conformance / Network Device Conformance}, \ref{sec:Conformance / Device Conformance / Block Device Conformance}, \ref{sec:Conformance / Device Conformance / Console Device Conformance}, \ref{sec:Conformance / Device Conformance / Entropy Device Conformance}, \ref{sec:Conformance / Device Conformance / Traditional Memory Balloon Device Conformance}, \ref{sec:Conformance / Device Conformance / SCSI Host Device Conformance}, \ref{sec:Conformance / Device Conformance / Input Device Conformance}, \ref{sec:Conformance / Device Conformance / Crypto Device Conformance} or \ref{sec:Conformance / Device Conformance / Socket Device Conformance}.
   \end{itemize}
 \end{description}
 
-- 
MST

---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

