Return-Path: virtio-dev-return-7716-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 412A89848BB
	for <virtio-dev@lists.oasis-open.org>; Mon, 24 Aug 2020 14:38:56 +0000 (UTC)
From: Nikos Dragazis <ndragazis@arrikto.com>
Date: Mon, 24 Aug 2020 17:37:06 +0300
Message-Id: <20200824143708.5664-10-ndragazis@arrikto.com>
In-Reply-To: <20200824143708.5664-1-ndragazis@arrikto.com>
References: <20200824143708.5664-1-ndragazis@arrikto.com>
Subject: [virtio-dev] [PATCH 09/11] content: Introduce device-specific notification cfg type for PCI
Content-Type: text/plain; charset=US-ASCII
To: virtio-dev@lists.oasis-open.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
List-ID: <virtio-dev.lists.oasis-open.org>

Signed-off-by: Nikos Dragazis <ndragazis@arrikto.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 conformance.tex |  1 +
 content.tex     | 71 ++++++++++++++++++++++++++++++++++++++++---------
 2 files changed, 60 insertions(+), 12 deletions(-)

diff --git a/conformance.tex b/conformance.tex
index f02770f..e033a0d 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -252,6 +252,7 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
 \item \ref{devicenormative:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / ISR status capability}
 \item \ref{devicenormative:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Device-specific configuration}
 \item \ref{devicenormative:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Doorbell capability}
+\item \ref{devicenormative:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Device-specific Notification capability}
 \item \ref{devicenormative:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Shared memory capability}
 \item \ref{devicenormative:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / PCI configuration access capability}
 \item \ref{devicenormative:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Device Initialization / Non-transitional Device With Legacy Driver}
diff --git a/content.tex b/content.tex
index 661ebd9..7541a91 100644
--- a/content.tex
+++ b/content.tex
@@ -643,6 +643,7 @@ \subsection{Virtio Structure PCI Capabilities}\label{sec:Virtio Transport Option
 \item Device-specific configuration (optional)
 \item PCI configuration access
 \item Doorbells (optional)
+\item Device-specific notifications (optional)
 \item Shared memory regions (optional)
 \item Vendor-specific data (optional)
 \end{itemize}
@@ -702,6 +703,8 @@ \subsection{Virtio Structure PCI Capabilities}\label{sec:Virtio Transport Option
 #define VIRTIO_PCI_CAP_PCI_CFG           5
 /* Doorbells */
 #define VIRTIO_PCI_CAP_DOORBELL_CFG      6
+/* Device-specific notifications */
+#define VIRTIO_PCI_CAP_DEV_NOTIFY_CFG    7
 /* Shared memory region */
 #define VIRTIO_PCI_CAP_SHARED_MEMORY_CFG 8
 /* Vendor-specific data */
@@ -1141,6 +1144,46 @@ \subsubsection{Doorbell capability}\label{sec:Virtio Transport Options / Virtio
 where \field{max_doorbell_idx} is the maximum doorbell index and is
 dependent on the device.
 
+\subsubsection{Device-specific Notification capability}\label{sec:Virtio
+Transport Options / Virtio Over PCI Bus / PCI Device Layout / Device-specific Notification capability}
+
+The device-specific notification
+\ref{sec:Basic Facilities of a Virtio Device / Notifications} location
+is found using the VIRTIO_PCI_CAP_DEV_NOTIFY_CFG capability. The
+device-specific notification structure allows MSI-X vectors to be
+configured for notification interrupts. If MSI-X is not available, bit 2
+of the ISR status \ref{sec:Virtio Transport Options / Virtio Over PCI
+Bus / PCI Device Layout / ISR status capability} indicates that a
+device-specific notification occurred.
+
+The device-specific notification structure is the following:
+
+\begin{lstlisting}
+struct virtio_pci_notification_cfg {
+	le16 notification_select;              /* read-write */
+	le16 notification_msix_vector;         /* read-write */
+};
+\end{lstlisting}
+
+The driver indicates which notification is of interest by writing the
+\field{notification_select} field. The driver then writes the MSI-X
+vector or VIRTIO_MSI_NO_VECTOR to \field{notification_msix_vector} to
+change the MSI-X vector for that notification.
+
+The mapping between notifications and notification indices is
+device-specific. The total number of notifications is also
+device-specific.
+
+\devicenormative{\paragraph}{Device-specific Notification capability}{Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Device-specific Notification capability}
+
+Device MUST ignore writes to \field{notification_msix_vector} if the
+value written to \field{notification_select} is not a valid notification
+index.
+
+Device MUST return VIRTIO_MSI_NO_VECTOR for reads from
+\field{notification_msix_vector} if the value written to
+\field{notification_select} is not a valid notification index.
+
 \subsubsection{Shared memory capability}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Shared memory capability}
 
 Shared memory regions \ref{sec:Basic Facilities of a Virtio
@@ -1451,15 +1494,17 @@ \subsubsection{Device Initialization}\label{sec:Virtio Transport Options / Virti
 \paragraph{MSI-X Vector Configuration}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Device Initialization / MSI-X Vector Configuration}
 
 When MSI-X capability is present and enabled in the device
-(through standard PCI configuration space) \field{config_msix_vector} and \field{queue_msix_vector} are used to map configuration change and queue
-interrupts to MSI-X vectors. In this case, the ISR Status is unused.
+(through standard PCI configuration space) \field{config_msix_vector},
+\field{queue_msix_vector} and \field{notification_msix_vector} are used
+to map configuration change, queue and device-specific interrupts to
+MSI-X vectors respectively. In this case, the ISR Status is unused.
 
 Writing a valid MSI-X Table entry number, 0 to 0x7FF, to
-\field{config_msix_vector}/\field{queue_msix_vector} maps interrupts triggered
-by the configuration change/selected queue events respectively to
-the corresponding MSI-X vector. To disable interrupts for an
-event type, the driver unmaps this event by writing a special NO_VECTOR
-value:
+\field{config_msix_vector}/\field{queue_msix_vector}/\field{notification_msix_vector}
+maps interrupts triggered by the configuration change/selected
+queue/device-specific events respectively to the corresponding MSI-X
+vector. To disable interrupts for an event type, the driver unmaps this
+event by writing a special NO_VECTOR value:
 
 \begin{lstlisting}
 /* Vector value used to disable MSI for queue */
@@ -1486,16 +1531,18 @@ \subsubsection{Device Initialization}\label{sec:Virtio Transport Options / Virti
 vector 0 to MSI-X \field{Table Size}.
 Device MUST support unmapping any event type.
 
-The device MUST return vector mapped to a given event,
-(NO_VECTOR if unmapped) on read of \field{config_msix_vector}/\field{queue_msix_vector}.
-The device MUST have all queue and configuration change
-events are unmapped upon reset.
+The device MUST return the vector mapped to a given event,
+(NO_VECTOR if unmapped) on read of
+\field{config_msix_vector}/\field{queue_msix_vector}/\field{notification_msix_vector}.
+The device MUST have all queue/configuration change/device-specific
+events unmapped upon reset.
 
 Devices SHOULD NOT cause mapping an event to vector to fail
 unless it is impossible for the device to satisfy the mapping
 request.  Devices MUST report mapping
 failures by returning the NO_VECTOR value when the relevant
-\field{config_msix_vector}/\field{queue_msix_vector} field is read. 
+\field{config_msix_vector}/\field{queue_msix_vector}/\field{notification_msix_vector}
+field is read.
 
 \drivernormative{\subparagraph}{MSI-X Vector Configuration}{Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Device Initialization / MSI-X Vector Configuration}
 
-- 
2.17.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

