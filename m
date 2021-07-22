Return-Path: <stefanha@redhat.com>
Date: Thu, 22 Jul 2021 11:30:33 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [virtio-comment] [PATCH V2 2/2] virtio: introduce STOP status bit
Message-ID: <YPlIyaA0g/y10fPZ@stefanha-x1.localdomain>
References: <YO79tuI72kTEWURN@stefanha-x1.localdomain>
 <1ab19438-cc13-bbe5-7fec-53a113d85463@redhat.com>
 <YPAHcG7bxhlIGVeE@stefanha-x1.localdomain>
 <c626c856-7010-0df6-131f-00aad7221266@redhat.com>
 <YPVzcLGj591X37fX@stefanha-x1.localdomain>
 <48a8b9f0-d68f-e5a0-1d7b-43e61bda603c@redhat.com>
 <YPajIv0m65U9wmPw@stefanha-x1.localdomain>
 <9aa13299-04b7-85a7-a468-9126e9b9cc14@redhat.com>
 <YPf6A4PtQQUyO1VK@stefanha-x1.localdomain>
 <75e5f391-79a4-e3b3-4d15-e187451ca3bd@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CBh45NZv3ZVmJdM7"
Content-Disposition: inline
In-Reply-To: <75e5f391-79a4-e3b3-4d15-e187451ca3bd@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Eugenio Perez Martin <eperezma@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, virtio-comment@lists.oasis-open.org, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Max Gurtovoy <mgurtovoy@nvidia.com>, Cornelia Huck <cohuck@redhat.com>, Oren Duer <oren@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Bodong Wang <bodong@nvidia.com>, Alexander Mikheev <amikheev@nvidia.com>, Halil Pasic <pasic@linux.ibm.com>
List-ID: <virtio-dev.lists.oasis-open.org>


--CBh45NZv3ZVmJdM7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 22, 2021 at 10:08:51AM +0800, Jason Wang wrote:
>=20
> =E5=9C=A8 2021/7/21 =E4=B8=8B=E5=8D=886:42, Stefan Hajnoczi =E5=86=99=E9=
=81=93:
> > On Wed, Jul 21, 2021 at 10:52:15AM +0800, Jason Wang wrote:
> > > =E5=9C=A8 2021/7/20 =E4=B8=8B=E5=8D=886:19, Stefan Hajnoczi =E5=86=99=
=E9=81=93:
> > > > On Tue, Jul 20, 2021 at 11:02:42AM +0800, Jason Wang wrote:
> > > > > =E5=9C=A8 2021/7/19 =E4=B8=8B=E5=8D=888:43, Stefan Hajnoczi =E5=
=86=99=E9=81=93:
> > > > > > On Fri, Jul 16, 2021 at 10:03:17AM +0800, Jason Wang wrote:
> > > > > > > =E5=9C=A8 2021/7/15 =E4=B8=8B=E5=8D=886:01, Stefan Hajnoczi =
=E5=86=99=E9=81=93:
> > > > > > > > On Thu, Jul 15, 2021 at 09:35:13AM +0800, Jason Wang wrote:
> > > > > > > > > =E5=9C=A8 2021/7/14 =E4=B8=8B=E5=8D=8811:07, Stefan Hajno=
czi =E5=86=99=E9=81=93:
> > > > > > > > > > On Wed, Jul 14, 2021 at 06:29:28PM +0800, Jason Wang wr=
ote:
> > > > > > > > > > > =E5=9C=A8 2021/7/14 =E4=B8=8B=E5=8D=885:53, Stefan Ha=
jnoczi =E5=86=99=E9=81=93:
> > > > > > > > > > > > On Tue, Jul 13, 2021 at 08:16:35PM +0800, Jason Wan=
g wrote:
> > > > > > > > > > > > > =E5=9C=A8 2021/7/13 =E4=B8=8B=E5=8D=886:00, Stefa=
n Hajnoczi =E5=86=99=E9=81=93:
> > > > > > > > > > > > > > On Tue, Jul 13, 2021 at 11:27:03AM +0800, Jason=
 Wang wrote:
