Return-Path: <hengqi@linux.alibaba.com>
Message-ID: <65f968f0-36b7-7fe6-8a18-e590d7657baa@linux.alibaba.com>
Date: Wed, 22 Feb 2023 23:21:16 +0800
MIME-Version: 1.0
Subject: Re: [virtio-dev] RE: [PATCH v6] virtio-net: support the virtqueue
 coalescing moderation
References: <20230222032148.106406-1-hengqi@linux.alibaba.com>
 <PH0PR12MB5481457D8EE37A39198592C1DCAA9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230222012200-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548187AB51323E8687FFC708DCAA9@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <PH0PR12MB548187AB51323E8687FFC708DCAA9@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: Parav Pandit <parav@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, Alvaro Karsz <alvaro.karsz@solid-run.com>, David Edmondson <david.edmondson@oracle.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Cornelia Huck <cohuck@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi, Parav.

在 2023/2/22 下午10:28, Parav Pandit 写道:
>
>> From: Michael S. Tsirkin <mst@redhat.com>
>> Sent: Wednesday, February 22, 2023 1:29 AM
>>> MMIO device has vq_index register too.
>>> I am inclined to vq_index given current state of spec
>> [mst@tuck virtio]$ git grep vq_index|wc -l
>> 0
>>
> :)
>
> Grep for "virtqueue index".
> We need to change "virtqueue index" to "virtqueue number".


Yes, this is more unified in the spec. :)

This version is closed, please help review the v7 version [1] if you 
have time.

[1] https://lists.oasis-open.org/archives/virtio-dev/202302/msg00520.html

Thanks very much for your response!

>
>>> and new additions by Michael.
>> admin vq? Good point, I will change that to vqn too.
> Ok. sounds good.
>
>>> Michael,
>>> Can you please suggest vqn or vq_index to use?
>> [mst@tuck virtio]$ git grep vqn|wc -l
>> 5
>>
>> I'd say vqn has precedent.
>>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

