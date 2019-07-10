Return-Path: virtio-dev-return-5838-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 68A8F985D70
	for <virtio-dev@lists.oasis-open.org>; Wed, 10 Jul 2019 10:02:43 +0000 (UTC)
Date: Wed, 10 Jul 2019 06:02:41 -0400 (EDT)
From: Pankaj Gupta <pagupta@redhat.com>
Message-ID: <823216138.40577754.1562752961242.JavaMail.zimbra@redhat.com>
In-Reply-To: <20190710113618.2159e0f5.cohuck@redhat.com>
References: <20190710080512.24973-1-pagupta@redhat.com> <20190710113618.2159e0f5.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v2] add virtio-pmem device spec
To: Cornelia Huck <cohuck@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, nilal@redhat.com, riel@surriel.com, stefanha@redhat.com, aarcange@redhat.com, david@redhat.com, mst@redhat.com, lcapitulino@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>


> 
> On Wed, 10 Jul 2019 13:35:12 +0530
> Pankaj Gupta <pagupta@redhat.com> wrote:
> 
> > This patch proposes a virtio specification for new
> > virtio pmem device. Virtio pmem is a paravirtualized
> > device which solves two problems:
> > 
> > - Provides emulation of persistent memory on host regular
> >   (non NVDIMM) storage.
> > - Allows the guest to bypass the page cache.
> > 
> > This is changed version from previous v1 [1], as per suggestions by
> > cornelia on RFC[2] with incorporated changes suggested by Stefan, Michael
> > & Cornerlia.
> > 
> > [1] https://lists.oasis-open.org/archives/virtio-dev/201907/msg00004.html
> > [2] https://lists.oasis-open.org/archives/virtio-dev/201903/msg00083.html
> > 
> > Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> > ---
> >  conformance.tex |  22 ++++++++++--
> >  content.tex     |   1 +
> >  virtio-pmem.tex | 109
> >  ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 130 insertions(+), 2 deletions(-)
> >  create mode 100644 virtio-pmem.tex
> 
> (...)
> 
> > diff --git a/virtio-pmem.tex b/virtio-pmem.tex
> > new file mode 100644
> > index 0000000..ffa5cc3
> > --- /dev/null
> > +++ b/virtio-pmem.tex
> > @@ -0,0 +1,109 @@
> > +\section{PMEM Device}\label{sec:Device Types / PMEM Device}
> > +
> > +virtio pmem is an emulated persistent memory device using virtio.
> > +
> > +The devices work as fake nvdimm device when emulated on host regular
> 
> "The device works as a fake nvdimm device when emulated on a host
> regular (non NVDIMM) device." ?
> 
> > +(non NVDIMM) device. Device provides a virtio based asynchronous
> 
> s/Device/The device/

o.k


> 
> > +flush mechanism to persist the guest writes. This avoids the
> > +need of separate caching inside the guest and host side caching
> > +is used. Under memory pressure, the host makes efficient memory
> > +reclaim decisions on uniform view of memory.
> > +
> > +\subsection{Device ID}\label{sec:Device Types / PMEM Device / Device ID}
> > +  27
> > +
> > +\subsection{Virtqueues}\label{sec:Device Types / PMEM Device / Virtqueues}
> > +\begin{description}
> > +\item[0] req_vq
> > +\end{description}
> > +
> > +\subsection{Feature bits}\label{sec:Device Types / PMEM Device / Feature
> > bits}
> > +
> > +There are currently no feature bits defined for this device.
> > +
> > +\subsection{Device configuration layout}\label{sec:Device Types / PMEM
> > Device / Device configuration layout}
> > +
> > +\begin{lstlisting}
> > +struct virtio_pmem_config {
> > +	uint64_t start;
> > +	uint64_t size;
> > +};
> > +\end{lstlisting}
> > +
> > +\field{start} contains the physical address of the start of the persistent
> > memory range.
> > +\field{size} contains the length of address range in bytes.
> > +
> > +\subsection{Device Initialization}\label{sec:Device Types / PMEM Device /
> > Device Initialization}
> > +
> > +Device hot-plugs physical memory to guest address space. Persistent memory
> > device
> 
> s/Device/The device/
> s/Persistent memory device/The persistent memory device/

sure

