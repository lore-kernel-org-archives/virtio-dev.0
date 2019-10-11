Return-Path: virtio-dev-return-6223-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A4850985DBE
	for <virtio-dev@lists.oasis-open.org>; Fri, 11 Oct 2019 09:42:11 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri, 11 Oct 2019 10:42:03 +0100
Message-Id: <20191011094203.5692-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] [PATCH] pci: use msix_config instead of config_msix_vector
To: virtio-dev@lists.oasis-open.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

The struct virtio_pci_common_cfg field is called msix_config but the
text refers to this field as config_msix_vector.  This is confusing.

Rename config_msix_vector to msix_config.  Although config_msix_vector
is arguably a clearer name, existing code using Linux virtio_pci.h uses
msix_config so let's stick with that.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/41
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
Note that Paolo already submitted a patch for the other approach and I
even reviewed it:
https://lists.oasis-open.org/archives/virtio/201903/msg00073.html

Either way, let's merge a fix!
---
 content.tex | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/content.tex b/content.tex
index 679391e..ae0b790 100644
--- a/content.tex
+++ b/content.tex
@@ -843,7 +843,7 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
         The driver writes this to accept feature bits offered by the device.
         Driver Feature Bits selected by \field{driver_feature_select}.
 
-\item[\field{config_msix_vector}]
+\item[\field{msix_config}]
         The driver sets the Configuration Vector for MSI-X.
 
 \item[\field{num_queues}]
@@ -1202,7 +1202,7 @@ \subsubsection{Legacy Interfaces: A Note on PCI Device Layout}\label{sec:Virtio
 \hline
 Read/Write & R+W            & R+W    \\
 \hline
-Purpose (MSI-X) & \field{config_msix_vector}  & \field{queue_msix_vector} \\
+Purpose (MSI-X) & \field{msix_config}  & \field{queue_msix_vector} \\
 \hline
 \end{tabular}
 
@@ -1323,11 +1323,11 @@ \subsubsection{Device Initialization}\label{sec:Virtio Transport Options / Virti
 \paragraph{MSI-X Vector Configuration}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Device Initialization / MSI-X Vector Configuration}
 
 When MSI-X capability is present and enabled in the device
-(through standard PCI configuration space) \field{config_msix_vector} and \field{queue_msix_vector} are used to map configuration change and queue
+(through standard PCI configuration space) \field{msix_config} and \field{queue_msix_vector} are used to map configuration change and queue
 interrupts to MSI-X vectors. In this case, the ISR Status is unused.
 
 Writing a valid MSI-X Table entry number, 0 to 0x7FF, to
-\field{config_msix_vector}/\field{queue_msix_vector} maps interrupts triggered
+\field{msix_config}/\field{queue_msix_vector} maps interrupts triggered
 by the configuration change/selected queue events respectively to
 the corresponding MSI-X vector. To disable interrupts for an
 event type, the driver unmaps this event by writing a special NO_VECTOR
@@ -1359,7 +1359,7 @@ \subsubsection{Device Initialization}\label{sec:Virtio Transport Options / Virti
 Device MUST support unmapping any event type.
 
 The device MUST return vector mapped to a given event,
-(NO_VECTOR if unmapped) on read of \field{config_msix_vector}/\field{queue_msix_vector}.
+(NO_VECTOR if unmapped) on read of \field{msix_config}/\field{queue_msix_vector}.
 The device MUST have all queue and configuration change
 events are unmapped upon reset.
 
@@ -1367,7 +1367,7 @@ \subsubsection{Device Initialization}\label{sec:Virtio Transport Options / Virti
 unless it is impossible for the device to satisfy the mapping
 request.  Devices MUST report mapping
 failures by returning the NO_VECTOR value when the relevant
-\field{config_msix_vector}/\field{queue_msix_vector} field is read. 
+\field{msix_config}/\field{queue_msix_vector} field is read. 
 
 \drivernormative{\subparagraph}{MSI-X Vector Configuration}{Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Device Initialization / MSI-X Vector Configuration}
 
@@ -1485,9 +1485,9 @@ \subsubsection{Notification of Device Configuration Changes}\label{sec:Virtio Tr
 
   \item If MSI-X capability is enabled:
     \begin{enumerate}
-    \item If \field{config_msix_vector} is not NO_VECTOR,
+    \item If \field{msix_config} is not NO_VECTOR,
       request the appropriate MSI-X interrupt message for the
-      device, \field{config_msix_vector} sets the MSI-X Table entry
+      device, \field{msix_config} sets the MSI-X Table entry
       number.
     \end{enumerate}
 \end{itemize}
@@ -1497,7 +1497,7 @@ \subsubsection{Notification of Device Configuration Changes}\label{sec:Virtio Tr
 
 \devicenormative{\paragraph}{Notification of Device Configuration Changes}{Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Notification of Device Configuration Changes}
 
-If MSI-X capability is enabled and \field{config_msix_vector} is
+If MSI-X capability is enabled and \field{msix_config} is
 NO_VECTOR, the device MUST NOT deliver an interrupt
 for device configuration space changes.
 
@@ -1527,7 +1527,7 @@ \subsubsection{Driver Handling Interrupts}\label{sec:Virtio Transport Options /
         device, to see if any progress has been made by the device
         which requires servicing.
       \item
-        If the MSI-X vector is equal to \field{config_msix_vector},
+        If the MSI-X vector is equal to \field{msix_config},
         re-examine the configuration space to see what changed.
     \end{itemize}
 \end{itemize}
-- 
2.21.0


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

