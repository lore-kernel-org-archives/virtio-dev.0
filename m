Return-Path: <stefanha@redhat.com>
Date: Wed, 21 Jul 2021 11:42:11 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [virtio-comment] [PATCH V2 2/2] virtio: introduce STOP status bit
Message-ID: <YPf6A4PtQQUyO1VK@stefanha-x1.localdomain>
References: <YO60HpxfZnmfMCMj@stefanha-x1.localdomain>
 <094e15d4-169a-87e9-5ebb-93439ea72831@redhat.com>
 <YO79tuI72kTEWURN@stefanha-x1.localdomain>
 <1ab19438-cc13-bbe5-7fec-53a113d85463@redhat.com>
 <YPAHcG7bxhlIGVeE@stefanha-x1.localdomain>
 <c626c856-7010-0df6-131f-00aad7221266@redhat.com>
 <YPVzcLGj591X37fX@stefanha-x1.localdomain>
 <48a8b9f0-d68f-e5a0-1d7b-43e61bda603c@redhat.com>
 <YPajIv0m65U9wmPw@stefanha-x1.localdomain>
 <9aa13299-04b7-85a7-a468-9126e9b9cc14@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2RUu6Mg2Sr1/FjRi"
Content-Disposition: inline
In-Reply-To: <9aa13299-04b7-85a7-a468-9126e9b9cc14@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Eugenio Perez Martin <eperezma@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, virtio-comment@lists.oasis-open.org, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Max Gurtovoy <mgurtovoy@nvidia.com>, Cornelia Huck <cohuck@redhat.com>, Oren Duer <oren@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Bodong Wang <bodong@nvidia.com>, Alexander Mikheev <amikheev@nvidia.com>, Halil Pasic <pasic@linux.ibm.com>
List-ID: <virtio-dev.lists.oasis-open.org>


--2RUu6Mg2Sr1/FjRi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 21, 2021 at 10:52:15AM +0800, Jason Wang wrote:
>=20
> =E5=9C=A8 2021/7/20 =E4=B8=8B=E5=8D=886:19, Stefan Hajnoczi =E5=86=99=E9=
=81=93:
> > On Tue, Jul 20, 2021 at 11:02:42AM +0800, Jason Wang wrote:
> > > =E5=9C=A8 2021/7/19 =E4=B8=8B=E5=8D=888:43, Stefan Hajnoczi =E5=86=99=
=E9=81=93:
> > > > On Fri, Jul 16, 2021 at 10:03:17AM +0800, Jason Wang wrote:
> > > > > =E5=9C=A8 2021/7/15 =E4=B8=8B=E5=8D=886:01, Stefan Hajnoczi =E5=
=86=99=E9=81=93:
> > > > > > On Thu, Jul 15, 2021 at 09:35:13AM +0800, Jason Wang wrote:
> > > > > > > =E5=9C=A8 2021/7/14 =E4=B8=8B=E5=8D=8811:07, Stefan Hajnoczi =
=E5=86=99=E9=81=93:
> > > > > > > > On Wed, Jul 14, 2021 at 06:29:28PM +0800, Jason Wang wrote:
> > > > > > > > > =E5=9C=A8 2021/7/14 =E4=B8=8B=E5=8D=885:53, Stefan Hajnoc=
zi =E5=86=99=E9=81=93:
> > > > > > > > > > On Tue, Jul 13, 2021 at 08:16:35PM +0800, Jason Wang wr=
ote:
> > > > > > > > > > > =E5=9C=A8 2021/7/13 =E4=B8=8B=E5=8D=886:00, Stefan Ha=
jnoczi =E5=86=99=E9=81=93:
> > > > > > > > > > > > On Tue, Jul 13, 2021 at 11:27:03AM +0800, Jason Wan=
g wrote:
> > > > > > > > > > > > > =E5=9C=A8 2021/7/12 =E4=B8=8B=E5=8D=885:57, Stefa=
n Hajnoczi =E5=86=99=E9=81=93:
> > > > > > > > > > > > > > On Mon, Jul 12, 2021 at 12:00:39PM +0800, Jason=
 Wang wrote:
