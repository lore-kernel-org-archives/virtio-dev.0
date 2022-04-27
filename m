Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [PATCH v1] virtio: Improve queue_reset polarity to match to
 default reset state
Date: Wed, 27 Apr 2022 09:33:57 +0000
Message-ID: <PH0PR12MB5481BDD79DF042B3F2B3F740DCFA9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220426000657.289786-1-parav@nvidia.com>
 <1651051543.7111266-3-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1651051543.7111266-3-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com" <jasowang@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>



> From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Sent: Wednesday, April 27, 2022 5:26 AM

> >  The device MUST reset the queue when 1 is written to
> > \field{queue_reset}, and -present a 1 in \field{queue_reset} after the
> > queue has been reset, until the
> > +present 1 in \field{queue_reset} after the queue has been reset,
> > +until the
>=20
> 1 -> 0?

Right. I missed updating it.
Fixing it in v2.

> >  The device MUST reset the queue when 1 is written to
> > \field{QueueReset}, and -present a 1 in \field{QueueReset} after the
> > queue has been reset, until the
> > +present 1 in \field{QueueReset} after the queue has been reset, until
> > +the
>=20
> 1 -> 0?
This too.

