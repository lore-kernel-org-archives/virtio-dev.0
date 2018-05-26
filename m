Return-Path: virtio-dev-return-4193-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id CB8A05818F4C
	for <virtio-dev@lists.oasis-open.org>; Sat, 26 May 2018 12:22:42 -0700 (PDT)
References: <1527180917-39737-1-git-send-email-sridhar.samudrala@intel.com>
 <1527180917-39737-3-git-send-email-sridhar.samudrala@intel.com>
 <20180525153456.28b44c7c@xeon-e3>
 <c0be8e44-34f8-0e46-3a51-7ce869a5d351@intel.com>
 <20180525162839.3c7028e1@xeon-e3>
 <cffe3c66-ae31-ae13-27ce-55f9be2d53d4@intel.com>
 <20180526075156.GC4288@nanopsycho.orion>
From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Message-ID: <821ec0bc-c6c6-467d-cc9c-448ce081b02f@intel.com>
Date: Sat, 26 May 2018 12:22:28 -0700
MIME-Version: 1.0
In-Reply-To: <20180526075156.GC4288@nanopsycho.orion>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH net-next v12 2/5] netvsc: refactor notifier/event handling
 code to use the failover framework
To: Jiri Pirko <jiri@resnulli.us>
Cc: Stephen Hemminger <stephen@networkplumber.org>, mst@redhat.com, davem@davemloft.net, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, kubakici@wp.pl, jasowang@redhat.com, loseweigh@gmail.com, aaron.f.brown@intel.com, anjali.singhai@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

'On 5/26/2018 12:51 AM, Jiri Pirko wrote:
> Sat, May 26, 2018 at 09:22:18AM CEST, sridhar.samudrala@intel.com wrote:
>> On 5/25/2018 4:28 PM, Stephen Hemminger wrote:
>>> On Fri, 25 May 2018 16:11:47 -0700
>>> "Samudrala, Sridhar" <sridhar.samudrala@intel.com> wrote:
>>>
>>>> On 5/25/2018 3:34 PM, Stephen Hemminger wrote:
>>>>> On Thu, 24 May 2018 09:55:14 -0700
>>>>> Sridhar Samudrala <sridhar.samudrala@intel.com> wrote:
>>>>>> --- a/drivers/net/hyperv/Kconfig
>>>>>> +++ b/drivers/net/hyperv/Kconfig
>>>>>> @@ -2,5 +2,6 @@ config HYPERV_NET
>>>>>>     	tristate "Microsoft Hyper-V virtual network driver"
>>>>>>     	depends on HYPERV
>>>>>>     	select UCS2_STRING
>>>>>> +	select FAILOVER
>>>>> When I take a working kernel config, add the patches then do
>>>>> make oldconfig
>>>>>
>>>>> It is not autoselecting FAILOVER, it prompts me for it. This means
>>>>> if user says no then a non-working netvsc device is made.
>>>> I see
>>>>       Generic failover module (FAILOVER) [M/y/?] (NEW)
>>>>
>>>> So the user is given an option to either build as a Module or part of the
>>>> kernel. 'n' is not an option.
>>> With most libraries there is no prompt at all.
>> Not sure what you meant by this.
>> Without any patches applied, i had a .config file with HYPERV_NET configured
>> as a module.
>> Then after applying the first 2 patches in this series, i did a
>>   make oldconfig
>> and i see the above prompt.
>>
>> Are you saying that on some distros, 'make oldconfig creates a .config
>> file without any prompt and FAILOVER is not getting selected even when HYPERV_NET
>> is enabled?
>>
>>
> Well the thing is that for a user, it makes no sense to select
> "FAILOVER" by hand. It is a lib, so it should be only select it by a
> user. It has no sense to have it turned on by hand - no lib user.
> You can achieve that by simply removing "help" for the Kconfig
> item. Same thing for "NET_FAILOVER".

I played around with the CONFIG options and i see that FAILOVER options do
get selected correctly when virtio-net/netvsc are enabled.  Even if the FAILOVER
is turned off by the user before the hyperv-net/virtio-net patches are applied,
it gets selected automatically when hyperv-net/virtio-net patches are applied and
enabled in config.

If we don't want to allow the user to see these options, then i think we need to
remove them from Kconfig files.  Just removing "help" doesn't seem to make a
difference.

Can we address any config issues (i don't see any at this point) as a bug-fix on top
of this series?



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

