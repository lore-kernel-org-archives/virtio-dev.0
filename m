Return-Path: <virtio-comment-return-3947-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Message-ID: <7016ad45-654c-de71-59c5-5bf93225196c@linux.alibaba.com>
Date: Thu, 2 Feb 2023 13:06:21 +0800
MIME-Version: 1.0
References: <20220920032824.GA125047@h68b04307.sqa.eu95>
 <1663903426.8765974-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEsmqngS-HYPzzV8b9dmv95=W6dJebAa=asXGmo7VEAnoA@mail.gmail.com>
 <20220923013341-mutt-send-email-mst@kernel.org>
 <619af5b3-4c38-955f-0f7f-f351f5a9527e@redhat.com>
 <20220928093530-mutt-send-email-mst@kernel.org>
 <CACGkMEsKHBo+tgJrADif9y5qLF-OHoK7pO6YvQBa-edjjPwVJQ@mail.gmail.com>
 <20220929022523-mutt-send-email-mst@kernel.org>
 <CACGkMEvmVJVCG-W-phG_JkVnEy_EpKRgG38LexTzStn7dADztw@mail.gmail.com>
 <20221020081601.GA48712@h68b04307.sqa.eu95>
 <dd25da2a-a035-4437-967c-b59c09140ebc.hengqi@linux.alibaba.com>
 <PH0PR12MB54814AE695F25009B7B9C038DCD09@PH0PR12MB5481.namprd12.prod.outlook.com>
 <f13450f0-854d-123f-eb0b-b8bded5670b8@linux.alibaba.com>
 <PH0PR12MB54811F110E8854161A900BF7DCD69@PH0PR12MB5481.namprd12.prod.outlook.com>
 <4177d301-f9a0-0707-9e70-9109ec40378d@linux.alibaba.com>
 <PH0PR12MB5481FE4A979391E911FC2051DCD69@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <PH0PR12MB5481FE4A979391E911FC2051DCD69@PH0PR12MB5481.namprd12.prod.outlook.com>
Subject: [virtio-comment] =?UTF-8?B?UmU6IFt2aXJ0aW8tZGV2XSBSRTogW3ZpcnRpby1jb21tZW50XSDlm54=?=
 =?UTF-8?B?5aSN77yaW3ZpcnRpby1kZXZdIFtQQVRDSCB2OF0gdmlydGlvX25ldDogc3VwcG9y?=
 =?UTF-8?Q?t_for_split_transport_header?=
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Parav Pandit <parav@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Kangjie Xu <kangjie.xu@linux.alibaba.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtio-dev <virtio-dev@lists.oasis-open.org>, virtio-comment <virtio-comment@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>



