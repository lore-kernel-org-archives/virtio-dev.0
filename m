Return-Path: virtio-dev-return-5497-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1AD289860E5
	for <virtio-dev@lists.oasis-open.org>; Fri, 22 Feb 2019 07:55:38 +0000 (UTC)
References: <1523386790-12396-1-git-send-email-sridhar.samudrala@intel.com>
 <1523386790-12396-5-git-send-email-sridhar.samudrala@intel.com>
 <20180410142608.50f15b45@xeon-e3> <20180411075334.GK2028@nanopsycho>
 <CADGSJ214RJV_zWVBGv0Ydo=CJj6WESTYAH=PpaYLFHdtWVrm3g@mail.gmail.com>
 <20190221203808-mutt-send-email-mst@kernel.org>
 <581e4399-3969-aecd-e923-03bbc0880733@oracle.com>
 <91d4cbb1-be7a-b53c-6b2a-99bef07e7c53@intel.com>
From: si-wei liu <si-wei.liu@oracle.com>
Message-ID: <d9ef40a2-237b-0cce-4401-ecaeac4c602a@oracle.com>
Date: Thu, 21 Feb 2019 23:55:11 -0800
MIME-Version: 1.0
In-Reply-To: <91d4cbb1-be7a-b53c-6b2a-99bef07e7c53@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio-dev] Re: net_failover slave udev renaming (was Re: [RFC
 PATCH net-next v6 4/4] netvsc: refactor notifier/event handling code to use
 the bypass framework)
To: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Siwei Liu <loseweigh@gmail.com>
Cc: Jiri Pirko <jiri@resnulli.us>, Stephen Hemminger <stephen@networkplumber.org>, David Miller <davem@davemloft.net>, Netdev <netdev@vger.kernel.org>, virtualization@lists.linux-foundation.org, virtio-dev <virtio-dev@lists.oasis-open.org>, "Brandeburg, Jesse" <jesse.brandeburg@intel.com>, Alexander Duyck <alexander.h.duyck@intel.com>, Jakub Kicinski <kubakici@wp.pl>, Jason Wang <jasowang@redhat.com>, liran.alon@oracle.com
List-ID: <virtio-dev.lists.oasis-open.org>



On 2/21/2019 11:00 PM, Samudrala, Sridhar wrote:
>
>
> On 2/21/2019 7:33 PM, si-wei liu wrote:
>>
>>
>> On 2/21/2019 5:39 PM, Michael S. Tsirkin wrote:
>>> On Thu, Feb 21, 2019 at 05:14:44PM -0800, Siwei Liu wrote:
>>>> Sorry for replying to this ancient thread. There was some remaining
>>>> issue that I don't think the initial net_failover patch got addressed
>>>> cleanly, see:
>>>>
>>>> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1815268
>>>>
>>>> The renaming of 'eth0' to 'ens4' fails because the udev userspace was
>>>> not specifically writtten for such kernel automatic enslavement.
>>>> Specifically, if it is a bond or team, the slave would typically get
>>>> renamed *before* virtual device gets created, that's what udev can
>>>> control (without getting netdev opened early by the other part of
>>>> kernel) and other userspace components for e.g. initramfs,
>>>> init-scripts can coordinate well in between. The in-kernel
>>>> auto-enslavement of net_failover breaks this userspace convention,
>>>> which don't provides a solution if user care about consistent naming
>>>> on the slave netdevs specifically.
>>>>
>>>> Previously this issue had been specifically called out when IFF_HIDDEN
>>>> and the 1-netdev was proposed, but no one gives out a solution to this
>>>> problem ever since. Please share your mind how to proceed and solve
>>>> this userspace issue if netdev does not welcome a 1-netdev model.
>>> Above says:
>>>
>>>     there's no motivation in the systemd/udevd community at
>>>     this point to refactor the rename logic and make it work well with
>>>     3-netdev.
>>>
>>> What would the fix be? Skip slave devices?
>>>
>> There's nothing user can get if just skipping slave devices - the 
>> name is still unchanged and unpredictable e.g. eth0, or eth1 the next 
>> reboot, while the rest may conform to the naming scheme (ens3 and 
>> such). There's no way one can fix this in userspace alone - when the 
>> failover is created the enslaved netdev was opened by the kernel 
>> earlier than the userspace is made aware of, and there's no 
>> negotiation protocol for kernel to know when userspace has done 
>> initial renaming of the interface. I would expect netdev list should 
>> at least provide the direction in general for how this can be solved...
>>
> Is there an issue if slave device names are not predictable? The user/admin scripts are expected
> to only work with the master failover device.
Where does this expectation come from?

Admin users may have ethtool or tc configurations that need to deal with 
predictable interface name. Third-party app which was built upon 
specifying certain interface name can't be modified to chase dynamic names.

Specifically, we have pre-canned image that uses ethtool to fine tune VF 
offload settings post boot for specific workload. Those images won't 
work well if the name is constantly changing just after couple rounds of 
live migration.

> Moreover, you were suggesting hiding the lower slave devices anyway. There was some discussion
> about moving them to a hidden network namespace so that they are not visible from the default namespace.
> I looked into this sometime back, but did not find the right kernel api to create a network namespace within
> kernel. If so, we could use this mechanism to simulate a 1-netdev model.
Yes, that's one possible implementation (IMHO the key is to make 
1-netdev model as much transparent to a real NIC as possible, while a 
hidden netns is just the vehicle). However, I recall there was 
resistance around this discussion that even the concept of hiding itself 
is a taboo for Linux netdev. I would like to summon potential 
alternatives before concluding 1-netdev is the only solution too soon.

Thanks,
-Siwei

>
>> -Siwei
>>
>>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

