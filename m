Return-Path: virtio-dev-return-3546-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 44E7F5818F9D
	for <virtio-dev@lists.oasis-open.org>; Tue, 13 Mar 2018 23:00:31 -0700 (PDT)
Message-ID: <5AA8BB27.6030205@intel.com>
Date: Wed, 14 Mar 2018 14:03:19 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1520426065-40265-1-git-send-email-wei.w.wang@intel.com> <1520426065-40265-4-git-send-email-wei.w.wang@intel.com> <20180313183558-mutt-send-email-mst@kernel.org> <5AA88C35.90300@intel.com> <20180314045130-mutt-send-email-mst@kernel.org>
In-Reply-To: <20180314045130-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio-dev] Re: [PATCH v4 3/4] virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, quintela@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 03/14/2018 10:53 AM, Michael S. Tsirkin wrote:
> On Wed, Mar 14, 2018 at 10:43:01AM +0800, Wei Wang wrote:
>> On 03/14/2018 12:49 AM, Michael S. Tsirkin wrote:
>>> On Wed, Mar 07, 2018 at 08:34:24PM +0800, Wei Wang wrote:
>>>
>>>> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
>>>> Signed-off-by: Liang Li <liang.z.li@intel.com>
>>>> CC: Michael S. Tsirkin <mst@redhat.com>
>>>> CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
>>>> CC: Juan Quintela <quintela@redhat.com>
>>> I find it suspicious that neither unrealize nor reset
>>> functions have been touched at all.
>>> Are you sure you have thought through scenarious like
>>> hot-unplug or disabling the device by guest?
>> OK. I think we can call balloon_free_page_stop in unrealize and reset.
>>
>>
>>> +static void *virtio_balloon_poll_free_page_hints(void *opaque)
>>> +{
>>> +    VirtQueueElement *elem;
>>> +    VirtIOBalloon *dev = opaque;
>>> +    VirtQueue *vq = dev->free_page_vq;
>>> +    uint32_t id;
>>> +    size_t size;
>>> What makes it safe to poke at this device from multiple threads?
>>> I think that it would be safer to do it from e.g. BH.
>>>
>> Actually the free_page_optimization thread is the only user of free_page_vq,
>> and there is only one optimization thread each time. Would this be safe
>> enough?
>>
>> Best,
>> Wei
> Aren't there other fields there? Also things like reset affect all VQs.
>

Yes. But I think BHs are used to avoid re-entrancy, which isn't the 
issue here.

The potential issue I could observe here is that 
"dev->free_page_report_status" is read and written by the optimization 
thread, and it is also modified by the migration thread and reset via 
virtio_balloon_free_page_stop.

How about adding a QEMU SpinLock, like this:

virtio_balloon_poll_free_page_hints()
{

     while (1) {
         qemu_spin_lock();
         /* If the status has been changed to STOP or EXIT, or the VM is 
stopped, just exit */
         if (dev->free_page_report_status >= FREE_PAGE_REPORT_S_STOP || 
!runstate_is_running()) {
             qemu_spin_unlock();
             break;
         }
         ....
         qemu_spin_unlock();
     }
}


Best,
Wei

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

