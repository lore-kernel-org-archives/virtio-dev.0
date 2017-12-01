Return-Path: virtio-dev-return-2735-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 10C8F5818FE7
	for <virtio-dev@lists.oasis-open.org>; Fri,  1 Dec 2017 07:43:03 -0800 (PST)
Date: Fri, 1 Dec 2017 15:46:10 +0000
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <a70bca26-778a-c917-357f-0717466d843f@arm.com>
References: <20171023093241.20113-1-jean-philippe.brucker@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171023093241.20113-1-jean-philippe.brucker@arm.com>
Content-Language: en-US
Subject: [virtio-dev] Re: [RFC] virtio-iommu version 0.5
To: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: Will Deacon <Will.Deacon@arm.com>, Robin Murphy <Robin.Murphy@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, Marc Zyngier <Marc.Zyngier@arm.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>, "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>, "bharat.bhushan@nxp.com" <bharat.bhushan@nxp.com>, "peterx@redhat.com" <peterx@redhat.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>, "Jayachandran.Nair@cavium.com" <Jayachandran.Nair@cavium.com>, "ashok.raj@intel.com" <ashok.raj@intel.com>, Alex Williamson <alex.williamson@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Hello,

Since we still have time to introduce disruptive changes, I'm
considering changing the UNMAP parameters slightly. Behavior stays the
same, but instead of passing virt_addr and size, we pass virt_start and
virt_end:

struct virtio_iommu_req_unmap {
        le32    domain;
        le64    virt_start;
        le64    virt_end;
        le32    reserved;
};

And for symmetry, also change MAP:

struct virtio_iommu_req_map {
        le32    domain;
        le64    phys_start;
        le64    virt_start;
        le64    virt_end;
        le32    flags;
};

This would allow to express the full 64-bit range in MAP and UNMAP
requests. Currently the MAP description dismisses this case with "just
use VIRTIO_IOMMU_F_BYPASS if you need an identity mapping", and I think
it still holds. But for UNMAP it can be useful to send a single request
covering the full address space instead of lots of individual requests.

I had this problem when implementing ATTACH/DETACH in kvmtool, because
VFIO doesn't have an explicit unmap-all command (and kvmtool doesn't
keep track of the mappings). When changing a device's domain, I had to
send two unmap commands, one for each half of the address space. It's
not a huge problem, just a bit inconvenient.

I don't see how unmap-all would be useful for virtio-iommu at the moment
(since detaching the domain unmaps all) but just like it turns out to be
desirable in VFIO, I'm sure someone will need it in virtio-iommu one
day.

Alternatively we could change \field{reserved} of the unmap request into
\field{flags} and add an UNMAP_ALL flag. This is backward-compatible and
less invasive. Introducing a new UNMAP_ALL request would probably be
cleaner though. In any case, I personally prefer start and end
parameter, it looks nicer. The changeset below looks scary, but it's
mostly reformatting.

Please let me know if you have any objection, or other comment for 0.5.

Thanks,
Jean

--- 8< ---
Subject: [PATCH] Change MAP and UNMAP parameters

Passing start/end instead of start/size to MAP and UNMAP offers more
flexibility. UNMAP can now be used to unmap the whole address space in
one go. UNMAP(domain, 0, ~0ULL) should now remove all mappings.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 device-operations.tex | 124 +++++++++++++++++++++++++-------------------------
 1 file changed, 61 insertions(+), 63 deletions(-)

diff --git a/device-operations.tex b/device-operations.tex
index 9b35283..3ecafd3 100644
--- a/device-operations.tex
+++ b/device-operations.tex
@@ -21,15 +21,15 @@ types:
   \texttt{attach(device = 0x104, domain = 1)}
 \item Create a mapping between a range of guest-virtual and guest-physical
   address. \\
-  \texttt{map(domain = 1, virt = 0x1000, phys = 0xa000,
-          size = 0x1000, flags = READ)}
+  \texttt{map(domain = 1, virt_start = 0x1000, virt_end = 0x1fff,
+          phys = 0xa000, flags = READ)}

   Endpoint 0x104, for example a hardware PCI endpoint, can now read at
   addresses 0x1000-0x1fff. These accesses are translated into
   system-physical addresses by the IOMMU.

 \item Remove the mapping.\\
-  \texttt{unmap(domain = 1, virt = 0x1000, size = 0x1000)}
+  \texttt{unmap(domain = 1, virt_start= 0x1000, virt_end = 0x1fff)}

   Any access to addresses 0x1000-0x1fff by endpoint 0x104 would now be
   rejected.
