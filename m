Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [virtio-dev] [PATCH v2] virtio: Improve queue_reset polarity to
 match to default reset state
Date: Thu, 28 Apr 2022 01:52:43 +0000
Message-ID: <PH0PR12MB5481829177584387DCB6D1A2DCFD9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220427102559.305669-1-parav@nvidia.com>
 <CACGkMEsDEJS0awDfFzR7a1aOr3+TQ6iDse5R=LRAYGxgNs4bpQ@mail.gmail.com>
 <PH0PR12MB5481FA61532231E61C96F692DCFA9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220427111713-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481CBB7E506E3DCEB11A7BFDCFA9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220427114055-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481AC52975356341A964314DCFA9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <PH0PR12MB548121654DFF8442593FF26DDCFA9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220427153119-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220427153119-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Cornelia Huck <cohuck@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Wednesday, April 27, 2022 3:32 PM

> > I think further, it appears a real bug that requires so special handlin=
g in the
> device for next years to carry.
> >
> > Imagine this sequence.
> > 1. A virtio device is handed over to guest VM 2. A virtio device
> > started queue_reset sequence, So register values are:
> > queue_enable =3D 1, q_reset=3D1
> > 2. guest VM poled the q_reset register.
> > Queue_enable =3D 1, q_reset =3D 0 (because device is doing the resettin=
g
> > the queue) 3. HV suspend the VM and queried the VQ state VQ state
> > returned q_enable=3D1, q_reset =3D 0.
> >
> > HV doesn't know what q_reset=3D0 mean here, is it 0 because it was neve=
r
> reset?
> > Or it is 0 because GVM Started the reset, but reset didn't finish?
> >
> > When this virtio device is restored on the other side, HV and device do=
esn't
> know how to deal with this.
> >
> > A WA that all devices will implement is, not returning 0, in step_2, bu=
t
> return say q_reset =3D 0xa to indicate that its other than 1 and other th=
an 0.
> > But hey, the destination side needs to treat this special 0xa and conve=
rt to
> internal q_yet_busy stage.
> >
> > And this answer Jason and myself why queue_enable shouldn't be
> overloaded for this busy_wait register.
> > Hence queue_reset register seems the right choice with the fix.
> >
> > Starting to think of workaround even before the spec release is not
> elegant.
> > Lets please fix this, bug effect is expanding beyond the primary virtio
> device itself.
>=20
> Thanks Parav. Updating the github issue with more motivation would be a
> good idea.
Done.

