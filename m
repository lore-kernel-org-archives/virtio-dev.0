Return-Path: <stefanha@redhat.com>
Date: Tue, 20 Jul 2021 09:50:41 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [virtio-comment] [PATCH V2 2/2] virtio: introduce STOP status bit
Message-ID: <YPaOYTAHaHYcelth@stefanha-x1.localdomain>
References: <8a2037df-e527-dcb4-c4c8-a568885180e4@redhat.com>
 <YO60HpxfZnmfMCMj@stefanha-x1.localdomain>
 <094e15d4-169a-87e9-5ebb-93439ea72831@redhat.com>
 <YO79tuI72kTEWURN@stefanha-x1.localdomain>
 <1ab19438-cc13-bbe5-7fec-53a113d85463@redhat.com>
 <YPAHcG7bxhlIGVeE@stefanha-x1.localdomain>
 <c626c856-7010-0df6-131f-00aad7221266@redhat.com>
 <c3f1d0f5-bfe1-b2f1-2d06-f9e7352247f8@redhat.com>
 <YPVz9A/DkawlKoD1@stefanha-x1.localdomain>
 <0213e6c2-59aa-f140-7231-36231b42051d@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gPEOQjn/pGskjbux"
Content-Disposition: inline
In-Reply-To: <0213e6c2-59aa-f140-7231-36231b42051d@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Eugenio Perez Martin <eperezma@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, virtio-comment@lists.oasis-open.org, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Max Gurtovoy <mgurtovoy@nvidia.com>, Cornelia Huck <cohuck@redhat.com>, Oren Duer <oren@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Bodong Wang <bodong@nvidia.com>, Alexander Mikheev <amikheev@nvidia.com>, Halil Pasic <pasic@linux.ibm.com>
List-ID: <virtio-dev.lists.oasis-open.org>


--gPEOQjn/pGskjbux
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 20, 2021 at 11:04:55AM +0800, Jason Wang wrote:
>=20
> =E5=9C=A8 2021/7/19 =E4=B8=8B=E5=8D=888:45, Stefan Hajnoczi =E5=86=99=E9=
=81=93:
> > On Fri, Jul 16, 2021 at 11:53:13AM +0800, Jason Wang wrote:
> > > =E5=9C=A8 2021/7/16 =E4=B8=8A=E5=8D=8810:03, Jason Wang =E5=86=99=E9=
=81=93:
> > > > =E5=9C=A8 2021/7/15 =E4=B8=8B=E5=8D=886:01, Stefan Hajnoczi =E5=86=
=99=E9=81=93:
> > > > > On Thu, Jul 15, 2021 at 09:35:13AM +0800, Jason Wang wrote:
> > > > > > =E5=9C=A8 2021/7/14 =E4=B8=8B=E5=8D=8811:07, Stefan Hajnoczi =
=E5=86=99=E9=81=93:
> > > > > > > On Wed, Jul 14, 2021 at 06:29:28PM +0800, Jason Wang wrote:
> > > > > > > > =E5=9C=A8 2021/7/14 =E4=B8=8B=E5=8D=885:53, Stefan Hajnoczi=
 =E5=86=99=E9=81=93:
