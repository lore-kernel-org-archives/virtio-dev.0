Return-Path: virtio-dev-return-4321-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id E48C2581916B
	for <virtio-dev@lists.oasis-open.org>; Fri,  8 Jun 2018 04:15:14 -0700 (PDT)
Date: Fri, 8 Jun 2018 19:14:49 +0800
From: Tiwei Bie <tiwei.bie@intel.com>
Message-ID: <20180608111449.GA22160@tbie-MOBL1.ccr.corp.intel.com>
References: <20180608020701.12297-1-tiwei.bie@intel.com>
 <20180608111231.10c7de51.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180608111231.10c7de51.cohuck@redhat.com>
Subject: [virtio-dev] Re: [PATCH v2] content: document SR-IOV driver requirements
To: Cornelia Huck <cohuck@redhat.com>
Cc: mst@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, virtio-dev@lists.oasis-open.org, dan.daly@intel.com, alexander.h.duyck@intel.com, mark.d.rustad@intel.com, cunming.liang@intel.com, zhihong.wang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Jun 08, 2018 at 11:12:31AM +0200, Cornelia Huck wrote:
> On Fri,  8 Jun 2018 10:07:01 +0800
> Tiwei Bie <tiwei.bie@intel.com> wrote:
> 
> > Document the driver requirements for the VIRTIO_F_SR_IOV
> > feature bit.
> > 
> > Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> > Fixes: https://github.com/oasis-tcs/virtio-spec/issues/13
> > ---
> > v2:
> > - Fix the commit message (MST);
> > - Improve the wording (MST);
> > - Drop unnecessary parts (MST);
> > 
> >  content.tex | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> > 
> > diff --git a/content.tex b/content.tex
> > index be18234..f996fad 100644
> > --- a/content.tex
> > +++ b/content.tex
> > @@ -5387,6 +5387,21 @@ A driver SHOULD accept VIRTIO_F_IO_BARRIER if it is offered.
> >  If VIRTIO_F_IO_BARRIER has been negotiated, a driver MUST use
> >  the barriers suitable for hardware devices.
> >  
> > +If VIRTIO_F_SR_IOV has been negotiated, a driver MAY enable
> > +virtual functions through the device's PCI SR-IOV capability
> > +structure.  A driver MUST NOT negotiate VIRTIO_F_SR_IOV if
> > +the device does not have a PCI SR-IOV capability structure
> > +or is not a PCI device.  A driver MUST negotiate
> 
> Maybe I'm missing something obvious, but why should the device offer
> the feature in the first place if it does not support the functionality?

The device is not allowed to offer the feature if it
doesn't support the functionality.

From my understanding, Michael suggested this to make
sure that in the future, the existing drivers won't
accept this feature bit when the VF or other transport
devices offer this feature bit, because some changes
may be necessary for drivers to really support this
feature offered by those devices.

> 
> > +VIRTIO_F_SR_IOV and complete the feature negotiation
> > +(including checking the FEATURES_OK \field{status} bit)
> > +before enabling virtual functions through the device's
> > +PCI SR-IOV capability structure.  After once successfully
> > +negotiating VIRTIO_F_SR_IOV, the driver MAY enable virtual
> > +functions through the device's PCI SR-IOV capability
> > +structure even if the device or the system has been fully
> > +or partially reset, and even without re-negotiating
> > +VIRTIO_F_SR_IOV after the reset.
> 
> So, what is the general lifetime of this feature supposed to be? As
> written here, the driver needs to negotiate the feature once and then
> may enable virtual functions at any time in all eternity. Is this
> intended to accommodate hardware implementations, where some kind of
> switch is flipped once and then the functionality is available?
> 
> Also, as the device will need to negotiate the feature at least once,
> what is stopping it from negotiating it again in the future? Is this
> wording intended to allow the driver to simply use virtual functions on
> resume etc. prior to feature negotiation?

This isn't intended to accommodate hardware implementations.

Yes, this is intended to allow the driver to simply use virtual
functions on resume etc. prior to feature negotiation.

> 
> It might be helpful to add some explanatory text outside of the
> conformance statement so we don't stumble over this in the future.

Do you have any more specific suggestions about this?
It would be quite helpful! Thanks a lot!

Best regards,
Tiwei Bie

> 
> > +
> >  \devicenormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}
> >  
> >  A device MUST offer VIRTIO_F_VERSION_1.  A device MAY fail to operate further
> 

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

