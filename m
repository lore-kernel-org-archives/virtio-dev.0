Return-Path: <virtio-dev-return-9829-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D16A9986450
	for <virtio-dev@lists.oasis-open.org>; Tue, 23 Aug 2022 10:19:27 +0000 (UTC)
Message-ID: <dd6fbeeb-7fc5-3668-3776-68618ff49fb4@nvidia.com>
Date: Tue, 23 Aug 2022 18:19:12 +0800
References: <20220819144904.3332-1-gavinl@nvidia.com>
 <PH0PR12MB548134ABC8B055298834050EDC709@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Gavin Li <gavinl@nvidia.com>
In-Reply-To: <PH0PR12MB548134ABC8B055298834050EDC709@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH v2 0/2] Improve virtio performance for 9k mtu
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Parav Pandit <parav@nvidia.com>, "mst@redhat.com" <mst@redhat.com>, "stephen@networkplumber.org" <stephen@networkplumber.org>, "davem@davemloft.net" <davem@davemloft.net>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "jesse.brandeburg@intel.com" <jesse.brandeburg@intel.com>, "alexander.h.duyck@intel.com" <alexander.h.duyck@intel.com>, "kubakici@wp.pl" <kubakici@wp.pl>, "sridhar.samudrala@intel.com" <sridhar.samudrala@intel.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "loseweigh@gmail.com" <loseweigh@gmail.com>
Cc: Gavi Teitz <gavi@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>


On 8/23/2022 10:56 AM, Parav Pandit wrote:
>> From: Gavin Li <gavinl@nvidia.com>
>> Sent: Friday, August 19, 2022 10:49 AM
>>
>> This small series contains two patches that improves virtio netdevice
>> performance for 9K mtu when GRO/ guest TSO is disabled.
>>
>> Gavin Li (2):
>>    virtio-net: introduce and use helper function for guest gso support
>>      checks
>>    virtio-net: use mtu size as buffer length for big packets
>>
>>   drivers/net/virtio_net.c | 52 +++++++++++++++++++++++++++-------------
>>   1 file changed, 36 insertions(+), 16 deletions(-)
> This driver change is in drivers/net.
> Patches must include, netdev@vger.kernel.org to this series.
> I do not know if they are merged through MST tree or netdev tree.
>
> You might want to wait for a day or two, and if you don't receive comments, you should resend V2 by including netdev@vger.kernel.org.
ACK

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

