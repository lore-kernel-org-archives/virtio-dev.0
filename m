Return-Path: virtio-dev-return-5833-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4F028984D9D
	for <virtio-dev@lists.oasis-open.org>; Tue,  9 Jul 2019 08:12:06 +0000 (UTC)
From: Pankaj Gupta <pagupta@redhat.com>
Date: Tue,  9 Jul 2019 13:41:34 +0530
Message-Id: <20190709081134.9156-1-pagupta@redhat.com>
Subject: [virtio-dev] [PATCH] add virtio-pmem device spec
To: virtio-dev@lists.oasis-open.org
Cc: mst@redhat.com, stefanha@redhat.com, cohuck@redhat.com, lcapitulino@redhat.com, riel@surriel.com, aarcange@redhat.com, david@redhat.com, nilal@redhat.com, pagupta@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

This patch proposes a virtio specification for new
virtio pmem device. Virtio pmem is a paravirtualized
device which solves two problems:

- Provides emulation of persistent memory on host regular
  (non NVDIMM) storage.
- Allows the guest to bypass the page cache.

This is changed version from previous RFC [1], incorporated
changes suggested by Stefan, Michael & Cornerlia.

[1] https://lists.oasis-open.org/archives/virtio-dev/201903/msg00083.html

Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
---
 conformance.tex |  23 ++++++++++-
 content.tex     |   1 +
 virtio-pmem.tex | 118 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 140 insertions(+), 2 deletions(-)
 create mode 100644 virtio-pmem.tex

diff --git a/conformance.tex b/conformance.tex
index 42f702a..7f80558 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -15,14 +15,14 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
   \begin{itemize}
     \item Clause \ref{sec:Conformance / Driver Conformance}.
     \item One of clauses \ref{sec:Conformance / Driver Conformance / PCI Driver Conformance}, \ref{sec:Conformance / Driver Conformance / MMIO Driver Conformance} or \ref{sec:Conformance / Driver Conformance / Channel I/O Driver Conformance}.
-    \item One of clauses \ref{sec:Conformance / Driver Conformance / Network Driver Conformance}, \ref{sec:Conformance / Driver Conformance / Block Driver Conformance}, \ref{sec:Conformance / Driver Conformance / Console Driver Conformance}, \ref{sec:Conformance / Driver Conformance / Entropy Driver Conformance}, \ref{sec:Conformance / Driver Conformance / Traditional Memory Balloon Driver Conformance}, \ref{sec:Conformance / Driver Conformance / SCSI Host Driver Conformance}, \ref{sec:Conformance / Driver Conformance / Input Driver Conformance}, \ref{sec:Conformance / Driver Conformance / Crypto Driver Conformance} or \ref{sec:Conformance / Driver Conformance / Socket Driver Conformance}.
+    \item One of clauses \ref{sec:Conformance / Driver Conformance / Network Driver Conformance}, \ref{sec:Conformance / Driver Conformance / Block Driver Conformance}, \ref{sec:Conformance / Driver Conformance / Console Driver Conformance}, \ref{sec:Conformance / Driver Conformance / Entropy Driver Conformance}, \ref{sec:Conformance / Driver Conformance / Traditional Memory Balloon Driver Conformance}, \ref{sec:Conformance / Driver Conformance / SCSI Host Driver Conformance}, \ref{sec:Conformance / Driver Conformance / Input Driver Conformance}, \ref{sec:Conformance / Driver Conformance / Crypto Driver Conformance}, \ref{sec:Conformance / Driver Conformance / Socket Driver Conformance} or \ref{sec:Conformance / Driver Conformance / PMEM Driver Conformance}.
     \item Clause \ref{sec:Conformance / Legacy Interface: Transitional Device and Transitional Driver Conformance}.
   \end{itemize}
 \item[Device] A device MUST conform to four conformance clauses:
   \begin{itemize}
     \item Clause \ref{sec:Conformance / Device Conformance}.
     \item One of clauses \ref{sec:Conformance / Device Conformance / PCI Device Conformance}, \ref{sec:Conformance / Device Conformance / MMIO Device Conformance} or \ref{sec:Conformance / Device Conformance / Channel I/O Device Conformance}.
