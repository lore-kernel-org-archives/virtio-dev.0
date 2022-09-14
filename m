Return-Path: <virtio-dev-return-9945-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 069639865A3
	for <virtio-dev@lists.oasis-open.org>; Wed, 14 Sep 2022 03:34:52 +0000 (UTC)
Message-ID: <845a54fa-149e-e170-5662-1bc04515af19@redhat.com>
Date: Wed, 14 Sep 2022 11:34:43 +0800
MIME-Version: 1.0
References: <1660642495-104002-1-git-send-email-hengqi@linux.alibaba.com>
 <CACGkMEuy2m7PagJwccx3QSnasuJpnF0MtKn-1MQSJ3sPLjvjew@mail.gmail.com>
 <d091f3e4-3d69-f0ba-5c6b-d3e05ca6b88c@linux.alibaba.com>
 <20220904162337-mutt-send-email-mst@kernel.org>
 <9843a9ea-07b9-7966-efa0-debf0467902a@linux.alibaba.com>
 <20220909044129-mutt-send-email-mst@kernel.org>
 <1662727108.301059-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <1662727108.301059-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [virtio-dev] Re: [PATCH v7] virtio_net: support split header
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, kangjie.xu@linux.alibaba.com, Heng Qi <hengqi@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>


=E5=9C=A8 2022/9/9 20:38, Xuan Zhuo =E5=86=99=E9=81=93:
> On Fri, 9 Sep 2022 07:15:02 -0400, "Michael S. Tsirkin" <mst@redhat.com> =
wrote:
>> On Fri, Sep 09, 2022 at 03:41:54PM +0800, Heng Qi wrote:
>>>
>>> =E5=9C=A8 2022/9/5 =E4=B8=8A=E5=8D=884:27, Michael S. Tsirkin =E5=86=99=
=E9=81=93:
>>>> On Fri, Sep 02, 2022 at 03:36:25PM +0800, Heng Qi wrote:
>>>>> We need to clarify that the purpose of header splitting is to make al=
l payloads
>>>>> can be independently in a page, which is beneficial for the zerocopy
>>>>> implemented by the upper layer.
>>>> absolutely, pls add motivation.
>>>>
>>>>> If the driver does not enforce that the buffers submitted to the rece=
iveq MUST
>>>>> be composed of at least two descriptors, then header splitting will b=
ecome meaningless,
>>>>> or the VIRTIO_NET_F_SPLIT_TRANSPORT_HEADER feature should not be nego=
tiated at this time.
>>>>>
>>>>>
>>>>> Thanks.
>>>>>
>>>>>
>>>> This seems very narrow and unecessarily wasteful of descriptors.
>>>> What is wrong in this:
>>>>
>>>> <header>...<padding>... <beginning of page><data>
>>>>
>>>> seems to achieve the goal of data in a separate page without
>>>> using extra descriptors.
>>>>
>>>> thus my proposal to replace the requirement of a separate
>>>> descriptor with an offset of data from beginning of
>>>> buffer that driver sets.
>>>>
>>>>
>>> We have carefully considered your suggestion.
>>>
>>> We refer to spec v7 and earlier as scheme A for short. Review scheme A
>>> below:
>>>
>>> | receive buffer |
>>>
>>> | 0th descriptor | 1th descriptor |
>>>
>>> | virtnet hdr | mac | ip hdr | tcp hdr|<-- hold -->| payload |
>>>
>>> We use a buffer plus a separate page when allocating the receive
>>>
>>> buffer. In this way, we can ensure that all payloads can be
>>>
>>> independently in a page, which is very beneficial for the zerocopy
>>>
>>> implemented by the upper layer.
>>>
>>> scheme A better solves the problem of headroom, tailroom and memory was=
te,
>>> but as you said, this solution relies on descriptor chain.
>>>
>>> Our rethinking approach is no longer based on or using descriptor chain=
.
>>>
>>> We refer to your proposed offset-based scheme as scheme B:
>>>
>>> As you suggested, scheme B gives the device a buffer, using offset to
>>> indicate where to place the payload like this:
>>>
>>> <header>...<padding>... <beginning of page><data>
>>>
>>> But how to apply for this buffer? Since we want the payload to be place=
d on
>>> a separate page, the method we consider is to directly apply to the dri=
ver
>>> for two pages of contiguous memory.
>>>
>>> Then the beginning of this contiguous memory is used to store the headr=
oom,
>>> and the contiguous memory after the headroom is directly handed over to=
 the
