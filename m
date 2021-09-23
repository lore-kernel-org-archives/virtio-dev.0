Return-Path: <virtio-dev-return-8706-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D9F819863E0
	for <virtio-dev@lists.oasis-open.org>; Thu, 23 Sep 2021 10:35:19 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20210921102702.60259-1-pankaj.gupta.linux@gmail.com>
References: <20210921102702.60259-1-pankaj.gupta.linux@gmail.com>
Date: Thu, 23 Sep 2021 12:34:54 +0200
Message-ID: <871r5ffult.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH v4] virtio-pmem: PMEM device spec
Content-Type: text/plain
To: Pankaj Gupta <pankaj.gupta.linux@gmail.com>, virtio-dev@lists.oasis-open.org
Cc: stefanha@redhat.com, dan.j.williams@intel.com, david@redhat.com, mst@redhat.com, tstark@linux.microsoft.com, pankaj.gupta@ionos.com, Pankaj Gupta <pankaj.gupta.linux@gmail.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Sep 21 2021, Pankaj Gupta <pankaj.gupta.linux@gmail.com> wrote:

> Posting virtio specification for virtio pmem device. Virtio pmem is a
> paravirtualized device which allows the guest to bypass page cache.
> Virtio pmem kernel driver is merged in Upstream Kernel 5.3. Also, Qemu
> device is merged in Qemu 4.1.
>
> Signed-off-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> ---
>  v3 -> v4
>   Define constant used in request type - Stefan
>   Small text change - Stefan
>
>  conformance.tex |  16 +++++-
>  content.tex     |   1 +
>  virtio-pmem.tex | 128 ++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 143 insertions(+), 2 deletions(-)
>  create mode 100644 virtio-pmem.tex

(...)

> diff --git a/virtio-pmem.tex b/virtio-pmem.tex
> new file mode 100644
> index 0000000..4fad8a3
> --- /dev/null
> +++ b/virtio-pmem.tex
> @@ -0,0 +1,128 @@
> +\section{PMEM Device}\label{sec:Device Types / PMEM Device}
> +
> +The virtio pmem device is a persistent memory (NVDIMM) device
> +that provides a virtio based asynchronous flush mechanism. This avoids
> +the need of a separate page cache in the guest and keeps the page cache
> +only in the host. Under memory pressure, the host makes use of
> +efficient memory reclaim decisions for page cache pages of all the
> +guests. This helps to reduce the memory footprint and fits more guests
> +in the host system.
> +
> +The virtio pmem device provides access to byte-addressable persistent
> +memory. The persist memory is a directly accessible range of system memory.
> +Data written to this memory is made persistent by separately sending a
> +flush command. Writes that have been flushed are preserved across device
> +reset and power failure.
> +
> +\subsection{Device ID}\label{sec:Device Types / PMEM Device / Device ID}
> +  27
> +
> +\subsection{Virtqueues}\label{sec:Device Types / PMEM Device / Virtqueues}
> +\begin{description}
> +\item[0] req_vq
> +\end{description}
> +
> +\subsection{Feature bits}\label{sec:Device Types / PMEM Device / Feature bits}
> +
> +There are currently no feature bits defined for this device.
> +
> +\subsection{Device configuration layout}\label{sec:Device Types / PMEM Device / Device configuration layout}
> +
> +\begin{lstlisting}
> +struct virtio_pmem_config {
> +	le64 start;
> +	le64 size;
> +};
> +\end{lstlisting}
> +
> +\begin{description}
> +\item[\field{start}] contains the physical address of the first byte of the persistent memory region.
> +
> +\item[\field{size}] contains the length of this address range.
> +\end{description}
> +
> +\begin{enumerate}
> +\item Driver vpmem start is read from \field{start}.
> +\item Driver vpmem end is read from \field{size}.
> +\end{enumerate}
> +
> +\subsection{Driver Initialization}\label{sec:Device Types / PMEM Driver / Driver Initialization}
> +
> +The driver determines the start address and size of the persistent memory region in preparation for reading or writing data.
> +
> +The driver initializes req_vq in preparation for making flush requests.
> +
> +\subsection{Driver Operations}\label{sec:Device Types / PMEM Driver / Driver Operation / Request Queues}
> +
> +Requests have the following format:
> +
> +\begin{lstlisting}
> +struct virtio_pmem_req {
> +        le32 type;
> +};
> +\end{lstlisting}
> +
> +\field{type} is the request command type. 

