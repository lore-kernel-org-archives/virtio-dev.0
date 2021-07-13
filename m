Return-Path: <stefanha@redhat.com>
Date: Tue, 13 Jul 2021 11:00:35 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [virtio-comment] [PATCH V2 2/2] virtio: introduce STOP status bit
Message-ID: <YO1kQ8sBkr2eguvi@stefanha-x1.localdomain>
References: <20210706043334.36359-1-jasowang@redhat.com>
 <20210706043334.36359-3-jasowang@redhat.com>
 <YOQhW9MUlv5ohe05@work-vm>
 <52e1347c-9363-8ff8-e36c-2681b42e4c37@redhat.com>
 <CAJaqyWeQQZopTWDxnG3yUyS9qyGSXYTj3KwuhFqbzKih3te6AQ@mail.gmail.com>
 <20210710163326-mutt-send-email-mst@kernel.org>
 <778ffa63-c0ca-2faa-32da-3c5e71dd1dfe@redhat.com>
 <YOwSGeL+lfTxHuXg@stefanha-x1.localdomain>
 <3ce9775c-64fa-1c9b-6627-55f3b18ac987@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YPL/1qp5RUz618ZH"
Content-Disposition: inline
In-Reply-To: <3ce9775c-64fa-1c9b-6627-55f3b18ac987@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Eugenio Perez Martin <eperezma@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, virtio-comment@lists.oasis-open.org, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Max Gurtovoy <mgurtovoy@nvidia.com>, Cornelia Huck <cohuck@redhat.com>, Oren Duer <oren@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Bodong Wang <bodong@nvidia.com>, Alexander Mikheev <amikheev@nvidia.com>, Halil Pasic <pasic@linux.ibm.com>
List-ID: <virtio-dev.lists.oasis-open.org>


--YPL/1qp5RUz618ZH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 13, 2021 at 11:27:03AM +0800, Jason Wang wrote:
>=20
> =E5=9C=A8 2021/7/12 =E4=B8=8B=E5=8D=885:57, Stefan Hajnoczi =E5=86=99=E9=
=81=93:
> > On Mon, Jul 12, 2021 at 12:00:39PM +0800, Jason Wang wrote:
> > > =E5=9C=A8 2021/7/11 =E4=B8=8A=E5=8D=884:36, Michael S. Tsirkin =E5=86=
=99=E9=81=93:
> > > > On Fri, Jul 09, 2021 at 07:23:33PM +0200, Eugenio Perez Martin wrot=
e:
> > > > > > >     If I understand correctly, this is all
> > > > > > > driven from the driver inside the guest, so for this to work
> > > > > > > the guest must be running and already have initialised the dr=
iver.
> > > > > > Yes.
> > > > > >=20
> > > > > As I see it, the feature can be driven entirely by the VMM as lon=
g as
> > > > > it intercept the relevant configuration space (PCI, MMIO, etc) fr=
om
> > > > > guest's reads and writes, and present it as coherent and transpar=
ent
> > > > > for the guest. Some use cases I can imagine with a physical devic=
e (or
> > > > > vp_vpda device) with VIRTIO_F_STOP:
> > > > >=20
> > > > > 1) The VMM chooses not to pass the feature flag. The guest cannot=
 stop
> > > > > the device, so any write to this flag is an error/undefined.
> > > > > 2) The VMM passes the flag to the guest. The guest can stop the d=
evice.
> > > > > 2.1) The VMM stops the device to perform a live migration, and the
> > > > > guest does not write to STOP in any moment of the LM. It resets t=
he
> > > > > destination device with the state, and then initializes the devic=
e.
> > > > > 2.2) The guest stops the device and, when STOP(32) is set, the so=
urce
> > > > > VMM migrates the device status. The destination VMM realizes the =
bit,
> > > > > so it sets the bit in the destination too after device initializa=
tion.
> > > > > 2.3) The device is not initialized by the guest so it doesn't mat=
ter
> > > > > what bit has the HW, but the VM can be migrated.
> > > > >=20
> > > > > Am I missing something?
> > > > >=20
> > > > > Thanks!
> > > > It's doable like this. It's all a lot of hoops to jump through thou=
gh.
> > > > It's also not easy for devices to implement.
> > >=20
> > > It just requires a new status bit. Anything that makes you think it's=
 hard
