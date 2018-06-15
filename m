Return-Path: virtio-dev-return-4385-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 74E405818038
	for <virtio-dev@lists.oasis-open.org>; Thu, 14 Jun 2018 19:34:37 -0700 (PDT)
Date: Fri, 15 Jun 2018 05:34:24 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180615052743-mutt-send-email-mst@kernel.org>
References: <1525734594-11134-1-git-send-email-sridhar.samudrala@intel.com>
 <20180611202207-mutt-send-email-mst@kernel.org>
 <dc8b1669-b8b6-fb59-94e2-6e4de6b96572@redhat.com>
 <20180612051432-mutt-send-email-mst@kernel.org>
 <23fc4aa4-ec41-d6e2-3354-10cbfc13b7ec@intel.com>
 <20180612142557-mutt-send-email-mst@kernel.org>
 <b9c88515-cf41-2a9a-078e-9c9e5adbbf14@intel.com>
 <CADGSJ213f8tJpNXuOhv8qRew-Y5VZAwA+srNMrLZYnKdVGLdAA@mail.gmail.com>
 <20180614120231.0a72bd5f.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180614120231.0a72bd5f.cohuck@redhat.com>
Subject: Re: [virtio-dev] Re: [Qemu-devel] [PATCH] qemu: Introduce
 VIRTIO_NET_F_STANDBY feature bit to virtio_net
To: Cornelia Huck <cohuck@redhat.com>
Cc: Siwei Liu <loseweigh@gmail.com>, "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, Alexander Duyck <alexander.h.duyck@intel.com>, virtio-dev@lists.oasis-open.org, aaron.f.brown@intel.com, Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski <kubakici@wp.pl>, Netdev <netdev@vger.kernel.org>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Jun 14, 2018 at 12:02:31PM +0200, Cornelia Huck wrote:
> So, do you know from the outset that there will be such a coupled
> device? I.e., is it a property of the VM definition?
> 
> Can there be a 'prepared' virtio-net device that presents the STANDBY
> feature even if there currently is no vfio-handled device available --
> but making it possible to simply hotplug that device later?
> Should it be possible to add a virtio/vfio pair later on?

Yes, that's the plan, more or less.

> > >>> I think Qemu should check if guest virtio-net supports this feature and
> > >>> provide a mechanism for
> > >>> an upper layer indicating if the STANDBY feature is successfully
> > >>> negotiated or not.
> > >>> The upper layer can then decide if it should hot plug a VF with the same
> > >>> MAC and manage the 2 links.
> > >>> If VF is successfully hot plugged, virtio-net link should be disabled.  

BTW I see no reason to do this last part. The role of the
standby device is to be always there.

> > >>
> > >> Did you even talk to upper layer management about it?
> > >> Just list the steps they need to do and you will see
> > >> that's a lot of machinery to manage by the upper layer.
> > >>
> > >> What do we gain in flexibility? As far as I can see the
> > >> only gain is some resources saved for legacy VMs.
> > >>
> > >> That's not a lot as tenant of the upper layer probably already has
> > >> at least a hunch that it's a new guest otherwise
> > >> why bother specifying the feature at all - you
> > >> save even more resources without it.
> > >>  
> > >
> > > I am not all that familiar with how Qemu manages network devices. If we can
> > > do all the
> > > required management of the primary/standby devices within Qemu, that is
> > > definitely a better
> > > approach without upper layer involvement.  
> > 
> > Right. I would imagine in the extreme case the upper layer doesn't
> > have to be involved at all if QEMU manages all hot plug/unplug logic.
> > The management tool can supply passthrough device and virtio with the
> > same group UUID, QEMU auto-manages the presence of the primary, and
> > hot plug the device as needed before or after the migration.
> 
> I do not really see how you can manage that kind of stuff in QEMU only.

So right now failover is limited to pci passthrough devices only.
The idea is to realize the vfio device but not expose it
to guest. Have a separate command to expose it to guest.
Hotunplug would also hide it from guest but not unrealize it.

This will help ensure that e.g. on migration failure we can
re-expose the device without risk of running out of resources.
-- 
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

