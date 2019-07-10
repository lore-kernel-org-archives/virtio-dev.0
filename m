Return-Path: virtio-dev-return-5835-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E0204985D6F
	for <virtio-dev@lists.oasis-open.org>; Wed, 10 Jul 2019 06:32:01 +0000 (UTC)
Date: Wed, 10 Jul 2019 02:31:57 -0400 (EDT)
From: Pankaj Gupta <pagupta@redhat.com>
Message-ID: <1431439000.40433516.1562740317670.JavaMail.zimbra@redhat.com>
In-Reply-To: <20190709184003.64484141.cohuck@redhat.com>
References: <20190709081134.9156-1-pagupta@redhat.com> <20190709184003.64484141.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio-dev] Re: [PATCH] add virtio-pmem device spec
To: Cornelia Huck <cohuck@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, mst@redhat.com, stefanha@redhat.com, lcapitulino@redhat.com, riel@surriel.com, aarcange@redhat.com, david@redhat.com, nilal@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>


> 
> > This patch proposes a virtio specification for new
> > virtio pmem device. Virtio pmem is a paravirtualized
> > device which solves two problems:
> > 
> > - Provides emulation of persistent memory on host regular
> >   (non NVDIMM) storage.
> > - Allows the guest to bypass the page cache.
> > 
> > This is changed version from previous RFC [1], incorporated
> > changes suggested by Stefan, Michael & Cornerlia.
> > 
> > [1] https://lists.oasis-open.org/archives/virtio-dev/201903/msg00083.html
> > 
> > Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> > ---
> >  conformance.tex |  23 ++++++++++-
> >  content.tex     |   1 +
> >  virtio-pmem.tex | 118
> >  ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 140 insertions(+), 2 deletions(-)
> >  create mode 100644 virtio-pmem.tex
> 
> (...)
> 
> > diff --git a/virtio-pmem.tex b/virtio-pmem.tex
> > new file mode 100644
> > index 0000000..fa64c6b
> > --- /dev/null
> > +++ b/virtio-pmem.tex
> > @@ -0,0 +1,118 @@
> > +\section{PMEM Device}\label{sec:Device Types / PMEM Device}
> > +
> > +virtio pmem is an emulated persistent memory device. The
> > +device is plugged to the guest using virtio bus.
> 
> "virtio bus" sounds too Linux-specific. Maybe just say "virtio pmem is
> an emulated persistent memory devices using virtio."?

o.k
> 
> > +
> > +Device works as fake nvdimm device when emulated on host regular
> 
> s/Device/The devices/

o.k

> 
> (more of these below)
> 
> > +(non NVDIMM) device. Device provides a virtio based asynchronous
> > +flush mechanism to persists the guest writes. This avoids the
> 
> s/persists/persist/

o.k

> 
> > +need of separate caching inside the guest and host side caching
> > +is used. Under memory pressure, host makes efficient memory reclaim
> 
> s/host/the host/
> 
> > +decisions on uniform view of memory.
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
> > +\field{size} in bytes length of address range.
> 
> "contains the length of the address range in bytes"?

done.

> 
> > +
> > +\subsection{Device Initialization}\label{sec:Device Types / PMEM Device /
> > Device Initialization}
> > +
> > +Device hot-plugs physical memory to guest address space. Persistent memory
> > device
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
> > +Host memory region MUST be mapped to guest address space in a
> 
> s/Host memory region/The host memory region/
> 
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
> > +\drivernormative{\subsubsection}{Driver Initialization: flush
> > callback}{Device Types / PMEM Driver / Driver Initialization / flush
> > callback}
> > +
> > +Driver MUST implement a virtio based flush callback, otherwise driver
> 
> s/Driver/The driver/
> 
> > +will fail to register.
> 
> I'm not sure what a "virtio based flush callback" is supposed to mean,
> though?
> 
> Also, what does it mean if a driver "fails to register"? I don't think
> you can translate this concept to the spec, it seems to be an
> implementation detail.

