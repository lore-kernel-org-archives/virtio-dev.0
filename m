Return-Path: <stefanha@redhat.com>
Date: Thu, 15 Jul 2021 11:01:20 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [virtio-comment] [PATCH V2 2/2] virtio: introduce STOP status bit
Message-ID: <YPAHcG7bxhlIGVeE@stefanha-x1.localdomain>
References: <20210710163326-mutt-send-email-mst@kernel.org>
 <778ffa63-c0ca-2faa-32da-3c5e71dd1dfe@redhat.com>
 <YOwSGeL+lfTxHuXg@stefanha-x1.localdomain>
 <3ce9775c-64fa-1c9b-6627-55f3b18ac987@redhat.com>
 <YO1kQ8sBkr2eguvi@stefanha-x1.localdomain>
 <8a2037df-e527-dcb4-c4c8-a568885180e4@redhat.com>
 <YO60HpxfZnmfMCMj@stefanha-x1.localdomain>
 <094e15d4-169a-87e9-5ebb-93439ea72831@redhat.com>
 <YO79tuI72kTEWURN@stefanha-x1.localdomain>
 <1ab19438-cc13-bbe5-7fec-53a113d85463@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HjX0A3tSO/Js9qWM"
Content-Disposition: inline
In-Reply-To: <1ab19438-cc13-bbe5-7fec-53a113d85463@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Eugenio Perez Martin <eperezma@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, virtio-comment@lists.oasis-open.org, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Max Gurtovoy <mgurtovoy@nvidia.com>, Cornelia Huck <cohuck@redhat.com>, Oren Duer <oren@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Bodong Wang <bodong@nvidia.com>, Alexander Mikheev <amikheev@nvidia.com>, Halil Pasic <pasic@linux.ibm.com>
List-ID: <virtio-dev.lists.oasis-open.org>


--HjX0A3tSO/Js9qWM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 15, 2021 at 09:35:13AM +0800, Jason Wang wrote:
>=20
> =E5=9C=A8 2021/7/14 =E4=B8=8B=E5=8D=8811:07, Stefan Hajnoczi =E5=86=99=E9=
=81=93:
> > On Wed, Jul 14, 2021 at 06:29:28PM +0800, Jason Wang wrote:
> > > =E5=9C=A8 2021/7/14 =E4=B8=8B=E5=8D=885:53, Stefan Hajnoczi =E5=86=99=
=E9=81=93:
> > > > On Tue, Jul 13, 2021 at 08:16:35PM +0800, Jason Wang wrote:
> > > > > =E5=9C=A8 2021/7/13 =E4=B8=8B=E5=8D=886:00, Stefan Hajnoczi =E5=
=86=99=E9=81=93:
> > > > > > On Tue, Jul 13, 2021 at 11:27:03AM +0800, Jason Wang wrote:
> > > > > > > =E5=9C=A8 2021/7/12 =E4=B8=8B=E5=8D=885:57, Stefan Hajnoczi =
=E5=86=99=E9=81=93:
> > > > > > > > On Mon, Jul 12, 2021 at 12:00:39PM +0800, Jason Wang wrote:
> > > > > > > > > =E5=9C=A8 2021/7/11 =E4=B8=8A=E5=8D=884:36, Michael S. Ts=
irkin =E5=86=99=E9=81=93:
> > > > > > > > > > On Fri, Jul 09, 2021 at 07:23:33PM +0200, Eugenio Perez=
 Martin wrote:
> > > > > > > > > > > > >        If I understand correctly, this is all
> > > > > > > > > > > > > driven from the driver inside the guest, so for t=
his to work
> > > > > > > > > > > > > the guest must be running and already have initia=
lised the driver.
> > > > > > > > > > > > Yes.
> > > > > > > > > > > >=20
> > > > > > > > > > > As I see it, the feature can be driven entirely by th=
e VMM as long as
> > > > > > > > > > > it intercept the relevant configuration space (PCI, M=
MIO, etc) from
> > > > > > > > > > > guest's reads and writes, and present it as coherent =
and transparent
> > > > > > > > > > > for the guest. Some use cases I can imagine with a ph=
ysical device (or
> > > > > > > > > > > vp_vpda device) with VIRTIO_F_STOP:
> > > > > > > > > > >=20
> > > > > > > > > > > 1) The VMM chooses not to pass the feature flag. The =
guest cannot stop
> > > > > > > > > > > the device, so any write to this flag is an error/und=
efined.
> > > > > > > > > > > 2) The VMM passes the flag to the guest. The guest ca=
n stop the device.
> > > > > > > > > > > 2.1) The VMM stops the device to perform a live migra=
tion, and the
> > > > > > > > > > > guest does not write to STOP in any moment of the LM.=
 It resets the
