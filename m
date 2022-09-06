Return-Path: <virtio-dev-return-9894-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CE040986373
	for <virtio-dev@lists.oasis-open.org>; Tue,  6 Sep 2022 05:47:58 +0000 (UTC)
Message-ID: <5e31dde2-804c-c49b-67bd-fa9c8907f27a@redhat.com>
Date: Tue, 6 Sep 2022 13:47:48 +0800
MIME-Version: 1.0
References: <1660642495-104002-1-git-send-email-hengqi@linux.alibaba.com>
 <CACGkMEuy2m7PagJwccx3QSnasuJpnF0MtKn-1MQSJ3sPLjvjew@mail.gmail.com>
 <20220902023546-mutt-send-email-mst@kernel.org>
 <94937aaa-e3c0-74fe-290c-59884c6eb9a4@linux.alibaba.com>
 <20220904162809-mutt-send-email-mst@kernel.org>
 <1662364338.205864-1-xuanzhuo@linux.alibaba.com>
 <3b7a4b68-b889-8432-d421-b591178bb7cf@linux.alibaba.com>
 <1662371007.8074908-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <1662371007.8074908-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [virtio-dev] Re: [PATCH v7] virtio_net: support split header
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>


=E5=9C=A8 2022/9/5 17:43, Xuan Zhuo =E5=86=99=E9=81=93:
> On Mon, 5 Sep 2022 16:37:57 +0800, Heng Qi <hengqi@linux.alibaba.com> wro=
te:
>> =E5=9C=A8 2022/9/5 =E4=B8=8B=E5=8D=883:52, Xuan Zhuo =E5=86=99=E9=81=93:
>>> On Sun, 4 Sep 2022 16:31:59 -0400, "Michael S. Tsirkin"<mst@redhat.com>=
  wrote:
>>>> On Fri, Sep 02, 2022 at 04:58:16PM +0800, Heng Qi wrote:
>>>>> When VIRTIO_NET_F_SPLIT_TRANSPORT_HEADER is negotiated,
>>>>> the driver requires that the buffers submitted to receiveq
>>>>> MUST be composed of at least two descriptors,
>>>>> which means that each buffer the device gets is a descriptor chain,
>>>>> even if the device does not split the header for some packets.
>>>>>
>>>>> To store packet in the descriptor chain without header splitting
>>>>> by the device, the device MUST start with the first descriptor of
>>>>> the descriptor chain to store the packet, and MUST NOT set the
>>>>> VIRTIO_NET_HDR_F_SPLIT_TRANSPORT_HEADER bit in \field{flags}.
>>>>>
>>>>> Thanks.
>>>> Descriptor chains will hurt performance badly.
>>> I understand the reasons for the performance impact here are:
>>> 1. Two buffers are used
>>> 2. One buffer occupies two descs
>>>
>>> This is the same as my understanding in the case of mergeable. We also =
need to
>>> pack the packets into two buffers, and a packet will eventually occupy =
two
>>> descs.
>>>
>>>
>>>> How about simply making this feature depend on mergeable buffers?
>>>> Then we have a separate buffer for the header and
>>>> this works cleanly.
>>> Under mergeable, each buffer is independent, and the split header requi=
res two
>>> unequal descs.
>>>
>>> If we implement it based on mergeable, then consider the scenario of tc=
p
>>> zerocopy, when we fill receive vq, each buffer is an separate page, and=
 if we use an
>>> separate buffer to save the header, then this is a waste, we may
>>> have to copy at the driver layer.
>>>
>>> @Qi Do you think there will be other problems with this approach?
>>>
>>> Thanks.
>>>
>> When we think about specs, we shouldn't be too distracted by the impleme=
ntation.
>>
>> But when we did think about this, suppose the driver fills by page based=
 on
>> mergeable mode. in order to use the xdp program, the driver usually take=
s
>> the beginning of a single page as the headroom, and fills the rest of th=
e page
>> into the virtqueue. Therefore, the empty buffer obtained by the
>> device is always smaller than a page when we implement split header
>> based on this mode, that is, the data load finally obtained by the drive=
r
>> is offset from the beginning of the page. This does not enjoy the benefi=
ts of zero copy.


I don't understand this issue fully, but if it's a driver behavior, we=20
can change.


>>
>> At the same time, since the header is always only more than 100 bytes,
>> the page occupied by the header is a waste of the buffer.
>
> Yeah that reminds me that merge doesn't feel like it handles this very we=
ll.
>
> The essence is that the two buffers used by the split header are differen=
t.
>
> Desc Chain is used to bind a small buffer desc and a page desc. I didn't =
think
> of a better way to deal with this problem.


I remember that XDP supports multi-buffer now, can it be used here?

Thanks


>
> Thanks.
>
>
>> Thanks.
>>
>>
>>
>>
>>
>>
>>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

