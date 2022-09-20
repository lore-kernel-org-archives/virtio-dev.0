Return-Path: <virtio-dev-return-9960-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3D1B0986458
	for <virtio-dev@lists.oasis-open.org>; Tue, 20 Sep 2022 13:46:13 +0000 (UTC)
Message-ID: <0a97bab1-2d5e-073b-e439-4e6e745dad52@nvidia.com>
Date: Tue, 20 Sep 2022 21:45:55 +0800
References: <20220901021038.84751-1-gavinl@nvidia.com>
 <76fca691-aff5-ad9e-6228-0377e2890a05@nvidia.com>
 <20220919083552.60449589@kernel.org>
From: Gavin Li <gavinl@nvidia.com>
In-Reply-To: <20220919083552.60449589@kernel.org>
MIME-Version: 1.0
Subject: Re: [virtio-dev] [PATCH v5 0/2] Improve virtio performance for 9k mtu
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Jakub Kicinski <kuba@kernel.org>
Cc: stephen@networkplumber.org, davem@davemloft.net, jesse.brandeburg@intel.com, sridhar.samudrala@intel.com, jasowang@redhat.com, loseweigh@gmail.com, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, gavi@nvidia.com, parav@nvidia.com
List-ID: <virtio-dev.lists.oasis-open.org>


On 9/19/2022 11:35 PM, Jakub Kicinski wrote:
> External email: Use caution opening links or attachments
>
>
> On Wed, 7 Sep 2022 10:57:01 +0800 Gavin Li wrote:
>> Hi Dave/Jakub, Michael,
>>
>> Sorry for the previous email formatting.
>> Should this 2-patch series merge through virtio tree or netdev tree?
> netdev seems appropriate, sorry for the delay

Sorry for the non-text format issue of last mail.

v6 is posted at link 
https://lore.kernel.org/netdev/20220914144911.56422-1-gavinl@nvidia.com/
Would you please review it?


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

