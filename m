Return-Path: virtio-dev-return-5076-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2D3049858B5
	for <virtio-dev@lists.oasis-open.org>; Thu, 29 Nov 2018 06:37:20 +0000 (UTC)
References: <20181122132626-mutt-send-email-mst@kernel.org>
 <CAKPgXcHT9rOt=FLSpK1qndJVMe1c7sDDqmHWenXVT5CaXt4Rxg@mail.gmail.com>
 <CAKPgXcEXVjH6ZHLLYA-rC+4LM43HMmZN2AgsJMpJJjhPm7cK2Q@mail.gmail.com>
 <25a340eb-62a8-ea90-5f0d-0ee3171479ce@intel.com>
 <20181128120516-mutt-send-email-mst@kernel.org>
 <af565813-753c-e4f1-00eb-0b3eb2fb373b@intel.com>
 <20181128123424-mutt-send-email-mst@kernel.org>
 <0a81c110-610e-2183-3483-95faf53c3fce@intel.com>
 <20181128135154-mutt-send-email-mst@kernel.org>
 <1aeab969-f47f-42c3-31a0-b4c5df647d58@oracle.com>
 <20181128195226-mutt-send-email-mst@kernel.org>
From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Message-ID: <b2c45f2f-2a88-d9ef-b38c-363672120f77@intel.com>
Date: Wed, 28 Nov 2018 22:37:16 -0800
MIME-Version: 1.0
In-Reply-To: <20181128195226-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [virtio-dev] [PATCH v4] content: Introduce VIRTIO_NET_F_STANDBY
 feature
To: "Michael S. Tsirkin" <mst@redhat.com>, si-wei liu <si-wei.liu@oracle.com>
Cc: Carolyn <carolyn.wyborny@intel.com>, Sameeh Jubran <sameeh@daynix.com>, Siwei Liu <loseweigh@gmail.com>, venu.busireddy@oracle.com, cohuck@redhat.com, virtio-dev <virtio-dev@lists.oasis-open.org>, liran.alon@oracle.com, Yan Vugenfirer <yan@daynix.com>, "Brandeburg, Jesse" <jesse.brandeburg@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On 11/28/2018 5:15 PM, Michael S. Tsirkin wrote:
> On Wed, Nov 28, 2018 at 12:28:42PM -0800, si-wei liu wrote:
>>
>> On 11/28/2018 12:06 PM, Michael S. Tsirkin wrote:
>>> On Wed, Nov 28, 2018 at 10:39:55AM -0800, Samudrala, Sridhar wrote:
>>>> On 11/28/2018 9:35 AM, Michael S. Tsirkin wrote:
>>>>> On Wed, Nov 28, 2018 at 09:31:32AM -0800, Samudrala, Sridhar wrote:
>>>>>> On 11/28/2018 9:08 AM, Michael S. Tsirkin wrote:
>>>>>>> On Mon, Nov 26, 2018 at 12:22:56PM -0800, Samudrala, Sridhar wrote:
>>>>>>>>> Update:
>>>>>>>>> I have just set the vf mac's address to 0 (ip link set ens2f0 vf 1 mac
>>>>>>>>> 00:00:00:00:00:00) after unplugging it (the primary device) and the
>>>>>>>>> pings started working again on the failover interface. So it seems
>>>>>>>>> like the frames were arriving to the vf on the host.
>>>>>>>>>
>>>>>>>>>
>>>>>>>> Yes. When the VF is unplugged, you need to reset the VFs MAC so that the packets
>>>>>>>> with VMs MAC start flowing via VF, bridge and the virtio interface.
>>>>>>>>
>>>>>>>> Have you looked at this documentation that shows a sample script to initiate live
>>>>>>>> migration?
>>>>>>>> https://www.kernel.org/doc/html/latest/networking/net_failover.html
>>>>>>>>
>>>>>>>> -Sridhar
>>>>>>> Interesting I didn't notice it does this. So in fact
>>>>>>> just defining VF mac will immediately divert packets
>>>>>>> to the VF? Given guest driver did not initialize VF
>>>>>>> yet won't a bunch of packets be dropped?
>>>>>> There is typo in my stmt above (VF->PF)
>>>>>> When the VF is unplugged, you need to reset the VFs MAC so that the packets
>>>>>> with VMs MAC start flowing via PF, bridge and the virtio interface.
>>>>>>
>>>>>> When the VF is plugged in, ideally the MAC filter for the VF should be added to
>>>>>> the HW once the guest driver comes up and can receive packets. Currently with intel
>>>>>> drivers, the filter gets added to HW as soon as the host admin sets the VFs MAC via
>>>>>> ndo_set_vf_mac() api. So potentially there could be packet drops until the VF driver
>>>>>> comes up in the VM.
>>>>>>
>>>>>>
>>>>> Can this be fixed in the intel drivers?
>>>> I just checked and it looks like this seems to have been addressed in the
>>>> ice 100Gb driver. Will bring this up issue internally to see if we can change this
>>>> behavior in i40e/ixgbe drivers.
>>> Also what happens if the mac is programmed both in PF (e.g. with
>>> macvtap) and VF? Ideally VF will take precedence.
>> I'm seriously doubtful that legacy Intel NIC hardware can do that instead of
>> mucking around with software workaround in the PF driver. Actually, the same
>> applies to other NIC vendors when hardware sees duplicate filters. There's
>> no such control of precedence on one over the other.
>>
>>
>> -Siwei
>>
>>
> Well removing a MAC from the PF filter when we are adding it to the VF
> filter should always be possible. Need to keep it in a separate list and
> re-add it when removing the MAC from VF filter.  This can be handled in
> the net core, no need for driver specific hacks.

We don't explicitly add MAC to the PF filter list. Just resetting VFs MAC will cause the
frames to reach PF as that is the default port.

Also, setting MACs is a privileged operation and i think managing them during live migration
should be handled by a management layer.


>
>
> Still, let's prioritize things correctly.  IMHO it's fine if we
> initially assume promisc mode on the PF.  macvlan has this mode too
> after all.

Yes. We don't need to explicitly set the MAC on the PF.

>
> Question is how does userspace know driver isn't broken in this respect?
> Let's add a "vf failover" flag somewhere so this can be probed?

I don't understand the need for this additional flag.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

