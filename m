Return-Path: <virtio-dev-return-9937-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4C664986584
	for <virtio-dev@lists.oasis-open.org>; Fri,  9 Sep 2022 07:42:08 +0000 (UTC)
Message-ID: <9843a9ea-07b9-7966-efa0-debf0467902a@linux.alibaba.com>
Date: Fri, 9 Sep 2022 15:41:54 +0800
MIME-Version: 1.0
References: <1660642495-104002-1-git-send-email-hengqi@linux.alibaba.com>
 <CACGkMEuy2m7PagJwccx3QSnasuJpnF0MtKn-1MQSJ3sPLjvjew@mail.gmail.com>
 <d091f3e4-3d69-f0ba-5c6b-d3e05ca6b88c@linux.alibaba.com>
 <20220904162337-mutt-send-email-mst@kernel.org>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <20220904162337-mutt-send-email-mst@kernel.org>
Subject: [virtio-dev] Re: [PATCH v7] virtio_net: support split header
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, kangjie.xu@linux.alibaba.com
List-ID: <virtio-dev.lists.oasis-open.org>



=E5=9C=A8 2022/9/5 =E4=B8=8A=E5=8D=884:27, Michael S. Tsirkin =E5=86=99=E9=
=81=93:
> On Fri, Sep 02, 2022 at 03:36:25PM +0800, Heng Qi wrote:
>> We need to clarify that the purpose of header splitting is to make all p=
ayloads
>> can be independently in a page, which is beneficial for the zerocopy
>> implemented by the upper layer.
> absolutely, pls add motivation.
>
>> If the driver does not enforce that the buffers submitted to the receive=
q MUST
>> be composed of at least two descriptors, then header splitting will beco=
me meaningless,
>> or the VIRTIO_NET_F_SPLIT_TRANSPORT_HEADER feature should not be negotia=
ted at this time.
>>
>>
>> Thanks.
>>
>>
>
> This seems very narrow and unecessarily wasteful of descriptors.
> What is wrong in this:
>
> <header>...<padding>... <beginning of page><data>
>
> seems to achieve the goal of data in a separate page without
> using extra descriptors.
>
> thus my proposal to replace the requirement of a separate
> descriptor with an offset of data from beginning of
> buffer that driver sets.
>
>
We have carefully considered your suggestion.

We refer to spec v7 and earlier as scheme A for short. Review scheme A=20
below:

| receive buffer |

| 0th descriptor | 1th descriptor |

| virtnet hdr | mac | ip hdr | tcp hdr|<-- hold -->| payload |

We use a buffer plus a separate page when allocating the receive

buffer. In this way, we can ensure that all payloads can be

independently in a page, which is very beneficial for the zerocopy

implemented by the upper layer.

scheme A better solves the problem of headroom, tailroom and memory=20
waste, but as you said, this solution relies on descriptor chain.

Our rethinking approach is no longer based on or using descriptor chain.

We refer to your proposed offset-based scheme as scheme B:

As you suggested, scheme B gives the device a buffer, using offset to=20
indicate where to place the payload like this:

<header>...<padding>... <beginning of page><data>

But how to apply for this buffer? Since we want the payload to be placed=20
on a separate page, the method we consider is to directly apply to the=20
driver for two pages of contiguous memory.

Then the beginning of this contiguous memory is used to store the=20
headroom, and the contiguous memory after the headroom is directly=20
handed over to the device. similar to the following:

<------------------------------------------ receive buffer(2 pages)=20
----------------------------------------->

<<---------------------------------- first page=20
-----------------------------------><---- second page ------>>

<<Driver reserved, the later part is filled><vheader><transport=20
header>..<padding>..<beginning of page><data>>

Based on your previous suggestion, we also considered another new scheme C.

This scheme is implemented based on mergeable buffer, filling a separate=20
page each time.

If the split header is negotiated and the packet can be successfully=20
split by the device, the device needs to find at least two buffers,=20
namely two pages, one for the virtio-net header and transport header,=20
and the other for the data payload. Like the following:

| receive buffer1(page) | receive buffer2 (page) |

| virtnet hdr | mac | ip hdr | tcp hdr|<-- hold -->| payload |

At the same time, if XDP is considered, then the device needs to add=20
headroom at the beginning of receive buffer1 when receiving packets, so=20
that the driver can process programs similar to XDP. In order to solve=20
this problem, can scheme C introduce an offset, which requires the=20
device to write data from the offset position to receive buffer1, like=20
the following:

| receive buffer (page) | receive buffer (page) |

| <-- offset(hold) --> | virtnet hdr | mac | ip hdr | tcp hdr|<-- hold=20
-->| payload |

Then we simply compare the advantages and disadvantages of scheme A(spec=20
v7), scheme B (offset buffer(2 pages)) and scheme C (based on mergeable=20
buffer):

1. desc chain:

- A depends on desciptor chain; - B, C do not depend on desciptor chain.

2. page alloc

- B fills two consecutive pages, which causes a great waste of memory=20
for small packages such as arp; - C fills a single page, slightly better=20
than B.

3. Memory waste:

- The memory waste of scheme A is mainly the 0th descriptor that is=20
skipped by the device; - When scheme B and scheme C successfully split=20
the header, there is a huge waste of the first page, but the first page=20
can be quickly released by copying.

4. headroom

- The headrooms of plan A and plan B are reserved; - Scheme C requires=20
the driver to set off to let the device skip off when using receive buffer1=
.

5. tailroom

- When splitting the header, skb usually needs to store each independent=20
page in the non-linear data area based on shinfo. - The tailroom of=20
scheme A is reserved by itself; - Scheme B requires the driver to set=20
the reserved padding area for the first receive buffer(2 pages) to use=20
shinfo when the split header is not successfully executed; - Scheme C=20
requires the driver to set max_len for the first receive buffer(page).


Which plan do you prefer?

---

Thanks.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

