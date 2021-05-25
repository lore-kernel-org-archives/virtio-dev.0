Return-Path: virtio-dev-return-8175-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7088E9864C1
	for <virtio-dev@lists.oasis-open.org>; Tue, 25 May 2021 16:56:56 +0000 (UTC)
Date: Tue, 25 May 2021 17:56:50 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <YK0sUt2gDA2KgZ0D@stefanha-x1.localdomain>
References: <CABATKF9Vjf1NE0EjToKfp=1aPcGieeny1k8rkfVv6BFZ=+b4sw@mail.gmail.com>
 <YJ07vrCt3thO5MM/@stefanha-x1.localdomain>
 <CABATKF_vRfnkybEyj-PejKYPud0=FNPscRJ9=ztKzWiySnyHVQ@mail.gmail.com>
 <YKu6IZjRlLUun6TJ@stefanha-x1.localdomain>
 <CABATKF-a+V5CjBTANS-xW-zuC3zVpPcWiXkrfNFr1EaFGkdZhg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CABATKF-a+V5CjBTANS-xW-zuC3zVpPcWiXkrfNFr1EaFGkdZhg@mail.gmail.com>
Subject: Re: [virtio-dev] [PATCH] Add virtio parameter server device
 specification
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FKcYCMU3NZUTIGVE"
Content-Disposition: inline
To: Hao Chen <chenhaosjtuacm@google.com>
Cc: virtio-dev@lists.oasis-open.org, Enrico Granata <egranata@google.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--FKcYCMU3NZUTIGVE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 24, 2021 at 11:45:43AM -0700, Hao Chen wrote:
> > Thanks for explaining. Would publishing a k-v store protocol spec for
> > use with vsock?
>=20
> Does "standard protocol over vsock" exist in virtio-spec? We can say
> "we use this protocol on vsock for this device, and it works very
> well", but I guess it is still different than writing it somewhere in
> the spec.

Right, there is not vsock protocol authority but anyone can publish the
necessary information themselves or through a standards body. If your
goal is just to have a standard protocol then I think you can make it
much easier for others to implement by publishing your own protocol spec
that runs over a vsock socket.

Again, I'm not against adding this as a VIRTIO device. If you decide it
needs to be a VIRTIO device I'd be happy to review this patch fully.

Stefan

--FKcYCMU3NZUTIGVE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmCtLFIACgkQnKSrs4Gr
c8i/Qgf/QgB0EKwCEDbj58mUFZ43eOkrFws5+D8ly3NLUb1wLXaRCVJ1alD90gKW
yUfdlbGbi/XbDo4mrmDgL6yikssks7QIMMEyjFBQ5+CczeDZU6GU9zmIinrQoOD/
JwIKYpgVvntUCgpjVAqPks0u0yAlUZ2h0Qvdeo9G6B0vt7zg3WpZM6rfCnY3WrhE
5phv6zi7EItNQHV5fAYPnkgocgVQjNWkWwkc6GkBThjVTp3rfoVAKRw0cf9X4Gg0
xySF3upYGMloYA4+b4Z67jx/RVKuaStHC6fAY8dixYL+RNPrus0n3HCDH8nnM3Ns
1DPCWIWMNroqa+2YCWRO1aKoHTJIzA==
=9fJb
-----END PGP SIGNATURE-----

--FKcYCMU3NZUTIGVE--

