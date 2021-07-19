Return-Path: <stefanha@redhat.com>
Date: Mon, 19 Jul 2021 13:18:04 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [virtio-dev] Re: [virtio-comment] [PATCH V2 2/2] virtio:
 introduce STOP status bit
Message-ID: <YPVtfFhirxeXeoFJ@stefanha-x1.localdomain>
References: <YOwSGeL+lfTxHuXg@stefanha-x1.localdomain>
 <3ce9775c-64fa-1c9b-6627-55f3b18ac987@redhat.com>
 <YO1kQ8sBkr2eguvi@stefanha-x1.localdomain>
 <8a2037df-e527-dcb4-c4c8-a568885180e4@redhat.com>
 <YO60HpxfZnmfMCMj@stefanha-x1.localdomain>
 <094e15d4-169a-87e9-5ebb-93439ea72831@redhat.com>
 <YO79tuI72kTEWURN@stefanha-x1.localdomain>
 <1ab19438-cc13-bbe5-7fec-53a113d85463@redhat.com>
 <YO/8/LaHihUE1bhN@stefanha-x1.localdomain>
 <db6540cc-55f0-ec66-447a-4d70dcdc97bd@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8ibj+dw6QRHmskjV"
Content-Disposition: inline
In-Reply-To: <db6540cc-55f0-ec66-447a-4d70dcdc97bd@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Eugenio Perez Martin <eperezma@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, virtio-comment@lists.oasis-open.org, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Max Gurtovoy <mgurtovoy@nvidia.com>, Cornelia Huck <cohuck@redhat.com>, Oren Duer <oren@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Bodong Wang <bodong@nvidia.com>, Alexander Mikheev <amikheev@nvidia.com>, Halil Pasic <pasic@linux.ibm.com>
List-ID: <virtio-dev.lists.oasis-open.org>


--8ibj+dw6QRHmskjV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 16, 2021 at 09:44:26AM +0800, Jason Wang wrote:
>=20
> =E5=9C=A8 2021/7/15 =E4=B8=8B=E5=8D=885:16, Stefan Hajnoczi =E5=86=99=E9=
=81=93:
> > On Thu, Jul 15, 2021 at 09:35:13AM +0800, Jason Wang wrote:
> > > =E5=9C=A8 2021/7/14 =E4=B8=8B=E5=8D=8811:07, Stefan Hajnoczi =E5=86=
=99=E9=81=93:
> > > > On Wed, Jul 14, 2021 at 06:29:28PM +0800, Jason Wang wrote:
> > > > > And as I've stated several times, virtqueue is the interface or t=
ransport
> > > > > which carries the commands for implementing specific semantics. I=
t doesn't
> > > > > conflict with what is proposed in this patch.
> > > > The abstract operations for stopping the device and fetching virtqu=
eue
> > > > state sound good to me, but I don't think a Device Status field STO=
P bit
> > > > should be added. An out-of-band stop operation would support devices
> > > > that take a long time to stop better.
> > >=20
> > > So the long time request is not something that is introduced by the S=
TOP
> > > bit. Spec already use that for reset.
> > Reset doesn't affect migration downtime. The register polling approach
> > is problematic during migration downtime because it's difficult to stop
> > multiple devices and do other downtime cleanup concurrently.
>=20
>=20
> This part I don't understand. We don't have an centralized control path t=
hat
> is used for each virtual functions.
>=20
> VMM is free to stop multiple devices and poll for all those device status?

Yes, it's possible to do that but I think it's harder for VMMs to
implement and consumes CPU (which competes with software devices that
are trying to stop).

Stefan

--8ibj+dw6QRHmskjV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmD1bXwACgkQnKSrs4Gr
c8h1xAf9Ed6lSJ+JjRpmgvacZbj4T6DUvdebO4GPsIZPsxvLoaqKSa0KF4QYht8m
wyM17xv8EWlXaepT5DXz3z3XKITmIOGTvpwMrHGJ6V2cezdboCV1kBGmU+An/ZKK
dGUdzTVEJahxAEu50PCmip+0e8F0ZUXUEn9Hx9hvHWnW+lHvLoYf5WfVHOgd0MXA
TfyfCZTSA1oNMwVhTpHyZXCcl5g1X4A9HfTmHkV58B2n4ZbziKvWNR9pj6WLG4mG
avRoRUUttwcqCLPZUSfy0AF7PHlboMNtyZdiaKhXGJdLU0xTYLh6Wa7hno+yuyUp
aDhB5jDuVqRcoHHczzfsoMUEpxnejQ==
=gMFB
-----END PGP SIGNATURE-----

--8ibj+dw6QRHmskjV--