> > > > > > > > > > > > > > > =E5=9C=A8 2021/7/11 =E4=B8=8A=E5=8D=884:36, M=
ichael S. Tsirkin =E5=86=99=E9=81=93:
> > > > > > > > > > > > > > > > On Fri, Jul 09, 2021 at 07:23:33PM +0200, E=
ugenio Perez Martin wrote:
> > > > > > > > > > > > > > > > > > >           If I understand correctly, =
this is all
> > > > > > > > > > > > > > > > > > > driven from the driver inside the gue=
st, so for this to work
> > > > > > > > > > > > > > > > > > > the guest must be running and already=
 have initialised the driver.
> > > > > > > > > > > > > > > > > > Yes.
> > > > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > > As I see it, the feature can be driven en=
tirely by the VMM as long as
> > > > > > > > > > > > > > > > > it intercept the relevant configuration s=
pace (PCI, MMIO, etc) from
> > > > > > > > > > > > > > > > > guest's reads and writes, and present it =
as coherent and transparent
> > > > > > > > > > > > > > > > > for the guest. Some use cases I can imagi=
ne with a physical device (or
> > > > > > > > > > > > > > > > > vp_vpda device) with VIRTIO_F_STOP:
> > > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > > 1) The VMM chooses not to pass the featur=
e flag. The guest cannot stop
> > > > > > > > > > > > > > > > > the device, so any write to this flag is =
an error/undefined.
> > > > > > > > > > > > > > > > > 2) The VMM passes the flag to the guest. =
The guest can stop the device.
> > > > > > > > > > > > > > > > > 2.1) The VMM stops the device to perform =
a live migration, and the
> > > > > > > > > > > > > > > > > guest does not write to STOP in any momen=
t of the LM. It resets the
> > > > > > > > > > > > > > > > > destination device with the state, and th=
en initializes the device.
> > > > > > > > > > > > > > > > > 2.2) The guest stops the device and, when=
 STOP(32) is set, the source
> > > > > > > > > > > > > > > > > VMM migrates the device status. The desti=
nation VMM realizes the bit,
> > > > > > > > > > > > > > > > > so it sets the bit in the destination too=
 after device initialization.
> > > > > > > > > > > > > > > > > 2.3) The device is not initialized by the=
 guest so it doesn't matter
> > > > > > > > > > > > > > > > > what bit has the HW, but the VM can be mi=
grated.
> > > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > > Am I missing something?
> > > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > > Thanks!
> > > > > > > > > > > > > > > > It's doable like this. It's all a lot of ho=
ops to jump through though.
> > > > > > > > > > > > > > > > It's also not easy for devices to implement.
> > > > > > > > > > > > > > > It just requires a new status bit. Anything t=
hat makes you think it's hard
> > > > > > > > > > > > > > > to implement?
> > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > E.g for networking device, it should be suffi=
cient to use this bit + the
> > > > > > > > > > > > > > > virtqueue state.
> > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > Why don't we design the feature in a way th=
at is useable by VMMs
> > > > > > > > > > > > > > > > and implementable by devices in a simple wa=
y?
> > > > > > > > > > > > > > > It use the common technology like register sh=
adowing without any further
> > > > > > > > > > > > > > > stuffs.
> > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > Or do you have any other ideas?
> > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > (I think we all know migration will be very h=
ard if we simply pass through
> > > > > > > > > > > > > > > those state registers).
> > > > > > > > > > > > > > If an admin virtqueue is used instead of the ST=
OP Device Status field
> > > > > > > > > > > > > > bit then there's no need to re-read the Device =
Status field in a loop
> > > > > > > > > > > > > > until the device has stopped.
> > > > > > > > > > > > > Probably not. Let me to clarify several points:
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > - This proposal has nothing to do with admin virt=
queue. Actually, admin
> > > > > > > > > > > > > virtqueue could be used for carrying any basic de=
vice facility like status
> > > > > > > > > > > > > bit. E.g I'm going to post patches that use admin=
 virtqueue as a "transport"
