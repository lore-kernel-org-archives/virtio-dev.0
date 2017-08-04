Return-Path: virtio-dev-return-2454-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 8643B58180E4
	for <virtio-dev@lists.oasis-open.org>; Fri,  4 Aug 2017 11:19:03 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Date: Fri,  4 Aug 2017 19:19:26 +0100
Message-Id: <20170804181927.12148-2-jean-philippe.brucker@arm.com>
In-Reply-To: <20170804181927.12148-1-jean-philippe.brucker@arm.com>
References: <20170804181927.12148-1-jean-philippe.brucker@arm.com>
Subject: [virtio-dev] [RFC] virtio-iommu v0.4 - IOMMU Device
To: iommu@lists.linux-foundation.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org
Cc: will.deacon@arm.com, robin.murphy@arm.com, lorenzo.pieralisi@arm.com, mst@redhat.com, jasowang@redhat.com, marc.zyngier@arm.com, eric.auger@redhat.com, eric.auger.pro@gmail.com, bharat.bhushan@nxp.com, peterx@redhat.com, kevin.tian@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

The following is roughly the content of device-operations.tex

---
\section{IOMMU device}\label{sec:Device Types / IOMMU Device}

The virtio-iommu device manages Direct Memory Access (DMA) from one or
more endpoints. It may act as a proxy for multiple physical IOMMUs
managing devices assigned to the guest, and as standalone IOMMU for
virtual devices.

The driver first discovers endpoints managed by the virtio-iommu device
using standard firmware mechanisms. It then sends requests to create
virtual address spaces and virtual-to-physical mappings for these
endpoints. In its simplest form, the virtio-iommu supports four request
types:

\begin{enumerate}
\item Create an address space and attach an endpoint to it.  \\
  \texttt{attach(device = 0x104, address space = 1)}
\item Create a mapping between a range of guest-virtual and guest-physical
  address. \\
  \texttt{map(address space = 1, virt = 0x1000, phys = 0xa000,
          size = 0x1000, flags = READ)}

  Endpoint 0x104, for example a hardware PCI endpoint, can now read at
  addresses 0x1000-0x1fff. These accesses are translated into
  system-physical addresses by the IOMMU.

\item Remove the mapping.\\
  \texttt{unmap(address space = 1, virt = 0x1000, size = 0x1000)}

  Any access to addresses 0x1000-0x1fff by endpoint 0x104 would now be
  rejected.
\item Detach the device and remove the address space.\\
  \texttt{detach(device = 0x104)}
\end{enumerate}

\subsection{Device ID}\label{sec:Device Types / IOMMU Device / Device ID}

TBD. During development, use 61216.

\subsection{Virtqueues}\label{sec:Device Types / IOMMU Device / Virtqueues}

\begin{description}
\item[0] requestq
\end{description}

\subsection{Feature bits}\label{sec:Device Types / IOMMU Device / Feature bits}

\begin{description}
\item[VIRTIO_IOMMU_F_INPUT_RANGE (0)]
  Available range of virtual addresses is described in \field{input_range}

\item[VIRTIO_IOMMU_F_IOASID_BITS (1)]
  The number of address spaces supported is described in \field{ioasid_bits}

\item[VIRTIO_IOMMU_F_MAP_UNMAP (2)]
  Map and unmap requests are available.\footnote{Future extensions may add
  different modes of operations. At the moment, only
  VIRTIO_IOMMU_F_MAP_UNMAP is supported.}

\item[VIRTIO_IOMMU_F_BYPASS (3)]
  When not attached to an address space, endpoints downstream of the IOMMU
  can access the guest-physical address space.

\item[VIRTIO_IOMMU_F_PROBE (4)]
  Probe request is available.
\end{description}

\drivernormative{\subsubsection}{Feature bits}{Device Types / IOMMU Device / Feature bits}

The driver SHOULD accept any of the VIRTIO_IOMMU_F_INPUT_RANGE,
VIRTIO_IOMMU_F_IOASID_BITS, VIRTIO_IOMMU_F_MAP_UNMAP and
VIRTIO_IOMMU_F_PROBE feature bits if offered by the device.

% XXX F_MAP_UNMAP will be optional when introducing PTH. But a 0.2 driver
% must implement it (otherwise the device is useless)

\devicenormative{\subsubsection}{Feature bits}{Device Types / IOMMU Device / Feature bits}

If the device offers any of VIRTIO_IOMMU_F_INPUT_RANGE,
VIRTIO_IOMMU_F_IOASID_BITS or VIRTIO_IOMMU_F_PROBE feature bits, and if
the driver did not accept this feature bit, then the device MAY signal
failure by failing to set FEATURES_OK \field{device status} bit when the
driver writes it.

