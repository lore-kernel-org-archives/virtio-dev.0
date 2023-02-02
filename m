Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [virtio-comment] RE: [virtio-dev] [PATCH v7] virtio-net: support
 inner header hash
Date: Thu, 2 Feb 2023 03:55:39 +0000
Message-ID: <PH0PR12MB548197725E16BC2B9954C926DCD69@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230104071401.31746-1-hengqi@linux.alibaba.com>
 <PH0PR12MB54813142D74C1328873435E2DCC79@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230131055710.GC34480@h68b04307.sqa.eu95>
 <PH0PR12MB5481A27116866CCE1000113FDCD19@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230201015350-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230201015350-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, Jason Wang <jasowang@redhat.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Yuri Benditovich <yuri.benditovich@daynix.com>, Cornelia Huck <cohuck@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>


> From: virtio-comment@lists.oasis-open.org <virtio-comment@lists.oasis-
> open.org> On Behalf Of Michael S. Tsirkin
> Sent: Wednesday, February 1, 2023 1:57 AM

> > Also, this patch is adding two functionalities.
> > 1. Inner header hash calculation of existing already defined hash
> > types 2. outer header hash for new type for GRE,VXLAN,GENEVE.
> > #1 should be in 1st patch.
> > #2 should be in 2nd patch.
> > This is better to review.
>=20
> Parav, you come to this discussion pretty late. Asking to split up the pa=
tch when
> it's v1/v2 is ok. Asking after others have already reviewed v6 is not you=
 are
> making review easier for yourself but re-review harder for others who alr=
eady
> have a mind map of the patch.
>=20
> In this case unless we really want to enable these separately (and frankl=
y I don't
> see a good reason to) then splitting it up makes review more confusing.
>
No. There is no need to enable it separately.
It was hard to parse new inner type decoding addition which has close to ze=
ro relation to outer headers.

As you say, it has some history, I don't have strong opinion to split.
But going forward in subsequent work, it is better to see logical changes i=
n multiple patches.

