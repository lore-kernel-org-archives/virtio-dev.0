Return-Path: virtio-dev-return-7013-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 04D2F985E38
	for <virtio-dev@lists.oasis-open.org>; Tue,  7 Apr 2020 07:56:03 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
Message-ID: <f3c003fb-9e54-2a13-47cf-a8820b96e62d@redhat.com>
Date: Tue, 7 Apr 2020 15:55:50 +0800
MIME-Version: 1.0
Content-Language: en-US
Subject: [virtio-dev] Doorbell mapping of vDPA
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: virtio-networking@redhat.com, Virtio-Dev <virtio-dev@lists.oasis-open.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi all:

To get native performance of VF, we need to map doorbell to guest to=20
avoid unnecessary vmexit. In order to do this, we will launch qemu with=20
page-per-vq=3Don. This means the each doorbell register should be located=
=20
at the beginning of 4K page and does not share the page with other=20
registers. Then vDPA framework can safely map it into the guest physical=20
address (GPA) range defined by qemu. It could be either

1) a single doorbell register that is used by all virtqueues

or

2) several different per-vq doorbell registers

If you decide to implement a virtio-pci register layout, need to make=20
sure for notification structure (4.1.4.4 of virtio spec):

For each virtqueue, the result=20
ofcap.offset+queue_notify_off*notify_off_multiplier is PAGE_SIZE (e.g=C2=A0=
=20
4K) alignment, and the doorbeel does not share the page with other=20
registers.

And it would be better if queue_notify_off, notify_off_multiplier can be=20
changed via firmware for extra flexibility.

Please check and make sure your hardware have such ability and feel free=20
to ask if you have questions (offline if necessary).

Thanks






---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