> > > > > > > > > > > > > for device slicing at virtio level.
> > > > > > > > > > > > > - Even if we had introduced admin virtqueue, we s=
till need a per function
> > > > > > > > > > > > > interface for this. This is a must for nested vir=
tualization, we can't
> > > > > > > > > > > > > always expect things like PF can be assigned to L=
1 guest.
> > > > > > > > > > > > > - According to the proposal, there's no need for =
the device to complete all
> > > > > > > > > > > > > the consumed buffers, device can choose to expose=
 those inflight descriptors
> > > > > > > > > > > > > in a device specific way and set the STOP bit. Th=
is means, if we have the
> > > > > > > > > > > > > device specific in-flight descriptor reporting fa=
cility, the device can
> > > > > > > > > > > > > almost set the STOP bit immediately.
> > > > > > > > > > > > > - If we don't go with the basic device facility b=
ut using the admin
> > > > > > > > > > > > > virtqueue specific method, we still need to clari=
fy how it works with the
> > > > > > > > > > > > > device status state machine, it will be some kind=
 of sub-states which looks
> > > > > > > > > > > > > much more complicated than the current proposal.
> > > > > > > > > > > > >=20
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > > When migrating a guest with many VIRTIO devices=
 a busy waiting approach
> > > > > > > > > > > > > > extends downtime if implemented sequentially (s=
topping one device at a
> > > > > > > > > > > > > > time).
> > > > > > > > > > > > > Well. You need some kinds of waiting for sure, th=
e device/DMA needs sometime
> > > > > > > > > > > > > to be stopped. The downtime is determined by a sp=
ecific virtio
> > > > > > > > > > > > > implementation which is hard to be restricted at =
the spec level. We can
> > > > > > > > > > > > > clarify that the device must set the STOP bit in =
e.g 100ms.
> > > > > > > > > > > > >=20
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > >         It can be implemented concurrently (set=
ting the STOP bit on all
> > > > > > > > > > > > > > devices and then looping until all their Device=
 Status fields have the
> > > > > > > > > > > > > > bit set), but this becomes more complex to impl=
ement.
> > > > > > > > > > > > > I still don't get what kind of complexity did you=
 worry here.
> > > > > > > > > > > > >=20
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > > I'm a little worried about adding a new bit tha=
t requires busy
> > > > > > > > > > > > > > waiting...
> > > > > > > > > > > > > Busy wait is not something that is introduced in =
this patch:
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > 4.1.4.3.2 Driver Requirements: Common configurati=
on structure layout
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > After writing 0 to device_status, the driver MUST=
 wait for a read of
> > > > > > > > > > > > > device_status to return 0 before reinitializing t=
he device.
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > Since it was required for at least one transport.=
 We need do something
> > > > > > > > > > > > > similar to when introducing basic facility.
> > > > > > > > > > > > Adding the STOP but as a Device Status bit is a sma=
ll and clean VIRTIO
> > > > > > > > > > > > spec change. I like that.
> > > > > > > > > > > >=20
> > > > > > > > > > > > On the other hand, devices need time to stop and th=
at time can be
> > > > > > > > > > > > unbounded. For example, software virtio-blk/scsi im=
plementations since
> > > > > > > > > > > > cannot immediately cancel in-flight I/O requests on=
 Linux hosts.