@@ -286,8 +286,9 @@ written to it, the driver SHOULD interpret it as a failure from the device
 to parse the request.

 If the VIRTIO_IOMMU_F_INPUT_RANGE feature is offered, the driver SHOULD
-NOT send requests with \field{virt_addr} less than
-\field{input_range.start} or greater than \field{input_range.end}.
+NOT send requests with \field{virt_start} less than
+\field{input_range.start} or \field{virt_end} greater than
+\field{input_range.end}.

 If the VIRTIO_IOMMU_F_DOMAIN_BITS feature is offered, the driver SHOULD
 NOT send requests with \field{domain} greater than the size described by
@@ -321,7 +322,7 @@ The device MUST ignore reserved fields of the head and the tail of a
 request.

 If the VIRTIO_IOMMU_F_INPUT_RANGE feature is offered, the device MUST
-truncate the range described by \field{virt_addr} and \field{size} in
+truncate the range described by \field{virt_start} and \field{virt_end} in
 requests to fit in the range described by \field{input_range}.

 If the VIRTIO_IOMMU_F_DOMAIN_BITS is offered, the device MUST ignore bits
@@ -446,9 +447,9 @@ endpoint cannot access any mapping from that domain.
 \begin{lstlisting}
 struct virtio_iommu_req_map {
 	le32	domain;
-	le64	phys_addr;
-	le64	virt_addr;
-	le64	size;
+	le64	phys_start;
+	le64	virt_start;
+	le64	virt_end;
 	le32	flags;
 };

