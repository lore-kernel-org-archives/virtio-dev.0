Return-Path: virtio-dev-return-3998-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 6F37F5818E8A
	for <virtio-dev@lists.oasis-open.org>; Fri, 27 Apr 2018 18:42:08 -0700 (PDT)
Date: Sat, 28 Apr 2018 09:42:42 +0800
From: Tiwei Bie <tiwei.bie@intel.com>
Message-ID: <20180428014242.msbdw25kmvx2gabi@debian>
References: <20180425082312.32244-1-tiwei.bie@intel.com>
 <20180427130246.GA11150@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180427130246.GA11150@stefanha-x1.localdomain>
Subject: [virtio-dev] Re: [RFC] VIRTIO_F_IO_BARRIER: use I/O barriers in driver
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: mst@redhat.com, pbonzini@redhat.com, jasowang@redhat.com, virtio-dev@lists.oasis-open.org, cunming.liang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Apr 27, 2018 at 02:02:46PM +0100, Stefan Hajnoczi wrote:
> On Wed, Apr 25, 2018 at 04:23:12PM +0800, Tiwei Bie wrote:
> > There will be hardware virtio devices in the future, which
> > require drivers to use the barriers suitable for I/O device,
> > compared with software virtio devices which just require
> > drivers to use the barriers suitable for CPU core.
> > 
> > To fix the ordering issue for hardware virtio devices, add
> > a new feature: VIRTIO_F_IO_BARRIER. When negotiated, driver
> > will use the barriers suitable for I/O device.
> > 
> > Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> > ---
> >  content.tex | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/content.tex b/content.tex
> > index ae5fa4c..f24e320 100644
> > --- a/content.tex
> > +++ b/content.tex
> > @@ -5445,6 +5445,8 @@ Descriptors} and \ref{sec:Packed Virtqueues / Indirect Flag: Scatter-Gather Supp
> >    that drivers pass extra data (besides identifying the Virtqueue)
> >    in their device notifications.
> >    See \ref{sec:Virtqueues / Driver notifications}~\nameref{sec:Virtqueues / Driver notifications}.
> > +  \item[VIRTIO_F_IO_BARRIER(37)] This feature indicates that the device
> > +  needs the driver to use the barriers suitable for hardware device.
> 
> s/hardware device/hardware devices/ (plural)
> 
> >  \end{description}
> >  
> >  \drivernormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}
> > @@ -5460,6 +5462,10 @@ addresses to the device.
> >  
> >  A driver SHOULD accept VIRTIO_F_RING_PACKED if it is offered.
> >  
> > +A driver SHOULD accept VIRTIO_F_IO_BARRIER if it is offered.
> > +If VIRTIO_F_IO_BARRIER has been negotiated, a driver MUST use
> > +the barriers suitable for hardware device.
> 
> s/hardware device/hardware devices/ (plural)
> 
> Please add a little context so the purpose is clear to readers (I
> wouldn't be 100% sure what the spec means without more detail):
> 
>   Some transports require barriers to ensure hardware devices have a
>   consistent view of memory.  When devices are implemented in software a
>   weaker form of barrier may be sufficient and yield better performance.
>   This feature bit indicates whether the full hardware barrier is
>   necessary.

Thank you very much for the review and suggestion! :)

Best regards,
Tiwei Bie

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

