Return-Path: <virtio-dev-return-14005-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7EF9CDB482
	for <virtio-dev@archiver.kernel.org>; Fri, 13 Oct 2023 07:50:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 072E9613D9
	for <virtio-dev@archiver.kernel.org>; Fri, 13 Oct 2023 07:50:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D5FB2986840
	for <virtio-dev@archiver.kernel.org>; Fri, 13 Oct 2023 07:50:33 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id B1F4A986836; Fri, 13 Oct 2023 07:50:33 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 33641986835;
	Fri, 13 Oct 2023 07:49:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-IronPort-AV: E=Sophos;i="6.03,221,1694736000"; 
   d="scan'208";a="245329882"
Message-ID: <5f548d39-2ae4-45a8-9dba-49a2c693dae4@amazon.es>
Date: Fri, 13 Oct 2023 09:49:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Babis Chalios <bchalios@amazon.es>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: <virtio-comment@lists.oasis-open.org>, <virtio-dev@lists.oasis-open.org>,
	"Cali, Marco" <xmarcalx@amazon.co.uk>, "Graf (AWS), Alexander"
	<graf@amazon.de>, "Jason A. Donenfeld" <Jason@zx2c4.com>, <aams@amazon.de>
References: <a22ba2cb-9b03-481a-b66e-0b78fbfb21f0@amazon.es>
 <20230918100355-mutt-send-email-mst@kernel.org>
 <4ab1b10e-4524-4b6c-a3df-863360fd225d@amazon.es>
 <c2e7076b-b07e-43cd-a912-9314d742a678@amazon.es>
 <20230919055811-mutt-send-email-mst@kernel.org>
 <4c6d6710-43c8-402b-9ae6-d2f4cafbe9a7@amazon.es>
 <20230922110329-mutt-send-email-mst@kernel.org>
 <c0c5b159-997f-4ddf-ab3e-1c749ad93e10@amazon.es>
 <20230922115920-mutt-send-email-mst@kernel.org>
 <19967fde-8893-4fe8-9f9a-7ce49bf38772@amazon.es>
 <20230927174611-mutt-send-email-mst@kernel.org>
 <4d22d699-b9f3-4d67-940a-8f11bcd29819@amazon.es>
Content-Language: en-US
Autocrypt: addr=bchalios@amazon.es; keydata=
 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
In-Reply-To: <4d22d699-b9f3-4d67-940a-8f11bcd29819@amazon.es>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.1.212.14]
X-ClientProxiedBy: EX19D045UWC001.ant.amazon.com (10.13.139.223) To
 EX19D037EUB003.ant.amazon.com (10.252.61.119)
Subject: Re: [virtio-dev] [PATCH RFC 3/3] rng: leak detection support