>>> device. similar to the following:
>>>
>>> <------------------------------------------ receive buffer(2 pages)
>>> ----------------------------------------->
>>>
>>> <<---------------------------------- first page
>>> -----------------------------------><---- second page ------>>
>>>
>>> <<Driver reserved, the later part is filled><vheader><transport
>>> header>..<padding>..<beginning of page><data>>
>>>
>>> Based on your previous suggestion, we also considered another new schem=
e C.
>>>
>>> This scheme is implemented based on mergeable buffer, filling a separat=
e
>>> page each time.
>>>
>>> If the split header is negotiated and the packet can be successfully sp=
lit
>>> by the device, the device needs to find at least two buffers, namely tw=
o
>>> pages, one for the virtio-net header and transport header, and the othe=
r for
>>> the data payload. Like the following:
>>>
>>> | receive buffer1(page) | receive buffer2 (page) |
>>>
>>> | virtnet hdr | mac | ip hdr | tcp hdr|<-- hold -->| payload |
>>>
>>> At the same time, if XDP is considered, then the device needs to add
>>> headroom at the beginning of receive buffer1 when receiving packets, so=
 that
>>> the driver can process programs similar to XDP. In order to solve this
>>> problem, can scheme C introduce an offset, which requires the device to
>>> write data from the offset position to receive buffer1, like the follow=
ing:
>>>
>>> | receive buffer (page) | receive buffer (page) |
>>>
>>> | <-- offset(hold) --> | virtnet hdr | mac | ip hdr | tcp hdr|<-- hold =
-->|
>>> payload |
>> And in fact, B and C both use an offset now, right?
>
> B: offset is used to get the position to place the payload.
> C: The offset is used to reserve some space for the device, which the dri=
ver can
>     use as headroom.
>
>     In order to make the payload page-aligned, we can only hand over the =
entire
>     page to the device, so we cannot reserve some headroom in advance.


For C, it might be better to do some tweak since mergeable buffer=20
doesn't forbid using a descriptor chain as a single buffer.

So if it's a descriptor chain we got back the method A by placing the=20
payload in a dedicated buffer. If it's not placing the payload in an=20
adjacent buffer.

Thanks


>
>>> Then we simply compare the advantages and disadvantages of scheme A(spe=
c
>>> v7), scheme B (offset buffer(2 pages)) and scheme C (based on mergeable
>>> buffer):
>>>
>>> 1. desc chain:
>>>
>>> - A depends on desciptor chain; - B, C do not depend on desciptor chain=
.
>>>
>>> 2. page alloc
>>>
>>> - B fills two consecutive pages, which causes a great waste of memory f=
or
>>> small packages such as arp; - C fills a single page, slightly better th=
an B.
>>>
>>> 3. Memory waste:
>>>
>>> - The memory waste of scheme A is mainly the 0th descriptor that is ski=
pped
>>> by the device;
>> there's also the cost of the indirect buffer since that is used when
>> there is a chain.
> Yes
>
>
>>> - When scheme B and scheme C successfully split the header,
>>> there is a huge waste of the first page, but the first page can be quic=
kly
>>> released by copying.
>>>
>>> 4. headroom
>>>
>>> - The headrooms of plan A and plan B are reserved; - Scheme C requires =
the
>>> driver to set off to let the device skip off when using receive buffer1=
.
>>>
>>> 5. tailroom
>>>
>>> - When splitting the header, skb usually needs to store each independen=
t
>>> page in the non-linear data area based on shinfo. - The tailroom of sch=
eme A
>>> is reserved by itself; - Scheme B requires the driver to set the reserv=
ed
>>> padding area for the first receive buffer(2 pages) to use shinfo when t=
he
>>> split header is not successfully executed; - Scheme C requires the driv=
er to
>>> set max_len for the first receive buffer(page).
>>>
>>>
>>> Which plan do you prefer?
>> I think either both B and C depending on the mergeable buffers flag,
>> or just one of these two.
> If I understand correctly, B does not depend on mergeable, while C must d=
epend
> on mergeable.
>
> Thanks.
>
>
>>> ---
>>>
>>> Thanks.
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

