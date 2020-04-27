Return-Path: virtio-dev-return-7186-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B432F985BA9
	for <virtio-dev@lists.oasis-open.org>; Mon, 27 Apr 2020 15:59:55 +0000 (UTC)
References: <20200424164239.10723.58352.stgit@localhost.localdomain>
 <20200424165021.10723.14111.stgit@localhost.localdomain>
 <7ce2bcde-7466-2764-7248-36f67bb9b573@redhat.com>
 <CAKgT0Uckr4uN=WCvGtp5GtXRZjfR+x1BR7L5b=RvnT7CHwtsMw@mail.gmail.com>
 <829a7d06-d5f4-1d82-32b9-744603288d84@redhat.com>
 <CAKgT0Ud2wbG_qRw2PXuz1E45DTT-NWQgVf=155172RPSf84joA@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <31085f60-6330-9552-bc92-cbc3d2fba1e6@redhat.com>
Date: Mon, 27 Apr 2020 17:59:11 +0200
MIME-Version: 1.0
In-Reply-To: <CAKgT0Ud2wbG_qRw2PXuz1E45DTT-NWQgVf=155172RPSf84joA@mail.gmail.com>
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH v22 QEMU 3/5] virtio-balloon: Replace free page hinting
 references to 'report' with 'hint'
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
List-ID: <virtio-dev.lists.oasis-open.org>

On 27.04.20 17:57, Alexander Duyck wrote:
> On Mon, Apr 27, 2020 at 8:11 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 27.04.20 17:08, Alexander Duyck wrote:
>>> On Mon, Apr 27, 2020 at 1:15 AM David Hildenbrand <david@redhat.com> wrote:
>>>>
>>>> There is only one wrong comment remaining I think. Something like
>>>>
>>>> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
>>>> index a1d6fb52c8..1b2127c04c 100644
>>>> --- a/hw/virtio/virtio-balloon.c
>>>> +++ b/hw/virtio/virtio-balloon.c
>>>> @@ -554,8 +554,8 @@ static void virtio_balloon_free_page_stop(VirtIOBalloon *s)
>>>>           */
>>>>          qemu_mutex_lock(&s->free_page_lock);
>>>>          /*
>>>> -         * The guest hasn't done the reporting, so host sends a notification
>>>> -         * to the guest to actively stop the reporting.
>>>> +         * The guest isn't done with hinting, so the host sends a notification
>>>> +         * to the guest to actively stop the hinting.
>>>
>>> I'll probably tweak it slightly and drop the "with". So the comment will read:
>>>         /*
>>>          * The guest isn't done hinting, so host sends a notification
>>
>> I always feel like "so host sends" sounds wrong ("the host"). But I am
>> not a native speaker.
> 
> Actually it might read better to get rid of "the host" entirely to
> make it more of an imperative statement rather than a declarative one.
> Maybe something more like:
>         /*
>          * The guest isn't done hinting, so send a notification
>          * to the guest to actively stop the hinting.
>          */
> 

Sounds good :)

-- 
Thanks,

David / dhildenb


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

