Return-Path: <virtio-dev-return-9655-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EE1C59867F9
	for <virtio-dev@lists.oasis-open.org>; Fri, 15 Jul 2022 16:50:29 +0000 (UTC)
Date: Fri, 15 Jul 2022 17:50:17 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <YtGayTbaFh9cbp/U@stefanha-x1.localdomain>
References: <6f4f611e95cf49b0b16b37efba6bf78a@HIMDWSMB01.ad.harman.com>
 <Ys1704UaN4/e3/Rf@stefanha-x1.localdomain>
 <1657894712677.5057@harman.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="VfS2gWH43yEf4k6h"
Content-Disposition: inline
In-Reply-To: <1657894712677.5057@harman.com>
Subject: Re: [virtio-dev] VM memory protection and zero-copy transfers.
To: "Afsa, Baptiste" <Baptiste.Afsa@harman.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--VfS2gWH43yEf4k6h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 15, 2022 at 02:18:32PM +0000, Afsa, Baptiste wrote:
> > One thing I didn't see in your proposal was a copying vs zero-copy
> > threshold. Maybe it helps to look at the size of requests and copy data
> > instead of granting pages when descriptors are small? On the other hand,
> > a 4 KB page size means that many descriptors won't be larger than 4 KB
> > anyway due to guest physical memory fragmentation. This is basically
> > hybrid of swiotlb and your proposal - zero-copy when it pays off,
> > copying when it's cheap.
> >
> > As I mentioned, I think IOMMUs are worth investigating, in particular
> > for the case where mappings are rarely changed. They are fast in that
> > case.
>=20
> I agree there is much likely a point until which copying is cheaper. Howe=
ver, we
> have not considered this in our initial investigation.
>=20
> Thank you Stefan for taking the time to read this proposal and for your
> feedback.

I will be away until August so I probably won't participate in the
discussion.

One thing I forgot to say is that relying on a single benchmark may not
be representative of real workloads. Two factors we touched on are
descriptor size and page reuse. It seems worth evaluating solutions
based on multiple benchmarks that vary these factors.

Stefan

--VfS2gWH43yEf4k6h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmLRmsgACgkQnKSrs4Gr
c8gTHgf+KYZaFlHb3Rvkkz0RCasfxrwZMIK76nyTd9vSuUzACLcpYin8PjFPi5Gm
IEvBYjHA0iM2c1UvQM26eFR3jdXVZA+ZVcWIF1PBm/yQwe69Rc/NQH42uJytx1Do
CuGCPNuTuz1FQXPbWyFSKunbgZZsb9ruZoY78/GkAGifUSr33tKy2mYHBbpmydpF
3yheeg1ZdElvV/+aKmyuR9Rx5b0HUg5x9WzRhf/7mmyarz91FhkIRDtzDEEXhglo
OmFP8lDwzUiZg/wURa+wbVE7Pu1GGdXUuMGntKzx4YNw42qYMGVW28hNt/m4ES+m
Em3IVVYB9QNNhPIZuK2Dcdy0Ww8NvQ==
=ct57
-----END PGP SIGNATURE-----

--VfS2gWH43yEf4k6h--

