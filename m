Return-Path: <stefanha@redhat.com>
Date: Mon, 19 Jul 2021 13:43:28 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [virtio-comment] [PATCH V2 2/2] virtio: introduce STOP status bit
Message-ID: <YPVzcLGj591X37fX@stefanha-x1.localdomain>
References: <YOwSGeL+lfTxHuXg@stefanha-x1.localdomain>
 <3ce9775c-64fa-1c9b-6627-55f3b18ac987@redhat.com>
 <YO1kQ8sBkr2eguvi@stefanha-x1.localdomain>
 <8a2037df-e527-dcb4-c4c8-a568885180e4@redhat.com>
 <YO60HpxfZnmfMCMj@stefanha-x1.localdomain>
 <094e15d4-169a-87e9-5ebb-93439ea72831@redhat.com>
 <YO79tuI72kTEWURN@stefanha-x1.localdomain>
 <1ab19438-cc13-bbe5-7fec-53a113d85463@redhat.com>
 <YPAHcG7bxhlIGVeE@stefanha-x1.localdomain>
 <c626c856-7010-0df6-131f-00aad7221266@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qf0sOlOv8dDbAmr2"
Content-Disposition: inline
In-Reply-To: <c626c856-7010-0df6-131f-00aad7221266@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Eugenio Perez Martin <eperezma@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, virtio-comment@lists.oasis-open.org, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Max Gurtovoy <mgurtovoy@nvidia.com>, Cornelia Huck <cohuck@redhat.com>, Oren Duer <oren@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Bodong Wang <bodong@nvidia.com>, Alexander Mikheev <amikheev@nvidia.com>, Halil Pasic <pasic@linux.ibm.com>
List-ID: <virtio-dev.lists.oasis-open.org>


--qf0sOlOv8dDbAmr2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 16, 2021 at 10:03:17AM +0800, Jason Wang wrote:
>=20
> =E5=9C=A8 2021/7/15 =E4=B8=8B=E5=8D=886:01, Stefan Hajnoczi =E5=86=99=E9=
=81=93:
> > On Thu, Jul 15, 2021 at 09:35:13AM +0800, Jason Wang wrote:
> > > =E5=9C=A8 2021/7/14 =E4=B8=8B=E5=8D=8811:07, Stefan Hajnoczi =E5=86=
=99=E9=81=93:
> > > > On Wed, Jul 14, 2021 at 06:29:28PM +0800, Jason Wang wrote:
> > > > > =E5=9C=A8 2021/7/14 =E4=B8=8B=E5=8D=885:53, Stefan Hajnoczi =E5=
=86=99=E9=81=93:
> > > > > > On Tue, Jul 13, 2021 at 08:16:35PM +0800, Jason Wang wrote:
> > > > > > > =E5=9C=A8 2021/7/13 =E4=B8=8B=E5=8D=886:00, Stefan Hajnoczi =
=E5=86=99=E9=81=93:
> > > > > > > > On Tue, Jul 13, 2021 at 11:27:03AM +0800, Jason Wang wrote:
> > > > > > > > > =E5=9C=A8 2021/7/12 =E4=B8=8B=E5=8D=885:57, Stefan Hajnoc=
zi =E5=86=99=E9=81=93:
> > > > > > > > > > On Mon, Jul 12, 2021 at 12:00:39PM +0800, Jason Wang wr=
ote:
> > > > > > > > > > > =E5=9C=A8 2021/7/11 =E4=B8=8A=E5=8D=884:36, Michael S=
=2E Tsirkin =E5=86=99=E9=81=93:
> > > > > > > > > > > > On Fri, Jul 09, 2021 at 07:23:33PM +0200, Eugenio P=
erez Martin wrote:
> > > > > > > > > > > > > > >         If I understand correctly, this is all
> > > > > > > > > > > > > > > driven from the driver inside the guest, so f=
or this to work
> > > > > > > > > > > > > > > the guest must be running and already have in=
itialised the driver.
> > > > > > > > > > > > > > Yes.
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > As I see it, the feature can be driven entirely b=
y the VMM as long as
> > > > > > > > > > > > > it intercept the relevant configuration space (PC=
I, MMIO, etc) from
> > > > > > > > > > > > > guest's reads and writes, and present it as coher=
ent and transparent
> > > > > > > > > > > > > for the guest. Some use cases I can imagine with =
a physical device (or
> > > > > > > > > > > > > vp_vpda device) with VIRTIO_F_STOP:
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > 1) The VMM chooses not to pass the feature flag. =
The guest cannot stop
> > > > > > > > > > > > > the device, so any write to this flag is an error=
/undefined.
> > > > > > > > > > > > > 2) The VMM passes the flag to the guest. The gues=
t can stop the device.
> > > > > > > > > > > > > 2.1) The VMM stops the device to perform a live m=
igration, and the
> > > > > > > > > > > > > guest does not write to STOP in any moment of the=
 LM. It resets the
