Return-Path: virtio-dev-return-4300-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 23CE71CB8078
	for <virtio-dev@lists.oasis-open.org>; Thu,  7 Jun 2018 06:04:56 -0700 (PDT)
Date: Thu, 7 Jun 2018 14:04:48 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180607130448.GM19032@stefanha-x1.localdomain>
References: <20180601112632.12651-1-tiwei.bie@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VLAOICcq5m4DWEYr"
Content-Disposition: inline
In-Reply-To: <20180601112632.12651-1-tiwei.bie@intel.com>
Subject: [virtio-dev] Re: [PATCH v3] virtio: update the comments for transport features
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: mst@redhat.com, jasowang@redhat.com, cohuck@redhat.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

--VLAOICcq5m4DWEYr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 01, 2018 at 07:26:32PM +0800, Tiwei Bie wrote:
> The existing comments for transport features are outdated.
> So update them to address the latest changes in the spec.
>=20
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> ---
> This patch is generated on top of below patch:
> https://lists.oasis-open.org/archives/virtio-dev/201805/msg00212.html
>=20
> v3:
> - Fix a typo in the commit message (Cornelia);
>=20
> v2:
> - Improve the comments (Cornelia);
> - Improve the commit message;
>=20
>  include/uapi/linux/virtio_config.h | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--VLAOICcq5m4DWEYr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbGS1wAAoJEJykq7OBq3PIsQgH/juE93zamoKrVvX0dLQqbPh7
cO+fADWB/7gWbUTAivY6zhpmxKN22QaR8OTrbJHctlS2A8NV3Ra7NOjNq9ThZEWQ
lsVF58S3PHBZVoI11pbd1FYgJvhQbBtI18wdN0VWwu2bXfL18qIEpELnfS/ePkvJ
WUx6nPt8JcqDwPwQpVyQFfRLudcg5N8RLXxTGPhSOHjyiPzfHkxvrs/Qu51W75C7
rX9K3AjauK4Rc1nebJG/u4REDJch6zBiTCqGod4cZCR4Zc/oeXQKCz02RLL8/VeR
zvfilxTYEEelkYa/+5mUDnt1tGpAssOt+Es/h0uERnxnL3haa1D+ofI8DYX+IM4=
=qMT1
-----END PGP SIGNATURE-----

--VLAOICcq5m4DWEYr--