> > > > > > > > > > > > > > > =E5=9C=A8 2021/7/12 =E4=B8=8B=E5=8D=885:57, S=
tefan Hajnoczi =E5=86=99=E9=81=93:
> > > > > > > > > > > > > > > > On Mon, Jul 12, 2021 at 12:00:39PM +0800, J=
ason Wang wrote:
> > > > > > > > > > > > > > > > > =E5=9C=A8 2021/7/11 =E4=B8=8A=E5=8D=884:3=
6, Michael S. Tsirkin =E5=86=99=E9=81=93:
> > > > > > > > > > > > > > > > > > On Fri, Jul 09, 2021 at 07:23:33PM +020=
0, Eugenio Perez Martin wrote:
> > > > > > > > > > > > > > > > > > > > >            If I understand correc=
tly, this is all
> > > > > > > > > > > > > > > > > > > > > driven from the driver inside the=
 guest, so for this to work
> > > > > > > > > > > > > > > > > > > > > the guest must be running and alr=
eady have initialised the driver.
> > > > > > > > > > > > > > > > > > > > Yes.
> > > > > > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > > > > As I see it, the feature can be drive=
n entirely by the VMM as long as
> > > > > > > > > > > > > > > > > > > it intercept the relevant configurati=
on space (PCI, MMIO, etc) from
> > > > > > > > > > > > > > > > > > > guest's reads and writes, and present=
 it as coherent and transparent
> > > > > > > > > > > > > > > > > > > for the guest. Some use cases I can i=
magine with a physical device (or
> > > > > > > > > > > > > > > > > > > vp_vpda device) with VIRTIO_F_STOP:
> > > > > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > > > > 1) The VMM chooses not to pass the fe=
ature flag. The guest cannot stop
> > > > > > > > > > > > > > > > > > > the device, so any write to this flag=
 is an error/undefined.
> > > > > > > > > > > > > > > > > > > 2) The VMM passes the flag to the gue=
st. The guest can stop the device.
> > > > > > > > > > > > > > > > > > > 2.1) The VMM stops the device to perf=
orm a live migration, and the
> > > > > > > > > > > > > > > > > > > guest does not write to STOP in any m=
oment of the LM. It resets the
> > > > > > > > > > > > > > > > > > > destination device with the state, an=
d then initializes the device.
> > > > > > > > > > > > > > > > > > > 2.2) The guest stops the device and, =
when STOP(32) is set, the source
> > > > > > > > > > > > > > > > > > > VMM migrates the device status. The d=
estination VMM realizes the bit,
> > > > > > > > > > > > > > > > > > > so it sets the bit in the destination=
 too after device initialization.
> > > > > > > > > > > > > > > > > > > 2.3) The device is not initialized by=
 the guest so it doesn't matter
