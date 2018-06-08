Return-Path: virtio-dev-return-4323-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id D111C581916B
	for <virtio-dev@lists.oasis-open.org>; Fri,  8 Jun 2018 05:36:39 -0700 (PDT)
Date: Fri, 8 Jun 2018 14:36:24 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180608143624.6ebe94c0.cohuck@redhat.com>
In-Reply-To: <20180608150501-mutt-send-email-mst@kernel.org>
References: <20180608020701.12297-1-tiwei.bie@intel.com>
	<20180608111231.10c7de51.cohuck@redhat.com>
	<20180608150501-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v2] content: document SR-IOV driver requirements
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Tiwei Bie <tiwei.bie@intel.com>, stefanha@redhat.com, pbonzini@redhat.com, virtio-dev@lists.oasis-open.org, dan.daly@intel.com, alexander.h.duyck@intel.com, mark.d.rustad@intel.com, cunming.liang@intel.com, zhihong.wang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, 8 Jun 2018 15:13:11 +0300
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Fri, Jun 08, 2018 at 11:12:31AM +0200, Cornelia Huck wrote:
> > On Fri,  8 Jun 2018 10:07:01 +0800
> > Tiwei Bie <tiwei.bie@intel.com> wrote:
> >   
> > > Document the driver requirements for the VIRTIO_F_SR_IOV
> > > feature bit.
> > > 
> > > Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> > > Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> > > Fixes: https://github.com/oasis-tcs/virtio-spec/issues/13
> > > ---
> > > v2:
> > > - Fix the commit message (MST);
> > > - Improve the wording (MST);
> > > - Drop unnecessary parts (MST);
> > > 
> > >  content.tex | 15 +++++++++++++++
> > >  1 file changed, 15 insertions(+)
> > > 
> > > diff --git a/content.tex b/content.tex
> > > index be18234..f996fad 100644
> > > --- a/content.tex
> > > +++ b/content.tex
> > > @@ -5387,6 +5387,21 @@ A driver SHOULD accept VIRTIO_F_IO_BARRIER if it is offered.
> > >  If VIRTIO_F_IO_BARRIER has been negotiated, a driver MUST use
> > >  the barriers suitable for hardware devices.
> > >  
> > > +If VIRTIO_F_SR_IOV has been negotiated, a driver MAY enable
> > > +virtual functions through the device's PCI SR-IOV capability
> > > +structure.  A driver MUST NOT negotiate VIRTIO_F_SR_IOV if
> > > +the device does not have a PCI SR-IOV capability structure
> > > +or is not a PCI device.  A driver MUST negotiate  
> > 
> > Maybe I'm missing something obvious, but why should the device offer
> > the feature in the first place if it does not support the functionality?  
> 
> Probably shouldn't, but what if we want to reuse the bit
> number for some non pci functionality on other transports?
> This text will allow it.

I'm not really a fan of reusing bits for different things. If we want
this, we should specify a transport-specific feature bit range. I'd
prefer simply noting that this is PCI-specific (as we do now), though.

> 
> > > +VIRTIO_F_SR_IOV and complete the feature negotiation
> > > +(including checking the FEATURES_OK \field{status} bit)
> > > +before enabling virtual functions through the device's
> > > +PCI SR-IOV capability structure.  After once successfully
> > > +negotiating VIRTIO_F_SR_IOV, the driver MAY enable virtual
> > > +functions through the device's PCI SR-IOV capability
> > > +structure even if the device or the system has been fully
> > > +or partially reset, and even without re-negotiating
> > > +VIRTIO_F_SR_IOV after the reset.  
> > 
> > So, what is the general lifetime of this feature supposed to be? As
> > written here, the driver needs to negotiate the feature once and then
> > may enable virtual functions at any time in all eternity. Is this
> > intended to accommodate hardware implementations, where some kind of
> > switch is flipped once and then the functionality is available?
> > Also, as the device will need to negotiate the feature at least once,
> > what is stopping it from negotiating it again in the future? Is this
> > wording intended to allow the driver to simply use virtual functions on
> > resume etc. prior to feature negotiation?  
> 
> Yes - it's to accomodate how guest OS-es treat SRIOV capability
> on resume, restoring it before they start talking to the driver.
> 
> Maybe we need a non conformance section explaining about SR-IOV.
> Another thing to explain is that all VFs are assumed to be same as the
> PF. Also I do not think we can support legacy or transitional VFs.

Yes, I think so.

> 
> > It might be helpful to add some explanatory text outside of the
> > conformance statement so we don't stumble over this in the future.  
> 
> Exactly. But in fact same applies to other features we just
> do not say this explicitly anywhere. For exactly things won't
> work well if you reset device to recover from error
> and suddenly it doesn't negotiate the feature.

But "please renegotiate the same feature set" is different from "you
can use this even before renegotiating", no?

> 
> 
> So I suspect we want to add somewhere in the general section:
> 
> 
>         If device has successfully negotiated a set of features at least once
>         (by setting the FEATURES_OK \field{status} bit) then it SHOULD NOT
>         fail re-negotiation of the same set of features after a device
>         or system reset. Failure to do so would interfere with resume
>         from suspend and error recovery.
> 
> would this address your comment?

This is a good idea, and I already reviewed Tiwei's other patch :)

We still need to note that reset doesn't clear this feature explicitly,
though, as this is only SHOULD NOT.

> 
> > > +
> > >  \devicenormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}
> > >  
> > >  A device MUST offer VIRTIO_F_VERSION_1.  A device MAY fail to operate further  


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

