Return-Path: <virtio-dev-return-14038-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C1A6C4167D
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Nov 2023 13:42:39 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 66AF42AC6C
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Nov 2023 13:42:38 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 449B1986C0C
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Nov 2023 13:42:38 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 28312986C02; Thu,  2 Nov 2023 13:42:38 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1217D986C01;
	Thu,  2 Nov 2023 13:42:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-IronPort-AV: E=Sophos;i="6.03,271,1694736000"; 
   d="scan'208";a="163836221"
X-Farcaster-Flow-ID: bcd7ff1a-49db-4283-9a13-7644a2a9afd3
Message-ID: <54a8f8ea-d876-48f7-a39f-ee2daeddee19@amazon.es>
Date: Thu, 2 Nov 2023 14:42:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: <virtio-comment@lists.oasis-open.org>, <virtio-dev@lists.oasis-open.org>,
	"Cali, Marco" <xmarcalx@amazon.co.uk>, "Graf (AWS), Alexander"
	<graf@amazon.de>, "Jason A. Donenfeld" <Jason@zx2c4.com>, <aams@amazon.de>
References: <20230919055811-mutt-send-email-mst@kernel.org>
 <4c6d6710-43c8-402b-9ae6-d2f4cafbe9a7@amazon.es>
 <20230922110329-mutt-send-email-mst@kernel.org>
 <c0c5b159-997f-4ddf-ab3e-1c749ad93e10@amazon.es>
 <20230922115920-mutt-send-email-mst@kernel.org>
 <19967fde-8893-4fe8-9f9a-7ce49bf38772@amazon.es>
 <20230927174611-mutt-send-email-mst@kernel.org>
 <4d22d699-b9f3-4d67-940a-8f11bcd29819@amazon.es>
 <20231102071934-mutt-send-email-mst@kernel.org>
 <23ca2091-efd8-498d-8ed6-9ac4fb905f1d@amazon.es>
 <20231102074645-mutt-send-email-mst@kernel.org>
From: Babis Chalios <bchalios@amazon.es>
Autocrypt: addr=bchalios@amazon.es; keydata=
 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
In-Reply-To: <20231102074645-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.1.213.6]
X-ClientProxiedBy: EX19D033UWA003.ant.amazon.com (10.13.139.42) To
 EX19D037EUB003.ant.amazon.com (10.252.61.119)
Subject: Re: [virtio-dev] [PATCH RFC 3/3] rng: leak detection support

