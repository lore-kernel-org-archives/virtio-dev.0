Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [PATCH v3 1/4] Add virtio Admin virtqueue
Date: Tue, 8 Feb 2022 06:25:41 +0000
Message-ID: <PH0PR12MB548164CFE929F59EEDBD3557DC2D9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220203075716.11684-1-mgurtovoy@nvidia.com>
 <20220203075716.11684-2-mgurtovoy@nvidia.com>
 <20220207052843-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220207052843-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com" <jasowang@redhat.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>, "stefanha@redhat.com" <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Monday, February 7, 2022 4:09 PM
>=20
> Next, trying to think about scalable iov extensions. So we will have grou=
ps of
> VFs and then SFs as the next level.
> How does one differentiate between the two?
> Maybe reserve a field for "destination type"?
>
We already discussed this in v2.
SF will have different identification than 16-bits. And no one knows what t=
hat would be.
We just cannot reserve some arbitrary bytes for unknown.
You suggested in v2 to reserve 4 bytes for sf_id, and I explained you that =
4 bytes may not be enough.

Whether SFs are on top of VFs or SFs are on top of PFs or both is completel=
y different spec.
Whether PF will manage SFs of the VFs or it will be done nested manner by V=
F etc is a completely different discussion than what is being proposed here=
.
Whether PF will manage the SF is yet another big question. We work with use=
rs and they dislike this.
To address it, some OS has a different management interface (not visible to=
 PF) for SF life cycle even though SFs are anchored on a PF.

So SF/iov extension discussion has long way to go for community to first un=
derstand the use cases before crafting some extension.

So lets not complicate and mix things here for a blurry definition of scala=
ble iov/sf extension.

