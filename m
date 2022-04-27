Return-Path: <virtio-dev-return-9483-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5F72898644F
	for <virtio-dev@lists.oasis-open.org>; Wed, 27 Apr 2022 23:52:07 +0000 (UTC)
From: Parav Pandit <parav@nvidia.com>
Date: Wed, 27 Apr 2022 23:52:02 +0000
Message-ID: <PH0PR12MB5481F2F44DAD45F107615D3BDCFA9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <PH0PR12MB54819125071ED675E2B72F0EDCF99@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1650785333.6800807-1-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB54813427247BD9D32CF50E75DCFB9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1651048123.1004138-1-xuanzhuo@linux.alibaba.com>
 <20220427160941-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220427160941-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Subject: RE: RE: [virtio-dev] queue_reset register polarity to improve
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Wednesday, April 27, 2022 4:30 PM
>=20
> On Wed, Apr 27, 2022 at 04:28:43PM +0800, Xuan Zhuo wrote:
> > On Tue, 26 Apr 2022 12:00:24 +0000, Parav Pandit <parav@nvidia.com>
> wrote:
> > >
> > > > From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > Sent: Sunday, April 24, 2022 3:29 AM
> > > > >
> > > > > A recently defined queue_reset register has a little weird
> > > > > definition that
> > > > we should improve.
> > > > > When driver initiate queue reset, it writes queue_reset =3D 1.
> > > > > When device is busy resetting the queue, on this driver request,
> > > > > it is
> > > > expected to return queue_reset=3D0.
> > > > > Once queue reset is completed it is expected to return queue_rese=
t
> =3D 1.
> > > > > (Polarity changed twice to same value as what was driver set).
> > > > > See more
> > > > below.
> > > > >
> > > > > So state wise,
> > > > > # q_enable, q_reset represents :
> > > > > a) 0,0 -> device init time value
> > > > > b) 1,0 -> vq is enabled and working
> > > > > c) 1,1 -> vq is enabled, driver initiated reset
> > > > > d) 1,0 -> vq is enabled, but device is busy doing the reset
> > > > > (conflicting definition with above #b )
> > > > > e) 0,1 -> vq reset is complete in the device and VQ is now
> > > > > disabled (again conflict with #a above )
> > > > >
> > > > > Instead, I think we should have below better, consistent
> > > > > definition, no
> > > > matter how queue reset occurs (init time or later).
> > > > >
> > > > > q_enable, q_reset
> > > > > A) 0, 0 -> default, device init time
> > > > > B) 1, 0 -> driver has enabled vq
> > > > > C) 1, 1 -> driver started q reset
> > > > > D) 1, 1 -> q_reset stays 1 until device is busy resetting vq
> > > > > (communicating that its working on resetting, consistent with
> > > > > #C)
> > > > > E) 0, 0 -> q_reset by device is completed, q got disabled (now
> > > > > matches the state same as device init time #A)
> > > >
> > > > Seems to me to be two different designs, I don't see any
> > > > particular value in the conflict mentioned here, and under what
> > > > circumstances would it cause any trouble?
> > > >
> > > queue reset state doesn't go back same register value at the end of
> queue reset operation as what it was initial device reset operation.
> > > And also, the special weird handling needed due to this on device sid=
e.
> > > The rest of the commit message text deleted describes the discrepanci=
es
> and also above in point #E.
> > >
> > > > The design here is similar to many scenarios, such as device reset.
> > > >
> > > Taking device reset example is not that great. As this is something e=
xists
> in the code way before the spec 1.x was written.
> > >
> > > In current form, device tells driver that queue is reset =3D 0) durin=
g initial
> time.
> > > And when done using register method, it says queue reset is complete =
by
> saying queue_reset =3D 1.
> > >
> > > This doesn't match with existing device reset semantics anyway.
> > >
> > > No matter how to reset the device, the end result of device_status =
=3D 0,
> when reset is completed.
> > >
> > > > So if you want to change to your design, I want to know if there
> > > > are other reasons.
> > > Those are described in the rest of the commit message and above.
> > > Its very simple, queue reset to go back to same state as what it was
> during device reset time, i.e. 0.
> >
> > OK, I have no problem.
> >
> > Thanks for pointing this out.
> >
> > Hi, Michael, what's our plan now? Will it be merged into 1.2?
> >
> > Should my linux code be implemented based on this new specification?
> >
> >
> > Thanks.
>=20
> So given the original commenter also feels we should make the change,
> maybe the best way forward is redoing the 1.2 draft before the public rev=
iew
> starts. The proposal has not been finalized yet though, whether that is
> practical would depend on when that is ready.

I am preparing v3 to address yours and Cornelia's comments.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

