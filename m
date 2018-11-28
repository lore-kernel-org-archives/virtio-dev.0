Return-Path: virtio-dev-return-5066-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 66D5F985D07
	for <virtio-dev@lists.oasis-open.org>; Wed, 28 Nov 2018 18:39:57 +0000 (UTC)
References: <20181018233115-mutt-send-email-mst@kernel.org>
 <CAKPgXcH4mokJd7MeTUNjoGzo6Lbyx72cOQPLfKccQLwVHSMArg@mail.gmail.com>
 <20181121124246-mutt-send-email-mst@kernel.org>
 <CAKPgXcH2D4XcUNoS6tvDfLxPAv05u7Yu77OYxRnuFFfgN34A_w@mail.gmail.com>
 <20181122132626-mutt-send-email-mst@kernel.org>
 <CAKPgXcHT9rOt=FLSpK1qndJVMe1c7sDDqmHWenXVT5CaXt4Rxg@mail.gmail.com>
 <CAKPgXcEXVjH6ZHLLYA-rC+4LM43HMmZN2AgsJMpJJjhPm7cK2Q@mail.gmail.com>
 <25a340eb-62a8-ea90-5f0d-0ee3171479ce@intel.com>
 <20181128120516-mutt-send-email-mst@kernel.org>
 <af565813-753c-e4f1-00eb-0b3eb2fb373b@intel.com>
 <20181128123424-mutt-send-email-mst@kernel.org>
From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Message-ID: <0a81c110-610e-2183-3483-95faf53c3fce@intel.com>
Date: Wed, 28 Nov 2018 10:39:55 -0800
MIME-Version: 1.0
In-Reply-To: <20181128123424-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [virtio-dev] [PATCH v4] content: Introduce VIRTIO_NET_F_STANDBY
 feature
To: "Michael S. Tsirkin" <mst@redhat.com>, Carolyn <carolyn.wyborny@intel.com>
Cc: Sameeh Jubran <sameeh@daynix.com>, Siwei Liu <loseweigh@gmail.com>, venu.busireddy@oracle.com, cohuck@redhat.com, virtio-dev <virtio-dev@lists.oasis-open.org>, liran.alon@oracle.com, Yan Vugenfirer <yan@daynix.com>, "Brandeburg, Jesse" <jesse.brandeburg@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On 11/28/2018 9:35 AM, Michael S. Tsirkin wrote:
> On Wed, Nov 28, 2018 at 09:31:32AM -0800, Samudrala, Sridhar wrote:
>>
>> On 11/28/2018 9:08 AM, Michael S. Tsirkin wrote:
>>> On Mon, Nov 26, 2018 at 12:22:56PM -0800, Samudrala, Sridhar wrote:
>>>>> Update:
>>>>> I have just set the vf mac's address to 0 (ip link set ens2f0 vf 1 mac
>>>>> 00:00:00:00:00:00) after unplugging it (the primary device) and the
>>>>> pings started working again on the failover interface. So it seems
>>>>> like the frames were arriving to the vf on the host.
>>>>>
>>>>>
>>>> Yes. When the VF is unplugged, you need to reset the VFs MAC so that the packets
>>>> with VMs MAC start flowing via VF, bridge and the virtio interface.
>>>>
>>>> Have you looked at this documentation that shows a sample script to initiate live
>>>> migration?
>>>> https://www.kernel.org/doc/html/latest/networking/net_failover.html
>>>>
>>>> -Sridhar
>>> Interesting I didn't notice it does this. So in fact
>>> just defining VF mac will immediately divert packets
>>> to the VF? Given guest driver did not initialize VF
>>> yet won't a bunch of packets be dropped?
>> There is typo in my stmt above (VF->PF)
>> When the VF is unplugged, you need to reset the VFs MAC so that the packets
>> with VMs MAC start flowing via PF, bridge and the virtio interface.
>>
>> When the VF is plugged in, ideally the MAC filter for the VF should be added to
>> the HW once the guest driver comes up and can receive packets. Currently with intel
>> drivers, the filter gets added to HW as soon as the host admin sets the VFs MAC via
>> ndo_set_vf_mac() api. So potentially there could be packet drops until the VF driver
>> comes up in the VM.
>>
>>
> Can this be fixed in the intel drivers?

I just checked and it looks like this seems to have been addressed in the
ice 100Gb driver. Will bring this up issue internally to see if we can change this
behavior in i40e/ixgbe drivers.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