> > > > > > > > > On Tue, Jul 13, 2021 at 08:16:35PM +0800, Jason Wang wrot=
e:
> > > > > > > > > > =E5=9C=A8 2021/7/13 =E4=B8=8B=E5=8D=886:00, Stefan Hajn=
oczi =E5=86=99=E9=81=93:
> > > > > > > > > > > On Tue, Jul 13, 2021 at 11:27:03AM +0800, Jason Wang =
wrote:
> > > > > > > > > > > > =E5=9C=A8 2021/7/12 =E4=B8=8B=E5=8D=885:57, Stefan =
Hajnoczi =E5=86=99=E9=81=93:
> > > > > > > > > > > > > On Mon, Jul 12, 2021 at 12:00:39PM +0800, Jason W=
ang wrote:
> > > > > > > > > > > > > > =E5=9C=A8 2021/7/11 =E4=B8=8A=E5=8D=884:36, Mic=
hael S. Tsirkin =E5=86=99=E9=81=93:
> > > > > > > > > > > > > > > On Fri, Jul 09, 2021 at
> > > > > > > > > > > > > > > 07:23:33PM +0200, Eugenio
> > > > > > > > > > > > > > > Perez Martin wrote:
> > > > > > > > > > > > > > > > > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 If I understand correctly, this is all
> > > > > > > > > > > > > > > > > > driven from the
> > > > > > > > > > > > > > > > > > driver inside
> > > > > > > > > > > > > > > > > > the guest, so
> > > > > > > > > > > > > > > > > > for this to work
> > > > > > > > > > > > > > > > > > the guest must
> > > > > > > > > > > > > > > > > > be running and
> > > > > > > > > > > > > > > > > > already have
> > > > > > > > > > > > > > > > > > initialised the
> > > > > > > > > > > > > > > > > > driver.
> > > > > > > > > > > > > > > > > Yes.
> > > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > As I see it, the feature
> > > > > > > > > > > > > > > > can be driven entirely
> > > > > > > > > > > > > > > > by the VMM as long as
> > > > > > > > > > > > > > > > it intercept the
> > > > > > > > > > > > > > > > relevant configuration
> > > > > > > > > > > > > > > > space (PCI, MMIO, etc)
> > > > > > > > > > > > > > > > from
> > > > > > > > > > > > > > > > guest's reads and
> > > > > > > > > > > > > > > > writes, and present it
> > > > > > > > > > > > > > > > as coherent and
> > > > > > > > > > > > > > > > transparent
> > > > > > > > > > > > > > > > for the guest. Some use
> > > > > > > > > > > > > > > > cases I can imagine with
> > > > > > > > > > > > > > > > a physical device (or
> > > > > > > > > > > > > > > > vp_vpda device) with VIRTIO_F_STOP:
> > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > 1) The VMM chooses not
> > > > > > > > > > > > > > > > to pass the feature
> > > > > > > > > > > > > > > > flag. The guest cannot
> > > > > > > > > > > > > > > > stop
> > > > > > > > > > > > > > > > the device, so any write to this flag is an=
 error/undefined.
