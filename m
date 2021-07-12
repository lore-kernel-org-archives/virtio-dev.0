Return-Path: <stefanha@redhat.com>
Date: Mon, 12 Jul 2021 10:57:45 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [virtio-comment] [PATCH V2 2/2] virtio: introduce STOP status bit
Message-ID: <YOwSGeL+lfTxHuXg@stefanha-x1.localdomain>
References: <20210706043334.36359-1-jasowang@redhat.com>
 <20210706043334.36359-3-jasowang@redhat.com>
 <YOQhW9MUlv5ohe05@work-vm>
 <52e1347c-9363-8ff8-e36c-2681b42e4c37@redhat.com>
 <CAJaqyWeQQZopTWDxnG3yUyS9qyGSXYTj3KwuhFqbzKih3te6AQ@mail.gmail.com>
 <20210710163326-mutt-send-email-mst@kernel.org>
 <778ffa63-c0ca-2faa-32da-3c5e71dd1dfe@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="c+SZ1qLIV8NWdGDs"
Content-Disposition: inline
In-Reply-To: <778ffa63-c0ca-2faa-32da-3c5e71dd1dfe@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Eugenio Perez Martin <eperezma@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, virtio-comment@lists.oasis-open.org, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Max Gurtovoy <mgurtovoy@nvidia.com>, Cornelia Huck <cohuck@redhat.com>, Oren Duer <oren@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Bodong Wang <bodong@nvidia.com>, Alexander Mikheev <amikheev@nvidia.com>, Halil Pasic <pasic@linux.ibm.com>
List-ID: <virtio-dev.lists.oasis-open.org>


--c+SZ1qLIV8NWdGDs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 12, 2021 at 12:00:39PM +0800, Jason Wang wrote:
>=20
> =E5=9C=A8 2021/7/11 =E4=B8=8A=E5=8D=884:36, Michael S. Tsirkin =E5=86=99=
=E9=81=93:
> > On Fri, Jul 09, 2021 at 07:23:33PM +0200, Eugenio Perez Martin wrote:
> > > > >    If I understand correctly, this is all
> > > > > driven from the driver inside the guest, so for this to work
> > > > > the guest must be running and already have initialised the driver.
> > > >=20
> > > > Yes.
> > > >=20
> > > As I see it, the feature can be driven entirely by the VMM as long as
> > > it intercept the relevant configuration space (PCI, MMIO, etc) from
> > > guest's reads and writes, and present it as coherent and transparent
> > > for the guest. Some use cases I can imagine with a physical device (or
> > > vp_vpda device) with VIRTIO_F_STOP:
> > >=20
> > > 1) The VMM chooses not to pass the feature flag. The guest cannot stop
> > > the device, so any write to this flag is an error/undefined.
> > > 2) The VMM passes the flag to the guest. The guest can stop the devic=
e.
> > > 2.1) The VMM stops the device to perform a live migration, and the
> > > guest does not write to STOP in any moment of the LM. It resets the
> > > destination device with the state, and then initializes the device.
> > > 2.2) The guest stops the device and, when STOP(32) is set, the source
> > > VMM migrates the device status. The destination VMM realizes the bit,
> > > so it sets the bit in the destination too after device initialization.
> > > 2.3) The device is not initialized by the guest so it doesn't matter
> > > what bit has the HW, but the VM can be migrated.
> > >=20
> > > Am I missing something?
> > >=20
> > > Thanks!
> > It's doable like this. It's all a lot of hoops to jump through though.
> > It's also not easy for devices to implement.
>=20
>=20
> It just requires a new status bit. Anything that makes you think it's hard
> to implement?
>=20
> E.g for networking device, it should be sufficient to use this bit + the
> virtqueue state.
>=20
>=20
> > Why don't we design the feature in a way that is useable by VMMs
> > and implementable by devices in a simple way?
>=20
>=20
> It use the common technology like register shadowing without any further
> stuffs.
>=20
> Or do you have any other ideas?
>=20
> (I think we all know migration will be very hard if we simply pass through
> those state registers).

If an admin virtqueue is used instead of the STOP Device Status field
bit then there's no need to re-read the Device Status field in a loop
until the device has stopped.

When migrating a guest with many VIRTIO devices a busy waiting approach
extends downtime if implemented sequentially (stopping one device at a
time). It can be implemented concurrently (setting the STOP bit on all
devices and then looping until all their Device Status fields have the
bit set), but this becomes more complex to implement.

I'm a little worried about adding a new bit that requires busy
waiting...

Stefan

--c+SZ1qLIV8NWdGDs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmDsEhkACgkQnKSrs4Gr
c8gYlwf4lrC8+UQsEK+yLlPKYympMNuDmBwGyPME2G0lknLBetuaNOmAdp3WyJ2D
Zp+DMbXNCEmuDO3zuz0FwduiEL+7UM5fkP4fFaUnaAlA7YYpTFOxNwrszdg/09HA
6QWekdBu/XtCiWgzaJKcMhVuy5ntKopVp3uahNV9mMRsw83ONfFJ5NPaibfGA7dt
LOlSWcwbgPEU3oXKBtXXKeurUDGow1sV2g4FCDGdjGeZnEaJKisnP4Oz0iHevORf
JECBS89Yz+QUuj2T9ji0IeDoz7sWQoDQYkngA37gKKaJ/Dzg9d+WSBoWPzD8IcXw
0p26OcC7wqC6cg21Gpsk6lv+cvaJ
=GDsX
-----END PGP SIGNATURE-----

--c+SZ1qLIV8NWdGDs--