If the device offers the VIRTIO_IOMMU_F_MAP_UNMAP feature bit, and if the
driver did not accept this feature bit, then the device SHOULD behave as
if the feature was negotiated.
% This takes into account all the following "If the F_MAP_UNMAP feature
% was negotiated..."

% If the driver supports F_PTH but not F_MAP_UNMAP, then the driver MUST
% give up upon seeing that the 0.2 device doesn't support F_PTH. If it
% supports F_MAP_UNMAP, then it SHOULD use F_MAP_UNMAP (this is described
% in "Driver Requirements: Feature Bits")

% If the driver supports F_PTH but the device doesn't, and the driver
% stupidly sets F_PTH but not F_MAP_UNMAP, then the device SHOULD reject
% any PTH request and PTH flag in attach.

% When not using the legacy interface, if the driver doesn't negotiate
% F_MAP_UNMAP, then the device may disable it an reject any request.

\subsubsection{Legacy Interface: Feature bits}\label{sec:Device Types / IOMMU Device / Feature bits / Legacy Interface: Feature bits}

When using the legacy interface, transitional devices MUST support guests
which do not negotiate any of the VIRTIO_IOMMU_F_INPUT_RANGE,
VIRTIO_IOMMU_F_IOASID_BITS, VIRTIO_IOMMU_F_MAP_UNMAP or
VIRTIO_IOMMU_F_PROBE features, and MUST behave as if the feature was
negotiated.

%\subsection{Feature Bits Requirements}\label{sec:Device Types / IOMMU Device / Feature bits requirements}

\subsection{Device configuration layout}\label{sec:Device Types / IOMMU Device / Device configuration layout}

The \field{page_size_mask} field is always present. Availability of the
others depend on various feature bits as indicated above.

\begin{lstlisting}
struct virtio_iommu_config {
	u64 page_size_mask;
	struct virtio_iommu_range {
		u64 start;
		u64 end;
	} input_range;
	u8 ioasid_bits;
	u8 padding[3];
	u32 probe_size;
};
\end{lstlisting}

\drivernormative{\subsubsection}{Device configuration layout}{Device Types / IOMMU Device / Device configuration layout}

The driver MUST NOT write to device configuration fields.

\devicenormative{\subsubsection}{Device configuration layout}{Device Types / IOMMU Device / Device configuration layout}

The device SHOULD set \field{padding} to zero.

The device MUST set at least one bit in \field{page_size_mask}, describing
the page granularity. The device MAY set more than one bit in
\field{page_size_mask}.

\subsubsection{Legacy Interface: Device configuration layout}\label{sec:Device Types / IOMMU Device / Device configuration layout / Legacy Interface: Device configuration layout}
When using the legacy interface, transitional devices and drivers
MUST format the fields in struct virtio_iommu_config
according to the native endian of the guest rather than
(necessarily when not using the legacy interface) little-endian.


\subsection{Device initialization}\label{sec:Device Types / IOMMU Device / Device initialization}

When the device is reset, endpoints are not attached to any address space.
If the VIRTIO_IOMMU_F_BYPASS feature is negotiated, all endpoints can
access guest-physical addresses ("bypass mode"). If the feature is not
negotiated, then any memory access from endpoints will fault. Upon
attaching an endpoint in bypass mode to a new address space, any memory
access from the endpoint will fault, since the address space does not
contain any mapping.

The driver chooses operating mode depending on its capabilities. In this
revision of the virtio-iommu specification, the only supported mode is
VIRTIO_IOMMU_F_MAP_UNMAP.

\drivernormative{\subsubsection}{Device Initialization}{Device Types / IOMMU Device / Device Initialization}

The driver MUST NOT negotiate VIRTIO_IOMMU_F_MAP_UNMAP if it is incapable
of sending VIRTIO_IOMMU_T_MAP and VIRTIO_IOMMU_T_UNMAP requests.

If the VIRTIO_IOMMU_F_PROBE feature is offered, the driver SHOULD send a
VIRTIO_IOMMU_T_PROBE request for each endpoint before attaching the
endpoint to an address space.

\devicenormative{\subsubsection}{Device Initialization}{Device Types / IOMMU Device / Device Initialization}

If the driver does not accept the VIRTIO_IOMMU_F_BYPASS feature, the
device SHOULD NOT let endpoints access the guest-physical address space.
However, the device MAY let endpoints access memory regions negotiated
with VIRTIO_IOMMU_PROBE_RESV_MEM_T_BYPASS (see
\ref{devicenormative:Device Types / IOMMU Device / Device operations / PROBE properties / RESV_MEM}).

\subsection{Device operations}\label{sec:Device Types / IOMMU Device / Device operations}

Driver send requests on the request virtqueue, notifies the device and
waits for the device to return the request with a status in the used ring.
All requests are split in two parts: one device-readable, one device-
writable. Each request is therefore described with at least two
descriptors, as illustrated below.

