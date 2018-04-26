Return-Path: virtio-return-3094-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
From: Halil Pasic <pasic@linux.ibm.com>
Date: Thu, 26 Apr 2018 13:00:00 +0200
In-Reply-To: <1524740402-18934-1-git-send-email-pasic@linux.ibm.com>
References: <1524740402-18934-1-git-send-email-pasic@linux.ibm.com>
Message-Id: <1524740402-18934-5-git-send-email-pasic@linux.ibm.com>
Subject: [virtio] [PATCH 4/6] pci: map common notifications terminology to PCI
To: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Pawel Moll <pawel.moll@arm.com>, Halil Pasic <pasic@linux.ibm.com>
List-ID: <virtio-dev.lists.oasis-open.org>

The various notifications are introduced and specified in the common
(i.e. transport agnostic) portion of this specification. How
notifications are realised for a given transport is something each
transport has to specify.

Let's make the relationship between the PCI terms and the common
terms more obvious.

Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
---
 conformance.tex |    2 +-
 content.tex     |   13 +++++++------
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/conformance.tex b/conformance.tex
index de33396..29969f1 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -180,7 +180,7 @@ A PCI device MUST conform to the following normative statements:
 \item \ref{devicenormative:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / PCI configuration access capability}
 \item \ref{devicenormative:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Device Initialization / Non-transitional Device With Legacy Driver}
 \item \ref{devicenormative:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Device Initialization / MSI-X Vector Configuration}
-\item \ref{devicenormative:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Virtqueue Interrupts From The Device}
+\item \ref{devicenormative:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Used Buffer Notifications}
 \item \ref{devicenormative:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Notification of Device Configuration Changes}
 \end{itemize}
 
diff --git a/content.tex b/content.tex
index e5b2499..ffd0c94 100644
--- a/content.tex
+++ b/content.tex
@@ -941,7 +941,7 @@ causes the device to de-assert the interrupt.
 In this way, driver read of ISR status causes the device to de-assert
 an interrupt.
 
-See sections \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Virtqueue Interrupts From The Device} and \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Notification of Device Configuration Changes} for how this is used.
+See sections \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Used Buffer Notifications} and \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Notification of Device Configuration Changes} for how this is used.
 
 \devicenormative{\paragraph}{ISR status capability}{Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / ISR status capability}
 
@@ -1306,14 +1306,15 @@ enough to ensure that the separate parts of the virtqueue are on
 separate cache lines.
 }.  There was no mechanism to negotiate the queue size.
 
-\subsubsection{Notifying The Device}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Notifying The Device}
+\subsubsection{Available Buffer Notifications}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Available Buffer Notifications}
 
-The driver notifies the device by writing the 16-bit virtqueue index
+The driver sends an available buffer notification the device by writing
+the 16-bit virtqueue index
 of this virtqueue to the Queue Notify address.  See \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Notification capability} for how to calculate this address.
 
-\subsubsection{Virtqueue Interrupts From The Device}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Virtqueue Interrupts From The Device}
+\subsubsection{Used Buffer Notifications}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Used Buffer Notifications}
 
-If an interrupt is necessary for a virtqueue, the device would typically act as follows:
+If an used buffer notification is necessary for a virtqueue, the device would typically act as follows:
 
 \begin{itemize}
   \item If MSI-X capability is disabled:
@@ -1332,7 +1333,7 @@ If an interrupt is necessary for a virtqueue, the device would typically act as
     \end{enumerate}
 \end{itemize}
 
-\devicenormative{\paragraph}{Virtqueue Interrupts From The Device}{Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Virtqueue Interrupts From The Device}
+\devicenormative{\paragraph}{Used Buffer Notifications}{Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Used Buffer Notifications}
 
 If MSI-X capability is enabled and \field{queue_msix_vector} is
 NO_VECTOR for a virtqueue, the device MUST NOT deliver an interrupt
-- 
1.7.1


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

