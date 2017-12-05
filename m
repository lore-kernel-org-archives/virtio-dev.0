Return-Path: virtio-dev-return-2759-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 349985818F75
	for <virtio-dev@lists.oasis-open.org>; Tue,  5 Dec 2017 08:00:30 -0800 (PST)
Date: Tue, 5 Dec 2017 16:00:20 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171205160020.GH31150@stefanha-x1.localdomain>
References: <1512444796-30615-1-git-send-email-wei.w.wang@intel.com>
 <1512444796-30615-6-git-send-email-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dDnEQgWzhgf+8aPe"
Content-Disposition: inline
In-Reply-To: <1512444796-30615-6-git-send-email-wei.w.wang@intel.com>
Subject: [virtio-dev] Re: [PATCH v3 5/7] vhost-user: VHOST_USER_SET_VHOST_PCI msg
To: Wei Wang <wei.w.wang@intel.com>
Cc: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, mst@redhat.com, marcandre.lureau@redhat.com, jasowang@redhat.com, pbonzini@redhat.com, jan.kiszka@siemens.com, avi.cohen@huawei.com, zhiyong.yang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

--dDnEQgWzhgf+8aPe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 05, 2017 at 11:33:14AM +0800, Wei Wang wrote:
> Add a new vhost-uer protocol msg, VHOST_USER_SET_VHOST_PCI. This msg is
> used to signal the vhost-pci device to start/stop working.
>=20
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> ---
>  hw/net/vhost_net.c                | 37 +++++++++++++++++++++++++++++++++=
++++
>  hw/virtio/vhost-pci-slave.c       |  2 +-
>  hw/virtio/vhost-user.c            | 17 +++++++++++++++++
>  hw/virtio/vhost.c                 |  7 +++++++
>  include/hw/virtio/vhost-backend.h |  2 ++
>  include/hw/virtio/vhost-user.h    |  2 ++
>  include/hw/virtio/vhost.h         |  2 ++
>  include/net/vhost_net.h           |  2 ++
>  8 files changed, 70 insertions(+), 1 deletion(-)

New protocol messages must be documented in docs/interop/vhost-user.txt.

Why is a new message needed?  I'm not sure why it is specific to
vhost-pci.

--dDnEQgWzhgf+8aPe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaJsKUAAoJEJykq7OBq3PIurcIAILS+kvuY/9b9DfgWgKz/tHq
F5KJ/iq4pZuQQ+546paS5Rm4gH1WfSLmrsXHzfUsqOCKJztxUUAZuLveoSbtRur0
Q4xcnKJMVQvtk3wW1vjfFRH5jZZRIkTOKp6Vly2o2gSfXXaBRtoEpMJfYCgDLPhX
B1LbHn6YiOu8urOlpEDg4FWcN9cc7AwBAyRtWjDS0BTUuLtBRuQmhbJR1XUk5Grx
vsJraih5PZHnUdRskpDp0xshC1bKz5p6vEAyLq/7jVYr1BubqKdb7QbJClfRFdxu
VE7zhAD7GvLa/Ue/XnFK4RLsHygxPZf/7l0WWIIEZdRSxuzNi6AnQ4/lBj2y1l0=
=zFqW
-----END PGP SIGNATURE-----

--dDnEQgWzhgf+8aPe--