right. o.k Will remove this part.

> 
> > +
> > +\subsection{Driver Operations}\label{sec:Device Types / PMEM Driver /
> > Driver Operation}
> > +
> > +The VIRTIO_PMEM_REQ_TYPE_FLUSH command persists memory writes that were
> > performed
> 
> Maybe "all memory writes to the persistent memory range", to be more
> clear?
> 
> > +before the command was submitted. Once the command completes the
> 
> s/the/those/, maybe?

feel any one should be ok. 

> 
> > +writes are guaranteed to be persistent.
> > +
> > +\drivernormative{\subsubsection}{Driver Operation: Virtqueue
> > command}{Device Types / PMEM Driver / Driver Operation / Virtqueue
> > command}
> > +
> > +The driver MUST submit a VIRTIO_PMEM_REQ_TYPE_FLUSH command after
> > performing
> > +memory writes that require persistence.
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
> > +corresponding host flush mechanisms.
> > +
> > +\devicenormative{\subsubsection}{Device operations: Virtqueue
> > return}{Device Types / PMEM Device / Device Operation / Virtqueue return}
> > +
> > +Device SHOULD return integer '0' for success and '1' for failure.
> > +These errors are converted to corresponding error codes by guest as
> > +per architecture.
> 
> I think what the driver actually does with the 0/1 return values is
> already an implementation detail. Also, why 'SHOULD'? The driver needs
> to be sure that it won't interpret success as failure, and vice versa.
> At least "return 0 on success, !0 otherwise" needs to be a MUST, I
> think.

Agree. Will remove text desrcribing implementation details.

> 
> > +
> > +\subsection{Possible security implications}\label{sec:Device Types / PMEM
> > Device / Possible Security Implications}
> > +
> > +If two devices actually share the same memory, this creates a
> 
> Maybe "Two devices actually sharing the same memory creates a..."?

changed.

> 
> > +potential information leak as access patterns of one driver could
> > +be observable by another driver.
> > +
> > +This can happen for example if two devices are implemented in software
> > +by a hyper-visor, and two drivers are parts of VMs running on the
> > +hyper-visor. In this case, the timing of access to device memory
> 
> I'm not sure whether hyper-visor or hypervisor is the more common
> spelling here.

changed back to hypervisor.

> 
> > +might leak information about access patterns from one VM to another.
> > +
> > +This can include, but might not be limited to:
> > +\begin{enumerate}
> > +\item Configurations sharing a single region of device memory (even in a
> > read-only configuration)
> > +\item Configurations with a shared cache between devices (e.g. linux page
> > cache)
> 
> s/linux/Linux/
> 
> > +\item Configurations with memory deduplication techniques such as KSM
> > similar side-channels
> > + might be present if the device memory is shared with another system, e.g.
> > information about
> > + the hyper-visor/host page cache might leak into a VM guest.
> 
> I'm not quite able to make sense of this sentence -- is there a
> semicolon missing after 'KSM'?

added 
> 
> > +\end{enumerate}
> > +
> > +\subsection{Countermeasures}\label{sec:Device Types / PMEM Device /
> > Possible Security Implications / Countermeasures}
> > +Solution is to avoid sharing resources between devices.
> > +\begin{enumerate}
> > +\item Each VM must have its own device memory, not shared with any other
> > VM or process.
> > +\item If VM workload is a special application and there is no risk, its
> > okay to share the device memory.
> 
> s/VM workload/the VM workload/
> s/its/it is/
> 
> > +\item Don't allow host cache eviction from VM when device memory is shared
> > with other VM or host process.
> > +\end{enumerate}
> 
> Generally, I think this has moved a lot into the right direction; some
> general nits from my side, and some remaining things that sound a bit
> too Linux-specific.

Thank you for the review. I have incorporated changes suggested by you.
Will post a v2 with the changes.

Thanks,
Pankaj

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

