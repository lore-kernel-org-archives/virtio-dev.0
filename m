Return-Path: virtio-dev-return-3094-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 138A91CB807B
	for <virtio-dev@lists.oasis-open.org>; Sun, 28 Jan 2018 12:18:06 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <f6737111-0015-007c-336b-c8c2793ee590@intel.com>
References: <1515736720-39368-1-git-send-email-sridhar.samudrala@intel.com>
 <1515736720-39368-3-git-send-email-sridhar.samudrala@intel.com>
 <CADGSJ22BsdB-hDb0xebSyWrwDuBJaFACjb26PDoqAd2Ah+tsQg@mail.gmail.com>
 <20180122233205-mutt-send-email-mst@kernel.org> <CADGSJ209vrdjnEAweLg84FwN3sf+1W+APmvB=NjFkMNAhsOyrg@mail.gmail.com>
 <20180124004556-mutt-send-email-mst@kernel.org> <CADGSJ2308J=tb1B1zrPi0bFzqYSoLfJsRZxBg6wT+wuCfRO6vw@mail.gmail.com>
 <731db0a0-85e7-a88e-6e0e-c540086347b5@intel.com> <CADGSJ205yeyGV2nJ9Cr=FwPypxAHb12jx3WitS6UmWSJ9VP42Q@mail.gmail.com>
 <20180127000831-mutt-send-email-mst@kernel.org> <20180126144704.6e1a9628@cakuba.netronome.com>
 <5fa8c6c6-4a94-91fa-fdbb-ee7b624d703f@intel.com> <20180126183003.591cd5c5@cakuba.netronome.com>
 <e02e21a1-ab5d-132a-fb33-5e0ba42fc9ac@intel.com> <20180126215829.7b3c6bac@cakuba.netronome.com>
 <CAKgT0Ud4e9O-FoY242Kn_yBX7JWtL_i=yW+Y-MXQ9BGEVBEkgA@mail.gmail.com> <f6737111-0015-007c-336b-c8c2793ee590@intel.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Sun, 28 Jan 2018 12:18:03 -0800
Message-ID: <CAKgT0UdaKtPe6982TuuGbxhhVgeehwS1aAp=s4sok2vKD6wMJg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [virtio-dev] Re: [RFC PATCH net-next v2 2/2] virtio_net: Extend
 virtio to use VF datapath when available
To: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Cc: Jakub Kicinski <kubakici@wp.pl>, "Michael S. Tsirkin" <mst@redhat.com>, Siwei Liu <loseweigh@gmail.com>, Stephen Hemminger <stephen@networkplumber.org>, David Miller <davem@davemloft.net>, Netdev <netdev@vger.kernel.org>, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, "Brandeburg, Jesse" <jesse.brandeburg@intel.com>, Alexander Duyck <alexander.h.duyck@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Sun, Jan 28, 2018 at 11:18 AM, Samudrala, Sridhar
<sridhar.samudrala@intel.com> wrote:
> On 1/28/2018 9:35 AM, Alexander Duyck wrote:
>>
>> On Fri, Jan 26, 2018 at 9:58 PM, Jakub Kicinski <kubakici@wp.pl> wrote:
>>>
>>> On Fri, 26 Jan 2018 21:33:01 -0800, Samudrala, Sridhar wrote:
>>>>>>
>>>>>> 3 netdev model breaks this configuration starting with the creation
>>>>>> and naming of the 2 devices to udev needing to be aware of master and
>>>>>> slave virtio-net devices.
>>>>>
>>>>> I don't understand this comment.  There is one virtio-net device and
>>>>> one "virtio-bond" netdev.  And user space has to be aware of the
>>>>> special
>>>>> automatic arrangement anyway, because it can't touch the VF.  It
>>>>> doesn't make any difference whether it ignores the VF or PV and VF.
>>>>> It simply can't touch the slaves, no matter how many there are.
>>>>
>>>> If the userspace is not expected to touch the slaves, then why do we
>>>> need to
>>>> take extra effort to expose a netdev that is just not really useful.
>>>
>>> You said:
>>> "[user space] needs to be aware of master and slave virtio-net devices."
>>>
>>> I'm saying:
>>> It has to be aware of the special arrangement whether there is an
>>> explicit bond netdev or not.
>>
>> To clarify here the kernel should be aware that there is a device that
>> is an aggregate of 2 other devices. It isn't as if we need to insert
>> the new device "above" the virtio.
>>
>> I have been doing a bit of messing around with a few ideas and it
>> seems like it would be better if we could replace the virtio interface
>> with the virtio-bond, renaming my virt-bond concept to this since it
>> is now supposedly going to live in the virtio driver, interface, and
>> then push the original virtio down one layer and call it a
>> virtio-backup. If I am not mistaken we could assign the same dev
>> pointer used by the virtio netdev to the virtio-bond, and if we
>> register it first with the "eth%d" name then udev will assume that the
>> virtio-bond device is the original virtio and all existing scripts
>> should just work with that. We then would want to change the name of
>> the virtio interface with the backup feature bit set, maybe call it
>> something like bkup-00:00:00 where the 00:00:00 would be the last 3
>> octets of the MAC address. It should solve the issue of inserting an
>> interface "above" the virtio by making the virtio-bond become the
>> virtio. The only limitation is that we will probably need to remove
>> the back-up if the virtio device is removed, however that was already
>> a limitation of this solution and others like the netvsc solution
>> anyway.
>
>
> With 3 netdev model, if we make the the master virtio-net associated with
> the
> real virtio pci device,  i think  the userspace scripts would not break.
> If we go this route, i am still not clear on the purpose of exposing the
> bkup netdev.
> Can we start with the 2 netdev model and move to 3 netdev model later if we
> find out that there are limitiations with the 2 netdev model? I don't think
> this will
> break any user API as the userspace is not expected to use the bkup netdev.