> > > > > > > > > > > > > > > > 2) The VMM passes the
> > > > > > > > > > > > > > > > flag to the guest. The
> > > > > > > > > > > > > > > > guest can stop the
> > > > > > > > > > > > > > > > device.
> > > > > > > > > > > > > > > > 2.1) The VMM stops the
> > > > > > > > > > > > > > > > device to perform a live
> > > > > > > > > > > > > > > > migration, and the
> > > > > > > > > > > > > > > > guest does not write to
> > > > > > > > > > > > > > > > STOP in any moment of
> > > > > > > > > > > > > > > > the LM. It resets the
> > > > > > > > > > > > > > > > destination device with
> > > > > > > > > > > > > > > > the state, and then
> > > > > > > > > > > > > > > > initializes the device.
> > > > > > > > > > > > > > > > 2.2) The guest stops the
> > > > > > > > > > > > > > > > device and, when
> > > > > > > > > > > > > > > > STOP(32) is set, the
> > > > > > > > > > > > > > > > source
> > > > > > > > > > > > > > > > VMM migrates the device
> > > > > > > > > > > > > > > > status. The destination
> > > > > > > > > > > > > > > > VMM realizes the bit,
> > > > > > > > > > > > > > > > so it sets the bit in
> > > > > > > > > > > > > > > > the destination too
> > > > > > > > > > > > > > > > after device
> > > > > > > > > > > > > > > > initialization.
> > > > > > > > > > > > > > > > 2.3) The device is not
> > > > > > > > > > > > > > > > initialized by the guest
> > > > > > > > > > > > > > > > so it doesn't matter
> > > > > > > > > > > > > > > > what bit has the HW, but the VM can be migr=
ated.
> > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > Am I missing something?
> > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > Thanks!
> > > > > > > > > > > > > > > It's doable like this. It's
> > > > > > > > > > > > > > > all a lot of hoops to jump
> > > > > > > > > > > > > > > through though.
> > > > > > > > > > > > > > > It's also not easy for devices to implement.
> > > > > > > > > > > > > > It just requires a new status
> > > > > > > > > > > > > > bit. Anything that makes you
> > > > > > > > > > > > > > think it's hard
> > > > > > > > > > > > > > to implement?
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > E.g for networking device, it
> > > > > > > > > > > > > > should be sufficient to use this
> > > > > > > > > > > > > > bit + the
> > > > > > > > > > > > > > virtqueue state.
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > Why don't we design the
> > > > > > > > > > > > > > > feature in a way that is
> > > > > > > > > > > > > > > useable by VMMs
> > > > > > > > > > > > > > > and implementable by devices in a simple way?
> > > > > > > > > > > > > > It use the common technology
> > > > > > > > > > > > > > like register shadowing without
> > > > > > > > > > > > > > any further
> > > > > > > > > > > > > > stuffs.
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > Or do you have any other ideas?
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > (I think we all know migration
> > > > > > > > > > > > > > will be very hard if we simply
> > > > > > > > > > > > > > pass through
> > > > > > > > > > > > > > those state registers).
> > > > > > > > > > > > > If an admin virtqueue is used
> > > > > > > > > > > > > instead of the STOP Device Status
> > > > > > > > > > > > > field
> > > > > > > > > > > > > bit then there's no need to re-read
> > > > > > > > > > > > > the Device Status field in a loop
> > > > > > > > > > > > > until the device has stopped.
> > > > > > > > > > > > Probably not. Let me to clarify several points:
> > > > > > > > > > > >=20
> > > > > > > > > > > > - This proposal has nothing to do with
> > > > > > > > > > > > admin virtqueue. Actually, admin
> > > > > > > > > > > > virtqueue could be used for carrying any
> > > > > > > > > > > > basic device facility like status
> > > > > > > > > > > > bit. E.g I'm going to post patches that
> > > > > > > > > > > > use admin virtqueue as a "transport"
> > > > > > > > > > > > for device slicing at virtio level.
> > > > > > > > > > > > - Even if we had introduced admin
> > > > > > > > > > > > virtqueue, we still need a per function
> > > > > > > > > > > > interface for this. This is a must for
> > > > > > > > > > > > nested virtualization, we can't
> > > > > > > > > > > > always expect things like PF can be assigned to L1 =
guest.
> > > > > > > > > > > > - According to the proposal, there's no
> > > > > > > > > > > > need for the device to complete all
> > > > > > > > > > > > the consumed buffers, device can choose
> > > > > > > > > > > > to expose those inflight descriptors
> > > > > > > > > > > > in a device specific way and set the
> > > > > > > > > > > > STOP bit. This means, if we have the
> > > > > > > > > > > > device specific in-flight descriptor
> > > > > > > > > > > > reporting facility, the device can
> > > > > > > > > > > > almost set the STOP bit immediately.
> > > > > > > > > > > > - If we don't go with the basic device
> > > > > > > > > > > > facility but using the admin
> > > > > > > > > > > > virtqueue specific method, we still need
> > > > > > > > > > > > to clarify how it works with the
> > > > > > > > > > > > device status state machine, it will be
> > > > > > > > > > > > some kind of sub-states which looks
> > > > > > > > > > > > much more complicated than the current proposal.
> > > > > > > > > > > >=20
> > > > > > > > > > > >=20
> > > > > > > > > > > > > When migrating a guest with many
> > > > > > > > > > > > > VIRTIO devices a busy waiting
> > > > > > > > > > > > > approach
> > > > > > > > > > > > > extends downtime if implemented
> > > > > > > > > > > > > sequentially (stopping one device at
> > > > > > > > > > > > > a
> > > > > > > > > > > > > time).
> > > > > > > > > > > > Well. You need some kinds of waiting for
> > > > > > > > > > > > sure, the device/DMA needs sometime
> > > > > > > > > > > > to be stopped. The downtime is determined by a spec=
ific virtio
> > > > > > > > > > > > implementation which is hard to be
> > > > > > > > > > > > restricted at the spec level. We can
> > > > > > > > > > > > clarify that the device must set the STOP bit in e.=
g 100ms.
> > > > > > > > > > > >=20
> > > > > > > > > > > >=20
> > > > > > > > > > > > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 It can be impleme=
nted
> > > > > > > > > > > > > concurrently (setting the STOP bit
> > > > > > > > > > > > > on all
> > > > > > > > > > > > > devices and then looping until all
> > > > > > > > > > > > > their Device Status fields have the
> > > > > > > > > > > > > bit set), but this becomes more complex to implem=
ent.
> > > > > > > > > > > > I still don't get what kind of complexity did you w=
orry here.
> > > > > > > > > > > >=20
> > > > > > > > > > > >=20
> > > > > > > > > > > > > I'm a little worried about adding a new bit that =
requires busy
> > > > > > > > > > > > > waiting...
> > > > > > > > > > > > Busy wait is not something that is introduced in th=
is patch:
> > > > > > > > > > > >=20
> > > > > > > > > > > > 4.1.4.3.2 Driver Requirements: Common
> > > > > > > > > > > > configuration structure layout
> > > > > > > > > > > >=20
> > > > > > > > > > > > After writing 0 to device_status, the
> > > > > > > > > > > > driver MUST wait for a read of
> > > > > > > > > > > > device_status to return 0 before reinitializing the=
 device.
