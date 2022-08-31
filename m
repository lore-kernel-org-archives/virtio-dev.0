Return-Path: <virtio-dev-return-9868-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5FFE9986449
	for <virtio-dev@lists.oasis-open.org>; Wed, 31 Aug 2022 13:10:39 +0000 (UTC)
Message-ID: <8f60e5ab-dfba-0e02-5d7f-ebd6bebf2572@nvidia.com>
Date: Wed, 31 Aug 2022 21:10:23 +0800
References: <20220831130541.81217-1-gavinl@nvidia.com>
 <20220831130541.81217-2-gavinl@nvidia.com>
 <20220831090721-mutt-send-email-mst@kernel.org>
From: Gavin Li <gavinl@nvidia.com>
In-Reply-To: <20220831090721-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Subject: Re: [virtio-dev] Re: [PATCH RESEND v4 1/2] virtio-net: introduce and
 use helper function for guest gso support checks
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: stephen@networkplumber.org, davem@davemloft.net, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, kuba@kernel.org, sridhar.samudrala@intel.com, jasowang@redhat.com, loseweigh@gmail.com, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, gavi@nvidia.com, parav@nvidia.com, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Si-Wei Liu <si-wei.liu@oracle.com>
List-ID: <virtio-dev.lists.oasis-open.org>


On 8/31/2022 9:08 PM, Michael S. Tsirkin wrote:
> External email: Use caution opening links or attachments
>
>
> On Wed, Aug 31, 2022 at 04:05:40PM +0300, Gavin Li wrote:
>> Probe routine is already several hundred lines.
>> Use helper function for guest gso support check.
>>
>> Signed-off-by: Gavin Li <gavinl@nvidia.com>
>> Reviewed-by: Gavi Teitz <gavi@nvidia.com>
>> Reviewed-by: Parav Pandit <parav@nvidia.com>
>> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>> Reviewed-by: Si-Wei Liu <si-wei.liu@oracle.com>
>> ---
>> changelog:
>> v1->v2
>> - Add new patch
>> ---
>>   drivers/net/virtio_net.c | 13 +++++++++----
>>   1 file changed, 9 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index 9cce7dec7366..e1904877d461 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -3682,6 +3682,14 @@ static int virtnet_validate(struct virtio_device *vdev)
>>        return 0;
>>   }
>>
>> +static bool virtnet_check_guest_gso(const struct virtnet_info *vi)
>> +{
>> +     return (virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_TSO4) ||
>> +             virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_TSO6) ||
>> +             virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_ECN) ||
>> +             virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_UFO));
>> +}
>> +
> fine but can we please drop the outer ()?
> they are necessary with if but not with return.
ACK
>
>
>>   static int virtnet_probe(struct virtio_device *vdev)
>>   {
>>        int i, err = -ENOMEM;
>> @@ -3777,10 +3785,7 @@ static int virtnet_probe(struct virtio_device *vdev)
>>        spin_lock_init(&vi->refill_lock);
>>
>>        /* If we can receive ANY GSO packets, we must allocate large ones. */
>> -     if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO4) ||
>> -         virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO6) ||
>> -         virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_ECN) ||
>> -         virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_UFO))
>> +     if (virtnet_check_guest_gso(vi))
>>                vi->big_packets = true;
>>
>>        if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF))
>> --
>> 2.31.1
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

