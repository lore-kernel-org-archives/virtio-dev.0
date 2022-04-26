Return-Path: <virtio-dev-return-9462-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C83769863F2
	for <virtio-dev@lists.oasis-open.org>; Tue, 26 Apr 2022 12:00:27 +0000 (UTC)
From: Parav Pandit <parav@nvidia.com>
Date: Tue, 26 Apr 2022 12:00:24 +0000
Message-ID: <PH0PR12MB54813427247BD9D32CF50E75DCFB9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <PH0PR12MB54819125071ED675E2B72F0EDCF99@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1650785333.6800807-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1650785333.6800807-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Subject: RE: [virtio-dev] queue_reset register polarity to improve
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "Michael S. Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>


> From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Sent: Sunday, April 24, 2022 3:29 AM
> >
> > A recently defined queue_reset register has a little weird definition t=
hat
> we should improve.
> > When driver initiate queue reset, it writes queue_reset =3D 1.
> > When device is busy resetting the queue, on this driver request, it is
> expected to return queue_reset=3D0.
> > Once queue reset is completed it is expected to return queue_reset =3D =
1.
> > (Polarity changed twice to same value as what was driver set). See more
> below.
> >
> > So state wise,
> > # q_enable, q_reset represents :
> > a) 0,0 -> device init time value
> > b) 1,0 -> vq is enabled and working
> > c) 1,1 -> vq is enabled, driver initiated reset
> > d) 1,0 -> vq is enabled, but device is busy doing the reset
> > (conflicting definition with above #b )
> > e) 0,1 -> vq reset is complete in the device and VQ is now disabled
> > (again conflict with #a above )
> >
> > Instead, I think we should have below better, consistent definition, no
> matter how queue reset occurs (init time or later).
> >
> > q_enable, q_reset
> > A) 0, 0 -> default, device init time
> > B) 1, 0 -> driver has enabled vq
> > C) 1, 1 -> driver started q reset
> > D) 1, 1 -> q_reset stays 1 until device is busy resetting vq
> > (communicating that its working on resetting, consistent with #C)
> > E) 0, 0 -> q_reset by device is completed, q got disabled (now matches
> > the state same as device init time #A)
>=20
> Seems to me to be two different designs, I don't see any particular value=
 in
> the conflict mentioned here, and under what circumstances would it cause
> any trouble?
>=20
queue reset state doesn't go back same register value at the end of queue r=
eset operation as what it was initial device reset operation.
And also, the special weird handling needed due to this on device side.
The rest of the commit message text deleted describes the discrepancies and=
 also above in point #E.

> The design here is similar to many scenarios, such as device reset.
>=20
Taking device reset example is not that great. As this is something exists =
in the code way before the spec 1.x was written.

In current form, device tells driver that queue is reset =3D 0) during init=
ial time.
And when done using register method, it says queue reset is complete by say=
ing queue_reset =3D 1.

This doesn't match with existing device reset semantics anyway.

No matter how to reset the device, the end result of device_status =3D 0, w=
hen reset is completed.

> So if you want to change to your design, I want to know if there are othe=
r
> reasons.
Those are described in the rest of the commit message and above.
Its very simple, queue reset to go back to same state as what it was during=
 device reset time, i.e. 0.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

