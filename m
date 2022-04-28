Return-Path: <virtio-dev-return-9484-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E6CAE98644F
	for <virtio-dev@lists.oasis-open.org>; Thu, 28 Apr 2022 01:09:09 +0000 (UTC)
From: Parav Pandit <parav@nvidia.com>
Date: Thu, 28 Apr 2022 01:09:05 +0000
Message-ID: <PH0PR12MB54814206732A665872182246DCFD9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220427102559.305669-1-parav@nvidia.com>
 <87fsly7kvp.fsf@redhat.com>
In-Reply-To: <87fsly7kvp.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] RE: [PATCH v2] virtio: Improve queue_reset polarity to match to
 default reset state
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Cornelia Huck <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "mst@redhat.com" <mst@redhat.com>
Cc: "stefanha@redhat.com" <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>


> From: Cornelia Huck <cohuck@redhat.com>
> Sent: Wednesday, April 27, 2022 8:48 AM

[..]
> > +\field{queue_reset} to reset the queue, driver MUST verify that the
> > +queue
>=20
> s/driver/the driver/
>=20
Done.

> > +has been reset by reading back \field{queue_reset} until device return=
s a
> value of 0.
>=20
> s/device/the device/
Done.

>=20
> > +Device continue to report value of 1 for the \field{queue_reset}
> > +until device finishes the queue reset request.
>=20
> This looks a bit odd: Shouldn't that go into the normative section for th=
e
> device instead?
Yes, Michael also had same comment.
I am moving there.

>=20
> > When the device completes the queue reset, \field{queue_reset}
> > +and \field{queue_enable} set to zero, indicating that specified queue
> > +is ready to be enabled again.
>=20
> Same here. I think a statement that the driver MUST NOT consider queue
> reset to be complete until it reads back 0 in both queue_reset and
> queue_enable is more appropriate here.
>=20
This was very useful. I had hard time put the wording as driver centric way=
.
Thanks a lot.

[..]

> Similar comments as for the pci section.

Fixed.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

