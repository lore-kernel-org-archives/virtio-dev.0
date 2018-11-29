Return-Path: virtio-dev-return-5082-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 37C10985D3E
	for <virtio-dev@lists.oasis-open.org>; Thu, 29 Nov 2018 23:53:58 +0000 (UTC)
References: <CAKPgXcEXVjH6ZHLLYA-rC+4LM43HMmZN2AgsJMpJJjhPm7cK2Q@mail.gmail.com>
 <25a340eb-62a8-ea90-5f0d-0ee3171479ce@intel.com>
 <20181128120516-mutt-send-email-mst@kernel.org>
 <af565813-753c-e4f1-00eb-0b3eb2fb373b@intel.com>
 <20181128123424-mutt-send-email-mst@kernel.org>
 <0a81c110-610e-2183-3483-95faf53c3fce@intel.com>
 <20181128135154-mutt-send-email-mst@kernel.org>
 <1aeab969-f47f-42c3-31a0-b4c5df647d58@oracle.com>
 <20181128195226-mutt-send-email-mst@kernel.org>
 <cca54913-42c0-55bf-986e-8670c49fb8fe@oracle.com>
 <20181129160950-mutt-send-email-mst@kernel.org>
 <2f44fe5e-ee7d-96cd-dd85-f663fa04c7d0@oracle.com>
From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Message-ID: <ff67ecc7-b3c0-658c-ee04-0d349555248d@intel.com>
Date: Thu, 29 Nov 2018 15:53:55 -0800
MIME-Version: 1.0
In-Reply-To: <2f44fe5e-ee7d-96cd-dd85-f663fa04c7d0@oracle.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [virtio-dev] [PATCH v4] content: Introduce VIRTIO_NET_F_STANDBY
 feature
