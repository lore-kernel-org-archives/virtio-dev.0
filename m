Return-Path: <jasowang@redhat.com>
Message-ID: <ecf230fb-1260-d0c9-5b38-4f9698518e0b@redhat.com>
Date: Tue, 6 Sep 2022 13:56:01 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v7] virtio_net: support split header
References: <1660642495-104002-1-git-send-email-hengqi@linux.alibaba.com>
 <CACGkMEuy2m7PagJwccx3QSnasuJpnF0MtKn-1MQSJ3sPLjvjew@mail.gmail.com>
 <d091f3e4-3d69-f0ba-5c6b-d3e05ca6b88c@linux.alibaba.com>
 <20220904162337-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220904162337-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: "Michael S. Tsirkin" <mst@redhat.com>, Heng Qi <hengqi@linux.alibaba.com>
Cc: virtio-dev@lists.oasis-open.org, Cornelia Huck <cohuck@redhat.com>, xuanzhuo@linux.alibaba.com, kangjie.xu@linux.alibaba.com
List-ID: <virtio-dev.lists.oasis-open.org>


在 2022/9/5 04:27, Michael S. Tsirkin 写道:
> On Fri, Sep 02, 2022 at 03:36:25PM +0800, Heng Qi wrote:
>> We need to clarify that the purpose of header splitting is to make all payloads
>> can be independently in a page, which is beneficial for the zerocopy
>> implemented by the upper layer.
> absolutely, pls add motivation.
>
>> If the driver does not enforce that the buffers submitted to the receiveq MUST
>> be composed of at least two descriptors, then header splitting will become meaningless,
>> or the VIRTIO_NET_F_SPLIT_TRANSPORT_HEADER feature should not be negotiated at this time.
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


Not sure I get this, does it mean the header and padding are placed at 
the tail of the previous adjacent page?

Thanks


>
>