> > > > > > > > > > > > > > > > > > > what bit has the HW, but the VM can b=
e migrated.
> > > > > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > > > > Am I missing something?
> > > > > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > > > > Thanks!
> > > > > > > > > > > > > > > > > > It's doable like this. It's all a lot o=
f hoops to jump through though.
> > > > > > > > > > > > > > > > > > It's also not easy for devices to imple=
ment.
> > > > > > > > > > > > > > > > > It just requires a new status bit. Anythi=
ng that makes you think it's hard
> > > > > > > > > > > > > > > > > to implement?
> > > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > > E.g for networking device, it should be s=
ufficient to use this bit + the
> > > > > > > > > > > > > > > > > virtqueue state.
> > > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > > > Why don't we design the feature in a wa=
y that is useable by VMMs
> > > > > > > > > > > > > > > > > > and implementable by devices in a simpl=
e way?
> > > > > > > > > > > > > > > > > It use the common technology like registe=
r shadowing without any further
> > > > > > > > > > > > > > > > > stuffs.
> > > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > > Or do you have any other ideas?
> > > > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > > (I think we all know migration will be ve=
ry hard if we simply pass through
> > > > > > > > > > > > > > > > > those state registers).
> > > > > > > > > > > > > > > > If an admin virtqueue is used instead of th=
e STOP Device Status field
> > > > > > > > > > > > > > > > bit then there's no need to re-read the Dev=
ice Status field in a loop
> > > > > > > > > > > > > > > > until the device has stopped.
> > > > > > > > > > > > > > > Probably not. Let me to clarify several point=
s:
> > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > - This proposal has nothing to do with admin =
virtqueue. Actually, admin
> > > > > > > > > > > > > > > virtqueue could be used for carrying any basi=
c device facility like status
> > > > > > > > > > > > > > > bit. E.g I'm going to post patches that use a=
dmin virtqueue as a "transport"
> > > > > > > > > > > > > > > for device slicing at virtio level.
> > > > > > > > > > > > > > > - Even if we had introduced admin virtqueue, =
we still need a per function
> > > > > > > > > > > > > > > interface for this. This is a must for nested=
 virtualization, we can't
> > > > > > > > > > > > > > > always expect things like PF can be assigned =
to L1 guest.
> > > > > > > > > > > > > > > - According to the proposal, there's no need =
for the device to complete all
> > > > > > > > > > > > > > > the consumed buffers, device can choose to ex=
pose those inflight descriptors
> > > > > > > > > > > > > > > in a device specific way and set the STOP bit=
=2E This means, if we have the
> > > > > > > > > > > > > > > device specific in-flight descriptor reportin=
g facility, the device can
> > > > > > > > > > > > > > > almost set the STOP bit immediately.
> > > > > > > > > > > > > > > - If we don't go with the basic device facili=
ty but using the admin
> > > > > > > > > > > > > > > virtqueue specific method, we still need to c=
larify how it works with the
> > > > > > > > > > > > > > > device status state machine, it will be some =
kind of sub-states which looks
> > > > > > > > > > > > > > > much more complicated than the current propos=
al.
> > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > When migrating a guest with many VIRTIO dev=
ices a busy waiting approach
> > > > > > > > > > > > > > > > extends downtime if implemented sequentiall=
y (stopping one device at a
> > > > > > > > > > > > > > > > time).
> > > > > > > > > > > > > > > Well. You need some kinds of waiting for sure=
, the device/DMA needs sometime
> > > > > > > > > > > > > > > to be stopped. The downtime is determined by =
a specific virtio
> > > > > > > > > > > > > > > implementation which is hard to be restricted=
 at the spec level. We can
> > > > > > > > > > > > > > > clarify that the device must set the STOP bit=
 in e.g 100ms.
> > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > >          It can be implemented concurrently=
 (setting the STOP bit on all
> > > > > > > > > > > > > > > > devices and then looping until all their De=
vice Status fields have the
> > > > > > > > > > > > > > > > bit set), but this becomes more complex to =
implement.
> > > > > > > > > > > > > > > I still don't get what kind of complexity did=
 you worry here.
> > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > > I'm a little worried about adding a new bit=
 that requires busy
> > > > > > > > > > > > > > > > waiting...
> > > > > > > > > > > > > > > Busy wait is not something that is introduced=
 in this patch:
> > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > 4.1.4.3.2 Driver Requirements: Common configu=
ration structure layout
> > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > After writing 0 to device_status, the driver =
MUST wait for a read of
> > > > > > > > > > > > > > > device_status to return 0 before reinitializi=
ng the device.
> > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > Since it was required for at least one transp=
ort. We need do something
> > > > > > > > > > > > > > > similar to when introducing basic facility.
> > > > > > > > > > > > > > Adding the STOP but as a Device Status bit is a=
 small and clean VIRTIO
