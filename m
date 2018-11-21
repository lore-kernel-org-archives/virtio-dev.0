Return-Path: virtio-return-3191-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Wed, 21 Nov 2018 12:38:10 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181121173344.475-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio] [PATCH v2] ACCESS_PLATFORM/ACCESS_ORDER
To: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: Tiwei Bie <tiwei.bie@intel.com>, mst@redhat.com, cohuck@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, jasowang@redhat.com, pasic@linux.vnet.ibm.com, dan.daly@intel.com, cunming.liang@intel.com, zhihong.wang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

This is an attempt to clarify the intent behind
VIRTIO_F_IOMMU_PLATFORM and VIRTIO_F_IO_BARRIER
which based on recent discussions appear to be hard to understand.

- rename VIRTIO_F_IOMMU_PLATFORM to ACCESS_PLATFORM
  It is already the fact that the DMA API that Linux
  uses does more than just IOMMUs - it includes
  cache flushing, bounce buffers for limited
  addressing, etc.
  Update spec to match this reality.

- rename VIRTIO_F_IO_BARRIER to VIRTIO_F_ORDER_PLATFORM
  this is after all what device is telling driver:
  its memory accesses are only ordered weakly,
  this is why a stronger barrier is required.

- Explain that with IO_BARRIER (now ORDER_PLATFORM) not negotiating it
  is not a good idea *even if it does not fail*: device can
  have a slower software fallback so that existing drivers
  aren't broken.

- Recommend that for maximum portability both bits are offered.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

Changes from v1:
- try to address comments by Jason Wang
  add a ote that it is RECOMMENDED that hardware devices offer both bits
- soften recommendation to support an emulation mode
  to MAY


 content.tex | 73 +++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 51 insertions(+), 22 deletions(-)