> > > > > > > > > > > destination device with the state, and then initializ=
es the device.
> > > > > > > > > > > 2.2) The guest stops the device and, when STOP(32) is=
 set, the source
> > > > > > > > > > > VMM migrates the device status. The destination VMM r=
ealizes the bit,
> > > > > > > > > > > so it sets the bit in the destination too after devic=
e initialization.
> > > > > > > > > > > 2.3) The device is not initialized by the guest so it=
 doesn't matter
> > > > > > > > > > > what bit has the HW, but the VM can be migrated.
> > > > > > > > > > >=20
> > > > > > > > > > > Am I missing something?
> > > > > > > > > > >=20
> > > > > > > > > > > Thanks!
> > > > > > > > > > It's doable like this. It's all a lot of hoops to jump =
through though.
> > > > > > > > > > It's also not easy for devices to implement.
> > > > > > > > > It just requires a new status bit. Anything that makes yo=
u think it's hard
> > > > > > > > > to implement?
> > > > > > > > >=20
> > > > > > > > > E.g for networking device, it should be sufficient to use=
 this bit + the
> > > > > > > > > virtqueue state.
> > > > > > > > >=20
> > > > > > > > >=20
> > > > > > > > > > Why don't we design the feature in a way that is useabl=
e by VMMs
> > > > > > > > > > and implementable by devices in a simple way?
> > > > > > > > > It use the common technology like register shadowing with=
out any further
> > > > > > > > > stuffs.
> > > > > > > > >=20
> > > > > > > > > Or do you have any other ideas?
> > > > > > > > >=20
> > > > > > > > > (I think we all know migration will be very hard if we si=
mply pass through
> > > > > > > > > those state registers).
> > > > > > > > If an admin virtqueue is used instead of the STOP Device St=
atus field
> > > > > > > > bit then there's no need to re-read the Device Status field=
 in a loop
> > > > > > > > until the device has stopped.
> > > > > > > Probably not. Let me to clarify several points:
> > > > > > >=20
> > > > > > > - This proposal has nothing to do with admin virtqueue. Actua=
lly, admin
> > > > > > > virtqueue could be used for carrying any basic device facilit=
y like status
> > > > > > > bit. E.g I'm going to post patches that use admin virtqueue a=
s a "transport"
> > > > > > > for device slicing at virtio level.
> > > > > > > - Even if we had introduced admin virtqueue, we still need a =
per function
> > > > > > > interface for this. This is a must for nested virtualization,=
 we can't
> > > > > > > always expect things like PF can be assigned to L1 guest.
> > > > > > > - According to the proposal, there's no need for the device t=
o complete all
> > > > > > > the consumed buffers, device can choose to expose those infli=
ght descriptors
> > > > > > > in a device specific way and set the STOP bit. This means, if=
 we have the
> > > > > > > device specific in-flight descriptor reporting facility, the =
device can
> > > > > > > almost set the STOP bit immediately.
> > > > > > > - If we don't go with the basic device facility but using the=
 admin
> > > > > > > virtqueue specific method, we still need to clarify how it wo=
rks with the
> > > > > > > device status state machine, it will be some kind of sub-stat=
es which looks
> > > > > > > much more complicated than the current proposal.
> > > > > > >=20
> > > > > > >=20
> > > > > > > > When migrating a guest with many VIRTIO devices a busy wait=
ing approach
> > > > > > > > extends downtime if implemented sequentially (stopping one =
device at a
> > > > > > > > time).
> > > > > > > Well. You need some kinds of waiting for sure, the device/DMA=
 needs sometime
> > > > > > > to be stopped. The downtime is determined by a specific virtio
> > > > > > > implementation which is hard to be restricted at the spec lev=
el. We can
> > > > > > > clarify that the device must set the STOP bit in e.g 100ms.
> > > > > > >=20
> > > > > > >=20
> > > > > > > >      It can be implemented concurrently (setting the STOP b=
it on all
> > > > > > > > devices and then looping until all their Device Status fiel=
ds have the
> > > > > > > > bit set), but this becomes more complex to implement.
> > > > > > > I still don't get what kind of complexity did you worry here.
> > > > > > >=20
> > > > > > >=20
> > > > > > > > I'm a little worried about adding a new bit that requires b=
usy
> > > > > > > > waiting...
> > > > > > > Busy wait is not something that is introduced in this patch:
> > > > > > >=20
> > > > > > > 4.1.4.3.2 Driver Requirements: Common configuration structure=
 layout