> > > > > > > > > > > > > > spec change. I like that.
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > On the other hand, devices need time to stop an=
d that time can be
> > > > > > > > > > > > > > unbounded. For example, software virtio-blk/scs=
i implementations since
> > > > > > > > > > > > > > cannot immediately cancel in-flight I/O request=
s on Linux hosts.
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > The natural interface for long-running operatio=
ns is virtqueue requests.
> > > > > > > > > > > > > > That's why I mentioned the alternative of using=
 an admin virtqueue
> > > > > > > > > > > > > > instead of a Device Status bit.
> > > > > > > > > > > > > So I'm not against the admin virtqueue. As said b=
efore, admin virtqueue
> > > > > > > > > > > > > could be used for carrying the device status bit.
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > Send a command to set STOP status bit to admin vi=
rtqueue. Device will make
> > > > > > > > > > > > > the command buffer used after it has successfully=
 stopped the device.
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > AFAIK, they are not mutually exclusive, since the=
y are trying to solve
> > > > > > > > > > > > > different problems.
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > Device status - basic device facility
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > Admin virtqueue - transport/device specific way t=
o implement (part of) the
> > > > > > > > > > > > > device facility
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > > Although you mentioned that the stopped state n=
eeds to be reflected in
> > > > > > > > > > > > > > the Device Status field somehow, I'm not sure a=
bout that since the
> > > > > > > > > > > > > > driver typically doesn't need to know whether t=
he device is being
> > > > > > > > > > > > > > migrated.
> > > > > > > > > > > > > The guest won't see the real device status bit. V=
MM will shadow the device
> > > > > > > > > > > > > status bit in this case.
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > E.g with the current vhost-vDPA, vDPA behave like=
 a vhost device, guest is
> > > > > > > > > > > > > unaware of the migration.
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > STOP status bit is set by Qemu to real virtio har=
dware. But guest will only
> > > > > > > > > > > > > see the DRIVER_OK without STOP.
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > It's not hard to implement the nested on top, see=
 the discussion initiated
> > > > > > > > > > > > > by Eugenio about how expose VIRTIO_F_STOP to gues=
t for nested live
> > > > > > > > > > > > > migration.
> > > > > > > > > > > > >=20
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > >         In fact, the VMM would need to hide thi=
s bit and it's safer to
> > > > > > > > > > > > > > keep it out-of-band instead of risking exposing=
 it by accident.
> > > > > > > > > > > > > See above, VMM may choose to hide or expose the c=
apability. It's useful for
> > > > > > > > > > > > > migrating a nested guest.
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > If we design an interface that can be used in the=
 nested environment, it's
> > > > > > > > > > > > > not an ideal interface.
> > > > > > > > > > > > >=20
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > > In addition, stateful devices need to load/save=
 non-trivial amounts of
> > > > > > > > > > > > > > data. They need DMA to do this efficiently, so =
an admin virtqueue is a
> > > > > > > > > > > > > > good fit again.
> > > > > > > > > > > > > I don't get the point here. You still need to add=
ress the exact the similar
> > > > > > > > > > > > > issues for admin virtqueue: the unbound time in f=
reezing the device, the
> > > > > > > > > > > > > interaction with the virtio device status state m=
achine.
> > > > > > > > > > > > Device state state can be large so a register inter=
face would be a
> > > > > > > > > > > > bottleneck. DMA is needed. I think a virtqueue is a=
 good fit for
