Return-Path: virtio-dev-return-5516-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C26E6985AA5
	for <virtio-dev@lists.oasis-open.org>; Mon, 25 Feb 2019 15:54:48 +0000 (UTC)
Date: Mon, 25 Feb 2019 15:54:45 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190225155445.GA379@stefanha-x1.localdomain>
References: <20190220124613.22661-1-stefanha@redhat.com>
 <20190220124613.22661-2-stefanha@redhat.com>
 <20190222143101.GE2574@work-vm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
Content-Disposition: inline
In-Reply-To: <20190222143101.GE2574@work-vm>
Subject: Re: [virtio-dev] [PATCH v3 1/2] content: add virtio file system
 device
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, Miklos Szeredi <mszeredi@redhat.com>, Sage Weil <sweil@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Steven Whitehouse <swhiteho@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 22, 2019 at 02:31:02PM +0000, Dr. David Alan Gilbert wrote:
> * Stefan Hajnoczi (stefanha@redhat.com) wrote:
>=20
> > +It is possible to maintain the FUSE session across live migration eith=
er by
> > +transferring the state or by redirecting requests from the new host to=
 the old
> > +host where the state resides.  The details of how to achieve this are
> > +implementation-dependent and are not visible at the device interface l=
evel.
>=20
> I wonder how 'transferring the state' will work;  it is tricky to
> specify because that state could be filesystem dependent so wouldn't
> really fit at this level of spec.

Yes, the state is file system daemon-specific and beyond the scope of
the VIRTIO device spec.

Stefan

--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcdA/FAAoJEJykq7OBq3PIU+wIAJnUxvnTD+aUGn3jUNIbch7p
qpVJisC1zqVZ3Ei4EG9TO1eCI++TttUourVjF/B5CKC4cUMS1Yac+AdL1pHP57h5
JyLzlJdtq1/nJR2Jr5fx43gNV4CLJsF96/82I2KpgAOF2SsEqs75dLFpEq8l0not
bf6F+mlcidKI8nHg5Fwr4vV6LXcxl+fGnM2HxYd3iwBtW5LsPwPy+7C6ExfUsOin
WrrgvIB2FZBIPCvXIWTpFjloqvHZqOLUY3ZAOjdkU2d5RTH9fqnPCApFLE4ixnv2
Em6I9NcnKbd+0pkfDe6p5c24lPjlOzJ6dwRpP5RQ/SYx/qTgjjX8R48RVQRdXLs=
=gRPL
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--
