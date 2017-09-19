Return-Path: virtio-dev-return-2553-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 8B74658191E6
	for <virtio-dev@lists.oasis-open.org>; Tue, 19 Sep 2017 03:43:49 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
References: <20170804181927.12148-1-jean-philippe.brucker@arm.com>
 <072f5a14-baae-57a9-9c5b-b93163c67075@redhat.com>
Message-ID: <4543e6dc-0f36-11ad-784a-d7c07399d10f@arm.com>
Date: Tue, 19 Sep 2017 11:47:43 +0100
MIME-Version: 1.0
In-Reply-To: <072f5a14-baae-57a9-9c5b-b93163c67075@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [RFC] virtio-iommu version 0.4
To: Auger Eric <eric.auger@redhat.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: Will Deacon <Will.Deacon@arm.com>, Robin Murphy <Robin.Murphy@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, Marc Zyngier <Marc.Zyngier@arm.com>, "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>, "bharat.bhushan@nxp.com" <bharat.bhushan@nxp.com>, "peterx@redhat.com" <peterx@redhat.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Eric,

On 12/09/17 18:13, Auger Eric wrote:
> 2.6.7
> - As I am currently integrating v0.4 in QEMU here are some other comments:
> At the moment struct virtio_iommu_req_probe flags is missing in your
> header. As such I understood the ACK protocol was not implemented by the
> driver in your branch.

Uh indeed. And yet I could swear I've written that code... somewhere. I
will add it to the batch of v0.5 changes, it shouldn't be too invasive.

> - VIRTIO_IOMMU_PROBE_PROPERTY_TYPE_MASK is VIRTIO_IOMMU_T_MASK in your
> header too.

Yes, keeping VIRTIO_IOMMU_PROBE_PROPERTY_TYPE_MASK is probably best
(though it is a mouthful).

> 2.6.8.2:
> - I am really confused about what the device should report as resv
> regions depending on the PE nature (VFIO or not VFIO)
>
> In other iommu drivers, the resv regions are populated by the iommu
> driver through its get_resv_regions callback. They are usually composed
> of an iommu specific MSI region (mapped or bypassed) and non IOMMU
> specific (device specific) reserved regions:
> iommu_dma_get_resv_regions(). In the case of virtio-iommu driver, those
> are the guest reserved regions.
>
> First in the current virtio-iommu driver I don't see the
> iommu_dma_get_resv_regions call. Do you agree that the virtio-iommu
> driver should compute the non IOMMU specific MSI regions. ie. this is
> not the responsability of the virtio-iommu device.

For SW_MSI, certainly. The driver allocates a fixed IOVA region for
mapping the MSI doorbell. But the driver has to know whether the doorbell
region is translated or bypassed.

> Then why is it more the job of the device to return the guest iommu
> specific region rather than the driver itself?

The MSI region is architectural on x86 IOMMUs, but
implementation-defined on virtio-iommu. It depends which platform the host
is emulating. In Linux, x86 IOMMU drivers register the bypass region
because there always is an IOAPIC on the other end, with a fixed MSI
address. But virtio-iommu may be either behind a GIC, an APIC or some
other IRQ chip.

The driver *could* go over all the irqchips/platforms it knows and try to
guess if there is a fixed doorbell or if it needs to reserve an IOVA for
them, but it would look horrible. I much prefer having a well-defined way
of doing this, so a description from the device.

> Then I understand this is the responsability of the virtio-iommu device
> to gather information about the host resv regions in case of VFIO EP.
> Typically the host PCIe host bridge windows cannot be used for IOVA.
> Also the host MSI reserved IOVA window cannot be used. Do you agree.

Yes, all regions reported in sysfs reserved_regions in the host would be
reported as RESV_T_RESERVED by virtio-iommu.

> I really think the spec should clarify what exact resv regions the
> device should return in case of VFIO device and non VFIO device.

Agreed. I will add something about RESV_T_RESERVED with the PCI bridge
example in Implementation Notes. Do you think the MSI examples at the end
need improvement as well? I can try to explain that RESV_MSI regions in
virtio-iommu are only those of the emulated platform, not the HW or SW MSI
regions from the host.

Thanks,
Jean

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

