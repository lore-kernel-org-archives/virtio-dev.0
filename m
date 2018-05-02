Return-Path: virtio-dev-return-4030-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 9779F5819145
	for <virtio-dev@lists.oasis-open.org>; Wed,  2 May 2018 08:34:58 -0700 (PDT)
References: <1524848820-42258-1-git-send-email-sridhar.samudrala@intel.com>
 <1524848820-42258-4-git-send-email-sridhar.samudrala@intel.com>
 <20180428094205.GM5632@nanopsycho.orion>
 <638e52c7-64db-9d8d-7530-f6b000d3e292@intel.com>
 <20180430072034.GH23854@nanopsycho.orion>
 <9c6f055c-c665-0601-3973-bce74d72544b@intel.com>
 <20180502075021.GC19250@nanopsycho>
From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Message-ID: <c94ce6a9-6f36-675c-cf5b-414454fc2244@intel.com>
Date: Wed, 2 May 2018 08:34:44 -0700
MIME-Version: 1.0
In-Reply-To: <20180502075021.GC19250@nanopsycho>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH net-next v9 3/4] virtio_net: Extend virtio to use VF
 datapath when available
To: Jiri Pirko <jiri@resnulli.us>
Cc: mst@redhat.com, stephen@networkplumber.org, davem@davemloft.net, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, kubakici@wp.pl, jasowang@redhat.com, loseweigh@gmail.com, aaron.f.brown@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 5/2/2018 12:50 AM, Jiri Pirko wrote:
> Wed, May 02, 2018 at 02:20:26AM CEST, sridhar.samudrala@intel.com wrote:
>> On 4/30/2018 12:20 AM, Jiri Pirko wrote:
>>>>> Now I try to change mac of the failover master:
>>>>> [root@test1 ~]# ip link set ens3 addr 52:54:00:b2:a7:f3
>>>>> RTNETLINK answers: Operation not supported
>>>>>
>>>>> That I did expect to work. I would expect this would change the mac of
>>>>> the master and both standby and primary slaves.
>>>> If a VF is untrusted, a VM will not able to change its MAC and moreover
>>> Note that at this point, I have no VF. So I'm not sure why you mention
>>> that.
>>>
>>>
>>>> in this mode we are assuming that the hypervisor has assigned the MAC and
>>>> guest is not expected to change the MAC.
>>> Wait, for ordinary old-fashioned virtio_net, as a VM user, I can change
>>> mac and all works fine. How is this different? Change mac on "failover
>>> instance" should work and should propagate the mac down to its slaves.
>>>
>>>
>>>> For the initial implementation, i would propose not allowing the guest to
>>>> change the MAC of failover or standby dev.
>>> I see no reason for such restriction.
>>>
>> It is true that a VM user can change mac address of a normal virtio-net interface,
>> however when it is in STANDBY mode i think we should not allow this change specifically
>> because we are creating a failover instance based on a MAC that is assigned by the
>> hypervisor.
>>
>> Moreover,  in a cloud environment i would think that PF/hypervisor assigns a MAC to
>> the VF and it cannot be changed by the guest.
> So that is easy. You allow the change of the mac and in the "failover"
> mac change implementation you propagate the change down to slaves. If
> one slave does not support the change, you bail out. And since VF does
> not allow it as you say, once it will be enslaved, the mac change could
> not be done. Seems like a correct behavior to me and is in-sync with how
> bond/team behaves.

If we allow the mac to be changed when the VF is not yet plugged in
and the guest changes the mac, then VF cannot join the failover when
it is hot plugged with the original mac assigned by the hypervisor.
Specifically there could be timing window during the live migration where
VF would be unplugged at the source and if we allow the guest to change the
failover mac, then VF would not be able to register with the failover after
the VM is migrated to the destination.

>
>> So for the initial implementation, do you see any issues with having this restriction
>> in STANDBY mode.
>>
>>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

