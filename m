Return-Path: virtio-dev-return-6221-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AE660985DBE
	for <virtio-dev@lists.oasis-open.org>; Fri, 11 Oct 2019 08:49:18 +0000 (UTC)
Date: Fri, 11 Oct 2019 09:49:13 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20191011084913.GB2848@stefanha-x1.localdomain>
References: <1463684030-23555-1-git-send-email-stefanha@redhat.com>
 <dd3b5bfb-af0e-5d19-e208-c5f59e3895d7@opensynergy.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+g7M9IMkV8truYOl"
Content-Disposition: inline
In-Reply-To: <dd3b5bfb-af0e-5d19-e208-c5f59e3895d7@opensynergy.com>
Subject: Re: [virtio-dev] Re: [PATCH] virtio-blk: document VIRTIO_BLK_F_MQ
 multiqueue feature
To: Matti Moell <Matti.Moell@opensynergy.com>
Cc: virtio-dev@lists.oasis-open.org, "Michael S. Tsirkin" <mst@redhat.com>, Ming Lei <ming.lei@canonical.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--+g7M9IMkV8truYOl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 07, 2019 at 07:29:49PM +0200, Matti Moell wrote:
> I wasn't able to find any discussion about not including multiqueue in the
> spec and this patch was never applied, is there any particular reason why=
 it
> wasn't added?
>=20
> Should it even be added to the spec?

Yes, it should be added to the spec.  Eugenio Perez has recently sent a
new patch to fix this:
https://lists.oasis-open.org/archives/virtio-comment/201909/msg00004.html

Stefan

--+g7M9IMkV8truYOl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2gQgkACgkQnKSrs4Gr
c8hBkQgAnhUqMuTMeAhR17tZWAlI9qcCvbPaz4izSUq1qyVNkj7AMLLAGYRGP79x
YaCNlMA8Ug9AribZsjpeQW3S0I9x/b8HjMUqPUNAPkW+3HZsnV0va80fxJ7PNDCe
5rLx/I8fpphd9/NWOKY2PcyPj7UiUmPlbNmO/q03/AqgduFjZRTMDpVwl/PFeLHy
u9h//XqHdqCgYEwc5xBOb0JysWCDGOcJeUFKURMXGt6NpICEKvDSR9ZwIeSlhazX
l5wwA8Dc96TOqF3wwFBSzoMGL7N8tgtUiV+QjYBba2o7FJaZhb3rjdzh6rt6L5TZ
eXMexU6IHaqEDewlO56GLgxGoq5RHg==
=mGO8
-----END PGP SIGNATURE-----

--+g7M9IMkV8truYOl--
