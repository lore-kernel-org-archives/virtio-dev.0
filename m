Return-Path: virtio-dev-return-4637-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 15808985B5E
	for <virtio-dev@lists.oasis-open.org>; Wed,  4 Jul 2018 11:25:48 +0000 (UTC)
References: <20180621190655.56391-1-jean-philippe.brucker@arm.com>
 <20180626210132-mutt-send-email-mst@kernel.org>
 <2bcda195-d2c6-fbf0-322e-d91756fc3547@arm.com>
 <20180627224801-mutt-send-email-mst@kernel.org>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <98512e15-fd51-e4b2-1d9d-2c9cf9c863b8@arm.com>
Date: Wed, 4 Jul 2018 12:25:26 +0100
MIME-Version: 1.0
In-Reply-To: <20180627224801-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v2 0/5] Add virtio-iommu driver
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>, "joro@8bytes.org" <joro@8bytes.org>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, Mark Rutland <Mark.Rutland@arm.com>, "jasowang@redhat.com" <jasowang@redhat.com>, Marc Zyngier <Marc.Zyngier@arm.com>, Robin Murphy <Robin.Murphy@arm.com>, Will Deacon <Will.Deacon@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>, "bharat.bhushan@nxp.com" <bharat.bhushan@nxp.com>, "tnowicki@caviumnetworks.com" <tnowicki@caviumnetworks.com>, "jayachandran.nair@cavium.com" <jayachandran.nair@cavium.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>, peter.maydell@linaro.org
List-ID: <virtio-dev.lists.oasis-open.org>

On 27/06/18 20:59, Michael S. Tsirkin wrote:
>> Another reason to keep the MMIO transport option is that one
>> virtio-iommu can manage DMA from endpoints on multiple PCI domains at
>> the same time, as well as platform devices. Some VMMs might want that,
>> in which case the IOMMU would be a separate platform device.
> 
> Which buses are managed by the IOMMU is separate from the bus
> on which it's programming interface resides.

Sorry I didn't get this. We probably don't want to instantiate a PCI
root complex just for the IOMMU, so it needs to be in the same PCI
segment as managed endpoints. For example in my VM the AMD IOMMU is
presented as 00:02.0, between other devices on PCI bus 00.

In any case, I have a solution for virtio-pci that works with DT and
ACPI, and isn't excessively awful. I'll probably send it as part of the
next version.

Thanks,
Jean


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

