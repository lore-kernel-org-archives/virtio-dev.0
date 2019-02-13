Return-Path: virtio-dev-return-5433-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EA6E9985E0C
	for <virtio-dev@lists.oasis-open.org>; Wed, 13 Feb 2019 10:34:00 +0000 (UTC)
References: <2f0de388-de01-1e51-b6b6-339389a2268a@solarflare.com>
 <20190211021124-mutt-send-email-mst@kernel.org>
 <d5d3b7f6-95a3-0d1c-4890-6e72f2e4bfc5@solarflare.com>
 <20190211080432-mutt-send-email-mst@kernel.org>
 <97e870fd-dbd5-2fed-b62c-67d24407e5cf@solarflare.com>
 <20190211233612-mutt-send-email-mst@kernel.org>
 <02809024-c99c-caf5-5ec4-98ee96ca6cd5@solarflare.com>
 <20190212085415-mutt-send-email-mst@kernel.org>
 <15b8c0b7-643d-d9c2-f05c-0f5d8c8169c3@solarflare.com>
 <20190212122619-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <f120aec1-60d7-33e2-9188-4abbdd887532@redhat.com>
Date: Wed, 13 Feb 2019 18:33:50 +0800
MIME-Version: 1.0
In-Reply-To: <20190212122619-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [virtio-dev] RFC: Doorbell suppression, packed-ring mode and
 hardware offload
To: "Michael S. Tsirkin" <mst@redhat.com>, David Riddoch <driddoch@solarflare.com>
Cc: Virtio-Dev <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>


On 2019/2/13 上午1:35, Michael S. Tsirkin wrote:
> On Tue, Feb 12, 2019 at 04:47:08PM +0000, David Riddoch wrote:
>>>>>> I would prefer to have the write barrier before writing the idx.
>>>>> Well that's driver overhead for something device might never utilise in
>>>>> a given workload. If we are optimizing let's optimize for speed.
>>>> I think doing the barrier before writing idx is best for speed (see below).
>>> I don't see it below:(
>> Sorry, I'm not being clear.  If the write barrier is before the idx, then a
>> PV device can read the idx, do a single rmb and read a whole bunch of
>> descriptors.  As things stand today a PV device has to do an rmb for each
>> descriptor that it reads.
>>
>> I'm not sure, but this may be what Jason meant when he said "prefetch".


Yes.


> Oh. Right. So for PV it's easy to convert an rmb to a data dependency
> instead.  It remains to be seen whether an extra cache miss per
> batch is cheaper or more expensive than such a dependency
> per descriptor.
>
> I hope Jason can experiment and let us know.
>
>

To clarify, actually I did play someting like:


if (desc_is_avail((last_avail + 32) % size))

     [last_avail, last_avail + 32] is avail [1]

else if (desc_is_avail(last_avail + 1) % size))

     last_avail is avail

else

    no new


And looks like [1] depends on the driver to do:

for all descriptors

     update desc (but not make it available for the flag)

wmb()

for all descriptors

     update desc.flag


This means if last_avail + 32 is avail, no need to check flags of 
[last_avail, last_avail + 31] since the descriptor content (except for 
the flag) is guaranteed to be correct.

I get ~10% PPS improvement.

Thanks


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