> > > > > > > > > > > >=20
> > > > > > > > > > > > Since it was required for at least one
> > > > > > > > > > > > transport. We need do something
> > > > > > > > > > > > similar to when introducing basic facility.
> > > > > > > > > > > Adding the STOP but as a Device Status bit
> > > > > > > > > > > is a small and clean VIRTIO
> > > > > > > > > > > spec change. I like that.
> > > > > > > > > > >=20
> > > > > > > > > > > On the other hand, devices need time to stop and that=
 time can be
> > > > > > > > > > > unbounded. For example, software
> > > > > > > > > > > virtio-blk/scsi implementations since
> > > > > > > > > > > cannot immediately cancel in-flight I/O requests on L=
inux hosts.
> > > > > > > > > > >=20
> > > > > > > > > > > The natural interface for long-running
> > > > > > > > > > > operations is virtqueue requests.
> > > > > > > > > > > That's why I mentioned the alternative of using an ad=
min virtqueue
> > > > > > > > > > > instead of a Device Status bit.
> > > > > > > > > > So I'm not against the admin virtqueue. As said
> > > > > > > > > > before, admin virtqueue
> > > > > > > > > > could be used for carrying the device status bit.
> > > > > > > > > >=20
> > > > > > > > > > Send a command to set STOP status bit to admin
> > > > > > > > > > virtqueue. Device will make
> > > > > > > > > > the command buffer used after it has
> > > > > > > > > > successfully stopped the device.
> > > > > > > > > >=20
> > > > > > > > > > AFAIK, they are not mutually exclusive, since
> > > > > > > > > > they are trying to solve
> > > > > > > > > > different problems.
> > > > > > > > > >=20
> > > > > > > > > > Device status - basic device facility
> > > > > > > > > >=20
> > > > > > > > > > Admin virtqueue - transport/device specific way
> > > > > > > > > > to implement (part of) the
> > > > > > > > > > device facility
> > > > > > > > > >=20
> > > > > > > > > > > Although you mentioned that the stopped
> > > > > > > > > > > state needs to be reflected in
> > > > > > > > > > > the Device Status field somehow, I'm not sure about t=
hat since the
> > > > > > > > > > > driver typically doesn't need to know whether the dev=
ice is being
> > > > > > > > > > > migrated.
> > > > > > > > > > The guest won't see the real device status bit.
> > > > > > > > > > VMM will shadow the device
> > > > > > > > > > status bit in this case.
> > > > > > > > > >=20
> > > > > > > > > > E.g with the current vhost-vDPA, vDPA behave
> > > > > > > > > > like a vhost device, guest is
> > > > > > > > > > unaware of the migration.
> > > > > > > > > >=20
> > > > > > > > > > STOP status bit is set by Qemu to real virtio
> > > > > > > > > > hardware. But guest will only
> > > > > > > > > > see the DRIVER_OK without STOP.
> > > > > > > > > >=20
> > > > > > > > > > It's not hard to implement the nested on top,
> > > > > > > > > > see the discussion initiated
> > > > > > > > > > by Eugenio about how expose VIRTIO_F_STOP to guest for =
nested live
> > > > > > > > > > migration.
> > > > > > > > > >=20
> > > > > > > > > >=20
> > > > > > > > > > >  =C2=A0=C2=A0=C2=A0=C2=A0 In fact, the VMM would need=
 to hide
