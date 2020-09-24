Return-Path: virtio-dev-return-7800-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1401F985D89
	for <virtio-dev@lists.oasis-open.org>; Thu, 24 Sep 2020 08:31:37 +0000 (UTC)
Date: Thu, 24 Sep 2020 10:31:16 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
Message-ID: <20200924083116.GA170808@myrica>
References: <20200821131540.2801801-1-jean-philippe@linaro.org>
 <20200821131540.2801801-3-jean-philippe@linaro.org>
 <21fce247-4c1c-b7a8-bcac-4d7b649eaeca@redhat.com>
MIME-Version: 1.0
In-Reply-To: <21fce247-4c1c-b7a8-bcac-4d7b649eaeca@redhat.com>
Subject: [virtio-dev] Re: [PATCH v3 2/6] iommu/virtio: Add topology helpers
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Auger Eric <eric.auger@redhat.com>
Cc: iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, linux-pci@vger.kernel.org, joro@8bytes.org, bhelgaas@google.com, mst@redhat.com, jasowang@redhat.com, kevin.tian@intel.com, sebastien.boeuf@intel.com, lorenzo.pieralisi@arm.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Sep 04, 2020 at 06:22:12PM +0200, Auger Eric wrote:
> > +/**
> > + * virt_dma_configure - Configure DMA of virtualized devices
> > + * @dev: the endpoint
> > + *
> > + * Setup the DMA and IOMMU ops of a virtual device, for platforms without DT or
> > + * ACPI.
> > + *
> > + * Return: -EPROBE_DEFER if the device is managed by an IOMMU that hasn't been
> > + *   probed yet, 0 otherwise
> > + */
> > +int virt_dma_configure(struct device *dev)
> > +{
> > +	const struct iommu_ops *iommu_ops;
> > +
> > +	iommu_ops = virt_iommu_setup(dev);
> > +	if (IS_ERR_OR_NULL(iommu_ops)) {
> > +		int ret = PTR_ERR(iommu_ops);
> > +
> > +		if (ret == -EPROBE_DEFER || ret == 0)
> > +			return ret;
> > +		dev_err(dev, "error %d while setting up virt IOMMU\n", ret);
> > +		return 0;
> why do we return 0 here?

So we can fall back to another method (ACPI or DT) if available

> Besides
> 
> Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks!
Jean

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