\begin{figure}[htb]
  \centering
  \includegraphics[width=0.7\textwidth]{img/request-wrapping.png}
  \caption{Anatomy of a virtio-iommu request}
\end{figure}

\begin{lstlisting}
struct virtio_iommu_req_head {
	u8	type;
	u8	reserved[3];
};

struct virtio_iommu_req_tail {
	u8	status;
	u8	reserved[3];
};
\end{lstlisting}

\rfc{% TODO
There is a problem with framing using multiple chains... If a request
isn't recognized by the device and is scattered across multiple descriptor
chains, how would the device know where this request ends and where the
next one begins? It assumes that a transition from WO descriptors to RO
descriptors is a new request, ok. But if this unknown request is from a
future extension that uses interleaved RO, WO, RO, WO descriptors for a
single request, then the device is doomed.\\
The extension will have to force that third buffer to start with 0 so our
device, that thinks it's a new request, doesn't recognize the request type
and waits for the next one.\\
Alternatively, we could add a 16-bit 'size' field into
virtio_iommu_req_head. We'd loose some space for future flags, and force
requests to be at most 64k, or 256k if we drop size bits [1:0]. (head
couldn't be extended in the future, with a field to describe a bigger
size, because our legacy device here would ignore it.) We'd have to resort
to multiple "container" requests transporting a single big one.\\
Personally I think we can let future extensions deal with interleaved
RO/WO/RO descriptors, but do you think a 'size' field would be better?
}

Type may be one of:

\begin{lstlisting}
#define VIRTIO_IOMMU_T_ATTACH			1
#define VIRTIO_IOMMU_T_DETACH			2
#define VIRTIO_IOMMU_T_MAP			3
#define VIRTIO_IOMMU_T_UNMAP			4
#define VIRTIO_IOMMU_T_PROBE			5
\end{lstlisting}

A few general-purpose status codes are defined here. Unless explicitly
described in a \textbf{Requirements} section, these values are hints to
make troubleshooting easier.

When the device fails to parse a request, for instance if a request seems
too small for its type and the device cannot find the tail, then it will
be unable to set \field{status}. In that case, it should return the
buffers without writing in them.

\begin{lstlisting}
/* All good! Carry on. */
#define VIRTIO_IOMMU_S_OK			0
/* Virtio communication error */
#define VIRTIO_IOMMU_S_IOERR			1
/* Unsupported request */
#define VIRTIO_IOMMU_S_UNSUPP			2
/* Internal device error */
#define VIRTIO_IOMMU_S_DEVERR			3
/* Invalid parameters */
#define VIRTIO_IOMMU_S_INVAL			4
/* Out-of-range parameters */
#define VIRTIO_IOMMU_S_RANGE			5
/* Entry not found */
#define VIRTIO_IOMMU_S_NOENT			6
/* Bad address */
#define VIRTIO_IOMMU_S_FAULT			7
\end{lstlisting}

Range limits of some request fields are described in the device
configuration:

\begin{itemize}
\item \field{page_size_mask} contains the bitmask of all page sizes that
  can be mapped. The least significant bit set defines the page
  granularity of IOMMU mappings. Other bits in the mask are hints
  describing page sizes that the IOMMU can merge into a single mapping
  (page blocks).

  The smallest page granularity supported by the IOMMU is one byte. It is
  legal for the driver to map one byte at a time if bit 0 of
  \field{page_size_mask} is set.

\item If the VIRTIO_IOMMU_F_IOASID_BITS feature is offered,
  \field{ioasid_bits} contains the number of bits supported in an I/O
  Address Space ID, the identifier used in most requests. A value of 0 is
  valid, and means that a single address space is supported.

  If the feature is not negotiated, address space identifiers can use up
  to 32 bits.

\item If the VIRTIO_IOMMU_F_INPUT_RANGE feature is offered,
  \field{input_range} contains the virtual address range that the IOMMU is
  able to translate. Any mapping request to virtual addresses outside of
  this range will fail.

  If the feature is not negotiated, virtual mappings span over the whole
  64-bit address space (\texttt{start = 0, end = 0xffffffff ffffffff})
\end{itemize}

\drivernormative{\subsubsection}{Device operations}{Device Types / IOMMU Device / Device operations}

The driver SHOULD set reserved fields of the head and the tail of a
request to zero.

When a device returns a complete request in the used queue without having
written to it, the driver SHOULD interpret it as a failure from the device
to parse the request.

If the VIRTIO_IOMMU_F_INPUT_RANGE feature is offered, the driver SHOULD
NOT send requests with \field{virt_addr} less than
\field{input_range.start} or greater than \field{input_range.end}.

