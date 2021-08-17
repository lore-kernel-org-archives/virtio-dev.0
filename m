Return-Path: <stefanha@redhat.com>
Date: Tue, 17 Aug 2021 16:26:13 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v2] virtio-pmem: PMEM device spec
Message-ID: <YRvVFbhQ83kY2xKw@stefanha-x1.localdomain>
References: <20210813095216.487591-1-pankaj.gupta.linux@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="R7sjyZoQHlOLP/GH"
Content-Disposition: inline
In-Reply-To: <20210813095216.487591-1-pankaj.gupta.linux@gmail.com>
To: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: virtio-dev@lists.oasis-open.org, dan.j.williams@intel.com, david@redhat.com, mst@redhat.com, cohuck@redhat.com, tstark@linux.microsoft.com, pankaj.gupta@ionos.com
List-ID: <virtio-dev.lists.oasis-open.org>


--R7sjyZoQHlOLP/GH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 13, 2021 at 11:52:16AM +0200, Pankaj Gupta wrote:
> +\section{PMEM Device}\label{sec:Device Types / PMEM Device}
> +
> +The virtio pmem device is a persistent memory (NVDIMM) device
> +provide a virtio based asynchronous flush mechanism. This avoids the

s/provide/that provides/

> +need of a separate page cache in the guest and keeps the page cache
> +only in the host. Under memory pressure, the host makes use of
> +efficient memory reclaim decisions for page cache pages of all the
> +guests. This helps to reduce the memory footprint and fit more guests

s/fit/fits/

> +in the host system.
> +
> +The virtio pmem device provides access to byte-addressable persistent
> +memory. The persist memory is directly accessible as a Shared Memory Region.

This patch doesn't describe the Shared Memory Region:

s/Shared Memory Region/range of system memory/

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
> +\item[\field{start}] contains the start address from the device physical address range
> +to be hotplugged into the driver address space.

"device physical address" is not a term defined in the specification.
Addresses are either physical memory addresses or platform-specific
translated addresses (VIRTIO_F_ACCESS_PLATFORM). Both are called
"physical address" in the spec. Hotplugging into the "driver address
space" is also undefined.

I suggest:

  contains the physical address of the first byte of the persistent
  memory region.

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
> +The driver determines the start address and size of the persist memory region in preparation for reading or writing data.

s/persist/persistent/

> +
> +The driver initializes req_vq in preparation for making flush requests.
> +
> +\drivernormative{\subsubsection}{Driver Initialization: Virtio flush}{Device Types / PMEM Driver / Driver Initialization / Virtio flush}
> +
> +The driver MUST implement a virtio based flushing interface.

I think this can be dropped. The only way to make writes persistent is
by sending flush requests. There is no need to say that the driver has
to use this interface. It doesn't really have to, but then it won't be
able to guarantee persistence.

> +
> +\subsection{Driver Operations}\label{sec:Device Types / PMEM Driver / Driver Operation}
> +\drivernormative{\subsubsection}{Driver Operation: Virtqueue command}{Device Types / PMEM Driver / Driver Operation / Virtqueue command}
> +
> +\begin{lstlisting}
> +struct virtio_pmem_req {
> +        __le32 type;

The spec uses le32 instead of __le32.

> +};
> +\end{lstlisting}
> +
> +Virtio pmem flush request:
> +\begin{lstlisting}
> +#define VIRTIO_PMEM_REQ_TYPE_FLUSH      0
> +\end{lstlisting}
> +
> +The driver MUST send VIRTIO_PMEM_REQ_TYPE_FLUSH command on request virtqueue.

What does this mean?

> +
> +The driver SHOULD be able to handle concurrent FLUSH requests.

I think this statement can be dropped. The driver submits the flush
requests, so it doesn't make sense to say it has to handle concurrent
flush requests. Nothing forces the driver to have multiple requests in
flight at the same time. If the driver doesn't want to have concurrent
flush requests it can submit them sequentially.

> +
> +\subsection{Device Operations}\label{sec:Device Types / PMEM Driver / Device Operation}
> +\devicenormative{\subsubsection}{Device Operation: Virtqueue flush}{Device Types / PMEM Device / Device Operation / Virtqueue flush}
> +
> +The device MUST ensure that all writes made before a flush request will persist across device reset and power failure before completing the flush request.
> +
> +\devicenormative{\subsubsection}{Device Operation: Virtqueue return}{Device Types / PMEM Device / Device Operation / Virtqueue return}
> +
> +The device MUST return integer "0" for success and "-1" for failure.

What type of integer? le32?

How is this returned, I don't see a struct definition, diagram, or table
showing the request layout?

--R7sjyZoQHlOLP/GH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmEb1RUACgkQnKSrs4Gr
c8hpNAf3UdnUp/jQZ/eBs1q1ddTKUsFiyYqZdWch7T7CR2nrL9JDkSdqB8A280Nk
//MPLsU3eYfDSlvSKNH74sMXm4N2pQofSSEX9lH8cQG9T+1+Rj9t3EqL6q77+j/h
y3s/RXK9qXuW6AM7V9s8LEF/UHcNJn59ZRpnpkgt1HkXe6OQAfZevilvAYmcxCRc
GALe2Zn+3vD3uK8pCrKirqUYGH1atQdVtoV8bQ2Id8xM9I27bGr+1OAt0g+ZL0vp
8DyA1y7KsvpiV6bV83m1ZzfxqRFaje0buUhHQxsiuLMv0ekk+cYZ8WRCQiobpitD
TUk9nxhho59zY7x5q/BCJg2xR5W6
=t3vE
-----END PGP SIGNATURE-----

--R7sjyZoQHlOLP/GH--