> > > > > > > > > > > > > destination device with the state, and then initi=
alizes the device.
> > > > > > > > > > > > > 2.2) The guest stops the device and, when STOP(32=
) is set, the source
> > > > > > > > > > > > > VMM migrates the device status. The destination V=
MM realizes the bit,
> > > > > > > > > > > > > so it sets the bit in the destination too after d=
evice initialization.
> > > > > > > > > > > > > 2.3) The device is not initialized by the guest s=
o it doesn't matter
> > > > > > > > > > > > > what bit has the HW, but the VM can be migrated.
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > Am I missing something?
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > Thanks!
> > > > > > > > > > > > It's doable like this. It's all a lot of hoops to j=
ump through though.
> > > > > > > > > > > > It's also not easy for devices to implement.
> > > > > > > > > > > It just requires a new status bit. Anything that make=
s you think it's hard
> > > > > > > > > > > to implement?
> > > > > > > > > > >=20
> > > > > > > > > > > E.g for networking device, it should be sufficient to=
 use this bit + the
> > > > > > > > > > > virtqueue state.
> > > > > > > > > > >=20
> > > > > > > > > > >=20
> > > > > > > > > > > > Why don't we design the feature in a way that is us=
eable by VMMs
> > > > > > > > > > > > and implementable by devices in a simple way?
> > > > > > > > > > > It use the common technology like register shadowing =
without any further
> > > > > > > > > > > stuffs.
> > > > > > > > > > >=20
> > > > > > > > > > > Or do you have any other ideas?
> > > > > > > > > > >=20
> > > > > > > > > > > (I think we all know migration will be very hard if w=
e simply pass through
> > > > > > > > > > > those state registers).
> > > > > > > > > > If an admin virtqueue is used instead of the STOP Devic=
e Status field
> > > > > > > > > > bit then there's no need to re-read the Device Status f=
ield in a loop
> > > > > > > > > > until the device has stopped.
> > > > > > > > > Probably not. Let me to clarify several points:
> > > > > > > > >=20
> > > > > > > > > - This proposal has nothing to do with admin virtqueue. A=
ctually, admin
> > > > > > > > > virtqueue could be used for carrying any basic device fac=
ility like status
> > > > > > > > > bit. E.g I'm going to post patches that use admin virtque=
ue as a "transport"
> > > > > > > > > for device slicing at virtio level.
> > > > > > > > > - Even if we had introduced admin virtqueue, we still nee=
d a per function
> > > > > > > > > interface for this. This is a must for nested virtualizat=
ion, we can't
> > > > > > > > > always expect things like PF can be assigned to L1 guest.
> > > > > > > > > - According to the proposal, there's no need for the devi=
ce to complete all
> > > > > > > > > the consumed buffers, device can choose to expose those i=
nflight descriptors
> > > > > > > > > in a device specific way and set the STOP bit. This means=
, if we have the
> > > > > > > > > device specific in-flight descriptor reporting facility, =
the device can
> > > > > > > > > almost set the STOP bit immediately.
> > > > > > > > > - If we don't go with the basic device facility but using=
 the admin
