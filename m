Return-Path: <jasowang@redhat.com>
Message-ID: <64ca5b76-2940-f009-4e69-104661d828ca@redhat.com>
Date: Fri, 28 Jan 2022 12:35:47 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 2/5] Introduce
 VIRTIO_F_ADMIN_VQ_INDIRECT_DESC/VIRTIO_F_ADMIN_VQ_IN_ORDER
References: <PH0PR12MB54818033A0BD96EA9493C51ADC589@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220118011731-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54816DB30F23511266B8F35EDC589@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220118014737-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481B99E351B624A27378BC5DC589@PH0PR12MB5481.namprd12.prod.outlook.com>
 <15063a94-85ae-fd1a-6ff1-458a039d1def@redhat.com>
 <PH0PR12MB5481D5BD8BB8CFDEFA218D2FDC599@PH0PR12MB5481.namprd12.prod.outlook.com>
 <56a7bf50-509d-f9d5-df78-858cb1b156c1@redhat.com>
 <PH0PR12MB548182EBE025ECA44124A11DDC5F9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <b6fc2eb9-8023-29c6-ce59-6a9f3810d057@nvidia.com>
 <20220125070649-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481B051AFA529851B0167B3DC209@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <PH0PR12MB5481B051AFA529851B0167B3DC209@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: Parav Pandit <parav@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: "cohuck@redhat.com" <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>, "stefanha@redhat.com" <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>


在 2022/1/26 下午9:29, Parav Pandit 写道:
>> From: Michael S. Tsirkin <mst@redhat.com>
>> Sent: Tuesday, January 25, 2022 5:39 PM
>>> So you do agree that managing a managed (create/destroy/setup/etc...)
>>> will be done using the AQ of the managing device ?
>> I think Jason asked that the management commands are split from the queue
>> itself, such that they can be implemented in more ways down the road.
> Admin commands involved DMA. And also multiple commands can be enqueued to the device.
> I don't see any other construct in the spec other than vq that enables driver and device to achieve both.
> Hence split the queue from command is very weird for spec to do.


I'd say it really depends on the transport. Not all transport uses 
registers. There could be transport that:

1) use DMA (e.g CCW)

2) use transport specific queue

3) doesn't need DMA at all (e.g using shared memory like virtio-rproc)

Having another VQ seems redundant.

Thanks


>
> A recent addition like virtio_fs_req didn’t adopt this suggestion.
>
> If we just want to split so that admin commands can be transported via non admin queue, we should remove below line from spec:
>
> "The Admin command set defines the commands that may be issued only to the admin virtqueue"
>
> And reword it as below,
>
> The Admin command set defines the commands to manipulate various features/attributes of another device within the same group...
> When VIRTIO_F_ADMIN_VQ feature is negotiated, admin commands must be transported through the admin queue.
>
> Looks ok?

