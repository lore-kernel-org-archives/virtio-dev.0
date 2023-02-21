Return-Path: <hengqi@linux.alibaba.com>
Message-ID: <99460ec7-4afa-7c4a-ff8a-72acf53a05da@linux.alibaba.com>
Date: Tue, 21 Feb 2023 20:17:24 +0800
MIME-Version: 1.0
Subject: Re: [virtio-dev] Re: [PATCH v5] virtio-net: support the virtqueue
 coalescing moderation
References: <20230221083852.32764-1-hengqi@linux.alibaba.com>
 <m25ybvdyl7.fsf@oracle.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <m25ybvdyl7.fsf@oracle.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: David Edmondson <david.edmondson@oracle.com>
Cc: virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org, "Michael S . Tsirkin" <mst@redhat.com>, Parav Pandit <parav@nvidia.com>, Alvaro Karsz <alvaro.karsz@solid-run.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Cornelia Huck <cohuck@redhat.com>, Jason Wang <jasowang@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>


在 2023/2/21 下午7:48, David Edmondson 写道:
> On Tuesday, 2023-02-21 at 16:38:52 +08, Heng Qi wrote:
>> ...
>> +A device MAY set the coalescing parameter to a value close to a power of 2 value.
> What is this about?
>
> If it is intended to indicate that a device may use a value different to
> that passed by the driver, more text to describe that would be

Yes. How about adding the following explanation to the "Operation" 
subparagraph?
"
When a device receives the VIRTIO_NET_CTRL_NOTF_COAL commands to set an 
coalescing parameter, it may set the parameter to a value close to a 
power of 2. For example:
If the VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET command with \field{max_usecs} = 
7 is received, the device may set \field{max_usecs} = 8 for a given 
enabled virtqueue.
"

Thanks.

> useful. If not, what does it mean?

