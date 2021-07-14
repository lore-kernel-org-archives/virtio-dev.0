Return-Path: <stefanha@redhat.com>
Date: Wed, 14 Jul 2021 10:53:34 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [virtio-comment] [PATCH V2 2/2] virtio: introduce STOP status bit
Message-ID: <YO60HpxfZnmfMCMj@stefanha-x1.localdomain>
References: <20210706043334.36359-3-jasowang@redhat.com>
 <YOQhW9MUlv5ohe05@work-vm>
 <52e1347c-9363-8ff8-e36c-2681b42e4c37@redhat.com>
 <CAJaqyWeQQZopTWDxnG3yUyS9qyGSXYTj3KwuhFqbzKih3te6AQ@mail.gmail.com>
 <20210710163326-mutt-send-email-mst@kernel.org>
 <778ffa63-c0ca-2faa-32da-3c5e71dd1dfe@redhat.com>
 <YOwSGeL+lfTxHuXg@stefanha-x1.localdomain>
 <3ce9775c-64fa-1c9b-6627-55f3b18ac987@redhat.com>
 <YO1kQ8sBkr2eguvi@stefanha-x1.localdomain>
 <8a2037df-e527-dcb4-c4c8-a568885180e4@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zIUoXp8W1U7UuEEZ"
Content-Disposition: inline
In-Reply-To: <8a2037df-e527-dcb4-c4c8-a568885180e4@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Eugenio Perez Martin <eperezma@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, virtio-comment@lists.oasis-open.org, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Max Gurtovoy <mgurtovoy@nvidia.com>, Cornelia Huck <cohuck@redhat.com>, Oren Duer <oren@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Bodong Wang <bodong@nvidia.com>, Alexander Mikheev <amikheev@nvidia.com>, Halil Pasic <pasic@linux.ibm.com>
List-ID: <virtio-dev.lists.oasis-open.org>


--zIUoXp8W1U7UuEEZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 13, 2021 at 08:16:35PM +0800, Jason Wang wrote:
>=20
> =E5=9C=A8 2021/7/13 =E4=B8=8B=E5=8D=886:00, Stefan Hajnoczi =E5=86=99=E9=
=81=93:
> > On Tue, Jul 13, 2021 at 11:27:03AM +0800, Jason Wang wrote:
> > > =E5=9C=A8 2021/7/12 =E4=B8=8B=E5=8D=885:57, Stefan Hajnoczi =E5=86=99=
=E9=81=93:
> > > > On Mon, Jul 12, 2021 at 12:00:39PM +0800, Jason Wang wrote:
> > > > > =E5=9C=A8 2021/7/11 =E4=B8=8A=E5=8D=884:36, Michael S. Tsirkin =
=E5=86=99=E9=81=93:
> > > > > > On Fri, Jul 09, 2021 at 07:23:33PM +0200, Eugenio Perez Martin =
wrote:
> > > > > > > > >      If I understand correctly, this is all
> > > > > > > > > driven from the driver inside the guest, so for this to w=
ork
> > > > > > > > > the guest must be running and already have initialised th=
e driver.
> > > > > > > > Yes.
> > > > > > > >=20
> > > > > > > As I see it, the feature can be driven entirely by the VMM as=
 long as
> > > > > > > it intercept the relevant configuration space (PCI, MMIO, etc=
) from
> > > > > > > guest's reads and writes, and present it as coherent and tran=
sparent
> > > > > > > for the guest. Some use cases I can imagine with a physical d=
evice (or
> > > > > > > vp_vpda device) with VIRTIO_F_STOP:
> > > > > > >=20
> > > > > > > 1) The VMM chooses not to pass the feature flag. The guest ca=
nnot stop
> > > > > > > the device, so any write to this flag is an error/undefined.
> > > > > > > 2) The VMM passes the flag to the guest. The guest can stop t=
he device.
> > > > > > > 2.1) The VMM stops the device to perform a live migration, an=
d the
> > > > > > > guest does not write to STOP in any moment of the LM. It rese=
ts the
> > > > > > > destination device with the state, and then initializes the d=
evice.
> > > > > > > 2.2) The guest stops the device and, when STOP(32) is set, th=
e source
> > > > > > > VMM migrates the device status. The destination VMM realizes =
the bit,
> > > > > > > so it sets the bit in the destination too after device initia=
lization.
> > > > > > > 2.3) The device is not initialized by the guest so it doesn't=
 matter
