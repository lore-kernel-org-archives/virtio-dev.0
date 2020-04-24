Return-Path: virtio-dev-return-7161-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D96AD9860A0
	for <virtio-dev@lists.oasis-open.org>; Fri, 24 Apr 2020 15:12:00 +0000 (UTC)
References: <20200422181649.12258.37077.stgit@localhost.localdomain>
 <20200422182113.12258.56556.stgit@localhost.localdomain>
 <69bf1579-78db-2a2c-6ac0-169daaa50153@redhat.com>
 <CAKgT0UeZLJfZtLyDo8DcQF2KmwoNxPYnkSrx6C-j=LxU9t0ovw@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <799e5942-4deb-7f75-5347-bc7dbd8a838e@redhat.com>
Date: Fri, 24 Apr 2020 17:11:51 +0200
MIME-Version: 1.0
In-Reply-To: <CAKgT0UeZLJfZtLyDo8DcQF2KmwoNxPYnkSrx6C-j=LxU9t0ovw@mail.gmail.com>
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH v21 QEMU 3/5] virtio-balloon: Replace free page hinting
 references to 'report' with 'hint'
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On 24.04.20 16:56, Alexander Duyck wrote:
> On Fri, Apr 24, 2020 at 4:23 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 22.04.20 20:21, Alexander Duyck wrote:
>>> From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
>>>
>>> In an upcoming patch a feature named Free Page Reporting is about to be
>>> added. In order to avoid any confusion we should drop the use of the word
>>> 'report' when referring to Free Page Hinting. So what this patch does is go
>>> through and replace all instances of 'report' with 'hint" when we are
>>> referring to free page hinting.
>>>
>>> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
>>> ---
>>>  hw/virtio/virtio-balloon.c         |   74 ++++++++++++++++++------------------
>>>  include/hw/virtio/virtio-balloon.h |   20 +++++-----
>>>  2 files changed, 47 insertions(+), 47 deletions(-)
>>>
>>> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
>>> index a4729f7fc930..a1d6fb52c876 100644
>>> --- a/hw/virtio/virtio-balloon.c
>>> +++ b/hw/virtio/virtio-balloon.c
>>> @@ -466,21 +466,21 @@ static bool get_free_page_hints(VirtIOBalloon *dev)
>>>              ret = false;
>>>              goto out;
>>>          }
>>> -        if (id == dev->free_page_report_cmd_id) {
>>> -            dev->free_page_report_status = FREE_PAGE_REPORT_S_START;
>>> +        if (id == dev->free_page_hint_cmd_id) {
>>> +            dev->free_page_hint_status = FREE_PAGE_HINT_S_START;
>>>          } else {
>>>              /*
>>>               * Stop the optimization only when it has started. This
>>>               * avoids a stale stop sign for the previous command.
>>>               */
>>> -            if (dev->free_page_report_status == FREE_PAGE_REPORT_S_START) {
>>> -                dev->free_page_report_status = FREE_PAGE_REPORT_S_STOP;
>>> +            if (dev->free_page_hint_status == FREE_PAGE_HINT_S_START) {
>>> +                dev->free_page_hint_status = FREE_PAGE_HINT_S_STOP;
>>>              }
>>>          }
>>>      }
>>>
>>>      if (elem->in_num) {
>>> -        if (dev->free_page_report_status == FREE_PAGE_REPORT_S_START) {
>>> +        if (dev->free_page_hint_status == FREE_PAGE_HINT_S_START) {
>>>              qemu_guest_free_page_hint(elem->in_sg[0].iov_base,
>>>                                        elem->in_sg[0].iov_len);
>>>          }
>>> @@ -506,11 +506,11 @@ static void virtio_ballloon_get_free_page_hints(void *opaque)
>>>          qemu_mutex_unlock(&dev->free_page_lock);
>>>          virtio_notify(vdev, vq);
>>>        /*
>>> -       * Start to poll the vq once the reporting started. Otherwise, continue
>>> +       * Start to poll the vq once the hinting started. Otherwise, continue
>>>         * only when there are entries on the vq, which need to be given back.
>>>         */
>>>      } while (continue_to_get_hints ||
>>> -             dev->free_page_report_status == FREE_PAGE_REPORT_S_START);
>>> +             dev->free_page_hint_status == FREE_PAGE_HINT_S_START);
>>>      virtio_queue_set_notification(vq, 1);
>>>  }
>>>
>>> @@ -531,14 +531,14 @@ static void virtio_balloon_free_page_start(VirtIOBalloon *s)
>>>          return;
>>>      }
>>>
>>> -    if (s->free_page_report_cmd_id == UINT_MAX) {
>>> -        s->free_page_report_cmd_id =
>>> -                       VIRTIO_BALLOON_FREE_PAGE_REPORT_CMD_ID_MIN;
>>> +    if (s->free_page_hint_cmd_id == UINT_MAX) {
>>> +        s->free_page_hint_cmd_id =
>>> +                       VIRTIO_BALLOON_FREE_PAGE_HINT_CMD_ID_MIN;
>>>      } else {
>>> -        s->free_page_report_cmd_id++;
>>> +        s->free_page_hint_cmd_id++;
>>>      }
>>>
>>> -    s->free_page_report_status = FREE_PAGE_REPORT_S_REQUESTED;
>>> +    s->free_page_hint_status = FREE_PAGE_HINT_S_REQUESTED;
>>>      virtio_notify_config(vdev);
>>>  }
>>>
>>> @@ -546,18 +546,18 @@ static void virtio_balloon_free_page_stop(VirtIOBalloon *s)
>>>  {
>>>      VirtIODevice *vdev = VIRTIO_DEVICE(s);
>>>
>>> -    if (s->free_page_report_status != FREE_PAGE_REPORT_S_STOP) {
>>> +    if (s->free_page_hint_status != FREE_PAGE_HINT_S_STOP) {
>>>          /*
>>>           * The lock also guarantees us that the
>>>           * virtio_ballloon_get_free_page_hints exits after the
>>> -         * free_page_report_status is set to S_STOP.
>>> +         * free_page_hint_status is set to S_STOP.
>>>           */
>>>          qemu_mutex_lock(&s->free_page_lock);
>>>          /*
>>>           * The guest hasn't done the reporting, so host sends a notification
>>>           * to the guest to actively stop the reporting.
>>>           */
>>> -        s->free_page_report_status = FREE_PAGE_REPORT_S_STOP;
>>> +        s->free_page_hint_status = FREE_PAGE_HINT_S_STOP;
>>>          qemu_mutex_unlock(&s->free_page_lock);
>>>          virtio_notify_config(vdev);
>>>      }
>>> @@ -567,15 +567,15 @@ static void virtio_balloon_free_page_done(VirtIOBalloon *s)
>>>  {
>>>      VirtIODevice *vdev = VIRTIO_DEVICE(s);
>>>
>>> -    s->free_page_report_status = FREE_PAGE_REPORT_S_DONE;
>>> +    s->free_page_hint_status = FREE_PAGE_HINT_S_DONE;
>>>      virtio_notify_config(vdev);
>>>  }
>>>
>>>  static int
>>> -virtio_balloon_free_page_report_notify(NotifierWithReturn *n, void *data)
>>> +virtio_balloon_free_page_hint_notify(NotifierWithReturn *n, void *data)
>>>  {
>>>      VirtIOBalloon *dev = container_of(n, VirtIOBalloon,
>>> -                                      free_page_report_notify);
>>> +                                      free_page_hint_notify);
>>>      VirtIODevice *vdev = VIRTIO_DEVICE(dev);
>>>      PrecopyNotifyData *pnd = data;
>>>
>>> @@ -624,7 +624,7 @@ static size_t virtio_balloon_config_size(VirtIOBalloon *s)
>>>      if (virtio_has_feature(features, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
>>>          return offsetof(struct virtio_balloon_config, poison_val);
>>>      }
>>> -    return offsetof(struct virtio_balloon_config, free_page_report_cmd_id);
>>> +    return offsetof(struct virtio_balloon_config, free_page_hint_cmd_id);
>>>  }
>>>
>>>  static void virtio_balloon_get_config(VirtIODevice *vdev, uint8_t *config_data)
>>> @@ -635,14 +635,14 @@ static void virtio_balloon_get_config(VirtIODevice *vdev, uint8_t *config_data)
>>>      config.num_pages = cpu_to_le32(dev->num_pages);
>>>      config.actual = cpu_to_le32(dev->actual);
>>>
>>> -    if (dev->free_page_report_status == FREE_PAGE_REPORT_S_REQUESTED) {
>>> -        config.free_page_report_cmd_id =
>>> -                       cpu_to_le32(dev->free_page_report_cmd_id);
>>> -    } else if (dev->free_page_report_status == FREE_PAGE_REPORT_S_STOP) {
>>> -        config.free_page_report_cmd_id =
>>> +    if (dev->free_page_hint_status == FREE_PAGE_HINT_S_REQUESTED) {
>>> +        config.free_page_hint_cmd_id =
>>> +                       cpu_to_le32(dev->free_page_hint_cmd_id);
>>> +    } else if (dev->free_page_hint_status == FREE_PAGE_HINT_S_STOP) {
>>> +        config.free_page_hint_cmd_id =
>>>                         cpu_to_le32(VIRTIO_BALLOON_CMD_ID_STOP);
>>> -    } else if (dev->free_page_report_status == FREE_PAGE_REPORT_S_DONE) {
>>> -        config.free_page_report_cmd_id =
>>> +    } else if (dev->free_page_hint_status == FREE_PAGE_HINT_S_DONE) {
>>> +        config.free_page_hint_cmd_id =
>>>                         cpu_to_le32(VIRTIO_BALLOON_CMD_ID_DONE);
>>>      }
>>>
>>> @@ -743,14 +743,14 @@ static int virtio_balloon_post_load_device(void *opaque, int version_id)
>>>      return 0;
>>>  }
>>>
>>> -static const VMStateDescription vmstate_virtio_balloon_free_page_report = {
>>> +static const VMStateDescription vmstate_virtio_balloon_free_page_hint = {
>>>      .name = "virtio-balloon-device/free-page-report",
>>>      .version_id = 1,
>>>      .minimum_version_id = 1,
>>>      .needed = virtio_balloon_free_page_support,
>>>      .fields = (VMStateField[]) {
>>> -        VMSTATE_UINT32(free_page_report_cmd_id, VirtIOBalloon),
>>> -        VMSTATE_UINT32(free_page_report_status, VirtIOBalloon),
>>> +        VMSTATE_UINT32(free_page_hint_cmd_id, VirtIOBalloon),
>>> +        VMSTATE_UINT32(free_page_hint_status, VirtIOBalloon),
>>>          VMSTATE_END_OF_LIST()
>>>      }
>>>  };
>>> @@ -766,7 +766,7 @@ static const VMStateDescription vmstate_virtio_balloon_device = {
>>>          VMSTATE_END_OF_LIST()
>>>      },
>>>      .subsections = (const VMStateDescription * []) {
>>> -        &vmstate_virtio_balloon_free_page_report,
>>> +        &vmstate_virtio_balloon_free_page_hint,
>>>          NULL
>>>      }
>>>  };
>>> @@ -797,12 +797,12 @@ static void virtio_balloon_device_realize(DeviceState *dev, Error **errp)
>>>                             VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
>>>          s->free_page_vq = virtio_add_queue(vdev, VIRTQUEUE_MAX_SIZE,
>>>                                             virtio_balloon_handle_free_page_vq);
>>> -        s->free_page_report_status = FREE_PAGE_REPORT_S_STOP;
>>> -        s->free_page_report_cmd_id =
>>> -                           VIRTIO_BALLOON_FREE_PAGE_REPORT_CMD_ID_MIN;
>>> -        s->free_page_report_notify.notify =
>>> -                                       virtio_balloon_free_page_report_notify;
>>> -        precopy_add_notifier(&s->free_page_report_notify);
>>> +        s->free_page_hint_status = FREE_PAGE_HINT_S_STOP;
>>> +        s->free_page_hint_cmd_id =
>>> +                           VIRTIO_BALLOON_FREE_PAGE_HINT_CMD_ID_MIN;
>>> +        s->free_page_hint_notify.notify =
>>> +                                       virtio_balloon_free_page_hint_notify;
>>> +        precopy_add_notifier(&s->free_page_hint_notify);
>>>          if (s->iothread) {
>>>              object_ref(OBJECT(s->iothread));
>>>              s->free_page_bh = aio_bh_new(iothread_get_aio_context(s->iothread),
>>> @@ -827,7 +827,7 @@ static void virtio_balloon_device_unrealize(DeviceState *dev, Error **errp)
>>>      if (virtio_balloon_free_page_support(s)) {
>>>          qemu_bh_delete(s->free_page_bh);
>>>          virtio_balloon_free_page_stop(s);
>>> -        precopy_remove_notifier(&s->free_page_report_notify);
>>> +        precopy_remove_notifier(&s->free_page_hint_notify);
>>>      }
>>>      balloon_stats_destroy_timer(s);
>>>      qemu_remove_balloon_handler(s);
>>> diff --git a/include/hw/virtio/virtio-balloon.h b/include/hw/virtio/virtio-balloon.h
>>> index d1c968d2376e..108cff97e71a 100644
>>> --- a/include/hw/virtio/virtio-balloon.h
>>> +++ b/include/hw/virtio/virtio-balloon.h
>>> @@ -23,7 +23,7 @@
>>>  #define VIRTIO_BALLOON(obj) \
>>>          OBJECT_CHECK(VirtIOBalloon, (obj), TYPE_VIRTIO_BALLOON)
>>>
>>> -#define VIRTIO_BALLOON_FREE_PAGE_REPORT_CMD_ID_MIN 0x80000000
>>> +#define VIRTIO_BALLOON_FREE_PAGE_HINT_CMD_ID_MIN 0x80000000
>>>
>>>  typedef struct virtio_balloon_stat VirtIOBalloonStat;
>>>
>>> @@ -33,20 +33,20 @@ typedef struct virtio_balloon_stat_modern {
>>>         uint64_t val;
>>>  } VirtIOBalloonStatModern;
>>>
>>> -enum virtio_balloon_free_page_report_status {
>>> -    FREE_PAGE_REPORT_S_STOP = 0,
>>> -    FREE_PAGE_REPORT_S_REQUESTED = 1,
>>> -    FREE_PAGE_REPORT_S_START = 2,
>>> -    FREE_PAGE_REPORT_S_DONE = 3,
>>> +enum virtio_balloon_free_page_hint_status {
>>> +    FREE_PAGE_HINT_S_STOP = 0,
>>> +    FREE_PAGE_HINT_S_REQUESTED = 1,
>>> +    FREE_PAGE_HINT_S_START = 2,
>>> +    FREE_PAGE_HINT_S_DONE = 3,
>>>  };
>>>
>>>  typedef struct VirtIOBalloon {
>>>      VirtIODevice parent_obj;
>>>      VirtQueue *ivq, *dvq, *svq, *free_page_vq;
>>> -    uint32_t free_page_report_status;
>>> +    uint32_t free_page_hint_status;
>>>      uint32_t num_pages;
>>>      uint32_t actual;
>>> -    uint32_t free_page_report_cmd_id;
>>> +    uint32_t free_page_hint_cmd_id;
>>>      uint64_t stats[VIRTIO_BALLOON_S_NR];
>>>      VirtQueueElement *stats_vq_elem;
>>>      size_t stats_vq_offset;
>>> @@ -55,7 +55,7 @@ typedef struct VirtIOBalloon {
>>>      QEMUBH *free_page_bh;
>>>      /*
>>>       * Lock to synchronize threads to access the free page reporting related
>>> -     * fields (e.g. free_page_report_status).
>>> +     * fields (e.g. free_page_hint_status).
>>>       */
>>>      QemuMutex free_page_lock;
>>>      QemuCond  free_page_cond;
>>> @@ -64,7 +64,7 @@ typedef struct VirtIOBalloon {
>>>       * stopped.
>>>       */
>>>      bool block_iothread;
>>> -    NotifierWithReturn free_page_report_notify;
>>> +    NotifierWithReturn free_page_hint_notify;
>>>      int64_t stats_last_update;
>>>      int64_t stats_poll_interval;
>>>      uint32_t host_features;
>>>
>>
>> Maybe split out the change to "free_page_report_cmd_id" in the uapi
>> (meaning: move that to a separate patch). So you can move forward with
>> most of this series (moving patch #1 and the free_page_report_cmd_id
>> change to the very last of this series) without depending on that change
>> to go upstream.
> 
> Okay. I can split it if that is needed. Any specific reason for
> splitting it I should cite in the patch? From what I can tell Michael
> has already accepted the renamed and pushed it to Linus.

Oh, I missed that - forget what I said. I thought this would still be
stuck in -next.

Acked-by: David Hildenbrand <david@redhat.com>

Thanks!

-- 
Thanks,

David / dhildenb


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

