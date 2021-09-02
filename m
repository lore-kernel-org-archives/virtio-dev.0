Return-Path: <pankaj.gupta.linux@gmail.com>
MIME-Version: 1.0
References: <20210902054033.75455-1-pankaj.gupta.linux@gmail.com> <YTCUamWUA24yt3g0@stefanha-x1.localdomain>
In-Reply-To: <YTCUamWUA24yt3g0@stefanha-x1.localdomain>
From: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date: Thu, 2 Sep 2021 11:18:39 +0200
Message-ID: <CAM9Jb+hqv-WRrhSObpaTvKwWE+bEgdHC_ck85wdj=guYjFUssw@mail.gmail.com>
Subject: Re: [PATCH v3] virtio-pmem: PMEM device spec
Content-Type: text/plain; charset="UTF-8"
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, Dan Williams <dan.j.williams@intel.com>, David Hildenbrand <david@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Taylor Stark <tstark@linux.microsoft.com>, Pankaj Gupta <pankaj.gupta@ionos.com>
List-ID: <virtio-dev.lists.oasis-open.org>

> > diff --git a/virtio-pmem.tex b/virtio-pmem.tex
> > new file mode 100644
> > index 0000000..6f1b504
> > --- /dev/null
> > +++ b/virtio-pmem.tex
> > @@ -0,0 +1,122 @@
> > +\section{PMEM Device}\label{sec:Device Types / PMEM Device}
> > +
> > +The virtio pmem device is a persistent memory (NVDIMM) device
> > +that provides a virtio based asynchronous flush mechanism. This avoids
> > +the need of a separate page cache in the guest and keeps the page cache
> > +only in the host. Under memory pressure, the host makes use of
> > +efficient memory reclaim decisions for page cache pages of all the
> > +guests. This helps to reduce the memory footprint and fits more guests
> > +in the host system.
> > +
> > +The virtio pmem device provides access to byte-addressable persistent
> > +memory. The persist memory is directly accessible range of system memory.
>
> s/is directly accessible range/is a directly accessible range/

o.k

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
> > +\item[\field{start}] contains the physical address of the first byte of the persistent memory region.
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
> > +The driver determines the start address and size of the persistent memory region in preparation for reading or writing data.
> > +
> > +The driver initializes req_vq in preparation for making flush requests.
> > +
> > +\subsection{Driver Operations}\label{sec:Device Types / PMEM Driver / Driver Operation / Request Queues}
> > +
> > +Requests have the following format:
> > +
> > +\begin{lstlisting}
> > +struct virtio_pmem_req {
> > +        le32 type;
> > +};
> > +\end{lstlisting}
> > +
> > +\field{type} is the request command type.
>
> Where are the type constants defined? I was expecting a flush request
> type constant:
>
>   /* Request types */
>   #define VIRTIO_PMEM_REQ_T_FLUSH 0

Removed this in current version. Thinking this might be driver specific detail.
Will add again.

>
> > +
> > +\subsection{Device Operations}\label{sec:Device Types / PMEM Driver / Device Operation}
> > +\devicenormative{\subsubsection}{Device Operation: Virtqueue flush}{Device Types / PMEM Device / Device Operation / Virtqueue flush}
> > +
> > +The device MUST ensure that all writes made before a flush request will persist across device reset and power failure before completing the flush request.
>
> "made" is vague, does it mean "submitted" or "completed". I suggest
> tweaking the language:
>
> "writes completed before a flush request persist ..."

yes, "completed"

Thanks,
Pankaj

