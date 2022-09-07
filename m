Return-Path: <virtio-dev-return-9930-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 01EE1986538
	for <virtio-dev@lists.oasis-open.org>; Wed,  7 Sep 2022 22:58:26 +0000 (UTC)
Message-ID: <010b795e-7f90-0ea6-e4d6-88a706c160a6@oracle.com>
Date: Wed, 7 Sep 2022 15:57:33 -0700
References: <20220907101335-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481D19E1E5DA11B2BD067CFDC419@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220907103420-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481066A18907753997A6F0CDC419@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220907141447-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481C6E39AB31AB445C714A1DC419@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220907151026-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54811F1234CB7822F47DD1B9DC419@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220907152156-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481291080EBEC54C82A5641DC419@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220907153425-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54815E541D435DDC9339CA02DC419@PH0PR12MB5481.namprd12.prod.outlook.com>
 <8d80bb05-2d01-9046-6642-3f74b59cc830@oracle.com>
 <PH0PR12MB548125D85533125828CE8454DC419@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
In-Reply-To: <PH0PR12MB548125D85533125828CE8454DC419@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
Subject: Re: [virtio-dev] RE: [PATCH v5 2/2] virtio-net: use mtu size as
 buffer length for big packets
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Parav Pandit <parav@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Gavin Li <gavinl@nvidia.com>, "stephen@networkplumber.org" <stephen@networkplumber.org>, "davem@davemloft.net" <davem@davemloft.net>, "jesse.brandeburg@intel.com" <jesse.brandeburg@intel.com>, "kuba@kernel.org" <kuba@kernel.org>, "sridhar.samudrala@intel.com" <sridhar.samudrala@intel.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "loseweigh@gmail.com" <loseweigh@gmail.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Gavi Teitz <gavi@nvidia.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>



On 9/7/2022 3:11 PM, Parav Pandit wrote:
>> From: Si-Wei Liu <si-wei.liu@oracle.com>
>> Sent: Wednesday, September 7, 2022 5:40 PM
>>
>>
>> On 9/7/2022 12:51 PM, Parav Pandit wrote:
>>>> And I'd like commit log to include results of perf testing
>>>> - with indirect feature on
>>> Which device do you suggest using for this test?
>>>
>> You may use software vhost-net backend with and without fix to compare.
>> Since this driver fix effectively lowers down the buffer size for the
>> indirect=3Don case as well,
> Do you have sample example for this?

ip link add link ens300f1 name macvtap1 address $mac type macvtap mode=20
bridge
ifindex1=3D`cat /sys/class/net/macvtap1/ifindex`

qemu-system-x86_64 \
 =C2=A0 ...
 =C2=A0 -netdev type=3Dtap,id=3Dhnet1,vhost=3Don,fd=3D25,vhostfd=3D27 \
 =C2=A0 -device=20
virtio-net-pci,netdev=3Dhnet1,id=3Dvnet1,mac=3D$mac,host_mtu=3D9000,mrg_rxb=
uf=3Doff,guest_tso4=3Doff,guest_tso6=3Doff,guest_ecn=3Doff,guest_ufo=3Doff,=
indirect_desc=3Don=20
\
 =C2=A0 25<>/dev/tap${ifindex1} 27<>/dev/vhost-net

indirect_desc=3Don is not actually required as it's on by default if not=20
specified.

-Siwei

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

