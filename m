Return-Path: <hengqi@linux.alibaba.com>
Message-ID: <c6f13b16-d566-5cd6-680a-8744d7fae89b@linux.alibaba.com>
Date: Tue, 21 Feb 2023 21:37:57 +0800
MIME-Version: 1.0
Subject: Re: [virtio-dev] RE: [virtio-comment] RE: [PATCH v9] virtio-net:
 support inner header hash
References: <20230218143715.841-1-hengqi@linux.alibaba.com>
 <PH0PR12MB5481224CBC059BD482347133DCA59@PH0PR12MB5481.namprd12.prod.outlook.com>
 <9ff76a6e-fd77-4cf3-a9ad-546696ab843d@linux.alibaba.com>
 <PH0PR12MB5481E635794E2B63B9A110A3DCA59@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <PH0PR12MB5481E635794E2B63B9A110A3DCA59@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: Parav Pandit <parav@nvidia.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Yuri Benditovich <yuri.benditovich@daynix.com>, Cornelia Huck <cohuck@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>


在 2023/2/21 下午8:47, Parav Pandit 写道:
>
>> From: virtio-comment@lists.oasis-open.org <virtio-comment@lists.oasis-
>> open.org> On Behalf Of Heng Qi
>>>> Also, a feature bit VIRTIO_NET_F_HASH_REPORT_TUNNEL are added to
>>>> report an encapsulation type, and the feature depends on
>>>> VIRTIO_NET_F_HASH_REPORT.
>>> As we discussed that tunnel type alone is not useful the sw, neither as an
>> individual field nor merged with some other field.
>>> Hence, please remove this feature bit. HASH_TUNNEL is good enough.
>>> Please remove the references to it at more places below.
>> If we don't want it at all, I'll remove it and references to it.
>>
> Ok. thanks.
> [..]
>>>>    #define VIRTIO_NET_HASH_TYPE_UDP_EX            (1 << 8)
>>>>    \end{lstlisting}
>>>>
>>> Lets please remove the below encoding.
>> Here is the encoding of the hash tunnel types, I guess you are referring to
>> remove the encoding of the hash_report_tunnel types?
>>
> Right.
> [..]
>>>> +RSS to select queues for placement. When a user inside a tunnel
>>>> +tries to control the enqueuing of encapsulated packets, then the
>>>> +user can flood the device with invaild packets, and the flooded
>>>> +packets may be hashed into the same queue as packets in other normal
>>>> +tunnels, which causing
>>>> the queue to overflow.
>>>>
>>> Invalid packets are confusing and the wording of "which causing" is not
>> proper.
>>> There is some duplicate wording below too.
>>>
>>> I think above and below risk can be summarized in bit simpler manner.
>>>
>>> How about,
>>>
>>> When a specific receive queue is shared to receive packets of multiple
>> tunnels, there is no quality of service for packets of multiple tunnels.
>>> +
>> I think this sentence can be used as a starting summary, and readers may still
>> need to expand the explanation.
>> Do you think the following description is ok?
>> "
>> When a specific receive queue is shared to receive encapsulating packets of
>> multiple tunnels, there is no quality of service for these packets of multiple
>> tunnels.
>> For example:
>> A user inside the tunnel floods a device with packets, then the packets are
>> hashed into the shared receive queue and cause the queue to overflow, and
>> this increases packet loss and latency for other tunnels.
>> "
> Even without a queue overflow, this shared receive queue may not have a balanced number of packets.
> For example, tunnel-2 occupied 90% of the queue and left only 10% for tunnel-1.
> So, your example is right (and extreme), a generic mention of QoS covers both aspects.
>
> Secondly "user inside the tunnel" is challenging to explain.
> In above sentence talks specifically about the "receive queue" as an object.
>   
>> struct virtio_net_rss_config {
>>>>        le32 hash_types;
>>>> +    le32 hash_tunnel_types;
>>> This field is not needed as device config space advertisement for the support
>> is enough.
>>
>> If so, virtio_net_hash_config does not require hash_tunnel_types when it does
>> not need to configure the specific tunnel(s).
>>
>>> If the intent is to enable hashing for the specific tunnel(s), an individual
>> command is better.
>>
>> Drivers MAY filter out some tunneling types when negotiating this feature.
>> Do you think it would be better for us to add a separate command? I don't see
>> tools like ethtool that can configure specific tunnels in userspace.
>>
> The reason I proposed different command is,
> Let's say we have only single command.
> Rss config command has many other fields unrelated to the inner hash.

And virtio_net_hash_config seems to suffice except for le16 reserved[4].

> Hence, to enable inner hash, the driver needs to supply the exact same value for unrelated fields to the same value.
> And device needs to compare it with the old value and maintain some sort of cache to derive that nothing changes from the previous hash config, hence, ignore hw configuration for rss.
>
> This mechanism slows down the command for the unrelated task.
> Hence, I am considering a separate command that would be simple for the device and driver to implement.
>
>>> Regardless, this new field cannot be in the middle of the new structure as it
>> breaks backward compatibility.
>> Yes, you are right. I'll fix this.
>>
>> Thank you very much!
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

