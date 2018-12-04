Return-Path: virtio-dev-return-5115-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2D1F3985C25
	for <virtio-dev@lists.oasis-open.org>; Tue,  4 Dec 2018 02:09:27 +0000 (UTC)
References: <20181128120516-mutt-send-email-mst@kernel.org>
 <af565813-753c-e4f1-00eb-0b3eb2fb373b@intel.com>
 <20181128123424-mutt-send-email-mst@kernel.org>
 <0a81c110-610e-2183-3483-95faf53c3fce@intel.com>
 <20181128135154-mutt-send-email-mst@kernel.org>
 <1aeab969-f47f-42c3-31a0-b4c5df647d58@oracle.com>
 <20181128195226-mutt-send-email-mst@kernel.org>
 <cca54913-42c0-55bf-986e-8670c49fb8fe@oracle.com>
 <20181129160950-mutt-send-email-mst@kernel.org>
 <2f44fe5e-ee7d-96cd-dd85-f663fa04c7d0@oracle.com>
 <20181130004530-mutt-send-email-mst@kernel.org>
From: si-wei liu <si-wei.liu@oracle.com>
Message-ID: <3035130f-ad02-39d7-a897-aec3a3f2fee5@oracle.com>
Date: Mon, 3 Dec 2018 18:09:19 -0800
MIME-Version: 1.0
In-Reply-To: <20181130004530-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [virtio-dev] [PATCH v4] content: Introduce VIRTIO_NET_F_STANDBY
 feature
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, Carolyn <carolyn.wyborny@intel.com>, Sameeh Jubran <sameeh@daynix.com>, Siwei Liu <loseweigh@gmail.com>, venu.busireddy@oracle.com, cohuck@redhat.com, virtio-dev <virtio-dev@lists.oasis-open.org>, liran.alon@oracle.com, Yan Vugenfirer <yan@daynix.com>, "Brandeburg, Jesse" <jesse.brandeburg@intel.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>
List-ID: <virtio-dev.lists.oasis-open.org>



