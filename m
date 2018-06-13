Return-Path: virtio-dev-return-4373-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id C66D958191EF
	for <virtio-dev@lists.oasis-open.org>; Wed, 13 Jun 2018 06:12:21 -0700 (PDT)
Date: Wed, 13 Jun 2018 14:12:09 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180613131209.GH24528@stefanha-x1.localdomain>
References: <20180613092702.5544-1-tiwei.bie@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="K1n7F7fSdjvFAEnM"
Content-Disposition: inline
In-Reply-To: <20180613092702.5544-1-tiwei.bie@intel.com>
Subject: [virtio-dev] Re: [PATCH v1] content: use a consistent wording for device status
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, virtio-dev@lists.oasis-open.org, dan.daly@intel.com, cunming.liang@intel.com, zhihong.wang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

--K1n7F7fSdjvFAEnM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 13, 2018 at 05:27:02PM +0800, Tiwei Bie wrote:
> There is a part called "device status field" in a
> Virtio device. Currently, both of \field{status}
> and \field{device status} are used to refer to it,
> which is a bit confusing. This patch changes spec
> to use \field{device status} consistently.
>=20
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/15
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> ---
> v1:
> - Drop RFC from subject;
> - Add Fixes tag;
>=20
>  content.tex | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--K1n7F7fSdjvFAEnM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbIRgpAAoJEJykq7OBq3PITq8H/3xYd9R/GYIVENV/2608oAI6
YHxRrwVhj1mJr1/mVso4FVs8SxmkuaumXSinYxMF+uB7FGz9j0wPYRjIOou9R2oK
zMhQY7FODavkH7WQc2AlaoMfM9sEzyXmYwZhXuGB0prYOijGEhfO28sqNn8sK0T5
2WaOmeFkQ25RQ9rnRtw+E3q0VxNRYvmlHpz3I3RGImc2X4p+vCCyzkIYwV718YAW
PwU4a9FXwfuEerxrasjN07zvgHZMQzJ3HhrH01IaIr35BIq+IIKLpYyYcZ5ZIUHc
FZWnp6yz5Ga+I8b7nHE4/ld7XUYb029PyM03BnSZlqwgj2TRh4fEzOrAUgsS/RQ=
=sR/v
-----END PGP SIGNATURE-----

--K1n7F7fSdjvFAEnM--
