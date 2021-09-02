Return-Path: <pankaj.gupta.linux@gmail.com>
From: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Subject: [PATCH v3] virtio-pmem: PMEM device spec
Date: Thu,  2 Sep 2021 07:40:33 +0200
Message-Id: <20210902054033.75455-1-pankaj.gupta.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
To: virtio-dev@lists.oasis-open.org
Cc: stefanha@redhat.com, dan.j.williams@intel.com, david@redhat.com, mst@redhat.com, cohuck@redhat.com, tstark@linux.microsoft.com, pankaj.gupta@ionos.com, Pankaj Gupta <pankaj.gupta.linux@gmail.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Posting virtio specification for virtio pmem device. Virtio pmem is a
paravirtualized device which allows the guest to bypass page cache.
Virtio pmem kernel driver is merged in Upstream Kernel 5.3. Also, Qemu
device is merged in Qemu 4.1.

Signed-off-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
---

v2->v3:
- Suggested text changes - Stefan
- Removed Virtio flush command details from conformance section
  {Cornelia, Stefan}
- More generic security text - Cornelia

 conformance.tex |  16 ++++++-
 content.tex     |   1 +
 virtio-pmem.tex | 122 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 137 insertions(+), 2 deletions(-)
 create mode 100644 virtio-pmem.tex

diff --git a/conformance.tex b/conformance.tex
index 94d7a06..7331003 100644
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
@@ -301,6 +303,16 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
 \item \ref{drivernormative:Device Types / SCMI Device / Device Operation / Setting Up eventq Buffers}
 \end{itemize}
 
+\conformance{\subsection}{PMEM Driver Conformance}\label{sec:Conformance / Driver Conformance / PMEM Driver Conformance}
+
+A PMEM driver MUST conform to the following normative statements:
+
+\begin{itemize}
+\item \ref{devicenormative:Device Types / PMEM Device / Device Initialization}
+\item \ref{devicenormative:Device Types / PMEM Device / Device Operation / Virtqueue flush}
+\item \ref{devicenormative:Device Types / PMEM Device / Device Operation / Virtqueue return}
+\end{itemize}
+
 \conformance{\section}{Device Conformance}\label{sec:Conformance / Device Conformance}
 
 A device MUST conform to the following normative statements:
diff --git a/content.tex b/content.tex
index 31b02e1..08d4a92 100644
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
index 0000000..6f1b504
--- /dev/null
+++ b/virtio-pmem.tex
@@ -0,0 +1,122 @@
+\section{PMEM Device}\label{sec:Device Types / PMEM Device}
+
+The virtio pmem device is a persistent memory (NVDIMM) device
+that provides a virtio based asynchronous flush mechanism. This avoids
+the need of a separate page cache in the guest and keeps the page cache
+only in the host. Under memory pressure, the host makes use of
+efficient memory reclaim decisions for page cache pages of all the
+guests. This helps to reduce the memory footprint and fits more guests
+in the host system.
+
+The virtio pmem device provides access to byte-addressable persistent
+memory. The persist memory is directly accessible range of system memory.
+Data written to this memory is made persistent by separately sending a
+flush command. Writes that have been flushed are preserved across device
+reset and power failure.
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
+\item[\field{start}] contains the physical address of the first byte of the persistent memory region.
+
+\item[\field{size}] contains the length of this address range.
+\end{description}
+
+\begin{enumerate}
+\item Driver vpmem start is read from \field{start}.
+\item Driver vpmem end is read from \field{size}.
+\end{enumerate}
+
+\subsection{Driver Initialization}\label{sec:Device Types / PMEM Driver / Driver Initialization}
+
+The driver determines the start address and size of the persistent memory region in preparation for reading or writing data.
+
+The driver initializes req_vq in preparation for making flush requests.
+
+\subsection{Driver Operations}\label{sec:Device Types / PMEM Driver / Driver Operation / Request Queues}
+
+Requests have the following format:
+
+\begin{lstlisting}
+struct virtio_pmem_req {
+        le32 type;
+};
+\end{lstlisting}
+
+\field{type} is the request command type. 
+
+\subsection{Device Operations}\label{sec:Device Types / PMEM Driver / Device Operation}
+\devicenormative{\subsubsection}{Device Operation: Virtqueue flush}{Device Types / PMEM Device / Device Operation / Virtqueue flush}
+
+The device MUST ensure that all writes made before a flush request will persist across device reset and power failure before completing the flush request.
+
+\subsubsection{Device Operations}\label{sec:Device Types / PMEM Driver / Device Operation / Virtqueue return}
+\begin{lstlisting}
+struct virtio_pmem_resp {
+        le32 ret;
+};
+\end{lstlisting}
+
+\field{ret} is the value which device returns after command completion.
+
+\devicenormative{\subsubsection}{Device Operation: Virtqueue return}{Device Types / PMEM Device / Device Operation / Virtqueue return}
+
+The device MUST return "0" for success and "-1" for failure.
+
+\subsection{Possible security implications}\label{sec:Device Types / PMEM Device / Possible Security Implications}
+
+There could be potential security implications depending on how
+memory mapped backing device is used. By default device emulation
+is done with SHARED memory mapping. There is a contract between driver
+and device to access shared memory region for read or write operations.
+
+If a malicious driver or device map the same memory region, the attacker
+can make use of known side channel attacks to predict the current state of data.
+If both attacker and victim somehow execute same shared code after a flush
+or evict operation, with difference in execution timing attacker could infer
+another device data.
+
+\subsection{Countermeasures}\label{sec:Device Types / PMEM Device / Possible Security Implications / Countermeasures}
+
+\subsubsection{ With SHARED mapping}\label{sec:Device Types / PMEM Device / Possible Security Implications / Countermeasures / SHARED}
+
+If device backing region is shared between multiple devices, this may act
+as a metric for side channel attack. As a counter measure every device
+should have its own(not shared with another driver) SHARED backing memory.
+
+\subsubsection{ With PRIVATE mapping}\label{sec:Device Types / PMEM Device / Possible Security Implications / Countermeasures / PRIVATE}
+There maybe be chances of side channels attack with PRIVATE
+memory mapping similar to SHARED with read-only shared mappings.
+PRIVATE is not used for virtio pmem making this usecase
+irrelevant.
+
+\subsubsection{ Workload specific mapping}\label{sec:Device Types / PMEM Device / Possible Security Implications / Countermeasures / Workload}
+For SHARED mapping, if workload is single application inside
+the driver and there is no risk in sharing data. Device sharing
+same backing region with SHARED mapping can be used as a valid configuration.
+
+\subsubsection{ Prevent cache eviction}\label{sec:Device Types / PMEM Device / Possible Security Implications / Countermeasures / Cache eviction}
+Don't allow device shared region evict from driver filesystem trim or discard 
+like commands with virtio pmem. This rules out any possibility of evict-reload
+cache side channel attacks if backing region is shared(SHARED)
+between mutliple devices. Though if we use per device backing file with
+shared mapping this countermeasure is not required.
-- 
2.25.1