On 28/9/23 20:16, Babis Chalios wrote:
>
>
> On 27/9/23 23:47, Michael S. Tsirkin wrote:
>> On Wed, Sep 27, 2023 at 12:43:20PM +0200, Babis Chalios wrote:
>>> On 22/9/23 18:01, Michael S. Tsirkin wrote:
>>>> On Fri, Sep 22, 2023 at 05:40:50PM +0200, Babis Chalios wrote:
>>>>> On 22/9/23 17:06, Michael S. Tsirkin wrote:
>>>>>> On Tue, Sep 19, 2023 at 12:11:37PM +0200, Babis Chalios wrote:
>>>>>>> On 19/9/23 12:01, Michael S. Tsirkin wrote:
>>>>>>>> On Tue, Sep 19, 2023 at 09:32:08AM +0200, Babis Chalios wrote:
>>>>>>>>> Resending to fix e-mail formatting issues (sorry for the spam)
>>>>>>>>>
>>>>>>>>> On 18/9/23 18:30, Babis Chalios wrote:
>>>>>>>>>>>>>> Yes, that's what the driver does now in the RFC patch.
>>>>>>>>>>>>>> However, this just
>>>>>>>>>>>>>> decreases
>>>>>>>>>>>>>> the race window, it doesn't eliminate it. If a third
>>>>>>>>>>>>>> leak event happens it
>>>>>>>>>>>>>> might not
>>>>>>>>>>>>>> find any buffers to use:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> 1. available buffers to queue 1-X
>>>>>>>>>>>>>> 2. available buffers to queue X
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> 3. poll queue X
>>>>>>>>>>>>>> 4. used buffers in queue X       <- leak event 1 will
>>>>>>>>>>>>>> use buffers in X
>>>>>>>>>>>>>> 5. avail buffers in queue X
>>>>>>>>>>>>>> 6. poll queue 1-X                <- leak event 2 will
>>>>>>>>>>>>>> use buffers in 1-X
>>>>>>>>>>>>>> 7. used buffers in queue 1-X
>>>>>>>>>>>>>> 8. avail buffers in queue 1-X
>>>>>>>>>>>>>> <- leak event 3 (it
>>>>>>>>>>>>>> needs buffers in X, race with step 5)
>>>>>>>>>>>>>> 9. goto 3
>>>>>>>>>>>>> I don't get it. we added buffers in step 5.
>>>>>>>>>>>> What if the leak event 3 arrives before step 5 had time to
>>>>>>>>>>>> actually add the
>>>>>>>>>>>> buffers in X and make
>>>>>>>>>>>> them visible to the device?
>>>>>>>>>>> Then it will see a single event in 1-X instead of two 
>>>>>>>>>>> events.  A leak is
>>>>>>>>>>> a leak though, I don't see does it matter how many triggered.
>>>>>>>>>>>
>>>>>>>>> So the scenario I have in mind is the following:
>>>>>>>>>
>>>>>>>>> (Epoch here is terminology that I used in the Linux RFC. It is 
>>>>>>>>> a value
>>>>>>>>> maintained by random.c
>>>>>>>>> that changes every time a leak event happens).
>>>>>>>>>
>>>>>>>>> 1. add buffers to 1-X
>>>>>>>>> 2. add buffers to X
>>>>>>>>> 3. poll queue X
>>>>>>>>> 4. vcpu 0: get getrandom() entropy and cache epoch value
>>>>>>>>> 5. Device: First snapshot, uses buffers in X
>>>>>>>>> 6. vcpu 1: sees used buffers
>>>>>>>>> 7. Device: Second snapshot, uses buffers in 1-X
>>>>>>>>> 8. vcpu 0: getrandom() observes new  epoch value & caches it
>>>>>>>>> 9. Device: Third snapshot, no buffers in either queue, (vcpu 1 
>>>>>>>>> from step 6
>>>>>>>>> has not yet finished adding new buffers).
>>>>>>>>> 10. vcpu 1 adds new buffer in X
>>>>>>>>> 11. vcpu 0: getrandom() will not see new epoch and gets stale 
>>>>>>>>> entropy.
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> In this succession of events, when the third snapshot will 
>>>>>>>>> happen, the
>>>>>>>>> device won't find
>>>>>>>>> any buffers in either queue, so it won't increase the RNG 
>>>>>>>>> epoch value. So,
>>>>>>>>> any entropy
>>>>>>>>> gathered after step 8 will be the same across all snapshots. 
>>>>>>>>> Am I missing
>>>>>>>>> something?
>>>>>>>>>
>>>>>>>>> Cheers,
>>>>>>>>> Babis
>>>>>>>>>
>>>>>>>> Yes but notice how this is followed by:
>>>>>>>>
>>>>>>>> 12. vcpu 1: sees used buffers in 1-X
>>>>>>>>
>>>>>>>> Driver can notify getrandom I guess?
>>>>>>> It could, but then we have the exact race condition that VMGENID 
>>>>>>> had,
>>>>>>> userspace has already consumed stale entropy and there's nothing we
>>>>>>> can do about that.
>>>>>>>
>>>>>>> Although this is indeed a corner case, it feels like it beats 
>>>>>>> the purpose
>>>>>>> of having the hardware update directly userspace (via copy on 
>>>>>>> leak).
>>>>>>>
>>>>>>> How do you feel about the proposal a couple of emails back? It 
>>>>>>> looks to
>>>>>>> me that it avoids completely the race condition.
>>>>>>>
>>>>>>> Cheers,
>>>>>>> Babis
>>>>>> It does. The problem of course is that this means that e.g.
>>>>>> taking a snapshot of a guest that is stuck won't work well.
>>>>> That is true, but does it matter? The intention of the proposal
>>>>> is that if it is not safe to take snapshots (i.e. no buffers in the
>>>>> queue) don't take snapshots.
>>>>>
>>>>>> I have been thinking of adding MAP/UNMAP descriptors for
>>>>>> a while now. Thus it will be possible to modify
>>>>>> userspace memory without consuming buffers.
>>>>>> Would something like this solve the problem?
>>>>> I am not familiar with MAP/UNMAP descriptors. Is there
>>>>> a link where I can read about them?
>>>>>
>>>>> Cheers,
>>>>> Babis
>>>> Heh no I just came up with the name. Will write up in a couple
>>>> of days, but the idea is that driver does get_user_pages,
>>>> adds buffer to queue, and device will remember the address
>>>> and change that memory on a snapshot. If there are buffers
>>>> in the queue it will also use these to tell driver,
>>>> but if there are no buffers then it won't.
>>> That sounds like a nice mechanism. However in our case the page
>>> holding the counter that gets increased by the hardware is a kernel
>>> page.
>>>
>>> The reason for that is that things other than us (virtio-rng) might
>>> want to notify for leak events. For example, I think that Jason
>>> intended to use this mechanism to periodically notify user-space
>>> PRNGs that they need to reseed.
>>>
>>> Cheers,
>>> Babis
>>
>> Now I'm lost.
>> when you write, e.g.:
>> 4. vcpu 0: get getrandom() entropy and cache epoch value
>> how does vcpu access the epoch?
>
> The kernel provides a user space API to map a pointer to the epoch
> value. User space then caches its value and checks it every time it
> needs to make sure that no entropy leak has happened before using
> cached kernel entropy.
>
> virtio-rng driver adds a copy on leak command to the queue for
> increasing this value (that's what we are speaking about in this thread).
> But other systems might want to report "leaks", such as random.c
> itself.
>
> Cheers,
> Babis

Hey Michael, does this explain the flow of things?

To summarize, end-to-end things work like this:

1. kernel allocates a page where an epoch value is stored.
2. User-space can mmap this page and look for changes in its value to
     know when it needs to re-seed its PRNGs.
3. virtio-rng driver gets a hold of the address of the page and programs
     device to update it when entropy is leaked
4. Other kernel sub-systems can do the same if they have a concept of
     entropy leaking. For example, random.c might want to do this 
periodically

Regarding your suggestion for MAP/UNMAP buffers, I think it could work
if it was working with kernel addresses as well. The device doesn't care
about user vs kernel space guest addresses after all. However, if we were to
use such a mechanism, it seems that we don't need the two leak queues
anyway.

So, it sounds like we can have a setup with one leak queue only. If we use a
MAP/UNMAP type of buffer then all is fine. If we use normal buffers, we can
add the requirement that the VMM needs to refuse to take a snapshot if there
is not a copy on leak buffer in the queue.

Thoughts?

Cheers,
Babis

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