> > > > > > > > > virtqueue specific method, we still need to clarify how i=
t works with the
> > > > > > > > > device status state machine, it will be some kind of sub-=
states which looks
> > > > > > > > > much more complicated than the current proposal.
> > > > > > > > >=20
> > > > > > > > >=20
> > > > > > > > > > When migrating a guest with many VIRTIO devices a busy =
waiting approach
> > > > > > > > > > extends downtime if implemented sequentially (stopping =
one device at a
> > > > > > > > > > time).
> > > > > > > > > Well. You need some kinds of waiting for sure, the device=
/DMA needs sometime
> > > > > > > > > to be stopped. The downtime is determined by a specific v=
irtio
> > > > > > > > > implementation which is hard to be restricted at the spec=
 level. We can
> > > > > > > > > clarify that the device must set the STOP bit in e.g 100m=
s.
> > > > > > > > >=20
> > > > > > > > >=20
> > > > > > > > > >       It can be implemented concurrently (setting the S=
TOP bit on all
> > > > > > > > > > devices and then looping until all their Device Status =
fields have the
> > > > > > > > > > bit set), but this becomes more complex to implement.
> > > > > > > > > I still don't get what kind of complexity did you worry h=
ere.
> > > > > > > > >=20
> > > > > > > > >=20
> > > > > > > > > > I'm a little worried about adding a new bit that requir=
es busy
> > > > > > > > > > waiting...
> > > > > > > > > Busy wait is not something that is introduced in this pat=
ch:
> > > > > > > > >=20
> > > > > > > > > 4.1.4.3.2 Driver Requirements: Common configuration struc=
ture layout
> > > > > > > > >=20
> > > > > > > > > After writing 0 to device_status, the driver MUST wait fo=
r a read of
> > > > > > > > > device_status to return 0 before reinitializing the devic=
e.
> > > > > > > > >=20
> > > > > > > > > Since it was required for at least one transport. We need=
 do something
> > > > > > > > > similar to when introducing basic facility.
> > > > > > > > Adding the STOP but as a Device Status bit is a small and c=
lean VIRTIO
> > > > > > > > spec change. I like that.
> > > > > > > >=20
> > > > > > > > On the other hand, devices need time to stop and that time =
can be
> > > > > > > > unbounded. For example, software virtio-blk/scsi implementa=
tions since
> > > > > > > > cannot immediately cancel in-flight I/O requests on Linux h=
osts.
> > > > > > > >=20
> > > > > > > > The natural interface for long-running operations is virtqu=
eue requests.
> > > > > > > > That's why I mentioned the alternative of using an admin vi=
rtqueue
> > > > > > > > instead of a Device Status bit.
> > > > > > > So I'm not against the admin virtqueue. As said before, admin=
 virtqueue
> > > > > > > could be used for carrying the device status bit.
> > > > > > >=20
> > > > > > > Send a command to set STOP status bit to admin virtqueue. Dev=
ice will make
> > > > > > > the command buffer used after it has successfully stopped the=
 device.
> > > > > > >=20
> > > > > > > AFAIK, they are not mutually exclusive, since they are trying=
 to solve
> > > > > > > different problems.
> > > > > > >=20
> > > > > > > Device status - basic device facility
> > > > > > >=20
> > > > > > > Admin virtqueue - transport/device specific way to implement =
(part of) the
> > > > > > > device facility
> > > > > > >=20
> > > > > > > > Although you mentioned that the stopped state needs to be r=
eflected in
> > > > > > > > the Device Status field somehow, I'm not sure about that si=
nce the
> > > > > > > > driver typically doesn't need to know whether the device is=
 being
