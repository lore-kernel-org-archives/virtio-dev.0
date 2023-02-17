Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [PATCH v3] virtio-net: support the virtqueue coalescing
 moderation
Date: Fri, 17 Feb 2023 13:50:57 +0000
Message-ID: <PH0PR12MB5481424E467400B9B206D77FDCA19@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230216144301.57728-1-hengqi@linux.alibaba.com>
 <20230216111552-mutt-send-email-mst@kernel.org>
 <20230217052404.GA114259@h68b04307.sqa.eu95>
In-Reply-To: <20230217052404.GA114259@h68b04307.sqa.eu95>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Heng Qi <hengqi@linux.alibaba.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Yuri Benditovich <yuri.benditovich@daynix.com>, Jason Wang <jasowang@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>



> From: Heng Qi <hengqi@linux.alibaba.com>
> Sent: Friday, February 17, 2023 12:24 AM

> I think there are two kinds of sequences:
> #Seq1:
> 1. vq is disabled (vq params are reset to max_packets =3D 0, max_usecs =
=3D 0) 2.
> VQ_SET command arrives with max_packets=3D10, max_usecs =3D 8 3. vq is en=
abled
> (vq params are max_packets =3D 0, max_usecs =3D 0) After #3 is done, vq p=
arams
> should be max_packets =3D 0, max_usecs =3D 0, because the device cannot a=
pply
> parameters when vq is disabled.
> Other reason is that parameters determined based on the previous traffic
> information before vq is re-enabled, and it is not applicable now.
From dev point of view, above is not a valid sequence.
VQ is the object whose lifecycle (create/delete/query/modify) is triggered =
by the driver.
So step 2 cannot happen before step 3.
If driver does that, driver should get error code INVALID_VQ on step 2.

>=20
> #Seq1:
> 1. vq is disabled (vq params are reset to max_packets =3D 0, max_usecs =
=3D 0) 2. vq
> is enabled (vq params are max_packets =3D 0, max_usecs =3D 0) 3. VQ_SET
> command arrives with max_packets=3D10, max_usecs =3D 8 After 3 is done, v=
q
> params should be max_packets =3D 10, max_usecs =3D 8
>=20
> Thanks.
>=20
> >
> > > +
> > > +A device MAY NOT set the coalescing parameter to the exact same
> > > +value as the one passed in by a driver. For example, the value of
> \field{max_packets} set by the driver is 15, but the device MAY store a v=
alue
> that is a power of 2, that is, 16.
> > > +
> > >  A device SHOULD NOT send used buffer notifications to the driver, if=
 the
> notifications are suppressed as explained in \ref{sec:Basic Facilities of=
 a Virtio
> Device / Virtqueues / Used Buffer Notification Suppression}, even if the
> coalescing counters expired.
> > >
> > >  Upon reset, a device MUST initialize all coalescing parameters to 0.
> > > --
> > > 2.19.1.6.gb485710b

