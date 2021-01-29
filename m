Return-Path: virtio-dev-return-7961-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8C635986583
	for <virtio-dev@lists.oasis-open.org>; Fri, 29 Jan 2021 08:38:40 +0000 (UTC)
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Message-ID: <875d1495-9511-4b5d-062c-2063ee9bed7e@redhat.com>
Date: Fri, 29 Jan 2021 09:38:25 +0100
MIME-Version: 1.0
Subject: [virtio-dev] Packed ring only devices clarification
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
To: virtio-dev@lists.oasis-open.org, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Hello,

In the Virtqueues section of the Virtio specification [0], it is
mentioned that:

"
Every driver and device supports either the Packed or the Split
Virtqueue format, or both.
"

However, it seems there is no way to differentiate whether the device
supports both split and packed ring, or only packed ring by reading
its features bits.

In the case of live-migration, it means we would need to trigger a
features negotiation before the migration is initiated, and see if
FEATURES_OK device status bit is set. Still, we could not be sure a
failure would be due to the device supporting only packed ring.

Is my understanding correct?

If so, maybe we would need to introduce a new feature bit for split
ring, and also a feature bit indicating compliance with the new spec
version for backward compatibility:

VIRTIO_F_VERSION_1_2(39):
    This indicates compliance with Virtio version 1.2 specification.

VIRTIO_F_RING_SPLIT(40):
    This feature indicates support for the split virtqueue layout as
    described in 2.6 Split Virtqueues.


Best regards,
Maxime

[0]:
https://docs.oasis-open.org/virtio/virtio/v1.1/csprd01/virtio-v1.1-csprd01.=
html#x1-230005


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

