Return-Path: <virtio-dev-return-8496-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B71ED986529
	for <virtio-dev@lists.oasis-open.org>; Wed,  4 Aug 2021 12:43:08 +0000 (UTC)
MIME-Version: 1.0
References: <20210728150435.264551-1-pankaj.gupta.linux@gmail.com>
 <YQp1D+Ece28livMx@stefanha-x1.localdomain> <dee2aab6-c0a7-3af6-4d4a-f0be75e2a92b@redhat.com>
 <YQqJAVa/qjy+NOrN@stefanha-x1.localdomain>
In-Reply-To: <YQqJAVa/qjy+NOrN@stefanha-x1.localdomain>
From: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date: Wed, 4 Aug 2021 14:42:56 +0200
Message-ID: <CAM9Jb+jKVhukS_-k0u89bh6_g1EjozrTqcLzHw=+FRi2fzOmxA@mail.gmail.com>
Subject: Re: [virtio-dev] [PATCH RESEND] virtio-pmem: PMEM device spec
Content-Type: text/plain; charset="UTF-8"
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, virtio-dev@lists.oasis-open.org, Dan Williams <dan.j.williams@intel.com>, "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Taylor Stark <tstark@linux.microsoft.com>, Pankaj Gupta <pankaj.gupta@ionos.com>
List-ID: <virtio-dev.lists.oasis-open.org>

> > On 04.08.21 13:07, Stefan Hajnoczi wrote:
> > > On Wed, Jul 28, 2021 at 05:04:35PM +0200, Pankaj Gupta wrote:
> > > > +\subsection{Device configuration layout}\label{sec:Device Types / PMEM Device / Device configuration layout}
> > > > +
> > > > +\begin{lstlisting}
> > > > +struct virtio_pmem_config {
> > > > + le64 start;
> > > > + le64 size;
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

You mean in the patch with parent spec?

>
> Although the difference between configuration space parameters and a
> shared memory region might seem trivial, I think using the shared memory
> region is worthwhile because it makes the memory region a first-class
> concept in the VIRTIO device model that is supported by the driver and
> device emulation infrastructure.
>
> Stefan

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

