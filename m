Return-Path: <stefanha@redhat.com>
Date: Mon, 4 Oct 2021 10:34:35 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [virtio-dev] [PATCH v4] virtio-pmem: PMEM device spec
Message-ID: <YVrKq1rOFCMMpowE@stefanha-x1.localdomain>
References: <20210921102702.60259-1-pankaj.gupta.linux@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oGCRZ4vfjELobJB2"
Content-Disposition: inline
In-Reply-To: <20210921102702.60259-1-pankaj.gupta.linux@gmail.com>
To: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: virtio-dev@lists.oasis-open.org, dan.j.williams@intel.com, david@redhat.com, mst@redhat.com, cohuck@redhat.com, tstark@linux.microsoft.com, pankaj.gupta@ionos.com
List-ID: <virtio-dev.lists.oasis-open.org>


--oGCRZ4vfjELobJB2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 21, 2021 at 12:27:02PM +0200, Pankaj Gupta wrote:
> Posting virtio specification for virtio pmem device. Virtio pmem is a
> paravirtualized device which allows the guest to bypass page cache.
> Virtio pmem kernel driver is merged in Upstream Kernel 5.3. Also, Qemu
> device is merged in Qemu 4.1.
>=20
> Signed-off-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> ---
>  v3 -> v4
>   Define constant used in request type - Stefan
>   Small text change - Stefan
>=20
>  conformance.tex |  16 +++++-
>  content.tex     |   1 +
>  virtio-pmem.tex | 128 ++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 143 insertions(+), 2 deletions(-)
>  create mode 100644 virtio-pmem.tex
>=20
> diff --git a/conformance.tex b/conformance.tex
> index 94d7a06..7331003 100644
> --- a/conformance.tex
> +++ b/conformance.tex
> @@ -31,7 +31,8 @@ \section{Conformance Targets}\label{sec:Conformance / C=
onformance Targets}
>  \ref{sec:Conformance / Driver Conformance / Sound Driver Conformance},
>  \ref{sec:Conformance / Driver Conformance / Memory Driver Conformance},
>  \ref{sec:Conformance / Driver Conformance / I2C Adapter Driver Conforman=
ce} or
> -\ref{sec:Conformance / Driver Conformance / SCMI Driver Conformance}.
> +\ref{sec:Conformance / Driver Conformance / SCMI Driver Conformance},
> +\ref{sec:Conformance / Driver Conformance / PMEM Driver Conformance}.
> =20
>      \item Clause \ref{sec:Conformance / Legacy Interface: Transitional D=
evice and Transitional Driver Conformance}.
>    \end{itemize}
> @@ -55,7 +56,8 @@ \section{Conformance Targets}\label{sec:Conformance / C=
onformance Targets}
>  \ref{sec:Conformance / Device Conformance / Sound Device Conformance},
>  \ref{sec:Conformance / Device Conformance / Memory Device Conformance},
>  \ref{sec:Conformance / Device Conformance / I2C Adapter Device Conforman=
ce} or
> -\ref{sec:Conformance / Device Conformance / SCMI Device Conformance}.
> +\ref{sec:Conformance / Device Conformance / SCMI Device Conformance},
> +\ref{sec:Conformance / Device Conformance / PMEM Driver Conformance}.
> =20
>      \item Clause \ref{sec:Conformance / Legacy Interface: Transitional D=
evice and Transitional Driver Conformance}.
>    \end{itemize}
> @@ -301,6 +303,16 @@ \section{Conformance Targets}\label{sec:Conformance =
/ Conformance Targets}
>  \item \ref{drivernormative:Device Types / SCMI Device / Device Operation=
 / Setting Up eventq Buffers}
>  \end{itemize}
> =20
> +\conformance{\subsection}{PMEM Driver Conformance}\label{sec:Conformance=
 / Driver Conformance / PMEM Driver Conformance}
> +
> +A PMEM driver MUST conform to the following normative statements:
> +
> +\begin{itemize}
> +\item \ref{devicenormative:Device Types / PMEM Device / Device Initializ=
ation}
> +\item \ref{devicenormative:Device Types / PMEM Device / Device Operation=
 / Virtqueue flush}
> +\item \ref{devicenormative:Device Types / PMEM Device / Device Operation=
 / Virtqueue return}