> > > > > > > what bit has the HW, but the VM can be migrated.
> > > > > > >=20
> > > > > > > Am I missing something?
> > > > > > >=20
> > > > > > > Thanks!
> > > > > > It's doable like this. It's all a lot of hoops to jump through =
though.
> > > > > > It's also not easy for devices to implement.
> > > > > It just requires a new status bit. Anything that makes you think =
it's hard
> > > > > to implement?
> > > > >=20
> > > > > E.g for networking device, it should be sufficient to use this bi=
t + the
> > > > > virtqueue state.
> > > > >=20
> > > > >=20
> > > > > > Why don't we design the feature in a way that is useable by VMMs
> > > > > > and implementable by devices in a simple way?
> > > > > It use the common technology like register shadowing without any =
further
> > > > > stuffs.
> > > > >=20
> > > > > Or do you have any other ideas?
> > > > >=20
> > > > > (I think we all know migration will be very hard if we simply pas=
s through
> > > > > those state registers).
> > > > If an admin virtqueue is used instead of the STOP Device Status fie=
ld
> > > > bit then there's no need to re-read the Device Status field in a lo=
op
> > > > until the device has stopped.
> > >=20
> > > Probably not. Let me to clarify several points:
> > >=20
> > > - This proposal has nothing to do with admin virtqueue. Actually, adm=
in
> > > virtqueue could be used for carrying any basic device facility like s=
tatus
> > > bit. E.g I'm going to post patches that use admin virtqueue as a "tra=
nsport"
> > > for device slicing at virtio level.
> > > - Even if we had introduced admin virtqueue, we still need a per func=
tion
> > > interface for this. This is a must for nested virtualization, we can't
> > > always expect things like PF can be assigned to L1 guest.
> > > - According to the proposal, there's no need for the device to comple=
te all
> > > the consumed buffers, device can choose to expose those inflight desc=
riptors
> > > in a device specific way and set the STOP bit. This means, if we have=
 the
> > > device specific in-flight descriptor reporting facility, the device c=
an
> > > almost set the STOP bit immediately.
> > > - If we don't go with the basic device facility but using the admin
> > > virtqueue specific method, we still need to clarify how it works with=
 the
> > > device status state machine, it will be some kind of sub-states which=
 looks
> > > much more complicated than the current proposal.
> > >=20
> > >=20
> > > > When migrating a guest with many VIRTIO devices a busy waiting appr=
oach
> > > > extends downtime if implemented sequentially (stopping one device a=
t a
> > > > time).
> > >=20
> > > Well. You need some kinds of waiting for sure, the device/DMA needs s=
ometime
> > > to be stopped. The downtime is determined by a specific virtio
> > > implementation which is hard to be restricted at the spec level. We c=
an
> > > clarify that the device must set the STOP bit in e.g 100ms.
> > >=20
> > >=20
> > > >    It can be implemented concurrently (setting the STOP bit on all
> > > > devices and then looping until all their Device Status fields have =
the
> > > > bit set), but this becomes more complex to implement.
> > >=20
> > > I still don't get what kind of complexity did you worry here.
> > >=20
> > >=20
> > > > I'm a little worried about adding a new bit that requires busy
> > > > waiting...
> > >=20
> > > Busy wait is not something that is introduced in this patch:
> > >=20
> > > 4.1.4.3.2 Driver Requirements: Common configuration structure layout
> > >=20
> > > After writing 0 to device_status, the driver MUST wait for a read of
> > > device_status to return 0 before reinitializing the device.
> > >=20
> > > Since it was required for at least one transport. We need do something
> > > similar to when introducing basic facility.
> > Adding the STOP but as a Device Status bit is a small and clean VIRTIO
> > spec change. I like that.
> >=20
> > On the other hand, devices need time to stop and that time can be
> > unbounded. For example, software virtio-blk/scsi implementations since
> > cannot immediately cancel in-flight I/O requests on Linux hosts.
> >=20
> > The natural interface for long-running operations is virtqueue requests.
> > That's why I mentioned the alternative of using an admin virtqueue
> > instead of a Device Status bit.
>=20
>=20
> So I'm not against the admin virtqueue. As said before, admin virtqueue
> could be used for carrying the device status bit.
>=20
> Send a command to set STOP status bit to admin virtqueue. Device will make
> the command buffer used after it has successfully stopped the device.
>=20
> AFAIK, they are not mutually exclusive, since they are trying to solve
> different problems.
>=20
> Device status - basic device facility
>=20
> Admin virtqueue - transport/device specific way to implement (part of) the
> device facility
>=20
> >=20
> > Although you mentioned that the stopped state needs to be reflected in
> > the Device Status field somehow, I'm not sure about that since the
> > driver typically doesn't need to know whether the device is being
> > migrated.
>=20
>=20
> The guest won't see the real device status bit. VMM will shadow the device
> status bit in this case.
>=20
> E.g with the current vhost-vDPA, vDPA behave like a vhost device, guest is
> unaware of the migration.
>=20
> STOP status bit is set by Qemu to real virtio hardware. But guest will on=
ly
> see the DRIVER_OK without STOP.
>=20
> It's not hard to implement the nested on top, see the discussion initiated
> by Eugenio about how expose VIRTIO_F_STOP to guest for nested live
> migration.
>=20
>=20
> >   In fact, the VMM would need to hide this bit and it's safer to
> > keep it out-of-band instead of risking exposing it by accident.
>=20
>=20
> See above, VMM may choose to hide or expose the capability. It's useful f=
or
> migrating a nested guest.
>=20
> If we design an interface that can be used in the nested environment, it's
> not an ideal interface.
>=20
>=20
> >=20
> > In addition, stateful devices need to load/save non-trivial amounts of
> > data. They need DMA to do this efficiently, so an admin virtqueue is a
> > good fit again.
>=20
>=20
> I don't get the point here. You still need to address the exact the simil=
ar
> issues for admin virtqueue: the unbound time in freezing the device, the
> interaction with the virtio device status state machine.