> > > > > > > > > > > >=20
> > > > > > > > > > > > The natural interface for long-running operations i=
s virtqueue requests.
> > > > > > > > > > > > That's why I mentioned the alternative of using an =
admin virtqueue
> > > > > > > > > > > > instead of a Device Status bit.
> > > > > > > > > > > So I'm not against the admin virtqueue. As said befor=
e, admin virtqueue
> > > > > > > > > > > could be used for carrying the device status bit.
> > > > > > > > > > >=20
> > > > > > > > > > > Send a command to set STOP status bit to admin virtqu=
eue. Device will make
> > > > > > > > > > > the command buffer used after it has successfully sto=
pped the device.
> > > > > > > > > > >=20
> > > > > > > > > > > AFAIK, they are not mutually exclusive, since they ar=
e trying to solve
> > > > > > > > > > > different problems.
> > > > > > > > > > >=20
> > > > > > > > > > > Device status - basic device facility
> > > > > > > > > > >=20
> > > > > > > > > > > Admin virtqueue - transport/device specific way to im=
plement (part of) the
> > > > > > > > > > > device facility
> > > > > > > > > > >=20
> > > > > > > > > > > > Although you mentioned that the stopped state needs=
 to be reflected in
> > > > > > > > > > > > the Device Status field somehow, I'm not sure about=
 that since the
> > > > > > > > > > > > driver typically doesn't need to know whether the d=
evice is being
> > > > > > > > > > > > migrated.
> > > > > > > > > > > The guest won't see the real device status bit. VMM w=
ill shadow the device
> > > > > > > > > > > status bit in this case.
> > > > > > > > > > >=20
> > > > > > > > > > > E.g with the current vhost-vDPA, vDPA behave like a v=
host device, guest is
> > > > > > > > > > > unaware of the migration.
> > > > > > > > > > >=20
> > > > > > > > > > > STOP status bit is set by Qemu to real virtio hardwar=
e. But guest will only
> > > > > > > > > > > see the DRIVER_OK without STOP.
> > > > > > > > > > >=20
> > > > > > > > > > > It's not hard to implement the nested on top, see the=
 discussion initiated
> > > > > > > > > > > by Eugenio about how expose VIRTIO_F_STOP to guest fo=
r nested live
> > > > > > > > > > > migration.
> > > > > > > > > > >=20
> > > > > > > > > > >=20
> > > > > > > > > > > >        In fact, the VMM would need to hide this bit=
 and it's safer to
> > > > > > > > > > > > keep it out-of-band instead of risking exposing it =
by accident.
> > > > > > > > > > > See above, VMM may choose to hide or expose the capab=
ility. It's useful for
> > > > > > > > > > > migrating a nested guest.
> > > > > > > > > > >=20
> > > > > > > > > > > If we design an interface that can be used in the nes=
ted environment, it's
> > > > > > > > > > > not an ideal interface.
> > > > > > > > > > >=20
> > > > > > > > > > >=20
> > > > > > > > > > > > In addition, stateful devices need to load/save non=
-trivial amounts of
> > > > > > > > > > > > data. They need DMA to do this efficiently, so an a=
dmin virtqueue is a
> > > > > > > > > > > > good fit again.
> > > > > > > > > > > I don't get the point here. You still need to address=
 the exact the similar
> > > > > > > > > > > issues for admin virtqueue: the unbound time in freez=
ing the device, the
> > > > > > > > > > > interaction with the virtio device status state machi=
ne.
> > > > > > > > > > Device state state can be large so a register interface=
 would be a
> > > > > > > > > > bottleneck. DMA is needed. I think a virtqueue is a goo=
d fit for
> > > > > > > > > > saving/loading device state.
> > > > > > > > > So this patch doesn't mandate a register interface, isn't=
 it?
