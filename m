Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [PATCH v1] virtio-net: Define configuration field layout before
 its description
Date: Thu, 9 Feb 2023 04:54:47 +0000
Message-ID: <PH0PR12MB54816EDE942889153244929DDCD99@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230209014251.210070-1-parav@nvidia.com>
In-Reply-To: <20230209014251.210070-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "mst@redhat.com" <mst@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>
Cc: "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Cornelia,

> From: Parav Pandit <parav@nvidia.com>
> Sent: Wednesday, February 8, 2023 8:43 PM
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
> [1] https://lists.oasis-open.org/archives/virtio-dev/202302/msg00004.html
>=20
> Signed-off-by: Parav Pandit <parav@nvidia.com>
> ---
> changelog:
> v0->v1:
> - Change wording about device configuration field introduction
> - remove duplicate read-only wording for status field
> - reword sentence to read it better
> ---
This patch is superseded by v2 at [1].
Hence, please review [1].

[1] https://lists.oasis-open.org/archives/virtio-dev/202302/msg00163.html