Device state state can be large so a register interface would be a
bottleneck. DMA is needed. I think a virtqueue is a good fit for
saving/loading device state.

If we're going to need it for saving/loading device state anyway, then
that's another reason to consider using a virtqueue for stopping the
device, saving/loading virtqueue state, etc.

> And with admin virtqueue, it's actually far more complicated e.g you need=
 to
> define how to synchronize the concurrent access to the basic facilites.

I'm not sure I understand? Driver complexity? Device implementation
complexity?

> >   This isn't addressed in this patch series, but it's the
> > next step and I think it's worth planning for it.
>=20
>=20
> I agree, but for admin virtqueue, it's better to use it as a full transpo=
rt
> instead of just use it for carrying part of the device basic facilities.
> Actually, as I said, I had patches to do that. But the motivation is not =
for
> live migration but for device slicing. I will post RFC before the KVM For=
um
> this year (since I'm going to talk device slicing at virtio level). It do=
es
> not conflict with Max's proposal, since migration part is not there.

Great, I'm looking forward to your device slicing idea.

> > If all devices could stop very quickly and were stateless then I would
> > agree that the STOP bit is an ideal solution.
>=20
>=20
> Note that in Max's proposal it also have something similar the "quiescenc=
e"
> and "freezed" state. It doesn't differ from STOP bit fundamentally. As Max
> suggested, we could introduce more status bit if necessary or even consid=
er
> to unify Max's proposal with mine.
>=20
>=20
> > I think it will be
> > necessary to support devices that don't behave like that, so the admin
> > virtqueue approach seems worth exploring.
>=20
>=20
> Yes and as mentioned in another thread. I think the best way is to define
> the device specific state first and then consider how to implement the
> interface.
>=20
> Admin virtqueue is worth to explore but should not be the only method.
> Device/transport are freed to implement it in many ways based on the actu=
al
> hardware.

What's the advantage of this proposal compared to an admin virtqueue? I
see the admin virtqueue as a more general interface than this proposal
and it can cover this use case.

Stefan

--zIUoXp8W1U7UuEEZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmDutB4ACgkQnKSrs4Gr
c8haPggAjZLlzX/MQZiC+C49jMNDVY0dpoMd1Gv2XHLoFxDHhllMzckTsXp6d5n7
XkXX6WwUx/vcgFunj1SkttlhJ9CxFlz5y5v3aADLmv6Q/7lovpwFdhGtAlyd/9XV
ovkoc57SI3RCI4UrB8h2UiSXy3BqkJYml2wdpIbTbbZxuZOFDVwW8Lw0t1KYTMnz
gpfUkqMgAdr1V8C7uc6kznFk4sKK+QZhkON5umAA7eunVn47aeyzMV6GnTgZA9Q1
pRgRx9mopbsppkIxBFXKAq92cKgZLNkSpirfL4PGlbQwx4uvrORCBz7sCpDRTYwt
4gcqcVQiIsNe2kOHZEhxeMUytwf38A==
=eOJn
-----END PGP SIGNATURE-----

--zIUoXp8W1U7UuEEZ--

