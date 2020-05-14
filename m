Return-Path: virtio-dev-return-7339-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 91C2E985F2D
	for <virtio-dev@lists.oasis-open.org>; Thu, 14 May 2020 10:56:10 +0000 (UTC)
Date: Thu, 14 May 2020 06:56:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20200514065206-mutt-send-email-mst@kernel.org>
References: <20200514075237.3941-1-bbhushan2@marvell.com>
 <20200514043747-mutt-send-email-mst@kernel.org>
 <20200514105016.GA2252@myrica>
MIME-Version: 1.0
In-Reply-To: <20200514105016.GA2252@myrica>
Subject: [virtio-dev] Re: [PATCH v6] iommu/virtio: Use page size bitmap supported by
 endpoint
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: Bharat Bhushan <bbhushan2@marvell.com>, virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, virtio-dev@lists.oasis-open.org, joro@8bytes.org, jasowang@redhat.com, eric.auger.pro@gmail.com, eric.auger@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, May 14, 2020 at 12:50:16PM +0200, Jean-Philippe Brucker wrote:
> On Thu, May 14, 2020 at 05:31:00AM -0400, Michael S. Tsirkin wrote:
> > On Thu, May 14, 2020 at 01:22:37PM +0530, Bharat Bhushan wrote:
> > > Different endpoint can support different page size, probe
> > > endpoint if it supports specific page size otherwise use
> > > global page sizes.
> > > 
> > > Device attached to domain should support a minimum of
> > > domain supported page sizes. If device supports more
> > > than domain supported page sizes then device is limited
> > > to use domain supported page sizes only.
> > 
> > OK so I am just trying to figure it out.
> > Before the patch, we always use the domain supported page sizes
> > right?
> > 
> > With the patch, we still do, but we also probe and
> > validate that device supports all domain page sizes,
> > if it does not then we fail to attach the device.
> 
> Generally there is one endpoint per domain. Linux creates the domains and
> decides which endpoint goes in which domain. It puts multiple endpoints in
> a domain in two cases:
> 
> * If endpoints cannot be isolated from each others by the IOMMU, for
>   example if ACS isolation isn't enabled in PCIe. In that case endpoints
>   are in the same IOMMU group, and therefore contained in the same domain.
>   This is more of a quirk for broken hardware, and isn't much of a concern
>   for virtualization because it's easy for the hypervisor to present
>   endpoints isolated from each others.

Unless they aren't isolated on real hardware :)

> * If userspace wants to put endpoints in the same VFIO container, then
>   VFIO first attempts to put them in the same IOMMU domain, and falls back
>   to multiple domains if that fails. That case is just a luxury and we
>   shouldn't over-complicate the driver to cater for this.
> 
> So the attach checks don't need to be that complicated. Checking that the
> page masks are exactly the same should be enough.
> 
> > This seems like a lot of effort for little benefit, can't
> > hypervisor simply make sure endpoints support the
> > iommu page sizes for us?
> 
> I tend to agree, it's not very likely that we'll have a configuration with
> different page sizes between physical and virtual endpoints.
> 
> If there is a way for QEMU to simply reject VFIO devices that don't use
> the same page mask as what's configured globally, let's do that instead of
> introducing the page_size_mask property.

Or we can even do the subset thing in QEMU. Can be transparent to
guests.


So I guess this patch isn't really needed then.

> 
> > > @@ -615,7 +636,7 @@ static int viommu_domain_finalise(struct viommu_endpoint *vdev,
> > >  	struct viommu_dev *viommu = vdev->viommu;
> > >  	struct viommu_domain *vdomain = to_viommu_domain(domain);
> > >  
> > > -	viommu_page_size = 1UL << __ffs(viommu->pgsize_bitmap);
> > > +	viommu_page_size = 1UL << __ffs(vdev->pgsize_bitmap);
> > >  	if (viommu_page_size > PAGE_SIZE) {
> > >  		dev_err(vdev->dev,
> > >  			"granule 0x%lx larger than system page size 0x%lx\n",
> > 
> > 
> > Looks like this is messed up on 32 bit: e.g. 0x100000000 will try to do
> > 1UL << -1, which is undefined behaviour. Which is btw already messed up
> > wrt viommu->pgsize_bitmap, but that's not a reason to propagate
> > the error.
> 
> Realistically we're not going to have a page granule larger than 4G, it's
> going to be 4k or 64k. But we can add a check that truncates the
> page_size_mask to 32-bit and makes sure that it's non-null.

... on 32 bit

> 
> > > +struct virtio_iommu_probe_pgsize_mask {
> > > +	struct virtio_iommu_probe_property	head;
> > > +	__u8					reserved[4];
> > > +	/* Same format as virtio_iommu_config::page_size_mask */
> > 
> > It's actually slightly different in that
> > this must be a superset of domain page size mask, right?
> 
> No it overrides the global mask

OK so I'd copy the comment and tweak it rather than
refer to virtio_iommu_config::page_size_mask
(besides, virtio_iommu_config::page_size_mask isn't legal C,
I know C++ so I figured out what's meant but it's
better to just say "page_size_mask in sturct virtio_iommu_config" )


> 
> > > +	__le64					pgsize_bitmap;
> 
> Bharat, please rename this to page_size_mask for consistency
> 
> Thanks,
> Jean
> 
> > > +};
> > > +
> > >  #define VIRTIO_IOMMU_RESV_MEM_T_RESERVED	0
> > >  #define VIRTIO_IOMMU_RESV_MEM_T_MSI		1
> > >  
> > > -- 
> > > 2.17.1
> > 


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

