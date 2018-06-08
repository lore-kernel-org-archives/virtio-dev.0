Return-Path: virtio-dev-return-4302-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 6D64A5818D84
	for <virtio-dev@lists.oasis-open.org>; Thu,  7 Jun 2018 18:33:12 -0700 (PDT)
Date: Fri, 8 Jun 2018 09:33:12 +0800
From: Tiwei Bie <tiwei.bie@intel.com>
Message-ID: <20180608013312.GA6801@debian>
References: <20180607015050.27547-1-tiwei.bie@intel.com>
 <20180607220032-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180607220032-mutt-send-email-mst@kernel.org>
Subject: Re: [virtio-dev] [PATCH] content: document the behaviours for SR-IOV
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: cohuck@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, virtio-dev@lists.oasis-open.org, dan.daly@intel.com, alexander.h.duyck@intel.com, mark.d.rustad@intel.com, cunming.liang@intel.com, zhihong.wang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Jun 07, 2018 at 10:17:09PM +0300, Michael S. Tsirkin wrote:
> Subject should be "document SR-IOV driver requirements" I think.

Yeah!

> 
> On Thu, Jun 07, 2018 at 09:50:50AM +0800, Tiwei Bie wrote:
> > Document the device and driver behaviours for SR-IOV.
> > 
> > Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> > Fixes: https://github.com/oasis-tcs/virtio-spec/issues/13
> > ---
> >  content.tex | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> > 
> > diff --git a/content.tex b/content.tex
> > index 73981b7..3b45a6c 100644
> > --- a/content.tex
> > +++ b/content.tex
> > @@ -5387,6 +5387,18 @@ A driver SHOULD accept VIRTIO_F_IO_BARRIER if it is offered.
> >  If VIRTIO_F_IO_BARRIER has been negotiated, a driver MUST use
> >  the barriers suitable for hardware devices.
> >  
> > +If VIRTIO_F_SR_IOV has been negotiated, a driver can enable
> 
> can -> MAY
> 
> > +virtual functions through the device's PCI SR-IOV capability
> > +structure.  A driver MUST NOT negotiate VIRTIO_F_SR_IOV if
> > +the device does not have a PCI SR-IOV capability structure
> > +or is not a PCI device.  A driver MUST negotiate
> > +VIRTIO_F_SR_IOV and complete the feature negotiation
> > +(including checking the FEATURES_OK \field{status} bit)
> 
> OK.
> 
> > before
> > +the first time to enable virtual functions
> 
> before enabling virtual functions
> 
> > through the device's
> > +PCI SR-IOV capability structure,
> 
> I'd end the sentence here and start a new one.
> 
> > and the driver MAY remember
> > +the VIRTIO_F_SR_IOV feature bit negotiation result until it
> > +unbinds from the device.
> > +
> 
> I'm not sure what does this mean. We generally take it to mean
> the DRIVER status bit and that gets cleared by device reset.
> 
> How about:
> 
> 	After once successfully negotiating VIRTIO_F_SR_IOV, the driver MAY
> 	enable virtual functions through the device's PCI SR-IOV capability
> 	structure even if the device or the system has been fully
> 	or partially reset, and even without re-negotiating VIRTIO_F_SR_IOV
> 	after the reset.

Thanks for all your review and suggestion!
I'll send a new version to address them.

> 
> 
> >  \devicenormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}
> >  
> >  A device MUST offer VIRTIO_F_VERSION_1.  A device MAY fail to operate further
> > @@ -5403,6 +5415,10 @@ buffers in the same order in which they have been available.
> >  A device MAY fail to operate further if VIRTIO_F_IO_BARRIER
> >  is not accepted.
> >  
> > +A device SHOULD offer VIRTIO_F_SR_IOV if it is a PCI device
> > +and presents a PCI SR-IOV capability structure, otherwise
> > +it MUST NOT offer VIRTIO_F_SR_IOV.
> > +
> >  \section{Legacy Interface: Reserved Feature Bits}\label{sec:Reserved Feature Bits / Legacy Interface: Reserved Feature Bits}
> >  
> >  Transitional devices MAY offer the following:
> 
> This part has been committed aleady.
> 
> I suspect we want to add somewhere in the general section:
> 
> 
> 	If device has successfully negotiated a set of features at least once
> 	(by setting the FEATURES_OK \field{status} bit) then it SHOULD NOT
> 	fail re-negotiation of the same set of features after a device
> 	or system reset. Failure to do so would interfere with resume
> 	from suspend and error recovery.
> 
> That's a general statement though, I think it's worth a
> separate issue in github.

Yeah. It makes sense. I'd like to do that.
Thanks for the suggestion!

Best regards,
Tiwei Bie

> 
> > -- 
> > 2.17.0
> > 
> > 
> > ---------------------------------------------------------------------
> > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> 
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> 

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

