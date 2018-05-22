Return-Path: virtio-dev-return-4102-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id ED8905819121
	for <virtio-dev@lists.oasis-open.org>; Mon, 21 May 2018 18:55:16 -0700 (PDT)
Date: Tue, 22 May 2018 04:55:05 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180522044253-mutt-send-email-mst@kernel.org>
References: <20180521105206.5075-1-tiwei.bie@intel.com>
 <20180522012346-mutt-send-email-mst@kernel.org>
 <20180522012822.GA12737@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180522012822.GA12737@debian>
Subject: Re: [virtio-dev] Re: [PATCH v1] content: support SR-IOV
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: cohuck@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, virtio-dev@lists.oasis-open.org, dan.daly@intel.com, alexander.h.duyck@intel.com, mark.d.rustad@intel.com, cunming.liang@intel.com, zhihong.wang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, May 22, 2018 at 09:28:22AM +0800, Tiwei Bie wrote:
> On Tue, May 22, 2018 at 01:32:29AM +0300, Michael S. Tsirkin wrote:
> > On Mon, May 21, 2018 at 06:52:06PM +0800, Tiwei Bie wrote:
> > > Reserve a feature bit for virtio devices which support SR-IOV.
> > 
> > s/Reserve/Allocate/ in that you define the behaviour here.
> 
> Got it. Thanks!
> 
> > 
> > > Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> > > Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> > 
> > Pls go ahead and add a github issue, you can then
> > include a Fixes: tag with a link to it,
> > which comes it handy down the road for voting.
> 
> Got it. I will send a new version to address this.
> 
> > 
> > > ---
> > > More details can be found from this thread:
> > > 
> > > https://patchwork.kernel.org/patch/10285541/
> > > 
> > > RFC -> v1:
> > > - Mention PCI in the description (Cornelia);
> > > 
> > >  content.tex | 15 +++++++++++++--
> > >  1 file changed, 13 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/content.tex b/content.tex
> > > index 7a92cb1..9f981fb 100644
> > > --- a/content.tex
> > > +++ b/content.tex
> > > @@ -95,10 +95,10 @@ Feature bits are allocated as follows:
> > >  \begin{description}
> > >  \item[0 to 23] Feature bits for the specific device type
> > >  
> > > -\item[24 to 33] Feature bits reserved for extensions to the queue and
> > > +\item[24 to 36] Feature bits reserved for extensions to the queue and
> > >    feature negotiation mechanisms
> > >  
> > > -\item[34 and above] Feature bits reserved for future extensions.
> > > +\item[37 and above] Feature bits reserved for future extensions.
> > >  \end{description}
> > >  
> > >  \begin{note}
> > > @@ -5348,6 +5348,9 @@ Descriptors} and \ref{sec:Packed Virtqueues / Indirect Flag: Scatter-Gather Supp
> > >    \item[VIRTIO_F_IN_ORDER(35)] This feature indicates
> > >    that all buffers are used by the device in the same
> > >    order in which they have been made available.
> > > +  \item[VIRTIO_F_SR_IOV(36)] This feature indicates that
> > > +  the device supports Single Root I/O Virtualization.
> > > +  Currently only virtio PCI devices support this feature.
> > >  \end{description}
> > >  
> > >  \drivernormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}
> > > @@ -5363,6 +5366,10 @@ addresses to the device.
> > >  
> > >  A driver SHOULD accept VIRTIO_F_RING_PACKED if it is offered.
> > >  
> > > +A driver SHOULD accept VIRTIO_F_SR_IOV if it is offered.
> > > +If VIRTIO_F_SR_IOV has been negotiated, a driver can
> > > +access device's PCI SR-IOV capability structure.
> > 
> > Does "access" here really mean "enable virtual functions"
> > through the PCI SR-IOV capability?
> 
> Hmm.. I'll make it more explicit in the next version,
> something like:
> 
> If VIRTIO_F_SR_IOV has been negotiated, a driver can
> enable virtual functions through device's PCI SR-IOV
> capability structure.
> 
> > 
> > > +
> > >  \devicenormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}
> > >  
> > >  A device MUST offer VIRTIO_F_VERSION_1.  A device MAY fail to operate further
> > > @@ -5376,6 +5383,10 @@ accepted.
> > >  If VIRTIO_F_IN_ORDER has been negotiated, a device MUST use
> > >  buffers in the same order in which they have been available.
> > >  
> > > +A device SHOULD offer VIRTIO_F_SR_IOV if it presents a PCI
> > > +SR-IOV capability structure.  A device MAY fail to operate
> > > +further if VIRTIO_F_SR_IOV is not accepted.
> > 
> > Why is the last sentence here? What are you trying to accomplish?  It
> > seems that if we allow drivers not to accept the bit, we should require
> > the devices to function without it or at least not go out of our way to
> > say they do not have to.
> 
> The last sentence "A device MAY fail to operate further
> if VIRTIO_F_SR_IOV is not accepted" means if the driver
> doesn't accept this feature, the device may fail to work,
> e.g. setting VIRTIO_CONFIG_S_FEATURES_OK may fail. And
> in this case (i.e. the device fails to work), it will be
> necessary for driver to accept this feature in order to
> work with this device.
> 
> So it's not to allow drivers not to accept the feature,
> instead, it just tells device's behaviour (i.e. device
> may fail to work) if this feature isn't accepted. And
> it leaves the choice to device's implementation.

The choice is always there. However the preferred response
to features is for drivers only use what they actually
need, and devices to try to accomodate subsets of features.

Is there a reason for this feature to be different?


> It's similar to the description for the IOMMU_PLATFORM
> feature:
> 
> """
> A device SHOULD offer VIRTIO_F_IOMMU_PLATFORM if it is behind an IOMMU that
> translates bus addresses from the device into physical addresses in memory.
> A device MAY fail to operate further if VIRTIO_F_IOMMU_PLATFORM is not
> accepted.
> """
> 
> Thanks for the review!
> 
> Best regards,
> Tiwei Bie

Well IOMMU platform is very special in that it's a security feature.
We really can't support legacy drivers with these devices.
Most features aren't like this.

Something like this would be appropriate for the barrier
feature.

But this specific feature I don't see why can't driver just use
the PF.



> > 
> > 
> > > +
> > >  \section{Legacy Interface: Reserved Feature Bits}\label{sec:Reserved Feature Bits / Legacy Interface: Reserved Feature Bits}
> > >  
> > >  Transitional devices MAY offer the following:
> > > -- 
> > > 2.17.0
> > 
> > ---------------------------------------------------------------------
> > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> > 

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

