Return-Path: virtio-dev-return-5774-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id ADBC19841E3
	for <virtio-dev@lists.oasis-open.org>; Sun, 16 Jun 2019 20:04:55 +0000 (UTC)
Date: Sun, 16 Jun 2019 16:04:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190616154841-mutt-send-email-mst@kernel.org>
References: <20190530170929.19366-1-jean-philippe.brucker@arm.com>
 <20190530170929.19366-3-jean-philippe.brucker@arm.com>
 <20190530133523-mutt-send-email-mst@kernel.org>
 <c3cd5dba-123d-e808-98b1-731ac2d4b950@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3cd5dba-123d-e808-98b1-731ac2d4b950@arm.com>
Subject: Re: [virtio-dev] Re: [PATCH v8 2/7] dt-bindings: virtio: Add
 virtio-pci-iommu node
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc: "joro@8bytes.org" <joro@8bytes.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com" <jasowang@redhat.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, Mark Rutland <Mark.Rutland@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Robin Murphy <Robin.Murphy@arm.com>, "bhelgaas@google.com" <bhelgaas@google.com>, "frowand.list@gmail.com" <frowand.list@gmail.com>, "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>, "eric.auger@redhat.com" <eric.auger@redhat.com>, "tnowicki@caviumnetworks.com" <tnowicki@caviumnetworks.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>, "bauerman@linux.ibm.com" <bauerman@linux.ibm.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, May 31, 2019 at 12:13:47PM +0100, Jean-Philippe Brucker wrote:
> On 30/05/2019 18:45, Michael S. Tsirkin wrote:
> > On Thu, May 30, 2019 at 06:09:24PM +0100, Jean-Philippe Brucker wrote:
> >> Some systems implement virtio-iommu as a PCI endpoint. The operating
> >> system needs to discover the relationship between IOMMU and masters long
> >> before the PCI endpoint gets probed. Add a PCI child node to describe the
> >> virtio-iommu device.
> >>
> >> The virtio-pci-iommu is conceptually split between a PCI programming
> >> interface and a translation component on the parent bus. The latter
> >> doesn't have a node in the device tree. The virtio-pci-iommu node
> >> describes both, by linking the PCI endpoint to "iommus" property of DMA
> >> master nodes and to "iommu-map" properties of bus nodes.
> >>
> >> Reviewed-by: Rob Herring <robh@kernel.org>
> >> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> >> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> > 
> > So this is just an example right?
> > We are not defining any new properties or anything like that.
> 
> Yes it's just an example. The properties already exist but it's good to
> describe how to put them together for this particular case, because
> there isn't a precedent describing the topology for an IOMMU that
> appears on the PCI bus.
> 
> > I think down the road for non dt platforms we want to put this
> > info in the config space of the device. I do not think ACPI
> > is the best option for this since not all systems have it.
> > But that can wait.
> 
> There is the probe order problem - PCI needs this info before starting
> to probe devices on the bus.


This isn't all that special - it's pretty common for
IOMMUs to be pci devices. The solution is to have the device on
bus 0. For example, add it with

DECLARE_PCI_FIXUP_EARLY
or
DECLARE_PCI_FIXUP_CLASS_EARLY

in e.g.
arch/x86/kernel/quirks.c
or
drivers/pci/quirks.c

You can also use the configuration access capability
if there's need to access the device before its memory is
enabled.

> Maybe we could store the info in a separate
> memory region, that is referenced on the command-line and that the guest
> can read early.
> 
> Thanks,
> Jean

The point is to avoid command line hacks. Devices should be
self describing.

-- 
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

