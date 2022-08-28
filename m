Return-Path: <mst@redhat.com>
Date: Sun, 28 Aug 2022 05:35:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [virtio-dev] Re: [virtio] [PATCH RFC v7 6/8] ccw: disallow
 ADMIN_VQ
Message-ID: <20220828052839-mutt-send-email-mst@kernel.org>
References: <20220812171841.12183-1-mst@redhat.com>
 <20220812171841.12183-7-mst@redhat.com>
 <20220816164811.16464110.pasic@linux.ibm.com>
 <20220816114216-mutt-send-email-mst@kernel.org>
 <20220818153958.7219f6b8.pasic@linux.ibm.com>
 <20220818235403-mutt-send-email-mst@kernel.org>
 <20220824014519.028ee16d.pasic@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20220824014519.028ee16d.pasic@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Halil Pasic <pasic@linux.ibm.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, jasowang@redhat.com, cohuck@redhat.com, sgarzare@redhat.com, stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com, virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>, oren@nvidia.com, parav@nvidia.com, shahafs@nvidia.com, aadam@redhat.com, eperezma@redhat.com, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Aug 24, 2022 at 01:45:19AM +0200, Halil Pasic wrote:
> On Thu, 18 Aug 2022 23:57:39 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > > > > I'm not sure I understand the intention here. I believe what we try to
> > > > > accomplish here is the following. The Channel I/O transport *currently*
> > > > > does not support the VIRTIO_F_ADMIN_VQ feature. It is not like we want
> > > > > to state that the feature VIRTIO_F_ADMIN_VQ won't ever be supported by
> > > > > the Channel I/O transport. Or am I wrong?
> > > > >
> > > > > If my assumptions are right, then the old incarnation of the spec could
> > > > > contradict the new incarnation of the spec. Thus I would prefer something
> > > > > like.    
> > > > 
> > > > Relaxing requirenents is always okay.  
> > > 
> > > Are you telling me, that for instance a driver author may not rely on
> > > even the MUST type device normative behavior stated by the spec, because
> > > future incarnations of the spec could relax the requirements towards this
> > > particular device, for example by removing that device normative
> > > statement?  
> > 
> > > I always imagined, if the spec says the device or the driver MUST
> > > "something", then I as the implementer of the other end (driver or
> > > device, can rely on that "something"). If this assumption is wrong then
> > > I'm have to re-examine my entire mental model of the spec.  
> > 
> > Generally yes.  Not if we explicitly tell it not to.
> > 
> > Like here:
> > 	 +Driver MUST NOT set bit VIRTIO_F_ADMIN_VQ (bit 41) in
> > 	 +DriverFeatures even if offered by the device.
> > 
> > This makes sure that drivers do not make an assumption that
> > devices do not set the bit. But yes, maybe spell it out:
> > 
> > 	 +Driver MUST NOT set bit VIRTIO_F_ADMIN_VQ (bit 41) in
> > 	 +DriverFeatures even if offered by the device.
> > 	 +Driver MUST NOT assume that device does not offer VIRTIO_F_ADMIN_VQ.
> > 	 +In particular driver MUST NOT fail feature negotiation if
> > 	 +device offers VIRTIO_F_ADMIN_VQ.
> > 
> > ok now?
> 
> Sorry, it still does not work for me. But I may be wrong. My problem
> is that what we mean is the following:
> 
> If the driver (where driver includes both the transport part and the
> transport agnostic part) does not support VIRTIO_F_ADMIN_VQ then it must
> not set VIRTIO_F_ADMIN_VQ. And any reasoning along the lines "hey the
> device was not supposed to offer that bit in the first place" is
> misguided.

Yes, this is exactly what I'm trying to prevent here.

> The crucial part here is that the MUST NOT accept VIRTIO_F_ADMIN_VQ
> partee is only applicable if the driver does not support
> VIRTIO_F_ADMIN_VQ. That is, if we happen to extend the Channel I/O transport, and we
> decide to implement VIRTIO_F_ADMIN_VQ for the over Channel I/O devices,
> that MUST NOT accept does not get in the way.

Then we'll describe how it works in the spec and then drop this.

> My problem with your proposal is, that the MUST NOT is not guarded by a
> proper precondition (it is a prohibition that does not allow for any
> exceptions).
> 
> I would very much like Conny to chime in on this.
> 
> Regards,
> Halil

But we do this all the time. We disallow some behaviour then
following spec versions start allowing it.

Basically removing a requirement is ok as long as the other side
does not rely on it.

For example, we had this for a while:


	The driver MUST ignore any vendor-specific capability structure which has
	a reserved \field{cfg_type} value.


but the meaning of a "reserved cfg_type" changed over time, allowing
driver to access new cfg_type values.



-- 
MST

