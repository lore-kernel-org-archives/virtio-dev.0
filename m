Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [virtio-dev] [PATCH v3] virtio-net: support the virtqueue
 coalescing moderation
Date: Thu, 16 Feb 2023 15:12:12 +0000
Message-ID: <PH0PR12MB5481EDBE8EE9DA14AA3E0943DCA09@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230216144301.57728-1-hengqi@linux.alibaba.com>
 <bc5776d7-dda2-0e5f-be75-8ee044d93cb7@linux.alibaba.com>
In-Reply-To: <bc5776d7-dda2-0e5f-be75-8ee044d93cb7@linux.alibaba.com>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Heng Qi <hengqi@linux.alibaba.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "Michael S . Tsirkin" <mst@redhat.com>
Cc: Yuri Benditovich <yuri.benditovich@daynix.com>, Jason Wang <jasowang@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>



> From: Heng Qi <hengqi@linux.alibaba.com>
> Sent: Thursday, February 16, 2023 9:49 AM


> Hi Michael.
>=20
> I know you suggested in v2 that I split the virtqueue SET and GET command=
s in
> series, but I have a bit of a problem trying to split because there are s=
ome
> statements where SET and GET are glued together.
> Please see the following places.
>=20
> If you think the split is better, I'll split it again and send it right a=
way.

I agree with Michael, better to split.

It should be possible.
First patch without next patch consideration.
Second patch can modify the previous line, this is fine.
Its common practice and better even if it touches some of the same lines.

