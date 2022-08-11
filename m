Return-Path: <virtio-dev-return-9763-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id ADFEE9863EF
	for <virtio-dev@lists.oasis-open.org>; Thu, 11 Aug 2022 00:26:29 +0000 (UTC)
Message-ID: <c96bf0cd-3e87-a75c-be92-f42945caf01b@oracle.com>
Date: Wed, 10 Aug 2022 17:26:09 -0700
References: <06bf192a-d310-943e-bbe1-1c53108db892@oracle.com>
 <PH0PR12MB54819B1419EF8D7AF306EE2CDC629@PH0PR12MB5481.namprd12.prod.outlook.com>
 <3b87cc07-525a-6753-6224-37ebc2503e65@oracle.com>
 <PH0PR12MB54810721EF477C778FDE3B98DC629@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220809173542-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481101A8414FAAB5FCAC537DC629@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220809182306-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54816FFF167D3EA3EF5F075FDC629@PH0PR12MB5481.namprd12.prod.outlook.com>
 <62920bd4-1070-a91a-baf8-659009e9f590@oracle.com>
 <20220810021320-mutt-send-email-mst@kernel.org>
 <20220810021427-mutt-send-email-mst@kernel.org>
From: Si-Wei Liu <si-wei.liu@oracle.com>
In-Reply-To: <20220810021427-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Subject: Re: [virtio-dev] [PATCH] virtio-net: use mtu size as buffer length
 for big packets
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>, Jason Wang <jasowang@redhat.com>, Gavin Li <gavinl@nvidia.com>, "Hemminger, Stephen" <stephen@networkplumber.org>, davem <davem@davemloft.net>, virtualization <virtualization@lists.linux-foundation.org>, Virtio-Dev <virtio-dev@lists.oasis-open.org>, "jesse.brandeburg@intel.com" <jesse.brandeburg@intel.com>, "alexander.h.duyck@intel.com" <alexander.h.duyck@intel.com>, "kubakici@wp.pl" <kubakici@wp.pl>, "sridhar.samudrala@intel.com" <sridhar.samudrala@intel.com>, "loseweigh@gmail.com" <loseweigh@gmail.com>, Gavi Teitz <gavi@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>



On 8/9/2022 11:15 PM, Michael S. Tsirkin wrote:
> On Wed, Aug 10, 2022 at 02:14:07AM -0400, Michael S. Tsirkin wrote:
>> On Tue, Aug 09, 2022 at 04:24:23PM -0700, Si-Wei Liu wrote:
>>>
>>> On 8/9/2022 3:49 PM, Parav Pandit wrote:
>>>>> From: Michael S. Tsirkin <mst@redhat.com>
>>>>> Sent: Tuesday, August 9, 2022 6:26 PM
>>>>> To: Parav Pandit <parav@nvidia.com>
>>>>> Cc: Si-Wei Liu <si-wei.liu@oracle.com>; Jason Wang
>>>>> <jasowang@redhat.com>; Gavin Li <gavinl@nvidia.com>; Hemminger,
>>>>> Stephen <stephen@networkplumber.org>; davem
>>>>> <davem@davemloft.net>; virtualization <virtualization@lists.linux-
>>>>> foundation.org>; Virtio-Dev <virtio-dev@lists.oasis-open.org>;
>>>>> jesse.brandeburg@intel.com; alexander.h.duyck@intel.com;
>>>>> kubakici@wp.pl; sridhar.samudrala@intel.com; loseweigh@gmail.com; Gav=
i
>>>>> Teitz <gavi@nvidia.com>
>>>>> Subject: Re: [virtio-dev] [PATCH] virtio-net: use mtu size as buffer =
length for
>>>>> big packets
>>>>>
>>>>> On Tue, Aug 09, 2022 at 09:49:03PM +0000, Parav Pandit wrote:
>>>>>>> From: Michael S. Tsirkin <mst@redhat.com>
>>>>>>> Sent: Tuesday, August 9, 2022 5:38 PM
>>>>>> [..]
>>>>>>>>> I think virtio-net driver doesn't differentiate MTU and MRU, in
>>>>>>>>> which case the receive buffer will be reduced to fit the 1500B
>>>>>>>>> payload size when mtu is lowered down to 1500 from 9000.
>>>>>>>> How? Driver reduced the mXu to 1500, say it is improved to post
>>>>>>>> buffers of
>>>>>>> 1500 bytes.
>>>>>>>> Device doesn't know about it because mtu in config space is RO fie=
ld.
>>>>>>>> Device keep dropping 9K packets because buffers posted are 1500
>>>>> bytes.
>>>>>>>> This is because device follows the spec " The device MUST NOT pass
>>>>>>> received packets that exceed mtu".
>>>>>>>
>>>>>>>
>>>>>>> The "mtu" here is the device config field, which is
>>>>>>>
>>>>>>>           /* Default maximum transmit unit advice */
>>>>>>>
>>>>>> It is the field from struct virtio_net_config.mtu. right?
>>>>>> This is RO field for driver.
>>>>>>
>>>>>>> there is no guarantee device will not get a bigger packet.
>>>>>> Right. That is what I also hinted.
>>>>>> Hence, allocating buffers worth upto mtu is safer.
>>>>> yes
>>>>>
>>>>>> When user overrides it, driver can be further optimized to honor suc=
h new
>>>>> value on rx buffer posting.
>>>>>
>>>>> no, not without a feature bit promising device won't get wedged.
>>>>>
>>>> I mean to say as_it_stands today, driver can decide to post smaller bu=
ffers with larger mtu.
>>>> Why device should be affected with it?
>>>> ( I am not proposing such weird configuration but asking for sake of c=
orrectness).
>>> I am also confused how the device can be wedged in this case.
>> Yea sorry. I misunderstood the code. It can't be.
> Here's a problem as I see it. Let's say we reduce mtu.
> Small buffers are added. Now we increase mtu.
> Device will drop all packets until small buffers are consumed.
>
> Should we make this depend on the vq reset ability maybe?
To be honest I am not sure if worth it, very few user changes MTU on the=20
fly with traffic ongoing, for the most cases I've seen users just change=20
it only once in deployment time. Even if they change it on the fly they=20
may need to be aware of the consequence and implication of loss of=20
packets. In real devices, mtu change could end up with link status=20
change and in that case there's usually no guarantee arrived=C2=A0 packet=
=20
will be kept during the window.

While I could understand this would slightly introduce regression on=20
functionality, as the worst case for packet loss if device dropping=20
packets, it would be all smaller buffers of the full queue size. For=20
correctness and elegance I don't mind introducing specific feature that=20
changes MTU, or even relying on vq_reset is fine. device_reset would be=20
too overwhelmed for this special use case IMHO.

-Siwei

>
>> --=20
>> MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

