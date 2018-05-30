Return-Path: virtio-dev-return-4200-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 561871CB8078
	for <virtio-dev@lists.oasis-open.org>; Wed, 30 May 2018 02:08:36 -0700 (PDT)
Message-ID: <5B0E6AE9.2030505@intel.com>
Date: Wed, 30 May 2018 17:12:09 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1524550428-27173-1-git-send-email-wei.w.wang@intel.com> <1524550428-27173-5-git-send-email-wei.w.wang@intel.com> <20180529181221-mutt-send-email-mst@kernel.org>
In-Reply-To: <20180529181221-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v7 4/5] virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, quintela@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com, zhang.zhanghailiang@huawei.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 05/29/2018 11:24 PM, Michael S. Tsirkin wrote:
> On Tue, Apr 24, 2018 at 02:13:47PM +0800, Wei Wang wrote:
>> +/*
>> + * Balloon will report pages which were free at the time of this call. As the
>> + * reporting happens asynchronously, dirty bit logging must be enabled before
>> + * this call is made.
>> + */
>> +void balloon_free_page_start(void)
>> +{
>> +    balloon_free_page_start_fn(balloon_opaque);
>> +}
> Please create notifier support, not a single global.

OK. The start is called at the end of bitmap_sync, and the stop is 
called at the beginning of bitmap_sync. In this case, we will need to 
add two migration states, MIGRATION_STATUS_BEFORE_BITMAP_SYNC and 
MIGRATION_STATUS_AFTER_BITMAP_SYNC, right?


>
> +static void virtio_balloon_poll_free_page_hints(void *opaque)
> +{
> +    VirtQueueElement *elem;
> +    VirtIOBalloon *dev = opaque;
> +    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
> +    VirtQueue *vq = dev->free_page_vq;
> +    uint32_t id;
> +    size_t size;
> +
> +    while (1) {
> +        qemu_mutex_lock(&dev->free_page_lock);
> +        while (dev->block_iothread) {
> +            qemu_cond_wait(&dev->free_page_cond, &dev->free_page_lock);
> +        }
> +
> +        /*
> +         * If the migration thread actively stops the reporting, exit
> +         * immediately.
> +         */
> +        if (dev->free_page_report_status == FREE_PAGE_REPORT_S_STOP) {
> Please refactor this : move loop body into a function so
> you can do lock/unlock in a single place.

Sounds good.

>
> +
> +static bool virtio_balloon_free_page_support(void *opaque)
> +{
> +    VirtIOBalloon *s = opaque;
> +    VirtIODevice *vdev = VIRTIO_DEVICE(s);
> +
> +    return virtio_vdev_has_feature(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT);
> or if poison is negotiated.

Will make it
return virtio_vdev_has_feature(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT) && 
!virtio_vdev_has_feature(vdev, VIRTIO_BALLOON_F_PAGE_POISON)


Best,
Wei

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

