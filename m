Return-Path: <hengqi@linux.alibaba.com>
Message-ID: <1043d395-a816-55ed-f7b7-9f3ba5d3bb65@linux.alibaba.com>
Date: Sat, 18 Feb 2023 00:43:55 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v3] virtio-net: support the virtqueue coalescing
 moderation
References: <20230216144301.57728-1-hengqi@linux.alibaba.com>
 <20230216111552-mutt-send-email-mst@kernel.org>
 <20230217052404.GA114259@h68b04307.sqa.eu95>
 <PH0PR12MB5481424E467400B9B206D77FDCA19@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <PH0PR12MB5481424E467400B9B206D77FDCA19@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: Parav Pandit <parav@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Yuri Benditovich <yuri.benditovich@daynix.com>, Jason Wang <jasowang@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>


在 2023/2/17 下午9:50, Parav Pandit 写道:
>
>> From: Heng Qi <hengqi@linux.alibaba.com>
>> Sent: Friday, February 17, 2023 12:24 AM
>> I think there are two kinds of sequences:
>> #Seq1:
>> 1. vq is disabled (vq params are reset to max_packets = 0, max_usecs = 0) 2.
>> VQ_SET command arrives with max_packets=10, max_usecs = 8 3. vq is enabled
>> (vq params are max_packets = 0, max_usecs = 0) After #3 is done, vq params
>> should be max_packets = 0, max_usecs = 0, because the device cannot apply
>> parameters when vq is disabled.
>> Other reason is that parameters determined based on the previous traffic
>> information before vq is re-enabled, and it is not applicable now.
>  From dev point of view, above is not a valid sequence.
> VQ is the object whose lifecycle (create/delete/query/modify) is triggered by the driver.
> So step 2 cannot happen before step 3.
> If driver does that, driver should get error code INVALID_VQ on step 2.
>

Yes, This example is not appropriate.  The driver must not make any 
requests on vq while it is being reset,

unless the reset of vq has been completed.


>> #Seq1:
>> 1. vq is disabled (vq params are reset to max_packets = 0, max_usecs = 0) 2. vq
>> is enabled (vq params are max_packets = 0, max_usecs = 0) 3. VQ_SET
>> command arrives with max_packets=10, max_usecs = 8 After 3 is done, vq
>> params should be max_packets = 10, max_usecs = 8
>>
>> Thanks.
>>
>>>> +
>>>> +A device MAY NOT set the coalescing parameter to the exact same
>>>> +value as the one passed in by a driver. For example, the value of
>> \field{max_packets} set by the driver is 15, but the device MAY store a value
>> that is a power of 2, that is, 16.
>>>> +
>>>>   A device SHOULD NOT send used buffer notifications to the driver, if the
>> notifications are suppressed as explained in \ref{sec:Basic Facilities of a Virtio
>> Device / Virtqueues / Used Buffer Notification Suppression}, even if the
>> coalescing counters expired.
>>>>   Upon reset, a device MUST initialize all coalescing parameters to 0.
>>>> --
>>>> 2.19.1.6.gb485710b

