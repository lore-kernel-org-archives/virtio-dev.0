Return-Path: virtio-dev-return-4112-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 915AC581803B
	for <virtio-dev@lists.oasis-open.org>; Tue, 22 May 2018 03:23:44 -0700 (PDT)
Date: Tue, 22 May 2018 18:24:02 +0800
From: Tiwei Bie <tiwei.bie@intel.com>
Message-ID: <20180522102402.GA20165@debian>
References: <20180522045623.10383-1-tiwei.bie@intel.com>
 <20180522115612.3977529e.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180522115612.3977529e.cohuck@redhat.com>
Subject: [virtio-dev] Re: [PATCH v2] content: support SR-IOV
To: Cornelia Huck <cohuck@redhat.com>
Cc: mst@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, virtio-dev@lists.oasis-open.org, dan.daly@intel.com, alexander.h.duyck@intel.com, mark.d.rustad@intel.com, cunming.liang@intel.com, zhihong.wang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, May 22, 2018 at 11:56:12AM +0200, Cornelia Huck wrote:
> On Tue, 22 May 2018 12:56:23 +0800
> Tiwei Bie <tiwei.bie@intel.com> wrote:
> 
> > Allocate a feature bit for virtio devices which support SR-IOV.
> > 
> > Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> > Fixes: https://github.com/oasis-tcs/virtio-spec/issues/11
> > ---
> > More details can be found from this thread:
> > https://patchwork.kernel.org/patch/10285541/
> > 
> > This patch needs below patch applied first:
> > https://github.com/oasis-tcs/virtio-spec/issues/10
> > https://lists.oasis-open.org/archives/virtio-dev/201805/msg00046.html
> > 
> > v1 -> v2:
> > - s/Reserve/Allocate/ (MST);
> > - Add a Fixes tag (MST);
> > - Be more explicit in driver requirement (MST);
> > - Remove the "device MAY fail" description (MST);
> > - Rebase on IO_BARRIER patch;
> > 
> > RFC -> v1:
> > - Mention PCI in the description (Cornelia);
> > 
> >  content.tex | 15 +++++++++++++--
> >  1 file changed, 13 insertions(+), 2 deletions(-)
> > 
> > diff --git a/content.tex b/content.tex
> > index 95c243f..1c23274 100644
> > --- a/content.tex
> > +++ b/content.tex
> > @@ -95,10 +95,10 @@ Feature bits are allocated as follows:
> >  \begin{description}
> >  \item[0 to 23] Feature bits for the specific device type
> >  
> > -\item[24 to 36] Feature bits reserved for extensions to the queue and
> > +\item[24 to 37] Feature bits reserved for extensions to the queue and
> >    feature negotiation mechanisms
> >  
> > -\item[37 and above] Feature bits reserved for future extensions.
> > +\item[38 and above] Feature bits reserved for future extensions.
> >  \end{description}
> >  
> >  \begin{note}
> > @@ -5357,6 +5357,9 @@ Descriptors} and \ref{sec:Packed Virtqueues / Indirect Flag: Scatter-Gather Supp
> >    better performance.  This feature indicates whether
> >    a stronger form of barrier suitable for hardware
> >    devices is necessary.
> > +  \item[VIRTIO_F_SR_IOV(37)] This feature indicates that
> > +  the device supports Single Root I/O Virtualization.
> > +  Currently only virtio PCI devices support this feature.
> 
> Nit: s/virtio PCI devices/PCI devices/
> 
> (I'd be fine with keeping 'virtio', though.)
> 
> >  \end{description}
> >  
> >  \drivernormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}
> > @@ -5376,6 +5379,11 @@ A driver SHOULD accept VIRTIO_F_IO_BARRIER if it is offered.
> >  If VIRTIO_F_IO_BARRIER has been negotiated, a driver MUST use
> >  the barriers suitable for hardware devices.
> >  
> > +A driver SHOULD accept VIRTIO_F_SR_IOV if it is offered.
> > +If VIRTIO_F_SR_IOV has been negotiated, a driver can
> > +enable virtual functions through device's PCI SR-IOV
> 
> s/device's/the device's/
> 
> > +capability structure.
> > +
> >  \devicenormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}
> >  
> >  A device MUST offer VIRTIO_F_VERSION_1.  A device MAY fail to operate further
> > @@ -5392,6 +5400,9 @@ buffers in the same order in which they have been available.
> >  A device MAY fail to operate further if VIRTIO_F_IO_BARRIER
> >  is not accepted.
> >  
> > +A device SHOULD offer VIRTIO_F_SR_IOV if it presents a PCI
> > +SR-IOV capability structure.
> > +
> >  \section{Legacy Interface: Reserved Feature Bits}\label{sec:Reserved Feature Bits / Legacy Interface: Reserved Feature Bits}
> >  
> >  Transitional devices MAY offer the following:
> 
> Else LGTM.

Thank you very much for the review! :)

Best regards,
Tiwei Bie

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

