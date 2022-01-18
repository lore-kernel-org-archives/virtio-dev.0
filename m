Return-Path: <jasowang@redhat.com>
Message-ID: <631d8512-6a28-a714-4a71-dded3ef9ce3c@redhat.com>
Date: Tue, 18 Jan 2022 10:18:29 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 4/5] virtio-net: add support for VIRTIO_F_ADMIN_VQ
References: <20220113145103.26894-1-mgurtovoy@nvidia.com>
 <20220113145103.26894-5-mgurtovoy@nvidia.com>
 <20220113125409-mutt-send-email-mst@kernel.org>
 <38c7b7a3-e0d8-d242-8723-11cabbbcb47d@nvidia.com>
 <PH0PR12MB54812553884E5791B8A69DE8DC579@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220117171459-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220117171459-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: "Michael S. Tsirkin" <mst@redhat.com>, Parav Pandit <parav@nvidia.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>, "stefanha@redhat.com" <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>


在 2022/1/18 上午6:22, Michael S. Tsirkin 写道:
> On Mon, Jan 17, 2022 at 02:07:51PM +0000, Parav Pandit wrote:
>>> From: Max Gurtovoy <mgurtovoy@nvidia.com>
>>> Sent: Sunday, January 16, 2022 3:18 PM
>>>
>>>
>>> On 1/13/2022 7:56 PM, Michael S. Tsirkin wrote:
>>>> On Thu, Jan 13, 2022 at 04:51:02PM +0200, Max Gurtovoy wrote:
>>>>> Set the relevant index in case of VIRTIO_F_ADMIN_VQ negotiation.
>>>>>
>>>>> Reviewed-by: Parav Pandit <parav@nvidia.com>
>>>>> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
>>>> So admin VQ # is only known when all features are negotiated.
>>> No. The driver should see if VIRTIO_NET_F_CTRL_VQ/VIRTIO_F_ADMIN_VQ
>>> are set by the device.
>>>
>>> Negotiation is not a must.
>>>
>>> Lets say CTRL_VQ is supported by the device and driver A would like to use it
>>> and driver B wouldn't like to use it - in both cases the admiq VQ # would be 2N
>>> + 1.
>>>
>>>> Which is quite annoying if hypervisor wants to partition things e.g.
>>>> handling admin q in process and handling vqs by an external process or
>>>> by hardware.
>>>>
>>>> I think we can allow devices to set the VQ# for the admin queue
>>>> instead. Would that work?
>> Number of MSI-X configuration and number of VQs config are two different,
>
> I was talking about the number of the VQ used for admin commands. Not
> about the number of VQs.
>
>> though it has strong correlation.
>> Configuring number of queues seems a very device specific configuration (even though num_queues is generic field in struct virtio_pci_common_cfg).
>>
>> So num VQ configuration is a different command likely combined with other device specific config such as mac or rss or others.
> I was not talking about that at all, but since you mention that,
> to me it looks like something that many device types can support.
> It's not necessarily rss related, MQ config would benefit too,
> so I am not sure why not have a command for controlling number
> of queues. Looks like it could quite be generic.
>
> Since current guests only support two modes: a vector
> per VQ and a shared vector for all VQs, it follows that
> it is important when configuring vectors per VF to also configure
> VQs per VF. This makes me wonder whether ability to configure
> vectors per VF in isolation without ability to configure or
> at least query VQs per VF even has value.


So I had some thought in the past, it looks to me we need a generic 
provision interface that contains all the necessary attributes:

1) #queues
2) device_features
3) #msi_vectors
4) device specific configurations

It could be either an admin virtqueue interface[1] or a dedicated 
capability[2], (the latter seems easier).

Thanks

[1] 
https://lists.oasis-open.org/archives/virtio-comment/202108/msg00025.html
[2] 
https://lists.oasis-open.org/archives/virtio-comment/202108/msg00136.html


>
>