On 11/29/2018 10:21 PM, Michael S. Tsirkin wrote:
> On Thu, Nov 29, 2018 at 02:53:08PM -0800, si-wei liu wrote:
>>
>> On 11/29/2018 1:17 PM, Michael S. Tsirkin wrote:
>>> On Thu, Nov 29, 2018 at 12:14:46PM -0800, si-wei liu wrote:
>>>> On 11/28/2018 5:15 PM, Michael S. Tsirkin wrote:
>>>>> On Wed, Nov 28, 2018 at 12:28:42PM -0800, si-wei liu wrote:
>>>>>> On 11/28/2018 12:06 PM, Michael S. Tsirkin wrote:
>>>>>>> On Wed, Nov 28, 2018 at 10:39:55AM -0800, Samudrala, Sridhar wrote:
>>>>>>>> On 11/28/2018 9:35 AM, Michael S. Tsirkin wrote:
>>>>>>>>> On Wed, Nov 28, 2018 at 09:31:32AM -0800, Samudrala, Sridhar wrote:
>>>>>>>>>> On 11/28/2018 9:08 AM, Michael S. Tsirkin wrote:
>>>>>>>>>>> On Mon, Nov 26, 2018 at 12:22:56PM -0800, Samudrala, Sridhar wrote:
>>>>>>>>>>>>> Update:
>>>>>>>>>>>>> I have just set the vf mac's address to 0 (ip link set ens2f0 vf 1 mac
>>>>>>>>>>>>> 00:00:00:00:00:00) after unplugging it (the primary device) and the
>>>>>>>>>>>>> pings started working again on the failover interface. So it seems
>>>>>>>>>>>>> like the frames were arriving to the vf on the host.
>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>> Yes. When the VF is unplugged, you need to reset the VFs MAC so that the packets
>>>>>>>>>>>> with VMs MAC start flowing via VF, bridge and the virtio interface.
>>>>>>>>>>>>
>>>>>>>>>>>> Have you looked at this documentation that shows a sample script to initiate live
>>>>>>>>>>>> migration?
>>>>>>>>>>>> https://www.kernel.org/doc/html/latest/networking/net_failover.html
>>>>>>>>>>>>
>>>>>>>>>>>> -Sridhar
>>>>>>>>>>> Interesting I didn't notice it does this. So in fact
>>>>>>>>>>> just defining VF mac will immediately divert packets
>>>>>>>>>>> to the VF? Given guest driver did not initialize VF
>>>>>>>>>>> yet won't a bunch of packets be dropped?
>>>>>>>>>> There is typo in my stmt above (VF->PF)
>>>>>>>>>> When the VF is unplugged, you need to reset the VFs MAC so that the packets
>>>>>>>>>> with VMs MAC start flowing via PF, bridge and the virtio interface.
>>>>>>>>>>
>>>>>>>>>> When the VF is plugged in, ideally the MAC filter for the VF should be added to
>>>>>>>>>> the HW once the guest driver comes up and can receive packets. Currently with intel
>>>>>>>>>> drivers, the filter gets added to HW as soon as the host admin sets the VFs MAC via
>>>>>>>>>> ndo_set_vf_mac() api. So potentially there could be packet drops until the VF driver
>>>>>>>>>> comes up in the VM.
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>> Can this be fixed in the intel drivers?
>>>>>>>> I just checked and it looks like this seems to have been addressed in the
>>>>>>>> ice 100Gb driver. Will bring this up issue internally to see if we can change this
>>>>>>>> behavior in i40e/ixgbe drivers.
>>>>>>> Also what happens if the mac is programmed both in PF (e.g. with
>>>>>>> macvtap) and VF? Ideally VF will take precedence.
>>>>>> I'm seriously doubtful that legacy Intel NIC hardware can do that instead of
>>>>>> mucking around with software workaround in the PF driver. Actually, the same
>>>>>> applies to other NIC vendors when hardware sees duplicate filters. There's
>>>>>> no such control of precedence on one over the other.
>>>>>>
>>>>>>
>>>>>> -Siwei
>>>>>>
>>>>>>
>>>>> Well removing a MAC from the PF filter when we are adding it to the VF
>>>>> filter should always be possible. Need to keep it in a separate list and
>>>>> re-add it when removing the MAC from VF filter.  This can be handled in
>>>>> the net core, no need for driver specific hacks.
>>>> So that is what I ever said - essentially what you need is a netdev API,
>>>> rather than to add dirty hacks on each driver. That is fine, but how would
>>>> you implement it? Note there's no equivalent driver level .ndo API to "move"
>>>> filters, and all existing .ndo APIs manipulate at the MAC address level as
>>>> opposed to filters. Are you going to convince netdev this is the right thing
>>>> to do and we should add such API to the net core and each individual driver?
>>> There's no need for a new API IMO.
>>> You drop it from list of uc macs, then call .ndo_set_rx_mode.
>> Then still you need a new netlink API
>> - effectively it alters the running
>> state of macvtap as it steals certain filters out from the NIC that affects
>> the datapath of macvtap. I assume we talk about some kernel mechanism to do
>> automatic datapath switching without involving userspace management
>> stack/orchestration software. In the kernel's (net core's) view that also
>> needs some weak binding/coordination between the VF and the macvtap for
>> which MAC filter needs to be activated. Still this senses to me a new API
>> rather than tweaking the current and long-existing default behavior and
>> making it work transparently just for this case. Otherwise, without
>> introducing a new API, how does the userspace infer that the running kernel
>> supports this new behavior.
> I agree. But a single flag is not much of an extension. We don't even
> need it in netlink, can be anywhere in e.g. sysfs.
I think sysfs attribute is for exposing the capability, while you still 
need to set up macvtap with some special mode via netlink. That way it 
doesn't break current behavior, and when VF's MAC filter is added 
macvtap would need to react to remove the filter from NIC. And add the 
one back when VF's MAC is removed.

