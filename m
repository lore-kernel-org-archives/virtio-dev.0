Return-Path: <pankaj.gupta.linux@gmail.com>
From: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Subject: [PATCH RESEND] virtio-pmem: PMEM device spec
Date: Wed, 28 Jul 2021 17:04:35 +0200
Message-Id: <20210728150435.264551-1-pankaj.gupta.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
To: virtio-dev@lists.oasis-open.org
Cc: dan.j.williams@intel.com, david@redhat.com, mst@redhat.com, cohuck@redhat.com, tstark@linux.microsoft.com, pankaj.gupta@ionos.com, Pankaj Gupta <pankaj.gupta.linux@gmail.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Posting virtio specification for virtio pmem device. Virtio pmem is a
paravirtualized device which allows the guest to bypass page cache.
Virtio pmem kernel driver is merged in Upstream Kernel 5.3. Also, Qemu
device is merged in Qemu 4.1.

Signed-off-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
---
Sorry, It took me long time to get back on this. There is
an enhancement to this spec by "Taylor Stark" CCed in the list.
Request for feedback and merging. 

RFC is posted here [1]
[1] https://lists.oasis-open.org/archives/virtio-dev/201903/msg00083.html

 conformance.tex |  19 ++++++-
 content.tex     |   1 +
 virtio-pmem.tex | 132 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 150 insertions(+), 2 deletions(-)
 create mode 100644 virtio-pmem.tex

diff --git a/conformance.tex b/conformance.tex
index 94d7a06..818ddda 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -31,7 +31,8 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
 \ref{sec:Conformance / Driver Conformance / Sound Driver Conformance},
 \ref{sec:Conformance / Driver Conformance / Memory Driver Conformance},
 \ref{sec:Conformance / Driver Conformance / I2C Adapter Driver Conformance} or
-\ref{sec:Conformance / Driver Conformance / SCMI Driver Conformance}.
+\ref{sec:Conformance / Driver Conformance / SCMI Driver Conformance},
+\ref{sec:Conformance / Driver Conformance / PMEM Driver Conformance}.
 
     \item Clause \ref{sec:Conformance / Legacy Interface: Transitional Device and Transitional Driver Conformance}.
   \end{itemize}
@@ -55,7 +56,8 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
 \ref{sec:Conformance / Device Conformance / Sound Device Conformance},
 \ref{sec:Conformance / Device Conformance / Memory Device Conformance},
 \ref{sec:Conformance / Device Conformance / I2C Adapter Device Conformance} or
-\ref{sec:Conformance / Device Conformance / SCMI Device Conformance}.
+\ref{sec:Conformance / Device Conformance / SCMI Device Conformance},
+\ref{sec:Conformance / Device Conformance / PMEM Driver Conformance}.
 
     \item Clause \ref{sec:Conformance / Legacy Interface: Transitional Device and Transitional Driver Conformance}.
   \end{itemize}
@@ -301,6 +303,19 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
 \item \ref{drivernormative:Device Types / SCMI Device / Device Operation / Setting Up eventq Buffers}
 \end{itemize}
 
+\conformance{\subsection}{PMEM Driver Conformance}\label{sec:Conformance / Driver Conformance / PMEM Driver Conformance}
+
+A PMEM driver MUST conform to the following normative statements:
+
+\begin{itemize}
+\item \ref{devicenormative:Device Types / PMEM Device / Device Initialization}
+\item \ref{drivernormative:Device Types / PMEM Driver / Driver Initialization / Direct access}
+\item \ref{drivernormative:Device Types / PMEM Driver / Driver Initialization / Virtio flush}
+\item \ref{drivernormative:Device Types / PMEM Driver / Driver Operation / Virtqueue command}
+\item \ref{devicenormative:Device Types / PMEM Device / Device Operation / Virtqueue flush}
+\item \ref{devicenormative:Device Types / PMEM Device / Device Operation / Virtqueue return}
+\end{itemize}
+
 \conformance{\section}{Device Conformance}\label{sec:Conformance / Device Conformance}
 
 A device MUST conform to the following normative statements:
diff --git a/content.tex b/content.tex
index ceb2562..6acc785 100644
--- a/content.tex
+++ b/content.tex
@@ -6583,6 +6583,7 @@ \subsubsection{Legacy Interface: Framing Requirements}\label{sec:Device
 \input{virtio-mem.tex}
 \input{virtio-i2c.tex}
 \input{virtio-scmi.tex}
+\input{virtio-pmem.tex}
 
 \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
 
diff --git a/virtio-pmem.tex b/virtio-pmem.tex
new file mode 100644
index 0000000..a2b888e
--- /dev/null
+++ b/virtio-pmem.tex
@@ -0,0 +1,132 @@
+\section{PMEM Device}\label{sec:Device Types / PMEM Device}
+
+The virtio pmem is a fake persistent memory (NVDIMM) device
+used to bypass the guest page cache and provide a virtio
+based asynchronous flush mechanism.This avoids the need
+of a separate page cache in guest and keeps page cache only
+in the host. Under memory pressure, the host makes use of
+effecient memory reclaim decisions for page cache pages
+of all the guests. This helps to reduce the memory footprint
+and fit more guests in the host system.
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
+	le64 start;
+	le64 size;
+};
+\end{lstlisting}
+
+\begin{description}
+\item[\field{start}] contains the start address from the guest physical address range
+to be hotplugged into the guest address space using the pmem API.
+
+\item[\field{size}] contains the length of this address range.
+\end{description}
+
+\subsection{Device Initialization}\label{sec:Device Types / PMEM Device / Device Initialization}
+
+Device hotplugs physical memory to guest address space. Persistent memory device
+is emulated with file backed memory at host side.
+
+\begin{enumerate}
+\item Guest vpmem start is read from \field{start}.
+\item Guest vpmem end is read from \field{size}.
+\end{enumerate}
+
+\devicenormative{\subsubsection}{Device Initialization}{Device Types / PMEM Device / Device Initialization}
+
+File backed memory MUST be memory mapped to guest address space with SHARED
+memory mapping.
+
+\subsection{Driver Initialization}\label{sec:Device Types / PMEM Driver / Driver Initialization}
+
+Driver hotplugs the physical memory and registers associated region with the pmem API.
+Also, configures a flush callback function with the corresponding region.
+
+\drivernormative{\subsubsection}{Driver Initialization: Filesystem direct access}{Device Types / PMEM Driver / Driver Initialization / Direct access}
+
+Driver MUST enable filesystem direct access operations for read/write on the device.
+
+\drivernormative{\subsubsection}{Driver Initialization: Virtio flush}{Device Types / PMEM Driver / Driver Initialization / Virtio flush}
+
+Driver MUST implement a virtio based flush callback.
+
+Driver MUST disable other FLUSH/SYNC mechanisms for the device when virtio flush is configured.
+
+\subsection{Driver Operations}\label{sec:Device Types / PMEM Driver / Driver Operation}
+\drivernormative{\subsubsection}{Driver Operation: Virtqueue command}{Device Types / PMEM Driver / Driver Operation / Virtqueue command}
+
+Driver MUST send VIRTIO_FLUSH command on request virtqueue, allows guest userspace process to perform IO operations asynchronously.
+
+Driver SHOULD handle multiple fsync requests on files present on the device.
+
+\subsection{Device Operations}\label{sec:Device Types / PMEM Driver / Device Operation}
+
+\devicenormative{\subsubsection}{Device Operations}{Device Types / PMEM Device / Device Operation / Virtqueue flush}
+
+Device SHOULD handle multiple flush requests simultaneously using host filesystem fsync or flush call.
+
+\devicenormative{\subsubsection}{Device operations}{Device Types / PMEM Device / Device Operation / Virtqueue return}
+
+Device MUST return integer "0" for success and "-1" for failure.
+These errors are converted to corresponding error codes by guest
+as per architecture.
+
+\subsection{Possible security implications}\label{sec:Device Types / PMEM Device / Possible Security Implications}
+
+There could be potential security implications depending on how
+memory mapped host backing file is used. By default device emulation
+is done with SHARED mapping. There is a contract between guest and host
+process to access same backing file for read/write operations.
+
+If a malicious guest or host userspace map the same backing file,
+attacking process can make use of known cache side channel attacks
+to predict the current state of shared page cache page. If both
+attacker and victim somehow execute same shared code after a
+flush/evict call, with difference in execution timing attacker
+could infer another guest local data or host data. Though this is
+not easy and same challenges exist as with bare metal host system
+when userspace share same backing file.
+
+\subsection{Countermeasures}\label{sec:Device Types / PMEM Device / Possible Security Implications / Countermeasures}
+
+\subsubsection{ With SHARED mapping}\label{sec:Device Types / PMEM Device / Possible Security Implications / Countermeasures / SHARED}
+
+If device backing backing file is shared with multiple guests or host
+processes, this may act as a metric for page cache side channel attack.
+As a counter measure every guest should have its own(not shared with
+another guest) SHARED backing file and gets populated a per host process
+page cache pages.
+
+\subsubsection{ With PRIVATE mapping}\label{sec:Device Types / PMEM Device / Possible Security Implications / Countermeasures / PRIVATE}
+There maybe be chances of side channels attack with PRIVATE
+memory mapping similar to SHARED with read-only shared mappings.
+PRIVATE is not used for virtio pmem making this usecase
+irrelevant.
+
+\subsubsection{ Workload specific mapping}\label{sec:Device Types / PMEM Device / Possible Security Implications / Countermeasures / Workload}
+For SHARED mapping, if workload is single application inside
+guest and there is no risk with sharing of data between guests.
+Guest sharing same backing file with SHARED mapping can be
+used as a valid configuration.
+
+\subsubsection{ Prevent cache eviction}\label{sec:Device Types / PMEM Device / Possible Security Implications / Countermeasures / Cache eviction}
+Don't allow cache evict from guest filesystem trim/discard command
+with virtio pmem. This rules out any possibility of evict-reload
+page cache side channel attacks if backing disk is shared(SHARED)
+with mutliple guests. Though if we use per device backing file with
+shared mapping this countermeasure is not required.
-- 
2.25.1