> > > > > > >=20
> > > > > > > After writing 0 to device_status, the driver MUST wait for a =
read of
> > > > > > > device_status to return 0 before reinitializing the device.
> > > > > > >=20
> > > > > > > Since it was required for at least one transport. We need do =
something
> > > > > > > similar to when introducing basic facility.
> > > > > > Adding the STOP but as a Device Status bit is a small and clean=
 VIRTIO
> > > > > > spec change. I like that.
> > > > > >=20
> > > > > > On the other hand, devices need time to stop and that time can =
be
> > > > > > unbounded. For example, software virtio-blk/scsi implementation=
s since
> > > > > > cannot immediately cancel in-flight I/O requests on Linux hosts.
> > > > > >=20
> > > > > > The natural interface for long-running operations is virtqueue =
requests.
> > > > > > That's why I mentioned the alternative of using an admin virtqu=
eue
> > > > > > instead of a Device Status bit.
> > > > > So I'm not against the admin virtqueue. As said before, admin vir=
tqueue
> > > > > could be used for carrying the device status bit.
> > > > >=20
> > > > > Send a command to set STOP status bit to admin virtqueue. Device =
will make
> > > > > the command buffer used after it has successfully stopped the dev=
ice.
> > > > >=20
> > > > > AFAIK, they are not mutually exclusive, since they are trying to =
solve
> > > > > different problems.
> > > > >=20
> > > > > Device status - basic device facility
> > > > >=20
> > > > > Admin virtqueue - transport/device specific way to implement (par=
t of) the
> > > > > device facility
> > > > >=20
> > > > > > Although you mentioned that the stopped state needs to be refle=
cted in
> > > > > > the Device Status field somehow, I'm not sure about that since =
the
> > > > > > driver typically doesn't need to know whether the device is bei=
ng
> > > > > > migrated.
> > > > > The guest won't see the real device status bit. VMM will shadow t=
he device
> > > > > status bit in this case.
> > > > >=20
> > > > > E.g with the current vhost-vDPA, vDPA behave like a vhost device,=
 guest is
> > > > > unaware of the migration.
> > > > >=20
> > > > > STOP status bit is set by Qemu to real virtio hardware. But guest=
 will only
> > > > > see the DRIVER_OK without STOP.
> > > > >=20
> > > > > It's not hard to implement the nested on top, see the discussion =
initiated
> > > > > by Eugenio about how expose VIRTIO_F_STOP to guest for nested live
> > > > > migration.
> > > > >=20
> > > > >=20
> > > > > >     In fact, the VMM would need to hide this bit and it's safer=
 to
> > > > > > keep it out-of-band instead of risking exposing it by accident.
> > > > > See above, VMM may choose to hide or expose the capability. It's =
useful for
> > > > > migrating a nested guest.
> > > > >=20
> > > > > If we design an interface that can be used in the nested environm=
ent, it's
> > > > > not an ideal interface.
> > > > >=20
> > > > >=20
> > > > > > In addition, stateful devices need to load/save non-trivial amo=
unts of
> > > > > > data. They need DMA to do this efficiently, so an admin virtque=
ue is a
> > > > > > good fit again.
> > > > > I don't get the point here. You still need to address the exact t=
he similar
> > > > > issues for admin virtqueue: the unbound time in freezing the devi=
ce, the
> > > > > interaction with the virtio device status state machine.
> > > > Device state state can be large so a register interface would be a
> > > > bottleneck. DMA is needed. I think a virtqueue is a good fit for
> > > > saving/loading device state.
> > >=20
> > > So this patch doesn't mandate a register interface, isn't it?
> > You're right, not this patch. I mentioned it because your other patch
> > series ("[PATCH] virtio-pci: implement VIRTIO_F_RING_STATE") implements
> > it a register interface.
> >=20
> > > And DMA
> > > doesn't means a virtqueue, it could be a transport specific method.
> > Yes, although virtqueues are a pretty good interface that works across
> > transports (PCI/MMIO/etc) thanks to the standard vring memory layout.
> >=20
> > > I think we need to start from defining the state of one specific devi=
ce and
> > > see what is the best interface.
> > virtio-blk might be the simplest. I think virtio-net has more device
> > state and virtio-scsi is definitely more complext than virtio-blk.
> >=20
> > First we need agreement on whether "device state" encompasses the full
> > state of the device or just state that is unknown to the VMM.
>=20
>=20
> I think we've discussed this in the past. It can't work since:
>=20
> 1) The state and its format must be clearly defined in the spec
> 2) We need to maintain migration compatibility and debug-ability