On 2/11/23 12:51, Michael S. Tsirkin wrote:
>
> On Thu, Nov 02, 2023 at 12:38:28PM +0100, Babis Chalios wrote:
>> On 2/11/23 12:20, Michael S. Tsirkin wrote:
>>> On Thu, Sep 28, 2023 at 08:16:11PM +0200, Babis Chalios wrote:
>>>> On 27/9/23 23:47, Michael S. Tsirkin wrote:
>>>>> On Wed, Sep 27, 2023 at 12:43:20PM +0200, Babis Chalios wrote:
>>>>>> On 22/9/23 18:01, Michael S. Tsirkin wrote:
>>>>>>> On Fri, Sep 22, 2023 at 05:40:50PM +0200, Babis Chalios wrote:
>>>>>>>> On 22/9/23 17:06, Michael S. Tsirkin wrote:
>>>>>>>>> On Tue, Sep 19, 2023 at 12:11:37PM +0200, Babis Chalios wrote:
>>>>>>>>>> On 19/9/23 12:01, Michael S. Tsirkin wrote:
>>>>>>>>>>> On Tue, Sep 19, 2023 at 09:32:08AM +0200, Babis Chalios wrote:
>>>>>>>>>>>> Resending to fix e-mail formatting issues (sorry for the spam)
>>>>>>>>>>>>
>>>>>>>>>>>> On 18/9/23 18:30, Babis Chalios wrote:
>>>>>>>>>>>>>>>>> Yes, that's what the driver does now in the RFC patch.
>>>>>>>>>>>>>>>>> However, this just
>>>>>>>>>>>>>>>>> decreases
>>>>>>>>>>>>>>>>> the race window, it doesn't eliminate it. If a third
>>>>>>>>>>>>>>>>> leak event happens it
>>>>>>>>>>>>>>>>> might not
>>>>>>>>>>>>>>>>> find any buffers to use:
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> 1. available buffers to queue 1-X
>>>>>>>>>>>>>>>>> 2. available buffers to queue X
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> 3. poll queue X
>>>>>>>>>>>>>>>>> 4. used buffers in queue X       <- leak event 1 will
>>>>>>>>>>>>>>>>> use buffers in X
>>>>>>>>>>>>>>>>> 5. avail buffers in queue X
>>>>>>>>>>>>>>>>> 6. poll queue 1-X                <- leak event 2 will
>>>>>>>>>>>>>>>>> use buffers in 1-X
>>>>>>>>>>>>>>>>> 7. used buffers in queue 1-X
>>>>>>>>>>>>>>>>> 8. avail buffers in queue 1-X
>>>>>>>>>>>>>>>>>                                          <- leak event 3 (it
>>>>>>>>>>>>>>>>> needs buffers in X, race with step 5)
>>>>>>>>>>>>>>>>> 9. goto 3
>>>>>>>>>>>>>>>> I don't get it. we added buffers in step 5.
>>>>>>>>>>>>>>> What if the leak event 3 arrives before step 5 had time to
>>>>>>>>>>>>>>> actually add the
>>>>>>>>>>>>>>> buffers in X and make
>>>>>>>>>>>>>>> them visible to the device?
>>>>>>>>>>>>>> Then it will see a single event in 1-X instead of two events.  A leak is
>>>>>>>>>>>>>> a leak though, I don't see does it matter how many triggered.
>>>>>>>>>>>>>>
>>>>>>>>>>>> So the scenario I have in mind is the following:
>>>>>>>>>>>>
>>>>>>>>>>>> (Epoch here is terminology that I used in the Linux RFC. It is a value
>>>>>>>>>>>> maintained by random.c
>>>>>>>>>>>> that changes every time a leak event happens).
>>>>>>>>>>>>
>>>>>>>>>>>> 1. add buffers to 1-X
>>>>>>>>>>>> 2. add buffers to X
>>>>>>>>>>>> 3. poll queue X
>>>>>>>>>>>> 4. vcpu 0: get getrandom() entropy and cache epoch value
>>>>>>>>>>>> 5. Device: First snapshot, uses buffers in X
>>>>>>>>>>>> 6. vcpu 1: sees used buffers
>>>>>>>>>>>> 7. Device: Second snapshot, uses buffers in 1-X
>>>>>>>>>>>> 8. vcpu 0: getrandom() observes new  epoch value & caches it
>>>>>>>>>>>> 9. Device: Third snapshot, no buffers in either queue, (vcpu 1 from step 6
>>>>>>>>>>>> has not yet finished adding new buffers).
>>>>>>>>>>>> 10. vcpu 1 adds new buffer in X
>>>>>>>>>>>> 11. vcpu 0: getrandom() will not see new epoch and gets stale entropy.
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> In this succession of events, when the third snapshot will happen, the
>>>>>>>>>>>> device won't find
>>>>>>>>>>>> any buffers in either queue, so it won't increase the RNG epoch value. So,
>>>>>>>>>>>> any entropy
>>>>>>>>>>>> gathered after step 8 will be the same across all snapshots. Am I missing
>>>>>>>>>>>> something?
>>>>>>>>>>>>
>>>>>>>>>>>> Cheers,
>>>>>>>>>>>> Babis
>>>>>>>>>>>>
>>>>>>>>>>> Yes but notice how this is followed by:
>>>>>>>>>>>
>>>>>>>>>>> 12. vcpu 1: sees used buffers in 1-X
>>>>>>>>>>>
>>>>>>>>>>> Driver can notify getrandom I guess?
>>>>>>>>>> It could, but then we have the exact race condition that VMGENID had,
>>>>>>>>>> userspace has already consumed stale entropy and there's nothing we
>>>>>>>>>> can do about that.
>>>>>>>>>>
>>>>>>>>>> Although this is indeed a corner case, it feels like it beats the purpose
>>>>>>>>>> of having the hardware update directly userspace (via copy on leak).
>>>>>>>>>>
>>>>>>>>>> How do you feel about the proposal a couple of emails back? It looks to
>>>>>>>>>> me that it avoids completely the race condition.
>>>>>>>>>>
>>>>>>>>>> Cheers,
>>>>>>>>>> Babis
>>>>>>>>> It does. The problem of course is that this means that e.g.
>>>>>>>>> taking a snapshot of a guest that is stuck won't work well.
>>>>>>>> That is true, but does it matter? The intention of the proposal
>>>>>>>> is that if it is not safe to take snapshots (i.e. no buffers in the
>>>>>>>> queue) don't take snapshots.
>>>>>>>>
>>>>>>>>> I have been thinking of adding MAP/UNMAP descriptors for
>>>>>>>>> a while now. Thus it will be possible to modify
>>>>>>>>> userspace memory without consuming buffers.
>>>>>>>>> Would something like this solve the problem?
>>>>>>>> I am not familiar with MAP/UNMAP descriptors. Is there
>>>>>>>> a link where I can read about them?
>>>>>>>>
>>>>>>>> Cheers,
>>>>>>>> Babis
>>>>>>> Heh no I just came up with the name. Will write up in a couple
>>>>>>> of days, but the idea is that driver does get_user_pages,
>>>>>>> adds buffer to queue, and device will remember the address
>>>>>>> and change that memory on a snapshot. If there are buffers
>>>>>>> in the queue it will also use these to tell driver,
>>>>>>> but if there are no buffers then it won't.
>>>>>> That sounds like a nice mechanism. However in our case the page
>>>>>> holding the counter that gets increased by the hardware is a kernel
>>>>>> page.
>>>>>>
>>>>>> The reason for that is that things other than us (virtio-rng) might
>>>>>> want to notify for leak events. For example, I think that Jason
>>>>>> intended to use this mechanism to periodically notify user-space
>>>>>> PRNGs that they need to reseed.
>>>>>>
>>>>>> Cheers,
>>>>>> Babis
>>>>> Now I'm lost.
>>>>> when you write, e.g.:
>>>>> 4. vcpu 0: get getrandom() entropy and cache epoch value
>>>>> how does vcpu access the epoch?
>>>> The kernel provides a user space API to map a pointer to the epoch
>>>> value. User space then caches its value and checks it every time it
>>>> needs to make sure that no entropy leak has happened before using
>>>> cached kernel entropy.
>>>>
>>>> virtio-rng driver adds a copy on leak command to the queue for
>>>> increasing this value (that's what we are speaking about in this thread).
>>>> But other systems might want to report "leaks", such as random.c
>>>> itself.
>>>>
>>>> Cheers,
>>>> Babis
>>> This idea would be fine but I don't see how it's so different
>>> from VMGENID. Care to explain?
>>>
>> It is different in that the memory is owned by the guest kernel, not
>> the hardware. In this case, random.c maintains it. This allows, systems
>> other than the hardware, e.g. virtio-rng to notify about entropy leak
>> events. For example, random.c itself can periodically do that (I think
>> Jason had that use-case in mind).
> No sure I understand. Example?

Sure!

Take for example a user-space PRNG that uses getrandom() for seeding.
We would like that this PRNG knows when it is not safe any more to return
new random bits, because the initial seed is not unique any more.
In the Linux patch, we use the copy-on-leak command to do that. What the
copy command does in this case, is increase the value of a memory location.
That memory location is maintained by random.c. random.c allows user
space to mmap the page that stores this value. A user-space PRNG would
then mmap this value and observe it for changes.

Now, there is no reason why only virtio-rng should inform user space PRNGs
about entropy leak events. For example, the kernel PRNG (which is handling
out seeds for the user-space PRNG) might want to mark randomness that it
returned earlier as no longer valid (for reasons unrelated to VMs). With 
VMGENID
this would not be possible. However, now that random.c owns that piece of
memory, more than one entities can use it to notify user space about stale
entropy. And they can work together (details on how we do that are in 
the cover
letter of the LKML patch), we can have both the virtio-rng and the random.c
updating that value.

I hope that makes sense and I am really happy to discuss all this, but 
do you
think it is related with the VirtIO protocol?

Cheers,
Babis

>> The fact that we as well mmap that memory to the user-space is just
>> for giving user space a mechanism that allows it to know when it needs
>> to reseed its PRNGs. We _could_ have done the same with VMGENID,
>> but the fact that, in this case, the underlying physical memory is owned
>> by the ACPI device blocks us from letting other systems sending
>> notifications
>> as well.
>>
>> Maybe it makes sense to have this discussion in the patch we sent for
>> Linux on LKML [1]?
>>
>> Cheers,
>> Babis
>>
>> [1] https://lore.kernel.org/lkml/20230823090107.65749-3-bchalios@amazon.es/T/#mb1242999d8296169d9a4ee1a0805005633ec146a
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