If the VIRTIO_IOMMU_F_IOASID_BITS feature is offered, the driver SHOULD
NOT send requests with \field{address_space} greater than the size
described by \field{ioasid_bits}.

% We mandate truncation to allow a future extension X.Y that would store
% information in addresses and address space IDs.
%
% If device is 0.2 and driver is X.Y, then device ignores ext. bits. But
% if device is X.Y and device is 0.2, then driver *might* set ext. bits to
% garbage. But this extension would be negotiated with a feature bit
% anyway. If it's not, then device must assume that driver is 0.2 and must
% keep truncating the fields.

\devicenormative{\subsubsection}{Device operations}{Device Types / IOMMU Device / Device operations}

The device SHOULD NOT set \field{status} to VIRTIO_IOMMU_S_OK if a request
didn't succeed. \footnote{%
For IMPLEMENTATION DEFINED values of 'succeed'... For example,
virtio_iommu_req_detach.reserved is allowed to be non-zero. If it is
non-zero, the device may consider it to be a failure and abort the
request. Or it may go on with the detach and return OK.}

If a request \field{type} is not recognized, the device SHOULD return the
buffers on the used ring and set the \field{len} field of the used element
to zero.

The device MUST ignore reserved fields of the head and the tail of a
request.

If the VIRTIO_IOMMU_F_INPUT_RANGE feature is offered, the device MUST
truncate the range described by \field{virt_addr} and \field{size} in
requests to fit in the range described by \field{input_range}.

If the VIRTIO_IOMMU_F_IOASID_BITS is offered, the device MUST ignore bits
above \field{ioasid_bits} in field \field{address_space} of requests.

\subsubsection{ATTACH request}\label{sec:Device Types / IOMMU Device / Device operations / ATTACH request}

\begin{lstlisting}
struct virtio_iommu_req_attach {
	le32	address_space;
	le32	device;
	le32	reserved;
};
\end{lstlisting}

Attach an endpoint to an address space. \field{address_space} is an
identifier unique to the virtio-iommu device. If the address space doesn't
exist in the device, it is created. \field{device} is an endpoint
identifier unique to the virtio-iommu device. The host communicates unique
device IDs to the guest using methods outside the scope of this
specification, but the following rules apply:

\begin{itemize}
\item The device ID is unique from the virtio-iommu point of view. Multiple
  endpoints whose DMA transactions are not translated by the same
  virtio-iommu may have the same device ID. Endpoints whose DMA
  transactions may be translated by the same virtio-iommu must have
  different device IDs.

\item Sometimes the host cannot completely isolate two endpoints from each
  others. For example on a legacy PCI bus, endpoints can snoop DMA
  transactions from their neighbours. In this case, the host must
  communicate to the guest that it cannot isolate these endpoints from
  each others, or that the physical IOMMU cannot distinguish transactions
  coming from these endpoints. The method used to communicate this is
  outside the scope of this specification.
\end{itemize}

Multiple endpoints may be added to the same address space. An endpoint
cannot be attached to multiple address spaces in VIRTIO_IOMMU_F_MAP_UNMAP
mode.

\drivernormative{\paragraph}{ATTACH request}{Device Types / IOMMU Device / Device operations / ATTACH request}

The driver SHOULD set \field{reserved} to zero.

The driver SHOULD ensure that endpoints that cannot be isolated by the
host are attached to the same address space.

\devicenormative{\paragraph}{ATTACH request}{Device Types / IOMMU Device / Device operations / ATTACH request}

If the \field{reserved} field of an ATTACH request is not zero, the device
SHOULD set the request \field{status} to VIRTIO_IOMMU_S_INVAL and SHOULD
NOT attach the endpoint to the address space. \footnote{The device should
validate input of ATTACH requests in case the driver attempts to attach in
a mode that is unimplemented by the device, and would be incompatible with
the modes implemented by the device.}

If the endpoint identified by \field{device} doesn't exist, then the
device SHOULD set the request \field{status} to VIRTIO_IOMMU_S_NOENT.

If another endpoint is already attached to the address space identified by
\field{address_space}, then the device MAY attach the endpoint identified
by \field{device} to the address space. If it cannot do so, the device
MUST set the request \field{status} to VIRTIO_IOMMU_S_UNSUPP.

If the endpoint identified by \field{device} is already attached to
another address space, then the device SHOULD first detach it from that
address space and attach it to the one identified by
\field{address_space}. In that case the device behaves as if the driver
issued a DETACH request with this \field{device}, followed by the ATTACH
request. If the device cannot do so, it MUST set the request
\field{status} to VIRTIO_IOMMU_S_UNSUPP.

\subsubsection{DETACH request}

\begin{lstlisting}
struct virtio_iommu_req_detach {
	le32	device;
	le32	reserved;
};
\end{lstlisting}