(minor) trailing whitespace

> +
> +Possible request types are:
> +
> +\begin{lstlisting}
> +#define VIRTIO_PMEM_REQ_TYPE_FLUSH      0
> +\end{lstlisting}
> +
> +\subsection{Device Operations}\label{sec:Device Types / PMEM Driver / Device Operation}
> +\devicenormative{\subsubsection}{Device Operation: Virtqueue flush}{Device Types / PMEM Device / Device Operation / Virtqueue flush}
> +
> +The device MUST ensure that all writes completed before a flush request persist across device reset and power failure before completing the flush request.
> +
> +\subsubsection{Device Operations}\label{sec:Device Types / PMEM Driver / Device Operation / Virtqueue return}
> +\begin{lstlisting}
> +struct virtio_pmem_resp {
> +        le32 ret;
> +};
> +\end{lstlisting}
> +
> +\field{ret} is the value which device returns after command completion.

(minor) s/device/the device/

> +
> +\devicenormative{\subsubsection}{Device Operation: Virtqueue return}{Device Types / PMEM Device / Device Operation / Virtqueue return}
> +
> +The device MUST return "0" for success and "-1" for failure.
> +
> +\subsection{Possible security implications}\label{sec:Device Types / PMEM Device / Possible Security Implications}
> +
> +There could be potential security implications depending on how
> +memory mapped backing device is used. By default device emulation
> +is done with SHARED memory mapping. There is a contract between driver
> +and device to access shared memory region for read or write operations.
> +
> +If a malicious driver or device map the same memory region, the attacker
> +can make use of known side channel attacks to predict the current state of data.
> +If both attacker and victim somehow execute same shared code after a flush
> +or evict operation, with difference in execution timing attacker could infer
> +another device data.
> +
> +\subsection{Countermeasures}\label{sec:Device Types / PMEM Device / Possible Security Implications / Countermeasures}
> +
> +\subsubsection{ With SHARED mapping}\label{sec:Device Types / PMEM Device / Possible Security Implications / Countermeasures / SHARED}
> +
> +If device backing region is shared between multiple devices, this may act
> +as a metric for side channel attack. As a counter measure every device
> +should have its own(not shared with another driver) SHARED backing memory.
> +
> +\subsubsection{ With PRIVATE mapping}\label{sec:Device Types / PMEM Device / Possible Security Implications / Countermeasures / PRIVATE}
> +There maybe be chances of side channels attack with PRIVATE
> +memory mapping similar to SHARED with read-only shared mappings.
> +PRIVATE is not used for virtio pmem making this usecase
> +irrelevant.
> +
> +\subsubsection{ Workload specific mapping}\label{sec:Device Types / PMEM Device / Possible Security Implications / Countermeasures / Workload}
> +For SHARED mapping, if workload is single application inside
> +the driver and there is no risk in sharing data. Device sharing
> +same backing region with SHARED mapping can be used as a valid configuration.
> +
> +\subsubsection{ Prevent cache eviction}\label{sec:Device Types / PMEM Device / Possible Security Implications / Countermeasures / Cache eviction}
> +Don't allow device shared region evict from driver filesystem trim or discard 
> +like commands with virtio pmem. This rules out any possibility of evict-reload
> +cache side channel attacks if backing region is shared(SHARED)
> +between mutliple devices. Though if we use per device backing file with
> +shared mapping this countermeasure is not required.

I have only two minor things, and these can easily be fixed up while
applying (or later). If others are also fine with this (especially
regarding the security implicates section, which I did not really
review), I think we can start voting.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

