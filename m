Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [PATCH v10 00/10] Introduce device group and device management
Date: Sat, 11 Feb 2023 18:49:52 +0000
Message-ID: <PH0PR12MB54817FB7BA47369974018BAFDCDF9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230209121221.15118-1-mst@redhat.com>
In-Reply-To: <20230209121221.15118-1-mst@redhat.com>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com" <jasowang@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>, "sgarzare@redhat.com" <sgarzare@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "nrupal.jani@intel.com" <nrupal.jani@intel.com>, "Piotr.Uminski@intel.com" <Piotr.Uminski@intel.com>, "hang.yuan@intel.com" <hang.yuan@intel.com>
Cc: "virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>, Zhu Lingshan <lingshan.zhu@intel.com>, "pasic@linux.ibm.com" <pasic@linux.ibm.com>, Shahaf Shuler <shahafs@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Thursday, February 9, 2023 7:13 AM

[..]

> My intent is to try and support both SR-IOV and SIOV usecases with the sa=
me
> structure and maybe even the same VQ.
>=20
Probably it is implicit, but is better for us to mention few examples use c=
ases here something like,

Admin queue is an infrastructure to support use cases like:
a. SIOV devices life cycles management (create, destroy, query, configure)
b. SR-IOV VF device/resource management (SR-PCIM)
c. May be transport

> For example, it might make sense to split creating/destroying SIOV device=
s
> from the transport passing data from the guest - the driver would then no=
t
> negotiate VIRTIO_F_SR_IOV (which then means auto-provisioning).

Above intermixing of SIOV and SR_IOV is very confusing.
Can you please drop it and have simpler examples like above?

