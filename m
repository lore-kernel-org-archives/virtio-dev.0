Return-Path: virtio-dev-return-7977-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2B288986621
	for <virtio-dev@lists.oasis-open.org>; Fri,  5 Feb 2021 18:02:00 +0000 (UTC)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
Date: Fri,  5 Feb 2021 18:58:12 +0100
Message-Id: <20210205175812.143886-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH 0/4] virtio-iommu: Support page tables
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="US-ASCII"
To: virtio-dev@lists.oasis-open.org
Cc: eric.auger@redhat.com, kevin.tian@intel.com, vivek.gautam@arm.com, Jean-Philippe Brucker <jean-philippe@linaro.org>
List-ID: <virtio-dev.lists.oasis-open.org>

Add page table support to the virtio-iommu specification, to enable
acceleration and later Shared Virtual Memory.

The interface currently offered by virtio-iommu is simple to implement
and sufficiently efficient for solutions based on static mappings, such
as DPDK running in guest userspace. While that's an essential use-case
for virtio-iommu, it is not the only DMA remapping usage, and the
MAP/UNMAP interface performs rather poorly for dynamic mappings.
Unsurprisingly a given vIOMMU model cannot be simple, efficient and
secure for all possible use-cases. It's always a compromise.

This extension adds:

* New PROBE properties that describe table formats available for each
  endpoints.
* An ATTACH_TABLE request to be used in place of an ATTACH, that
  provides a guest-physical address to a table.
* An INVALIDATE request to signal destructive changes.

Those tables may be:

(1) Page tables that are read directly by the hardware IOMMU, for
  hardware endpoints. An example for Arm SMMU is given in patch 4. The
  driver writes mappings into the table, and sends invalidations when
  removing mappings that could have been cached in an IOTLB. This
  divides the number of context switches to the host by at least two
  (much more with lazy invalidation), and with a vhost IOMMU the
  invalidation itself should be relatively cheap compared to an emulated
  viommu.

  I don't expect a large proliferation of table formats because they are
  relatively stable. A few extensible formats is more likely: two tables
  for Arm until they run out of PTE bits, one or two page tables for
  x86, and a couple for other architectures.

(2) Tables that are read by a software component performing DMA, for
  emulated and paravirtual endpoints. These could be your garden-variety
  page tables from (1) but being paravirtual we have the opportunity to
  design more efficient solutions. For example a virtio/vhost endpoint
  accesses rings often and leaf buffers once. If the virtio-iommu device
  avoids caching leaf buffers, the driver does not need to send
  invalidations and we get almost no context switches for vIOMMU
  operations. A purposely designed page table can provide a handshake
  between device and driver to avoid sending invalidations for uncached
  mappings.

(3) Tables that complement the MAP_UNMAP interface to help reduce
  context switches. The coIOMMU model [1] provides a DMA tracking table
  for co-operative pinning.


An example driver implementation was submitted by Vivek Gautam [2],
based on an older version of this extension (0.10-dev03). Since then
I've reworked some of the structures and improved the wording. To ease
review I uploaded a PDF with these changes, plus one with diff colors,
here:

https://jpbrucker.net/virtio-iommu/spec/virtio-iommu-v0.13.pdf
https://jpbrucker.net/virtio-iommu/spec/virtio-iommu-diff-v0.12-v0.13.pdf


[1] https://www.usenix.org/system/files/atc20-tian.pdf
[2] https://lore.kernel.org/linux-iommu/20210115121342.15093-1-vivek.gautam=
@arm.com/

Jean-Philippe Brucker (4):
  virtio-iommu: Add ATTACH_TABLE request
  virtio-iommu: Add INVALIDATE request
  virtio-iommu: Add PROBE properties for tables
  virtio-iommu: Add Arm 64-bit page tables

 introduction.tex |   6 +
 virtio-iommu.tex | 564 ++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 560 insertions(+), 10 deletions(-)

--=20
2.30.0


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

