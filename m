Return-Path: virtio-dev-return-7042-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C1103985FDB
	for <virtio-dev@lists.oasis-open.org>; Fri, 10 Apr 2020 03:36:27 +0000 (UTC)
MIME-Version: 1.0
References: <20200408225302.18764.209.stgit@localhost.localdomain>
 <20200408225529.18764.44086.stgit@localhost.localdomain> <06ac44b9-77ae-7686-8a65-7edff2cbf1b7@redhat.com>
 <CAKgT0UdLRKyc47izJO-rukHmj4cWP1xOzrxBv1ZX4yF92nH8Kg@mail.gmail.com> <987022c8-3aed-dccb-df02-d834500c04d3@redhat.com>
In-Reply-To: <987022c8-3aed-dccb-df02-d834500c04d3@redhat.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 9 Apr 2020 20:36:14 -0700
Message-ID: <CAKgT0UdYu7GnY_w_50p_7RZ+gSSP5hMUgNqsscqU8fdvFc1yQA@mail.gmail.com>
Subject: [virtio-dev] Re: [PATCH v18 QEMU 3/3] virtio-balloon: Provide a interface for free
 page reporting
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Apr 9, 2020 at 10:35 AM David Hildenbrand <david@redhat.com> wrote:
> On 09.04.20 19:34, Alexander Duyck wrote:
> >>>  hw/virtio/virtio-balloon.c         |   48 ++++++++++++++++++++++++++=
+++++++++-
> >>>  include/hw/virtio/virtio-balloon.h |    2 +-
> >>>  2 files changed, 47 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> >>> index 1c6d36a29a04..297b267198ac 100644
> >>> --- a/hw/virtio/virtio-balloon.c
> >>> +++ b/hw/virtio/virtio-balloon.c
> >>> @@ -321,6 +321,42 @@ static void balloon_stats_set_poll_interval(Obje=
ct *obj, Visitor *v,
> >>>      balloon_stats_change_timer(s, 0);
> >>>  }
> >>>
> >>> +static void virtio_balloon_handle_report(VirtIODevice *vdev, VirtQue=
ue *vq)
> >>> +{
> >>> +    VirtIOBalloon *dev =3D VIRTIO_BALLOON(vdev);
> >>> +    VirtQueueElement *elem;
> >>> +
> >>> +    while ((elem =3D virtqueue_pop(vq, sizeof(VirtQueueElement)))) {
> >>> +        unsigned int i;
> >>> +
> >>> +        for (i =3D 0; i < elem->in_num; i++) {
> >>> +            void *addr =3D elem->in_sg[i].iov_base;
> >>> +            size_t size =3D elem->in_sg[i].iov_len;
> >>> +            ram_addr_t ram_offset;
> >>> +            size_t rb_page_size;
> >>> +            RAMBlock *rb;
> >>> +
> >>> +            if (qemu_balloon_is_inhibited() || dev->poison_val) {
> >>> +                continue;
> >>> +            }
> >>
> >> These checks are not sufficient. See virtio_balloon_handle_output(),
> >> where we e.g., check that somebody doesn't try to discard the bios.
> >>
> >> Maybe we can factor our/unify the handling in both code paths.
> >
> > I am going to have to look at this further. If I understand correctly
> > you are asking me to add all of the memory section checks that are in
> > virtio_balloon_handle_output correct?
> >
> > I'm not sure it makes sense with the scatterlist approach I have taken
> > here. All of the mappings were created as a scatterlist of writable
> > DMA mappings unlike the regular balloon which is just stuffing PFN
> > numbers into an array and then sending the array across. As such I
> > would think there are already such protections in place. For instance,
> > you wouldn't want to let virtio-net map the BIOS and request data be
> > written into that either, correct? So I am assuming there is something
> > there to prevent that already isn't there?
>
> Good point, let's find out :)

Okay, so I believe I figured it out. From what I can tell there is a
call in address_space_map that will determine if we can directly write
to the page or not. However it looks like there might be one minor
issue as it is assuming it can write directly to ROM devices and that
isn't correct. I will add a patch to my set to address that.

Other than that the behavior seems to be that a bounce buffer will be
allocated on the first instance of a page backed by ROM or anything
other than RAM, and after that it will return NULL until the bounce
buffer is freed. If we start getting NULLs the mapping will be aborted
and we wouldn't even get into this code path. After we unmap the
region it will attempt to use address_space_write which should fail
for any region that isn't meant to be written to, or it will copy
zeros out of the bounce buffer into the region if it is writable via
address_space_write.

So the DMA mapping API in virtqueue_pop/virtqueue_push will take care
of doing the right stuff for the mappings in the case that the guest
is trying to do something really stupid, at least after I address the
direct write access to rom_device regions.

- Alex

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

