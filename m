Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [PATCH v2] virtio-net: Define configuration field layout before
 its description
Date: Fri, 17 Feb 2023 01:20:42 +0000
Message-ID: <PH0PR12MB5481AD3ECF5D89295AF8395DDCA19@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230209045228.212309-1-parav@nvidia.com>
In-Reply-To: <20230209045228.212309-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "mst@redhat.com" <mst@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>
Cc: "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>



> From: Parav Pandit <parav@nvidia.com>
> Sent: Wednesday, February 8, 2023 11:52 PM
>=20
> Currently some fields of the virtio_net_config structure are defined befo=
re
> introducing the structure and some are defined after introducing
> virtio_net_config.
> Better to define the configuration layout first followed by description o=
f all the
> fields.
>=20
> Device configuration fields are described in the section. Change wording =
from
> 'listed' to 'described' as suggested in patch [1].
>=20
> While rewording the configuration layout, mention only one time that all =
the
> fields of the configuration layout are read-only. Remove read-only wordin=
g
> from individual fields.
>=20
> [1] https://lists.oasis-open.org/archives/virtio-dev/202302/msg00004.html
>=20
> Signed-off-by: Parav Pandit <parav@nvidia.com>
> ---
> changelog:
> v1->v2:
> - remove read-only wording from multiple places

Since there are no further comments, can you please take this further?
It is only editorial change.