> > > > > > > > > > > > saving/loading device state.
> > > > > > > > > > > So this patch doesn't mandate a register interface, i=
sn't it?
> > > > > > > > > > You're right, not this patch. I mentioned it because yo=
ur other patch
> > > > > > > > > > series ("[PATCH] virtio-pci: implement VIRTIO_F_RING_ST=
ATE") implements
> > > > > > > > > > it a register interface.
> > > > > > > > > >=20
> > > > > > > > > > > And DMA
> > > > > > > > > > > doesn't means a virtqueue, it could be a transport sp=
ecific method.
> > > > > > > > > > Yes, although virtqueues are a pretty good interface th=
at works across
> > > > > > > > > > transports (PCI/MMIO/etc) thanks to the standard vring =
memory layout.
> > > > > > > > > >=20
> > > > > > > > > > > I think we need to start from defining the state of o=
ne specific device and
> > > > > > > > > > > see what is the best interface.
> > > > > > > > > > virtio-blk might be the simplest. I think virtio-net ha=
s more device
> > > > > > > > > > state and virtio-scsi is definitely more complext than =
virtio-blk.
> > > > > > > > > >=20
> > > > > > > > > > First we need agreement on whether "device state" encom=
passes the full
> > > > > > > > > > state of the device or just state that is unknown to th=
e VMM.
> > > > > > > > > I think we've discussed this in the past. It can't work s=
ince:
> > > > > > > > >=20
> > > > > > > > > 1) The state and its format must be clearly defined in th=
e spec
> > > > > > > > > 2) We need to maintain migration compatibility and debug-=
ability
> > > > > > > > Some devices need implementation-specific state. They shoul=
d still be
> > > > > > > > able to live migrate even if it means cross-implementation =
migration and
> > > > > > > > debug-ability is not possible.
> > > > > > > I think we need to re-visit this conclusion. Migration compat=
ibility is
> > > > > > > pretty important, especially consider the software stack has =
spent a huge
> > > > > > > mount of effort in maintaining them.
> > > > > > >=20
> > > > > > > Say a virtio hardware would break this, this mean we will los=
e all the
> > > > > > > advantages of being a standard device.
> > > > > > >=20
> > > > > > > If we can't do live migration among:
> > > > > > >=20
> > > > > > > 1) different backends, e.g migrate from virtio hardware to mi=
grate software
> > > > > > > 2) different vendors
> > > > > > >=20
> > > > > > > We failed to say as a standard device and the customer is in =
fact locked by
> > > > > > > the vendor implicitly.
> > > > > > My virtiofs device implementation is backed by an in-memory fil=
e system.
> > > > > > The device state includes the contents of each file.
> > > > > >=20
> > > > > > Your virtiofs device implementation uses Linux file handles to =
keep
> > > > > > track of open files. The device state includes Linux file handl=
es (but
> > > > > > not the contents of each file) so the destination host can acce=
ss the
> > > > > > same files on shared storage.
> > > > > >=20
> > > > > > Cornelia's virtiofs device implementation is backed by an objec=
t storage
> > > > > > HTTP API. The device state includes API object IDs.
> > > > > >=20
> > > > > > The device state is implementation-dependent. There is no stand=
ard
> > > > > > representation and it's not possible to migrate between device
> > > > > > implementations. How are they supposed to migrate?
> > > > > So if I understand correclty, virtio-fs is not desigined to be mi=
grate-able?
> > > > >=20
> > > > > (Having a check on the current virtio-fs support in qemu, it look=
s to me it
> > > > > has a migration blocker).
> > > > The code does not support live migration but it's on the roadmap. M=
ax
> > > > Reitz added Linux file handle support to virtiofsd. That was the fi=
rst
> > > > step towards being able to migrate the device's state.
> > >=20
> > > A dumb question, how do qemu know it is connected to virtiofsd?
> > virtiofsd is a vhost-user-fs device. QEMU doesn't know if it's connected
> > to virtiofsd or another implementation.
>=20
>=20
> That's my understanding. So this answers my questions basically: there co=
uld
> be a common migration implementation for each virtio-fs device which impl=
ies
> that we only need to migrate the common device specific state but not
> implementation specific state.
>=20
>=20
> >=20
> > > > > > This is why I think it's necessarily to allow implementation-sp=
ecific
> > > > > > device state representations.
> > > > > Or you probably mean you don't support cross backend migration. T=
his sounds
> > > > > like a drawback and it's actually not a standard device but a
> > > > > vendor/implementation specific device.
> > > > >=20
> > > > > It would bring a lot of troubles, not only for the implementation=
 but for
