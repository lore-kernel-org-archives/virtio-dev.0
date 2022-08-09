Return-Path: <virtio-dev-return-9721-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CF1A8986332
	for <virtio-dev@lists.oasis-open.org>; Tue,  9 Aug 2022 19:09:10 +0000 (UTC)
Message-ID: <3b87cc07-525a-6753-6224-37ebc2503e65@oracle.com>
Date: Tue, 9 Aug 2022 12:08:55 -0700
References: <20220802044548.9031-1-gavinl@nvidia.com>
 <973632c6-3606-01fb-c584-a6d4774647d8@oracle.com>
 <c4c42174-dcf0-b1e1-a483-0447fbdb1c48@nvidia.com>
 <c173ba21-ad86-6360-5db7-df81de0b0350@oracle.com>
 <465efc4c-f41f-494e-8f2d-a87deae90c5d@nvidia.com>
 <CACGkMEsVG_62yJ5nGmp5ufF_xiEJk2TezQz-QFftF8ezKYLB8A@mail.gmail.com>
 <06bf192a-d310-943e-bbe1-1c53108db892@oracle.com>
 <PH0PR12MB54819B1419EF8D7AF306EE2CDC629@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
In-Reply-To: <PH0PR12MB54819B1419EF8D7AF306EE2CDC629@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
Subject: Re: [virtio-dev] [PATCH] virtio-net: use mtu size as buffer length
 for big packets
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Parav Pandit <parav@nvidia.com>, Jason Wang <jasowang@redhat.com>, Gavin Li <gavinl@nvidia.com>
Cc: mst <mst@redhat.com>, "Hemminger, Stephen" <stephen@networkplumber.org>, davem <davem@davemloft.net>, virtualization <virtualization@lists.linux-foundation.org>, Virtio-Dev <virtio-dev@lists.oasis-open.org>, "jesse.brandeburg@intel.com" <jesse.brandeburg@intel.com>, "alexander.h.duyck@intel.com" <alexander.h.duyck@intel.com>, "kubakici@wp.pl" <kubakici@wp.pl>, "sridhar.samudrala@intel.com" <sridhar.samudrala@intel.com>, "loseweigh@gmail.com" <loseweigh@gmail.com>, Gavi Teitz <gavi@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>



On 8/9/2022 11:42 AM, Parav Pandit wrote:
>> From: Si-Wei Liu <si-wei.liu@oracle.com>
>> Sent: Tuesday, August 9, 2022 2:39 PM
>> Currently it is not. Not a single patch nor this patch, but the context for the
>> eventual goal is to allow XDP on a MTU=9000 link when guest users
>> intentionally lower down MTU to 1500.
> Which application benefit by having asymmetry by lowering mtu to 1500 to send packets but want to receive 9K packets?
I think virtio-net driver doesn't differentiate MTU and MRU, in which 
case the receive buffer will be reduced to fit the 1500B payload size 
when mtu is lowered down to 1500 from 9000. What I actually tried to say 
is that as our current use case (software virtio) supports XDP 
applications with 1500 guest mtu and mergeable buffer enabled on a 9000 
MTU link, technically it's a legitimate use case regardless of mergeable 
buffer capability. Otherwise it's considered to be a usability 
regression in driver software side when migrating (not live migrating) 
existing user to vdpa, due to lack of hardware implementation of certain 
relevant feature.

Thanks,
-Siwei

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

