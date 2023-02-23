Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [PATCH v4 2/2] virtio-net: Define cfg fields before description
Date: Thu, 23 Feb 2023 18:16:40 +0000
Message-ID: <PH0PR12MB5481183AD1344D65A45667C3DCAB9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230223023521.159959-1-parav@nvidia.com>
 <20230223023521.159959-3-parav@nvidia.com> <m2k008d71b.fsf@oracle.com>
In-Reply-To: <m2k008d71b.fsf@oracle.com>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: David Edmondson <david.edmondson@oracle.com>
Cc: "mst@redhat.com" <mst@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>



> From: David Edmondson <david.edmondson@oracle.com>
> Sent: Thursday, February 23, 2023 5:12 AM
>=20
>=20
> On Thursday, 2023-02-23 at 04:35:21 +02, Parav Pandit wrote:
> > Currently some fields of the virtio_net_config structure are defined
> > before introducing the structure and some are defined after
> > introducing virtio_net_config.
>=20
> Don't need the trailing "introducing virtio_net_config".

Thanks. Addressed this and another comment in v5 at [1].

[1] https://lists.oasis-open.org/archives/virtio-dev/202302/msg00556.html