=E5=9C=A8 2023/2/2 =E4=B8=8B=E5=8D=8812:20, Parav Pandit =E5=86=99=E9=81=93=
:
>
>> From: Heng Qi <hengqi@linux.alibaba.com>
>> Sent: Wednesday, February 1, 2023 10:45 PM
>>
>> =E5=9C=A8 2023/2/2 =E4=B8=8A=E5=8D=889:45, Parav Pandit =E5=86=99=E9=81=
=93:
>>>> From: Heng Qi <hengqi@linux.alibaba.com>
>>>> Sent: Wednesday, February 1, 2023 8:18 AM
>>> [..]
>>>
>>>>> Response....
>>>>>
>>>>> Page alignment requirements should not come from the virtio spec.
>>>>> There are a variety of cases which may use non page aligned data buff=
ers.
>>>>> a. A kernel only consumer can use it who doesn't have mmap requiremen=
t.
>>>>> b. A VQ accessible directly in user space may also use it without
>>>>> page
>>>> alignment.
>>>>> c. A system with 64k page size, page aligned memory has a fair
>>>>> amount of
>>>> wastage.
>>>>> d. iouring example you pointed, also has non page aligned use.
>>>>>
>>>>> So let the driver deal with alignment restriction, outside of the vir=
tio spec.
>>>>>
>>>>> In header data split cases, data buffers utilization is more
>>>>> important than the
>>>> tiny header buffers utilization.
>>>>> How about if the headers do not interfere with the data buffers?
>>>>>
>>>>> In other words, say a given RQ has optionally linked to a circular
>>>>> queue of
>>>> header buffers.
>>>>> All header buffers are of the same size, supplied one time.
>>>>> This header size and circular q address is configured one time at RQ
>>>>> creation
>>>> time.
>>>>> With this the device doesn't need to process header buffer size
>>>>> every single
>>>> incoming packet.
>>>>> Data buffers can continue as chains or merged mode can be supported.
>>>>> When the received packet=E2=80=99s header cannot fit, it continues as=
-is in
>>>>> the data
>>>> buffer.
>>>>> Virtio net hdr as suggest indicates usage of hdr buffer offset/index.
>>>> This is a good direction, thanks a lot for your comments, the new
>>>> split header method might look like this:
>>>> When allocating the receive queue, allocate a circular queue storing
>>>> the header buffers at the driver layer, which is shared with the
>>>> device, and set the length of the header buffer. The length of the
>>>> circular queue is the same as the length of the descriptor table.
>>>>
>>>> 1. When a data packet is successfully split, all virtio-net-hdr +
>>>> transport headers are stored in the header buffer, and
>>>> VIRTIO_NET_HDR_F_SPLIT_HEADER is set in the flag of virtio-net-hdr;
>>>> If the header buffer is not enough to store virtio- net-hdr +
>>>> transport header, then roll back, that is, not split the packet;
>>>>
>>> Right.
>>>
>>>> 2. When a packet is not split by the device for some reason,
>>>> virtio-net-hdr is placed in the header buffer, and the transport
>>>> header and payload are placed in the buffer. At this time, xdp is not
>>>> supported, because xdp requires the transport header to be placed in t=
he
>> first buffer, the header buffer.
>>> I do not understand why the xdp is not supported in this case.
>>> Isn't it the case today, where xdp_prepare_buff() gets the buffer with =
offset
>> after the net hdr?
>>> In the above case you mentioned xdp gets to used the packet buffer wher=
e
>> pkt hdr + data is located.
>>
>> The head buffer and data buffer are not continuous, but xdp requires the=
 data
>> memory in the linear area to be continuous. When virtio-net-hdr is store=
d in
>> the header buffer, and the transport header and payload are in the data =
buffer,
>> the requirements of xdp are not met at this time. Many xdp kern programs=
 and
>> xdp core layers also require the transport header to be placed in the li=
near
>> region.
>>
> Lets keep aside a virtio net hdr for a moment.
> Pkt HDR (L2 to L4) is in buffer_type_1.
> Pkt Data (after L4) is in buffer_type_2.
> They are not contiguous.
> In this case XDP doesn=E2=80=99t work.
> Did I understand you correctly?

It seems not. The case you mentioned is currently supported in virtio-net:
https://lore.kernel.org/all/20230114082229.62143-1-hengqi@linux.alibaba.com=
/=20
.

I just mean:
Virtio-net-hdr is in buffer_type_1.
Pkt hdr (L2 to L4) + pkt data (after L4) are in buffer_type_2.

They are not contiguous and xdp doesn't work.

> If so, there is ongoing work to support multi buffer XDP.
> We should look forward to have that support it in the future in OS.
>  =20
>>>> Then why
>>>> not start storing packets from the header buffer? If this is the
>>>> case, imagine a
>>>> situation: If all small packets are put into the header buffers, and
>>>> virtio net driver receives packets according to the descriptor table
>>>> and used_ring, but the data buffers are empty at this time, then can't=
 seem
>> to continue?
>>> In future when such mode is extended, vq mechanism will be extended to
>> handle desc table and used ring anyway.
>>
>> Yes, for example, we can support the descriptor table to allow placing a=
 buffer
