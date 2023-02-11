Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [PATCH v10 02/10] admin: introduce device group and related
 concepts
Date: Sat, 11 Feb 2023 16:52:52 +0000
Message-ID: <PH0PR12MB5481AF0FF52E61D889768B4BDCDF9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230209121221.15118-1-mst@redhat.com>
 <20230209121221.15118-3-mst@redhat.com>
In-Reply-To: <20230209121221.15118-3-mst@redhat.com>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com" <jasowang@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>, "sgarzare@redhat.com" <sgarzare@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "nrupal.jani@intel.com" <nrupal.jani@intel.com>, "Piotr.Uminski@intel.com" <Piotr.Uminski@intel.com>, "hang.yuan@intel.com" <hang.yuan@intel.com>
Cc: "virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>, Zhu Lingshan <lingshan.zhu@intel.com>, "pasic@linux.ibm.com" <pasic@linux.ibm.com>, Shahaf Shuler <shahafs@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Thursday, February 9, 2023 7:14 AM
>=20
> Each device group has a type. For now, define one initial group:

> +The following group types, and their identifiers, are currently specifie=
d):
Above "):" is that needed?

> +\begin{description}
> +\item[SR-IOV group type (0x1)]
Above 0x1 is duplicate of below.
Better to mention at single place.
> +This device group has a PCI Single Root I/O Virtualization
> +(SR-IOV) physical function (PF) device as the owner and includes all
> +its SR-IOV virtual functions (VFs) as members (see
> +\hyperref[intro:PCIe]{[PCIe]}).
> +
> +The PF device itself is not a member of the group.
> +
> +The group type identifier for this group is 0x1.
> +
Current spce for device ID style is better than writing above lines repeate=
dly.
Something like,

\subsection{Group Type identifier }\label{sec: ... /Group Type Identifier}
1