> > > > > > > > migrated.
> > > > > > > The guest won't see the real device status bit. VMM will shad=
ow the device
> > > > > > > status bit in this case.
> > > > > > >=20
> > > > > > > E.g with the current vhost-vDPA, vDPA behave like a vhost dev=
ice, guest is
> > > > > > > unaware of the migration.
> > > > > > >=20
> > > > > > > STOP status bit is set by Qemu to real virtio hardware. But g=
uest will only
> > > > > > > see the DRIVER_OK without STOP.
> > > > > > >=20
> > > > > > > It's not hard to implement the nested on top, see the discuss=
ion initiated
> > > > > > > by Eugenio about how expose VIRTIO_F_STOP to guest for nested=
 live
> > > > > > > migration.
> > > > > > >=20
> > > > > > >=20
> > > > > > > >      In fact, the VMM would need to hide this bit and it's =
safer to
> > > > > > > > keep it out-of-band instead of risking exposing it by accid=
ent.
> > > > > > > See above, VMM may choose to hide or expose the capability. I=
t's useful for
> > > > > > > migrating a nested guest.
> > > > > > >=20
> > > > > > > If we design an interface that can be used in the nested envi=
ronment, it's
> > > > > > > not an ideal interface.
> > > > > > >=20
> > > > > > >=20
> > > > > > > > In addition, stateful devices need to load/save non-trivial=
 amounts of
> > > > > > > > data. They need DMA to do this efficiently, so an admin vir=
tqueue is a
> > > > > > > > good fit again.
> > > > > > > I don't get the point here. You still need to address the exa=
ct the similar
> > > > > > > issues for admin virtqueue: the unbound time in freezing the =
device, the
> > > > > > > interaction with the virtio device status state machine.
> > > > > > Device state state can be large so a register interface would b=
e a
> > > > > > bottleneck. DMA is needed. I think a virtqueue is a good fit for
> > > > > > saving/loading device state.
> > > > > So this patch doesn't mandate a register interface, isn't it?
> > > > You're right, not this patch. I mentioned it because your other pat=
ch
> > > > series ("[PATCH] virtio-pci: implement VIRTIO_F_RING_STATE") implem=
ents
> > > > it a register interface.
> > > >=20
> > > > > And DMA
> > > > > doesn't means a virtqueue, it could be a transport specific metho=
d.
> > > > Yes, although virtqueues are a pretty good interface that works acr=
oss
> > > > transports (PCI/MMIO/etc) thanks to the standard vring memory layou=
t.
> > > >=20
> > > > > I think we need to start from defining the state of one specific =
device and
> > > > > see what is the best interface.
> > > > virtio-blk might be the simplest. I think virtio-net has more device
> > > > state and virtio-scsi is definitely more complext than virtio-blk.
> > > >=20
> > > > First we need agreement on whether "device state" encompasses the f=
ull
> > > > state of the device or just state that is unknown to the VMM.
> > >=20
> > > I think we've discussed this in the past. It can't work since:
> > >=20
> > > 1) The state and its format must be clearly defined in the spec
> > > 2) We need to maintain migration compatibility and debug-ability
> > Some devices need implementation-specific state. They should still be
> > able to live migrate even if it means cross-implementation migration and
> > debug-ability is not possible.
>=20
>=20
> I think we need to re-visit this conclusion. Migration compatibility is
> pretty important, especially consider the software stack has spent a huge
> mount of effort in maintaining them.
>=20
> Say a virtio hardware would break this, this mean we will lose all the
> advantages of being a standard device.
>=20
> If we can't do live migration among:
>=20
> 1) different backends, e.g migrate from virtio hardware to migrate softwa=
re
> 2) different vendors
>=20
> We failed to say as a standard device and the customer is in fact locked =
by
> the vendor implicitly.

My virtiofs device implementation is backed by an in-memory file system.
The device state includes the contents of each file.

Your virtiofs device implementation uses Linux file handles to keep
track of open files. The device state includes Linux file handles (but
not the contents of each file) so the destination host can access the
same files on shared storage.

Cornelia's virtiofs device implementation is backed by an object storage
HTTP API. The device state includes API object IDs.

The device state is implementation-dependent. There is no standard
representation and it's not possible to migrate between device
implementations. How are they supposed to migrate?

This is why I think it's necessarily to allow implementation-specific
device state representations.

