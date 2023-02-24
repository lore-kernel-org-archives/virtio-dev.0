Return-Path: <hengqi@linux.alibaba.com>
Message-ID: <f8d09582-749f-11f6-90d1-ac7413ed6937@linux.alibaba.com>
Date: Fri, 24 Feb 2023 22:38:37 +0800
MIME-Version: 1.0
Subject: Re: [virtio-dev] Re: [PATCH v9] virtio-net: support inner header hash
References: <20230218143715.841-1-hengqi@linux.alibaba.com>
 <20230223080358-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481FD1A82D37157AFCFC541DCAB9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230224030725-mutt-send-email-mst@kernel.org>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <20230224030725-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: "Michael S. Tsirkin" <mst@redhat.com>, Parav Pandit <parav@nvidia.com>
Cc: "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Jason Wang <jasowang@redhat.com>, Yuri Benditovich <yuri.benditovich@daynix.com>, Cornelia Huck <cohuck@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "ailan@redhat.com" <ailan@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>



在 2023/2/24 下午4:13, Michael S. Tsirkin 写道:
> On Thu, Feb 23, 2023 at 02:40:46PM +0000, Parav Pandit wrote:
>>
>>> From: Michael S. Tsirkin <mst@redhat.com>
>>> Sent: Thursday, February 23, 2023 8:14 AM
>>>
>>> On Sat, Feb 18, 2023 at 10:37:15PM +0800, Heng Qi wrote:
>>
>>> So for RSS specifically, we brain-stormed with Amnon (Cc'd) and came up with
>>> an idea: RSS indirection table entries are 16 bit but onlu 15 bits are used to
>>> indentify an RX queue.
>>> We can use the remaining bit as a "tunnel bit" to signal whether to use the
>>> inner or the outer hash for queue selection.
>>>
>> I further brainstormed internally with Saeed and Rony on this.
>>
>> The inner hash is only needed for GRE, IPIP etc.
>> For VXLAN and NVGRE Linux kernel transmit side uses the entropy of the source port of the outer header.
>> It does that based on the inner header.
>> Refer to [1] as one example.
>>
>> [1] https://elixir.bootlin.com/linux/latest/source/drivers/net/geneve.c#L922
> But I think hash was requested for RSS with dpdk, no?

I think yes, at least probably the first customer to use the feature 
might be dpdk.:)


>
>>> The lookup will work like this then:
>>>
>>> calculate outer hash
>>> if (rss[outer hash] & tunnel bit)
>> Tunnel bit, you mean tunneled packet, right?
> this idea stores a bit in the indirection table
> which signals which of the hashes to use for rss

This allows inner hash to have the ability to select a queue and place 
packets to the queue (that is, parallel to RSS),
which seems to be different from our discussion before v9. 🙁

Thanks.

>
>>> then
>>> 	calculate inner hash
>>> 	return rss[inner hash] & ~tunnel bit
>> Why to end with a tunnel bit?
>
> this just clears the bit so we end up with a vq number.
>
>>> else
>>> 	return rss[outer hash]
>>>
>>>
>>> this fixes the security issue returning us back to status quo : specific tunnels can
>>> be directed to separate queues.
>>>
>> The number of tunnels is far higher than the number of queues with para virt driver doing decap.
> True. This seeks to get us back to where we are before the feature:
> driver can send specific outer hashes to specific queues.
> outer hash collisions remain a problem.
>
>
>>> This is for RSS.
>>>
>>>
>>> For hash reporting indirection table is not used.
>>> Maybe it is enough to signal to driver that inner hash was used.
>>> We do need that signalling though.
>>>
>>> My question would be whether it's practical to implement in hardware.
>> In above example, hw calculating double hash is difficult without much gain.
>> Either calculating on one inner or outer makes sense.
>>
>> Signaling whether calculated on inner or outer is fine because hw exactly tells what it did.
> This, in a sense, is what reporting hash tunnel type did.
> Do you now think we need it?
>

