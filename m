Return-Path: virtio-dev-return-4067-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 81D5E1CB80EE
	for <virtio-dev@lists.oasis-open.org>; Fri, 11 May 2018 08:43:27 -0700 (PDT)
References: <1525731046-10989-1-git-send-email-sridhar.samudrala@intel.com>
 <1525731046-10989-3-git-send-email-sridhar.samudrala@intel.com>
 <460f3d8f-b2ec-2118-e296-03f4f9655c5a@infradead.org>
From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Message-ID: <9bbc5be8-71e2-5aab-ce18-32eb8a612f21@intel.com>
Date: Fri, 11 May 2018 08:43:16 -0700
MIME-Version: 1.0
In-Reply-To: <460f3d8f-b2ec-2118-e296-03f4f9655c5a@infradead.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH net-next v10 2/4] net: Introduce generic failover module
To: Randy Dunlap <rdunlap@infradead.org>, mst@redhat.com, stephen@networkplumber.org, davem@davemloft.net, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, kubakici@wp.pl, jasowang@redhat.com, loseweigh@gmail.com, jiri@resnulli.us, aaron.f.brown@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 5/7/2018 3:39 PM, Randy Dunlap wrote:
> Hi,
>
> On 05/07/2018 03:10 PM, Sridhar Samudrala wrote:
>> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
>> ---
>>   MAINTAINERS                |    7 +
>>   include/linux/netdevice.h  |   16 +
>>   include/net/net_failover.h |   52 +++
>>   net/Kconfig                |   10 +
>>   net/core/Makefile          |    1 +
>>   net/core/net_failover.c    | 1044 ++++++++++++++++++++++++++++++++++++++++++++
>>   6 files changed, 1130 insertions(+)
>>   create mode 100644 include/net/net_failover.h
>>   create mode 100644 net/core/net_failover.c
>
>> diff --git a/net/Kconfig b/net/Kconfig
>> index b62089fb1332..0540856676de 100644
>> --- a/net/Kconfig
>> +++ b/net/Kconfig
>> @@ -429,6 +429,16 @@ config MAY_USE_DEVLINK
>>   config PAGE_POOL
>>          bool
>>   
>> +config NET_FAILOVER
>> +	tristate "Failover interface"
>> +	default m
> Need some justification for default m (as opposed to n).

default n should be fine.  It will get selected automatically when virtio_net or
netvsc are enabled. will fix in the next revision.


>
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

