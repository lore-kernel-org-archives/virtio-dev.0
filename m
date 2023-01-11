Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [virtio-dev] [PATCH v3 06/20] virtio-mem-balloon: Maintain mem
 balloon device spec in separate directory
Date: Wed, 11 Jan 2023 16:32:19 +0000
Message-ID: <PH0PR12MB54818EF6116DADE344AD014EDCFC9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230110230358.528098-1-parav@nvidia.com>
 <20230110230358.528098-7-parav@nvidia.com>
 <b95d3aab-21c0-8256-a8bd-09e5b45cd206@redhat.com>
 <PH0PR12MB54814D2E4FAABC0A72EA5CE3DCFC9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <c3d29199-df2a-6a13-e88c-b52d20fa04ff@redhat.com> <87sfghvzd0.fsf@redhat.com>
 <PH0PR12MB5481F8DF03266EA84A2C3D2BDCFC9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230111111735-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230111111735-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Wednesday, January 11, 2023 11:22 AM
>
> > Also, I want to drop the prefix "virtio_" in the directory names.
> > Any opinion on that?
>=20
> I'm fine with this. But I agree mem-balloon is not a good file name, let'=
s just
> stick with balloon. It's unambigous and short.
>=20
Ok. Will make both changes in v4.

