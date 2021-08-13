Return-Path: <pankaj.gupta.linux@gmail.com>
From: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Subject: [PATCH v2] virtio-pmem: PMEM device spec
Date: Fri, 13 Aug 2021 11:52:16 +0200
Message-Id: <20210813095216.487591-1-pankaj.gupta.linux@gmail.com>
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
changes from v1 -> v2
-----------------------
Thanks to Cornelia, Stefan & David for the v1 review.
- Use device & driver name instead of host & guest.
- Remove implementation details from the spec.
- Define FLUSH_REQUEST.
- Other suggested changes.

 conformance.tex |  18 ++++++-
 content.tex     |   1 +
 virtio-pmem.tex | 128 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 145 insertions(+), 2 deletions(-)
 create mode 100644 virtio-pmem.tex

diff --git a/conformance.tex b/conformance.tex
index 94d7a06..822eaa5 100644
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
@@ -301,6 +303,18 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
 \item \ref{drivernormative:Device Types / SCMI Device / Device Operation / Setting Up eventq Buffers}
 \end{itemize}
 
+\conformance{\subsection}{PMEM Driver Conformance}\label{sec:Conformance / Driver Conformance / PMEM Driver Conformance}
+
+A PMEM driver MUST conform to the following normative statements:
+
+\begin{itemize}
+\item \ref{devicenormative:Device Types / PMEM Device / Device Initialization}
+\item \ref{drivernormative:Device Types / PMEM Driver / Driver Initialization / Virtio flush}
+\item \ref{drivernormative:Device Types / PMEM Driver / Driver Operation / Virtqueue command}
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
index 0000000..247313a
--- /dev/null
+++ b/virtio-pmem.tex
@@ -0,0 +1,128 @@
+\section{PMEM Device}\label{sec:Device Types / PMEM Device}
+
+The virtio pmem device is a persistent memory (NVDIMM) device
+provide a virtio based asynchronous flush mechanism. This avoids the
+need of a separate page cache in the guest and keeps the page cache
+only in the host. Under memory pressure, the host makes use of
+efficient memory reclaim decisions for page cache pages of all the
+guests. This helps to reduce the memory footprint and fit more guests
+in the host system.
+
+The virtio pmem device provides access to byte-addressable persistent
+memory. The persist memory is directly accessible as a Shared Memory Region.
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
+\item[\field{start}] contains the start address from the device physical address range
+to be hotplugged into the driver address space.
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
+The driver determines the start address and size of the persist memory region in preparation for reading or writing data.
+
+The driver initializes req_vq in preparation for making flush requests.
+
+\drivernormative{\subsubsection}{Driver Initialization: Virtio flush}{Device Types / PMEM Driver / Driver Initialization / Virtio flush}
+
+The driver MUST implement a virtio based flushing interface.
+
+\subsection{Driver Operations}\label{sec:Device Types / PMEM Driver / Driver Operation}
+\drivernormative{\subsubsection}{Driver Operation: Virtqueue command}{Device Types / PMEM Driver / Driver Operation / Virtqueue command}
+
+\begin{lstlisting}
+struct virtio_pmem_req {
+        __le32 type;
+};
+\end{lstlisting}
+
+Virtio pmem flush request:
+\begin{lstlisting}
+#define VIRTIO_PMEM_REQ_TYPE_FLUSH      0
+\end{lstlisting}
+
+The driver MUST send VIRTIO_PMEM_REQ_TYPE_FLUSH command on request virtqueue.
+
+The driver SHOULD be able to handle concurrent FLUSH requests.
+
+\subsection{Device Operations}\label{sec:Device Types / PMEM Driver / Device Operation}
+\devicenormative{\subsubsection}{Device Operation: Virtqueue flush}{Device Types / PMEM Device / Device Operation / Virtqueue flush}
+
+The device MUST ensure that all writes made before a flush request will persist across device reset and power failure before completing the flush request.
+
+\devicenormative{\subsubsection}{Device Operation: Virtqueue return}{Device Types / PMEM Device / Device Operation / Virtqueue return}
+
+The device MUST return integer "0" for success and "-1" for failure.
+
+\subsection{Possible security implications}\label{sec:Device Types / PMEM Device / Possible Security Implications}
+
+There could be potential security implications depending on how
+memory mapped device backing file is used. By default device emulation
+is done with SHARED mapping. There is a contract between driver and device
+process to access same backing file for read or write operations.
+
+If a malicious driver or device map the same backing file, attacking
+process can make use of known cache side channel attacks to predict
+the current state of shared page cache page. If both attacker and 
+victim somehow execute same shared code after a flush or evict call, 
+with difference in execution timing attacker could infer another driver
+local data or device data. Though this is not easy and same challenges
+exist as with bare metal device system when userspace share same backing file.
+
+\subsection{Countermeasures}\label{sec:Device Types / PMEM Device / Possible Security Implications / Countermeasures}
+
+\subsubsection{ With SHARED mapping}\label{sec:Device Types / PMEM Device / Possible Security Implications / Countermeasures / SHARED}
+
+If device backing backing file is shared with multiple driver or device, 
+this may act as a metric for page cache side channel attack. As a counter
+measure every driver should have its own(not shared with another driver)
+SHARED backing file and gets populated a per device page cache pages.
+
+\subsubsection{ With PRIVATE mapping}\label{sec:Device Types / PMEM Device / Possible Security Implications / Countermeasures / PRIVATE}
+There maybe be chances of side channels attack with PRIVATE
+memory mapping similar to SHARED with read-only shared mappings.
+PRIVATE is not used for virtio pmem making this usecase
+irrelevant.
+
+\subsubsection{ Workload specific mapping}\label{sec:Device Types / PMEM Device / Possible Security Implications / Countermeasures / Workload}
+For SHARED mapping, if workload is single application inside
+the driver and there is no risk with sharing of data between the devices.
+Driver sharing same backing file with SHARED mapping can be
+used as a valid configuration.
+
+\subsubsection{ Prevent cache eviction}\label{sec:Device Types / PMEM Device / Possible Security Implications / Countermeasures / Cache eviction}
+Don't allow cache evict from driver filesystem trim or discard command
+with virtio pmem. This rules out any possibility of evict-reload
+page cache side channel attacks if backing disk is shared(SHARED)
+with mutliple drivers. Though if we use per device backing file with
+shared mapping this countermeasure is not required.
-- 
2.25.1

