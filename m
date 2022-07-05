Return-Path: <virtio-comment-return-3207-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Parav Pandit <parav@nvidia.com>
Date: Tue, 5 Jul 2022 15:11:43 +0000
Message-ID: <PH0PR12MB5481D9416A601E6F2D4A32FFDC819@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220426225824.5918-1-mgurtovoy@nvidia.com>
 <20220705095514-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220705095514-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Subject: [virtio-comment] RE: [PATCH v5 0/7] Introduce device group and device management
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: "jasowang@redhat.com" <jasowang@redhat.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Oren Duer <oren@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, "aadam@redhat.com" <aadam@redhat.com>, "virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Tuesday, July 5, 2022 9:57 AM
>=20
> On Wed, Apr 27, 2022 at 01:58:17AM +0300, Max Gurtovoy wrote:
> > Hi,
> > A device group definition will help extending the virtio specefication
> > for various future features that require a notion of grouping devices
> > together or managing devices inside a group. A device group include one=
 or
> more virtio devices.
> > For now, only support for type 1 device group was added.
>=20
> How about posting a new version? I frankly think between the hardware
> hack I proposed and the new admin queue transport proposal, we do not
> need to work hard to save on writeable registers and so for starters at l=
east
> we can just use feature bits instead of the query capability command.

Reader and writer via different channel is really a hack.
It still doesn't help to have efficient hw.

What is the technical reason to use feature bits which has strong relations=
hips with device initialization sequence?
The proposed bits are AQ functionality bits and not per_say device feature =
bits?

This enables to build device in lot more flexible (and frankly simple way).
Looking at sw guest driver being simple to use existing limited 64-bits is =
just one part of it.

And when AQ exists, most of the plumbing comes for free.
So I fail to see the simplicity benefit of overloading feature bits for thi=
ngs that has no relation to device init sequence.


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