> > > to implement?
> > >=20
> > > E.g for networking device, it should be sufficient to use this bit + =
the
> > > virtqueue state.
> > >=20
> > >=20
> > > > Why don't we design the feature in a way that is useable by VMMs
> > > > and implementable by devices in a simple way?
> > >=20
> > > It use the common technology like register shadowing without any furt=
her
> > > stuffs.
> > >=20
> > > Or do you have any other ideas?
> > >=20
> > > (I think we all know migration will be very hard if we simply pass th=
rough
> > > those state registers).
> > If an admin virtqueue is used instead of the STOP Device Status field
> > bit then there's no need to re-read the Device Status field in a loop
> > until the device has stopped.
>=20
>=20
> Probably not. Let me to clarify several points:
>=20
> - This proposal has nothing to do with admin virtqueue. Actually, admin
> virtqueue could be used for carrying any basic device facility like status
> bit. E.g I'm going to post patches that use admin virtqueue as a "transpo=
rt"
> for device slicing at virtio level.
> - Even if we had introduced admin virtqueue, we still need a per function
> interface for this. This is a must for nested virtualization, we can't
> always expect things like PF can be assigned to L1 guest.
> - According to the proposal, there's no need for the device to complete a=
ll
> the consumed buffers, device can choose to expose those inflight descript=
ors
> in a device specific way and set the STOP bit. This means, if we have the
> device specific in-flight descriptor reporting facility, the device can
> almost set the STOP bit immediately.
> - If we don't go with the basic device facility but using the admin
> virtqueue specific method, we still need to clarify how it works with the
> device status state machine, it will be some kind of sub-states which loo=
ks
> much more complicated than the current proposal.
>=20
>=20
> >=20
> > When migrating a guest with many VIRTIO devices a busy waiting approach
> > extends downtime if implemented sequentially (stopping one device at a
> > time).
>=20
>=20
> Well. You need some kinds of waiting for sure, the device/DMA needs somet=
ime
> to be stopped. The downtime is determined by a specific virtio
> implementation which is hard to be restricted at the spec level. We can
> clarify that the device must set the STOP bit in e.g 100ms.
>=20
>=20
> >   It can be implemented concurrently (setting the STOP bit on all
> > devices and then looping until all their Device Status fields have the
> > bit set), but this becomes more complex to implement.
>=20
>=20
> I still don't get what kind of complexity did you worry here.
>=20
>=20
> >=20
> > I'm a little worried about adding a new bit that requires busy
> > waiting...
>=20
>=20
> Busy wait is not something that is introduced in this patch:
>=20
> 4.1.4.3.2 Driver Requirements: Common configuration structure layout
>=20
> After writing 0 to device_status, the driver MUST wait for a read of
> device_status to return 0 before reinitializing the device.
>=20
> Since it was required for at least one transport. We need do something
> similar to when introducing basic facility.

Adding the STOP but as a Device Status bit is a small and clean VIRTIO
spec change. I like that.

On the other hand, devices need time to stop and that time can be
unbounded. For example, software virtio-blk/scsi implementations since
cannot immediately cancel in-flight I/O requests on Linux hosts.

The natural interface for long-running operations is virtqueue requests.
That's why I mentioned the alternative of using an admin virtqueue
instead of a Device Status bit.

Although you mentioned that the stopped state needs to be reflected in
the Device Status field somehow, I'm not sure about that since the
driver typically doesn't need to know whether the device is being
migrated. In fact, the VMM would need to hide this bit and it's safer to
keep it out-of-band instead of risking exposing it by accident.

In addition, stateful devices need to load/save non-trivial amounts of
data. They need DMA to do this efficiently, so an admin virtqueue is a
good fit again. This isn't addressed in this patch series, but it's the
next step and I think it's worth planning for it.

If all devices could stop very quickly and were stateless then I would
agree that the STOP bit is an ideal solution. I think it will be
necessary to support devices that don't behave like that, so the admin
virtqueue approach seems worth exploring.

Stefan

--YPL/1qp5RUz618ZH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmDtZEMACgkQnKSrs4Gr
c8ijbQf+ITWSidOSX2GYgCTsoL/JvJKbsBDfGiun7Qfi68yqcM9lqO0kcvNR/FZe
6qmYp8+DO2Cmt1+o/bfvY7WvNGmNCWZqpST+0fEbbCeigxHZw0/Wu/3oh9P5KrkQ
n9d7wWRrVPdgWvIQVztSUwjDXtNBbB+0yMBGFOrW63dW5ZnA0TnJJrTVIXedzzPh
7ezWgt5SLS+jyRToxsjdx9ZWpf/IgQwWjvYn8p/QX7x3bk/LLrAtvU31+zjTadMJ
lRCAGFE8hFY3XzUpn0piBEK8oE3V/QYM5Q1bufiN3tVZ5qIL0405iBNdwWAA3Zic
bxtWq8ZVLMGhkOpsKJ/cJK+GlqSlGA==
=PdLW
-----END PGP SIGNATURE-----

--YPL/1qp5RUz618ZH--