> 
> > +is emulated at host side.
> > +
> > +\begin{enumerate}
> > +  \item The driver reads the physical start address from \field{start}.
> > +  \item The driver reads the length of the persistent memory range from
> > \field{size}.
> > +  \end{enumerate}
> > +
> > +\devicenormative{\subsubsection}{Device Initialization}{Device Types /
> > PMEM Device / Device Initialization}
> > +
> > +The host memory region MUST be mapped to guest address space in a
> > +way so that updates are visible to other processes mapping the
> > +same memory region.
> > +
> > +\subsection{Driver Initialization}\label{sec:Device Types / PMEM Driver /
> > Driver Initialization}
> > +
> > +Memory stores to the persistent memory range are not guaranteed to be
> > +persistent without further action. An explicit flush command is
> > +required to ensure persistence. The req_vq is used to perform flush
> > +commands.
> > +
> > +\subsection{Driver Operations}\label{sec:Device Types / PMEM Driver /
> > Driver Operation}
> > +
> > +The VIRTIO_PMEM_REQ_TYPE_FLUSH command persists memory writes that were
> > performed
> > +before the command was submitted. Once the command completes those writes
> > are guaranteed
> > +to be persistent.
> > +
> > +\drivernormative{\subsubsection}{Driver Operation: Virtqueue
> > command}{Device Types / PMEM Driver / Driver Operation / Virtqueue
> > command}
> > +
> > +The driver MUST submit a VIRTIO_PMEM_REQ_TYPE_FLUSH command after
> > performing
> > +all memory writes to the persistent memory range.
> 
> The last version had "The driver MUST submit a
> VIRTIO_PMEM_REQ_TYPE_FLUSH command after performing memory writes that
> require persistence.", which sounds better IMO.

o.k

> 
> (Ah, now I see; the "all memory writes" I suggested last time was
> supposed to be for the previous subsection :)

o.k :)

> 
> > +
> > +The driver MUST wait for the VIRTIO_PMEM_REQ_TYPE_FLUSH command to
> > complete before
> > +assuming previous writes are persistent.
> > +
> > +\subsection{Device Operations}\label{sec:Device Types / PMEM Driver /
> > Device Operation}
> > +
> > +\devicenormative{\subsubsection}{Device Operations: Virtqueue
> > flush}{Device Types / PMEM Device / Device Operation / Virtqueue flush}
> > +
> > +Device SHOULD handle multiple flush requests simultaneously using
> 
> s/Device/The device/
> 
> > +corresponding host flush mechanisms.
> > +
> > +\devicenormative{\subsubsection}{Device operations: Virtqueue
> > return}{Device Types / PMEM Device / Device Operation / Virtqueue return}
> > +
> > +Device MUST return integer '0' for success and '!0' for failure.
> 
> s/Device/The device/

sure

> 
> > +
> > +\subsection{Possible security implications}\label{sec:Device Types / PMEM
> > Device / Possible Security Implications}
> > +
> > +Two devices actually sharing the same memory creates a potential
> > information
> > +leak as access patterns of one driver could be observable by another
> > driver.
> > +
> > +This can happen for example if two devices are implemented in software
> > +by a hypervisor, and two drivers are parts of VMs running on the
> > +hypervisor. In this case, the timing of access to device memory
> > +might leak information about access patterns from one VM to another.
> > +
> > +This can include, but might not be limited to:
> > +\begin{enumerate}
> > +\item Configurations sharing a single region of device memory (even in a
> > read-only configuration)
> > +\item Configurations with a shared cache between devices (e.g. Linux page
> > cache)
> > +\item Configurations with memory deduplication techniques such as KSM;
> > similar side-channels
> > + might be present if the device memory is shared with another system, e.g.
> > information about
> > + the hypervisor/host page cache might leak into a VM guest.
> > +\end{enumerate}
> > +
> > +\subsection{Countermeasures}\label{sec:Device Types / PMEM Device /
> > Possible Security Implications / Countermeasures}
> > +Solution is to avoid sharing resources between devices.
> > +\begin{enumerate}
> > +\item Each VM must have its own device memory, not shared with any other
> > VM or process.
> > +\item If the VM workload is a special application and there is no risk, it
> > is okay to share the device memory.
> > +\item Don't allow host cache eviction from VM when device memory is shared
> > with other VM or host process.
> > +\end{enumerate}
> 
> Other than my minor comments, this looks good to me.

Sure. Thank you!

Best regards,
Pankaj

> 

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