>
>>> This can be done without changing existing drivers.
>>>
>>>>> Still, let's prioritize things correctly.  IMHO it's fine if we
>>>>> initially assume promisc mode on the PF.  macvlan has this mode too
>>>>> after all.
>>>> I'm not sure what promisc mode you talked about. As far as I understand it
>>>> for macvlan/macvtap the NIC is only put into promisc mode when running out
>>>> of MAC filter entries. Before that all MAC addresses will be added to the
>>>> NIC as unicast filters. In addition, people prefer macvlan/macvtap for
>>>> adding isolation in a multi-tenant cloud as well as avoiding performance
>>>> penalty due to noisy neighbors. I'd rather to hear that claim to be that the
>>>> current MAC-based pairing scheme doesn't work well with macvtap and only
>>>> works with bridged setup which has promisc enabled. That would be more
>>>> helpful for people to understand the situation better.
>>>>
>>>> Thanks,
>>>> -Siwei
>>>>
>>> As a first step that's fine.
>> Well, I specifically called it out one year ago as this work was started
>> that macvtap is what we look into (we don't care about bridge with
>> promiscuous enabled) and the answer I got at the point was that the current
>> model would work well for macvtap too (which I've been very doubtful from
>> the very beginning).
> At least I personally did not realize it's about macvtap.
Wouldn't macvtap a very common backend that any virtio-net feature has 
to support? I thought it has tighter integration with vhost-net than 
bridge and tap.

>   I wish there
> were example command lines showing what's broken.  Liran got hold of me
> at the KVM forum and explained it's about macvlan that's the first I
> heard about it, but that was offline, others might hear just now first.
>
> The issue between macvlan and configuring a VF can be
> tested with a couple of simple commands maybe using e.g. netsniff
> with no need for a VM at all.
> Pity these were never posted - interested in posting a test
> tool that can be used to demonstrate/test the issue on various cards?
>
>> Eventually turns out this is not true and it looks like
>> this is slowly converging to what Hyper-V netvsc already supported quite a
>> few years if not a decade ago, sighs...
> Oh we'll see.
>
> Meanwhile what's missing and was missing all along for the change you
> seem to be advocating for to get off the ground is people who
> are ready to actually send e.g. spec, guest driver, test patches.
Partly because it hadn't been converged to the best way to do it (even 
the group ID mechanism with PCI bridge can address our need you don't 
seem to think it is valuable). The in-kernel approach is fine at its 
appearance, but I personally don't believe changing every legacy driver 
is the way to go. It's the choice of implementation and what has been 
implemented in those drivers today IMHO is nothing wrong.

>
>>>    Still this assumes just creating a VF
>>> doesn't yet program the on-card filter to cause packet drops.
>> Suppose this behavior is fixable in legacy Intel NIC, you would still need
>> to evacuate the filter programmed by macvtap previously when VF's filter
>> gets activated (typically when VF's netdev is netif_running() in a Linux
>> guest). That's what we and NetVSC call as "datapath switching", and where
>> this could be handled (driver, net core, or userspace) is the core for the
>> architectural design that I spent much time on.
>>
>> Having said it, I don't expect or would desperately wait on one vendor to
>> fix a legacy driver which wasn't quite motivated, then no work would be done
>> on that.
> Then that device can't be used with the mechanism in question.
> Or if there are lots of drivers like this maybe someone will be
> motivated enough to post a better implementation with a new
> feature bit. It's not that I'm arguing against that.
>
> But given the options of teaching management to play with
> netlink API in response to guest actions, and with VCPU stopped,
> and doing it all in host kernel drivers, I know I'll prefer host kernel
> changes.
We have some internal patches that leverage management to respond to 
various guest actions. If you're interested we can post them. The thing 
is no one would like to work on the libvirt changes, while internally we 
have our own orchestration software which is not libvirt. But if you 
think it's fine we can definitely share our QEMU patches while leaving 
out libvirt.

Thanks,
-Siwei
>
>> If you'd go the way, please make sure Intel could change their
>> driver first.
> We'll see what happens with that. It's Sridhar from intel that implemented
> the guest changes after all, so I expect he's motivated to make them
> work well.
>
>
>>>    Let's
>>> assume drivers are fixed to do that. How does userspace know
>>> that's the case? We might need some kind of attribute so
>>> userspace can detect it.
>> Where do you envision the new attribute could be at? Supposedly it'd be
>> exposed by the kernel, which constitutes a new API or API changes.
>>
>>
>> Thanks,
>> -Siwei
> People add e.g. new attributes in sysfs left and right.  It's unlikely
> to be a matter of serious contention.
>
>>>>> Question is how does userspace know driver isn't broken in this respect?
>>>>> Let's add a "vf failover" flag somewhere so this can be probed?
>>>>>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

