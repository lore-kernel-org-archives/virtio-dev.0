Return-Path: virtio-dev-return-6228-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 230EB985E12
	for <virtio-dev@lists.oasis-open.org>; Fri, 11 Oct 2019 15:49:07 +0000 (UTC)
Date: Fri, 11 Oct 2019 16:49:02 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20191011154902.GB22727@stefanha-x1.localdomain>
References: <20191011094203.5692-1-stefanha@redhat.com>
 <20191011055722-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GID0FwUMdk1T2AWN"
Content-Disposition: inline
In-Reply-To: <20191011055722-mutt-send-email-mst@kernel.org>
Subject: [virtio-dev] Re: [PATCH] pci: use msix_config instead of config_msix_vector
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, Paolo Bonzini <pbonzini@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--GID0FwUMdk1T2AWN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2019 at 05:58:59AM -0400, Michael S. Tsirkin wrote:
> On Fri, Oct 11, 2019 at 10:42:03AM +0100, Stefan Hajnoczi wrote:
> > The struct virtio_pci_common_cfg field is called msix_config but the
> > text refers to this field as config_msix_vector.  This is confusing.
> >=20
> > Rename config_msix_vector to msix_config.  Although config_msix_vector
> > is arguably a clearer name, existing code using Linux virtio_pci.h uses
> > msix_config so let's stick with that.
> >=20
> > Fixes: https://github.com/oasis-tcs/virtio-spec/issues/41
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> > Note that Paolo already submitted a patch for the other approach and I
> > even reviewed it:
> > https://lists.oasis-open.org/archives/virtio/201903/msg00073.html
> >=20
> > Either way, let's merge a fix!
>=20
> OK I'll start voting on Paolo's patch as it was here earlier.
> If that fails we'll vote on yours?

Sounds good :).

Stefan

--GID0FwUMdk1T2AWN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2gpG0ACgkQnKSrs4Gr
c8hUxwgAnUM02mnUgCGOdytDE1BQ6ykbDQER9CSiIgf8qe+XX4G4Z/cZCLG0gqUu
hlv7PpOM8NyYahS+EVaU7f1mnqUASrMAtST4hgvPiRFh/4XiD5oDDG240aTt7VbH
8wAiYWieKDG4vlWkbvq9gbVAifmx9QG++gF0ucnlJ4D6x3wjpzG3el5ZeNh1+FQD
veQ5iCD1n6hQF/adJYBpV561QxH+U8svaGmjWIqdofmxYvCvYZ0SL87SBM2YhwaH
5JYd0TFAK4xn9OBhCmpqNu6YD8nysKcqJrbKrLUnogqYBNUwRFg9oHXOcmAU9gJh
jgOPFIWxIX6i2eacL4mJS+Py9EHjNA==
=f22x
-----END PGP SIGNATURE-----

--GID0FwUMdk1T2AWN--
