Return-Path: <stefanha@redhat.com>
Date: Thu, 2 Sep 2021 10:07:54 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v3] virtio-pmem: PMEM device spec
Message-ID: <YTCUamWUA24yt3g0@stefanha-x1.localdomain>
References: <20210902054033.75455-1-pankaj.gupta.linux@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Na+ymneyKy9N63OO"
Content-Disposition: inline
In-Reply-To: <20210902054033.75455-1-pankaj.gupta.linux@gmail.com>
To: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: virtio-dev@lists.oasis-open.org, dan.j.williams@intel.com, david@redhat.com, mst@redhat.com, cohuck@redhat.com, tstark@linux.microsoft.com, pankaj.gupta@ionos.com
List-ID: <virtio-dev.lists.oasis-open.org>


--Na+ymneyKy9N63OO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 02, 2021 at 07:40:33AM +0200, Pankaj Gupta wrote:
> diff --git a/virtio-pmem.tex b/virtio-pmem.tex
> new file mode 100644
> index 0000000..6f1b504
> --- /dev/null
> +++ b/virtio-pmem.tex
> @@ -0,0 +1,122 @@
> +\section{PMEM Device}\label{sec:Device Types / PMEM Device}
> +
> +The virtio pmem device is a persistent memory (NVDIMM) device
> +that provides a virtio based asynchronous flush mechanism. This avoids
> +the need of a separate page cache in the guest and keeps the page cache
> +only in the host. Under memory pressure, the host makes use of
> +efficient memory reclaim decisions for page cache pages of all the
> +guests. This helps to reduce the memory footprint and fits more guests
> +in the host system.
> +
> +The virtio pmem device provides access to byte-addressable persistent
> +memory. The persist memory is directly accessible range of system memory.

s/is directly accessible range/is a directly accessible range/

> +Data written to this memory is made persistent by separately sending a
> +flush command. Writes that have been flushed are preserved across device
> +reset and power failure.
> +
> +\subsection{Device ID}\label{sec:Device Types / PMEM Device / Device ID}
> +  27
> +
> +\subsection{Virtqueues}\label{sec:Device Types / PMEM Device / Virtqueue=
s}
> +\begin{description}
> +\item[0] req_vq
> +\end{description}
> +
> +\subsection{Feature bits}\label{sec:Device Types / PMEM Device / Feature=
 bits}
> +
> +There are currently no feature bits defined for this device.
> +
> +\subsection{Device configuration layout}\label{sec:Device Types / PMEM D=
evice / Device configuration layout}
> +
> +\begin{lstlisting}
> +struct virtio_pmem_config {
> +	le64 start;
> +	le64 size;
> +};
> +\end{lstlisting}
> +
> +\begin{description}
> +\item[\field{start}] contains the physical address of the first byte of =
the persistent memory region.
> +
> +\item[\field{size}] contains the length of this address range.
> +\end{description}
> +
> +\begin{enumerate}
> +\item Driver vpmem start is read from \field{start}.
> +\item Driver vpmem end is read from \field{size}.
> +\end{enumerate}
> +
> +\subsection{Driver Initialization}\label{sec:Device Types / PMEM Driver =
/ Driver Initialization}
> +
> +The driver determines the start address and size of the persistent memor=
y region in preparation for reading or writing data.
> +
> +The driver initializes req_vq in preparation for making flush requests.
> +
> +\subsection{Driver Operations}\label{sec:Device Types / PMEM Driver / Dr=
iver Operation / Request Queues}
> +
> +Requests have the following format:
> +
> +\begin{lstlisting}
> +struct virtio_pmem_req {
> +        le32 type;
> +};
> +\end{lstlisting}
> +
> +\field{type} is the request command type.=20

Where are the type constants defined? I was expecting a flush request
type constant:

  /* Request types */
  #define VIRTIO_PMEM_REQ_T_FLUSH 0

> +
> +\subsection{Device Operations}\label{sec:Device Types / PMEM Driver / De=
vice Operation}
> +\devicenormative{\subsubsection}{Device Operation: Virtqueue flush}{Devi=
ce Types / PMEM Device / Device Operation / Virtqueue flush}
> +
> +The device MUST ensure that all writes made before a flush request will =
persist across device reset and power failure before completing the flush r=
equest.

"made" is vague, does it mean "submitted" or "completed". I suggest
tweaking the language:

"writes completed before a flush request persist ..."

--Na+ymneyKy9N63OO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmEwlGoACgkQnKSrs4Gr
c8h0awf/WJMihEl8IpkAfl9WZUgKlaJXt5cRfFctJQoGyv+DgJnKHX+YjcHIUfz2
8ucpavnKZOnUlWxQI2sZKJSOQpUpLKKVBEcy13beY/U7X0RGBK7nxIcWYKVVuIZi
h3p6e0G7PW9w3baDKfSFBYnVzRZzUqzfqSy01SZ5qewbtg6Da6X6e0Cg5nAvzZyD
XNwfou3YXmy6JMxCMNGY3RWJx2gupxYXtCht8TDXAU/uN9F2QXxLluzV16YWxMH8
3okbvJCh1hwVQ/jnNbATo/bWES68tcUEVLdhm0Z5ysSFwabGmyIBwFTYXH4NiCxe
MvucaykotWsmhjpNkvTKUo+EYNNwzg==
=Bvjy
-----END PGP SIGNATURE-----

--Na+ymneyKy9N63OO--