> +\end{itemize}
> +
>  \conformance{\section}{Device Conformance}\label{sec:Conformance / Devic=
e Conformance}
> =20
>  A device MUST conform to the following normative statements:
> diff --git a/content.tex b/content.tex
> index 31b02e1..08d4a92 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -6583,6 +6583,7 @@ \subsubsection{Legacy Interface: Framing Requiremen=
ts}\label{sec:Device
>  \input{virtio-mem.tex}
>  \input{virtio-i2c.tex}
>  \input{virtio-scmi.tex}
> +\input{virtio-pmem.tex}
> =20
>  \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
> =20
> diff --git a/virtio-pmem.tex b/virtio-pmem.tex
> new file mode 100644
> index 0000000..4fad8a3
> --- /dev/null
> +++ b/virtio-pmem.tex
> @@ -0,0 +1,128 @@
> +\section{PMEM Device}\label{sec:Device Types / PMEM Device}
> +
> +The virtio pmem device is a persistent memory (NVDIMM) device
> +that provides a virtio based asynchronous flush mechanism. This avoids
> +the need of a separate page cache in the guest and keeps the page cache

s/need of/need for/

> +only in the host. Under memory pressure, the host makes use of
> +efficient memory reclaim decisions for page cache pages of all the
> +guests. This helps to reduce the memory footprint and fits more guests
> +in the host system.
> +
> +The virtio pmem device provides access to byte-addressable persistent
> +memory. The persist memory is a directly accessible range of system memo=
ry.

s/persist/persistent/

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
> +
> +Possible request types are:
> +
> +\begin{lstlisting}
> +#define VIRTIO_PMEM_REQ_TYPE_FLUSH      0
> +\end{lstlisting}
> +
> +\subsection{Device Operations}\label{sec:Device Types / PMEM Driver / De=
vice Operation}
> +\devicenormative{\subsubsection}{Device Operation: Virtqueue flush}{Devi=
ce Types / PMEM Device / Device Operation / Virtqueue flush}
> +
> +The device MUST ensure that all writes completed before a flush request =
persist across device reset and power failure before completing the flush r=
equest.
> +
> +\subsubsection{Device Operations}\label{sec:Device Types / PMEM Driver /=
 Device Operation / Virtqueue return}
> +\begin{lstlisting}
> +struct virtio_pmem_resp {
> +        le32 ret;
> +};
> +\end{lstlisting}
> +
> +\field{ret} is the value which device returns after command completion.
> +
> +\devicenormative{\subsubsection}{Device Operation: Virtqueue return}{Dev=
ice Types / PMEM Device / Device Operation / Virtqueue return}
> +
> +The device MUST return "0" for success and "-1" for failure.
> +
> +\subsection{Possible security implications}\label{sec:Device Types / PME=
M Device / Possible Security Implications}
> +
> +There could be potential security implications depending on how
> +memory mapped backing device is used. By default device emulation
> +is done with SHARED memory mapping. There is a contract between driver
> +and device to access shared memory region for read or write operations.
> +
> +If a malicious driver or device map the same memory region, the attacker

s/map/maps/

> +can make use of known side channel attacks to predict the current state =
of data.
> +If both attacker and victim somehow execute same shared code after a flu=
sh
> +or evict operation, with difference in execution timing attacker could i=
nfer
> +another device data.

s/device/device's/

> +
> +\subsection{Countermeasures}\label{sec:Device Types / PMEM Device / Poss=
ible Security Implications / Countermeasures}
> +
> +\subsubsection{ With SHARED mapping}\label{sec:Device Types / PMEM Devic=
e / Possible Security Implications / Countermeasures / SHARED}
> +
> +If device backing region is shared between multiple devices, this may act

s/If device/If a device's/

> +as a metric for side channel attack. As a counter measure every device

s/attack/attacks/

> +should have its own(not shared with another driver) SHARED backing memor=
y.

s/own(/own (/

> +
> +\subsubsection{ With PRIVATE mapping}\label{sec:Device Types / PMEM Devi=
ce / Possible Security Implications / Countermeasures / PRIVATE}
> +There maybe be chances of side channels attack with PRIVATE
> +memory mapping similar to SHARED with read-only shared mappings.
> +PRIVATE is not used for virtio pmem making this usecase
> +irrelevant.
> +
> +\subsubsection{ Workload specific mapping}\label{sec:Device Types / PMEM=
 Device / Possible Security Implications / Countermeasures / Workload}
> +For SHARED mapping, if workload is single application inside

s/mapping/mappings/
s/workload/the workload/
s/single/a single/

> +the driver and there is no risk in sharing data. Device sharing

The first sentence is incomplete ("if X and Y"). Should it be "if X then
Y" or something else?

> +same backing region with SHARED mapping can be used as a valid configura=
tion.
> +
> +\subsubsection{ Prevent cache eviction}\label{sec:Device Types / PMEM De=
vice / Possible Security Implications / Countermeasures / Cache eviction}
> +Don't allow device shared region evict from driver filesystem trim or di=
scard=20

s/evict/eviction/

> +like commands with virtio pmem. This rules out any possibility of evict-=
reload
> +cache side channel attacks if backing region is shared(SHARED)

s/shared(/shared (/

> +between mutliple devices. Though if we use per device backing file with
> +shared mapping this countermeasure is not required.
> --=20
> 2.25.1
>=20
>=20
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>=20

--oGCRZ4vfjELobJB2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmFayqoACgkQnKSrs4Gr
c8gEuQgArxn/dJJgUrHPhvOab5dCZZjRa6B8bnBWn4iKGgW+iO8nfUXi8FJTW0Cd
7m1J4DcYSemv1KQvNcZvBnPJ7C5UfU7eFzMXIYeK1Fh2xDqe+NSVJVZTObh1E/wP
Xxfh5kQ1kGUEFQ7S5n8nKD6Vr6Y9W0jpdvp6bE7VMFmReN53DDlBFLH9wLVxtvcD
uTC4pgXKLVHORQBjz/v0N2ELryQQr3H71k2TPOPblFxmGmxi9+Ej51KtILnunnur
7gngf2q66GGOOq9AYERb/sihx8qxSp7H79EFk/stSRGiDmh44KLO2feHav/eH7jM
cSHHb7uzNuA+wGpBp3tYdRddZp+0cw==
=Abx9
-----END PGP SIGNATURE-----

--oGCRZ4vfjELobJB2--

