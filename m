Return-Path: virtio-dev-return-4377-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id F188B58191F2
	for <virtio-dev@lists.oasis-open.org>; Wed, 13 Jun 2018 10:59:40 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Date: Wed, 13 Jun 2018 18:58:39 +0100
Message-Id: <20180613175839.12949-1-jean-philippe.brucker@arm.com>
Subject: [virtio-dev] [RFC] virtio-iommu version 0.7
To: virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org
Cc: eric.auger@redhat.com, bharat.bhushan@nxp.com, tnowicki@caviumnetworks.com, kevin.tian@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

This is version 0.7 of the virtio-iommu specification. The diff from 0.6,
included below, is fairly small and consists of the following changes:

* Address comments from 0.6, rework bits of the implementation notes.

* Change resv_mem parameters to be consistent with the rest of the
  spec.

* Add the MMIO flag to MAP requests. At the moment it is used by
  mapped MSIs mostly for completeness, but will be important for IDENTITY
  resv_mem regions that next versions introduce. Please find more
  information about this on the v0.6 thread [1].

  For mapped MSIs, the MMIO flag allows host userspace to easily catch MSI
  maps, and route the rest to VFIO. Without it the host needs to check
  addresses against the MSI doorbell on every map request, before passing
  them down to VFIO. This version makes the flag mandatory in MMIO map
  requests. It could be useful on the unmap request as well but adding
  such flag seems unintuitive (and changes unmap semantics, no way to do
  unmap-all anymore). Adding both flags showed barely any performance
  improvement on my kvmtool prototype. Please let me know if you notice
  anything interesting on the QEMU and vhost prototypes, if you get around
  comparing this.

* A notable change to protection semantics: write-only may imply
  read-write (but read-only never implies read-write). We need this
  behavior because some architectures do not support write-only mappings
  and the corresponding host drivers don't reject write-only map requests.
  I chose to follow POSIX mmap() semantics for this ("if the application
  requests only PROT_WRITE, the implementation may also allow read
  access.")

Sources: git://linux-arm.org/virtio-iommu.git viommu/v0.7
Docs:    http://jpbrucker.net/virtio-iommu/spec/virtio-iommu.pdf
         http://jpbrucker.net/virtio-iommu/spec/virtio-iommu.html
Diff:    http://jpbrucker.net/virtio-iommu/spec/diffs/virtio-iommu-pdf-diff-v0.6-v0.7.pdf

I'll send the updated Linux driver, which you can find on my
virtio-iommu/devel branch, after the merge window.

Next RFCs should be more interesting, with support for page table sharing
and some optimizations. It is progressing nicely but there isn't any rush,
since we're currently discussing the host-side interface in VFIO, which
virtio-iommu will try to follow closely. Since I'm working on a few
related projects, expect a similar cadence (around four months) for next
versions.

[1] https://www.spinics.net/lists/linux-virtualization/msg32628.html


--- >8 ---
diff --git a/MSI.tex b/MSI.tex
index fb54af4..7758fd1 100644
--- a/MSI.tex
+++ b/MSI.tex
@@ -11,22 +11,18 @@ number and destination processing units. Additional devices between the
 endpoint and the IRQ chip may translate the doorbell address, the IRQ
 number and verify that the endpoint is allowed to send this interrupt.
 
-Different platforms implement IRQ remapping and routing in different ways.
-This section describes three ways of dealing with Message Signaled
-Interrupts in virtio-iommu devices and drivers.
-
-In simplest systems, the endpoint writes the plain interrupt number to the
+Different platforms implement IRQ remapping and routing in different ways. In
+simplest systems, the endpoint writes the plain interrupt number to the
 doorbell, and the IRQ chip signals the interruption to destination CPUs
-programmed by software. Section \ref{sec:viommu / MSI / Address bypass}
-describes how to implement a simple system with virtio-iommu. Section
-\ref{sec:viommu / MSI / Address translation} describes the added complexity
-(from the host point of view) of translating the IRQ chip doorbell.
+programmed by software. Sections \ref{sec:viommu / MSI / Address bypass} and
+\ref{sec:viommu / MSI / Address translation} describe two ways of implementing
+MSIs with virtio-iommu.
 
 More complex systems add a level of indirection in the MSI message. The address
 or data contains an index into a remapping table, that describes interrupt
 delivery in details and is programmed by software either into the IRQ chip or
-the IOMMU. Section \ref{sec:viommu / MSI / IRQ remapping} describes how to use
-the remapping feature of virtio-iommu.
+the IOMMU. This is shown in section \ref{sec:viommu / MSI / IRQ remapping} but
+isn't yet supported by virtio-iommu.
 
 \subsubsection{Address bypass}\label{sec:viommu / MSI / Address bypass}
 
@@ -66,8 +62,8 @@ struct __attribute__((packed)) {
 	},
 	.mem = {
 		.subtype	= VIRTIO_IOMMU_RESV_MEM_T_MSI,
-		.addr		= 0xfee00000,
-		.size		= 0x00100000,
+		.start		= 0xfee00000,
+		.end		= 0xfeefffff,
 	},
 };
 \end{lstlisting}
