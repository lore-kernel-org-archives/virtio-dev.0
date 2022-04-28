Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [virtio-dev] [PATCH v2] virtio: Improve queue_reset polarity to
 match to default reset state
Date: Thu, 28 Apr 2022 19:13:59 +0000
Message-ID: <PH0PR12MB5481274EEA5A680388259263DCFD9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220427102559.305669-1-parav@nvidia.com>
 <20220427163003-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481BFEF514B5D7E7B4ED085DCFD9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <8735hxmzm1.fsf@redhat.com>
In-Reply-To: <8735hxmzm1.fsf@redhat.com>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Cornelia Huck <cohuck@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>


> From: Cornelia Huck <cohuck@redhat.com>
> Sent: Thursday, April 28, 2022 3:33 AM
>=20
> On Thu, Apr 28 2022, Parav Pandit <parav@nvidia.com> wrote:
>=20
> > All above comments are taken care now with Cornelia's wording for your
> input and by correctly updating device side section now.
> > Sending v3.
>=20
> Honestly, I think it's a bit early for sending a v3 already, since it see=
ms we've
> not reached complete agreement yet what this should look like in the end,
> and what we can/should do for 1.2 and what should be deferred for 1.3. At
> least, it's about as clear as mud to me. Maybe someone can summarize?

Summary:
1. Michel suggested to continue to keep queue_reset register with the propo=
sed fixes of v3
2. Jason is ok with the use cases that we see on hand are addressed with th=
is register fix
3. Xuan's comments are addressed already in v2.
4. Comments posted from you, Michael and Jason are taken care in v3.
Waiting for reviews of v3 from Xuan, Jason, Michael for 1.2 merge.
5. github issue is up to date

I derive that we should get the fixes in 1.2.
Any complex advancement for other use cases is likely in 1.3.

Michael,
Please correct me if above is not accurate.
Did I miss anything for MMIO in v3?