> > > > > > > > You're right, not this patch. I mentioned it because your o=
ther patch
> > > > > > > > series ("[PATCH] virtio-pci: implement VIRTIO_F_RING_STATE"=
) implements
> > > > > > > > it a register interface.
> > > > > > > >=20
> > > > > > > > > And DMA
> > > > > > > > > doesn't means a virtqueue, it could be a transport specif=
ic method.
> > > > > > > > Yes, although virtqueues are a pretty good interface that w=
orks across
> > > > > > > > transports (PCI/MMIO/etc) thanks to the standard vring memo=
ry layout.
> > > > > > > >=20
> > > > > > > > > I think we need to start from defining the state of one s=
pecific device and
> > > > > > > > > see what is the best interface.
> > > > > > > > virtio-blk might be the simplest. I think virtio-net has mo=
re device
> > > > > > > > state and virtio-scsi is definitely more complext than virt=
io-blk.
> > > > > > > >=20
> > > > > > > > First we need agreement on whether "device state" encompass=
es the full
> > > > > > > > state of the device or just state that is unknown to the VM=
M.
> > > > > > > I think we've discussed this in the past. It can't work since:
> > > > > > >=20
> > > > > > > 1) The state and its format must be clearly defined in the sp=
ec
> > > > > > > 2) We need to maintain migration compatibility and debug-abil=
ity
> > > > > > Some devices need implementation-specific state. They should st=
ill be
> > > > > > able to live migrate even if it means cross-implementation migr=
ation and
> > > > > > debug-ability is not possible.
> > > > > I think we need to re-visit this conclusion. Migration compatibil=
ity is
> > > > > pretty important, especially consider the software stack has spen=
t a huge
> > > > > mount of effort in maintaining them.
> > > > >=20
> > > > > Say a virtio hardware would break this, this mean we will lose al=
l the
> > > > > advantages of being a standard device.
> > > > >=20
> > > > > If we can't do live migration among:
> > > > >=20
> > > > > 1) different backends, e.g migrate from virtio hardware to migrat=
e software
> > > > > 2) different vendors
> > > > >=20
> > > > > We failed to say as a standard device and the customer is in fact=
 locked by
> > > > > the vendor implicitly.
> > > > My virtiofs device implementation is backed by an in-memory file sy=
stem.
> > > > The device state includes the contents of each file.
> > > >=20
> > > > Your virtiofs device implementation uses Linux file handles to keep
> > > > track of open files. The device state includes Linux file handles (=
but
> > > > not the contents of each file) so the destination host can access t=
he
> > > > same files on shared storage.
> > > >=20
> > > > Cornelia's virtiofs device implementation is backed by an object st=
orage
> > > > HTTP API. The device state includes API object IDs.
> > > >=20
> > > > The device state is implementation-dependent. There is no standard
> > > > representation and it's not possible to migrate between device
> > > > implementations. How are they supposed to migrate?
> > >=20
> > > So if I understand correclty, virtio-fs is not desigined to be migrat=
e-able?
> > >=20
> > > (Having a check on the current virtio-fs support in qemu, it looks to=
 me it
> > > has a migration blocker).
> > The code does not support live migration but it's on the roadmap. Max
> > Reitz added Linux file handle support to virtiofsd. That was the first
> > step towards being able to migrate the device's state.
>=20
>=20
> A dumb question, how do qemu know it is connected to virtiofsd?

virtiofsd is a vhost-user-fs device. QEMU doesn't know if it's connected
to virtiofsd or another implementation.

> > > > This is why I think it's necessarily to allow implementation-specif=
ic
> > > > device state representations.
> > >=20
> > > Or you probably mean you don't support cross backend migration. This =
sounds
> > > like a drawback and it's actually not a standard device but a
> > > vendor/implementation specific device.
> > >=20
> > > It would bring a lot of troubles, not only for the implementation but=
 for
> > > the management. Maybe we can start from adding the support of migrati=
on for
> > > some specific backend and start from there.
> > Yes, it's complicated. Some implementations could be compatible, but
> > others can never be compatible because they have completely different
> > state.
> >=20
> > The virtiofsd implementation is the main one for virtiofs and the device
> > state representation can be published, even standardized. Others can
> > implement it to achieve migration compatibility.
> >=20
> > But it must be possible for implementations that have completely
> > different state to migrate too. virtiofsd isn't special.
> >=20
> > > > > > > 3) Not a proper uAPI desgin
> > > > > > I never understood this argument. The Linux uAPI passes through=
 lots of
