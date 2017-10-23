Return-Path: virtio-dev-return-2621-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 8CC8658190F3
	for <virtio-dev@lists.oasis-open.org>; Mon, 23 Oct 2017 02:27:24 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Date: Mon, 23 Oct 2017 10:32:41 +0100
Message-Id: <20171023093241.20113-1-jean-philippe.brucker@arm.com>
Subject: [virtio-dev] [RFC] virtio-iommu version 0.5
To: iommu@lists.linux-foundation.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org
Cc: will.deacon@arm.com, robin.murphy@arm.com, lorenzo.pieralisi@arm.com, mst@redhat.com, jasowang@redhat.com, marc.zyngier@arm.com, eric.auger@redhat.com, eric.auger.pro@gmail.com, bharat.bhushan@nxp.com, peterx@redhat.com, kevin.tian@intel.com, Jayachandran.Nair@cavium.com, ashok.raj@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

This is version 0.5 of the virtio-iommu specification, the paravirtualized
IOMMU. This version addresses feedback from v0.4 and adds an event virtqueue.
Please find the specification, LaTeX sources and pdf, at:
git://linux-arm.org/virtio-iommu.git viommu/v0.5
http://linux-arm.org/git?p=virtio-iommu.git;a=blob;f=dist/v0.5/virtio-iommu-v0.5.pdf

A detailed changelog since v0.4 follows. You can find the pdf diff at:
http://linux-arm.org/git?p=virtio-iommu.git;a=blob;f=dist/diffs/virtio-iommu-pdf-diff-v0.4-v0.5.pdf

* Add an event virtqueue for the device to report translation faults to
  the driver. For the moment only unrecoverable faults are available but
  future versions will extend it.
* Simplify PROBE request by removing the ack part, and flattening RESV
  properties.
* Rename "address space" to "domain". The change might seem futile but
  allows to introduce PASIDs and other features cleanly in the next
  versions. In the same vein, the few remaining "device" occurrences were
  replaced by "endpoint", to avoid any confusion with "the device"
  referring to the virtio device across the document.
* Add implementation notes for RESV_MEM properties.
* Update ACPI table definition.
* Fix typos and clarify a few things.

I will publish the Linux driver for v0.5 shortly. Then for next versions
I'll focus on optimizations and adding support for hardware acceleration.

Existing implementations are simple and can certainly be optimized, even
without architectural changes. But the architecture itself can also be
improved in a number of ways. Currently it is designed to work well with
VFIO. However, having explicit MAP requests is less efficient* than page
tables for emulated and PV endpoints, and the current architecture doesn't
address this. Binding page tables is an obvious way to improve throughput
in that case, but we can explore cleverer (and possibly simpler) ways to
do it.

So first we'll work on getting the base device and driver merged, then
we'll analyze and compare several ideas for improving performance.

Thanks,
Jean

* I have yet to study this behaviour, and would be interested in any
prior art on the subject of analyzing devices DMA patterns (virtio and
others)

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

