Return-Path: <virtio-comment-return-4051-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Parav Pandit <parav@nvidia.com>
Date: Wed, 8 Feb 2023 17:30:28 +0000
Message-ID: <PH0PR12MB5481BBF4B010D1B197DEF27FDCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230206084746.40536-1-alvaro.karsz@solid-run.com>
 <PH0PR12MB54817FE12FD77CC74B36D136DCDA9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230206160206-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54818A5BD25527FEAEAFF6CCDCDA9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230206171410-mutt-send-email-mst@kernel.org>
 <DM8PR12MB54806C5AF84EB7974D80FE0EDCDA9@DM8PR12MB5480.namprd12.prod.outlook.com>
 <20230207091242-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230207091242-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Subject: RE: [virtio-comment] RE: [virtio-dev] [PATCH] virtio-net: Fix and
 update VIRTIO_NET_F_NOTF_COAL feature
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Alvaro Karsz <alvaro.karsz@solid-run.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com" <jasowang@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Tuesday, February 7, 2023 9:18 AM

> > Why migration generate too many spurious interrupts?
>=20
> Because, you might want to migrate from hardware with to hardware without
> coalescing features. So you just tell guest "sure I will coalesce" but in=
 fact send
> interrupts normally.

For the hardware that has fake coalescing, HV wouldn't know it anyway witho=
ut doing pre verification.
And HV may not migrate in such case for best experience.
HV may choose to migrate with low accuracy as you say, which is fine.

But the spec guidance for the device implementations is to promote some rea=
sonable level of accuracy.
Hard to define in words here.
Best effort is wide spectrum of range. :)

Typically, we say in the spec as SHOULD.=20
So, lets skip the best-effort wording and stick to SHOULD part like rest of=
 the spec.


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

