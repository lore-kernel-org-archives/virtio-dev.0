Return-Path: virtio-dev-return-2713-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 1F0365818F7B
	for <virtio-dev@lists.oasis-open.org>; Wed, 29 Nov 2017 00:12:27 -0800 (PST)
From: Lars Ganrot <lga@napatech.com>
Date: Wed, 29 Nov 2017 08:12:23 +0000
Message-ID: <1c66689d2d27414ba6372baecebff18b@napatech.com>
References: <20171108141659-mutt-send-email-mst@kernel.org>
 <24fcb5e29d8d446fa6a13d262205edc4@napatech.com>
 <20171128155148-mutt-send-email-mst@kernel.org>
In-Reply-To: <20171128155148-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: RE: [virtio-dev] [PATCH RFC] packed ring layout spec v5
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

> From: Michael S. Tsirkin [mailto:mst@redhat.com]
> Sent: 28. november 2017 15:37

> > If the device always returns buffers in order, then couldn't the driver=
 skip the
> >step of reading the used.ring for read-only buffers  (e.g. TX for net de=
vices)? The
> >used.idx tells how many buffers were returned, and since they are return=
ed in
> >the same order as the driver sent them, it knows what their indices are.=
 This
> >would then save one cache-miss in the old structure too.
>=20
> True. That would be another variant to support though.
>=20
> I doubt it'll outperform this one but I didn't test it specifically. Care=
 trying to
> implement it?

Agreed, and I don't see it as competing with the packed ring, however if th=
ere
are low hanging fruits, that improve performance of the non-ring structure
(in at least some significant use cases) they could be worth considering as=
 part
of a rev 1.1 specification too. I'll see what can be done for a prototype.

>=20
> > And a follow-up questions would then be: if a device always returns buf=
fers in
> >order, does the v1.0 specification not require drivers to reuse descript=
ors in the
> >same order as they are returned? I think 3.2.1.1 implies that at least. =
If so,
> >wouldn't new descriptors always be placed back2back in the descriptor ta=
ble
> >(contiguous memory)?
>=20
> You probably mean this:
> 1. Get the next free descriptor table entry, d
>=20
> and you interpret "next" here as "next in ring order".
>=20
> I'm not sure everyone follows this interpretation though.
>=20
> E.g. Linux does:
> static void detach_buf(struct vring_virtqueue *vq, unsigned int head,
>                        void **ctx)
> {
> ...
>         vq->vring.desc[i].next =3D cpu_to_virtio16(vq->vq.vdev, vq->free_=
head);
>         vq->free_head =3D head;
>=20
> So descriptors are added at head of the free list.  Next is interpreted a=
s next on
> this list.  E.g. with a single request in flight, it looks like a single =
descriptor will
> keep getting reused.
>=20

I guess there isn't an explicit enough requirement in v1.0 to claim right o=
r wrong=20
with regards to this. Enforcing it could however be made part of a driver=20
requirement imposed by the new IN_ORDER feature bit. Thus the IN_ORDER=20
feature bit for the non-ring would be defined to enforce that the descripto=
r indices=20
are always processed in-order by both the device and the driver.

My reason for this is to ensure that new descriptors are placed in a contig=
uous
range of the descriptor table, which should improve the L1$ prefetcher hit =
rate
for batching, and also provide means for efficient DMA in case of HW-offloa=
d.
With knowledge of the number of elements in each buffer it could maybe also=
 be=20
possible to calculate the descriptor index range to DMA.

BR,

-Lars

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

