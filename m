Return-Path: virtio-dev-return-5658-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 889F5985E03
	for <virtio-dev@lists.oasis-open.org>; Wed, 10 Apr 2019 14:42:55 +0000 (UTC)
Date: Wed, 10 Apr 2019 15:42:45 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190410144245.GD9868@stefanha-x1.localdomain>
References: <20190326143507.12607-1-pagupta@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VV4b6MQE+OnNyhkM"
Content-Disposition: inline
In-Reply-To: <20190326143507.12607-1-pagupta@redhat.com>
Subject: [virtio-dev] Re: [RFC] virtio-pmem: PMEM device spec
To: Pankaj Gupta <pagupta@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, mst@redhat.com, david@redhat.com, riel@surriel.com, dan.j.williams@intel.com, aarcange@redhat.com, cohuck@redhat.com, lcapitulino@redhat.com, nilal@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

--VV4b6MQE+OnNyhkM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 26, 2019 at 08:05:07PM +0530, Pankaj Gupta wrote:
> diff --git a/virtio-pmem.tex b/virtio-pmem.tex
> new file mode 100644
> index 0000000..04e07bb
> --- /dev/null
> +++ b/virtio-pmem.tex
> @@ -0,0 +1,134 @@
> +\section{PMEM Device}\label{sec:Device Types / PMEM Device}
> +
> +The virtio pmem is a fake persistent memory (NVDIMM) device
> +used to bypass the guest page cache and provide a virtio
> +based asynchronous flush mechanism. This avoids the need

Is there anything "fake" about virtio-pmem from the perspective of the
device interface?

What you are describing is one use case.  But on a platform that doesn't
have existing physical NVDIMM interfaces, ACPI, etc maybe virtio-pmem
would be used to pass through physical NVDIMMs from the host?  If you
agree, then it might make sense to describe the device simply as a
persistent memory device and give "fake NVDIMM" as an example use case
in a separate paragraph.  This would make the text more future-proof.

> +of a separate page cache in guest and keeps page cache only
> +in the host. Under memory pressure, the host makes use of
> +effecient memory reclaim decisions for page cache pages

efficient

Please use a spell-checker like aspell or ispell.

> +of all the guests. This helps to reduce the memory footprint
> +and fit more guests in the host system.
> +
> +\subsection{Device ID}\label{sec:Device Types / PMEM Device / Device ID}
> +  25
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
> +\field{start} contains the guest physical address of the start of the
> +physical address range to be hotplugged into the guest address space
> +using the pmem API.

What pmem API?  This specification shouldn't be written from a Linux
kernel internals point of view.  It should be possible to implement BSD,
Windows, etc drivers too.

Just saying that this is the physical address of the start of the
persistent memory range is enough.

> +\field{size} contains the length of this address range.

"in bytes" would be nice because it makes the units explicit.

> +
> +\subsection{Device Initialization}\label{sec:Device Types / PMEM Device / Device Initialization}
> +
> +Device hotplugs physical memory to guest address space. Persistent memory device
> +is emulated with file backed memory at host side.

File-backed memory is a detail of one possible use case.  The spec
shouldn't be tied to this single use case.

> +
> +\begin{enumerate}
> +\item Guest vpmem start is read from \field{start}.
> +\item Guest vpmem end is read from \field{size}.
> +\end{enumerate}

"vpmem" is not defined.  Please use consistent terminology.

I suggest structuring this subsection as follows:

  Initialization proceeds as follows:

  \begin{enumerate}
  \item The driver reads the physical start address from \field{start}.
  \item The driver reads the length of the persistent memory range from \field{size}.
  \end{enumerate}

> +
> +\devicenormative{\subsubsection}{Device Initialization}{Device Types / PMEM Device / Device Initialization}
> +
> +File backed memory SHOULD be memory mapped to guest address space with SHARED
> +memory mapping.

I'm not sure this point is appropriate for the virtio spec since it's a
device implementation detail.  This is outside the scope of the device
interface and should be dropped.

If you'd like to describe the file-backed memory use case, please do it
in a non-normative section and use the appropriate terminology
(MAP_SHARED) and explanations (shared mapping so that changes will be
written back to the file).

> +
> +\subsection{Driver Initialization}\label{sec:Device Types / PMEM Driver / Driver Initialization}
> +
> +Driver hotplugs the physical memory and registers associated
> +region with the pmem API. Also, configures a flush callback
> +function with the corresponding region.

