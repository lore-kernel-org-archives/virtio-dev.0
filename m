Return-Path: virtio-dev-return-4397-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 1BD625818CAD
	for <virtio-dev@lists.oasis-open.org>; Fri, 15 Jun 2018 05:31:57 -0700 (PDT)
Date: Fri, 15 Jun 2018 15:31:43 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180615152926-mutt-send-email-mst@kernel.org>
References: <20180611202207-mutt-send-email-mst@kernel.org>
 <dc8b1669-b8b6-fb59-94e2-6e4de6b96572@redhat.com>
 <20180612051432-mutt-send-email-mst@kernel.org>
 <23fc4aa4-ec41-d6e2-3354-10cbfc13b7ec@intel.com>
 <20180612142557-mutt-send-email-mst@kernel.org>
 <b9c88515-cf41-2a9a-078e-9c9e5adbbf14@intel.com>
 <CADGSJ213f8tJpNXuOhv8qRew-Y5VZAwA+srNMrLZYnKdVGLdAA@mail.gmail.com>
 <20180614120231.0a72bd5f.cohuck@redhat.com>
 <20180615052743-mutt-send-email-mst@kernel.org>
 <20180615113242.799974f6.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180615113242.799974f6.cohuck@redhat.com>
Subject: Re: [virtio-dev] Re: [Qemu-devel] [PATCH] qemu: Introduce
 VIRTIO_NET_F_STANDBY feature bit to virtio_net
To: Cornelia Huck <cohuck@redhat.com>
Cc: Siwei Liu <loseweigh@gmail.com>, "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, Alexander Duyck <alexander.h.duyck@intel.com>, virtio-dev@lists.oasis-open.org, aaron.f.brown@intel.com, Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski <kubakici@wp.pl>, Netdev <netdev@vger.kernel.org>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Jun 15, 2018 at 11:32:42AM +0200, Cornelia Huck wrote:
> On Fri, 15 Jun 2018 05:34:24 +0300
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Thu, Jun 14, 2018 at 12:02:31PM +0200, Cornelia Huck wrote:
> 
> > > > > I am not all that familiar with how Qemu manages network devices. If we can
> > > > > do all the
> > > > > required management of the primary/standby devices within Qemu, that is
> > > > > definitely a better
> > > > > approach without upper layer involvement.    
> > > > 
> > > > Right. I would imagine in the extreme case the upper layer doesn't
> > > > have to be involved at all if QEMU manages all hot plug/unplug logic.
> > > > The management tool can supply passthrough device and virtio with the
> > > > same group UUID, QEMU auto-manages the presence of the primary, and
> > > > hot plug the device as needed before or after the migration.  
> > > 
> > > I do not really see how you can manage that kind of stuff in QEMU only.  
> > 
> > So right now failover is limited to pci passthrough devices only.
> > The idea is to realize the vfio device but not expose it
> > to guest. Have a separate command to expose it to guest.
> > Hotunplug would also hide it from guest but not unrealize it.
> 
> So, this would not be real hot(un)plug, but 'hide it from the guest',
> right? The concept of "we have it realized in QEMU, but the guest can't
> discover and use it" should be translatable to non-pci as well (at
> least for ccw).
> 
> > 
> > This will help ensure that e.g. on migration failure we can
> > re-expose the device without risk of running out of resources.
> 
> Makes sense.
> 
> Should that 'hidden' state be visible/settable from outside as well
> (e.g. via a property)? I guess yes, so that management software has a
> chance to see whether a device is visible.

Might be handy for debug, but note that since QEMU manages this
state it's transient: can change at any time, so it's kind
of hard for management to rely on it.

> Settable may be useful if we
> find another use case for hiding realized devices.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