@@ -90,13 +86,20 @@ translation can only forbid an endpoint from sending interrupts. If it is
 allowed to send MSIs, the endpoint can easily spoof another endpoint by
 sending interrupts that were not assigned to it.
 
-From the virtio-iommu point of view, this is the simplest to implement, because
-there is no special address range. The whole address space is treated the same
-by the virtio-iommu device.
-
-However, this mode of operations may add significant complexity in the host
-implementation.
-
+From the virtio-iommu point of view, this is the simplest to implement,
+because there is no special address range and no need for a PROBE request.
+The whole address space is treated the same way by the virtio-iommu
+device.
+
+However, this mode of operations may add some complexity in the host
+implementation. To setup MSIs, the guest writes an IOVA into the MSI-X
+table of the PCI endpoint. One possible host implementation emulates IRQ
+chips and captures requests that map virtual addresses to doorbell
+registers. These requests have the VIRTIO_IOMMU_MAP_F_MMIO flag set,
+making them easy to differentiate from requests that target normal memory
+and are forwarded to the physical IOMMU driver. The host also traps
+accesses to the endpoint's MSI-X table, and creates IRQ routes by
+translating the written IOVA into the corresponding doorbell.
 
 \subsubsection{IRQ remapping}\label{sec:viommu / MSI / IRQ remapping}
 
diff --git a/assignment.tex b/assignment.tex
index 4e26a9c..e372713 100644
--- a/assignment.tex
+++ b/assignment.tex
@@ -35,8 +35,9 @@ struct __attribute__((packed)) {
 		.length		= sizeof(resv.mem),
 	},
 	.mem = {
-		.addr		= 0x08000000,
-		.size		= 0x00100000,
+		.subtype	= VIRTIO_IOMMU_RESV_MEM_T_RESERVED,
+		.start		= 0x08000000,
+		.end		= 0x080fffff,
 	},
 };
 \end{lstlisting}
diff --git a/device-operations.tex b/device-operations.tex
index 40c68cf..7af6fb0 100644
--- a/device-operations.tex
+++ b/device-operations.tex
@@ -294,15 +294,6 @@ If the VIRTIO_IOMMU_F_DOMAIN_BITS feature is offered, the driver SHOULD
 NOT send requests with \field{domain} greater than the size described by
 \field{domain_bits}.
 
-% We mandate truncation to allow a future extension X.Y that would store
-% information in addresses and domain IDs.
-%
-% If device is 0.2 and driver is X.Y, then device ignores ext. bits. But
-% if device is X.Y and device is 0.2, then driver *might* set ext. bits to
-% garbage. But this extension would be negotiated with a feature bit
-% anyway. If it's not, then device must assume that driver is 0.2 and must
-% keep truncating the fields.
-
 The driver SHOULD NOT use multiple descriptor chains for a single request.
 
 \devicenormative{\subsubsection}{Device operations}{Device Types / IOMMU Device / Device operations}
@@ -321,12 +312,14 @@ to zero.
 The device MUST ignore reserved fields of the head and the tail of a
 request.
 
-If the VIRTIO_IOMMU_F_INPUT_RANGE feature is offered, the device MUST
-truncate the range described by \field{virt_start} and \field{virt_end} in
-requests to fit in the range described by \field{input_range}.
+If the VIRTIO_IOMMU_F_INPUT_RANGE feature is offered and the range
+described by fields \field{virt_start} and \field{virt_end} doesn't fit in
+the range described by \field{input_range}, the device MAY set
+\field{status} to VIRTIO_IOMMU_S_RANGE and ignore the request.
 
-If the VIRTIO_IOMMU_F_DOMAIN_BITS is offered, the device MUST ignore bits
-above \field{domain_bits} in field \field{domain} of requests.
+If the VIRTIO_IOMMU_F_DOMAIN_BITS is offered and bits above
+\field{domain_bits} are set in field \field{domain}, the device MAY set
+\field{status} to VIRTIO_IOMMU_S_RANGE and ignore the request.
 
 \subsubsection{ATTACH request}\label{sec:Device Types / IOMMU Device / Device operations / ATTACH request}
 
