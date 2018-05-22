Return-Path: virtio-dev-return-4109-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id A1A075819121
	for <virtio-dev@lists.oasis-open.org>; Mon, 21 May 2018 19:40:47 -0700 (PDT)
Date: Tue, 22 May 2018 10:40:57 +0800
From: Tiwei Bie <tiwei.bie@intel.com>
Message-ID: <20180522024057.GA21227@debian>
References: <20180521105206.5075-1-tiwei.bie@intel.com>
 <20180522012346-mutt-send-email-mst@kernel.org>
 <20180522012822.GA12737@debian>
 <20180522044253-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180522044253-mutt-send-email-mst@kernel.org>
Subject: Re: [virtio-dev] Re: [PATCH v1] content: support SR-IOV
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: cohuck@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, virtio-dev@lists.oasis-open.org, dan.daly@intel.com, alexander.h.duyck@intel.com, mark.d.rustad@intel.com, cunming.liang@intel.com, zhihong.wang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, May 22, 2018 at 04:55:05AM +0300, Michael S. Tsirkin wrote:
> On Tue, May 22, 2018 at 09:28:22AM +0800, Tiwei Bie wrote:
> > On Tue, May 22, 2018 at 01:32:29AM +0300, Michael S. Tsirkin wrote:
> > > On Mon, May 21, 2018 at 06:52:06PM +0800, Tiwei Bie wrote:
[...]
> > > >  If VIRTIO_F_IN_ORDER has been negotiated, a device MUST use
> > > >  buffers in the same order in which they have been available.
> > > >  
> > > > +A device SHOULD offer VIRTIO_F_SR_IOV if it presents a PCI
> > > > +SR-IOV capability structure.  A device MAY fail to operate
> > > > +further if VIRTIO_F_SR_IOV is not accepted.
> > > 
> > > Why is the last sentence here? What are you trying to accomplish?  It
> > > seems that if we allow drivers not to accept the bit, we should require
> > > the devices to function without it or at least not go out of our way to
> > > say they do not have to.
> > 
> > The last sentence "A device MAY fail to operate further
> > if VIRTIO_F_SR_IOV is not accepted" means if the driver
> > doesn't accept this feature, the device may fail to work,
> > e.g. setting VIRTIO_CONFIG_S_FEATURES_OK may fail. And
> > in this case (i.e. the device fails to work), it will be
> > necessary for driver to accept this feature in order to
> > work with this device.
> > 
> > So it's not to allow drivers not to accept the feature,
> > instead, it just tells device's behaviour (i.e. device
> > may fail to work) if this feature isn't accepted. And
> > it leaves the choice to device's implementation.
> 
> The choice is always there. However the preferred response
> to features is for drivers only use what they actually
> need, and devices to try to accomodate subsets of features.
> 
> Is there a reason for this feature to be different?
> 
> 
> > It's similar to the description for the IOMMU_PLATFORM
> > feature:
> > 
> > """
> > A device SHOULD offer VIRTIO_F_IOMMU_PLATFORM if it is behind an IOMMU that
> > translates bus addresses from the device into physical addresses in memory.
> > A device MAY fail to operate further if VIRTIO_F_IOMMU_PLATFORM is not
> > accepted.
> > """
> 
> Well IOMMU platform is very special in that it's a security feature.
> We really can't support legacy drivers with these devices.
> Most features aren't like this.
> 
> Something like this would be appropriate for the barrier
> feature.
> 
> But this specific feature I don't see why can't driver just use
> the PF.

Okay. I'll remove the last sentence.

Best regards,
Tiwei Bie

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

