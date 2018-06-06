Return-Path: virtio-dev-return-4286-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id D2A865818F86
	for <virtio-dev@lists.oasis-open.org>; Wed,  6 Jun 2018 03:08:02 -0700 (PDT)
Message-ID: <5B17B366.5030802@intel.com>
Date: Wed, 06 Jun 2018 18:11:50 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1524550428-27173-1-git-send-email-wei.w.wang@intel.com> <1524550428-27173-5-git-send-email-wei.w.wang@intel.com> <20180606064315.GB7815@xz-mi>
In-Reply-To: <20180606064315.GB7815@xz-mi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [Qemu-devel] [PATCH v7 4/5] virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, quintela@redhat.com, dgilbert@redhat.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, liliang.opensource@gmail.com, pbonzini@redhat.com, nilal@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 06/06/2018 02:43 PM, Peter Xu wrote:
> On Tue, Apr 24, 2018 at 02:13:47PM +0800, Wei Wang wrote:
>
> [...]
>
> +        if (elem->out_num) {
> +            size = iov_to_buf(elem->out_sg, elem->out_num, 0, &id, sizeof(id));
> +            virtqueue_push(vq, elem, size);
> Silly question: is this sending the same id back to guest?  Why?

No. It's just giving back the used buffer.

>
>> +            g_free(elem);
>> +
>> +            virtio_tswap32s(vdev, &id);
>> +            if (unlikely(size != sizeof(id))) {
>> +                virtio_error(vdev, "received an incorrect cmd id");
> Forgot to unlock?
>
> Maybe we can just move the lock operations outside:
>
>    mutex_lock();
>    while (1) {
>      ...
>      if (block) {
>        qemu_cond_wait();
>      }
>      ...
>      if (skip) {
>        continue;
>      }
>      ...
>      if (error) {
>        break;
>      }
>      ...
>    }
>    mutex_unlock();


I got similar comments from Michael, and it will be
while (1) {
lock;
func();
unlock();
}

All the unlock inside the body will be gone.

> [...]
>> +static const VMStateDescription vmstate_virtio_balloon_free_page_report = {
>> +    .name = "virtio-balloon-device/free-page-report",
>> +    .version_id = 1,
>> +    .minimum_version_id = 1,
>> +    .needed = virtio_balloon_free_page_support,
>> +    .fields = (VMStateField[]) {
>> +        VMSTATE_UINT32(free_page_report_cmd_id, VirtIOBalloon),
>> +        VMSTATE_UINT32(poison_val, VirtIOBalloon),
> (could we move all the poison-related lines into another patch or
>   postpone?  after all we don't support it yet, do we?)
>

  We don't support migrating poison value, but guest maybe use it, so we 
are actually disabling this feature in that case. Probably good to leave 
the code together to handle that case.


>> +    if (virtio_has_feature(s->host_features,
>> +                           VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
>> +        s->free_page_vq = virtio_add_queue(vdev, VIRTQUEUE_MAX_SIZE, NULL);
>> +        s->free_page_report_status = FREE_PAGE_REPORT_S_STOP;
>> +        s->free_page_report_cmd_id =
>> +                           VIRTIO_BALLOON_FREE_PAGE_REPORT_CMD_ID_MIN - 1;
> Why explicitly -1?  I thought ID_MIN would be fine too?

Yes, that will also be fine. Since we states that the cmd id will be 
from [MIN, MAX], and we make s->free_page_report_cmd_id++ in start(), 
using VIRTIO_BALLOON_FREE_PAGE_REPORT_CMD_ID_MIN here will make it [MIN 
+ 1, MAX].

>
>> +        if (s->iothread) {
>> +            object_ref(OBJECT(s->iothread));
>> +            s->free_page_bh = aio_bh_new(iothread_get_aio_context(s->iothread),
>> +                                       virtio_balloon_poll_free_page_hints, s);
> Just to mention that now we can create internal iothreads.  Please
> have a look at iothread_create().

Thanks. I noticed that, but I think configuring via the cmd line can let 
people share the iothread with other devices that need it.

Best,
Wei

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

