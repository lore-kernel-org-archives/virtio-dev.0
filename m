Return-Path: virtio-dev-return-7068-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1AF68985FAD
	for <virtio-dev@lists.oasis-open.org>; Wed, 15 Apr 2020 17:17:28 +0000 (UTC)
MIME-Version: 1.0
References: <20200410033729.24738.22879.stgit@localhost.localdomain>
 <20200410034129.24738.36022.stgit@localhost.localdomain> <b6f97131-89dc-064a-5b87-2bf68437176d@redhat.com>
In-Reply-To: <b6f97131-89dc-064a-5b87-2bf68437176d@redhat.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 15 Apr 2020 10:17:15 -0700
Message-ID: <CAKgT0UcgbhKASE3RahdVZR35HHcnMVFGvh=q3qewgL7Yxin27w@mail.gmail.com>
Subject: [virtio-dev] Re: [PATCH v19 QEMU 1/4] virtio-balloon: Implement support for page
 poison tracking feature
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: David Hildenbrand <david@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Apr 15, 2020 at 1:08 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 10.04.20 05:41, Alexander Duyck wrote:
> > From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> >
> > We need to make certain to advertise support for page poison tracking i=
f
> > we want to actually get data on if the guest will be poisoning pages. S=
o
> > if free page hinting is active we should add page poisoning support and
> > let the guest disable it if it isn't using it.
> >
> > Page poisoning will result in a page being dirtied on free. As such we
> > cannot really avoid having to copy the page at least one more time sinc=
e
> > we will need to write the poison value to the destination. As such we c=
an
> > just ignore free page hinting if page poisoning is enabled as it will
> > actually reduce the work we have to do.
> >
> > Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> > ---
> >  hw/virtio/virtio-balloon.c         |   26 ++++++++++++++++++++++----
> >  include/hw/virtio/virtio-balloon.h |    1 +
> >  2 files changed, 23 insertions(+), 4 deletions(-)
> >
> > diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> > index a4729f7fc930..1c6d36a29a04 100644
> > --- a/hw/virtio/virtio-balloon.c
> > +++ b/hw/virtio/virtio-balloon.c
> > @@ -531,6 +531,15 @@ static void virtio_balloon_free_page_start(VirtIOB=
alloon *s)
> >          return;
> >      }
> >
> > +    /*
> > +     * If page poisoning is enabled then we probably shouldn't bother =
with
> > +     * the hinting since the poisoning will dirty the page and invalid=
ate
> > +     * the work we are doing anyway.
> > +     */
> > +    if (virtio_vdev_has_feature(vdev, VIRTIO_BALLOON_F_PAGE_POISON)) {
>
> Why not check for the poison value instead? (as you do in patch #3) ?

So if I recall correctly the vdev has feature requires the host to
indicate that the feature is in use. If page poisoning is not enabled
on the host then it clears the flag on its end and we can proceed with
the feature.

The comment above explains the "why". Basically poisoning a page will
dirty it. So why hint a page as free when that will drop it back into
the guest and result in it being dirtied again. What you end up with
is all the pages that were temporarily placed in the balloon are dirty
after the hinting report is finished at which point you made things
worse instead of helping to improve them.

>
> > +        return;
> > +    }
> > +
> >      if (s->free_page_report_cmd_id =3D=3D UINT_MAX) {
> >          s->free_page_report_cmd_id =3D
> >                         VIRTIO_BALLOON_FREE_PAGE_REPORT_CMD_ID_MIN;
>
> We should rename all "free_page_report" stuff we can to
> "free_page_hint"/"free_page_hinting" to avoid confusion (e.g., on my
> side :) ) before adding free page reporting .
>
> (looking at the virtio-balloon linux header, it's also confusing but
> we're stuck with that - maybe we should add better comments)

Are we stuck? Couldn't we just convert it to an anonymous union with
free_page_hint_cmd_id and then use that where needed?

> > @@ -618,12 +627,10 @@ static size_t virtio_balloon_config_size(VirtIOBa=
lloon *s)
> >      if (s->qemu_4_0_config_size) {
> >          return sizeof(struct virtio_balloon_config);
> >      }
> > -    if (virtio_has_feature(features, VIRTIO_BALLOON_F_PAGE_POISON)) {
> > +    if (virtio_has_feature(features, VIRTIO_BALLOON_F_PAGE_POISON) ||
> > +        virtio_has_feature(features, VIRTIO_BALLOON_F_FREE_PAGE_HINT))=
 {
> >          return sizeof(struct virtio_balloon_config);
> >      }
> > -    if (virtio_has_feature(features, VIRTIO_BALLOON_F_FREE_PAGE_HINT))=
 {
> > -        return offsetof(struct virtio_balloon_config, poison_val);
> > -    }
>
> I am not sure this change is completely sane. Why is that necessary at al=
l?

The poison_val is stored at the end of the structure and is required
in order to make free page hinting to work. What this change is doing
is forcing it so that we report the config size as the full size if
either poisoning or hinting are enabled since the poison val is the
last member of the config structure.

If the question is why bother reducing the size if free page hinting
is not present then I guess we could simplify this and just report
report the size of the config for all cases.

> >      return offsetof(struct virtio_balloon_config, free_page_report_cmd=
_id);
> >  }
> >
> > @@ -634,6 +641,7 @@ static void virtio_balloon_get_config(VirtIODevice =
*vdev, uint8_t *config_data)
> >
> >      config.num_pages =3D cpu_to_le32(dev->num_pages);
> >      config.actual =3D cpu_to_le32(dev->actual);
> > +    config.poison_val =3D cpu_to_le32(dev->poison_val);
> >
> >      if (dev->free_page_report_status =3D=3D FREE_PAGE_REPORT_S_REQUEST=
ED) {
> >          config.free_page_report_cmd_id =3D
> > @@ -697,6 +705,9 @@ static void virtio_balloon_set_config(VirtIODevice =
*vdev,
> >          qapi_event_send_balloon_change(vm_ram_size -
> >                          ((ram_addr_t) dev->actual << VIRTIO_BALLOON_PF=
N_SHIFT));
> >      }
> > +    dev->poison_val =3D virtio_vdev_has_feature(vdev,
> > +                                              VIRTIO_BALLOON_F_PAGE_PO=
ISON) ?
> > +                      le32_to_cpu(config.poison_val) : 0;
>
> Can we just do a
>
>
> dev->poison_val =3D 0;
> if (virtio_vdev_has_feature(vdev, VIRTIO_BALLOON_F_PAGE_POISON)) {
>         dev->poison_val =3D le32_to_cpu(config.poison_val);
> }
>
> instead?

I can change it to that if that is what is preferred.

> >      trace_virtio_balloon_set_config(dev->actual, oldactual);
> >  }
> >
> > @@ -706,6 +717,9 @@ static uint64_t virtio_balloon_get_features(VirtIOD=
evice *vdev, uint64_t f,
> >      VirtIOBalloon *dev =3D VIRTIO_BALLOON(vdev);
> >      f |=3D dev->host_features;
> >      virtio_add_feature(&f, VIRTIO_BALLOON_F_STATS_VQ);
> > +    if (virtio_has_feature(f, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
> > +        virtio_add_feature(&f, VIRTIO_BALLOON_F_PAGE_POISON);
> > +    }
> >
> >      return f;
> >  }
> > @@ -854,6 +868,8 @@ static void virtio_balloon_device_reset(VirtIODevic=
e *vdev)
> >          g_free(s->stats_vq_elem);
> >          s->stats_vq_elem =3D NULL;
> >      }
> > +
> > +    s->poison_val =3D 0;
> >  }
> >
> >  static void virtio_balloon_set_status(VirtIODevice *vdev, uint8_t stat=
us)
> > @@ -916,6 +932,8 @@ static Property virtio_balloon_properties[] =3D {
> >                      VIRTIO_BALLOON_F_DEFLATE_ON_OOM, false),
> >      DEFINE_PROP_BIT("free-page-hint", VirtIOBalloon, host_features,
> >                      VIRTIO_BALLOON_F_FREE_PAGE_HINT, false),
> > +    DEFINE_PROP_BIT("x-page-poison", VirtIOBalloon, host_features,
> > +                    VIRTIO_BALLOON_F_PAGE_POISON, false),
>
> Just curious, why an x- feature?

It was something I didn't expect the users to enable. It gets enabled
when either free page hinting or free page reporting is enabled. So if
you look you will see that in virtio_balloon_get_features the page
poison feature is added if free page hinting is present. The guest
will clear the feature bit if poisoning is not enabled in the guest.
That results in the vdev getting the bit cleared.

Part of it was also about making this work with the existing feature
code as it had been added to the upstream kernel.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

