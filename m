Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [PATCH v6] virtio-net: Improve introductory description
Date: Thu, 16 Feb 2023 14:30:03 +0000
Message-ID: <PH0PR12MB5481F4E1099DF88D667DBD2CDCA09@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230214180405.364920-1-parav@nvidia.com>
 <87ilg1aehi.fsf@redhat.com>
In-Reply-To: <87ilg1aehi.fsf@redhat.com>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Cornelia Huck <cohuck@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>, David Edmondson <david.edmondson@oracle.com>
List-ID: <virtio-dev.lists.oasis-open.org>


> From: Cornelia Huck <cohuck@redhat.com>
> Sent: Thursday, February 16, 2023 9:10 AM
>=20
> On Tue, Feb 14 2023, Parav Pandit <parav@nvidia.com> wrote:
>=20
> > The control VQ of the virtio network device is used beyond advance
> > steering control. The control VQ dynamically changes multiple features
> > of the initialized device.
> >
> > Hence, update this area of control VQ introductory description at few
> > places and also place the link to its description.
> >
> > Also update the introduction section to better describe receive and
> > transmit virtqueues.
> >
> > Fixes: https://github.com/oasis-tcs/virtio-spec/issues/156
> > Reviewed-by: David Edmondson <david.edmondson@oracle.com>
> > Signed-off-by: Parav Pandit <parav@nvidia.com>
>=20
> Are you requesting a vote for this?

I was not sure if its need voting as most are editorial cleanups, better de=
scription, structure movement.
Please advise if we need voting.

