Return-Path: <stefanha@redhat.com>
Date: Tue, 13 Jul 2021 11:30:33 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH V2 0/2] Vitqueue State Synchronization
Message-ID: <YO1rST8Vz3rrqqL4@stefanha-x1.localdomain>
References: <20210706043334.36359-1-jasowang@redhat.com>
 <YOwVc1V3k6+/xGHa@stefanha-x1.localdomain>
 <7cac6f07-2ea3-1d02-5706-abf93327224a@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="46B35ucF7k2Hnv4U"
Content-Disposition: inline
In-Reply-To: <7cac6f07-2ea3-1d02-5706-abf93327224a@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, mgurtovoy@nvidia.com, cohuck@redhat.com, eperezma@redhat.com, oren@nvidia.com, shahafs@nvidia.com, parav@nvidia.com, bodong@nvidia.com, amikheev@nvidia.com, pasic@linux.ibm.com
List-ID: <virtio-dev.lists.oasis-open.org>


--46B35ucF7k2Hnv4U
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 13, 2021 at 11:08:28AM +0800, Jason Wang wrote:
>=20
> =E5=9C=A8 2021/7/12 =E4=B8=8B=E5=8D=886:12, Stefan Hajnoczi =E5=86=99=E9=
=81=93:
> > On Tue, Jul 06, 2021 at 12:33:32PM +0800, Jason Wang wrote:
> > > Hi All:
> > >=20
> > > This is an updated version to implement virtqueue state
> > > synchronization which is a must for the migration support.
> > >=20
> > > The first patch introduces virtqueue states as a new basic facility of
> > > the virtio device. This is used by the driver to save and restore
> > > virtqueue state. The states were split into available state and used
> > > state to ease the transport specific implementation. It is also
> > > allowed for the device to have its own device specific way to save and
> > > resotre extra virtqueue states like in flight request.
> > >=20
> > > The second patch introduce a new status bit STOP. This bit is used for
> > > the driver to stop the device. The major difference from reset is that
> > > STOP must preserve all the virtqueue state plus the device state.
> > >=20
> > > A driver can then:
> > >=20
> > > - Get the virtqueue state if STOP status bit is set
> > > - Set the virtqueue state after FEATURE_OK but before DRIVER_OK
> > >=20
> > > Device specific state synchronization could be built on top.
> > Will you send a proof-of-concept implementation to demonstrate how it
> > works in practice?
>=20
>=20
> Eugenio has implemented a prototype for this. (Note that the codes was for
> previous version of the proposal, but it's sufficient to demonstrate how =
it
> works).
>=20
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg809332.html
>=20
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg809335.html
>=20
>=20
> >=20
> > You mentioned being able to migrate virtio-net devices using this
> > interface, but what about state like VIRTIO_NET_S_LINK_UP that is either
> > per-device or associated with a non-rx/tx virtqueue?
>=20
>=20
> Note that the config space will be maintained by Qemu. So Qemu can choose=
 to
> emulate link down by simply don't set DRIVER_OK to the device.
>=20
>=20
> >=20
> > Basically I'm not sure if the scope of this is just to migrate state
> > associated with offloaded virtqueues (vDPA, VFIO/mdev, etc) or if it's
> > really supposed to migrate the entire device?
>=20
>=20
> As the subject, it's the virtqueue state not the device state. The series
> tries to introduce the minimal sets of functions that could be used to
> migrate the network device.
>
>=20
>=20
> >=20
> > Do you have an approach in mind for saving/loading device-specific
> > state? Here are devices and their state:
> > - virtio-blk: a list of requests that the destination device can
> >    re-submit
> > - virtio-scsi: a list of requests that the destination device can
> >    re-submit
> > - virtio-serial: active ports, including the current buffer being
> >    transferred
>=20
>=20
> Actually, we had two types of additional states:
>=20
> - pending (or inflight) buffers, we can introduce a transport specific way
> to specify the auxiliary page which is used to stored the inflight
> descriptors (as what vhost-user did)
> - other device states, this needs to be done via a device specific way, a=
nd
> it would be hard to generalize them
>=20
>=20
> > - virtio-net: MAC address, status, etc
>=20
>=20
> So VMM will intercept all the control commands, that means we don't need =
to
> query any states that is changed via those control commands.
>=20
> E.g The Qemu is in charge of shadowing control virtqueue, so we don't even
> need to interface to query any of those states that is set via control
> virtqueue.
>=20
> But all those device state stuffs is out of the scope of this proposal.
>=20
> I can see one of the possible gap is that people may think the migration
> facility is designed for the simple passthrough that Linux provides, that
> means the device is assigend 'entirely' to the guest. This is not case for
> the case of live migration, some kind of mediation must be done in the
> middle.
>=20
> And that's the work of VMM through vDPA + Qemu: intercepting control comm=
and
> but not datapath.

I thought this was a more general migration mechanism that passthrough
devices could use. Thanks for explaining. Maybe this can be made clearer
in the spec - it's not a full save/load mechanism, it can only be used
in conjunction with another component that is aware of the device's
state.

There is a gap between this approach and VFIO's migration interface. It
appears to be impossible to write a VFIO/mdev or vfio-user device that
passes a physical virtio-pci device through to the guest with migration
support. The reason is because VIRTIO lacks an interface to save/load
device (not virtqueue) state. I guess it will be added sooner or later,
it's similar to what Max Gurtovoy recently proposed.

Stefan

--46B35ucF7k2Hnv4U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmDta0kACgkQnKSrs4Gr
c8jTuAgAqlf9md+IAJ6EtDpqzXgVFmfReDQaWtr7cOHqGzXfZ9aH9PDNBn2CBnE9
Jbz/FEfowfkO66cFmRkDrYYGmxZbnvOdIjdTwKjQhX0lxCyMgQW2+gu+8Uq/KcI6
52bu1/46f1fKnjLJeQhJl/ROlZyVGiEn1KVoTXSi2MUwldPrxGnDkzsHqH2mLPZk
oVzVbJkV4f2Sxtlzc1ie9NNm0QjizKCLNLh7Xk4qBR1/vlPdAqTXHwCfaEoIRYzM
VyUi/b8yhKEgZfp/zBN2B2eI44JMev2er1LsjrBWw/KiQXkWyQ2R/MLkAZB2Eue5
/G5HMTYQl+Uks2qgWB30tTP6DvRR4g==
=4ero
-----END PGP SIGNATURE-----

--46B35ucF7k2Hnv4U--