> > > > > > > > > > > this bit and it's safer to
> > > > > > > > > > > keep it out-of-band instead of risking exposing it by=
 accident.
> > > > > > > > > > See above, VMM may choose to hide or expose the
> > > > > > > > > > capability. It's useful for
> > > > > > > > > > migrating a nested guest.
> > > > > > > > > >=20
> > > > > > > > > > If we design an interface that can be used in
> > > > > > > > > > the nested environment, it's
> > > > > > > > > > not an ideal interface.
> > > > > > > > > >=20
> > > > > > > > > >=20
> > > > > > > > > > > In addition, stateful devices need to
> > > > > > > > > > > load/save non-trivial amounts of
> > > > > > > > > > > data. They need DMA to do this efficiently,
> > > > > > > > > > > so an admin virtqueue is a
> > > > > > > > > > > good fit again.
> > > > > > > > > > I don't get the point here. You still need to
> > > > > > > > > > address the exact the similar
> > > > > > > > > > issues for admin virtqueue: the unbound time in
> > > > > > > > > > freezing the device, the
> > > > > > > > > > interaction with the virtio device status state machine.
> > > > > > > > > Device state state can be large so a register interface w=
ould be a
> > > > > > > > > bottleneck. DMA is needed. I think a virtqueue is a good =
fit for
> > > > > > > > > saving/loading device state.
> > > > > > > > So this patch doesn't mandate a register interface, isn't i=
t?
> > > > > > > You're right, not this patch. I mentioned it because your oth=
er patch
> > > > > > > series ("[PATCH] virtio-pci: implement VIRTIO_F_RING_STATE")
> > > > > > > implements
> > > > > > > it a register interface.
> > > > > > >=20
> > > > > > > > And DMA
> > > > > > > > doesn't means a virtqueue, it could be a transport specific=
 method.
> > > > > > > Yes, although virtqueues are a pretty good interface that wor=
ks across
> > > > > > > transports (PCI/MMIO/etc) thanks to the standard vring memory=
 layout.
> > > > > > >=20
> > > > > > > > I think we need to start from defining the state of one
> > > > > > > > specific device and
> > > > > > > > see what is the best interface.
> > > > > > > virtio-blk might be the simplest. I think virtio-net has more=
 device
> > > > > > > state and virtio-scsi is definitely more complext than virtio=
-blk.
> > > > > > >=20
> > > > > > > First we need agreement on whether "device state" encompasses=
 the full