> > > > > > opaque data from devices to userspace. Allowing an
> > > > > > implementation-specific device state representation is nothing =
new. VFIO
> > > > > > already does it.
> > > > > I think we've already had a lots of discussion for VFIO but witho=
ut a
> > > > > conclusion. Maybe we need the verdict from Linus or Greg (not sur=
e if it's
> > > > > too late). But that's not related to virito and this thread.
> > > > >=20
> > > > > What you propose here is kind of conflict with the efforts of vir=
tio. I
> > > > > think we all aggree that we should define the state in the spec. =
Assuming
> > > > > this is correct:
> > > > >=20
> > > > > 1) why do we still offer opaque migration state to userspace?
> > > > See above. Stateful devices may require an implementation-defined d=
evice
> > > > state representation.
> > >=20
> > > So my point stand still, it's not a standard device if we do this.
> > These "non-standard devices" still need to be able to migrate.
>=20
>=20
> See other thread, it breaks the effort of having a spec.
>
> >   How
> > should we do that?
>=20
>=20
> I think the main issue is that, to me it's not a virtio device but a devi=
ce
> that is using virtio queue with implementation specific state. So it can't
> be migrated by the virtio subsystem but through a vendor/implementation
> specific migration driver.

Okay. Are you thinking about a separate set of vDPA APIs and vhost
ioctls so the VMM can save/load implementation-specific device state?
These separate APIs just need to be called as part of the standard
VIRTIO stop and vq save/load lifecycle.

> >=20
> > > > > 2) how can it be integrated into the current VMM (Qemu) virtio de=
vices'
> > > > > migration bytes stream?
> > > > Opaque data like D-Bus VMState:
> > > > https://qemu.readthedocs.io/en/latest/interop/dbus-vmstate.html
> > >=20
> > > Actually, I meant how to keep the opaque state which is compatible wi=
th all
> > > the existing device that can do migration.
> > >=20
> > > E.g we want to live migration virtio-blk among any backends (from a h=
ardware
> > > device to a software backend).
> > There was a series of email threads last year where migration
> > compatibility was discussed:
> >=20
> > https://lists.gnu.org/archive/html/qemu-devel/2020-11/msg02620.html
> >=20
> > I proposed an algorithm for checking migration compatibility between
> > devices. The source and destination device can have different
> > implementations (e.g. hardware, software, etc).
> >=20
> > It involves picking an identifier like virtio-spec.org/pci/virtio-net
> > for the device state representation and device parameters for aspects of
> > the device that vary between instances (e.g. tso=3Don|off).
> >=20
> > It's more complex than today's live migration approach in libvirt and
> > QEMU. Today libvirt configures the source and destination in a
> > compatible manner (thanks to knowledge of the device implementation) and
> > then QEMU transfers the device state.
> >=20
> > Part of the point of defining a migration compatibility algorithm is
> > that it's possible to lift the assumptions out of libvirt so that
> > arbitrary device implementations can be supported (hardware, software,
> > etc) without putting knowledge about every device/VMM implementation
> > into libvirt.
> >=20
> > (The other advantage is that this allows orchestration software to
> > determine migration compatibility before starting a migration.)
>=20
>=20
> This looks like another independent issues and I fully agree to have a
> better migration protocol. But using that means we break the migration
> compatibility with the existing device which is used for more than 10 yea=
rs.
> We still need to make the migration from/to the existing virtio device to
> work.

I agree that migrating to/from existing devices needs to work. It should
be possible to transition without breaking migration.

> > > > > > > > That's
> > > > > > > > basically the difference between the vhost/vDPA's selective=
 passthrough
> > > > > > > > approach and VFIO's full passthrough approach.
> > > > > > > We can't do VFIO full pasthrough for migration anyway, some k=
ind of mdev is
> > > > > > > required but it's duplicated with the current vp_vdpa driver.
> > > > > > I'm not sure that's true. Generic VFIO PCI migration can probab=
ly be
> > > > > > achieved without mdev:
> > > > > > 1. Define a migration PCI Capability that indicates support for
> > > > > >       VFIO_REGION_TYPE_MIGRATION. This allows the PCI device to=
 implement