The 2 netdev model breaks a large number of expectations of user
space. Among them is XDP since we cannot guarantee a symmetric setup
between any entity and the virtio. How does it make sense that
enabling XDP on virtio shows zero Rx packets, and in the meantime you
are getting all of the packets coming in off of the VF?

In addition we would need to rewrite the VLAN and MAC address
filtering ndo operations since we likely cannot add any VLANs since in
most cases VFs are VLAN locked due to things like port VLAN and we
cannot change the MAC address since the whole bonding concept is built
around it.

The last bit is the netpoll packet routing which the current code
assumes is using the virtio only, but I don't know if that is a valid
assumption since the VF is expected to be the default route for
everything else when it is available.

The point is by the time you are done you will have rewritten pretty
much all the network device ops. With that being the case why add all
the code to virtio itself instead of just coming up with a brand new
set of ndo_ops that belong to this new device, and you could leave the
existing virtio code in place and save yourself a bunch of time by
just accessing it as an existing call as a separate netdev.

>>>>>> Also, from a user experience point of view, loading a virtio-net with
>>>>>> BACKUP feature enabled will now show 2 virtio-net netdevs.
>>>>>
>>>>> One virtio-net and one virtio-bond, which represents what's happening.
>>>>
>>>> This again assumes that we want to represent a bond setup. Can't we
>>>> treat this
>>>> as virtio-net providing an alternate low-latency datapath by taking over
>>>> VF datapath?
>>>
>>> Bond is just a familiar name, we can call it something else if you
>>> prefer.  The point is there are two data paths which can have
>>> independent low-level settings and a higher level entity with
>>> global settings which represents any path to the outside world.
>>>
>>> Hiding low-level netdevs from a lay user requires a generic solution.
>>
>> The last thing I think we should be doing is hiding the low level
>> netdevs. It doesn't solve anythying. We are already trusting the owner
>> of the VM enough to let them have root access of the VM. That means
>> they can load/unload any driver they want. They don't have to use the
>> kernel provided virtio driver, they could load their own. They could
>> even do something like run DPDK on top of it, or they could run DPDK
>> on top of the VF. In either case there is no way the bond would ever
>> be created and all hiding devices does is make it easier to fix
>> problems when something gets broken. Unless I am mistaken, and
>> "security through obscurity" has somehow become a valid security
>> model.
>>
>> As I mentioned to Sridhar on an off-list thread I think the goal
>> should be to make it so that the user wants to use the virtio-bond,
>> not make it so that they have no choice but to use it. The idea is we
>> should be making things easier for the administrator of the VM, not
>> harder.
>>
>>
> When the hypervisor has enabled BACKUP bit along with a VF with the same
> MAC address, the VM can use either VF only OR extended virtio with attached
> VF.
> Although there are 2 datapaths to the device, the hypervisor will enable
> only
> one at any time.  The virtio via PF datapath is only enabled during live
> migration
> when the VF is unplugged. If not, VF broadcasts/multicasts will get looped
> back
> to the VM via the PF datapath. In the RFC path i was assuming that the VM
> can
> use both datapaths and i had broadcasts/multicasts going over virtio
> datapath,
> but i don' think it is a good idea.  It requires the device to disable
> broadcast
> replication on the VFs.
>
> Thanks
> Sridhar

This would work well for the SwitchDev model, but not so well for the
legacy model supported by the Intel drivers. With SwitchDev the
broadcasts/multicasts are coming in on the upllink port representor
anyway is my understanding of how some of the implementations out
there are configured.

For now though we can't assume the logic in the path. We can do that
later when we start looking at v2 which would likely have us spawn a
new device that acts as some sort of smart PCI bridge/PCIe switch that
can then have that device assigned to the virtio-bond/bridge and can
hopefully start taking care of things like providing topology/switch
information and maybe incorporate some DMA tracking on the VF which
would probably be v3.

In the meantime for now I would say we keep this simple. We create a
virtio-bond device that does a bit of identity theft on the existing
virtio by mapping the same device, pushes the existing virtio to a
different name to hide it from udev to avoid naming confusion. We make
the device as dumb as can be and don't let it do any L2 configuration
such as assigning a MAC address or VLAN filter, we could probably flag
it as VLAN challenged. The XDP problem solves itself by us not
exposing any bpf or XDP operations. Then all that is left is dealing
with netpoll which if needed we can probably borrow the existing
approach from the bonding driver to solve.

Anyway that is the direction I see this going in.

Thanks.

- Alex

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

