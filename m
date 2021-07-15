Return-Path: <virtio-dev-return-8289-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 752EA9864BA
	for <virtio-dev@lists.oasis-open.org>; Thu, 15 Jul 2021 09:16:54 +0000 (UTC)
Date: Thu, 15 Jul 2021 10:16:44 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <YO/8/LaHihUE1bhN@stefanha-x1.localdomain>
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
In-Reply-To: <1ab19438-cc13-bbe5-7fec-53a113d85463@redhat.com>
Subject: [virtio-dev] Re: [virtio-comment] [PATCH V2 2/2] virtio: introduce STOP status bit
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yPp4m4aq9iMBtiwJ"
Content-Disposition: inline
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Eugenio Perez Martin <eperezma@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, virtio-comment@lists.oasis-open.org, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Max Gurtovoy <mgurtovoy@nvidia.com>, Cornelia Huck <cohuck@redhat.com>, Oren Duer <oren@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Bodong Wang <bodong@nvidia.com>, Alexander Mikheev <amikheev@nvidia.com>, Halil Pasic <pasic@linux.ibm.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--yPp4m4aq9iMBtiwJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 15, 2021 at 09:35:13AM +0800, Jason Wang wrote:
> =E5=9C=A8 2021/7/14 =E4=B8=8B=E5=8D=8811:07, Stefan Hajnoczi =E5=86=99=E9=
=81=93:
> > On Wed, Jul 14, 2021 at 06:29:28PM +0800, Jason Wang wrote:
> > > And as I've stated several times, virtqueue is the interface or trans=
port
> > > which carries the commands for implementing specific semantics. It do=
esn't
> > > conflict with what is proposed in this patch.
> > The abstract operations for stopping the device and fetching virtqueue
> > state sound good to me, but I don't think a Device Status field STOP bi=
t
> > should be added. An out-of-band stop operation would support devices
> > that take a long time to stop better.
>=20
>=20
> So the long time request is not something that is introduced by the STOP
> bit. Spec already use that for reset.

Reset doesn't affect migration downtime. The register polling approach
is problematic during migration downtime because it's difficult to stop
multiple devices and do other downtime cleanup concurrently. Stopping
devices sequentially increases migration downtime, so I think the
interface should encourage concurrently stopping multiple devices.

I think you and Cornelia discussed that an interrupt could be added to
solve this problem. That would address my concerns about the STOP bit.

Stefan

--yPp4m4aq9iMBtiwJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmDv/PwACgkQnKSrs4Gr
c8iZEwf+KJ0QQ0ldVqx5Meur3NTKAXmOyKzPDl9TVMgKwYXAq+qj78zpmVk1127w
/5d8Sm6yrTzhIOS6Ovd3s3BxYUo+JoF07bV08H/QH0h7KzqSpSTpnGFyBJsbMFB5
3pz1q2wYnwaauUAr6f6PAL4pEInBRyWYk2tea7h7lGv1214fHji/siUUOOGgn5T6
22/v2Etwi8Zig7T2hqhyV5Y9s4sdKyawA657y3ASOYIVoQ7y27jqwg79IA5ttatG
pLp9ZdCtMR/QF1FlHz4V4QqIARBnMg2WMVTjXbTSK9N+ehtnDCLbJigdySTssxGN
5V3/09YANCz9wMPqAr3ZepVNCax+lA==
=RXxm
-----END PGP SIGNATURE-----

--yPp4m4aq9iMBtiwJ--

