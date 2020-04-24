Return-Path: virtio-dev-return-7160-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 173559860A0
	for <virtio-dev@lists.oasis-open.org>; Fri, 24 Apr 2020 14:56:52 +0000 (UTC)
MIME-Version: 1.0
References: <20200422181649.12258.37077.stgit@localhost.localdomain>
 <20200422182113.12258.56556.stgit@localhost.localdomain> <69bf1579-78db-2a2c-6ac0-169daaa50153@redhat.com>
In-Reply-To: <69bf1579-78db-2a2c-6ac0-169daaa50153@redhat.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 24 Apr 2020 07:56:38 -0700
Message-ID: <CAKgT0UeZLJfZtLyDo8DcQF2KmwoNxPYnkSrx6C-j=LxU9t0ovw@mail.gmail.com>
Subject: [virtio-dev] Re: [PATCH v21 QEMU 3/5] virtio-balloon: Replace free page hinting
 references to 'report' with 'hint'
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: David Hildenbrand <david@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Apr 24, 2020 at 4:23 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 22.04.20 20:21, Alexander Duyck wrote:
> > From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> >
> > In an upcoming patch a feature named Free Page Reporting is about to be
> > added. In order to avoid any confusion we should drop the use of the wo=
rd
> > 'report' when referring to Free Page Hinting. So what this patch does i=
s go
> > through and replace all instances of 'report' with 'hint" when we are
> > referring to free page hinting.
> >
> > Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> > ---
> >  hw/virtio/virtio-balloon.c         |   74 ++++++++++++++++++----------=
--------
> >  include/hw/virtio/virtio-balloon.h |   20 +++++-----
> >  2 files changed, 47 insertions(+), 47 deletions(-)
> >
> > diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> > index a4729f7fc930..a1d6fb52c876 100644
> > --- a/hw/virtio/virtio-balloon.c
> > +++ b/hw/virtio/virtio-balloon.c
> > @@ -466,21 +466,21 @@ static bool get_free_page_hints(VirtIOBalloon *de=
v)
> >              ret =3D false;
> >              goto out;
> >          }
> > -        if (id =3D=3D dev->free_page_report_cmd_id) {
> > -            dev->free_page_report_status =3D FREE_PAGE_REPORT_S_START;
> > +        if (id =3D=3D dev->free_page_hint_cmd_id) {
> > +            dev->free_page_hint_status =3D FREE_PAGE_HINT_S_START;
> >          } else {
> >              /*
> >               * Stop the optimization only when it has started. This
> >               * avoids a stale stop sign for the previous command.
> >               */
> > -            if (dev->free_page_report_status =3D=3D FREE_PAGE_REPORT_S=
_START) {
> > -                dev->free_page_report_status =3D FREE_PAGE_REPORT_S_ST=
OP;
> > +            if (dev->free_page_hint_status =3D=3D FREE_PAGE_HINT_S_STA=
RT) {
> > +                dev->free_page_hint_status =3D FREE_PAGE_HINT_S_STOP;
> >              }
> >          }
> >      }
> >
> >      if (elem->in_num) {
> > -        if (dev->free_page_report_status =3D=3D FREE_PAGE_REPORT_S_STA=
RT) {
> > +        if (dev->free_page_hint_status =3D=3D FREE_PAGE_HINT_S_START) =
{
> >              qemu_guest_free_page_hint(elem->in_sg[0].iov_base,
> >                                        elem->in_sg[0].iov_len);
> >          }
> > @@ -506,11 +506,11 @@ static void virtio_ballloon_get_free_page_hints(v=
oid *opaque)
> >          qemu_mutex_unlock(&dev->free_page_lock);
> >          virtio_notify(vdev, vq);
> >        /*
> > -       * Start to poll the vq once the reporting started. Otherwise, c=
ontinue
> > +       * Start to poll the vq once the hinting started. Otherwise, con=
tinue
> >         * only when there are entries on the vq, which need to be given=
 back.
> >         */
> >      } while (continue_to_get_hints ||
> > -             dev->free_page_report_status =3D=3D FREE_PAGE_REPORT_S_ST=
ART);
> > +             dev->free_page_hint_status =3D=3D FREE_PAGE_HINT_S_START)=
;
> >      virtio_queue_set_notification(vq, 1);
> >  }
> >
> > @@ -531,14 +531,14 @@ static void virtio_balloon_free_page_start(VirtIO=
Balloon *s)
> >          return;
> >      }
> >
> > -    if (s->free_page_report_cmd_id =3D=3D UINT_MAX) {
> > -        s->free_page_report_cmd_id =3D
> > -                       VIRTIO_BALLOON_FREE_PAGE_REPORT_CMD_ID_MIN;
> > +    if (s->free_page_hint_cmd_id =3D=3D UINT_MAX) {
> > +        s->free_page_hint_cmd_id =3D
> > +                       VIRTIO_BALLOON_FREE_PAGE_HINT_CMD_ID_MIN;
> >      } else {
> > -        s->free_page_report_cmd_id++;
> > +        s->free_page_hint_cmd_id++;
> >      }
> >
> > -    s->free_page_report_status =3D FREE_PAGE_REPORT_S_REQUESTED;
> > +    s->free_page_hint_status =3D FREE_PAGE_HINT_S_REQUESTED;
> >      virtio_notify_config(vdev);
> >  }
> >
> > @@ -546,18 +546,18 @@ static void virtio_balloon_free_page_stop(VirtIOB=
alloon *s)
> >  {
> >      VirtIODevice *vdev =3D VIRTIO_DEVICE(s);
> >
> > -    if (s->free_page_report_status !=3D FREE_PAGE_REPORT_S_STOP) {
> > +    if (s->free_page_hint_status !=3D FREE_PAGE_HINT_S_STOP) {
> >          /*
> >           * The lock also guarantees us that the
> >           * virtio_ballloon_get_free_page_hints exits after the
> > -         * free_page_report_status is set to S_STOP.
> > +         * free_page_hint_status is set to S_STOP.
> >           */
> >          qemu_mutex_lock(&s->free_page_lock);
> >          /*
> >           * The guest hasn't done the reporting, so host sends a notifi=
cation
> >           * to the guest to actively stop the reporting.
> >           */
> > -        s->free_page_report_status =3D FREE_PAGE_REPORT_S_STOP;
> > +        s->free_page_hint_status =3D FREE_PAGE_HINT_S_STOP;
> >          qemu_mutex_unlock(&s->free_page_lock);
> >          virtio_notify_config(vdev);
> >      }
> > @@ -567,15 +567,15 @@ static void virtio_balloon_free_page_done(VirtIOB=
alloon *s)
> >  {
> >      VirtIODevice *vdev =3D VIRTIO_DEVICE(s);
> >
> > -    s->free_page_report_status =3D FREE_PAGE_REPORT_S_DONE;
> > +    s->free_page_hint_status =3D FREE_PAGE_HINT_S_DONE;
> >      virtio_notify_config(vdev);
> >  }
> >
> >  static int
> > -virtio_balloon_free_page_report_notify(NotifierWithReturn *n, void *da=
ta)
> > +virtio_balloon_free_page_hint_notify(NotifierWithReturn *n, void *data=
)
> >  {
> >      VirtIOBalloon *dev =3D container_of(n, VirtIOBalloon,
> > -                                      free_page_report_notify);
> > +                                      free_page_hint_notify);
> >      VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
> >      PrecopyNotifyData *pnd =3D data;
> >
> > @@ -624,7 +624,7 @@ static size_t virtio_balloon_config_size(VirtIOBall=
oon *s)
> >      if (virtio_has_feature(features, VIRTIO_BALLOON_F_FREE_PAGE_HINT))=
 {
> >          return offsetof(struct virtio_balloon_config, poison_val);
> >      }
> > -    return offsetof(struct virtio_balloon_config, free_page_report_cmd=
_id);
> > +    return offsetof(struct virtio_balloon_config, free_page_hint_cmd_i=
d);
> >  }
> >
> >  static void virtio_balloon_get_config(VirtIODevice *vdev, uint8_t *con=
fig_data)
> > @@ -635,14 +635,14 @@ static void virtio_balloon_get_config(VirtIODevic=
e *vdev, uint8_t *config_data)
> >      config.num_pages =3D cpu_to_le32(dev->num_pages);
> >      config.actual =3D cpu_to_le32(dev->actual);
> >
> > -    if (dev->free_page_report_status =3D=3D FREE_PAGE_REPORT_S_REQUEST=
ED) {
> > -        config.free_page_report_cmd_id =3D
> > -                       cpu_to_le32(dev->free_page_report_cmd_id);
> > -    } else if (dev->free_page_report_status =3D=3D FREE_PAGE_REPORT_S_=
STOP) {
> > -        config.free_page_report_cmd_id =3D
> > +    if (dev->free_page_hint_status =3D=3D FREE_PAGE_HINT_S_REQUESTED) =
{
> > +        config.free_page_hint_cmd_id =3D
> > +                       cpu_to_le32(dev->free_page_hint_cmd_id);
> > +    } else if (dev->free_page_hint_status =3D=3D FREE_PAGE_HINT_S_STOP=
) {
> > +        config.free_page_hint_cmd_id =3D
> >                         cpu_to_le32(VIRTIO_BALLOON_CMD_ID_STOP);
> > -    } else if (dev->free_page_report_status =3D=3D FREE_PAGE_REPORT_S_=
DONE) {
> > -        config.free_page_report_cmd_id =3D
> > +    } else if (dev->free_page_hint_status =3D=3D FREE_PAGE_HINT_S_DONE=
) {
> > +        config.free_page_hint_cmd_id =3D
> >                         cpu_to_le32(VIRTIO_BALLOON_CMD_ID_DONE);
> >      }
> >
> > @@ -743,14 +743,14 @@ static int virtio_balloon_post_load_device(void *=
opaque, int version_id)
> >      return 0;
> >  }
> >
> > -static const VMStateDescription vmstate_virtio_balloon_free_page_repor=
t =3D {
> > +static const VMStateDescription vmstate_virtio_balloon_free_page_hint =
=3D {
> >      .name =3D "virtio-balloon-device/free-page-report",
> >      .version_id =3D 1,
> >      .minimum_version_id =3D 1,
> >      .needed =3D virtio_balloon_free_page_support,
> >      .fields =3D (VMStateField[]) {
> > -        VMSTATE_UINT32(free_page_report_cmd_id, VirtIOBalloon),
> > -        VMSTATE_UINT32(free_page_report_status, VirtIOBalloon),
> > +        VMSTATE_UINT32(free_page_hint_cmd_id, VirtIOBalloon),
> > +        VMSTATE_UINT32(free_page_hint_status, VirtIOBalloon),
> >          VMSTATE_END_OF_LIST()
> >      }
> >  };
> > @@ -766,7 +766,7 @@ static const VMStateDescription vmstate_virtio_ball=
oon_device =3D {
> >          VMSTATE_END_OF_LIST()
> >      },
> >      .subsections =3D (const VMStateDescription * []) {
> > -        &vmstate_virtio_balloon_free_page_report,
> > +        &vmstate_virtio_balloon_free_page_hint,
> >          NULL
> >      }
> >  };
> > @@ -797,12 +797,12 @@ static void virtio_balloon_device_realize(DeviceS=
tate *dev, Error **errp)
> >                             VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
> >          s->free_page_vq =3D virtio_add_queue(vdev, VIRTQUEUE_MAX_SIZE,
> >                                             virtio_balloon_handle_free_=
page_vq);
> > -        s->free_page_report_status =3D FREE_PAGE_REPORT_S_STOP;
> > -        s->free_page_report_cmd_id =3D
> > -                           VIRTIO_BALLOON_FREE_PAGE_REPORT_CMD_ID_MIN;
> > -        s->free_page_report_notify.notify =3D
> > -                                       virtio_balloon_free_page_report=
_notify;
> > -        precopy_add_notifier(&s->free_page_report_notify);
> > +        s->free_page_hint_status =3D FREE_PAGE_HINT_S_STOP;
> > +        s->free_page_hint_cmd_id =3D
> > +                           VIRTIO_BALLOON_FREE_PAGE_HINT_CMD_ID_MIN;
> > +        s->free_page_hint_notify.notify =3D
> > +                                       virtio_balloon_free_page_hint_n=
otify;
> > +        precopy_add_notifier(&s->free_page_hint_notify);
> >          if (s->iothread) {
> >              object_ref(OBJECT(s->iothread));
> >              s->free_page_bh =3D aio_bh_new(iothread_get_aio_context(s-=
>iothread),
> > @@ -827,7 +827,7 @@ static void virtio_balloon_device_unrealize(DeviceS=
tate *dev, Error **errp)
> >      if (virtio_balloon_free_page_support(s)) {
> >          qemu_bh_delete(s->free_page_bh);
> >          virtio_balloon_free_page_stop(s);
> > -        precopy_remove_notifier(&s->free_page_report_notify);
> > +        precopy_remove_notifier(&s->free_page_hint_notify);
> >      }
> >      balloon_stats_destroy_timer(s);
> >      qemu_remove_balloon_handler(s);
> > diff --git a/include/hw/virtio/virtio-balloon.h b/include/hw/virtio/vir=
tio-balloon.h
> > index d1c968d2376e..108cff97e71a 100644
> > --- a/include/hw/virtio/virtio-balloon.h
> > +++ b/include/hw/virtio/virtio-balloon.h
> > @@ -23,7 +23,7 @@
> >  #define VIRTIO_BALLOON(obj) \
> >          OBJECT_CHECK(VirtIOBalloon, (obj), TYPE_VIRTIO_BALLOON)
> >
> > -#define VIRTIO_BALLOON_FREE_PAGE_REPORT_CMD_ID_MIN 0x80000000
> > +#define VIRTIO_BALLOON_FREE_PAGE_HINT_CMD_ID_MIN 0x80000000
> >
> >  typedef struct virtio_balloon_stat VirtIOBalloonStat;
> >
> > @@ -33,20 +33,20 @@ typedef struct virtio_balloon_stat_modern {
> >         uint64_t val;
> >  } VirtIOBalloonStatModern;
> >
> > -enum virtio_balloon_free_page_report_status {
> > -    FREE_PAGE_REPORT_S_STOP =3D 0,
> > -    FREE_PAGE_REPORT_S_REQUESTED =3D 1,
> > -    FREE_PAGE_REPORT_S_START =3D 2,
> > -    FREE_PAGE_REPORT_S_DONE =3D 3,
> > +enum virtio_balloon_free_page_hint_status {
> > +    FREE_PAGE_HINT_S_STOP =3D 0,
> > +    FREE_PAGE_HINT_S_REQUESTED =3D 1,
> > +    FREE_PAGE_HINT_S_START =3D 2,
> > +    FREE_PAGE_HINT_S_DONE =3D 3,
> >  };
> >
> >  typedef struct VirtIOBalloon {
> >      VirtIODevice parent_obj;
> >      VirtQueue *ivq, *dvq, *svq, *free_page_vq;
> > -    uint32_t free_page_report_status;
> > +    uint32_t free_page_hint_status;
> >      uint32_t num_pages;
> >      uint32_t actual;
> > -    uint32_t free_page_report_cmd_id;
> > +    uint32_t free_page_hint_cmd_id;
> >      uint64_t stats[VIRTIO_BALLOON_S_NR];
> >      VirtQueueElement *stats_vq_elem;
> >      size_t stats_vq_offset;
> > @@ -55,7 +55,7 @@ typedef struct VirtIOBalloon {
> >      QEMUBH *free_page_bh;
> >      /*
> >       * Lock to synchronize threads to access the free page reporting r=
elated
> > -     * fields (e.g. free_page_report_status).
> > +     * fields (e.g. free_page_hint_status).
> >       */
> >      QemuMutex free_page_lock;
> >      QemuCond  free_page_cond;
> > @@ -64,7 +64,7 @@ typedef struct VirtIOBalloon {
> >       * stopped.
> >       */
> >      bool block_iothread;
> > -    NotifierWithReturn free_page_report_notify;
> > +    NotifierWithReturn free_page_hint_notify;
> >      int64_t stats_last_update;
> >      int64_t stats_poll_interval;
> >      uint32_t host_features;
> >
>
> Maybe split out the change to "free_page_report_cmd_id" in the uapi
> (meaning: move that to a separate patch). So you can move forward with
> most of this series (moving patch #1 and the free_page_report_cmd_id
> change to the very last of this series) without depending on that change
> to go upstream.

Okay. I can split it if that is needed. Any specific reason for
splitting it I should cite in the patch? From what I can tell Michael
has already accepted the renamed and pushed it to Linus.

Thanks.

- Alex

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

