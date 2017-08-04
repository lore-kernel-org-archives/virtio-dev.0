Return-Path: virtio-dev-return-2455-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id C0E7B58180C6
	for <virtio-dev@lists.oasis-open.org>; Fri,  4 Aug 2017 11:19:07 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Date: Fri,  4 Aug 2017 19:19:27 +0100
Message-Id: <20170804181927.12148-3-jean-philippe.brucker@arm.com>
In-Reply-To: <20170804181927.12148-1-jean-philippe.brucker@arm.com>
References: <20170804181927.12148-1-jean-philippe.brucker@arm.com>
Subject: [virtio-dev] [RFC] virtio-iommu v0.4 - Implementation notes
To: iommu@lists.linux-foundation.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org
Cc: will.deacon@arm.com, robin.murphy@arm.com, lorenzo.pieralisi@arm.com, mst@redhat.com, jasowang@redhat.com, marc.zyngier@arm.com, eric.auger@redhat.com, eric.auger.pro@gmail.com, bharat.bhushan@nxp.com, peterx@redhat.com, kevin.tian@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

The following is roughly the content of topology.tex and MSI.tex

---
\section{Implementation notes}\label{sec:viommu}

\subsection{Virtual system topology}\label{sec:viommu / Virtual topology}

\subsubsection{Example virtual topology}\label{sec:viommu / Virtual topology / Example}

\begin{figure}[htb]
  \centering
  \includegraphics[width=\textwidth]{img/virtual-topology.png}
  \caption{An example IOMMU topology}
  \label{fig:viommu / Virtual topology / Topology}
\end{figure}

Diagram~\ref{fig:viommu / Virtual topology / Topology} shows an example
system topology centered around an IOMMU. On the left, the IOMMU manages
traffic from two PCI root complexes. On the right, the IOMMU manages
traffic from three platform devices (or "integrated devices").

Within a PCI domain, devices are identified by a Requester ID. It is a
16-bit identifier also called Bus/Device/Function (BDF). In a BDF, Bus is
8 bits, Device is 5 bits, and Function is 3 bits.

The bottom PCI domain has four endpoints connected to the root complex via
two bridges. The first endpoint is identified by BDF 01:04.0. On the other
bus, the first endpoint is identified by BDF 02:00.0, and the two other
endpoints are two functions of the same device, identified by BDFs 02:01.0
and 02:01.1. The bridges and the root complex may also issue transactions
with BDFs 00:00.0, 00:01.0 and 00:02.0.

In order for the IOMMU to differentiate devices in multiple PCI domains,
the root bridge expands the BDF with a domain ID. In example
\ref{fig:viommu / Virtual topology / Topology},
the PCI domain on top gets ID 0 and the one on the bottom gets ID 1.
Therefore when reaching the IOMMU, a transaction coming from endpoint
01:04.0 (= 0x0120) is identified by Device ID 0x10120.

We define here "platform" devices as endpoints that are on the system bus,
as opposed to behind a PCI host bridge. Unlike PCI devices, platform
devices do not have a standardized identifier scheme to be used with the
IOMMU. Their Device IDs are chosen arbitrarily during system integration
in such way that they don't overlap PCI domains or each others.

\subsubsection{Firmware description}\label{sec:viommu / Virtual topology / Firmware description}

The host describes the relation between IOMMU and devices to the guest
using either device-tree or ACPI. Topology description is outside the
scope of virtio-iommu, because the virtio-iommu does not and should not
need to know about vendor-specific buses. The virtual IOMMU identifies
each virtual endpoint with an abstract 32-bit ID, that is called "Device
ID" in this document\footnote{Other IOMMU architectures use different
names, such as "stream ID" on ARM SMMU or "source ID" on Intel VT-d}.
Device IDs are not necessarily unique system-wide, but they should not
overlap within a single virtio-iommu. Device IDs of physical endpoints do
not need to match IDs seen by the physical IOMMU.

