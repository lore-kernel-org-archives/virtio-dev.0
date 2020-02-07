Return-Path: virtio-dev-return-6703-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4EDDE98610C
	for <virtio-dev@lists.oasis-open.org>; Fri,  7 Feb 2020 17:42:56 +0000 (UTC)
From: Benedikt Radtke <benediktradtke@mailbox.tu-berlin.de>
Message-ID: <eb379913-fcd9-1030-6f51-2dfeae7c95a9@mailbox.tu-berlin.de>
Date: Fri, 7 Feb 2020 18:42:52 +0100
MIME-Version: 1.0
Subject: [virtio-dev] May a device use buffers after putting them into the used ring?
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

Hey all,

I am using qemu-system-arm with "-device virtio-net-device" to emulate a=20
nic (mmio, legacy). I have noticed that a receive queue uses the same=20
buffer multiple times, although it has been added to the used ring (and=20
not been added to the available ring again). Is it allowed to do that?

This is the first buffer (index 0) in the descriptor table:
(gdb) x/16x 0x46008000
0x46008000:=C2=A0=C2=A0=C2=A0=C2=A0 0x00000000=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0x00000000=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0xffff0000 0xffffffff
0x46008010:=C2=A0=C2=A0=C2=A0=C2=A0 0x000a5552=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0x06080202=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x00080100 0x01000406
0x46008020:=C2=A0=C2=A0=C2=A0=C2=A0 0x000a5552=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0x000a0202=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x00000202 0x00000000
0x46008030:=C2=A0=C2=A0=C2=A0=C2=A0 0x0f02000a=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0x00000000=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x00000000 0x00000000
As you can see it contains a legacy virtio_net_hdr and an ethernet frame=20
with an arp packet.

After receiving two such arp packets the used ring looks like this:
(gdb) x/8x 0x46005000
0x46005000:=C2=A0=C2=A0=C2=A0=C2=A0 0x00020001=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0x00000000=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x00000034 0x00000000
0x46005010:=C2=A0=C2=A0=C2=A0=C2=A0 0x00000034=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0x00000000=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x00000000 0x00000000

The used index is 2, and both entries use the first buffer in the=20
descriptor table (0). The virtio 1.1 spec says in section 2.6.8 ("The=20
Virtqueue Used Ring"): "The used ring is where the device returns=20
buffers once it is done with them". I'd expect that any buffer that=20
appears in the used ring will not be touched by the device (unless the=20
driver puts it into an available ring again).

Is my interpretation of the phrasing wrong, or is the device misbehaving?

Kind regards,
Benni


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

