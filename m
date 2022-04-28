Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [virtio-comment] [PATCH v3] virtio: Improve queue_reset polarity
 to match to default reset state
Date: Thu, 28 Apr 2022 21:53:52 +0000
Message-ID: <PH0PR12MB5481DD44B1F2C47A7C21A58ADCFD9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220428015041.333836-1-parav@nvidia.com>
 <20220428174206-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220428174206-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "stefanha@redhat.com" <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Thursday, April 28, 2022 5:49 PM

> >  If VIRTIO_F_RING_RESET has been negotiated, after the driver writes 1
> > to -\field{queue_reset} to reset the queue, it MUST verify that the
> > queue -has been reset by reading back \field{queue_reset} and ensuring
> > that it -is 1. The driver MAY re-enable the queue by writing a 1 to
> > -\field{queue_enable} after ensuring that the other virtqueue fields
> > have -been set up correctly. The driver MAY set driver-writeable queue
> > configuration
> > +\field{queue_reset} to reset the queue, the driver MUST NOT consider
> > +queue reset to be complete until it reads back 0 in both
> > +\field{queue_reset} and \field{queue_enable}.
>=20
> two reads are now required, this is unfortunate.
> why is it not enough to read back 0 in queue_reset?
>=20
Two reads are not required.
Only queue_reset read is required.
The wording movement let to this.
As a result, queue got disabled so queue_enable also becomes zero.

Above wording is incorrect from driver point of view.
I better write this in the device section and rephase only for queue_reset.