Some devices need implementation-specific state. They should still be
able to live migrate even if it means cross-implementation migration and
debug-ability is not possible.

> 3) Not a proper uAPI desgin

I never understood this argument. The Linux uAPI passes through lots of
opaque data from devices to userspace. Allowing an
implementation-specific device state representation is nothing new. VFIO
already does it.

>=20
>=20
> > That's
> > basically the difference between the vhost/vDPA's selective passthrough
> > approach and VFIO's full passthrough approach.
>=20
>=20
> We can't do VFIO full pasthrough for migration anyway, some kind of mdev =
is
> required but it's duplicated with the current vp_vdpa driver.

I'm not sure that's true. Generic VFIO PCI migration can probably be
achieved without mdev:
1. Define a migration PCI Capability that indicates support for
   VFIO_REGION_TYPE_MIGRATION. This allows the PCI device to implement
   the migration interface in hardware instead of an mdev driver.
2. The VMM either uses the migration PCI Capability directly from
   userspace or core VFIO PCI code advertises VFIO_REGION_TYPE_MIGRATION
   to userspace so migration can proceed in the same way as with
   VFIO/mdev drivers.
3. The PCI Capability is not passed through to the guest.

Changpeng Liu originally mentioned the idea of defining a migration PCI
Capability.

> >   For example, some of the
> > virtio-net state is available to the VMM with vhost/vDPA because it
> > intercepts the virtio-net control virtqueue.
> >=20
> > Also, we need to decide to what degree the device state representation
> > is standardized in the VIRTIO specification.
>=20
>=20
> I think all the states must be defined in the spec otherwise the device
> can't claim it supports migration at virtio level.
>=20
>=20
> >   I think it makes sense to
> > standardize it if it's possible to convey all necessary state and device
> > implementors can easily implement this device state representation.
>=20
>=20
> I doubt it's high device specific. E.g can we standardize device(GPU)
> memory?

For devices that have little internal state it's possible to define a
standard device state representation.

For other devices, like virtio-crypto, virtio-fs, etc it becomes
difficult because the device implementation contains state that will be
needed but is very specific to the implementation. These devices *are*
migratable but they don't have standard state. Even here there is a
spectrum:
- Host OS-specific state (e.g. Linux struct file_handles)
- Library-specific state (e.g. crypto library state)
- Implementation-specific state (e.g. sshfs inode state for virtio-fs)

This is why I think it's necessary to support both standard device state
representations and implementation-specific device state
representations.

> > If
> > not, then device implementation-specific device state would be needed.
>=20
>=20
> Yes.
>=20
>=20
> >=20
> > I think that's a larger discussion that deserves its own email thread.
>=20
>=20
> I agree, but it doesn't prevent us from starting from simple device that
> virtqueue state is sufficient (e.g virtio-net).

Right, stateless devices don't need to save/load device state, at least
when virtqueues are passed through selectively instead of full
passsthrough.

Stefan

--HjX0A3tSO/Js9qWM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmDwB3AACgkQnKSrs4Gr
c8gmWAgAmEhuJcDJm9yVpAjtv3Sr+XFlCqXD+Rwt95KAPFMduN2D43EiC+mWGTX4
LcRSnq9eQeTABQBhpuL7rdtiUy8TNWdCNwsEyhVgPeAokNtPtNV494rWPcvi9/b2
ZWr6QijZeFpfXNhQK9y6/86zPP9N2n9rnoxPfxsZFvR9o7HKBaoqbR9Eu0M7hNYG
6LYhPfRRJhRnNqZ2dJYvzta4PmZ4XYRmJzpxd59u51YtYL+6FTKRgSo3Cegl/aEQ
eT7CbMp2s8YraJc94rhioiuVhUC/Zb00Jk1iG7t0cj0qi61WK6fjB9exKLDRZ+eE
rXTVqiXHRZMjjpEBg7wcFtGD18/ppA==
=5Nsv
-----END PGP SIGNATURE-----

--HjX0A3tSO/Js9qWM--

