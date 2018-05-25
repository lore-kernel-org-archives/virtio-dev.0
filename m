Return-Path: virtio-dev-return-4191-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 0715A58191AB
	for <virtio-dev@lists.oasis-open.org>; Fri, 25 May 2018 16:11:58 -0700 (PDT)
References: <1527180917-39737-1-git-send-email-sridhar.samudrala@intel.com>
 <1527180917-39737-3-git-send-email-sridhar.samudrala@intel.com>
 <20180525153456.28b44c7c@xeon-e3>
From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Message-ID: <c0be8e44-34f8-0e46-3a51-7ce869a5d351@intel.com>
Date: Fri, 25 May 2018 16:11:47 -0700
MIME-Version: 1.0
In-Reply-To: <20180525153456.28b44c7c@xeon-e3>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH net-next v12 2/5] netvsc: refactor notifier/event handling
 code to use the failover framework
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: mst@redhat.com, davem@davemloft.net, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, kubakici@wp.pl, jasowang@redhat.com, loseweigh@gmail.com, jiri@resnulli.us, aaron.f.brown@intel.com, anjali.singhai@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>


On 5/25/2018 3:34 PM, Stephen Hemminger wrote:
> On Thu, 24 May 2018 09:55:14 -0700
> Sridhar Samudrala <sridhar.samudrala@intel.com> wrote:
>
>> --- a/drivers/net/hyperv/Kconfig
>> +++ b/drivers/net/hyperv/Kconfig
>> @@ -2,5 +2,6 @@ config HYPERV_NET
>>   	tristate "Microsoft Hyper-V virtual network driver"
>>   	depends on HYPERV
>>   	select UCS2_STRING
>> +	select FAILOVER
> When I take a working kernel config, add the patches then do
> make oldconfig
>
> It is not autoselecting FAILOVER, it prompts me for it. This means
> if user says no then a non-working netvsc device is made.

I see
    Generic failover module (FAILOVER) [M/y/?] (NEW)

So the user is given an option to either build as a Module or part of the
kernel. 'n' is not an option.



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

