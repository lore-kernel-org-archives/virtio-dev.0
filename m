Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [virtio-dev] Re: queue_reset register polarity to improve
Date: Mon, 25 Apr 2022 12:01:21 +0000
Message-ID: <PH0PR12MB54811ABC8173F4DE9AABED5EDCF89@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <PH0PR12MB54819125071ED675E2B72F0EDCF99@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220424023301-mutt-send-email-mst@kernel.org> <871qxl8k51.fsf@redhat.com>
In-Reply-To: <871qxl8k51.fsf@redhat.com>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Cornelia Huck <cohuck@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Halil Pasic <pasic@linux.ibm.com>
List-ID: <virtio-dev.lists.oasis-open.org>


> From: Cornelia Huck <cohuck@redhat.com>
> Sent: Monday, April 25, 2022 7:42 AM

> >
> > Well it's been merged since November. Probably too late unless you can
> > convince the TC that the current feature should be abandoned and the
> > feature completely redesigned. Above does not look like a deal
> > breaker.
>=20
> Agreed. We can add clarifications on top, though.

I replied to Michael in other thread.
Feature was merged in Dec-21.
It is likely not too late to fix it now, instead of keeping this behavior f=
or next 10 years.
Are there any devices, drivers that have adopted and broken due to this?
If not, lets please fix it.
Spec is not released, right?

