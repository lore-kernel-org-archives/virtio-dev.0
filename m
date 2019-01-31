Return-Path: virtio-dev-return-5359-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C9260985F77
	for <virtio-dev@lists.oasis-open.org>; Thu, 31 Jan 2019 02:37:46 +0000 (UTC)
Date: Thu, 31 Jan 2019 10:37:40 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190131023740.GA21248@stefanha-x1.localdomain>
References: <20190130085718.15931-1-stefanha@redhat.com>
 <20190130115017-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
Content-Disposition: inline
In-Reply-To: <20190130115017-mutt-send-email-mst@kernel.org>
Subject: [virtio-dev] Re: [PATCH] virtio-blk: document data[] size constraints
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, Changpeng Liu <changpeng.liu@intel.com>, Stefano Garzarella <sgarzare@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 30, 2019 at 12:01:01PM -0500, Michael S. Tsirkin wrote:
> On Wed, Jan 30, 2019 at 04:57:18PM +0800, Stefan Hajnoczi wrote:
> > The struct virtio_blk_req->data[] field is a multiple of 512 bytes long
> > for read and write requests.  Flush requests don't use data[] at all.
> >=20
> > The new discard and write zeroes requests being introduced in VIRTIO 1.1
> > put struct virtio_blk_discard_write_zeroes elements into data[], so it
> > must be a multiple of the struct size.
> >=20
> > The uint8_t data[][512] pseudo-code makes it look like discard and write
> > zeroes requests must pad to 512 bytes.  This wastes memory since struct
> > virtio_blk_discard_write_data is only 16 bytes long.
> >=20
> > Furthermore, all known implementations wishing to take advantage of this
> > upcoming VIRTIO 1.1 feature do not use 512-byte padding (Linux
> > virtio_blk.ko, QEMU virtio-blk device emulation, the SPDK virtio-blk
> > driver, and the SPDK vhost-user-blk device backend).
> >=20
> > This patch documents the data[] size constraints clearly in the driver
> > normative section.  This is clearer than the current pseudo-code.
> >=20
> > Cc: Michael S. Tsirkin <mst@redhat.com>
> > Cc: Changpeng Liu <changpeng.liu@intel.com>
> > Cc: Stefano Garzarella <sgarzare@redhat.com>
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>=20
> Yes I don't see how we can require 512 bytes there.
> Looks good, thanks!
> As a reminder next step is github issue, sending Fixes: tag and
> asking for a vote.
> I also noticed a couple of minor defects listed below.
> Would you mind taking a look and handling them?

Thanks, I have sent v2 and created the GitHub issue.

Stefan

--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcUl90AAoJEJykq7OBq3PI/asH/28/nmypOSI1WnHdbhN9V5Dz
HpMze5HN/Bw3fedpWTvGhca9qzUqjxJ985EUG6bKnj3iUCBEgjYOPPTc8rj6yBjM
ufB/Ur3RMiZgTxujgBYh98i7eMSFiL0br71gTbbZqeN/1bJsSorZ5U18s/z1N8hs
Zy3UMmGiRvVCs1oqqEE8GmJlZofnGoIw1ZVup1llhfB47rUXEggqS0W39RvzNfC1
pVognt+qxFEBduxyTtwCDvbRQZTe+X7uwTpDOfC5EST9hZ726qpSN8Sx2jFsLYXX
G0n57MA8GMDzEHSmOuM5ZiX2eKouqmn/GfU7dlRp0XhmbMoawnYjkAUJSVql00I=
=D9Ik
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--
