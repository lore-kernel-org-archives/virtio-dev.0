Return-Path: virtio-dev-return-5792-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 272DA985D20
	for <virtio-dev@lists.oasis-open.org>; Fri, 21 Jun 2019 20:33:05 +0000 (UTC)
Date: Fri, 21 Jun 2019 16:33:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190621161107-mutt-send-email-mst@kernel.org>
References: <20190326143507.12607-1-pagupta@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326143507.12607-1-pagupta@redhat.com>
Subject: Re: [virtio-dev] [RFC] virtio-pmem: PMEM device spec
To: Pankaj Gupta <pagupta@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, david@redhat.com, riel@surriel.com, stefanha@redhat.com, dan.j.williams@intel.com, aarcange@redhat.com, cohuck@redhat.com, lcapitulino@redhat.com, nilal@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>


On Tue, Mar 26, 2019 at 08:05:07PM +0530, Pankaj Gupta wrote:
> This patch proposes a virtio specification for new
> virtio pmem device. Virtio pmem is a paravirtualized 
> device which allows the guest to bypass page cache.
> Previous posting of kernel driver is [1] and Qemu 
> device is [2]. Specification has introduction of 
> virtio pmem device with other implementation details. 
> 
> I have also listed concerns with page cache side channel
> attacks in previous kernel driver posting [1] and 
> possible countermeasures based on discussion [4].
> I have also created an virtio-spec issue [5] for this.
> 
> Request to provide feedback on device specification.
> 
> [1] https://lkml.org/lkml/2019/1/9/471 
> [2] https://marc.info/?l=qemu-devel&m=153555721901824&w=2
> [3] https://lkml.org/lkml/2019/1/9/541
> [4] https://lkml.org/lkml/2019/2/4/1151
> [5] https://github.com/oasis-tcs/virtio-spec/issues/38
> 
> Signed-off-by: Pankaj Gupta <pagupta@redhat.com>


So we need to rewrite all this in terms of driver/device.
This will also help remove linux-isms.

