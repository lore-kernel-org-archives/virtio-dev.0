Return-Path: <pankaj.gupta.linux@gmail.com>
MIME-Version: 1.0
References: <20210813095216.487591-1-pankaj.gupta.linux@gmail.com> <YRvVFbhQ83kY2xKw@stefanha-x1.localdomain>
In-Reply-To: <YRvVFbhQ83kY2xKw@stefanha-x1.localdomain>
From: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date: Tue, 17 Aug 2021 22:11:55 +0200
Message-ID: <CAM9Jb+idw-LNTbEekYz9KkuYu4w+T4UbzLJoGfQULU=2Zd97ng@mail.gmail.com>
Subject: Re: [PATCH v2] virtio-pmem: PMEM device spec
Content-Type: text/plain; charset="UTF-8"
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, Dan Williams <dan.j.williams@intel.com>, David Hildenbrand <david@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Taylor Stark <tstark@linux.microsoft.com>, Pankaj Gupta <pankaj.gupta@ionos.com>
List-ID: <virtio-dev.lists.oasis-open.org>

> > +\section{PMEM Device}\label{sec:Device Types / PMEM Device}
> > +
> > +The virtio pmem device is a persistent memory (NVDIMM) device
> > +provide a virtio based asynchronous flush mechanism. This avoids the
>
> s/provide/that provides/

o.k

>
> > +need of a separate page cache in the guest and keeps the page cache
> > +only in the host. Under memory pressure, the host makes use of
> > +efficient memory reclaim decisions for page cache pages of all the
> > +guests. This helps to reduce the memory footprint and fit more guests
>
> s/fit/fits/

o.k

>
> > +in the host system.
> > +
> > +The virtio pmem device provides access to byte-addressable persistent
> > +memory. The persist memory is directly accessible as a Shared Memory Region.
>
> This patch doesn't describe the Shared Memory Region:
>
> s/Shared Memory Region/range of system memory/

Sure. Copy-pasted. Will correct.

>
> > +Data written to this memory is made persistent by separately sending a
> > +flush command. Writes that have been flushed are preserved across device
> > +reset and power failure.
> > +
> > +\subsection{Device ID}\label{sec:Device Types / PMEM Device / Device ID}
> > +  27
> > +
> > +\subsection{Virtqueues}\label{sec:Device Types / PMEM Device / Virtqueues}
> > +\begin{description}
> > +\item[0] req_vq
> > +\end{description}
> > +
> > +\subsection{Feature bits}\label{sec:Device Types / PMEM Device / Feature bits}
> > +
> > +There are currently no feature bits defined for this device.
> > +
> > +\subsection{Device configuration layout}\label{sec:Device Types / PMEM Device / Device configuration layout}
> > +
> > +\begin{lstlisting}
> > +struct virtio_pmem_config {
> > +     le64 start;
> > +     le64 size;
> > +};
> > +\end{lstlisting}
> > +
> > +\begin{description}
> > +\item[\field{start}] contains the start address from the device physical address range
> > +to be hotplugged into the driver address space.
>
> "device physical address" is not a term defined in the specification.
> Addresses are either physical memory addresses or platform-specific
> translated addresses (VIRTIO_F_ACCESS_PLATFORM). Both are called
> "physical address" in the spec. Hotplugging into the "driver address
> space" is also undefined.
>
> I suggest:
>
>   contains the physical address of the first byte of the persistent
>   memory region.

Sure.
>
> > +
> > +\item[\field{size}] contains the length of this address range.
> > +\end{description}
> > +
> > +\begin{enumerate}
> > +\item Driver vpmem start is read from \field{start}.
> > +\item Driver vpmem end is read from \field{size}.
> > +\end{enumerate}
> > +
> > +\subsection{Driver Initialization}\label{sec:Device Types / PMEM Driver / Driver Initialization}
> > +
> > +The driver determines the start address and size of the persist memory region in preparation for reading or writing data.
>
> s/persist/persistent/

Sure.

>
> > +
> > +The driver initializes req_vq in preparation for making flush requests.
> > +
> > +\drivernormative{\subsubsection}{Driver Initialization: Virtio flush}{Device Types / PMEM Driver / Driver Initialization / Virtio flush}
> > +
> > +The driver MUST implement a virtio based flushing interface.
>
> I think this can be dropped. The only way to make writes persistent is
> by sending flush requests. There is no need to say that the driver has
> to use this interface. It doesn't really have to, but then it won't be
> able to guarantee persistence.

I am not 100 percent sure on this.

>
> > +
> > +\subsection{Driver Operations}\label{sec:Device Types / PMEM Driver / Driver Operation}
> > +\drivernormative{\subsubsection}{Driver Operation: Virtqueue command}{Device Types / PMEM Driver / Driver Operation / Virtqueue command}
> > +
> > +\begin{lstlisting}
> > +struct virtio_pmem_req {
> > +        __le32 type;
>
> The spec uses le32 instead of __le32.

o.k

>
> > +};
> > +\end{lstlisting}
> > +
> > +Virtio pmem flush request:
> > +\begin{lstlisting}
> > +#define VIRTIO_PMEM_REQ_TYPE_FLUSH      0
> > +\end{lstlisting}
> > +
> > +The driver MUST send VIRTIO_PMEM_REQ_TYPE_FLUSH command on request virtqueue.
>
> What does this mean?

Will delete this as well.

>
> > +
> > +The driver SHOULD be able to handle concurrent FLUSH requests.
>
> I think this statement can be dropped. The driver submits the flush
> requests, so it doesn't make sense to say it has to handle concurrent
> flush requests. Nothing forces the driver to have multiple requests in
> flight at the same time. If the driver doesn't want to have concurrent
> flush requests it can submit them sequentially.

o.k. Sure.

>
> > +
> > +\subsection{Device Operations}\label{sec:Device Types / PMEM Driver / Device Operation}
> > +\devicenormative{\subsubsection}{Device Operation: Virtqueue flush}{Device Types / PMEM Device / Device Operation / Virtqueue flush}
> > +
> > +The device MUST ensure that all writes made before a flush request will persist across device reset and power failure before completing the flush request.
> > +
> > +\devicenormative{\subsubsection}{Device Operation: Virtqueue return}{Device Types / PMEM Device / Device Operation / Virtqueue return}
> > +
> > +The device MUST return integer "0" for success and "-1" for failure.
>
> What type of integer? le32?

yes. will add struct definition as well.

>
> How is this returned, I don't see a struct definition, diagram, or table
> showing the request layout?

Thank you!