Detach an endpoint from its address space. When this request completes,
the endpoint cannot access any mapping from that address space anymore.

After all endpoints have been successfully detached from an address space,
it ceases to exist and its ID can be reused by the driver for another
address space.

\drivernormative{\paragraph}{DETACH request}{Device Types / IOMMU Device / Device operations / DETACH request}

The driver SHOULD set \field{reserved} to zero.

\devicenormative{\paragraph}{DETACH request}{Device Types / IOMMU Device / Device operations / DETACH request}

If the \field{reserved} field of an DETACH request is not zero, the device
MAY set the request \field{status} to VIRTIO_IOMMU_S_INVAL, in which case
the device MAY perform the DETACH operation.
% If it returns OK, the device SHOULD go on with the detach, as required
% by the VIRTIO_IOMMU_S_OK rule.

If the endpoint identified by \field{device} doesn't exist, then the
device SHOULD set the request \field{status} to VIRTIO_IOMMU_S_NOENT.

If the endpoint identified by \field{device} wasn't attached to any
address space, then the device MAY set the request \field{status} to
VIRTIO_IOMMU_S_INVAL.

The device MUST ensure that after being detached from an address space,
the endpoint cannot access any mapping from that address space.

\subsubsection{MAP request}\label{sec:Device Types / IOMMU Device / Device operations / MAP request}

\begin{lstlisting}
struct virtio_iommu_req_map {
	le32	address_space;
	le64	phys_addr;
	le64	virt_addr;
	le64	size;
	le32	flags;
};

/* Flags are: */
#define VIRTIO_IOMMU_MAP_F_READ		(1 << 0)
#define VIRTIO_IOMMU_MAP_F_WRITE	(1 << 1)
#define VIRTIO_IOMMU_MAP_F_EXEC		(1 << 2)
\end{lstlisting}

