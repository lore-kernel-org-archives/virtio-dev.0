Return-Path: virtio-dev-return-7713-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 38EA5985A17
	for <virtio-dev@lists.oasis-open.org>; Mon, 24 Aug 2020 14:38:55 +0000 (UTC)
From: Nikos Dragazis <ndragazis@arrikto.com>
Date: Mon, 24 Aug 2020 17:37:03 +0300
Message-Id: <20200824143708.5664-7-ndragazis@arrikto.com>
In-Reply-To: <20200824143708.5664-1-ndragazis@arrikto.com>
References: <20200824143708.5664-1-ndragazis@arrikto.com>
Subject: [virtio-dev] [PATCH 06/11] content: Introduce Doorbell cfg type for PCI
Content-Type: text/plain; charset=US-ASCII
To: virtio-dev@lists.oasis-open.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
List-ID: <virtio-dev.lists.oasis-open.org>

Signed-off-by: Nikos Dragazis <ndragazis@arrikto.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 conformance.tex |  1 +
 content.tex     | 50 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/conformance.tex b/conformance.tex
index b6fdec0..f02770f 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -251,6 +251,7 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
 \item \ref{devicenormative:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Notification capability}
 \item \ref{devicenormative:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / ISR status capability}
 \item \ref{devicenormative:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Device-specific configuration}
+\item \ref{devicenormative:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Doorbell capability}
 \item \ref{devicenormative:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Shared memory capability}
 \item \ref{devicenormative:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / PCI configuration access capability}
 \item \ref{devicenormative:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Device Initialization / Non-transitional Device With Legacy Driver}
diff --git a/content.tex b/content.tex
index 38ed709..628265e 100644
--- a/content.tex
+++ b/content.tex
@@ -636,6 +636,7 @@ \subsection{Virtio Structure PCI Capabilities}\label{sec:Virtio Transport Option
 \item ISR Status
 \item Device-specific configuration (optional)
 \item PCI configuration access
+\item Doorbells (optional)
 \item Shared memory regions (optional)
 \item Vendor-specific data (optional)
 \end{itemize}
@@ -693,6 +694,8 @@ \subsection{Virtio Structure PCI Capabilities}\label{sec:Virtio Transport Option
 #define VIRTIO_PCI_CAP_DEVICE_CFG        4
 /* PCI configuration access */
 #define VIRTIO_PCI_CAP_PCI_CFG           5
+/* Doorbells */
+#define VIRTIO_PCI_CAP_DOORBELL_CFG      6
 /* Shared memory region */
 #define VIRTIO_PCI_CAP_SHARED_MEMORY_CFG 8
 /* Vendor-specific data */
@@ -1085,6 +1088,53 @@ \subsubsection{Device-specific configuration}\label{sec:Virtio Transport Options
 
 The \field{offset} for the device-specific configuration MUST be 4-byte aligned.
 
+\subsubsection{Doorbell capability}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Doorbell capability}
+
+The doorbell \ref{sec:Basic Facilities of a Virtio device / Doorbells}
+location is found using the VIRTIO_PCI_CAP_DOORBELL_CFG capability. This
+capability is immediately followed by an additional field, like so:
+
+\begin{lstlisting}
+struct virtio_pci_doorbell_cap {
+        struct virtio_pci_cap cap;
+        le32 doorbell_off_multiplier;
+};
+\end{lstlisting}
+
+The doorbell address within a BAR is calculated as follows:
+
+\begin{lstlisting}
+        cap.offset + doorbell_idx * doorbell_off_multiplier
+\end{lstlisting}
+
+The \field{cap.offset} and \field{doorbell_off_multiplier} are taken
+from the doorbell capability structure above, and the
+\field{doorbell_idx} is the doorbell index. There is no restriction for
+the mapping between doorbells and doorbell indices. The mapping is
+device-specific. One possible mapping would be to use the integers 0 to
+N-1 as the doorbell indices for a total of N doorbells. The total number
+of doorbells exposed by the device is also device-specific.
+
+\devicenormative{\paragraph}{Doorbell capability}{Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Doorbell capability}
+
+The \field{cap.offset} MUST be 2-byte aligned.
+
+The device MUST either present \field{doorbell_off_multiplier} as an
+even power of 2, or present \field{doorbell_off_multiplier} as 0.
+
+The value \field{cap.length} presented by the device MUST be at least 2
+and MUST be large enough to support doorbell offsets for all supported
+doorbells in all possible configurations.
+
+The value \field{cap.length} presented by the device MUST satisfy:
+
+\begin{lstlisting}
+cap.length >= max_doorbell_idx * doorbell_off_multiplier + 2
+\end{lstlisting}
+
+where \field{max_doorbell_idx} is the maximum doorbell index and is
+dependent on the device.
+
 \subsubsection{Shared memory capability}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Shared memory capability}
 
 Shared memory regions \ref{sec:Basic Facilities of a Virtio
-- 
2.17.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

