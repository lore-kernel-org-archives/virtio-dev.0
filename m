Return-Path: virtio-dev-return-4158-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id D932E1CB80F1
	for <virtio-dev@lists.oasis-open.org>; Thu, 24 May 2018 06:44:21 -0700 (PDT)
Date: Thu, 24 May 2018 16:44:18 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180524163054-mutt-send-email-mst@kernel.org>
References: <20180522102615.21339-1-tiwei.bie@intel.com>
 <20180523204446-mutt-send-email-mst@kernel.org>
 <20180523223204-mutt-send-email-mst@kernel.org>
 <20180524000641.GA23755@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180524000641.GA23755@debian>
Subject: Re: [virtio-dev] [PATCH v3] content: support SR-IOV
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: cohuck@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, virtio-dev@lists.oasis-open.org, dan.daly@intel.com, alexander.h.duyck@intel.com, mark.d.rustad@intel.com, cunming.liang@intel.com, zhihong.wang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, May 24, 2018 at 08:06:41AM +0800, Tiwei Bie wrote:
> On Wed, May 23, 2018 at 10:34:29PM +0300, Michael S. Tsirkin wrote:
> > On Wed, May 23, 2018 at 08:54:47PM +0300, Michael S. Tsirkin wrote:
> > > On Tue, May 22, 2018 at 06:26:15PM +0800, Tiwei Bie wrote:
> > > > Allocate a feature bit for virtio devices which support SR-IOV.
> > > > 
> > > > Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> > > > Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> > > > Fixes: https://github.com/oasis-tcs/virtio-spec/issues/11
> > > > ---
> > > > More details can be found from this thread:
> > > > https://patchwork.kernel.org/patch/10285541/
> > > > 
> > > > This patch needs below patch applied first:
> > > > https://github.com/oasis-tcs/virtio-spec/issues/10
> > > > https://lists.oasis-open.org/archives/virtio-dev/201805/msg00046.html
> > > > 
> > > > v2 -> v3:
> > > > - Improve the wording (Cornelia);
> > > > 
> > > > v1 -> v2:
> > > > - s/Reserve/Allocate/ (MST);
> > > > - Add a Fixes tag (MST);
> > > > - Be more explicit in driver requirement (MST);
> > > > - Remove the "device MAY fail" description (MST);
> > > > - Rebase on IO_BARRIER patch;
> > > > 
> > > > RFC -> v1:
> > > > - Mention PCI in the description (Cornelia);
> > > > 
> > > >  content.tex | 15 +++++++++++++--
> > > >  1 file changed, 13 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/content.tex b/content.tex
> > > > index 95c243f..e9e6f9a 100644
> > > > --- a/content.tex
> > > > +++ b/content.tex
> > > > @@ -95,10 +95,10 @@ Feature bits are allocated as follows:
> > > >  \begin{description}
> > > >  \item[0 to 23] Feature bits for the specific device type
> > > >  
> > > > -\item[24 to 36] Feature bits reserved for extensions to the queue and
> > > > +\item[24 to 37] Feature bits reserved for extensions to the queue and
> > > >    feature negotiation mechanisms
> > > >  
> > > > -\item[37 and above] Feature bits reserved for future extensions.
> > > > +\item[38 and above] Feature bits reserved for future extensions.
> > > >  \end{description}
> > > >  
> > > >  \begin{note}
> > > > @@ -5357,6 +5357,9 @@ Descriptors} and \ref{sec:Packed Virtqueues / Indirect Flag: Scatter-Gather Supp
> > > >    better performance.  This feature indicates whether
> > > >    a stronger form of barrier suitable for hardware
> > > >    devices is necessary.
> > > > +  \item[VIRTIO_F_SR_IOV(37)] This feature indicates that
> > > > +  the device supports Single Root I/O Virtualization.
> > > > +  Currently only PCI devices support this feature.
> > > 
> > > I guess the assumption is that all VFs and the PF are of the same type?
> > > 
> > > I feel it might be handy down the road to support mixing
> > > types. For this reason, to avoid binding a wrong driver
> > > to a VF, I propose that all VFs have this bit too,
> > > and require that drivers ignore VFs without this bit.
> > > 
> > > What do you think?
> > 
> > Thinking more about it, I can see how this might
> > interfere with passing VFs through to legacy nested guests.
> > How about reversing it then?
> > 
> > Require that drivers MUST NOT negotiate VIRTIO_F_SR_IOV
> > if device does not have an SRIOV capability or
> > is not a PCI device, in particular a VF.
> 
> I think driver can accept this feature as long as it's
> able to handle the SR-IOV capability and there is no
> need for it to check whether the device has the SR-IOV
> capability.

So my point is this, VFs themselves do not have
this feature.

Should all of them have it? None of them?
I don't see what use it is to VFs, but maybe
we will come with a use down the road.

I propose we require that
1. drivers ignore this if there is
no SRIOV cap, and

2. that devices do not expose it.

This way if we come up with a use down the road, only new drivers
will negotiate it.



> And device should make sure that it won't
> offer this feature if it doesn't present this capability.
> How about changing the driver requirement to:
> 
> A driver SHOULD accept VIRTIO_F_SR_IOV if it is offered.

This part won't address the issue above.


> If VIRTIO_F_SR_IOV has been negotiated, a driver can
> enable virtual functions through the device's PCI SR-IOV
> capability structure.  A driver MUST negotiate VIRTIO_F_SR_IOV
> and complete the feature negotiation (including setting
> the DRIVER_OK \field{status} bit) before enabling virtual
> functions through the device's PCI SR-IOV capability
> structure.
> 
> 
> > 
> > And say a device without SRIOV cap SHOULD NOT expose this bit.
> > 
> 
> No problem. How about:
> 
> A device SHOULD offer VIRTIO_F_SR_IOV if it presents a
> PCI SR-IOV capability structure.  A device SHOULD NOT
> offer VIRTIO_F_SR_IOV if it doesn't presents

doesn't present

> a PCI SR-IOV
> capability structure.

Assuming we teach drivers they should ignore it
if it is there without SRIOV, then this last one I'd make MUST NOT.

> > 
> > 
> > > >  \end{description}
> > > >  
> > > >  \drivernormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}
> > > > @@ -5376,6 +5379,11 @@ A driver SHOULD accept VIRTIO_F_IO_BARRIER if it is offered.
> > > >  If VIRTIO_F_IO_BARRIER has been negotiated, a driver MUST use
> > > >  the barriers suitable for hardware devices.
> > > >  
> > > > +A driver SHOULD accept VIRTIO_F_SR_IOV if it is offered.
> > > > +If VIRTIO_F_SR_IOV has been negotiated, a driver can
> > > > +enable virtual functions through the device's PCI SR-IOV
> > > > +capability structure.
> > > 
> > > I feel the last sentence isn't clear enough.  How about
> > > 
> > > a driver MUST negotiate VIRTIO_F_SR_IOV and complete the feature
> > > negotiation (including setting the DRIVER_OK \field{status} bit) before
> > > enabling virtual functions through the device's PCI SR-IOV capability
> > > structure.
> > > 
> > > > +
> > > >  \devicenormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}
> > > >  
> > > >  A device MUST offer VIRTIO_F_VERSION_1.  A device MAY fail to operate further
> > > > @@ -5392,6 +5400,9 @@ buffers in the same order in which they have been available.
> > > >  A device MAY fail to operate further if VIRTIO_F_IO_BARRIER
> > > >  is not accepted.
> > > >  
> > > > +A device SHOULD offer VIRTIO_F_SR_IOV if it presents a PCI
> > > > +SR-IOV capability structure.
> > > > +
> > > >  \section{Legacy Interface: Reserved Feature Bits}\label{sec:Reserved Feature Bits / Legacy Interface: Reserved Feature Bits}
> > > >  
> > > >  Transitional devices MAY offer the following:
> > > 
> > > 
> > > 
> > > > -- 
> > > > 2.17.0
> > > > 
> > > > 
> > > > ---------------------------------------------------------------------
> > > > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > > > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

