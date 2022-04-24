Return-Path: <virtio-dev-return-9433-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E8C4D9865B0
	for <virtio-dev@lists.oasis-open.org>; Sun, 24 Apr 2022 00:49:22 +0000 (UTC)
From: Parav Pandit <parav@nvidia.com>
Date: Sun, 24 Apr 2022 00:49:19 +0000
Message-ID: <PH0PR12MB54819125071ED675E2B72F0EDCF99@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
Subject: [virtio-dev] queue_reset register polarity to improve
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "Michael S. Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi,

A recently defined queue_reset register has a little weird definition that =
we should improve.
When driver initiate queue reset, it writes queue_reset =3D 1.
When device is busy resetting the queue, on this driver request, it is expe=
cted to return queue_reset=3D0.
Once queue reset is completed it is expected to return queue_reset =3D 1.
(Polarity changed twice to same value as what was driver set). See more bel=
ow.

So state wise,
# q_enable, q_reset represents :
a) 0,0 -> device init time value
b) 1,0 -> vq is enabled and working
c) 1,1 -> vq is enabled, driver initiated reset
d) 1,0 -> vq is enabled, but device is busy doing the reset (conflicting de=
finition with above #b )
e) 0,1 -> vq reset is complete in the device and VQ is now disabled (again =
conflict with #a above )

Instead, I think we should have below better, consistent definition, no mat=
ter how queue reset occurs (init time or later).

q_enable, q_reset
A) 0, 0 -> default, device init time
B) 1, 0 -> driver has enabled vq
C) 1, 1 -> driver started q reset
D) 1, 1 -> q_reset stays 1 until device is busy resetting vq (communicating=
 that its working on resetting, consistent with #C)
E) 0, 0 -> q_reset by device is completed, q got disabled (now matches the =
state same as device init time #A)

Parav

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

