Return-Path: <virtio-comment-return-4408-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Message-ID: <85de2618-6018-5436-6e8a-4d5253b42e64@linux.alibaba.com>
Date: Wed, 22 Feb 2023 00:44:26 +0800
MIME-Version: 1.0
References: <20230218143715.841-1-hengqi@linux.alibaba.com>
 <PH0PR12MB5481224CBC059BD482347133DCA59@PH0PR12MB5481.namprd12.prod.outlook.com>
 <9ff76a6e-fd77-4cf3-a9ad-546696ab843d@linux.alibaba.com>
 <PH0PR12MB5481E635794E2B63B9A110A3DCA59@PH0PR12MB5481.namprd12.prod.outlook.com>
 <f7080485-e8bd-048f-b8ea-cd86757f7b1c@linux.alibaba.com>
 <PH0PR12MB548135774CD69A5A5F475FB2DCA59@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <PH0PR12MB548135774CD69A5A5F475FB2DCA59@PH0PR12MB5481.namprd12.prod.outlook.com>
Subject: [virtio-comment] Re: [virtio-dev] RE: [virtio-comment] RE: [PATCH v9] virtio-net:
 support inner header hash
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Parav Pandit <parav@nvidia.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Yuri Benditovich <yuri.benditovich@daynix.com>, Cornelia Huck <cohuck@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>



=E5=9C=A8 2023/2/21 =E4=B8=8B=E5=8D=8811:32, Parav Pandit =E5=86=99=E9=81=
=93:
>> From: Heng Qi <hengqi@linux.alibaba.com>
>> Sent: Tuesday, February 21, 2023 8:34 AM
>>> Even without a queue overflow, this shared receive queue may not have a
>> balanced number of packets.
>>> For example, tunnel-2 occupied 90% of the queue and left only 10% for
>> tunnel-1.
>>> So, your example is right (and extreme), a generic mention of QoS cover=
s
>> both aspects.
>>> Secondly "user inside the tunnel" is challenging to explain.
>>> In above sentence talks specifically about the "receive queue" as an ob=
ject.
>>>
>> "overflow" in my example. If we only use a one-sentence summary to descr=
ibe
>> tunnel risks, then I think this subparagraph is called "QoS problem for =
tunnel
>> hash".
>>
> Yes, Tunnel Qos limitations
>
>>>> struct virtio_net_rss_config {
>>>>>>         le32 hash_types;
>>>>>> +    le32 hash_tunnel_types;
>>>>> This field is not needed as device config space advertisement for
>>>>> the support
>>>> is enough.
>>>>
>>>> If so, virtio_net_hash_config does not require hash_tunnel_types when
>>>> it does not need to configure the specific tunnel(s).
>>>>
>>>>> If the intent is to enable hashing for the specific tunnel(s), an
>>>>> individual
>>>> command is better.
>>>>
>>>> Drivers MAY filter out some tunneling types when negotiating this feat=
ure.
>>>> Do you think it would be better for us to add a separate command? I
>>>> don't see tools like ethtool that can configure specific tunnels in us=
erspace.
>>>>
>>> The reason I proposed different command is, Let's say we have only
>>> single command.
>>> Rss config command has many other fields unrelated to the inner hash.
>> Yes. For inner hash, fields such as indirection table are irrelevant.
>>
> Right.
>
>>> Hence, to enable inner hash, the driver needs to supply the exact same =
value
>> for unrelated fields to the same value.
>>> And device needs to compare it with the old value and maintain some sor=
t of
>> cache to derive that nothing changes from the previous hash config, henc=
e,
>> ignore hw configuration for rss.
>>> This mechanism slows down the command for the unrelated task.
>> Totally agree.
>>
>>> Hence, I am considering a separate command that would be simple for the
>> device and driver to implement.
>>
>> I agree with you. Do you want me to do it in this patch, or should we do=
 it in
>> another patch?
>>
> It should be in this patch set because enablement in the device is linked=
 to this capability exposed in this patch.
>
>  From patch split point of view,
>
> Patch-1 to introduce the feature bit, description, and link to CVQ depend=
ency.
> Patch-2 for its link in virtio_net_config structure and description.
> Patch-3 for new command touching control VQ pieces.

Yes, and you seem to have missed my other replies in this thread:), I=20
rephrased it here:
virtio_net_hash_config seems to be reusable, as the v9 patch is doing,=20
why don't we re-use it?
The reason I can think of is to not expand the virtio_net_hash_config=20
structure, just set a separate
structure for VIRTIO_NET_F_HASH_TUNNEL and include hash_tunnel_types?

Thanks.
>
> We can always squash the patch to single when/if it is hard to understand=
 in multiple patches.


This publicly archived list offers a means to provide input to the
OASIS Virtual I/O Device (VIRTIO) TC.

In order to verify user consent to the Feedback License terms and
to minimize spam in the list archive, subscription is required
before posting.

Subscribe: virtio-comment-subscribe@lists.oasis-open.org
Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
List help: virtio-comment-help@lists.oasis-open.org
List archive: https://lists.oasis-open.org/archives/virtio-comment/
Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lis=
ts
Committee: https://www.oasis-open.org/committees/virtio/
Join OASIS: https://www.oasis-open.org/join/

