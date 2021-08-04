Return-Path: <tstark@linux.microsoft.com>
Date: Wed, 4 Aug 2021 15:58:49 -0700
From: Taylor Stark <tstark@linux.microsoft.com>
Subject: Re: [virtio-dev] [PATCH RESEND] virtio-pmem: PMEM device spec
Message-ID: <20210804225849.GA23364@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20210728150435.264551-1-pankaj.gupta.linux@gmail.com>
 <YQp1D+Ece28livMx@stefanha-x1.localdomain>
 <dee2aab6-c0a7-3af6-4d4a-f0be75e2a92b@redhat.com>
 <YQqJAVa/qjy+NOrN@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <YQqJAVa/qjy+NOrN@stefanha-x1.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, virtio-dev@lists.oasis-open.org, dan.j.williams@intel.com, mst@redhat.com, cohuck@redhat.com, pankaj.gupta@ionos.com, tstark@microsoft.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Aug 04, 2021 at 01:33:05PM +0100, Stefan Hajnoczi wrote:
> On Wed, Aug 04, 2021 at 01:11:52PM +0200, David Hildenbrand wrote:
> > On 04.08.21 13:07, Stefan Hajnoczi wrote:
> > > On Wed, Jul 28, 2021 at 05:04:35PM +0200, Pankaj Gupta wrote:
> > > > +\subsection{Device configuration layout}\label{sec:Device Types / PMEM Device / Device configuration layout}
> > > > +
> > > > +\begin{lstlisting}
> > > > +struct virtio_pmem_config {
> > > > +	le64 start;
> > > > +	le64 size;
> > > > +};
> > > > +\end{lstlisting}
> > > > +
> > > > +\begin{description}
> > > > +\item[\field{start}] contains the start address from the guest physical address range
> > > > +to be hotplugged into the guest address space using the pmem API.
> > > > +
> > > > +\item[\field{size}] contains the length of this address range.
> > > > +\end{description}
> > > 
> > > Please use a Shared Memory Region instead. This is a relatively new
> > > addition to the VIRTIO device model that seems like a good fit for this
> > > device:
> > > https://github.com/oasis-tcs/virtio-spec/blob/master/shared-mem.tex
> > 
> > Note that virtio-pmem is already upstream in QEMU and in Linux using this
> > model. There is a proposal to optionally use shared memory for exposing the
> > area, to be unlocked with a feature bit.
> 
> Please incorporate the proposal into this patch. A feature bit is a good
> way of handling this case.
> 
> Although the difference between configuration space parameters and a
> shared memory region might seem trivial, I think using the shared memory
> region is worthwhile because it makes the memory region a first-class
> concept in the VIRTIO device model that is supported by the driver and
> device emulation infrastructure.
> 
> Stefan

For what it's worth, here's the proposal to add support for shared memory regions:
https://lists.oasis-open.org/archives/virtio-comment/202107/msg00169.html

The original plan was to have the base spec go in first, and then consider the
proposal. Do you think it's better to include the shared memory region proposal
from the start?

Thanks,
Taylor