We strongly advise to implement the virtio-iommu using virtio-mmio
transport. Nothing prevents an implementation to use virtio-pci instead,
but existing firmware interfaces do not easily allow to describe an IOMMU
$\leftrightarrow$ master relations between PCI endpoints. Device models in
Operating Systems might not be designed to support such complicated
system.

Device-tree offers a way to describe the IOMMU topology for PCI and
platform devices. Here's an excerpt of the device-tree describing examples
\ref{fig:viommu / Virtual topology / Topology}.

\begin{lstlisting}
/* The virtual IOMMU is described with a virtio-mmio node */
viommu: virtio@9050000 {
	compatible = "virtio,mmio";
	reg = <0x09050000 0x200>;
	dma-coherent;
	interrupts = <0x0 0x5 0x1>;

	#iommu-cells = <1>
};

/* PCI domain 0 */
pcie@3eff0000 {
	...
	/* Identity map */
	iommu-map = <0x0 &viommu 0x0 0x10000>;
};

/* PCI domain 1 */
pcie@3f000000 {
	...
	/* Linear map: deviceID = RID + 0x10000 */
	iommu-map = <0x0 &viommu 0x10000 0x10000>;
};

someplatformdevice@a000000 {
	...
	iommus = <&viommu 0x20000>;
};
\end{lstlisting}

For more details, please refer to \hyperref[intro:IOMMU DT Bindings]{[IOMMU DT]}.

In ACPI, the plan would be to add a new node type to the IO Remapping
Table specification \hyperref[intro:ACPI IORT]{[ACPI IORT]}, that provides
a mechanism similar to DT for describing IOMMU topology.

The OS would parse the IORT table to build a map of ID relations between
IOMMU and devices. ID Array is used to find correspondence between IOMMU
IDs and PCI or platform devices. Later on, the virtio-iommu driver finds
the associated LNRO0005 descriptor via the "Device object name" field, and
probes the virtio device to find out more about its capabilities. Since
all properties of the IOMMU will be obtained during virtio probing, the
IORT node can stay simple.

The following table shows the possible\protect\footnotemark\ format for a
paravirtualized IOMMU IORT node.

\footnotetext{This table IS NOT authoritative, only a suggestion.
  Such a node would be described in \hyperref[intro:ACPI IORT]{[ACPI IORT]}}.

\begin{center}
\begin{tabular}{| l | l | l | p{.4\textwidth} |}
\hline
\textbf{Field} & \textbf{Length} & \textbf{Offset} & \textbf{Description} \\
\hline
Type                  & 1     & 0     & 5: Paravirtualized IOMMU \\
\hline
Length                & 2     & 1     & The length of the node. \\
\hline
Revision              & 1     & 3     & 0 \\
\hline
Reserved              & 4     & 4     & Must be zero. \\
\hline
Number of ID mapping  & 4     & 8     & \\
\hline
Reference to ID Array & 4     & 12    &
  Offset from the start of the ID Array IORT node to the start of its
  Array ID mappings.\\
\hline
Model                 & 4     & 16    & 0: virtio-iommu \\
\hline
Device object name    &       & 20    &
  ASCII Null terminated string with the full path to the entry in the
  namespace for this IOMMU. \\
\hline
Padding & & & To keep 32-bit alignment and leave space for future models. \\
\hline
Array of ID mappings  & 20xN  &       & ID Array. \\
\hline
\end{tabular}
\end{center}

---
\subsection{Message Signaled Interrupts}\label{sec:viommu / MSI}

Some buses, such as PCI, implement Message Signaled Interrupts. Instead of
requesting an interrupt via a wire that runs from the endpoint to the irqchip,
the endpoint can request interrupts by performing a memory write to a specific
register (the "doorbell").

By combining the data written to the doorbell, the address itself, and the
originator of the write, the IRQ chip deduces the destination interrupt
number and destination processing units. Additional devices between the
endpoint and the IRQ chip may translate the doorbell address, the IRQ
number and verify that the endpoint is allowed to send this interrupt.