> > > > > >       the migration interface in hardware instead of an mdev dr=
iver.
> > > > > So I think it still depend on the driver to implement migrate sta=
te which is
> > > > > vendor specific.
> > > > The current VFIO migration interface depends on a device-specific
> > > > software mdev driver but here I'm showing that the physical device =
can
> > > > implement the migration interface so that no device-specific driver=
 code
> > > > is needed.
> > >=20
> > > This is not what I read from the patch:
> > >=20
> > >  =C2=A0* device_state: (read/write)
> > >  =C2=A0*=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - The user application writes =
to this field to inform the vendor
> > > driver
> > >  =C2=A0*=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 about the device s=
tate to be transitioned to.
> > >  =C2=A0*=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - The vendor driver should tak=
e the necessary actions to change the
> > >  =C2=A0*=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 device state. Afte=
r successful transition to a given state, the
> > >  =C2=A0*=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vendor driver shou=
ld return success on write(device_state, state)
> > >  =C2=A0*=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 system call. If th=
e device state transition fails, the vendor
> > > driver
> > >  =C2=A0*=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 should return an a=
ppropriate -errno for the fault condition.
> > >=20
> > > Vendor driver need to mediate between the uAPI and the actual device.
> > Yes, that's the current state of VFIO migration. If a hardware interface
> > (e.g. PCI Capability) is defined that maps to this API then no
> > device-specific drivers would be necessary because core VFIO PCI code
> > can implement the uAPI by talking to the hardware.
>=20
>=20
> As we discussed, it would be very hard. The device state is implementation
> specific which may not fit for the Capability. (PCIE has already had VF
> migration state in the SR-IOV extended capability).
>=20
>=20
> >=20
> > > > > > 2. The VMM either uses the migration PCI Capability directly fr=
om
> > > > > >       userspace or core VFIO PCI code advertises VFIO_REGION_TY=
PE_MIGRATION
> > > > > >       to userspace so migration can proceed in the same way as =
with
> > > > > >       VFIO/mdev drivers.
> > > > > > 3. The PCI Capability is not passed through to the guest.
> > > > > This brings troubles in the nested environment.
> > > > It depends on the device splitting/management design. If L0 wishes =
to
> > > > let L1 manage the VFs then it would need to expose a management dev=
ice.
> > > > Since the migration interface is generic (not device-specific) a ge=
neric
> > > > management device solves this for all devices.
> > >=20
> > > Right, but it's a burden to expose the management device or it may ju=
st
> > > won't work.
> > A single generic management device is not a huge burden and it may turn
> > out that keeping the management device out-of-band is actually a
> > desirable feature if the device owner does not wish to expose the
> > stop/save/load functionality for some reason.
>=20
>=20
> VMM are free to hide those features from guest. Management can just do
> -device virtio-pci,state=3Dfalse
>=20
> Having management device works for L0 but not suitable for L(x>0). A per
> function device interface is a must for the nested virt to work in a simp=
le
> and easy way.

You are right, a per function interface is simplest. I'm not experienced
enough with SR-IOV and nested virtualization to have a strong opinion in
this area.

Stefan

--2RUu6Mg2Sr1/FjRi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmD3+gMACgkQnKSrs4Gr
c8gY3wf8DALagVLV+RR18D0/7+mYjrdING9BQgYw0LCePRwkvYHBkZj6QRvckl47
CX6GkWIwBv4J8giUf30zXQYS2dqYkS6Yxc3+nr3+KLhiO0IhOS6x9j9ONH6KHalP
RTlFiv/xmOdGOPNqz7hQ+uF0iJFoRpkdy1eVDBzkW0J/kjfLfsz2FX8wNIPc9RAw
J1Oc062ljpFp+rD+vYmCN293brQq/+XCXYXgv6fcVQqLw/wdXq6+UesVNSZ8pB6R
CHKb+dIetfAOx3dUP1oGzuLPYXAvSDiVq6kWtrOiBG83wCPwsaOZOnWc9Ee5+eoH
tDfEZ5aIemvz/lKr3JEM9Z6q1Qse9g==
=YG8e
-----END PGP SIGNATURE-----

--2RUu6Mg2Sr1/FjRi--

