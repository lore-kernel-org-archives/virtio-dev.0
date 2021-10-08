Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [PATCH v2] Add device reset timeout field
Date: Fri, 8 Oct 2021 11:45:36 +0000
Message-ID: <PH0PR12MB548145D0D7783E69545A9A90DCB29@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20211006141033.612283-1-parav@nvidia.com>
 <20211006111143-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54811E06DAED3F7D60955A84DCB09@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211006163309-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481990F6F33697BB2F9B6D4DCB19@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211008063303-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481378DF0CE74777A5BEC90DCB29@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211008071903-mutt-send-email-mst@kernel.org>
In-Reply-To: <20211008071903-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "cohuck@redhat.com" <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Max Gurtovoy <mgurtovoy@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Friday, October 8, 2021 4:52 PM
>=20
> On Fri, Oct 08, 2021 at 10:59:02AM +0000, Parav Pandit wrote:
> > It may be even a pre-boot environment where 100msec or 10msec may be
> too short interval as other extreme of VM boot time example.
>=20
> I don't really know what this means. We are talking about how long it tak=
es
> device to calm down and stop poking at the host after it's told to reset.=
 10ms
> worst case not enough for this?
For the example you gave, probably yes, it is.

However, when the device is coming up for the first time, in such reset sce=
nario, device is not even poking at the host yet.
It is still under reset.
10msec may not be enough.
And infinite wait is yet another extreme where system is optimistic that de=
vice _will_ finish the reset.

