Return-Path: virtio-dev-return-4483-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 61ECD58182B6
	for <virtio-dev@lists.oasis-open.org>; Fri, 22 Jun 2018 08:10:14 -0700 (PDT)
Date: Fri, 22 Jun 2018 17:09:55 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180622170955.298900c1.cohuck@redhat.com>
In-Reply-To: <20180621211712-mutt-send-email-mst@kernel.org>
References: <CADGSJ23WnTmVKHezm3t0V6M2sWeHaOUoTjdXkmrvbO0EF83hMg@mail.gmail.com>
	<20180615134815.6613620e.cohuck@redhat.com>
	<CADGSJ208NRp=bjhSkzF2K5Ft94TwdRs73WfSp4h-_vXvEKwgiQ@mail.gmail.com>
	<20180619125453.2d2dfb2d.cohuck@redhat.com>
	<20180619233001-mutt-send-email-mst@kernel.org>
	<20180620115359.1a3bf6fb.cohuck@redhat.com>
	<20180620170904-mutt-send-email-mst@kernel.org>
	<20180620180619.6b4ee52d.cohuck@redhat.com>
	<20180620224535-mutt-send-email-mst@kernel.org>
	<20180621165913.7e3f4faa.cohuck@redhat.com>
	<20180621211712-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio-dev] Re: [Qemu-devel] [PATCH] qemu: Introduce
 VIRTIO_NET_F_STANDBY feature bit to virtio_net
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Siwei Liu <loseweigh@gmail.com>, "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, Alexander Duyck <alexander.h.duyck@intel.com>, virtio-dev@lists.oasis-open.org, aaron.f.brown@intel.com, Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski <kubakici@wp.pl>, Netdev <netdev@vger.kernel.org>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, konrad.wilk@oracle.com, boris.ostrovsky@oracle.com, Joao Martins <joao.m.martins@oracle.com>, Venu Busireddy <venu.busireddy@oracle.com>, vijay.balakrishna@oracle.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, 21 Jun 2018 21:20:13 +0300
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Thu, Jun 21, 2018 at 04:59:13PM +0200, Cornelia Huck wrote:
> > OK, so what about the following:
> > 
> > - introduce a new feature bit, VIRTIO_NET_F_STANDBY_UUID that indicates
> >   that we have a new uuid field in the virtio-net config space
> > - in QEMU, add a property for virtio-net that allows to specify a uuid,
> >   offer VIRTIO_NET_F_STANDBY_UUID if set
> > - when configuring, set the property to the group UUID of the vfio-pci
> >   device
> > - in the guest, use the uuid from the virtio-net device's config space
> >   if applicable; else, fall back to matching by MAC as done today
> > 
> > That should work for all virtio transports.  
> 
> True. I'm a bit unhappy that it's virtio net specific though
> since down the road I expect we'll have a very similar feature
> for scsi (and maybe others).
> 
> But we do not have a way to have fields that are portable
> both across devices and transports, and I think it would
> be a useful addition. How would this work though? Any idea?

Can we introduce some kind of device-independent config space area?
Pushing back the device-specific config space by a certain value if the
appropriate feature is negotiated and use that for things like the uuid?

But regardless of that, I'm not sure whether extending this approach to
other device types is the way to go. Tying together two different
devices is creating complicated situations at least in the hypervisor
(even if it's fairly straightforward in the guest). [I have not come
around again to look at the "how to handle visibility in QEMU"
questions due to lack of cycles, sorry about that.]

So, what's the goal of this approach? Only to allow migration with
vfio-pci, or also to plug in a faster device and use it instead of an
already attached paravirtualized device?

What about migration of vfio devices that are not easily replaced by a
paravirtualized device? I'm thinking of vfio-ccw, where our main (and
currently only) supported device is dasd (disks) -- which can do a lot
of specialized things that virtio-blk does not support (and should not
or even cannot support). Would it be more helpful to focus on generic
migration support for vfio instead of going about it device by device?

This network device approach already seems far along, so it makes sense
to continue with it. But I'm not sure whether we want to spend time and
energy on that for other device types rather than working on a general
solution for vfio migration.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