@@ -415,7 +408,9 @@ struct virtio_iommu_req_detach {
 \end{lstlisting}
 
 Detach an endpoint from its domain. When this request completes, the
-endpoint cannot access any mapping from that domain anymore.
+endpoint cannot access any mapping from that domain anymore. If feature
+VIRTIO_IOMMU_F_BYPASS has been negotiated, then the endpoint accesses the
+guest-physical address space once this request completes.
 
 After all endpoints have been successfully detached from a domain, it
 ceases to exist and its ID can be reused by the driver for another domain.
@@ -457,6 +452,7 @@ struct virtio_iommu_req_map {
 #define VIRTIO_IOMMU_MAP_F_READ		(1 << 0)
 #define VIRTIO_IOMMU_MAP_F_WRITE	(1 << 1)
 #define VIRTIO_IOMMU_MAP_F_EXEC		(1 << 2)
+#define VIRTIO_IOMMU_MAP_F_MMIO		(1 << 3)
 \end{lstlisting}
 
 Map a range of virtually-contiguous addresses to a range of
@@ -478,15 +474,23 @@ guest-physical addresses for use by the host (for instance MSI doorbells).
 Guest physical boundaries are set by the host using a firmware mechanism
 outside the scope of this specification.
 
-\begin{note}
-On flags: it is unlikely that all possible combinations of flags will be
-supported by the physical IOMMU. For instance, $W \& !R$ or $X \& W$ might
-be invalid. We do not have a way to advertise supported and implicit (for
-instance $W \rightarrow R$) flags or combination thereof for the moment,
-you are free to send any suggestions for describing this. Please keep in
-mind that we might soon want to add more flags, such as privileged,
-device, transient, shared, etc. (whatever these would mean).
-\end{note}
+Availability and allowed combinations of \field{flags} depend of the
+underlying IOMMU architectures. VIRTIO_IOMMU_MAP_F_READ and
+VIRTIO_IOMMU_MAP_F_WRITE are usually implemented, although READ is
+sometimes implied. VIRTIO_IOMMU_MAP_F_EXEC might not be available. In
+addition combinations such as "WRITE and not READ" or "WRITE and EXEC"
+might not be supported.
+
+The VIRTIO_IOMMU_MAP_F_MMIO flag is a memory type rather than a protection
+lag. It may be used, for example, to map Message Signaled Interrupt
+doorbells when a VIRTIO_IOMMU_RESV_MEM_T_MSI region isn't available. To
+trigger interrupts the endpoint performs a direct memory write to another
+peripheral, the IRQ chip. Since it is a signal, the write must not be
+buffered, elided, or combined with other writes by the memory
+interconnect. The precise meaning of the MMIO flag depends on the
+underlying memory architecture (for example on Armv8-A it corresponds to
+the "Device-nGnRE" memory type). Unless needed by mapped MSIs, the device
+isn't required to support the MMIO flag.
 
 This request is only available when VIRTIO_IOMMU_F_MAP_UNMAP has been
 negotiated.
@@ -497,6 +501,11 @@ The driver SHOULD set undefined \field{flags} bits to zero.
 
 \field{virt_end} MUST be strictly greater than \field{virt_start}.
 
+The driver SHOULD set the VIRTIO_IOMMU_MAP_F_MMIO flag when the physical
+range corresponds to memory-mapped device registers. The physical range
+SHOULD have a single memory type: either normal memory or memory-mapped
+I/O.
+
 \devicenormative{\paragraph}{MAP request}{Device Types / IOMMU Device / Device operations / MAP request}
 
 If \field{virt_start}, \field{phys_start} or (\field{virt_end} + 1) is
@@ -510,6 +519,15 @@ here, because the driver might be attempting to map with special flags
 that the device doesn't recognize. Creating the mapping with incompatible
 flags may introduce a security hazard.}
 
+If a flag or combination of flag isn't supported, the device MAY set the
+request \field{status} to VIRTIO_IOMMU_S_UNSUPP.
+
+The device MUST NOT allow writes to a range mapped without the
+VIRTIO_IOMMU_MAP_F_WRITE flag. However, if the underlying architecture
+does not support write-only mappings, the device MAY allow reads to a
+range mapped with VIRTIO_IOMMU_MAP_F_WRITE but not
+VIRTIO_IOMMU_MAP_F_READ.
+
 If \field{domain} does not exist, the device SHOULD set the request
 \field{status} to VIRTIO_IOMMU_S_NOENT.
 
@@ -730,21 +748,24 @@ allocated by the driver, or that are special.
 struct virtio_iommu_probe_resv_mem {
 	u8	subtype;
 	u8	reserved[3];
-	le64	addr;
-	le64	size;
+	le64	start;
+	le64	end;
 };
 \end{lstlisting}
 
-Fields \field{addr} and \field{size} describe the range of reserved
-virtual addresses. \field{subtype} may be one of:
+Fields \field{start} and \field{end} describe the range of reserved virtual
+addresses. \field{subtype} may be one of:
 
 \begin{description}
   \item[VIRTIO_IOMMU_RESV_MEM_T_RESERVED (0)]
-    Accesses to virtual addresses in this region are not translated by the
-    device. They may either be aborted by the device (or the underlying
-    IOMMU), bypass it, or never even reach it. The guest should neither
-    use these virtual addresses in a MAP request nor instruct endpoints to
-    perform DMA on them.
+    Accesses to virtual addresses in this region have undefined behavior.
+    They may be aborted by the device, bypass it, or never even reach it.
+    The region may also be used for host mappings, for example Message
+    Signaled Interrupts (see \ref{sec:viommu / Hardware device
+    assignment}).
+
+    The guest should neither use these virtual addresses in a MAP request
+    nor instruct endpoints to perform DMA on them.
 
   \item[VIRTIO_IOMMU_RESV_MEM_T_MSI (1)]
     This region is a doorbell for Message Signaled Interrupts (MSIs). It

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

