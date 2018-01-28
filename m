Return-Path: virtio-dev-return-3093-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id C2B371CB807B
	for <virtio-dev@lists.oasis-open.org>; Sun, 28 Jan 2018 11:18:58 -0800 (PST)
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
 <e02e21a1-ab5d-132a-fb33-5e0ba42fc9ac@intel.com>
 <20180126215829.7b3c6bac@cakuba.netronome.com>
 <CAKgT0Ud4e9O-FoY242Kn_yBX7JWtL_i=yW+Y-MXQ9BGEVBEkgA@mail.gmail.com>
From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Message-ID: <f6737111-0015-007c-336b-c8c2793ee590@intel.com>
Date: Sun, 28 Jan 2018 11:18:45 -0800
MIME-Version: 1.0
In-Reply-To: <CAKgT0Ud4e9O-FoY242Kn_yBX7JWtL_i=yW+Y-MXQ9BGEVBEkgA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [virtio-dev] Re: [RFC PATCH net-next v2 2/2] virtio_net: Extend
 virtio to use VF datapath when available
To: Alexander Duyck <alexander.duyck@gmail.com>, Jakub Kicinski <kubakici@wp.pl>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Siwei Liu <loseweigh@gmail.com>, Stephen Hemminger <stephen@networkplumber.org>, David Miller <davem@davemloft.net>, Netdev <netdev@vger.kernel.org>, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, "Brandeburg, Jesse" <jesse.brandeburg@intel.com>, Alexander Duyck <alexander.h.duyck@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On 1/28/2018 9:35 AM, Alexander Duyck wrote:
> On Fri, Jan 26, 2018 at 9:58 PM, Jakub Kicinski <kubakici@wp.pl> wrote:
>> On Fri, 26 Jan 2018 21:33:01 -0800, Samudrala, Sridhar wrote:
>>>>> 3 netdev model breaks this configuration starting with the creation
>>>>> and naming of the 2 devices to udev needing to be aware of master and
>>>>> slave virtio-net devices.
>>>> I don't understand this comment.  There is one virtio-net device and
>>>> one "virtio-bond" netdev.  And user space has to be aware of the special
>>>> automatic arrangement anyway, because it can't touch the VF.  It
>>>> doesn't make any difference whether it ignores the VF or PV and VF.
>>>> It simply can't touch the slaves, no matter how many there are.
>>> If the userspace is not expected to touch the slaves, then why do we need to
>>> take extra effort to expose a netdev that is just not really useful.
>> You said:
>> "[user space] needs to be aware of master and slave virtio-net devices."
>>
>> I'm saying:
>> It has to be aware of the special arrangement whether there is an
>> explicit bond netdev or not.
> To clarify here the kernel should be aware that there is a device that
> is an aggregate of 2 other devices. It isn't as if we need to insert
> the new device "above" the virtio.
>
> I have been doing a bit of messing around with a few ideas and it
> seems like it would be better if we could replace the virtio interface
> with the virtio-bond, renaming my virt-bond concept to this since it
> is now supposedly going to live in the virtio driver, interface, and
> then push the original virtio down one layer and call it a
> virtio-backup. If I am not mistaken we could assign the same dev
> pointer used by the virtio netdev to the virtio-bond, and if we
> register it first with the "eth%d" name then udev will assume that the
> virtio-bond device is the original virtio and all existing scripts
> should just work with that. We then would want to change the name of
> the virtio interface with the backup feature bit set, maybe call it
> something like bkup-00:00:00 where the 00:00:00 would be the last 3
> octets of the MAC address. It should solve the issue of inserting an
> interface "above" the virtio by making the virtio-bond become the
> virtio. The only limitation is that we will probably need to remove
> the back-up if the virtio device is removed, however that was already
> a limitation of this solution and others like the netvsc solution
> anyway.

With 3 netdev model, if we make the the master virtio-net associated 
with the
real virtio pci device,  i think  the userspace scripts would not break.
If we go this route, i am still not clear on the purpose of exposing the 
bkup netdev.
Can we start with the 2 netdev model and move to 3 netdev model later if we
find out that there are limitiations with the 2 netdev model? I don't 
think this will
break any user API as the userspace is not expected to use the bkup netdev.

>
>>>>> Also, from a user experience point of view, loading a virtio-net with
>>>>> BACKUP feature enabled will now show 2 virtio-net netdevs.
>>>> One virtio-net and one virtio-bond, which represents what's happening.
>>> This again assumes that we want to represent a bond setup. Can't we
>>> treat this
>>> as virtio-net providing an alternate low-latency datapath by taking over
>>> VF datapath?
>> Bond is just a familiar name, we can call it something else if you
>> prefer.  The point is there are two data paths which can have
>> independent low-level settings and a higher level entity with
>> global settings which represents any path to the outside world.
>>
>> Hiding low-level netdevs from a lay user requires a generic solution.
> The last thing I think we should be doing is hiding the low level
> netdevs. It doesn't solve anythying. We are already trusting the owner
> of the VM enough to let them have root access of the VM. That means
> they can load/unload any driver they want. They don't have to use the
> kernel provided virtio driver, they could load their own. They could
> even do something like run DPDK on top of it, or they could run DPDK
> on top of the VF. In either case there is no way the bond would ever
> be created and all hiding devices does is make it easier to fix
> problems when something gets broken. Unless I am mistaken, and
> "security through obscurity" has somehow become a valid security
> model.
>
> As I mentioned to Sridhar on an off-list thread I think the goal
> should be to make it so that the user wants to use the virtio-bond,
> not make it so that they have no choice but to use it. The idea is we
> should be making things easier for the administrator of the VM, not
> harder.
>
>
When the hypervisor has enabled BACKUP bit along with a VF with the same
MAC address, the VM can use either VF only OR extended virtio with 
attached  VF.
Although there are 2 datapaths to the device, the hypervisor will enable 
only
one at any time.  The virtio via PF datapath is only enabled during live 
migration
when the VF is unplugged. If not, VF broadcasts/multicasts will get 
looped back
to the VM via the PF datapath. In the RFC path i was assuming that the 
VM can
use both datapaths and i had broadcasts/multicasts going over virtio 
datapath,
but i don' think it is a good idea.  It requires the device to disable 
broadcast
replication on the VFs.

Thanks
Sridhar

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

