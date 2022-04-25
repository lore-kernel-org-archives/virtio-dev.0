Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [PATCH] virtio: Improve queue_reset polarity to match to default
 reset state
Date: Mon, 25 Apr 2022 23:45:51 +0000
Message-ID: <PH0PR12MB5481F6C5B45BF9DA19682426DCF89@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220425204225.288309-1-parav@nvidia.com>
 <20220425185633-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220425185633-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Monday, April 25, 2022 7:11 PM
>=20
[..]

> That's a weird way to describe this.  I guess the logic in the spec is si=
mply a
> register bit that is set to !=3D 1 when reset starts and set to 1 when re=
set
> completes.
> You propose reversing its polarity. Fair enough.
>=20
I will drop this part from the commit message as example clarifies it enoug=
h without device side code.

>=20
> I do think it's inelegant that the value is different when reset is throu=
gh vq
> reset (1) and through device reset (0).

> >  If VIRTIO_F_RING_RESET has been negotiated, after the driver writes 1
> > to -\field{queue_reset} to reset the queue, it MUST verify that the
> > queue -has been reset by reading back \field{queue_reset} and ensuring
> > that it -is 1. The driver MAY re-enable the queue by writing a 1 to
> > +\field{queue_reset} to reset the queue, driver MUST verify that the
> > +queue has been reset by reading back \field{queue_reset} until device
> returns a value of 0.
> > +Device continue to report value of 1 for the \field{queue_reset}
> > +until device finishes
>=20
> this MUST should move to conformance chapter BTW.

In this proposal it is covered in the section 4.1.4.3.2 " Driver Requiremen=
ts: Common configuration structure layout".
This section is listed in 7.2 " Clause 2: PCI Driver Conformance".

To me it appears that this is covered in the conformance.
What am I missing?

>=20
> > +the queue reset request. When the device completes the queue reset,
> > +\field{queue_reset} and \field{queue_enable} set to zero,
>=20
> set-> "are set"
>=20
Will fix.

> > indicating
> > +that specified queue is ready to be enabled again. The driver MAY
> > +re-enable the queue by writing a 1 to
>=20
> a 1 -> 1
Will fix.

>=20
> >  \field{queue_enable} after ensuring that the other virtqueue fields
> > have
>=20
> the other -> other (not your fault)
>=20
Should this be pre-patch?
Or small enough editorial change to be part of this?

> >  been set up correctly. The driver MAY set driver-writeable queue
> > configuration  values to different values than those that were used bef=
ore
> the queue reset.
> >  (see \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtq=
ueue
> Reset}).
> >
> > +
>=20
> drop this pls.
My bad. Will fix it.

>=20
> ccw will have to be changed too.
My weak area. Didn't find the vq reset section in below 3 commits.

a4ce81a virtio: mmio support virtqueue reset
12998e7 virtio: pci support virtqueue reset
3b5378d virtio: introduce virtqueue reset as basic facility

In a previous email by Cornelia, she replied " For ccw, we have not yet add=
ed queue reset;".
So, can we please do this later in a some a non_bug_fix patch?

I will revise v1 for the comments that I can fix.
Based on v1 review, we can split patches and improve further.

