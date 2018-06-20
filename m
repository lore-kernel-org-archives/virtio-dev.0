Return-Path: virtio-dev-return-4463-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 74A5F1CB80EE
	for <virtio-dev@lists.oasis-open.org>; Wed, 20 Jun 2018 09:06:36 -0700 (PDT)
Date: Wed, 20 Jun 2018 18:06:19 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180620180619.6b4ee52d.cohuck@redhat.com>
In-Reply-To: <20180620170904-mutt-send-email-mst@kernel.org>
References: <20180612142557-mutt-send-email-mst@kernel.org>
	<b9c88515-cf41-2a9a-078e-9c9e5adbbf14@intel.com>
	<CADGSJ213f8tJpNXuOhv8qRew-Y5VZAwA+srNMrLZYnKdVGLdAA@mail.gmail.com>
	<20180614120231.0a72bd5f.cohuck@redhat.com>
	<CADGSJ23WnTmVKHezm3t0V6M2sWeHaOUoTjdXkmrvbO0EF83hMg@mail.gmail.com>
	<20180615134815.6613620e.cohuck@redhat.com>
	<CADGSJ208NRp=bjhSkzF2K5Ft94TwdRs73WfSp4h-_vXvEKwgiQ@mail.gmail.com>
	<20180619125453.2d2dfb2d.cohuck@redhat.com>
	<20180619233001-mutt-send-email-mst@kernel.org>
	<20180620115359.1a3bf6fb.cohuck@redhat.com>
	<20180620170904-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio-dev] Re: [Qemu-devel] [PATCH] qemu: Introduce
 VIRTIO_NET_F_STANDBY feature bit to virtio_net
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Siwei Liu <loseweigh@gmail.com>, "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, Alexander Duyck <alexander.h.duyck@intel.com>, virtio-dev@lists.oasis-open.org, aaron.f.brown@intel.com, Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski <kubakici@wp.pl>, Netdev <netdev@vger.kernel.org>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, konrad.wilk@oracle.com, boris.ostrovsky@oracle.com, Joao Martins <joao.m.martins@oracle.com>, Venu Busireddy <venu.busireddy@oracle.com>, vijay.balakrishna@oracle.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, 20 Jun 2018 17:11:59 +0300
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Wed, Jun 20, 2018 at 11:53:59AM +0200, Cornelia Huck wrote:
> > On Tue, 19 Jun 2018 23:32:06 +0300
> > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >   
> > > On Tue, Jun 19, 2018 at 12:54:53PM +0200, Cornelia Huck wrote:  
> > > > Sorry about dragging mainframes into this, but this will only work for
> > > > homogenous device coupling, not for heterogenous. Consider my vfio-pci
> > > > + virtio-net-ccw example again: The guest cannot find out that the two
> > > > belong together by checking some group ID, it has to either use the MAC
> > > > or some needs-to-be-architectured property.
> > > > 
> > > > Alternatively, we could propose that mechanism as pci-only, which means
> > > > we can rely on mechanisms that won't necessarily work on non-pci
> > > > transports. (FWIW, I don't see a use case for using vfio-ccw to pass
> > > > through a network card anytime in the near future, due to the nature of
> > > > network cards currently in use on s390.)    
> > > 
> > > That's what it boils down to, yes.  If there's need to have this for
> > > non-pci devices, then we should put it in config space.
> > > Cornelia, what do you think?
> > >   
> > 
> > I think the only really useful config on s390 is the vfio-pci network
> > card coupled with a virtio-net-ccw device: Using an s390 network card
> > via vfio-ccw is out due to the nature of the s390 network cards, and
> > virtio-ccw is the default transport (virtio-pci is not supported on any
> > enterprise distro AFAIK).
> > 
> > For this, having a uuid in the config space could work (vfio-pci
> > devices have a config space by virtue of being pci devices, and
> > virtio-net-ccw devices have a config space by virtue of being virtio
> > devices -- ccw devices usually don't have that concept).  
> 
> OK so this calls for adding such a field generally (it's
> device agnostic right now).
> 
> How would you suggest doing that?

I hope that I'm not thoroughly confused at this point in time, so I'll
summarize my current understanding (also keep in mind that I haven't
looked at Venu's patches yet):

- The Linux guest initiates coupling from the virtio-net driver.
  Matching the other device is done via the MAC, and only pci devices
  are allowed for the failover device. (There does not seem to be any
  restriction on the transport of the virtio-net device.)
- The Linux guest virtio-net driver does not allow changing the MAC if
  standby has been negotiated (implying that the hypervisor needs to
  configure the correct MAC).
- In QEMU, we need to know which two devices (vfio-pci and virtio-net)
  go together, so that the virtio-net device gets the correct MAC. We
  also need the pairing so that we can make the vfio-pci device
  available once the guest has negotiated the standby feature.

We can tack the two devices together in QEMU by introducing new,
optional properties pointing from the virtio-net device to the vfio-pci
device (only offer standby if this is set) and the other way around
(don't make the device visible at the start if this is set). Problems:

- The admin needs to figure out the MAC by themselves and set it
  correctly. If this is incorrect, the vfio-pci device cannot be found
  in the guest. (Not sure how much of a problem this is in practice --
  and QEMU cannot figure out the MAC without poking at the vfio-pci
  device, and we probably want to avoid that.)
- This two-way pointing makes for interesting handing of the command
  line and when both devices are plugged later.

In any case, I'm not sure anymore why we'd want the extra uuid. Is
there any way QEMU (or libvirt) can figure it out without actually
looking at the vfio-pci device?

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

