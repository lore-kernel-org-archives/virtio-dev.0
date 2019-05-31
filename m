Return-Path: virtio-dev-return-5766-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A0206985EF3
	for <virtio-dev@lists.oasis-open.org>; Fri, 31 May 2019 11:14:14 +0000 (UTC)
References: <20190530170929.19366-1-jean-philippe.brucker@arm.com>
 <20190530170929.19366-3-jean-philippe.brucker@arm.com>
 <20190530133523-mutt-send-email-mst@kernel.org>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <c3cd5dba-123d-e808-98b1-731ac2d4b950@arm.com>
Date: Fri, 31 May 2019 12:13:47 +0100
MIME-Version: 1.0
In-Reply-To: <20190530133523-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio-dev] Re: [PATCH v8 2/7] dt-bindings: virtio: Add
 virtio-pci-iommu node
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "joro@8bytes.org" <joro@8bytes.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com" <jasowang@redhat.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, Mark Rutland <Mark.Rutland@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Robin Murphy <Robin.Murphy@arm.com>, "bhelgaas@google.com" <bhelgaas@google.com>, "frowand.list@gmail.com" <frowand.list@gmail.com>, "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>, "eric.auger@redhat.com" <eric.auger@redhat.com>, "tnowicki@caviumnetworks.com" <tnowicki@caviumnetworks.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>, "bauerman@linux.ibm.com" <bauerman@linux.ibm.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On 30/05/2019 18:45, Michael S. Tsirkin wrote:
> On Thu, May 30, 2019 at 06:09:24PM +0100, Jean-Philippe Brucker wrote:
>> Some systems implement virtio-iommu as a PCI endpoint. The operating
>> system needs to discover the relationship between IOMMU and masters long
>> before the PCI endpoint gets probed. Add a PCI child node to describe the
>> virtio-iommu device.
>>
>> The virtio-pci-iommu is conceptually split between a PCI programming
>> interface and a translation component on the parent bus. The latter
>> doesn't have a node in the device tree. The virtio-pci-iommu node
>> describes both, by linking the PCI endpoint to "iommus" property of DMA
>> master nodes and to "iommu-map" properties of bus nodes.
>>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> Reviewed-by: Eric Auger <eric.auger@redhat.com>
>> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> 
> So this is just an example right?
> We are not defining any new properties or anything like that.

Yes it's just an example. The properties already exist but it's good to
describe how to put them together for this particular case, because
there isn't a precedent describing the topology for an IOMMU that
appears on the PCI bus.

> I think down the road for non dt platforms we want to put this
> info in the config space of the device. I do not think ACPI
> is the best option for this since not all systems have it.
> But that can wait.

There is the probe order problem - PCI needs this info before starting
to probe devices on the bus. Maybe we could store the info in a separate
memory region, that is referenced on the command-line and that the guest
can read early.

Thanks,
Jean

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

