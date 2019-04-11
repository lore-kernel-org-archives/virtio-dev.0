Return-Path: virtio-dev-return-5660-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 83710985E1D
	for <virtio-dev@lists.oasis-open.org>; Thu, 11 Apr 2019 09:02:37 +0000 (UTC)
Date: Thu, 11 Apr 2019 05:02:33 -0400 (EDT)
From: Pankaj Gupta <pagupta@redhat.com>
Message-ID: <952782165.20990220.1554973353161.JavaMail.zimbra@redhat.com>
In-Reply-To: <20190410144245.GD9868@stefanha-x1.localdomain>
References: <20190326143507.12607-1-pagupta@redhat.com> <20190410144245.GD9868@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [RFC] virtio-pmem: PMEM device spec
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, mst@redhat.com, david@redhat.com, riel@surriel.com, dan j williams <dan.j.williams@intel.com>, aarcange@redhat.com, cohuck@redhat.com, lcapitulino@redhat.com, nilal@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>


Hi Stefan,

Thank you for the review. Please find my reply inline.

> > diff --git a/virtio-pmem.tex b/virtio-pmem.tex
> > new file mode 100644
> > index 0000000..04e07bb
> > --- /dev/null
> > +++ b/virtio-pmem.tex
> > @@ -0,0 +1,134 @@
> > +\section{PMEM Device}\label{sec:Device Types / PMEM Device}
> > +
> > +The virtio pmem is a fake persistent memory (NVDIMM) device
> > +used to bypass the guest page cache and provide a virtio
> > +based asynchronous flush mechanism. This avoids the need
> 
> Is there anything "fake" about virtio-pmem from the perspective of the
> device interface?

I think I should remove fake Keyword here.

> 
> What you are describing is one use case.  But on a platform that doesn't
> have existing physical NVDIMM interfaces, ACPI, etc maybe virtio-pmem
> would be used to pass through physical NVDIMMs from the host?  If you
> agree, then it might make sense to describe the device simply as a
> persistent memory device and give "fake NVDIMM" as an example use case
> in a separate paragraph.  This would make the text more future-proof.

Yes, good point point. I will add a separate paragraph for "fake NVDIMM"
as an example usecase. 

> 
> > +of a separate page cache in guest and keeps page cache only
> > +in the host. Under memory pressure, the host makes use of
> > +effecient memory reclaim decisions for page cache pages
> 
> efficient

o.k

> 
> Please use a spell-checker like aspell or ispell.

Sure.

> 
> > +of all the guests. This helps to reduce the memory footprint
> > +and fit more guests in the host system.
> > +
> > +\subsection{Device ID}\label{sec:Device Types / PMEM Device / Device ID}
> > +  25
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
> > +	le64 start;
> > +	le64 size;
> > +};
> > +\end{lstlisting}
> > +
> > +\field{start} contains the guest physical address of the start of the
> > +physical address range to be hotplugged into the guest address space
> > +using the pmem API.
> 
> What pmem API?  This specification shouldn't be written from a Linux
> kernel internals point of view.  It should be possible to implement BSD,
> Windows, etc drivers too.

o.k. will change this to generic naming common to other operating systems.

> 
> Just saying that this is the physical address of the start of the
> persistent memory range is enough.
> 
> > +\field{size} contains the length of this address range.
> 
> "in bytes" would be nice because it makes the units explicit.

yes.

> 
> > +
> > +\subsection{Device Initialization}\label{sec:Device Types / PMEM Device /
> > Device Initialization}
> > +
> > +Device hotplugs physical memory to guest address space. Persistent memory
> > device
> > +is emulated with file backed memory at host side.
> 
> File-backed memory is a detail of one possible use case.  The spec
> shouldn't be tied to this single use case.

o.k. Will try to make more generic text here as well. I think I need to consider
all the use-cases with real NVDIMM and file backed memory on regular disk?  

> 
> > +
> > +\begin{enumerate}
> > +\item Guest vpmem start is read from \field{start}.
> > +\item Guest vpmem end is read from \field{size}.
> > +\end{enumerate}
> 
> "vpmem" is not defined.  Please use consistent terminology.

o.k

> 
> I suggest structuring this subsection as follows:
> 
>   Initialization proceeds as follows:
> 
>   \begin{enumerate}
>   \item The driver reads the physical start address from \field{start}.
>   \item The driver reads the length of the persistent memory range from
>   \field{size}.
>   \end{enumerate}
> 
> > +
> > +\devicenormative{\subsubsection}{Device Initialization}{Device Types /
> > PMEM Device / Device Initialization}
> > +
> > +File backed memory SHOULD be memory mapped to guest address space with
> > SHARED
> > +memory mapping.
> 
> I'm not sure this point is appropriate for the virtio spec since it's a
> device implementation detail.  This is outside the scope of the device
> interface and should be dropped.
> 
> If you'd like to describe the file-backed memory use case, please do it
> in a non-normative section and use the appropriate terminology
> (MAP_SHARED) and explanations (shared mapping so that changes will be
> written back to the file).