There are Linux internals that don't need to be in the spec.  Some
kernels may not have a similar pmem API with a flush callback,
registration, etc.

Please describe the functionality instead:

  Memory stores to the persistent memory range are not guaranteed to be
  persistent without further action.  An explicit flush command is
  required to ensure persistence.  The req_vq is used to perform flush
  commands.

> +
> +\drivernormative{\subsubsection}{Driver Initialization: Filesystem direct access}{Device Types / PMEM Driver / Driver Initialization / Direct access}
> +
> +Driver SHOULD enable filesystem direct access operations for
> +read/write on the device.

This is specific to one possible use case for virtio-pmem and it's a
driver implementation detail, not a requirement of the device interface.

Imagine a unikernel application that doesn't have a file system.  They
just want to access the persistent memory range, they don't care about
filesystem direct access.

Please focus on the requirements/constraints/assumptions of the device
interface, not the implementation details of the device emulation or the
Linux guest driver.  That way the specification will be generally useful
and will age better as the use cases change.

> +
> +\drivernormative{\subsubsection}{Driver Initialization: Virtio flush}{Device Types / PMEM Driver / Driver Initialization / Virtio flush}
> +
> +Driver SHOULD add implement a virtio based flush callback.

If flush is optional, how should a device that does not implement it
behave:
1. Don't implement req_vq
Or
2. Fail flush commands with a certain error code
?

> +Driver SHOULD disable other FLUSH/SYNC mechanisms for the device
> +when virtio flush is configured.

What does this mean?

> +
> +\subsection{Driver Operations}\label{sec:Device Types / PMEM Driver / Driver Operation}
> +\drivernormative{\subsubsection}{Driver Operation: Virtqueue command}{Device Types / PMEM Driver / Driver Operation / Virtqueue command}
> +
> +Driver SHOULD send VIRTIO_FLUSH command on request virtqueue,
> +blocks guest userspace process utill host completes fsync/flush.

userspace processes are outside the scope of the virtio specification.
There may be no "userspace" inside the guest.  Please stick to
describing the device interface.

I think the intention here is:

  The VIRTIO_FLUSH command persists memory writes that were performed
  before the command was submitted.  Once the command completes the
  writes are guaranteed to be persistent.

And the normative part is:

  The driver MUST submit a VIRTIO_FLUSH command after performing memory
  writes that require persistence.

  The driver MUST wait for the VIRTIO_FLUSH command to complete before
  assuming previous writes are persistent.

> +Driver SHOULD handle multiple fsync requests on files present
> +on the device.

fsync is outside the scope of the device interface and, hence, this
specification.  Perhaps:

  The driver MAY have multiple VIRTIO_FLUSH commands pending, though
  each command completion only guarantees persistence of memory writes
  that were performed before the command was submitted.

> +\subsection{Device Operations}\label{sec:Device Types / PMEM Driver / Device Operation}
> +
> +\devicenormative{\subsubsection}{Device Operations}{Device Types / PMEM Device / Device Operation / Virtqueue flush}
> +
> +Device SHOULD handle multiple flush requests simultaneously using
> +host filesystem fsync/flush call.

fsync/flush is an implementation detail.  I'll stop reviewing at this
point to avoid repetition :).

--VV4b6MQE+OnNyhkM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcrgDlAAoJEJykq7OBq3PIuvkH/1L12Y5xxEoXuV5IchUYJiWB
K/l1q2fFTfRZTBRXYfCf0kWU7/I4YHQOwx/OvWtA41hYkzgvVeN2TMJ/52gFqHYj
66vCsdf2n8xRGgmhcraAt0On+V5ju7mCkzDtN9ZJyLlz8Wmi5M/wi/xNh+RrDXqA
0U6iOxI6rFf85DyV0Zh69ypLR3q+8Aj0fcmpKHn66+/NvKIwlpEWsG95MSUW3opG
bJIwprbhNRI0pT7XffnCJYWMM0hNU2J31fuuNo4zLfD5ff6Vw5qwtsTMPDMos6Od
Gz3q8XWRXjUf8Pma8DpTWIBbcHIRM9ncKUjphNelRGAZVUvM+t70XbpDyVJJRjU=
=Bn7m
-----END PGP SIGNATURE-----

--VV4b6MQE+OnNyhkM--