> ---
>  conformance.tex |  14 ++++++
>  content.tex     |   3 ++
>  virtio-pmem.tex | 134 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 151 insertions(+)
>  create mode 100644 virtio-pmem.tex
> 
> diff --git a/conformance.tex b/conformance.tex
> index ad7e82e..2133a7c 100644
> --- a/conformance.tex
> +++ b/conformance.tex
> @@ -181,6 +181,20 @@ A socket driver MUST conform to the following normative statements:
>  \item \ref{drivernormative:Device Types / Socket Device / Device Operation / Device Events}
>  \end{itemize}
>  
> +\subsection{PMEM Driver Conformance}\label{sec:Conformance / Driver Conformance / PMEM Driver Conformance}
> +
> +A PMEM driver MUST conform to the following normative statements:
> +
> +\begin{itemize}
> +\item \ref{devicenormative:Device Types / PMEM Device / Device Initialization}
> +\item \ref{drivernormative:Device Types / PMEM Driver / Driver Initialization / Direct access}
> +\item \ref{drivernormative:Device Types / PMEM Driver / Driver Initialization / Virtio flush}
> +\item \ref{drivernormative:Device Types / PMEM Driver / Driver Operation / Virtqueue command}
> +\item \ref{devicenormative:Device Types / PMEM Device / Device Operation / Virtqueue flush}
> +\item \ref{devicenormative:Device Types / PMEM Device / Device Operation / Virtqueue return}
> +\end{itemize}
> +
> +
>  \section{Device Conformance}\label{sec:Conformance / Device Conformance}
>  
>  A device MUST conform to the following normative statements:
> diff --git a/content.tex b/content.tex
> index ede0ef6..6077d32 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -2634,6 +2634,8 @@ Device ID  &  Virtio Device    \\
>  \hline
>  24         &   Memory device \\
>  \hline
> +25         &   PMEM device \\
> +\hline
>  \end{tabular}
>  
>  Some of the devices above are unspecified by this document,
> @@ -5595,6 +5597,7 @@ descriptor for the \field{sense_len}, \field{residual},
>  \input{virtio-input.tex}
>  \input{virtio-crypto.tex}
>  \input{virtio-vsock.tex}
> +\input{virtio-pmem.tex}
>  
>  \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
>  
> diff --git a/virtio-pmem.tex b/virtio-pmem.tex
> new file mode 100644
> index 0000000..04e07bb
> --- /dev/null
> +++ b/virtio-pmem.tex
> @@ -0,0 +1,134 @@
> +\section{PMEM Device}\label{sec:Device Types / PMEM Device}
> +
> +The virtio pmem is a fake persistent memory (NVDIMM) device
> +used to bypass the guest page cache and provide a virtio
> +based asynchronous flush mechanism. This avoids the need
> +of a separate page cache in guest and keeps page cache only
> +in the host. Under memory pressure, the host makes use of
> +effecient memory reclaim decisions for page cache pages
> +of all the guests. This helps to reduce the memory footprint
> +and fit more guests in the host system.
> +
> +\subsection{Device ID}\label{sec:Device Types / PMEM Device / Device ID}
> +  25
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
> +\field{start} contains the guest physical address of the start of the
> +physical address range to be hotplugged into the guest address space
> +using the pmem API.
> +\field{size} contains the length of this address range.
> +
> +\subsection{Device Initialization}\label{sec:Device Types / PMEM Device / Device Initialization}
> +
> +Device hotplugs physical memory to guest address space. Persistent memory device
> +is emulated with file backed memory at host side.
> +
> +\begin{enumerate}
> +\item Guest vpmem start is read from \field{start}.
> +\item Guest vpmem end is read from \field{size}.
> +\end{enumerate}
> +
> +\devicenormative{\subsubsection}{Device Initialization}{Device Types / PMEM Device / Device Initialization}
> +
> +File backed memory SHOULD be memory mapped to guest address space with SHARED
> +memory mapping.

You mean MAP_SHARED, right?  This wording is very specific to linux, and
even then it's not all that well defined (can differ between kernel
versions).  Please try to write out what exactly it means.
I also wonder about MAP_SYNC and generally persistence across crashes.


> +
> +\subsection{Driver Initialization}\label{sec:Device Types / PMEM Driver / Driver Initialization}
> +
> +Driver hotplugs the physical memory and registers associated
> +region with the pmem API. Also, configures a flush callback
> +function with the corresponding region.
> +
> +\drivernormative{\subsubsection}{Driver Initialization: Filesystem direct access}{Device Types / PMEM Driver / Driver Initialization / Direct access}
> +
> +Driver SHOULD enable filesystem direct access operations for
> +read/write on the device.
> +
> +\drivernormative{\subsubsection}{Driver Initialization: Virtio flush}{Device Types / PMEM Driver / Driver Initialization / Virtio flush}
> +
> +Driver SHOULD add implement a virtio based flush callback.
> +Driver SHOULD disable other FLUSH/SYNC mechanisms for the device
> +when virtio flush is configured.
> +
> +\subsection{Driver Operations}\label{sec:Device Types / PMEM Driver / Driver Operation}
> +\drivernormative{\subsubsection}{Driver Operation: Virtqueue command}{Device Types / PMEM Driver / Driver Operation / Virtqueue command}
> +
> +Driver SHOULD send VIRTIO_FLUSH command on request virtqueue,
> +blocks guest userspace process utill host completes fsync/flush.

more specifically, what does this mean? I am guessing access
to device should be blocked between VIRTIO_FLUSH being available
and VIRTIO_FLUSH being used?

Also, this is the only place that mentions VIRTIO_FLUSH.
And I think VIRTIO_PMEM_FLUSH would be a better name.

