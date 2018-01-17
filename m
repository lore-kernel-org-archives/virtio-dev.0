Return-Path: virtio-dev-return-2986-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id A43761CB8078
	for <virtio-dev@lists.oasis-open.org>; Wed, 17 Jan 2018 07:53:07 -0800 (PST)
From: "Wang, Wei W" <wei.w.wang@intel.com>
Date: Wed, 17 Jan 2018 15:52:52 +0000
Message-ID: <286AC319A985734F985F78AFA26841F7393CF34B@shsmsx102.ccr.corp.intel.com>
References: <1516170720-4948-1-git-send-email-wei.w.wang@intel.com>
	<1516170720-4948-2-git-send-email-wei.w.wang@intel.com>
 <878tcw4ssp.fsf@secure.laptop>
In-Reply-To: <878tcw4ssp.fsf@secure.laptop>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [virtio-dev] RE: [Qemu-devel] [PATCH v1 1/4] virtio-balloon:
 VIRTIO_BALLOON_F_FREE_PAGE_VQ
To: "quintela@redhat.com" <quintela@redhat.com>
Cc: "yang.zhang.wz@gmail.com" <yang.zhang.wz@gmail.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "quan.xu0@gmail.com" <quan.xu0@gmail.com>, "mst@redhat.com" <mst@redhat.com>, "liliang.opensource@gmail.com" <liliang.opensource@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "nilal@redhat.com" <nilal@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wednesday, January 17, 2018 7:41 PM, Juan Quintela wrote:
> Wei Wang <wei.w.wang@intel.com> wrote:
> > +void skip_free_pages_from_dirty_bitmap(RAMBlock *block, ram_addr_t
> offset,
> > +                                       size_t len) {
> > +    long start =3D offset >> TARGET_PAGE_BITS,
> > +         nr =3D len >> TARGET_PAGE_BITS;
> > +
> > +    bitmap_clear(block->bmap, start, nr);
>=20
> But what assures us that all the nr pages are dirty?

Actually the free page optimization is used for the bulk stage, where all t=
he pages are treated as dirty. In patch 2, we have:

+            if (rs->free_page_support) {
+                bitmap_set(block->bmap, 1, pages);
+            } else {
+                bitmap_set(block->bmap, 0, pages);
+            }


>=20
> > +    ram_state->migration_dirty_pages -=3D nr;
>=20
> This should be
> ram_state->migration_dirty_pages -=3D
>      count_ones(block->bmap, start, nr);
>=20
> For a count_ones function, no?

Not really. "nr" is the number of bits to clear from the bitmap, so "migrat=
ion_dirty_pages -=3D nr" shows how many dirty bits left in the bitmap.

One cornercase I'm thinking about is when we do=20
bitmap_clear(block->bmap, start, nr);
would it be possible that "start + nr" exceeds the bitmap size? that is, wo=
uld it be possible that the free page block (e.g. 2MB) from the guest cross=
es the QEMU ram block boundary?


> Furthermore, we have one "optimization" and this only works for the secon=
d
> stages onward:
>=20
> static inline
> unsigned long migration_bitmap_find_dirty(RAMState *rs, RAMBlock *rb,
>                                           unsigned long start) {
>     unsigned long size =3D rb->used_length >> TARGET_PAGE_BITS;
>     unsigned long *bitmap =3D rb->bmap;
>     unsigned long next;
>=20
>     if (rs->ram_bulk_stage && start > 0) {
>         next =3D start + 1;
>     } else {
>         next =3D find_next_bit(bitmap, size, start);
>     }
>=20
>     return next;
> }
>=20
> So, for making this really work, we have more work to do.
>=20
> Actually, what I think we should do was to _ask_ the guest which pages ar=
e
> used at the beggining, instead of just setting all pages as dirty, but th=
at
> requires kernel changes and lot of search of corner cases.
>=20

This series optimizes the bulk stage memory transfer. Do you mean you have =
another idea to optimize the second round and onward? How would you let the=
 guest track pages that are written?

Best,
Wei



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