>> with a length of 0 as a placeholder to deal with the above problem.
>>
>>>> It seems that
>>>> the operation of circular queue has become a producer-consumer
>>>> problem again.
>>>>
>>> I didn=E2=80=99t follow.
>>>
>>> I tend to imagine that driver consumed meta data (vnet_hdr and used
>>> ring) should be placed together in one buffer and
>> Sorry, I didn't understand what you said, can you explain more clearly?
>> Do you mean that
>> virtio-ner-hdr and some other metadata are placed in a buffer? How are u=
sed
>> ring and virtio-net-hdr placed together in one buffer?
>>
> We can extend virtio net used ring which will consist of,
> struct virtio_net_used_ring_entry {
> =09struct virtio_net_hdr hdr; /* with padding bytes */
> =09struct used_elem elem[];
> };
> struct virtio_net_used_ring {
> =09struct virtio_net_used_ring_entry ring[];
> };
>
> With above layering is nit.
> Driver metadata stays in driver level such as something like above struct=
.
> HDR buffer can have constant size head room too, which is cache line alig=
ned without any kind of padding.
> No need to mix driver internal meta data (vnet_hdr and packet hdr) togeth=
er.
>
> This may find its use even without HDS, where one received packets, metad=
ata is found adjacent in single cache line.

Yes, this seems to be a good solution, but we should proceed step by=20
step, such as pushing the
split header first, and then try to change the virtio core later.

Thanks.

>> Thanks.
>>
>>> Actual packet header and data belongs to other buffer.
>>> This way there is clear layering of ownership. But before we explore th=
is
>> option, lets understand your above point.
>>>> 3. The meaning of hdr_len in virtio-net-hdr:
>>>>    =C2=A0=C2=A0=C2=A0=C2=A0 i. When splitting successfully: hdr_len re=
presents the effective length of
>> the
>>>> header in the header buffer.
>>>>    =C2=A0=C2=A0=C2=A0=C2=A0 ii. On unsuccessful split: hdr_len is 0.
>>>>
>>>> What do you think of this plan? Or is there a better one?
>>>>
>>>> Thanks.
>>>>
>>>>> This method has few benefits on perf and buffer efficiency as below.
>>>>> 1. Data buffers can be directly mapped at best utilization 2. Device
>>>>> doesn't need to match up per packet header sizes and descriptor sizes=
,
>>>>> efficient for device to implement 3. No need to keep reposting the he=
ader
>>>> buffers, only its tail index to be updated.
>>>>> Directly gives 50% cycle reduction on buffer traversing on driver sid=
e on rx
>>>> path.
>>>>> 4. Ability to share this header buffer queue among multiple RQs if ne=
eded.
>>>>> 5. In the future there may be an extension to place tiny whole packet=
s that
>>>> can fit in the header buffer also to contain the rest of the data.
>>>>> 6. Device can always fall back to place packet header in data buffer
>>>>> when header buffer is not available or smaller than newer protocol 7.
>>>>> Because the header buffer comes virtually contiguous memory and not
>>>>> intermixed with data buffers, there isn't small per header allocation=
s 8. Also
>>>> works in both chained and merged mode 9. memory utilization for an RQ =
of
>>>> depth 256, with 4K page size for data buffers =3D 1M, and hdr buffer p=
er
>> packet =3D
>>>> 256 * 128bytes =3D only 3% of the data buffer.
>>>>> So, in worst case when no packet uses the header buffers wastage is o=
nly
>> 3%.
>>>>> When high number of packets larger than 4K uses the header buffer, sa=
y
>> 8K
>>>> packets, header buffer utilization is at 50%. So, wastage is only 1.5%=
.
>>>>> At 1500 mtu merged buffer data buffer size, it is also < 10% of hdr b=
uffer
>>>> memory.
>>>>> All 3 cases are very manageable range of buffer utilization.
>>>>>
>>>>> Crafting and modifying the feature bits from your v7 version and virt=
io net
>>>> header is not difficult to get there if we like this approach.


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

