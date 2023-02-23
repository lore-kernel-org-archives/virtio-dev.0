Return-Path: <hengqi@linux.alibaba.com>
Message-ID: <0547edfa-bb75-62bb-9a33-41a9b9603a0e@linux.alibaba.com>
Date: Thu, 23 Feb 2023 12:41:52 +0800
MIME-Version: 1.0
Subject: Re: [virtio-dev] Re: [PATCH v9] virtio-net: support inner header hash
References: <20230218143715.841-1-hengqi@linux.alibaba.com>
 <20230221124518-mutt-send-email-mst@kernel.org>
 <4d123e32-1ad0-e692-7fa6-0565eb34c487@redhat.com>
 <0f53212f-a89b-ad3c-73e3-a7a7b5533058@linux.alibaba.com>
 <1047920c-5dd5-8f31-0c4c-a108f36155f8@redhat.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <1047920c-5dd5-8f31-0c4c-a108f36155f8@redhat.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, Parav Pandit <parav@nvidia.com>, Yuri Benditovich <yuri.benditovich@daynix.com>, Cornelia Huck <cohuck@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>



在 2023/2/23 上午10:50, Jason Wang 写道:
> Hi:
>
> 在 2023/2/22 14:46, Heng Qi 写道:
>> Hi, Jason. Long time no see. :)
>>
>> 在 2023/2/22 上午11:22, Jason Wang 写道:
>>>
>>> 在 2023/2/22 01:50, Michael S. Tsirkin 写道:
>>>> On Sat, Feb 18, 2023 at 10:37:15PM +0800, Heng Qi wrote:
>>>>> +\subparagraph{Security risks between encapsulated packets and RSS}
>>>>> +There may be potential security risks when encapsulated packets 
>>>>> using RSS to
>>>>> +select queues for placement. When a user inside a tunnel tries to 
>>>>> control the
>>>
>>>
>>> What do you mean by "user" here? Is it a remote or local one?
>>>
>>
>> I mean a remote attacker who is not under the control of the tunnel 
>> owner.
>
>
> Anything may the tunnel different? I think this can happen even 
> without tunnel (and even with single queue).

I agree.

>
> How to mitigate those attackers seems more like a implementation 
> details where might require fair queuing or other QOS technology which 
> has been well studied.

I am also not sure whether this point needs to be focused on in the 
spec, and I see that the protection against tunnel DoS is more protected 
outside the device,
but it seems to be okay to give some attack reminders.

Thanks.

>
> It seems out of the scope of the spec (unless we want to let driver 
> manageable QOS).
>
> Thanks
>
>
>>
>> Thanks.
>>
>>>
>>>>> +enqueuing of encapsulated packets, then the user can flood the 
>>>>> device with invaild
>>>>> +packets, and the flooded packets may be hashed into the same 
>>>>> queue as packets in
>>>>> +other normal tunnels, which causing the queue to overflow.
>>>>> +
>>>>> +This can pose several security risks:
>>>>> +\begin{itemize}
>>>>> +\item  Encapsulated packets in the normal tunnels cannot be 
>>>>> enqueued due to queue
>>>>> +       overflow, resulting in a large amount of packet loss.
>>>>> +\item  The delay and retransmission of packets in the normal 
>>>>> tunnels are extremely increased.
>>>>> +\item  The user can observe the traffic information and enqueue 
>>>>> information of other normal
>>>>> +       tunnels, and conduct targeted DoS attacks.
>>>>> +\end{\itemize}
>>>>> +
>>>> Hmm with this all written out it sounds pretty severe.
>>>
>>>
>>> I think we need first understand whether or not it's a problem that 
>>> we need to solve at spec level:
>>>
>>> 1) anything make encapsulated packets different or why we can't hit 
>>> this problem without encapsulation
>>>
>>> 2) whether or not it's the implementation details that the spec 
>>> doesn't need to care (or how it is solved in real NIC)
>>>
>>> Thanks
>>>
>>>
>>>> At this point with no ways to mitigate, I don't feel this is something
>>>> e.g. Linux can enable.  I am not going to nack the spec patch if
>>>> others  find this somehow useful e.g. for dpdk.
>>>> How about CC e.g. dpdk devs or whoever else is going to use this
>>>> and asking them for the opinion?
>>>>
>>>>
>>
>
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