-    \item One of clauses \ref{sec:Conformance / Device Conformance / Network Device Conformance}, \ref{sec:Conformance / Device Conformance / Block Device Conformance}, \ref{sec:Conformance / Device Conformance / Console Device Conformance}, \ref{sec:Conformance / Device Conformance / Entropy Device Conformance}, \ref{sec:Conformance / Device Conformance / Traditional Memory Balloon Device Conformance}, \ref{sec:Conformance / Device Conformance / SCSI Host Device Conformance}, \ref{sec:Conformance / Device Conformance / Input Device Conformance}, \ref{sec:Conformance / Device Conformance / Crypto Device Conformance} or \ref{sec:Conformance / Device Conformance / Socket Device Conformance}.
+    \item One of clauses \ref{sec:Conformance / Device Conformance / Network Device Conformance}, \ref{sec:Conformance / Device Conformance / Block Device Conformance}, \ref{sec:Conformance / Device Conformance / Console Device Conformance}, \ref{sec:Conformance / Device Conformance / Entropy Device Conformance}, \ref{sec:Conformance / Device Conformance / Traditional Memory Balloon Device Conformance}, \ref{sec:Conformance / Device Conformance / SCSI Host Device Conformance}, \ref{sec:Conformance / Device Conformance / Input Device Conformance}, \ref{sec:Conformance / Device Conformance / Crypto Device Conformance}, \ref{sec:Conformance / Device Conformance / Socket Device Conformance} or \ref{sec:Conformance / Device Conformance / PMEM Device Conformance}.
     \item Clause \ref{sec:Conformance / Legacy Interface: Transitional Device and Transitional Driver Conformance}.
   \end{itemize}
 \end{description}
@@ -183,6 +183,15 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
 \item \ref{drivernormative:Device Types / Socket Device / Device Operation / Device Events}
 \end{itemize}
 
+\conformance{\subsection}{PMEM Driver Conformance}\label{sec:Conformance / Driver Conformance / PMEM Driver Conformance}
+
+A PMEM driver MUST conform to the following normative statements:
+
+\begin{itemize}
+\item \ref{drivernormative:Device Types / PMEM Driver / Driver Initialization / flush callback}
+\item \ref{drivernormative:Device Types / PMEM Driver / Driver Operation / Virtqueue command}
+\end{itemize}
+
 \conformance{\section}{Device Conformance}\label{sec:Conformance / Device Conformance}
 
 A device MUST conform to the following normative statements:
@@ -336,6 +345,16 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
 \item \ref{devicenormative:Device Types / Socket Device / Device Operation / Receive and Transmit}
 \end{itemize}
 