diff --git a/content.tex b/content.tex
index c346183..fe02715 100644
--- a/content.tex
+++ b/content.tex
@@ -5452,26 +5452,46 @@ Descriptors} and \ref{sec:Packed Virtqueues / Indirect Flag: Scatter-Gather Supp
   \item[VIRTIO_F_VERSION_1(32)] This indicates compliance with this
     specification, giving a simple way to detect legacy devices or drivers.
 
-  \item[VIRTIO_F_IOMMU_PLATFORM(33)] This feature indicates that the device is
+  \item[VIRTIO_F_ACCESS_PLATFORM(33)] This feature indicates that
+  the device can be used in a platform where device access to data
+  in memory is limited and/or translated. E.g. this is the case if the device can be located
   behind an IOMMU that translates bus addresses from the device into physical
-  addresses in memory.  If this feature bit is set to 0, then the device emits
-  physical addresses which are not translated further, even though an IOMMU
-  may be present.
+  addresses in memory, if device can be limited to only access
+  certain memory addresses or if special commands such as
+  a cache flush can be needed to synchronise data in memory with
+  the device. Whether accesses are actually limited or translated
+  is described by platform-specific means.
+  If this feature bit is set to 0, then the device
+  has same access to memory addresses supplied to it as the driver.
+  In particular it will always use physical addresses
+  matching addresses used by driver (typically the CPU)
+  and not translated further, and can access any address supplied to it by
+  driver. When clear, this overrides any platform-specific description of
+  whether device access is limited or translated in any way, e.g.
+  whether an IOMMU may be present.
   \item[VIRTIO_F_RING_PACKED(34)] This feature indicates
   support for the packed virtqueue layout as described in
   \ref{sec:Basic Facilities of a Virtio Device / Packed Virtqueues}~\nameref{sec:Basic Facilities of a Virtio Device / Packed Virtqueues}.
   \item[VIRTIO_F_IN_ORDER(35)] This feature indicates
   that all buffers are used by the device in the same
   order in which they have been made available.
-  \item[VIRTIO_F_IO_BARRIER(36)] This feature indicates
-  that the device needs the driver to use the barriers
-  suitable for hardware devices.  Some transports require
-  barriers to ensure devices have a consistent view of
-  memory.  When devices are implemented in software a
-  weaker form of barrier may be sufficient and yield
-  better performance.  This feature indicates whether
-  a stronger form of barrier suitable for hardware
-  devices is necessary.
+  \item[VIRTIO_F_ORDER_PLATFORM(36)] This feature indicates
+  that memory accesses by driver and device are ordered
+  in a way described by the platform.
+  If this feature bit is negotiated, then for any memory
+  accesses by the driver that need to be ordered
+  in a specific way with respect to access by
+  the device, the ordering in effect is the one
+  suitable for devices described by the platform,
+  and he driver needs to use memory barriers
+  suitable for devices described by the platform,
+  e.g. for the PCI transport, for hardware PCI devices.
+  If this feature bit is set to 0, then the device
+  and driver are assumed to be implemented in software, that is
+  they can be assumed to run on identical CPUs
+  in an SMP configuration.
+  Thus a weaker form of memory barriers is sufficient
+  to yield better performance.
   \item[VIRTIO_F_SR_IOV(37)] This feature indicates that
   the device supports Single Root I/O Virtualization.
   Currently only PCI devices support this feature.
@@ -5482,16 +5502,16 @@ Descriptors} and \ref{sec:Packed Virtqueues / Indirect Flag: Scatter-Gather Supp
 A driver MUST accept VIRTIO_F_VERSION_1 if it is offered.  A driver
 MAY fail to operate further if VIRTIO_F_VERSION_1 is not offered.
 
-A driver SHOULD accept VIRTIO_F_IOMMU_PLATFORM if it is offered, and it MUST
+A driver SHOULD accept VIRTIO_F_ACCESS_PLATFORM if it is offered, and it MUST
 then either disable the IOMMU or configure the IOMMU to translate bus addresses
 passed to the device into physical addresses in memory.  If
-VIRTIO_F_IOMMU_PLATFORM is not offered, then a driver MUST pass only physical
+VIRTIO_F_ACCESS_PLATFORM is not offered, then a driver MUST pass only physical
 addresses to the device.
 
 A driver SHOULD accept VIRTIO_F_RING_PACKED if it is offered.
 
-A driver SHOULD accept VIRTIO_F_IO_BARRIER if it is offered.
-If VIRTIO_F_IO_BARRIER has been negotiated, a driver MUST use
+A driver SHOULD accept VIRTIO_F_ORDER_PLATFORM if it is offered.
+If VIRTIO_F_ORDER_PLATFORM has been negotiated, a driver MUST use
 the barriers suitable for hardware devices.
 
 \devicenormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}
@@ -5499,16 +5519,25 @@ the barriers suitable for hardware devices.
 A device MUST offer VIRTIO_F_VERSION_1.  A device MAY fail to operate further
 if VIRTIO_F_VERSION_1 is not accepted.
 
-A device SHOULD offer VIRTIO_F_IOMMU_PLATFORM if it is behind an IOMMU that
-translates bus addresses from the device into physical addresses in memory.
-A device MAY fail to operate further if VIRTIO_F_IOMMU_PLATFORM is not
+A device SHOULD offer VIRTIO_F_ACCESS_PLATFORM if it's access to
+memory is through bus addresses distinct from and translated
+by the platform to physical addresses used by the driver, and/or
+if it can only access certain memory addresses with said access
+specified and/or granted by the platform.
+A device MAY fail to operate further if VIRTIO_F_ACCESS_PLATFORM is not
 accepted.
 
 If VIRTIO_F_IN_ORDER has been negotiated, a device MUST use
 buffers in the same order in which they have been available.
 
-A device MAY fail to operate further if VIRTIO_F_IO_BARRIER
-is not accepted.
+A device MAY fail to operate further if
+VIRTIO_F_ORDER_PLATFORM is offered but not accepted.
+A device MAY operate in a slower emulation mode if
+VIRTIO_F_ORDER_PLATFORM is offered but not accepted.
+
+It is RECOMMENDED that an add-in card based PCI device
+offer both VIRTIO_F_ACCESS_PLATFORM and
+VIRTIO_F_ORDER_PLATFORM for maximum portability.
 
 A device SHOULD offer VIRTIO_F_SR_IOV if it is a PCI device
 and presents a PCI SR-IOV capability structure, otherwise
-- 
MST

---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