> +Driver SHOULD handle multiple fsync requests on files present
> +on the device.
> +
> +\subsection{Device Operations}\label{sec:Device Types / PMEM Driver / Device Operation}
> +
> +\devicenormative{\subsubsection}{Device Operations}{Device Types / PMEM Device / Device Operation / Virtqueue flush}
> +
> +Device SHOULD handle multiple flush requests simultaneously using
> +host filesystem fsync/flush call.
> +
> +\devicenormative{\subsubsection}{Device operations}{Device Types / PMEM Device / Device Operation / Virtqueue return}
> +
> +Device SHOULD return integer '0' for success and '-1' for failure.
> +These errors are converted to corresponding error codes by guest as
> +per architecture.
> +
> +\subsection{Possible security implications}\label{sec:Device Types / PMEM Device / Possible Security Implications}
> +
> +There could be potential security implications depending on how
> +memory mapped host backing file is used. By default device emulation
> +is done with SHARED mapping. There is a contract between guest and host
> +process to access same backing file for read/write operations.
> +
> +If a malicious guest or host userspace map the same backing file,
> +attacking process can make use of known cache side channel attacks
> +to predict the current state of shared page cache page. If both
> +attacker and victim somehow execute same shared code after a
> +flush/evict call, with difference in execution timing attacker
> +could infer another guest local data or host data. Though this is
> +not easy and same challenges exist as with bare metal host system
> +when userspace share same backing file.

This seems a bit vague.  I think what you are trying to say is this:

if two devices actually share the same memory, this
creates a potential information leak as access patterns
of on driver could be observable by another driver.

This can happen for example if two devices are implemented
in software by a hypervisor, and two drivers are
parts of VMs running on the hypervisor.
In this case, the timing of access to device memory
might leak information about access patterns from one VM to another.

This can include, but might not be limited to:
- configurations sharing a single region of device memory (even in a read-only
  configuration)
- configurations with a shared cache between devices (e.g. linux page
  cache)
- configurations with memory deduplication techniques such as KSM 


Similar side-channels might be present if the device memory is shared
with another system, e.g. information about the hypervisor/host page cache
might leak into a VM guest.



> +
> +\subsection{Countermeasures}\label{sec:Device Types / PMEM Device / Possible Security Implications / Countermeasures}
> +
> +\subsubsection{ With SHARED mapping}\label{sec:Device Types / PMEM Device / Possible Security Implications / Countermeasures / SHARED}
> +
> +If device backing backing file is shared with multiple guests or host
> +processes, this may act as a metric for page cache side channel attack.
> +As a counter measure every guest should have its own(not shared with
> +another guest) SHARED backing file and gets populated a per host process
> +page cache pages.


I would say that the solution is to avoid sharing resources between
devices.  Then give examples.

> +
> +\subsubsection{ With PRIVATE mapping}\label{sec:Device Types / PMEM Device / Possible Security Implications / Countermeasures / PRIVATE}
> +There maybe be chances of side channels attack with PRIVATE
> +memory mapping similar to SHARED with read-only shared mappings.
> +PRIVATE is not used for virtio pmem making this usecase
> +irrelevant.

Let's rewrite in a way that does not rely on semantics of linux
system calls. I am guessing you mean MAP_SHARED/MAP_PRIVATE,
but I am not all that sure.

> +
> +\subsubsection{ Workload specific mapping}\label{sec:Device Types / PMEM Device / Possible Security Implications / Countermeasures / Workload}
> +For SHARED mapping, if workload is single application inside
> +guest and there is no risk with sharing of data between guests.
> +Guest sharing same backing file with SHARED mapping can be
> +used as a valid configuration.
> +
> +\subsubsection{ Prevent cache eviction}\label{sec:Device Types / PMEM Device / Possible Security Implications / Countermeasures / Cache eviction}
> +Don't allow cache evict from guest filesystem trim/discard command
> +with virtio pmem. This rules out any possibility of evict-reload
> +page cache side channel attacks if backing disk is shared(SHARED)
> +with mutliple guests. Though if we use per device backing file with
> +shared mapping this countermeasure is not required.
> -- 
> 2.14.3
> 
> 
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