> > > > > > > state of the device or just state that is unknown to the VMM.
> > > > > > I think we've discussed this in the past. It can't work since:
> > > > > >=20
> > > > > > 1) The state and its format must be clearly defined in the spec
> > > > > > 2) We need to maintain migration compatibility and debug-ability
> > > > > Some devices need implementation-specific state. They should stil=
l be
> > > > > able to live migrate even if it means cross-implementation migrat=
ion and
> > > > > debug-ability is not possible.
> > > >=20
> > > > I think we need to re-visit this conclusion. Migration compatibilit=
y is
> > > > pretty important, especially consider the software stack has spent a
> > > > huge mount of effort in maintaining them.
> > > >=20
> > > > Say a virtio hardware would break this, this mean we will lose all =
the
> > > > advantages of being a standard device.
> > > >=20
> > > > If we can't do live migration among:
> > > >=20
> > > > 1) different backends, e.g migrate from virtio hardware to migrate
> > > > software
> > > > 2) different vendors
> > > >=20
> > > > We failed to say as a standard device and the customer is in fact l=
ocked
> > > > by the vendor implicitly.
> > > >=20
> > > >=20
> > > > > > 3) Not a proper uAPI desgin
> > > > > I never understood this argument. The Linux uAPI passes through l=
ots of
> > > > > opaque data from devices to userspace. Allowing an
> > > > > implementation-specific device state representation is nothing ne=
w. VFIO
> > > > > already does it.
> > > >=20
> > > > I think we've already had a lots of discussion for VFIO but without=
 a
> > > > conclusion. Maybe we need the verdict from Linus or Greg (not sure =
if
> > > > it's too late). But that's not related to virito and this thread.
> > > >=20
> > > > What you propose here is kind of conflict with the efforts of virti=
o. I
> > > > think we all aggree that we should define the state in the spec.
> > > > Assuming this is correct:
> > > >=20
> > > > 1) why do we still offer opaque migration state to userspace?
> > > > 2) how can it be integrated into the current VMM (Qemu) virtio devi=
ces'
> > > > migration bytes stream?
> > > >=20
> > > > We should standardize everything that is visible by the driver to b=
e a
> > > > standard device. That's the power of virtio.
> > > >=20
> > > >=20
> > > > > > > That's
> > > > > > > basically the difference between the vhost/vDPA's selective
> > > > > > > passthrough
> > > > > > > approach and VFIO's full passthrough approach.
> > > > > > We can't do VFIO full pasthrough for migration anyway, some kind
> > > > > > of mdev is
> > > > > > required but it's duplicated with the current vp_vdpa driver.
> > > > > I'm not sure that's true. Generic VFIO PCI migration can probably=
 be
> > > > > achieved without mdev:
> > > > > 1. Define a migration PCI Capability that indicates support for
> > > > >  =C2=A0=C2=A0=C2=A0 VFIO_REGION_TYPE_MIGRATION. This allows the P=
CI device to implement
> > > > >  =C2=A0=C2=A0=C2=A0 the migration interface in hardware instead o=
f an mdev driver.
> > > >=20
> > > > So I think it still depend on the driver to implement migrate state
> > > > which is vendor specific.
> > > >=20
> > > > Note that it's just an uAPI definition not something defined in the=
 PCI
