Return-Path: virtio-dev-return-7067-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 427DF985FAD
	for <virtio-dev@lists.oasis-open.org>; Wed, 15 Apr 2020 15:32:00 +0000 (UTC)
MIME-Version: 1.0
References: <20200410033729.24738.22879.stgit@localhost.localdomain>
 <20200410034143.24738.78852.stgit@localhost.localdomain> <4f26ec52-5520-1bfb-a1e5-fe6492f7af60@redhat.com>
In-Reply-To: <4f26ec52-5520-1bfb-a1e5-fe6492f7af60@redhat.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 15 Apr 2020 08:31:47 -0700
Message-ID: <CAKgT0UeHwrj+RSb3o8ZPAnzA3+_M0eW4q36c-OU5ntL9W5i2jw@mail.gmail.com>
Subject: [virtio-dev] Re: [PATCH v19 QEMU 3/4] virtio-balloon: Provide an interface for
 free page reporting
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: David Hildenbrand <david@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Apr 15, 2020 at 1:17 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 10.04.20 05:41, Alexander Duyck wrote:
> > From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> >
> > Add support for free page reporting. The idea is to function very simil=
ar
> > to how the balloon works in that we basically end up madvising the page=
 as
> > not being used. However we don't really need to bother with any deflate
> > type logic since the page will be faulted back into the guest when it i=
s
> > read or written to.
> >
> > This provides a new way of letting the guest proactively report free
> > pages to the hypervisor, so the hypervisor can reuse them. In contrast =
to
> > inflate/deflate that is triggered via the hypervisor explicitly.
>
> Much better, thanks!
>
> >
> > Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> > ---
> >  hw/virtio/virtio-balloon.c         |   63 ++++++++++++++++++++++++++++=
+++++++-
> >  include/hw/virtio/virtio-balloon.h |    2 +
> >  2 files changed, 62 insertions(+), 3 deletions(-)
> >
> > diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> > index 1c6d36a29a04..86d8b48a8e3a 100644
> > --- a/hw/virtio/virtio-balloon.c
> > +++ b/hw/virtio/virtio-balloon.c
> > @@ -321,6 +321,57 @@ static void balloon_stats_set_poll_interval(Object=
 *obj, Visitor *v,
> >      balloon_stats_change_timer(s, 0);
> >  }
> >
> > +static void virtio_balloon_handle_report(VirtIODevice *vdev, VirtQueue=
 *vq)
> > +{
> > +    VirtIOBalloon *dev =3D VIRTIO_BALLOON(vdev);
> > +    VirtQueueElement *elem;
> > +
> > +    while ((elem =3D virtqueue_pop(vq, sizeof(VirtQueueElement)))) {
> > +        unsigned int i;
> > +
> > +        for (i =3D 0; i < elem->in_num; i++) {
> > +            void *addr =3D elem->in_sg[i].iov_base;
> > +            size_t size =3D elem->in_sg[i].iov_len;
> > +            ram_addr_t ram_offset;
> > +            size_t rb_page_size;
> > +            RAMBlock *rb;
> > +
> > +            if (qemu_balloon_is_inhibited() || dev->poison_val) {
> > +                continue;
>
> actually, you want to do that in the outer loop, no?

I'll move that. Odds are compiler was doing that anyway.

> > +            }
> > +
> > +            /*
> > +             * There is no need to check the memory section to see if
> > +             * it is ram/readonly/romd like there is for handle_output
> > +             * below. If the region is not meant to be written to then
> > +             * address_space_map will have allocated a bounce buffer
> > +             * and it will be freed in address_space_unmap and trigger
> > +             * and unassigned_mem_write before failing to copy over th=
e
> > +             * buffer. If more than one bad descriptor is provided it
> > +             * will return NULL after the first bounce buffer and fail
> > +             * to map any resources.
> > +             */
> > +            rb =3D qemu_ram_block_from_host(addr, false, &ram_offset);
> > +            if (!rb) {
> > +                trace_virtio_balloon_bad_addr(elem->in_addr[i]);
> > +                continue;
> > +            }
> > +
> > +            /* For now we will simply ignore unaligned memory regions =
*/
> > +            rb_page_size =3D qemu_ram_pagesize(rb);
> > +            if (!QEMU_IS_ALIGNED(ram_offset | size, rb_page_size)) {
>
> /me thinks you can drop rb_page_size

You mean just fold it into the statement? I guess I can do that.

> I *think* there is still one remaining case to handle: Crossing RAM block=
s.
>
> Most probably you should check
>
> /* For now, ignore crossing RAM blocks. */
> if (ram_offset + size >=3D qemu_ram_get_used_length()) {
>         continue;
> }
>
> otherwise ram_block_discard_range() will report an error.

Makes sense. I can add that into the QEMU_IS_ALIGNED check.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

