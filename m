Return-Path: <virtio-dev-return-9442-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6800C9862AF
	for <virtio-dev@lists.oasis-open.org>; Mon, 25 Apr 2022 10:06:07 +0000 (UTC)
From: Parav Pandit <parav@nvidia.com>
Date: Mon, 25 Apr 2022 10:06:04 +0000
Message-ID: <PH0PR12MB54812908D91C72CC7407F185DCF89@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <PH0PR12MB54819125071ED675E2B72F0EDCF99@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220424023301-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220424023301-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Subject: [virtio-dev] RE: queue_reset register polarity to improve
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Sunday, April 24, 2022 2:47 AM
>=20
> On Sun, Apr 24, 2022 at 12:49:19AM +0000, Parav Pandit wrote:
> > Hi,
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
> it is not great but don't see a conflict here
>=20
> > e) 0,1 -> vq reset is complete in the device and VQ is now disabled
> > (again conflict with #a above )
> this one is ugly in that state is really mostly same as (1) but the flag =
values are
> different
Right.

>=20
>=20
> > f) 1,0 -> vq is enabled and working again
>=20
>=20
>=20
> It can actually be any value, the spec just says
>=20
> If VIRTIO_F_RING_RESET has been negotiated, after the driver writes 1 to
> \field{QueueReset} to reset the queue, it MUST verify that the queue has
> been reset by reading back \field{QueueReset} and ensuring that it is 1.
>=20
> So can be 2 or whatever, so one can distinguish between the two states.
>=20
It is sub-optimal for device to burn more than one bit to implement/return =
value 2, which can be communicated using single bit.
So, 0 is preferred as this the value at default reset time.

> Spec really should clarify what to do if it is not 1 (i.e. read it again =
until it is 1) .
>=20
>=20
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
> >
> > Parav
>=20
>=20
> Well it's been merged since November.=20
Merged on dec-21 to be more precise. :)

> Probably too late unless you can
> convince the TC that the current feature should be abandoned and the
> feature completely redesigned. Above does not look like a deal breaker.
>=20
I don't see a need for abandoning and redesigning this feature.
Not sure if any driver+device already produced and consumed which cannot be=
 fixed.
The spec is not released yet, we should be able to fix it.

> If we are to re-design it, I would maybe instead rework things so
> queue_enable can be written to, to stop vq without a reset. Will need car=
eful
> work for transports other than PCI since those already allow writing into=
 e.g.
> QueueReady.
>=20
Reusing queue_enable to disable the queue require driver writing zero, devi=
ce returning 1 till its enabled, and device returning 0 when done.
This can be supported using the new VIRTIO_F_RING_RESET flag.
This way we have single bit to control enablement/disablement the VQ regard=
less of DRIVER_OK state.

> If possible, please open a github issue so we can track this for the rele=
ase.
Done at [1]

[1] https://github.com/oasis-tcs/virtio-spec/issues/139
Do we continue to discuss this over email or in github now?


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

