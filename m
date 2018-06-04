Return-Path: virtio-dev-return-4264-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 7546B581916C
	for <virtio-dev@lists.oasis-open.org>; Mon,  4 Jun 2018 01:01:14 -0700 (PDT)
Message-ID: <5B14F2A3.9010805@intel.com>
Date: Mon, 04 Jun 2018 16:04:51 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1524550428-27173-1-git-send-email-wei.w.wang@intel.com> <1524550428-27173-5-git-send-email-wei.w.wang@intel.com> <20180529181221-mutt-send-email-mst@kernel.org> <5B0E6AE9.2030505@intel.com> <20180530154325-mutt-send-email-mst@kernel.org>
In-Reply-To: <20180530154325-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v7 4/5] virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, quintela@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com, zhang.zhanghailiang@huawei.com, Peter Xu <peterx@redhat.com>
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

Peter, do you have any thought about this?

Currently, the usage of free page optimization isn't limited to the 
first stage. It is used in each stage. A global call to start the free 
page optimization is made after bitmap sync, and another global call to 
stop the optimization is made before bitmap sync. It is simple to just 
use global calls.

If we change the implementation to use notifiers, I think we will need 
to add two new MigrationStatus as above. Would you think that is 
worthwhile for some reason?

Best,
Wei




---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

