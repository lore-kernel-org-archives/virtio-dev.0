Return-Path: virtio-dev-return-3425-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 79ABD5818F75
	for <virtio-dev@lists.oasis-open.org>; Mon,  5 Mar 2018 17:52:03 -0800 (PST)
Message-ID: <5A9DF4E9.3090706@intel.com>
Date: Tue, 06 Mar 2018 09:54:49 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1519980450-3404-1-git-send-email-wei.w.wang@intel.com> <1519980450-3404-3-git-send-email-wei.w.wang@intel.com> <20180302203557-mutt-send-email-mst@kernel.org> <5A9CBB2F.8010400@intel.com> <20180305155642-mutt-send-email-mst@kernel.org>
In-Reply-To: <20180305155642-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v3 2/3] virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, quintela@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 03/05/2018 10:09 PM, Michael S. Tsirkin wrote:
> On Mon, Mar 05, 2018 at 11:36:15AM +0800, Wei Wang wrote:
>> On 03/03/2018 02:37 AM, Michael S. Tsirkin wrote:
>>> On Fri, Mar 02, 2018 at 04:47:29PM +0800, Wei Wang wrote:
>>>> diff --git a/include/sysemu/balloon.h b/include/sysemu/balloon.h
>>>> index af49e19..16a2aae 100644
>>>> --- a/include/sysemu/balloon.h
>>>> +++ b/include/sysemu/balloon.h
>>> ...
>>>
>>>> +typedef void (QEMUBalloonFreePageStart)(void *opaque);
>>>> +typedef void (QEMUBalloonFreePageStop)(void *opaque);
>>> So I think the rule is that no bitmap sync must happen
>>> between these two, otherwise a hint might arrive and
>>> override the sync output.
>>>
>>> Should be documented I think.
>>>
>> Yes, agree.
> Ideally we'd also detect violations and trigger an assert.

How about just invoking

if (rs->free_page_support)
     balloon_free_page_stop();

at the beginning of migration_bitmap_sync()? (balloon_free_page_stop 
will just return if the optimization has stopped.)

In this way, we can always have the guarantee that "no bitmap sync must 
happen between these two"


>
>> How about adding the following new balloon API explanation to
>> this patch's commit:
>>
>>      - balloon_free_page_start: Callers call this API to obtain guest free
>>        page hints, and clear the related bits from the migration dirty
>> bitmap.
>>        The whole process is implemented in a new thread independent of the
>>        migration thread. Free page hints imply the part of guest memory is
>>        likely to be free without a guarantee. That is, the reported free
>> pages
>>        may not be free any more when QEMU receives them, so callers are
>>        responsible for detecting those pages that are not free pages after
>> the
>>        bits are cleared from the dirty bitmap. To ensure the above, this API
>>        should be used when the migration dirty logging mechanism (e.g.
>>        guest memory write-protection) has started.
>>
>>      - balloon_free_page_stop: Callers call this API to stop the guest from
>>        reporting free page hints. Bits from the dirty bitmap are safe to
>>        be cleared on condition that the dirty logging mechanism is recording
>>        pages that the guest has written to. To avoid the case that clearing
>>        bits of free page hints overrides the dirty bits offered by the dirty
>>        logging mechanism, this API is suggested to be called before QEMU
>>        synchronizes the dirty logging bitmap.
>>
>>      - balloon_free_page_support: This API is called to check whether the
>>        balloon device supports the guest free page reporting feature. The
>>        balloon_free_page_start and balloon_free_page_stop APIs should be used
>>        only when this API returns true.
>>
>>
>> Best,
>> Wei
> I find this more confusing than explaining.
>
> Let me try
>
> balloon_free_page_start - start guest free page hint reporting.
> Note: balloon will report pages which were free at the time
> of this call. As the reporting happens asynchronously,
> we rely on dirty logging to be started before this call is made.
>
> The dirty logging bitmap must be synchronized before this call
> and then after balloon_free_page_stop.

I think it would be better to remove the above one sentence.
I agree "No dirty bitmap synchronizations are allowed between 
balloon_free_page_start and balloon_free_page_stop", but "The dirty 
logging bitmap MUST be synchronized before balloon_free_page_start" 
seems confusing, for example the bulk stage doesn't have to start with a 
bitmap sync.


>
> balloon_free_page_stop: stop the guest reporting
> of free pages. dirty logging bitmap can be synchronized
> after this point.
>
> No bitmap synchronizations are allowed between these two points.
>

Best,
Wei

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

