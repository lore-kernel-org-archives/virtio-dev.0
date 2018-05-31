Return-Path: virtio-dev-return-4212-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 670AF1CB807B
	for <virtio-dev@lists.oasis-open.org>; Wed, 30 May 2018 19:23:25 -0700 (PDT)
Message-ID: <5B0F5D74.603@intel.com>
Date: Thu, 31 May 2018 10:27:00 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1524550428-27173-1-git-send-email-wei.w.wang@intel.com> <1524550428-27173-5-git-send-email-wei.w.wang@intel.com> <20180529181221-mutt-send-email-mst@kernel.org> <5B0E6AE9.2030505@intel.com> <20180530154325-mutt-send-email-mst@kernel.org>
In-Reply-To: <20180530154325-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v7 4/5] virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, quintela@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com, zhang.zhanghailiang@huawei.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 05/30/2018 08:47 PM, Michael S. Tsirkin wrote:
> On Wed, May 30, 2018 at 05:12:09PM +0800, Wei Wang wrote:
>> On 05/29/2018 11:24 PM, Michael S. Tsirkin wrote:
>>> On Tue, Apr 24, 2018 at 02:13:47PM +0800, Wei Wang wrote:
>>>> +/*
>>>> + * Balloon will report pages which were free at the time of this call. As the
>>>> + * reporting happens asynchronously, dirty bit logging must be enabled before
>>>> + * this call is made.
>>>> + */
>>>> +void balloon_free_page_start(void)
>>>> +{
>>>> +    balloon_free_page_start_fn(balloon_opaque);
>>>> +}
>>> Please create notifier support, not a single global.
>> OK. The start is called at the end of bitmap_sync, and the stop is called at
>> the beginning of bitmap_sync. In this case, we will need to add two
>> migration states, MIGRATION_STATUS_BEFORE_BITMAP_SYNC and
>> MIGRATION_STATUS_AFTER_BITMAP_SYNC, right?
> If that's the way you do it, you need to ask migration guys, not me.

Yeah, I know.. thanks for the virtio part.

>>> +
>>> +static bool virtio_balloon_free_page_support(void *opaque)
>>> +{
>>> +    VirtIOBalloon *s = opaque;
>>> +    VirtIODevice *vdev = VIRTIO_DEVICE(s);
>>> +
>>> +    return virtio_vdev_has_feature(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT);
>>> or if poison is negotiated.
>> Will make it
>> return virtio_vdev_has_feature(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT) &&
>> !virtio_vdev_has_feature(vdev, VIRTIO_BALLOON_F_PAGE_POISON)
>
> I mean the reverse:
> 	virtio_vdev_has_feature(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT) ||
> 	virtio_vdev_has_feature(vdev, VIRTIO_BALLOON_F_PAGE_POISON)
>
>
> If poison has been negotiated you must migrate the
> guest supplied value even if you don't use it for hints.


Just a little confused with the logic. Writing it that way means that we 
are taking this possibility "virtio_vdev_has_feature(vdev, 
VIRTIO_BALLOON_F_FREE_PAGE_HINT)=fasle, virtio_vdev_has_feature(vdev, 
VIRTIO_BALLOON_F_PAGE_POISON)=true" into account, and let the support 
function return true when F_FREE_PAGE_HINT isn't supported.

If guest doesn't support F_FREE_PAGE_HINT, it doesn't support the free 
page reporting (even the free page vq). I'm not sure why we tell the 
migration thread that the free page reporting feature is supported via 
this support function. If the support function simply returns false when 
F_FREE_PAGE_HINT isn't negotiated, the legacy migration already migrates 
the poisoned pages (not skipped, but may be compressed).

I think it would be better to simply use the original "return 
virtio_vdev_has_feature(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT)" here.


Best,
Wei

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

