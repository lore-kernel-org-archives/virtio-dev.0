Return-Path: <virtio-dev-return-8450-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7017798647B
	for <virtio-dev@lists.oasis-open.org>; Fri, 30 Jul 2021 11:53:56 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20210728150435.264551-1-pankaj.gupta.linux@gmail.com>
References: <20210728150435.264551-1-pankaj.gupta.linux@gmail.com>
Date: Fri, 30 Jul 2021 13:53:41 +0200
Message-ID: <87r1fg10hm.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH RESEND] virtio-pmem: PMEM device spec
Content-Type: text/plain
To: Pankaj Gupta <pankaj.gupta.linux@gmail.com>, virtio-dev@lists.oasis-open.org
Cc: dan.j.williams@intel.com, david@redhat.com, mst@redhat.com, tstark@linux.microsoft.com, pankaj.gupta@ionos.com, Pankaj Gupta <pankaj.gupta.linux@gmail.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Jul 28 2021, Pankaj Gupta <pankaj.gupta.linux@gmail.com> wrote:

> Posting virtio specification for virtio pmem device. Virtio pmem is a
> paravirtualized device which allows the guest to bypass page cache.
> Virtio pmem kernel driver is merged in Upstream Kernel 5.3. Also, Qemu
> device is merged in Qemu 4.1.
>
> Signed-off-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> ---
> Sorry, It took me long time to get back on this. There is
> an enhancement to this spec by "Taylor Stark" CCed in the list.
> Request for feedback and merging.

Thank you for following up on this.

>
> RFC is posted here [1]
> [1] https://lists.oasis-open.org/archives/virtio-dev/201903/msg00083.html
>
>  conformance.tex |  19 ++++++-
>  content.tex     |   1 +
>  virtio-pmem.tex | 132 ++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 150 insertions(+), 2 deletions(-)
>  create mode 100644 virtio-pmem.tex

(...)

> diff --git a/virtio-pmem.tex b/virtio-pmem.tex
> new file mode 100644
> index 0000000..a2b888e
> --- /dev/null
> +++ b/virtio-pmem.tex
> @@ -0,0 +1,132 @@
> +\section{PMEM Device}\label{sec:Device Types / PMEM Device}
> +
> +The virtio pmem is a fake persistent memory (NVDIMM) device

"The virtio pmem device"?

> +used to bypass the guest page cache and provide a virtio
> +based asynchronous flush mechanism.This avoids the need

missing space after '.'

> +of a separate page cache in guest and keeps page cache only

s/guest/the guest/
s/page cache/the page cache/

> +in the host. Under memory pressure, the host makes use of

"can make use", or maybe "is enabled to make use"?

> +effecient memory reclaim decisions for page cache pages
> +of all the guests. This helps to reduce the memory footprint
> +and fit more guests in the host system.
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
> +\item[\field{start}] contains the start address from the guest physical address range
> +to be hotplugged into the guest address space using the pmem API.
> +
> +\item[\field{size}] contains the length of this address range.
> +\end{description}
> +
> +\subsection{Device Initialization}\label{sec:Device Types / PMEM Device / Device Initialization}
> +
> +Device hotplugs physical memory to guest address space. Persistent memory device

s/Device/The device/
s/Persistent memory device/The persistent memory device/

> +is emulated with file backed memory at host side.

"on the host side"?

> +
> +\begin{enumerate}
> +\item Guest vpmem start is read from \field{start}.
> +\item Guest vpmem end is read from \field{size}.
> +\end{enumerate}
> +
> +\devicenormative{\subsubsection}{Device Initialization}{Device Types / PMEM Device / Device Initialization}
> +
> +File backed memory MUST be memory mapped to guest address space with SHARED
> +memory mapping.

Is 'SHARED' generic enough? Probably yes.

(Similar for the other terms like 'page cache' -- I think we can assume
similar concepts for most operating systems?)

> +
> +\subsection{Driver Initialization}\label{sec:Device Types / PMEM Driver / Driver Initialization}
> +
> +Driver hotplugs the physical memory and registers associated region with the pmem API.

s/Driver/The driver/
s/associated region/the associated region/ ?

> +Also, configures a flush callback function with the corresponding region.

Not sure if that is too specific already... maybe something like "Also,
it configures a notification for when the corresponding region is flushed."?

> +
> +\drivernormative{\subsubsection}{Driver Initialization: Filesystem direct access}{Device Types / PMEM Driver / Driver Initialization / Direct access}
> +
> +Driver MUST enable filesystem direct access operations for read/write on the device.

s/Driver/The driver/

Not sure whether this is operating system agnostic enough... does anyone
else have a better idea?

> +
> +\drivernormative{\subsubsection}{Driver Initialization: Virtio flush}{Device Types / PMEM Driver / Driver Initialization / Virtio flush}
> +
> +Driver MUST implement a virtio based flush callback.
> +
> +Driver MUST disable other FLUSH/SYNC mechanisms for the device when virtio flush is configured.

s/Driver/The driver/ (x2)

See above for "flush callback". I'm mostly worrying about the wording
being generic enough (even though it's probably obvious enough for
non-Linux people as well.)

> +
> +\subsection{Driver Operations}\label{sec:Device Types / PMEM Driver / Driver Operation}
> +\drivernormative{\subsubsection}{Driver Operation: Virtqueue command}{Device Types / PMEM Driver / Driver Operation / Virtqueue command}
> +
> +Driver MUST send VIRTIO_FLUSH command on request virtqueue, allows guest userspace process to perform IO operations asynchronously.

s/Driver/The driver/

I don't think we should refer to "guest userspace" in the spec; can we
reword this?

> +
> +Driver SHOULD handle multiple fsync requests on files present on the device.

s/Driver/The driver/

Again, a bit unsure on whether this is generic enough.

> +
> +\subsection{Device Operations}\label{sec:Device Types / PMEM Driver / Device Operation}
> +
> +\devicenormative{\subsubsection}{Device Operations}{Device Types / PMEM Device / Device Operation / Virtqueue flush}
> +
> +Device SHOULD handle multiple flush requests simultaneously using host filesystem fsync or flush call.

s/Device/The device/

> +
> +\devicenormative{\subsubsection}{Device operations}{Device Types / PMEM Device / Device Operation / Virtqueue return}
> +
> +Device MUST return integer "0" for success and "-1" for failure.

s/Device/The device/

> +These errors are converted to corresponding error codes by guest
> +as per architecture.

I don't think you need to specify what the guest will actually do with
the errors, that's entirely driver-dependent.

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
> +
> +\subsubsection{ With PRIVATE mapping}\label{sec:Device Types / PMEM Device / Possible Security Implications / Countermeasures / PRIVATE}
> +There maybe be chances of side channels attack with PRIVATE
> +memory mapping similar to SHARED with read-only shared mappings.
> +PRIVATE is not used for virtio pmem making this usecase
> +irrelevant.
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

I'll leave review of these to others who are more familiar with this
area.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