I omitted MAP_SHARED because I thought its not generic to other operating system 
(e.g Windows).

> 
> > +
> > +\subsection{Driver Initialization}\label{sec:Device Types / PMEM Driver /
> > Driver Initialization}
> > +
> > +Driver hotplugs the physical memory and registers associated
> > +region with the pmem API. Also, configures a flush callback
> > +function with the corresponding region.
> 
> There are Linux internals that don't need to be in the spec.  Some
> kernels may not have a similar pmem API with a flush callback,
> registration, etc.

Agree.

> 
> Please describe the functionality instead:
> 
>   Memory stores to the persistent memory range are not guaranteed to be
>   persistent without further action.  An explicit flush command is
>   required to ensure persistence.  The req_vq is used to perform flush
>   commands.

This is better.

> 
> > +
> > +\drivernormative{\subsubsection}{Driver Initialization: Filesystem direct
> > access}{Device Types / PMEM Driver / Driver Initialization / Direct
> > access}
> > +
> > +Driver SHOULD enable filesystem direct access operations for
> > +read/write on the device.
> 
> This is specific to one possible use case for virtio-pmem and it's a
> driver implementation detail, not a requirement of the device interface.
> 
> Imagine a unikernel application that doesn't have a file system.  They
> just want to access the persistent memory range, they don't care about
> filesystem direct access.

Agree.

> 
> Please focus on the requirements/constraints/assumptions of the device
> interface, not the implementation details of the device emulation or the
> Linux guest driver.  That way the specification will be generally useful
> and will age better as the use cases change.

o.k

> 
> > +
> > +\drivernormative{\subsubsection}{Driver Initialization: Virtio
> > flush}{Device Types / PMEM Driver / Driver Initialization / Virtio flush}
> > +
> > +Driver SHOULD add implement a virtio based flush callback.
> 
> If flush is optional, how should a device that does not implement it
> behave:
> 1. Don't implement req_vq
> Or
> 2. Fail flush commands with a certain error code
> ?

I think this needs to be structured again after non ACPI real NVDIMM passthrough
use-case which you pointed above.

> 
> > +Driver SHOULD disable other FLUSH/SYNC mechanisms for the device
> > +when virtio flush is configured.
> 
> What does this mean?

Either Virtio based flush is enabled or alternative flush (e.g MAP_SYNC is enabled).

> 
> > +
> > +\subsection{Driver Operations}\label{sec:Device Types / PMEM Driver /
> > Driver Operation}
> > +\drivernormative{\subsubsection}{Driver Operation: Virtqueue
> > command}{Device Types / PMEM Driver / Driver Operation / Virtqueue
> > command}
> > +
> > +Driver SHOULD send VIRTIO_FLUSH command on request virtqueue,
> > +blocks guest userspace process utill host completes fsync/flush.
> 
> userspace processes are outside the scope of the virtio specification.
> There may be no "userspace" inside the guest.  Please stick to
> describing the device interface.
> 
> I think the intention here is:
> 
>   The VIRTIO_FLUSH command persists memory writes that were performed
>   before the command was submitted.  Once the command completes the
>   writes are guaranteed to be persistent.
> 
> And the normative part is:
> 
>   The driver MUST submit a VIRTIO_FLUSH command after performing memory
>   writes that require persistence.
> 
>   The driver MUST wait for the VIRTIO_FLUSH command to complete before
>   assuming previous writes are persistent.

Thanks! this is better.

> 
> > +Driver SHOULD handle multiple fsync requests on files present
> > +on the device.
> 
> fsync is outside the scope of the device interface and, hence, this
> specification.  Perhaps:
> 
>   The driver MAY have multiple VIRTIO_FLUSH commands pending, though
>   each command completion only guarantees persistence of memory writes
>   that were performed before the command was submitted.

o.k

> 
> > +\subsection{Device Operations}\label{sec:Device Types / PMEM Driver /
> > Device Operation}
> > +
> > +\devicenormative{\subsubsection}{Device Operations}{Device Types / PMEM
> > Device / Device Operation / Virtqueue flush}
> > +
> > +Device SHOULD handle multiple flush requests simultaneously using
> > +host filesystem fsync/flush call.
> 
> fsync/flush is an implementation detail.  I'll stop reviewing at this
> point to avoid repetition :).

Thanks you very much for in detail review. I will work on the suggestions.

Best regards,
Pankaj
> 

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