> >=20
> > > 3) Not a proper uAPI desgin
> > I never understood this argument. The Linux uAPI passes through lots of
> > opaque data from devices to userspace. Allowing an
> > implementation-specific device state representation is nothing new. VFIO
> > already does it.
>=20
>=20
> I think we've already had a lots of discussion for VFIO but without a
> conclusion. Maybe we need the verdict from Linus or Greg (not sure if it's
> too late). But that's not related to virito and this thread.
>=20
> What you propose here is kind of conflict with the efforts of virtio. I
> think we all aggree that we should define the state in the spec. Assuming
> this is correct:
>=20
> 1) why do we still offer opaque migration state to userspace?

See above. Stateful devices may require an implementation-defined device
state representation.

> 2) how can it be integrated into the current VMM (Qemu) virtio devices'
> migration bytes stream?

Opaque data like D-Bus VMState:
https://qemu.readthedocs.io/en/latest/interop/dbus-vmstate.html

> >=20
> > >=20
> > > > That's
> > > > basically the difference between the vhost/vDPA's selective passthr=
ough
> > > > approach and VFIO's full passthrough approach.
> > >=20
> > > We can't do VFIO full pasthrough for migration anyway, some kind of m=
dev is
> > > required but it's duplicated with the current vp_vdpa driver.
> > I'm not sure that's true. Generic VFIO PCI migration can probably be
> > achieved without mdev:
> > 1. Define a migration PCI Capability that indicates support for
> >     VFIO_REGION_TYPE_MIGRATION. This allows the PCI device to implement
> >     the migration interface in hardware instead of an mdev driver.
>=20
>=20
> So I think it still depend on the driver to implement migrate state which=
 is
> vendor specific.

The current VFIO migration interface depends on a device-specific
software mdev driver but here I'm showing that the physical device can
implement the migration interface so that no device-specific driver code
is needed.

>=20
> Note that it's just an uAPI definition not something defined in the PCI
> spec.

Yes, that's why I mentioned Changpeng Liu's idea to turn the uAPI into a
standard PCI Capability to eliminate the need for device-specific
drivers.

>=20
> Out of curiosity, the patch is merged without any real users in the Linux.
> This is very bad since we lose the change to audit the whole design.

I agree. It would have helped to have a complete vision for how live
migration should work along with demos. I don't see any migration code
in samples/vfio-mdev/ :(.

> > 2. The VMM either uses the migration PCI Capability directly from
> >     userspace or core VFIO PCI code advertises VFIO_REGION_TYPE_MIGRATI=
ON
> >     to userspace so migration can proceed in the same way as with
> >     VFIO/mdev drivers.
> > 3. The PCI Capability is not passed through to the guest.
>=20
>=20
> This brings troubles in the nested environment.

It depends on the device splitting/management design. If L0 wishes to
let L1 manage the VFs then it would need to expose a management device.
Since the migration interface is generic (not device-specific) a generic
management device solves this for all devices.

Stefan

--qf0sOlOv8dDbAmr2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmD1c3AACgkQnKSrs4Gr
c8h3WQf+KtGjCeD0OrACghCPF/79OxFkFwPQv2soGyrU+1lZGLDiyj2+oRUjjsnF
H+qCic51/BZvKDEgTkeRZ3bC7r3DNQ/iPUeOBAk8+eEVvg/CdYBebgVovnPJ1Td0
0RrbXd9bq1qgauxK7IpldBiupBO77aR+/RmoVveJEm1VSGSeQeFjhV9VIZNHMOgg
0gWmSN3kIuoEntiryGtWNCGmtHLRqJ+45baxyaNGweIV/BdlbkbFFYJnCPZkDmUh
EQB9770/CHqgQhxwbkQU2ECsU3GO7ZP7aoVuujNra9DPRHWtjSoTlzxtk7gzMyJ9
eFcSoLKc5L1LPk89pzhx+kJBYlQIKg==
=TsKd
-----END PGP SIGNATURE-----

--qf0sOlOv8dDbAmr2--