+\conformance{\subsection}{PMEM Device Conformance}\label{sec:Conformance / Device Conformance / PMEM Device Conformance}
+
+A PMEM device MUST conform to the following normative statements:
+
+\begin{itemize}
+\item \ref{devicenormative:Device Types / PMEM Device / Device Initialization}
+\item \ref{devicenormative:Device Types / PMEM Device / Device Operation / Virtqueue flush}
+\item \ref{devicenormative:Device Types / PMEM Device / Device Operation / Virtqueue return}
+\end{itemize}
+
 \conformance{\section}{Legacy Interface: Transitional Device and Transitional Driver Conformance}\label{sec:Conformance / Legacy Interface: Transitional Device and Transitional Driver Conformance}
 A conformant implementation MUST be either transitional or
 non-transitional, see \ref{intro:Legacy
diff --git a/content.tex b/content.tex
index 8f0498e..28e747c 100644
--- a/content.tex
+++ b/content.tex
@@ -5598,6 +5598,7 @@ \subsubsection{Legacy Interface: Framing Requirements}\label{sec:Device
 \input{virtio-input.tex}
 \input{virtio-crypto.tex}
 \input{virtio-vsock.tex}
+\input{virtio-pmem.tex}
 
 \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
 
diff --git a/virtio-pmem.tex b/virtio-pmem.tex
new file mode 100644
index 0000000..fa64c6b
--- /dev/null
+++ b/virtio-pmem.tex
@@ -0,0 +1,118 @@
+\section{PMEM Device}\label{sec:Device Types / PMEM Device}
+
+virtio pmem is an emulated persistent memory device. The 
+device is plugged to the guest using virtio bus.
+
+Device works as fake nvdimm device when emulated on host regular
+(non NVDIMM) device. Device provides a virtio based asynchronous
+flush mechanism to persists the guest writes. This avoids the 
+need of separate caching inside the guest and host side caching
+is used. Under memory pressure, host makes efficient memory reclaim
+decisions on uniform view of memory.
+
+\subsection{Device ID}\label{sec:Device Types / PMEM Device / Device ID}
+  27
+
+\subsection{Virtqueues}\label{sec:Device Types / PMEM Device / Virtqueues}
+\begin{description}
+\item[0] req_vq
+\end{description}
+
+\subsection{Feature bits}\label{sec:Device Types / PMEM Device / Feature bits}
+
+There are currently no feature bits defined for this device.
+
+\subsection{Device configuration layout}\label{sec:Device Types / PMEM Device / Device configuration layout}
+
+\begin{lstlisting}
+struct virtio_pmem_config {
+	uint64_t start;
+	uint64_t size;
+};
+\end{lstlisting}
+
+\field{start} contains the physical address of the start of the persistent memory range.
+\field{size} in bytes length of address range.
+
+\subsection{Device Initialization}\label{sec:Device Types / PMEM Device / Device Initialization}
+
+Device hot-plugs physical memory to guest address space. Persistent memory device
+is emulated at host side.
+
+\begin{enumerate}
+  \item The driver reads the physical start address from \field{start}.
+  \item The driver reads the length of the persistent memory range from \field{size}.
+  \end{enumerate}
+
+\devicenormative{\subsubsection}{Device Initialization}{Device Types / PMEM Device / Device Initialization}
+
+Host memory region MUST be mapped to guest address space in a 
+way so that updates are visible to other processes mapping the
+same memory region. 
+
+\subsection{Driver Initialization}\label{sec:Device Types / PMEM Driver / Driver Initialization}
+
+Memory stores to the persistent memory range are not guaranteed to be
+persistent without further action. An explicit flush command is
+required to ensure persistence. The req_vq is used to perform flush
+commands.
+
+\drivernormative{\subsubsection}{Driver Initialization: flush callback}{Device Types / PMEM Driver / Driver Initialization / flush callback}
+
+Driver MUST implement a virtio based flush callback, otherwise driver
+will fail to register.
+
+\subsection{Driver Operations}\label{sec:Device Types / PMEM Driver / Driver Operation}
+
+The VIRTIO_PMEM_REQ_TYPE_FLUSH command persists memory writes that were performed
+before the command was submitted. Once the command completes the
+writes are guaranteed to be persistent.
+
+\drivernormative{\subsubsection}{Driver Operation: Virtqueue command}{Device Types / PMEM Driver / Driver Operation / Virtqueue command}
+
+The driver MUST submit a VIRTIO_PMEM_REQ_TYPE_FLUSH command after performing
+memory writes that require persistence.
+
+The driver MUST wait for the VIRTIO_PMEM_REQ_TYPE_FLUSH command to complete before
+assuming previous writes are persistent.
+
+\subsection{Device Operations}\label{sec:Device Types / PMEM Driver / Device Operation}
+
+\devicenormative{\subsubsection}{Device Operations: Virtqueue flush}{Device Types / PMEM Device / Device Operation / Virtqueue flush}
+
+Device SHOULD handle multiple flush requests simultaneously using
+corresponding host flush mechanisms.
+
+\devicenormative{\subsubsection}{Device operations: Virtqueue return}{Device Types / PMEM Device / Device Operation / Virtqueue return}
+
+Device SHOULD return integer '0' for success and '1' for failure.
+These errors are converted to corresponding error codes by guest as
+per architecture.
+
+\subsection{Possible security implications}\label{sec:Device Types / PMEM Device / Possible Security Implications}
+
+If two devices actually share the same memory, this creates a 
+potential information leak as access patterns of one driver could
+be observable by another driver.
+
+This can happen for example if two devices are implemented in software
+by a hyper-visor, and two drivers are parts of VMs running on the 
+hyper-visor. In this case, the timing of access to device memory
+might leak information about access patterns from one VM to another.
+
+This can include, but might not be limited to:
+\begin{enumerate}
+\item Configurations sharing a single region of device memory (even in a read-only configuration)
+\item Configurations with a shared cache between devices (e.g. linux page cache)
+\item Configurations with memory deduplication techniques such as KSM similar side-channels 
+ might be present if the device memory is shared with another system, e.g. information about
+ the hyper-visor/host page cache might leak into a VM guest.
+\end{enumerate}
+
+\subsection{Countermeasures}\label{sec:Device Types / PMEM Device / Possible Security Implications / Countermeasures}
+Solution is to avoid sharing resources between devices.
+\begin{enumerate}
+\item Each VM must have its own device memory, not shared with any other VM or process. 
+\item If VM workload is a special application and there is no risk, its okay to share the device memory.  
+\item Don't allow host cache eviction from VM when device memory is shared with other VM or host process. 
+\end{enumerate}
-- 
2.14.5


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

