Return-Path: <virtio-dev-return-11246-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6D6B1986655
	for <virtio-dev@lists.oasis-open.org>; Fri, 24 Feb 2023 02:45:21 +0000 (UTC)
Message-ID: <cfa99440-4a37-87c9-72de-68ce1d727721@redhat.com>
Date: Fri, 24 Feb 2023 10:45:13 +0800
MIME-Version: 1.0
References: <20230218143715.841-1-hengqi@linux.alibaba.com>
 <20230221124518-mutt-send-email-mst@kernel.org>
 <4d123e32-1ad0-e692-7fa6-0565eb34c487@redhat.com>
 <0f53212f-a89b-ad3c-73e3-a7a7b5533058@linux.alibaba.com>
 <1047920c-5dd5-8f31-0c4c-a108f36155f8@redhat.com>
 <0547edfa-bb75-62bb-9a33-41a9b9603a0e@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <0547edfa-bb75-62bb-9a33-41a9b9603a0e@linux.alibaba.com>
Subject: Re: [virtio-dev] Re: [PATCH v9] virtio-net: support inner header hash
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Heng Qi <hengqi@linux.alibaba.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, Parav Pandit <parav@nvidia.com>, Yuri Benditovich <yuri.benditovich@daynix.com>, Cornelia Huck <cohuck@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>


=E5=9C=A8 2023/2/23 12:41, Heng Qi =E5=86=99=E9=81=93:
>
>
> =E5=9C=A8 2023/2/23 =E4=B8=8A=E5=8D=8810:50, Jason Wang =E5=86=99=E9=81=
=93:
>> Hi:
>>
>> =E5=9C=A8 2023/2/22 14:46, Heng Qi =E5=86=99=E9=81=93:
>>> Hi, Jason. Long time no see. :)
>>>
>>> =E5=9C=A8 2023/2/22 =E4=B8=8A=E5=8D=8811:22, Jason Wang =E5=86=99=E9=81=
=93:
>>>>
>>>> =E5=9C=A8 2023/2/22 01:50, Michael S. Tsirkin =E5=86=99=E9=81=93:
>>>>> On Sat, Feb 18, 2023 at 10:37:15PM +0800, Heng Qi wrote:
>>>>>> +\subparagraph{Security risks between encapsulated packets and RSS}
>>>>>> +There may be potential security risks when encapsulated packets=20
>>>>>> using RSS to
>>>>>> +select queues for placement. When a user inside a tunnel tries=20
>>>>>> to control the
>>>>
>>>>
>>>> What do you mean by "user" here? Is it a remote or local one?
>>>>
>>>
>>> I mean a remote attacker who is not under the control of the tunnel=20
>>> owner.
>>
>>
>> Anything may the tunnel different? I think this can happen even=20
>> without tunnel (and even with single queue).
>
> I agree.
>
>>
>> How to mitigate those attackers seems more like a implementation=20
>> details where might require fair queuing or other QOS technology=20
>> which has been well studied.
>
> I am also not sure whether this point needs to be focused on in the=20
> spec, and I see that the protection against tunnel DoS is more=20
> protected outside the device,
> but it seems to be okay to give some attack reminders.


Maybe it's sufficient to say the device should make sure the fairness=20
among different flows when queuing packets?

Thanks


>
> Thanks.
>
>>
>> It seems out of the scope of the spec (unless we want to let driver=20
>> manageable QOS).
>>
>> Thanks
>>
>>
>>>
>>> Thanks.
>>>
>>>>
>>>>>> +enqueuing of encapsulated packets, then the user can flood the=20
>>>>>> device with invaild
>>>>>> +packets, and the flooded packets may be hashed into the same=20
>>>>>> queue as packets in
>>>>>> +other normal tunnels, which causing the queue to overflow.
>>>>>> +
>>>>>> +This can pose several security risks:
>>>>>> +\begin{itemize}
>>>>>> +\item=C2=A0 Encapsulated packets in the normal tunnels cannot be=20
>>>>>> enqueued due to queue
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 overflow, resulting in a large=
 amount of packet loss.
>>>>>> +\item=C2=A0 The delay and retransmission of packets in the normal=
=20
>>>>>> tunnels are extremely increased.
>>>>>> +\item=C2=A0 The user can observe the traffic information and enqueu=
e=20
>>>>>> information of other normal
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tunnels, and conduct targeted =
DoS attacks.
>>>>>> +\end{\itemize}
>>>>>> +
>>>>> Hmm with this all written out it sounds pretty severe.
>>>>
>>>>
>>>> I think we need first understand whether or not it's a problem that=20
>>>> we need to solve at spec level:
>>>>
>>>> 1) anything make encapsulated packets different or why we can't hit=20
>>>> this problem without encapsulation
>>>>
>>>> 2) whether or not it's the implementation details that the spec=20
>>>> doesn't need to care (or how it is solved in real NIC)
>>>>
>>>> Thanks
>>>>
>>>>
>>>>> At this point with no ways to mitigate, I don't feel this is=20
>>>>> something
>>>>> e.g. Linux can enable.=C2=A0 I am not going to nack the spec patch if
>>>>> others=C2=A0 find this somehow useful e.g. for dpdk.
>>>>> How about CC e.g. dpdk devs or whoever else is going to use this
>>>>> and asking them for the opinion?
>>>>>
>>>>>
>>>
>>
>>
>> ---------------------------------------------------------------------
>> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
>> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