> > > > > the management. Maybe we can start from adding the support of mig=
ration for
> > > > > some specific backend and start from there.
> > > > Yes, it's complicated. Some implementations could be compatible, but
> > > > others can never be compatible because they have completely differe=
nt
> > > > state.
> > > >=20
> > > > The virtiofsd implementation is the main one for virtiofs and the d=
evice
> > > > state representation can be published, even standardized. Others can
> > > > implement it to achieve migration compatibility.
> > > >=20
> > > > But it must be possible for implementations that have completely
> > > > different state to migrate too. virtiofsd isn't special.
> > > >=20
> > > > > > > > > 3) Not a proper uAPI desgin
> > > > > > > > I never understood this argument. The Linux uAPI passes thr=
ough lots of
> > > > > > > > opaque data from devices to userspace. Allowing an
> > > > > > > > implementation-specific device state representation is noth=
ing new. VFIO
> > > > > > > > already does it.
> > > > > > > I think we've already had a lots of discussion for VFIO but w=
ithout a
> > > > > > > conclusion. Maybe we need the verdict from Linus or Greg (not=
 sure if it's
> > > > > > > too late). But that's not related to virito and this thread.
> > > > > > >=20
> > > > > > > What you propose here is kind of conflict with the efforts of=
 virtio. I
> > > > > > > think we all aggree that we should define the state in the sp=
ec. Assuming
> > > > > > > this is correct:
> > > > > > >=20
> > > > > > > 1) why do we still offer opaque migration state to userspace?
> > > > > > See above. Stateful devices may require an implementation-defin=
ed device
> > > > > > state representation.
> > > > > So my point stand still, it's not a standard device if we do this.
> > > > These "non-standard devices" still need to be able to migrate.
> > >=20
> > > See other thread, it breaks the effort of having a spec.
> > >=20
> > > >    How
> > > > should we do that?
> > >=20
> > > I think the main issue is that, to me it's not a virtio device but a =
device
> > > that is using virtio queue with implementation specific state. So it =
can't
> > > be migrated by the virtio subsystem but through a vendor/implementati=
on
> > > specific migration driver.
> > Okay. Are you thinking about a separate set of vDPA APIs and vhost
> > ioctls so the VMM can save/load implementation-specific device state?
>=20
>=20
> Probably not, I think the question is can we define the virtio-fs device
> state in the spec? If yes (and I think the answer is yes), we're fine. If
> not, it looks like we need to improve the spec or design.

There isn't one device state that contains all the information needed to
migrate virtiofs devices - unless implementation-specific device state
is allowed.

The implementation-specific device state could be added to the spec, but
it doesn't help: each implementation will use its subset of the device
state from the spec and cross-implementation migration still won't be
possible.

Stefan

--CBh45NZv3ZVmJdM7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmD5SMkACgkQnKSrs4Gr
c8gjMgf6A/C54CYA9sipGrQo8JcX+NZcp7iwbDErkAn2PmxG/V3zCOa/9rJAh0B2
JVcCHiL5JCBXealzqmoSa6TSUIENtCJN7KhNjhDH2kk69rMpbzXiIcq6F2lqjglp
iAg9XCv6bFKT4JxQIfwuMJ8VnEECvCOP1teQ5zlcrBqqW95e6O77Ia79bVOL8LQp
+CLtLkBOfh7IodpZfd1UNySF/X2P7f2aKxiVgQ4hEXG5ZhrEFkKAqQCa1LmuxB66
QFDCCrFD71l2lyYQQrLpL+5eVXlPnTlbpH8sDIC+10LOPXY067GNhPss05gl3cuC
hwbgwUm0+xEJ/eS4RbnEDlFfyO1kng==
=mdD4
-----END PGP SIGNATURE-----

--CBh45NZv3ZVmJdM7--