Different platforms implement IRQ remapping and routing in different ways.
This section describes three ways of dealing with Message Signaled
Interrupts in virtio-iommu devices and drivers.

In simplest systems, the endpoint writes the plain interrupt number to the
doorbell, and the IRQ chip signals the interruption to destination CPUs
programmed by software. Section \ref{sec:viommu / MSI / Address bypass}
describes how to implement a simple system with virtio-iommu. Section
\ref{sec:viommu / MSI / Address translation} describes the added complexity
(from the host point of view) of translating the IRQ chip doorbell.

More complex systems add a level of indirection in the MSI message. The address
or data contains an index into a remapping table, that describes interrupt
delivery in details and is programmed by software either into the IRQ chip or
the IOMMU. Section \ref{sec:viommu / MSI / IRQ remapping} describes how to use
the remapping feature of virtio-iommu.

\subsubsection{Address bypass}\label{sec:viommu / MSI / Address bypass}

\begin{figure}[htb]
  \centering
  \includegraphics{img/MSI-addr-noremap.png}
  \caption{MSI remapping with address bypass}
\end{figure}

Bypassing translation for MSIs is the simplest implementation from the host
perspective. The virtio-iommu device has a special IOVA window that it does not
translate. Any access from devices to that region is forwarded upstream of the
IOMMU without being translated or even checked.

The IRQ chip may or may not have an IRQ remapping component. It may be as
simple as generating the interrupt number described in data, without checking
if the device was allowed to send that interrupt. If there is another
component performing the isolation, one might consider translating the
doorbell address superfluous.

With virtio-iommu, the device can advertise the doorbell address as
untranslated by using the PROBE request with a reserved region (see
\ref{sec:Device Types / IOMMU Device / Device operations / PROBE properties / RESV_MEM}).

For example, if the virtual platform has an IRQ remapping module with a
doorbell in the physical address range 0xfee00000-0xfeefffff, then the
device can present the following property to the driver:

\begin{lstlisting}
struct __attribute__((packed)) {
	struct virtio_iommu_probe_property	head;
	struct virtio_iommu_probe_resv_mem	mem;
} doorbell = {
	.head = {
		.type		= VIRTIO_IOMMU_PROBE_T_RESV_MEM,
		.length		= sizeof(doorbell.mem),
	},
	.mem = {
		.subtype	= VIRTIO_IOMMU_PROBE_RESV_MEM_T_BYPASS,
		.flags		= VIRTIO_IOMMU_PROBE_RESV_MEM_F_MSI,
		.addr		= 0xfee00000,
		.size		= 0x00100000,
	},
};
\end{lstlisting}

\subsubsection{Address translation}\label{sec:viommu / MSI / Address translation}

\begin{figure}[htb]
  \centering
  \includegraphics{img/MSI-addr-remap.png}
  \caption{MSI remapping with address translation}
\end{figure}

On some systems (e.g. ARM-based platforms) the IOMMU does not have a special
MSI window, and MSIs are treated like any other memory write. The MSI address
therefore has to be translated by the IOMMU before reaching the IRQ chip.

Address translation may be used as a rudimentary form of MSI isolation,
but multiple endpoints will typically access the same doorbell. Address
translation can only forbid an endpoint from sending interrupts. If it is
allowed to send MSIs, the endpoint can easily spoof another endpoint by
sending interrupts that were not assigned to it.

From the virtio-iommu point of view, this is the simplest to implement, because
there is no special address range. The whole address space is treated the same
by the virtio-iommu device.

However, this mode of operations may add significant complexity in the host
implementation.


\subsubsection{IRQ remapping}\label{sec:viommu / MSI / IRQ remapping}

Some IOMMUs (e.g. Intel and AMD IOMMUs) are able to remap IRQs themselves. 

\begin{figure}[htb]
  \centering
  \includegraphics{img/MSI-irq-remap.png}
  \caption{MSI remapping with address bypass}
\end{figure}

This version of virtio-iommu doesn't support IRQ remapping.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

