Return-Path: virtio-dev-return-3180-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 9671058191A2
	for <virtio-dev@lists.oasis-open.org>; Wed,  7 Feb 2018 21:35:49 -0800 (PST)
Message-ID: <5A7BE253.8050306@intel.com>
Date: Thu, 08 Feb 2018 13:38:27 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1517915299-15349-1-git-send-email-wei.w.wang@intel.com> <20180207015803-mutt-send-email-mst@kernel.org>
In-Reply-To: <20180207015803-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v2 0/3] virtio-balloon: free page hint reporting support
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, quintela@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 02/07/2018 08:02 AM, Michael S. Tsirkin wrote:
> On Tue, Feb 06, 2018 at 07:08:16PM +0800, Wei Wang wrote:
>> This is the deivce part implementation to add a new feature,
>> VIRTIO_BALLOON_F_FREE_PAGE_HINT to the virtio-balloon device. The device
>> receives the guest free page hints from the driver and clears the
>> corresponding bits in the dirty bitmap, so that those free pages are
>> not transferred by the migration thread to the destination.
>>
>> Please see the driver patch link for test results:
>> https://lkml.org/lkml/2018/2/4/60
>>
>> ChangeLog:
>> v1->v2:
>>      1) virtio-balloon
>>          - use subsections to save free_page_report_cmd_id;
>>          - poll the free page vq after sending a cmd id to the driver;
>>          - change the free page vq size to VIRTQUEUE_MAX_SIZE;
>>          - virtio_balloon_poll_free_page_hints: handle the corner case
>>            that the free page block reported from the driver may cross
>>            the RAMBlock boundary.
>>      2) migration/ram.c
>>          - use balloon_free_page_poll to start the optimization
>>
>> Wei Wang (3):
>>    virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT
>>    migration: use the free page reporting feature from balloon
>>    virtio-balloon: add a timer to limit the free page report waiting time
> This feature needs in-tree documentation about possible ways to use it,
> tradeoffs involved etc.

OK. I plan to add the documentation in later versions after we mostly 
finalize the QEMU part design.

Best,
Wei

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

