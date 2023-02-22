Return-Path: <virtio-comment-return-4454-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Parav Pandit <parav@nvidia.com>
Date: Wed, 22 Feb 2023 14:28:47 +0000
Message-ID: <PH0PR12MB548187AB51323E8687FFC708DCAA9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230222032148.106406-1-hengqi@linux.alibaba.com>
 <PH0PR12MB5481457D8EE37A39198592C1DCAA9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230222012200-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230222012200-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Subject: [virtio-comment] RE: [PATCH v6] virtio-net: support the virtqueue coalescing
 moderation
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, Alvaro Karsz <alvaro.karsz@solid-run.com>, David Edmondson <david.edmondson@oracle.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Cornelia Huck <cohuck@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Wednesday, February 22, 2023 1:29 AM

> > MMIO device has vq_index register too.
> > I am inclined to vq_index given current state of spec
>=20
> [mst@tuck virtio]$ git grep vq_index|wc -l
> 0
>=20
:)

Grep for "virtqueue index".
We need to change "virtqueue index" to "virtqueue number".

> > and new additions by Michael.
>=20
> admin vq? Good point, I will change that to vqn too.

Ok. sounds good.

>=20
> > Michael,
> > Can you please suggest vqn or vq_index to use?
>=20
> [mst@tuck virtio]$ git grep vqn|wc -l
> 5
>=20
> I'd say vqn has precedent.
>=20

This publicly archived list offers a means to provide input to the=0D
OASIS Virtual I/O Device (VIRTIO) TC.=0D
=0D
In order to verify user consent to the Feedback License terms and=0D
to minimize spam in the list archive, subscription is required=0D
before posting.=0D
=0D
Subscribe: virtio-comment-subscribe@lists.oasis-open.org=0D
Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org=0D
List help: virtio-comment-help@lists.oasis-open.org=0D
List archive: https://lists.oasis-open.org/archives/virtio-comment/=0D
Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf=
=0D
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lis=
ts=0D
Committee: https://www.oasis-open.org/committees/virtio/=0D
Join OASIS: https://www.oasis-open.org/join/