Map a range of virtually-contiguous addresses to a range of
physically-contiguous addresses of the same size. After the request
succeeds, all endpoints attached to this address space can access memory
in the range $[phys\_addr; phys\_addr + size[$. For example, if an endpoint
accesses address $VA \in [virt\_addr; virt\_addr + size[$, the device (or the
physical IOMMU) translates the address: $PA = VA - virt\_addr +
phys\_addr$. If the access parameters are compatible with \field{flags}
(for instance, the access is write and \field{flags} are
VIRTIO_IOMMU_MAP_F_READ | VIRTIO_IOMMU_MAP_F_WRITE) then the IOMMU allows
the access to reach $PA$.

The range defined by (\field{virt_addr}, \field{size}) must be within the
limits specified by \field{input_range}. The range defined by
(\field{phys_addr}, \field{size}) must be within the guest-physical
address space. This includes upper and lower limits, as well as any
carving of guest-physical addresses for use by the host (for instance MSI
doorbells). Guest physical boundaries are set by the host using a firmware
mechanism outside the scope of this specification.

\begin{note}
This format prevents from creating the identity mapping in a single
request \texttt{[0x0; 0xfff....fff] $\rightarrow$ [0x0; 0xfff...fff]},
since it would result in a size of zero. Hopefully allowing
VIRTIO_IOMMU_F_BYPASS eliminates the need for issuing such request. It
would also be unlikely to conform to the physical range restrictions
from the previous paragraph.
\end{note}

\begin{note}
On flags: it is unlikely that all possible combinations of flags will be
supported by the physical IOMMU. For instance, $W \& !R$ or $X \& W$ might
be invalid. We do not have a way to advertise supported and implicit (for
instance $W \rightarrow R$) flags or combination thereof for the moment,
you are free to send any suggestions for describing this. Please keep in
mind that we might soon want to add more flags, such as privileged,
device, transient, shared, etc. (whatever these would mean).
\end{note}

This request is only available when VIRTIO_IOMMU_F_MAP_UNMAP has been
negotiated.

\drivernormative{\paragraph}{MAP request}{Device Types / IOMMU Device / Device operations / MAP request}

The driver SHOULD set undefined \field{flags} bits to zero.

\devicenormative{\paragraph}{MAP request}{Device Types / IOMMU Device / Device operations / MAP request}

If \field{virt_addr}, \field{phys_addr} or \field{size} is not aligned on
the page granularity, the device SHOULD set the request \field{status} to
VIRTIO_IOMMU_S_RANGE and SHOULD NOT create the mapping.

If the device doesn't recognize a \field{flags} bit, it SHOULD set the
request \field{status} to VIRTIO_IOMMU_S_INVAL. In this case the device
SHOULD NOT create the mapping. \footnote{Validating the input is important
here, because the driver might be attempting to map with special flags
that the device doesn't recognize. Creating the mapping with incompatible
flags may introduce a security hazard.}

If \field{address_space} does not exist, the device SHOULD set the request
\field{status} to VIRTIO_IOMMU_S_NOENT.

\subsubsection{UNMAP request}\label{sec:Device Types / IOMMU Device / Device operations / UNMAP request}

\begin{lstlisting}
struct virtio_iommu_req_unmap {
	le32	address_space;
	le64	virt_addr;
	le64	size;
	le32	reserved;
};
\end{lstlisting}

Unmap a range of addresses mapped with VIRTIO_IOMMU_T_MAP. We define here
a mapping as a virtual region created with a single MAP request. All
mappings covered by the range $[virt\_addr; virt\_addr + size [$ are
removed.

The semantics of unmapping are specified below, and illustrated with the
following requests, assuming each example sequence starts with a blank
address space. We define two pseudocode functions \texttt{map(virt\_addr,
size) -> mapping} and \texttt{unmap(virt\_addr, size)}.

\begin{lstlisting}
(1) unmap(addr=0, size=5)        -> succeeds, doesn't unmap anything

(2) a = map(addr=0, size=10);
    unmap(0, 10)                 -> succeeds, unmaps a

(3) a = map(0, 5);
    b = map(5, 5);
    unmap(0, 10)                 -> succeeds, unmaps a and b

(4) a = map(0, 10);
    unmap(0, 5)                  -> faults, doesn't unmap anything

(5) a = map(0, 5);
    b = map(5, 5);
    unmap(0, 5)                  -> succeeds, unmaps a

(6) a = map(0, 5);
    unmap(0, 10)                 -> succeeds, unmaps a

(7) a = map(0, 5);
    b = map(10, 5);
    unmap(0, 15)                 -> succeeds, unmaps a and b
\end{lstlisting}

This request is only available when VIRTIO_IOMMU_F_MAP_UNMAP has been
negotiated.

\drivernormative{\paragraph}{UNMAP request}{Device Types / IOMMU Device / Device operations / UNMAP request}

The driver SHOULD set the \field{reserved} field to zero.

The range, defined by \field{virt_addr} and \field{size}, SHOULD cover one
or more contiguous mappings created with MAP requests. The range MAY spill
over unmapped virtual addresses.

The first address of a range SHOULD either be the first address of a
mapping or be outside any mapping. The last address of a range SHOULD
either be the last address of a mapping or be outside any mapping.

\devicenormative{\paragraph}{UNMAP request}{Device Types / IOMMU Device / Device operations / UNMAP request}

If the \field{reserved} field of an UNMAP request is not zero, the device
MAY set the request \field{status} to VIRTIO_IOMMU_S_INVAL, in which case
the device MAY perform the UNMAP operation.
% If it returns OK, the device SHOULD go on with the unmap, as required by
% the VIRTIO_IOMMU_S_OK rule.

If \field{address_space} does not exist, the device SHOULD set the request
\field{status} to VIRTIO_IOMMU_S_NOENT.

If a mapping affected by the range is not covered in its entirety by the
range (the UNMAP request would split the mapping), then the device SHOULD
set the request \field{status} to VIRTIO_IOMMU_S_RANGE, and SHOULD NOT
remove any mapping.

If part of the range or the full range is not covered by an existing
mapping, then the device SHOULD remove all mappings affected by the range
and set the request \field{status} to VIRTIO_IOMMU_S_OK.

\subsubsection{PROBE request}\label{sec:Device Types / IOMMU Device / Device operations / PROBE request}

If the VIRTIO_IOMMU_F_PROBE feature bit is present, the driver sends a
VIRTIO_IOMMU_T_PROBE request for each endpoint that the virtio-iommu
device manages. This probe is performed before attaching the endpoint to
an address space.

\begin{lstlisting}
struct virtio_iommu_req_probe {
	/* Device-readable */
	le32	device;
	le32	flags;
	u8	reserved[60];

	/* Device-writable when not ACK */
	u8	properties[];
};

/* Flags are: */
#define VIRTIO_IOMMU_PROBE_F_ACK	(1 << 0)
\end{lstlisting}

\begin{description}
\item[\field{device}] has the same meaning as in ATTACH and DETACH
  requests.

\item[\field{flags}] contain additional information about the request.
  The VIRTIO_IOMMU_PROBE_F_ACK flag changes the descriptor chain layout:
  when ACK is clear, the \field{properties} field is device-writable;
  when it is set, the \field{properties} field is device-readable.

\item[\field{reserved}] is used as padding, so that future extensions can
  add fields to the device-readable part.

\item[\field{properties}] contains a list of properties of endpoint
  \field{device}, filled by the device. This field is exactly
  \field{probe_size} bytes. Each property is described with a type, four
    flag bits, a length, and a value:
\begin{lstlisting}
#define VIRTIO_IOMMU_PROBE_PROPERTY_TYPE_MASK	0xfff
#define VIRTIO_IOMMU_PROBE_PROPERTY_F_ACK	(1 << 12)

struct virtio_iommu_probe_property {
	le16	type;
	le16	length;
	u8	value[];
};
\end{lstlisting}

\end{description}

The driver allocates a buffer of adequate size for the probe request,
writes \field{device} and adds it to the request queue. The device fills
the \field{properties} field with a list of properties for this endpoint.

The driver parses the first property by reading \field{type}, then
\field{length}. If the driver recognizes \field{type}, it reads and
handles \field{value}. The driver then reads the next property, that is
located $(\field{length} + 4)$ bytes after the beginning of the first one,
and so on. The driver parses all properties until it reaches a NONE
property or the end of \field{properties}.

The upper nibble of property \field{type} is reserved for flags.
Therefore only 4096 types are available. The actual type of a property is
extracted like this:

\begin{lstlisting}
u16 type = le16_to_cpu(property.type) & VIRTIO_IOMMU_PROBE_PROPERTY_TYPE_MASK;
\end{lstlisting}

If a property is correctly understood by the driver, then it sets the ACK
bit in \field{type}:

\begin{lstlisting}
property.type |= cpu_to_le16(VIRTIO_IOMMU_PROBE_PROPERTY_F_ACK);
\end{lstlisting}

Then, to signal to the device which properties are understood, the device
sends the probe again with the VIRTIO_IOMMU_PROBE_F_ACK flag. In all
properties understood and accepted by the driver, \field{type} has the
VIRTIO_IOMMU_PROBE_PROPERTY_F_ACK bit set. The other properties are left
as is.

This second phase of the probe request allows the device to ensure that
all properties crucial for good operations are recognized and handled by
the driver. This is analogous to the initial feature negotiation of virtio
devices: an endpoint property is \emph{offered} by the device to the
driver during the first PROBE, and it is \emph{negotiated} after the
driver acknowledges it during the second PROBE.

Available property types are described in section
\ref{sec:Device Types / IOMMU Device / Device operations / PROBE properties}.
When attaching multiple devices to the same address space, their
properties are combined. \emph{Combination Rules} are given for each
property, and describe the rules to apply when combining properties
obtained during probe.

\drivernormative{\paragraph}{PROBE request}{Device Types / IOMMU Device / Device operations / PROBE request}

The size of \field{properties} MUST be \field{probe_size} bytes.

The driver SHOULD set undefined \field{flags} to zero.

The driver SHOULD set \field{reserved} to zero.

If the driver doesn't recognize the \field{type} of a property, it SHOULD
ignore the property and continue parsing the list.

The driver SHOULD NOT deduce the property length from \field{type}.

If the driver recognizes a property \field{type} and is able to
handle{\footnotemark} the property, then the driver SHOULD set the
VIRTIO_IOMMU_PROBE_PROPERTY_F_ACK bit of that property.

\footnotetext{A driver's ability to handle a property depends on the
property type. Without a specific definition of the ACK requirements for a
given property type, it simply means that the driver read all fields of
that property.}

The driver SHOULD resend the PROBE request with the
VIRTIO_IOMMU_PROBE_F_ACK bit set after parsing and updating the
\field{properties} list. Depending on the properties encountered in the
list, the driver MAY modify some of their fields between the first and
second probe, but it SHOULD NOT modify the \field{length} field or bits
[11:0] of field \field{type}.

\devicenormative{\paragraph}{PROBE request}{Device Types / IOMMU Device / Device operations / PROBE request}

If an undefined bit is set in \field{flags}, the device MAY set the
request \field{status} to VIRTIO_IOMMU_S_INVAL.

If the \field{reserved} field of a PROBE request is not zero, the device
MAY set the request \field{status} to VIRTIO_IOMMU_S_INVAL.

If the endpoint identified by \field{device} doesn't exist, then the
device SHOULD set the request \field{status} to VIRTIO_IOMMU_S_NOENT.

If the device does not offer the VIRTIO_IOMMU_F_PROBE feature, and if the
driver sends a VIRTIO_IOMMU_T_PROBE request, then the device SHOULD return
the buffers on the used ring and set the \field{len} field of the used
element to zero.

The device SHOULD set bits [15:13] of property \field{type} to zero.

The device MUST write the size of \field{value}, in bytes, into
\field{length}.

When two properties follow each others, the device MUST put the second
property exactly $(\field{length} + 4)$ bytes after the beginning of the
first one.

If the device doesn't fill all \field{probe_size} bytes with properties,
it SHOULD terminate the list with a property of type NONE and size 0. The
device MAY fill the remaining bytes of \field{properties}, if any, with
zeroes. If there isn't enough space remaining in \field{properties} to
terminate the list with a complete NONE property (4 bytes), then the
device SHOULD fill the remaining bytes with zeroes.

If the PROBE request has VIRTIO_IOMMU_PROBE_F_ACK bit set, the device MAY
ignore the request and set the request \field{status} to
VIRTIO_IOMMU_S_OK.

\subsubsection{PROBE properties}\label{sec:Device Types / IOMMU Device / Device operations / PROBE properties}

\begin{lstlisting}
#define VIRTIO_IOMMU_PROBE_T_NONE		0
#define VIRTIO_IOMMU_PROBE_T_RESV_MEM		2
\end{lstlisting}

\paragraph{Property NONE}\label{sec:Device Types / IOMMU Device / Device operations / PROBE properties / NONE}

Marks the end of the property list. This property doesn't have any value,
and should have \field{length} 0.

\paragraph{Property RESV_MEM}\label{sec:Device Types / IOMMU Device / Device operations / PROBE properties / RESV_MEM}

The RESV_MEM property describes a chunk of reserved virtual memory. It may
be used by the device to describe virtual address ranges that shouldn't be
allocated by the driver, or that are special.

\begin{lstlisting}
struct virtio_iommu_probe_resv_mem {
	u8	subtype;
	u8	reserved[3];
	le64	addr;
	le64	size;
	le32	flags;
};
\end{lstlisting}

Fields \field{addr} and \field{size} describe the range of reserved
addresses. \field{subtype} may be one of:

\begin{description}
  \item[VIRTIO_IOMMU_PROBE_RESV_MEM_T_ABORT (0)]
    Accesses to this region are aborted. This subtype does not accept any
    flag.
  \item[VIRTIO_IOMMU_PROBE_RESV_MEM_T_BYPASS (1)]
    Accesses to this region behave as if the IOMMU was bypassed, and reach
    the bus upstream of the IOMMU untranslated.

    The following \field{flags} are defined for BYPASS regions:
    \begin{description}
      \item[VIRTIO_IOMMU_PROBE_RESV_MEM_F_MSI (1)]
        Provides a hint to the guest that this is a doorbell for Message
        Signaled Interrupts.

        If the device doesn't provide such a region, then MSIs are normal
        write accesses from the IOMMU point of view, and arbitrary virtual
        addresses should be allocated by the driver to map MSI doorbells.
        Otherwise, the guest should use the guest-physical doorbell
        address when programming MSIs for this endpoint.
    \end{description}

  %\item[VIRTIO_IOMMU_PROBE_RESV_MEM_T_IDENTITY (2)]
  %  This region should be identity-mapped by the guest. TODO: is this
  %  useful for anyone?
\end{description}

\propcombination{\subparagraph}{Property RESV_MEM}{Device Types / IOMMU Device / Device operations / PROBE properties / RESV_MEM}

Multiple overlapping RESV_MEM properties are merged together. Difference
in subtype on the intersecting range doesn't make a difference from the
driver point of view.

\drivernormative{\subparagraph}{Property RESV_MEM}{Device Types / IOMMU Device / Device operations / PROBE properties / RESV_MEM}

The driver SHOULD NOT map any virtual address described by a
VIRTIO_IOMMU_PROBE_RESV_MEM_T_ABORT or
VIRTIO_IOMMU_PROBE_RESV_MEM_T_BYPASS property.

% An old driver that doesn't find or understand this property will
% allocate and map virtual addresses. We really can't do anything about
% that. We're not introducing a regression, MSIs never worked for x86
% before we introduced the F_MSI flag.

The driver SHOULD ignore \field{reserved}.

For a given \field{subtype}, the driver SHOULD ignore undefined
\field{flags} bits.

The driver SHOULD treat any \field{subtype} it doesn't recognize as if it
was VIRTIO_IOMMU_PROBE_RESV_MEM_T_ABORT.

\devicenormative{\subparagraph}{Property RESV_MEM}{Device Types / IOMMU Device / Device operations / PROBE properties / RESV_MEM}

The device SHOULD set \field{reserved} to zero.

For a given \field{subtype}, the device SHOULD set undefined \field{flags}
bits to zero.

The device MAY abort any transaction targeting a
VIRTIO_IOMMU_PROBE_RESV_MEM_T_ABORT region.

If an endpoint is attached to an address space, the device SHOULD leave
any access targeting one of its VIRTIO_IOMMU_PROBE_RESV_MEM_T_BYPASS
regions pass through untranslated. In other words, the device SHOULD
handle such a region as if it was identity-mapped (virtual address equal
to physical address). If the endpoint is not attached to any address
space, then the device MAY abort the transaction.

The device MAY abort any transaction that isn't a write access and that
targets a VIRTIO_IOMMU_PROBE_RESV_MEM_T_BYPASS region with flag
VIRTIO_IOMMU_PROBE_RESV_MEM_F_MSI.



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