@@ -461,30 +462,21 @@ struct virtio_iommu_req_map {
 Map a range of virtually-contiguous addresses to a range of
 physically-contiguous addresses of the same size. After the request
 succeeds, all endpoints attached to this domain can access memory in the
-range $[phys\_addr; phys\_addr + size[$. For example, if an endpoint
-accesses address $VA \in [virt\_addr; virt\_addr + size[$, the device (or
-the physical IOMMU) translates the address: $PA = VA - virt\_addr +
-phys\_addr$. If the access parameters are compatible with \field{flags}
-(for instance, the access is write and \field{flags} are
-VIRTIO_IOMMU_MAP_F_READ | VIRTIO_IOMMU_MAP_F_WRITE) then the IOMMU allows
-the access to reach $PA$.
-
-The range defined by (\field{virt_addr}, \field{size}) must be within the
-limits specified by \field{input_range}. The range defined by
-(\field{phys_addr}, \field{size}) must be within the guest-physical
-address space. This includes upper and lower limits, as well as any
-carving of guest-physical addresses for use by the host (for instance MSI
-doorbells). Guest physical boundaries are set by the host using a firmware
-mechanism outside the scope of this specification.
-
-\begin{note}
-This format prevents from creating the identity mapping in a single
-request \texttt{[0x0; 0xfff....fff] $\rightarrow$ [0x0; 0xfff...fff]},
-since it would result in a size of zero. Hopefully allowing
-VIRTIO_IOMMU_F_BYPASS eliminates the need for issuing such request. It
-would also be unlikely to conform to the physical range restrictions
-from the previous paragraph.
-\end{note}
+range $[virt\_start; virt\_end]$. For example, if an endpoint accesses
+address $VA \in [virt\_start; virt\_end]$, the device (or the physical
+IOMMU) translates the address: $PA = VA - virt\_start + phys\_start$. If
+the access parameters are compatible with \field{flags} (for instance, the
+access is write and \field{flags} are VIRTIO_IOMMU_MAP_F_READ |
+VIRTIO_IOMMU_MAP_F_WRITE) then the IOMMU allows the access to reach $PA$.
+
+The range defined by \field{virt_start} and \field{virt_end} should be
+within the limits specified by \field{input_range}. Given $phys\_end =
+phys\_start + virt\_end - virt\_start$, the range defined by
+\field{phys_start} and phys_end should be within the guest-physical address
+space. This includes upper and lower limits, as well as any carving of
+guest-physical addresses for use by the host (for instance MSI doorbells).
+Guest physical boundaries are set by the host using a firmware mechanism
+outside the scope of this specification.

 \begin{note}
 On flags: it is unlikely that all possible combinations of flags will be
@@ -503,11 +495,13 @@ negotiated.

 The driver SHOULD set undefined \field{flags} bits to zero.

+\field{virt_end} MUST be strictly greater than \field{virt_start}.
+
 \devicenormative{\paragraph}{MAP request}{Device Types / IOMMU Device / Device operations / MAP request}

-If \field{virt_addr}, \field{phys_addr} or \field{size} is not aligned on
-the page granularity, the device SHOULD set the request \field{status} to
-VIRTIO_IOMMU_S_RANGE and SHOULD NOT create the mapping.
+If \field{virt_start}, \field{phys_start} or (\field{virt_end} + 1) is
+not aligned on the page granularity, the device SHOULD set the request
+\field{status} to VIRTIO_IOMMU_S_RANGE and SHOULD NOT create the mapping.

 If the device doesn't recognize a \field{flags} bit, it SHOULD set the
 request \field{status} to VIRTIO_IOMMU_S_INVAL. In this case the device
@@ -524,45 +518,49 @@ If \field{domain} does not exist, the device SHOULD set the request
 \begin{lstlisting}
 struct virtio_iommu_req_unmap {
 	le32	domain;
-	le64	virt_addr;
-	le64	size;
+	le64	virt_start;
+	le64	virt_end;
 	le32	reserved;
 };
 \end{lstlisting}

 Unmap a range of addresses mapped with VIRTIO_IOMMU_T_MAP. We define here
 a mapping as a virtual region created with a single MAP request. All
-mappings covered by the range $[virt\_addr; virt\_addr + size [$ are
-removed.
+mappings covered by the range $[virt\_start; virt\_end]$ are removed.

-The semantics of unmapping are specified below, and illustrated with the
-following requests, assuming each example sequence starts with a blank
-address space. We define two pseudocode functions \texttt{map(virt\_addr,
-size) -> mapping} and \texttt{unmap(virt\_addr, size)}.
+The semantics of unmapping are specified in \ref{drivernormative:Device
+Types / IOMMU Device / Device operations / UNMAP request} and
+\ref{devicenormative:Device Types / IOMMU Device / Device operations /
+UNMAP request}, and illustrated with the following requests, assuming each
+example sequence starts with a blank address space. We define two
+pseudocode functions \texttt{map(virt_start, virt_end) -> mapping} and
+\texttt{unmap(virt_start, virt_end)}.

 \begin{lstlisting}
-(1) unmap(addr=0, size=5)        -> succeeds, doesn't unmap anything
+(1) unmap(virt_start=0,
+          virt_end=4)            -> succeeds, doesn't unmap anything

-(2) a = map(addr=0, size=10);
-    unmap(0, 10)                 -> succeeds, unmaps a
+(2) a = map(virt_start=0,
+            virt_end=9);
+    unmap(0, 9)                  -> succeeds, unmaps a

-(3) a = map(0, 5);
-    b = map(5, 5);
-    unmap(0, 10)                 -> succeeds, unmaps a and b
+(3) a = map(0, 4);
+    b = map(5, 9);
+    unmap(0, 9)                  -> succeeds, unmaps a and b

-(4) a = map(0, 10);
-    unmap(0, 5)                  -> faults, doesn't unmap anything
+(4) a = map(0, 9);
+    unmap(0, 4)                  -> faults, doesn't unmap anything

-(5) a = map(0, 5);
-    b = map(5, 5);
-    unmap(0, 5)                  -> succeeds, unmaps a
+(5) a = map(0, 4);
+    b = map(5, 9);
+    unmap(0, 4)                  -> succeeds, unmaps a

-(6) a = map(0, 5);
-    unmap(0, 10)                 -> succeeds, unmaps a
+(6) a = map(0, 4);
+    unmap(0, 9)                  -> succeeds, unmaps a

-(7) a = map(0, 5);
-    b = map(10, 5);
-    unmap(0, 15)                 -> succeeds, unmaps a and b
+(7) a = map(0, 4);
+    b = map(10, 14);
+    unmap(0, 14)                 -> succeeds, unmaps a and b
 \end{lstlisting}

 This request is only available when VIRTIO_IOMMU_F_MAP_UNMAP has been
@@ -572,9 +570,9 @@ negotiated.

 The driver SHOULD set the \field{reserved} field to zero.

-The range, defined by \field{virt_addr} and \field{size}, SHOULD cover one
-or more contiguous mappings created with MAP requests. The range MAY spill
-over unmapped virtual addresses.
+The range, defined by \field{virt_start} and \field{virt_end}, SHOULD
+cover one or more contiguous mappings created with MAP requests. The range
+MAY spill over unmapped virtual addresses.

 The first address of a range SHOULD either be the first address of a
 mapping or be outside any mapping. The last address of a range SHOULD
--
2.14.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