> > > > spec.
> > > >=20
> > > > Out of curiosity, the patch is merged without any real users in the
> > > > Linux. This is very bad since we lose the change to audit the whole
> > > > design.
> > > >=20
> > > >=20
> > > > > 2. The VMM either uses the migration PCI Capability directly from
> > > > >  =C2=A0=C2=A0=C2=A0 userspace or core VFIO PCI code advertises
> > > > > VFIO_REGION_TYPE_MIGRATION
> > > > >  =C2=A0=C2=A0=C2=A0 to userspace so migration can proceed in the =
same way as with
> > > > >  =C2=A0=C2=A0=C2=A0 VFIO/mdev drivers.
> > > > > 3. The PCI Capability is not passed through to the guest.
> > > >=20
> > > > This brings troubles in the nested environment.
> > > >=20
> > > > Thanks
> > > >=20
> > > >=20
> > > > > Changpeng Liu originally mentioned the idea of defining a migrati=
on PCI
> > > > > Capability.
> > > > >=20
> > > > > > >  =C2=A0=C2=A0 For example, some of the
> > > > > > > virtio-net state is available to the VMM with vhost/vDPA beca=
use it
> > > > > > > intercepts the virtio-net control virtqueue.
> > > > > > >=20
> > > > > > > Also, we need to decide to what degree the device state repre=
sentation
> > > > > > > is standardized in the VIRTIO specification.
> > > > > > I think all the states must be defined in the spec otherwise th=
e device
> > > > > > can't claim it supports migration at virtio level.
> > > > > >=20
> > > > > >=20
> > > > > > >  =C2=A0=C2=A0 I think it makes sense to
> > > > > > > standardize it if it's possible to convey all necessary
> > > > > > > state and device
> > > > > > > implementors can easily implement this device state represent=
ation.
> > > > > > I doubt it's high device specific. E.g can we standardize devic=
e(GPU)
> > > > > > memory?
> > > > > For devices that have little internal state it's possible to defi=
ne a
> > > > > standard device state representation.
> > > > >=20
> > > > > For other devices, like virtio-crypto, virtio-fs, etc it becomes
> > > > > difficult because the device implementation contains state that w=
ill be
> > > > > needed but is very specific to the implementation. These devices =
*are*
> > > > > migratable but they don't have standard state. Even here there is=
 a
> > > > > spectrum:
> > > > > - Host OS-specific state (e.g. Linux struct file_handles)
> > > > > - Library-specific state (e.g. crypto library state)
> > > > > - Implementation-specific state (e.g. sshfs inode state for virti=
o-fs)
> > > > >=20
> > > > > This is why I think it's necessary to support both standard devic=
e state
> > > > > representations and implementation-specific device state
> > > > > representations.
> > >=20
> > > Having two ways will bring extra complexity. That why I suggest:
> > >=20
> > > - to have general facility for the virtuqueue to be migrated
> > > - leave the device specific state to be device specific. so device can
> > > choose what is convenient way or interface.
> > I don't think we have a choice. For stateful devices it can be
> > impossible to define a standard device state representation.
>=20
>=20
> Let me clarify, I agree we can't have a standard device state for all kin=
ds
> of device.
>=20
> That's way I tend to leave them to be device specific. (but not
> implementation specific)

Unfortunately device state is sometimes implementation-specific. Not
because the device is proprietary, but because the actual state is
meaningless to other implementations.

I mentioned virtiofs as an example where file system backends can be
implemented in completely different ways so the device state cannot be
migrated between implementations.

> But we can generalize the virtqueue state for sure.

I agree and also that some device types can standardize their device
state representations. But I think it's a technical requirement to
support implementation-specific state for device types where
cross-implementation migration is not possible.

I'm not saying the implementation-specific state representation has to
be a binary blob. There could be an identifier registry to ensure live
migration compatibility checks can be performed. There could also be a
standard binary encoding for migration data. But the contents will be
implementation-specific for some devices.

Stefan

--gPEOQjn/pGskjbux
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmD2jmEACgkQnKSrs4Gr
c8i9NQgAsYjGEVODxe6I7KBRbl3QEhxy2UoSpESfwOew6EzxeYwLx6ovMHTzbWjV
EZkCjbOk4elDHRlrpmPprPmJYUuZahlUd313uuajw46vDMZ0w0hAbSE29oYvz8Tp
Usf4Aa3rCi66XRF1ZHybvNnMHAl+saDkn/nI6QzmT8hqt92DSGt2H0G0Y1uY1QHT
ZIi/XWOF6palbjQhTxFo3XzeY8oi0OEwQM7HTjV8An3reWQ/epJmf/ZvmaDRYCkR
ZTKHi5JzylcXmJ63IwcFgO1niGn/bk2YgZ70lE800mJs6NAQCCBAFXENXPDPdbra
/P9N/ek2Pex2lpzugxFP2uVHMp2nJw==
=2lJw
-----END PGP SIGNATURE-----

--gPEOQjn/pGskjbux--

