Return-Path: virtio-dev-return-7808-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8B7F9985DC3
	for <virtio-dev@lists.oasis-open.org>; Fri, 25 Sep 2020 08:13:04 +0000 (UTC)
Date: Fri, 25 Sep 2020 10:12:43 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
Message-ID: <20200925081243.GA490533@myrica>
References: <20200821131540.2801801-6-jean-philippe@linaro.org>
 <20200924152203.GA2320481@bjorn-Precision-5520>
MIME-Version: 1.0
In-Reply-To: <20200924152203.GA2320481@bjorn-Precision-5520>
Subject: [virtio-dev] Re: [PATCH v3 5/6] iommu/virtio: Support topology description in
 config space
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, linux-pci@vger.kernel.org, joro@8bytes.org, bhelgaas@google.com, mst@redhat.com, jasowang@redhat.com, kevin.tian@intel.com, sebastien.boeuf@intel.com, eric.auger@redhat.com, lorenzo.pieralisi@arm.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Sep 24, 2020 at 10:22:03AM -0500, Bjorn Helgaas wrote:
> On Fri, Aug 21, 2020 at 03:15:39PM +0200, Jean-Philippe Brucker wrote:
> > Platforms without device-tree nor ACPI can provide a topology
> > description embedded into the virtio config space. Parse it.
> > 
> > Use PCI FIXUP to probe the config space early, because we need to
> > discover the topology before any DMA configuration takes place, and the
> > virtio driver may be loaded much later. Since we discover the topology
> > description when probing the PCI hierarchy, the virtual IOMMU cannot
> > manage other platform devices discovered earlier.
> 
> > +struct viommu_cap_config {
> > +	u8 bar;
> > +	u32 length; /* structure size */
> > +	u32 offset; /* structure offset within the bar */
> 
> s/the bar/the BAR/ (to match comment below).
> 
> > +static void viommu_pci_parse_topology(struct pci_dev *dev)
> > +{
> > +	int ret;
> > +	u32 features;
> > +	void __iomem *regs, *common_regs;
> > +	struct viommu_cap_config cap = {0};
> > +	struct virtio_pci_common_cfg __iomem *common_cfg;
> > +
> > +	/*
> > +	 * The virtio infrastructure might not be loaded at this point. We need
> > +	 * to access the BARs ourselves.
> > +	 */
> > +	ret = viommu_pci_find_capability(dev, VIRTIO_PCI_CAP_COMMON_CFG, &cap);
> > +	if (!ret) {
> > +		pci_warn(dev, "common capability not found\n");
> 
> Is the lack of this capability really an error, i.e., is this
> pci_warn() or pci_info()?  The "device doesn't have topology
> description" below is only pci_dbg(), which suggests that we can live
> without this.

At this point we know that this is a (modern) virtio-pci device which,
according to the virtio 1.0 specification, must have this capability. So
this is definitely an error, but the topology description is an optional
feature.

> 
> Maybe a hint about what "common capability" means?

Yes, "virtio-pci common configuration capability" would be more
appropriate

> 
> > +		return;
> > +	}
> > +
> > +	if (pci_enable_device_mem(dev))
> > +		return;
> > +
> > +	common_regs = pci_iomap(dev, cap.bar, 0);
> > +	if (!common_regs)
> > +		return;
> > +
> > +	common_cfg = common_regs + cap.offset;
> > +
> > +	/* Perform the init sequence before we can read the config */
> > +	ret = viommu_pci_reset(common_cfg);
> 
> I guess this is some special device-specific reset, not any kind of
> standard PCI reset?

Yes it's the virtio reset - writing 0 to the status register in the BAR.

Thanks,
Jean

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

