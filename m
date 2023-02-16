Return-Path: <hengqi@linux.alibaba.com>
Message-ID: <e7056681-25fc-eada-8628-1810ca94c155@linux.alibaba.com>
Date: Thu, 16 Feb 2023 22:19:05 +0800
MIME-Version: 1.0
Subject: Re: [virtio-comment] RE: [virtio-dev] RE: [virtio-comment] [PATCH v8]
 virtio-net: support inner header hash
References: <20230208090836.74355-1-hengqi@linux.alibaba.com>
 <0f73e9c7-5080-d01c-0f63-dd23942fa71b@linux.alibaba.com>
 <PH0PR12MB54817EAF86DF11B9FB0DCB8EDCDD9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <f26d28f7-d213-28d7-df7f-513c1d39930f@linux.alibaba.com>
 <PH0PR12MB54817FE1744032D13AAFB74EDCA09@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <PH0PR12MB54817FE1744032D13AAFB74EDCA09@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: Parav Pandit <parav@nvidia.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Yuri Benditovich <yuri.benditovich@daynix.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>



在 2023/2/16 下午9:25, Parav Pandit 写道:
>
>> From: Heng Qi <hengqi@linux.alibaba.com>
>> Sent: Thursday, February 16, 2023 1:58 AM
>>
>> I'm really okay with this, the tunnel type seems to help the software driver do
>> more things in the future, for example, the driver may not want to use the
>> outer hash value when forwarding packets. But if there is really no practical
>> scenario for the driver at present, then let us hide the tunnel types in the
>> \field{hash_report}?
>>
> Right. Lets omit hash_report in virtio_net_hdr.

Ok. Will do.

>   
>>> What is valuable is to have a VNI already identified and coming to the driver,
>> like a hash value.
>>
>> This is too specific to a certain tunnel protocol, not every protocol has
>> corresponding VNI information.
>>
> True. I was considering a hash of the generic outer header through which it can reach to generic tunnel.
> But it is a very different feature of its own, so yes, better to split and proceed with this to improve inner hash.

It's a good idea, but I think the current work needs to focus on the 
inner header hash, and the more general features we can continue in 
other work.

Thanks.



