Return-Path: virtio-dev-return-3825-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 450405818F54
	for <virtio-dev@lists.oasis-open.org>; Wed, 11 Apr 2018 17:24:45 -0700 (PDT)
References: <1521497654-24807-1-git-send-email-jonathan.helman@oracle.com>
 <db6371af-f93d-4409-c910-2ff712196c5b@redhat.com>
 <6ED6CAC9-FAD9-4A27-A9B1-C6EFC7627D68@oracle.com>
 <c09d3570-a8f9-7a84-5dd6-46d385da2e15@redhat.com>
 <20180322050842-mutt-send-email-mst@kernel.org>
 <3f8a1b91-c5ba-8a24-72b8-02d884a67826@redhat.com>
 <b1414be4-84bc-5d02-afff-9e42c1fd7210@oracle.com>
 <e773c5bb-52a5-4b7d-4ce6-0fc3b189475f@redhat.com>
From: Jonathan Helman <jonathan.helman@oracle.com>
Message-ID: <1d2bcb00-b210-b992-318e-c65607d31dff@oracle.com>
Date: Wed, 11 Apr 2018 17:24:27 -0700
MIME-Version: 1.0
In-Reply-To: <e773c5bb-52a5-4b7d-4ce6-0fc3b189475f@redhat.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [virtio-dev] Re: [PATCH v2] virtio_balloon: export hugetlb page
 allocation counts
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, virtio-dev@lists.oasis-open.org, Mihai Carabas <mihai.carabas@oracle.com>
List-ID: <virtio-dev.lists.oasis-open.org>



On 04/10/2018 08:12 PM, Jason Wang wrote:
> 
> 
> On 2018年04月10日 05:11, Jonathan Helman wrote:
>>
>>
>> On 03/22/2018 07:38 PM, Jason Wang wrote:
>>>
>>>
>>> On 2018年03月22日 11:10, Michael S. Tsirkin wrote:
>>>> On Thu, Mar 22, 2018 at 09:52:18AM +0800, Jason Wang wrote:
>>>>> On 2018年03月20日 12:26, Jonathan Helman wrote:
>>>>>>> On Mar 19, 2018, at 7:31 PM, Jason Wang<jasowang@redhat.com>  wrote:
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> On 2018年03月20日 06:14, Jonathan Helman wrote:
>>>>>>>> Export the number of successful and failed hugetlb page
>>>>>>>> allocations via the virtio balloon driver. These 2 counts
>>>>>>>> come directly from the vm_events HTLB_BUDDY_PGALLOC and
>>>>>>>> HTLB_BUDDY_PGALLOC_FAIL.
>>>>>>>>
>>>>>>>> Signed-off-by: Jonathan Helman<jonathan.helman@oracle.com>
>>>>>>> Reviewed-by: Jason Wang<jasowang@redhat.com>
>>>>>> Thanks.
>>>>>>
>>>>>>>> ---
>>>>>>>>    drivers/virtio/virtio_balloon.c     | 6 ++++++
>>>>>>>>    include/uapi/linux/virtio_balloon.h | 4 +++-
>>>>>>>>    2 files changed, 9 insertions(+), 1 deletion(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/virtio/virtio_balloon.c 
>>>>>>>> b/drivers/virtio/virtio_balloon.c
>>>>>>>> index dfe5684..6b237e3 100644
>>>>>>>> --- a/drivers/virtio/virtio_balloon.c
>>>>>>>> +++ b/drivers/virtio/virtio_balloon.c
>>>>>>>> @@ -272,6 +272,12 @@ static unsigned int 
>>>>>>>> update_balloon_stats(struct virtio_balloon *vb)
>>>>>>>>                    pages_to_bytes(events[PSWPOUT]));
>>>>>>>>        update_stat(vb, idx++, VIRTIO_BALLOON_S_MAJFLT, 
>>>>>>>> events[PGMAJFAULT]);
>>>>>>>>        update_stat(vb, idx++, VIRTIO_BALLOON_S_MINFLT, 
>>>>>>>> events[PGFAULT]);
>>>>>>>> +#ifdef CONFIG_HUGETLB_PAGE
>>>>>>>> +    update_stat(vb, idx++, VIRTIO_BALLOON_S_HTLB_PGALLOC,
>>>>>>>> +            events[HTLB_BUDDY_PGALLOC]);
>>>>>>>> +    update_stat(vb, idx++, VIRTIO_BALLOON_S_HTLB_PGFAIL,
>>>>>>>> +            events[HTLB_BUDDY_PGALLOC_FAIL]);
>>>>>>>> +#endif
>>>>>>>>    #endif
>>>>>>>>        update_stat(vb, idx++, VIRTIO_BALLOON_S_MEMFREE,
>>>>>>>>                    pages_to_bytes(i.freeram));
>>>>>>>> diff --git a/include/uapi/linux/virtio_balloon.h 
>>>>>>>> b/include/uapi/linux/virtio_balloon.h
>>>>>>>> index 4e8b830..40297a3 100644
>>>>>>>> --- a/include/uapi/linux/virtio_balloon.h
>>>>>>>> +++ b/include/uapi/linux/virtio_balloon.h
>>>>>>>> @@ -53,7 +53,9 @@ struct virtio_balloon_config {
>>>>>>>>    #define VIRTIO_BALLOON_S_MEMTOT   5   /* Total amount of 
>>>>>>>> memory */
>>>>>>>>    #define VIRTIO_BALLOON_S_AVAIL    6   /* Available memory as 
>>>>>>>> in /proc */
>>>>>>>>    #define VIRTIO_BALLOON_S_CACHES   7   /* Disk caches */
>>>>>>>> -#define VIRTIO_BALLOON_S_NR       8
>>>>>>>> +#define VIRTIO_BALLOON_S_HTLB_PGALLOC  8  /* Hugetlb page 
>>>>>>>> allocations */
>>>>>>>> +#define VIRTIO_BALLOON_S_HTLB_PGFAIL   9  /* Hugetlb page 
>>>>>>>> allocation failures */
>>>>>>>> +#define VIRTIO_BALLOON_S_NR       10
>>>>>>>>      /*
>>>>>>>>     * Memory statistics structure.
>>>>>>> Not for this patch, but it looks to me that exporting such nr 
>>>>>>> through uapi is fragile.
>>>>>> Sorry, can you explain what you mean here?
>>>>>>
>>>>>> Jon
>>>>> Spec said "Within an output buffer submitted to the statsq, the 
>>>>> device MUST
>>>>> ignore entries with tag values that it does not recognize". So 
>>>>> exporting
>>>>> VIRTIO_BALLOON_S_NR seems useless and device implementation can not 
>>>>> depend
>>>>> on such number in uapi.
>>>>>
>>>>> Thanks
>>>> Suggestions? I don't like to break build for people ...
>>>>
>>>
>>> Didn't have a good idea. But maybe we should keep VIRTIO_BALLOON_S_NR 
>>> unchanged, and add a comment here.
>>>
>>> Thanks
>>
>> I think Jason's comment is for a future patch. Didn't see this patch 
>> get applied, so wondering if it could be.
>>
>> Thanks,
>> Jon
> 
> Hi Jon:
> 
> Have you tested new driver with old qemu?

Yes, this testing scenario looks good. Thanks.

Jon

> 
> Thanks
> 
> 

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

