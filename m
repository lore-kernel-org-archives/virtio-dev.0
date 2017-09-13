Return-Path: virtio-dev-return-2538-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id E4CE258191EF
	for <virtio-dev@lists.oasis-open.org>; Tue, 12 Sep 2017 18:26:41 -0700 (PDT)
References: <20160915223915.qjlnlvf2w7u37bu3@redhat.com>
 <0f0e1b94-2a46-689c-dbb3-0d578cc8df33@redhat.com>
 <CAF=yD-+LtZO=Fcw6Y-v0dnxkmwqW1+CqzopyQEApOjOAszgqMg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <092b643b-cfa1-f965-cbf1-0799df1685c7@redhat.com>
Date: Wed, 13 Sep 2017 09:26:32 +0800
MIME-Version: 1.0
In-Reply-To: <CAF=yD-+LtZO=Fcw6Y-v0dnxkmwqW1+CqzopyQEApOjOAszgqMg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [virtio-dev] Re: packed ring layout proposal v3
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org
List-ID: <virtio-dev.lists.oasis-open.org>



On 2017年09月13日 00:23, Willem de Bruijn wrote:
> On Mon, Sep 11, 2017 at 3:47 AM, Jason Wang <jasowang@redhat.com> wrote:
>>
>> On 2017年09月10日 13:06, Michael S. Tsirkin wrote:
>>> This is an update from v2 version.
>>> Changes:
>>> - update event suppression mechanism
>>> - add wrap counter: DESC_WRAP flag in addition to
>>>     DESC_DRIVER flag used for validity so device does not have to
>>>     write out all used descriptors.
>>
>> Do we have benchmark result to show the advantage of DESC_DRIVER over e.g
>> avail/used index?
> The KVM forum presentation has some numbers.

Yes. My question may be not accurate. I meant maybe we should benchmark 
packed ring layout without DESC_DRIVER but something like queue 
tail/head or producer/consumer (or whatever it called). Looks like most 
more nic does not use a flag inside descriptor to exam the descriptor 
ownership.

>
> I'm not sure that synthetic benchmarks will provide much value, as we
> understand the trade-off quite well.
>
> The benefit of this model is improved best case performance, by having
> a single cacheline read instead of two for the indirect used/avail ring model.
>
> The drawback is worse worst case, as scanning the ring of descriptors
> introduces more cacheline misses than scanning the compressed
> used/avail ring.

Like I've replied, looks like the scanning is not friendly to batching 
or prefetching and can cause extra overheads.

>
> This model is easier to implement in hardware and the common case is
> likely close to the best case, so I think it makes sense.

Maybe, but we probably need inputs from hardware vendor guys.

Thanks

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

