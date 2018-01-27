Return-Path: virtio-dev-return-3089-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 60D4258191C7
	for <virtio-dev@lists.oasis-open.org>; Fri, 26 Jan 2018 21:33:13 -0800 (PST)
References: <1515736720-39368-1-git-send-email-sridhar.samudrala@intel.com>
 <1515736720-39368-3-git-send-email-sridhar.samudrala@intel.com>
 <CADGSJ22BsdB-hDb0xebSyWrwDuBJaFACjb26PDoqAd2Ah+tsQg@mail.gmail.com>
 <20180122233205-mutt-send-email-mst@kernel.org>
 <CADGSJ209vrdjnEAweLg84FwN3sf+1W+APmvB=NjFkMNAhsOyrg@mail.gmail.com>
 <20180124004556-mutt-send-email-mst@kernel.org>
 <CADGSJ2308J=tb1B1zrPi0bFzqYSoLfJsRZxBg6wT+wuCfRO6vw@mail.gmail.com>
 <731db0a0-85e7-a88e-6e0e-c540086347b5@intel.com>
 <CADGSJ205yeyGV2nJ9Cr=FwPypxAHb12jx3WitS6UmWSJ9VP42Q@mail.gmail.com>
 <20180127000831-mutt-send-email-mst@kernel.org>
 <20180126144704.6e1a9628@cakuba.netronome.com>
 <5fa8c6c6-4a94-91fa-fdbb-ee7b624d703f@intel.com>
 <20180126183003.591cd5c5@cakuba.netronome.com>
From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Message-ID: <e02e21a1-ab5d-132a-fb33-5e0ba42fc9ac@intel.com>
Date: Fri, 26 Jan 2018 21:33:01 -0800
MIME-Version: 1.0
In-Reply-To: <20180126183003.591cd5c5@cakuba.netronome.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [virtio-dev] Re: [RFC PATCH net-next v2 2/2] virtio_net: Extend
 virtio to use VF datapath when available
To: Jakub Kicinski <kubakici@wp.pl>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Siwei Liu <loseweigh@gmail.com>, Stephen Hemminger <stephen@networkplumber.org>, David Miller <davem@davemloft.net>, Netdev <netdev@vger.kernel.org>, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, "Brandeburg, Jesse" <jesse.brandeburg@intel.com>, Alexander Duyck <alexander.h.duyck@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On 1/26/2018 6:30 PM, Jakub Kicinski wrote:
> On Fri, 26 Jan 2018 15:30:35 -0800, Samudrala, Sridhar wrote:
>> On 1/26/2018 2:47 PM, Jakub Kicinski wrote:
>>> On Sat, 27 Jan 2018 00:14:20 +0200, Michael S. Tsirkin wrote:
>>>> On Fri, Jan 26, 2018 at 01:46:42PM -0800, Siwei Liu wrote:
>>>>>> and the VM is not expected to do any tuning/optimizations on the VF driver
>>>>>> directly,
>>>>>> i think the current patch that follows the netvsc model of 2 netdevs(virtio
>>>>>> and vf) should
>>>>>> work fine.
>>>>> OK. For your use case that's fine. But that's too specific scenario
>>>>> with lots of restrictions IMHO, perhaps very few users will benefit
>>>>> from it, I'm not sure. If you're unwilling to move towards it, we'd
>>>>> take this one and come back with a generic solution that is able to
>>>>> address general use cases for VF/PT live migration .
>>>> I think that's a fine approach. Scratch your own itch!  I imagine a very
>>>> generic virtio-switchdev providing host routing info to guests could
>>>> address lots of usecases. A driver could bind to that one and enslave
>>>> arbitrary other devices.  Sounds reasonable.
>>>>
>>>> But given the fundamental idea of a failover was floated at least as
>>>> early as 2013, and made 0 progress since precisely because it kept
>>>> trying to address more and more features, and given netvsc is already
>>>> using the basic solution with some success, I'm not inclined to block
>>>> this specific effort waiting for the generic one.
>>> I think there is an agreement that the extra netdev will be useful for
>>> more advanced use cases, and is generally preferable.  What is the
>>> argument for not doing that from the start?  If it was made I must have
>>> missed it.  Is it just unwillingness to write the extra 300 lines of
>>> code?  Sounds like a pretty weak argument when adding kernel ABI is at
>>> stake...
>> I am still not clear on the need for the extra netdev created by
>> virtio_net. The only advantage i can see is that the stats can be
>> broken between VF and virtio datapaths compared to the aggregrated
>> stats on virtio netdev as seen with the 2 netdev approach.
> Maybe you're not convinced but multiple arguments were made.
All the arguments seem to either saying that semantically this doesn't 
look like
a bond OR suggesting usecases that this patch is not trying to solve.
This approach should help cloud environments where the guest networking 
is fully
controlled from the hypervisor via the PF driver or via port representor 
when switchdev
mode is enabled. The guest admin is not expected or allowed to make any 
networking
changes from the VM.

>
>> With 2 netdev model, any VM image that has a working network
>> configuration will transparently get VF based acceleration without
>> any changes.
> Nothing happens transparently.  Things may happen automatically.  The
> VF netdev doesn't disappear with netvsc.  The PV netdev transforms into
> something it did not use to be.  And configures and reports some
> information from the PV (e.g. speed) but PV doesn't pass traffic any
> longer.

>> 3 netdev model breaks this configuration starting with the creation
>> and naming of the 2 devices to udev needing to be aware of master and
>> slave virtio-net devices.
> I don't understand this comment.  There is one virtio-net device and
> one "virtio-bond" netdev.  And user space has to be aware of the special
> automatic arrangement anyway, because it can't touch the VF.  It
> doesn't make any difference whether it ignores the VF or PV and VF.
> It simply can't touch the slaves, no matter how many there are.

If the userspace is not expected to touch the slaves, then why do we need to
take extra effort to expose a netdev that is just not really useful.

>
>> Also, from a user experience point of view, loading a virtio-net with
>> BACKUP feature enabled will now show 2 virtio-net netdevs.
> One virtio-net and one virtio-bond, which represents what's happening.
This again assumes that we want to represent a bond setup. Can't we 
treat this
as virtio-net providing an alternate low-latency datapath by taking over 
VF datapath?
>
>> For live migration with advanced usecases that Siwei is suggesting, i
>> think we need a new driver with a new device type that can track the
>> VF specific feature settings even when the VF driver is unloaded.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

