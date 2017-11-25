Return-Path: virtio-dev-return-2709-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 616EE5818FA8
	for <virtio-dev@lists.oasis-open.org>; Sat, 25 Nov 2017 11:55:58 -0800 (PST)
From: Lars Ganrot <lga@napatech.com>
Date: Sat, 25 Nov 2017 19:55:53 +0000
Message-ID: <24fcb5e29d8d446fa6a13d262205edc4@napatech.com>
References: <20171108141659-mutt-send-email-mst@kernel.org>
In-Reply-To: <20171108141659-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: RE: [virtio-dev] [PATCH RFC] packed ring layout spec v5
To: "Michael S. Tsirkin" <mst@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Michael and others,

Hopefully my question below follows the forum format.

BR,

-Lars
>=20
> \subsection{In-order use of descriptors} \label{sec:Packed Virtqueues / I=
n-order
> use of descriptors}
>=20
> Some devices always use descriptors in the same order in which they have =
been
> made available. These devices can offer the VIRTIO_F_IN_ORDER feature. If
> negotiated, this knowledge allows devices to notify the use of a batch of=
 buffers
> to the driver by only writing out a single used descriptor with the Buffe=
r ID
> corresponding to the last descriptor in the batch.
> =20
This VIRTIO_F_IN_ORDER feature bit answers one of my earlier questions, how=
ever I'm curious if it couldn't also be usable in the non-ring Virtqueue?

If the device always returns buffers in order, then couldn't the driver ski=
p the step of reading the used.ring for read-only buffers  (e.g. TX for net=
 devices)? The used.idx tells how many buffers were returned, and since the=
y are returned in the same order as the driver sent them, it knows what the=
ir indices are. This would then save one cache-miss in the old structure to=
o.

And a follow-up questions would then be: if a device always returns buffers=
 in order, does the v1.0 specification not require drivers to reuse descrip=
tors in the same order as they are returned? I think 3.2.1.1 implies that a=
t least. If so, wouldn't new descriptors always be placed back2back in the =
descriptor table (contiguous memory)?

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