To: si-wei liu <si-wei.liu@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Carolyn <carolyn.wyborny@intel.com>, Sameeh Jubran <sameeh@daynix.com>, Siwei Liu <loseweigh@gmail.com>, venu.busireddy@oracle.com, cohuck@redhat.com, virtio-dev <virtio-dev@lists.oasis-open.org>, liran.alon@oracle.com, Yan Vugenfirer <yan@daynix.com>, "Brandeburg, Jesse" <jesse.brandeburg@intel.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On 11/29/2018 2:53 PM, si-wei liu wrote:
>
>
> On 11/29/2018 1:17 PM, Michael S. Tsirkin wrote:
>> On Thu, Nov 29, 2018 at 12:14:46PM -0800, si-wei liu wrote:
>>>
>>> On 11/28/2018 5:15 PM, Michael S. Tsirkin wrote:
>>>> On Wed, Nov 28, 2018 at 12:28:42PM -0800, si-wei liu wrote:
>>>>> On 11/28/2018 12:06 PM, Michael S. Tsirkin wrote:
>>>>>> On Wed, Nov 28, 2018 at 10:39:55AM -0800, Samudrala, Sridhar wrote:
>>>>>>> On 11/28/2018 9:35 AM, Michael S. Tsirkin wrote:
>>>>>>>> On Wed, Nov 28, 2018 at 09:31:32AM -0800, Samudrala, Sridhar 
>>>>>>>> wrote:
>>>>>>>>> On 11/28/2018 9:08 AM, Michael S. Tsirkin wrote:
>>>>>>>>>> On Mon, Nov 26, 2018 at 12:22:56PM -0800, Samudrala, Sridhar 
>>>>>>>>>> wrote:
>>>>>>>>>>>> Update:
>>>>>>>>>>>> I have just set the vf mac's address to 0 (ip link set 
>>>>>>>>>>>> ens2f0 vf 1 mac
>>>>>>>>>>>> 00:00:00:00:00:00) after unplugging it (the primary device) 
>>>>>>>>>>>> and the
>>>>>>>>>>>> pings started working again on the failover interface. So 
>>>>>>>>>>>> it seems
>>>>>>>>>>>> like the frames were arriving to the vf on the host.
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>> Yes. When the VF is unplugged, you need to reset the VFs MAC 
>>>>>>>>>>> so that the packets
>>>>>>>>>>> with VMs MAC start flowing via VF, bridge and the virtio 
>>>>>>>>>>> interface.
>>>>>>>>>>>
>>>>>>>>>>> Have you looked at this documentation that shows a sample 
>>>>>>>>>>> script to initiate live
>>>>>>>>>>> migration?
>>>>>>>>>>> https://www.kernel.org/doc/html/latest/networking/net_failover.html 
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> -Sridhar
>>>>>>>>>> Interesting I didn't notice it does this. So in fact
>>>>>>>>>> just defining VF mac will immediately divert packets
>>>>>>>>>> to the VF? Given guest driver did not initialize VF
>>>>>>>>>> yet won't a bunch of packets be dropped?
>>>>>>>>> There is typo in my stmt above (VF->PF)
>>>>>>>>> When the VF is unplugged, you need to reset the VFs MAC so 
>>>>>>>>> that the packets
>>>>>>>>> with VMs MAC start flowing via PF, bridge and the virtio 
>>>>>>>>> interface.
>>>>>>>>>
>>>>>>>>> When the VF is plugged in, ideally the MAC filter for the VF 
>>>>>>>>> should be added to
>>>>>>>>> the HW once the guest driver comes up and can receive packets. 
>>>>>>>>> Currently with intel
>>>>>>>>> drivers, the filter gets added to HW as soon as the host admin 
>>>>>>>>> sets the VFs MAC via
>>>>>>>>> ndo_set_vf_mac() api. So potentially there could be packet 
>>>>>>>>> drops until the VF driver
>>>>>>>>> comes up in the VM.
>>>>>>>>>
>>>>>>>>>
>>>>>>>> Can this be fixed in the intel drivers?
>>>>>>> I just checked and it looks like this seems to have been 
>>>>>>> addressed in the
>>>>>>> ice 100Gb driver. Will bring this up issue internally to see if 
>>>>>>> we can change this
>>>>>>> behavior in i40e/ixgbe drivers.
>>>>>> Also what happens if the mac is programmed both in PF (e.g. with
>>>>>> macvtap) and VF? Ideally VF will take precedence.
>>>>> I'm seriously doubtful that legacy Intel NIC hardware can do that 
>>>>> instead of
>>>>> mucking around with software workaround in the PF driver. 
>>>>> Actually, the same
>>>>> applies to other NIC vendors when hardware sees duplicate filters. 
>>>>> There's
>>>>> no such control of precedence on one over the other.
>>>>>
>>>>>
>>>>> -Siwei
>>>>>
>>>>>
>>>> Well removing a MAC from the PF filter when we are adding it to the VF
>>>> filter should always be possible. Need to keep it in a separate 
>>>> list and
>>>> re-add it when removing the MAC from VF filter.  This can be 
>>>> handled in
>>>> the net core, no need for driver specific hacks.
>>> So that is what I ever said - essentially what you need is a netdev 
>>> API,
>>> rather than to add dirty hacks on each driver. That is fine, but how 
>>> would
>>> you implement it? Note there's no equivalent driver level .ndo API 
>>> to "move"
>>> filters, and all existing .ndo APIs manipulate at the MAC address 
>>> level as
>>> opposed to filters. Are you going to convince netdev this is the 
>>> right thing
>>> to do and we should add such API to the net core and each individual 
>>> driver?
>> There's no need for a new API IMO.
>> You drop it from list of uc macs, then call .ndo_set_rx_mode.
> Then still you need a new netlink API - effectively it alters the 
> running state of macvtap as it steals certain filters out from the NIC 
> that affects the datapath of macvtap. I assume we talk about some 
> kernel mechanism to do automatic datapath switching without involving 
> userspace management stack/orchestration software. In the kernel's 
> (net core's) view that also needs some weak binding/coordination 
> between the VF and the macvtap for which MAC filter needs to be 
> activated. Still this senses to me a new API rather than tweaking the 
> current and long-existing default behavior and making it work 
> transparently just for this case. Otherwise, without introducing a new 
> API, how does the userspace infer that the running kernel supports 
> this new behavior.

In case of virtio backed by macvtap, you can change the mac address of the macvtap
interface. When VF is plugged in, change macvtap's MAC to an unassigned MAC and bring
the virtio link down.
When VF in unplugged, set macvtap's MAC to VMs mac and bring up virtio link.



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

