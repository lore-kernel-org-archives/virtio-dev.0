Return-Path: virtio-dev-return-4522-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 4DDE758191F6
	for <virtio-dev@lists.oasis-open.org>; Mon, 25 Jun 2018 10:42:40 -0700 (PDT)
Date: Mon, 25 Jun 2018 20:42:27 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180625203654-mutt-send-email-mst@kernel.org>
References: <20180625122442.22432-1-tiwei.bie@intel.com>
 <c1215d02-918f-64af-867a-d7a21ca8f93b@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1215d02-918f-64af-867a-d7a21ca8f93b@linux.ibm.com>
Subject: Re: [virtio-dev] [RFC] content: tweak VIRTIO_F_IO_BARRIER
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Tiwei Bie <tiwei.bie@intel.com>, cohuck@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, jasowang@redhat.com, pasic@linux.vnet.ibm.com, virtio-dev@lists.oasis-open.org, dan.daly@intel.com, cunming.liang@intel.com, zhihong.wang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Jun 25, 2018 at 06:07:17PM +0200, Halil Pasic wrote:
> 
> 
> On 06/25/2018 02:24 PM, Tiwei Bie wrote:
> > VIRTIO_F_IO_BARRIER was proposed recently to allow
> > drivers to do some optimizations when devices are
> > implemented in software. But it only covers barrier
> > related optimizations. Later investigations show
> > that, it could cover more. So this patch tweaks this
> > feature bit to tell the driver whether it can assume
> > the device is implemented in software and runs on
> > host CPU, and also renames this feature bit to
> > VIRTIO_F_REAL_DEVICE correspondingly.
> > 
> > Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> 
> I think it would be conceptually cleaner to revert the
> VIRTIO_F_IO_BARRIER and introduce VIRTIO_F_REAL_DEVICE form
> zero. The point is VIRTIO_F_IO_BARRIER never got released. Otherwise
> I'm not sure altering the meaning of a feature bit is a good idea.
> 
> > ---
> >   content.tex | 22 ++++++++++------------
> >   1 file changed, 10 insertions(+), 12 deletions(-)
> > 
> > diff --git a/content.tex b/content.tex
> > index be18234..5d6b977 100644
> > --- a/content.tex
> > +++ b/content.tex
> > @@ -5356,15 +5356,13 @@ Descriptors} and \ref{sec:Packed Virtqueues / Indirect Flag: Scatter-Gather Supp
> >     \item[VIRTIO_F_IN_ORDER(35)] This feature indicates
> >     that all buffers are used by the device in the same
> >     order in which they have been made available.
> > -  \item[VIRTIO_F_IO_BARRIER(36)] This feature indicates
> > -  that the device needs the driver to use the barriers
> > -  suitable for hardware devices.  Some transports require
> > -  barriers to ensure devices have a consistent view of
> > -  memory.  When devices are implemented in software a
> > -  weaker form of barrier may be sufficient and yield
> > +  \item[VIRTIO_F_REAL_DEVICE(36)] This feature indicates
> > +  that the device doesn't allow the driver to assume the
> > +  device is implemented in software and runs on host CPU.
> > +  When devices are implemented in software and run on host
> > +  CPU, some optimizations can be done in drivers and yield
> 
> s/optimizations/optimization/ ?

Why?

> >     better performance.  This feature indicates whether
> 
> Previously 'yield better performance' was meaningful, but
> IMHO it is not after the change.

I agree it's somehow vague.

> > -  a stronger form of barrier suitable for hardware
> > -  devices is necessary.
> > +  drivers can make this assumption.
> 
> IMHO too vague. What is the assumption? That the device is a 'real'
> device, or that it 'runs on host CPU'? This last sentence seems
> also redundant with the first sentence.
> 
> I think we could sneak back the barriers topic here at least.
> This 'if you see VIRTIO_F_REAL_DEVICE don't do "some optimizations"'
> is very vague. What is in except for memory barriers?
> 
> >     \item[VIRTIO_F_SR_IOV(37)] This feature indicates that
> >     the device supports Single Root I/O Virtualization.
> >     Currently only PCI devices support this feature.
> > @@ -5383,9 +5381,9 @@ addresses to the device.
> >   A driver SHOULD accept VIRTIO_F_RING_PACKED if it is offered.
> > -A driver SHOULD accept VIRTIO_F_IO_BARRIER if it is offered.
> > -If VIRTIO_F_IO_BARRIER has been negotiated, a driver MUST use
> > -the barriers suitable for hardware devices.
> > +A driver SHOULD accept VIRTIO_F_REAL_DEVICE if it is offered.
> > +If VIRTIO_F_REAL_DEVICE has been negotiated, a driver MUST NOT
> > +assume the device is implemented in software and runs on host CPU.
> >   \devicenormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}
> > @@ -5400,7 +5398,7 @@ accepted.
> >   If VIRTIO_F_IN_ORDER has been negotiated, a device MUST use
> >   buffers in the same order in which they have been available.
> > -A device MAY fail to operate further if VIRTIO_F_IO_BARRIER
> > +A device MAY fail to operate further if VIRTIO_F_REAL_DEVICE
> >   is not accepted.
> 
> I think them MAY should be a SHOULD. If the device knows that it is likely
> to malfunction if the driver does 'the some optimisations' then I think
> failing the feature negotiation is the right thing to do.
> 
> Regards,
> Halil

With the REAL_DEVICE as vague as it is, it's hard to argue either way.


> >   A device SHOULD offer VIRTIO_F_SR_IOV if it is a PCI device
> > 

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

