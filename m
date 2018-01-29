Return-Path: virtio-dev-return-3096-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 00D6C1CB807A
	for <virtio-dev@lists.oasis-open.org>; Sun, 28 Jan 2018 16:59:09 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <b6bf20f8-8881-4d25-db4c-24f93d5e6cba@intel.com>
References: <1515736720-39368-1-git-send-email-sridhar.samudrala@intel.com>
 <CADGSJ22BsdB-hDb0xebSyWrwDuBJaFACjb26PDoqAd2Ah+tsQg@mail.gmail.com>
 <20180122233205-mutt-send-email-mst@kernel.org> <CADGSJ209vrdjnEAweLg84FwN3sf+1W+APmvB=NjFkMNAhsOyrg@mail.gmail.com>
 <20180124004556-mutt-send-email-mst@kernel.org> <CADGSJ2308J=tb1B1zrPi0bFzqYSoLfJsRZxBg6wT+wuCfRO6vw@mail.gmail.com>
 <731db0a0-85e7-a88e-6e0e-c540086347b5@intel.com> <CADGSJ205yeyGV2nJ9Cr=FwPypxAHb12jx3WitS6UmWSJ9VP42Q@mail.gmail.com>
 <20180127000831-mutt-send-email-mst@kernel.org> <20180126144704.6e1a9628@cakuba.netronome.com>
 <5fa8c6c6-4a94-91fa-fdbb-ee7b624d703f@intel.com> <20180126183003.591cd5c5@cakuba.netronome.com>
 <e02e21a1-ab5d-132a-fb33-5e0ba42fc9ac@intel.com> <20180126215829.7b3c6bac@cakuba.netronome.com>
 <CAKgT0Ud4e9O-FoY242Kn_yBX7JWtL_i=yW+Y-MXQ9BGEVBEkgA@mail.gmail.com>
 <f6737111-0015-007c-336b-c8c2793ee590@intel.com> <CAKgT0UdaKtPe6982TuuGbxhhVgeehwS1aAp=s4sok2vKD6wMJg@mail.gmail.com>
 <b6bf20f8-8881-4d25-db4c-24f93d5e6cba@intel.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Sun, 28 Jan 2018 16:58:56 -0800
Message-ID: <CAKgT0UcF=Gb5JnFJ=DV8s-X8swKUwjsZ6CEXyjnRovBREoBDNA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [virtio-dev] Re: [RFC PATCH net-next v2 2/2] virtio_net: Extend
 virtio to use VF datapath when available
To: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Cc: Jakub Kicinski <kubakici@wp.pl>, "Michael S. Tsirkin" <mst@redhat.com>, Siwei Liu <loseweigh@gmail.com>, Stephen Hemminger <stephen@networkplumber.org>, David Miller <davem@davemloft.net>, Netdev <netdev@vger.kernel.org>, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, "Brandeburg, Jesse" <jesse.brandeburg@intel.com>, Alexander Duyck <alexander.h.duyck@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Sun, Jan 28, 2018 at 1:01 PM, Samudrala, Sridhar
<sridhar.samudrala@intel.com> wrote:
>
>
> On 1/28/2018 12:18 PM, Alexander Duyck wrote:
>>
>> On Sun, Jan 28, 2018 at 11:18 AM, Samudrala, Sridhar
>> <sridhar.samudrala@intel.com> wrote:
>>>
>>> On 1/28/2018 9:35 AM, Alexander Duyck wrote:
>>>>
>>>> On Fri, Jan 26, 2018 at 9:58 PM, Jakub Kicinski <kubakici@wp.pl> wrote:
>>>>>
>>>>> On Fri, 26 Jan 2018 21:33:01 -0800, Samudrala, Sridhar wrote:
>>>>>>>>
>>>>>>>> 3 netdev model breaks this configuration starting with the creation
>>>>>>>> and naming of the 2 devices to udev needing to be aware of master
>>>>>>>> and
>>>>>>>> slave virtio-net devices.
>>>>>>>
>>>>>>> I don't understand this comment.  There is one virtio-net device and
>>>>>>> one "virtio-bond" netdev.  And user space has to be aware of the
>>>>>>> special
>>>>>>> automatic arrangement anyway, because it can't touch the VF.  It
>>>>>>> doesn't make any difference whether it ignores the VF or PV and VF.
>>>>>>> It simply can't touch the slaves, no matter how many there are.
>>>>>>
>>>>>> If the userspace is not expected to touch the slaves, then why do we
>>>>>> need to
>>>>>> take extra effort to expose a netdev that is just not really useful.
>>>>>
>>>>> You said:
>>>>> "[user space] needs to be aware of master and slave virtio-net
>>>>> devices."
>>>>>
>>>>> I'm saying:
>>>>> It has to be aware of the special arrangement whether there is an
>>>>> explicit bond netdev or not.
>>>>
>>>> To clarify here the kernel should be aware that there is a device that
>>>> is an aggregate of 2 other devices. It isn't as if we need to insert
>>>> the new device "above" the virtio.
>>>>
>>>> I have been doing a bit of messing around with a few ideas and it
>>>> seems like it would be better if we could replace the virtio interface
>>>> with the virtio-bond, renaming my virt-bond concept to this since it
>>>> is now supposedly going to live in the virtio driver, interface, and
>>>> then push the original virtio down one layer and call it a
>>>> virtio-backup. If I am not mistaken we could assign the same dev
>>>> pointer used by the virtio netdev to the virtio-bond, and if we
>>>> register it first with the "eth%d" name then udev will assume that the
>>>> virtio-bond device is the original virtio and all existing scripts
>>>> should just work with that. We then would want to change the name of
>>>> the virtio interface with the backup feature bit set, maybe call it
>>>> something like bkup-00:00:00 where the 00:00:00 would be the last 3
>>>> octets of the MAC address. It should solve the issue of inserting an
>>>> interface "above" the virtio by making the virtio-bond become the
>>>> virtio. The only limitation is that we will probably need to remove
>>>> the back-up if the virtio device is removed, however that was already
>>>> a limitation of this solution and others like the netvsc solution
>>>> anyway.
>>>
>>>
>>> With 3 netdev model, if we make the the master virtio-net associated with
>>> the
>>> real virtio pci device,  i think  the userspace scripts would not break.
>>> If we go this route, i am still not clear on the purpose of exposing the
>>> bkup netdev.
>>> Can we start with the 2 netdev model and move to 3 netdev model later if
>>> we
>>> find out that there are limitiations with the 2 netdev model? I don't
>>> think
>>> this will
>>> break any user API as the userspace is not expected to use the bkup
>>> netdev.
>>
>> The 2 netdev model breaks a large number of expectations of user
>> space. Among them is XDP since we cannot guarantee a symmetric setup
>> between any entity and the virtio. How does it make sense that
>> enabling XDP on virtio shows zero Rx packets, and in the meantime you
>> are getting all of the packets coming in off of the VF?
>
> Sure we cannot support XDP in this model and it needs to be disabled.
>>
>>
>> In addition we would need to rewrite the VLAN and MAC address
>> filtering ndo operations since we likely cannot add any VLANs since in
>> most cases VFs are VLAN locked due to things like port VLAN and we
>> cannot change the MAC address since the whole bonding concept is built
>> around it.
>>
>> The last bit is the netpoll packet routing which the current code
>> assumes is using the virtio only, but I don't know if that is a valid
>> assumption since the VF is expected to be the default route for
>> everything else when it is available.
>>
>> The point is by the time you are done you will have rewritten pretty
>> much all the network device ops. With that being the case why add all
>> the code to virtio itself instead of just coming up with a brand new
>> set of ndo_ops that belong to this new device, and you could leave the
>> existing virtio code in place and save yourself a bunch of time by
>> just accessing it as an existing call as a separate netdev.
>
>
> When the BACKUP feature is enabled, we can simply disable most of these ndo
> ops
> that cannot be supported. Not sure we need an additional netdev and ndo_ops.

The point is feature bits have to be changed, and network
device/ethtool ops have to be rewritten. At that point you have
essentially forked the virtio interface. What I don't understand is
what your resistance is to doing this as 3 netdevs? I thought the
original issue was the fact that the bond-like interface would come up
with a different name/ID. I think we have a solution for that at this
point. I think the bigger issue is that this 2 netdev approach is far
to invasive to be done in the virtio driver itself and would require
massive changes to it. It makes more sense to just put together a
small new netdev that basically does the "dumb-bond" solution.

> When we can support all these usecases along with live migration we can move
> to the 3 netdev model and i think we will need a new feature bit so that the
> hypervisor can allow VM to use both datapaths and configure PF accordingly.

Right now you aren't supporting any of the use cases you claim to. The
code as it stands is full of corner cases. I have already pointed out
several holes in the code that were overlooked that are going to sink
the whole concept if we were to try to push something like this into
production.

On Thursday I tried seeing how hard it would be to make bonding fit
into the model we need. The bonding driver is carrying a TON of extra
bloat and technical debt that we don't need at this point since it has
all the MII/ARP code, sysfs, procfs, debugfs, notifiers, and modes
that we don't want. Trying to cut out that code and make something
that would be usable for this is probably going to be too expensive in
the long run. In the meantime though I think I have developed an
appreciation of where both solutions are currently lacking.

I think implementing another netdev at this point is the only way to
go forward, otherwise what is going to happen is that virtio is going
to quickly bloat up with a bunch of code that has to disable almost
everything in it if BACKUP is enabled as a feature. So here are the
list of netdev ops for virtio:
        .ndo_open            = virtnet_open,
        .ndo_stop            = virtnet_close,

I assume these first 2 will need some changes. I suspect there would
be threads responsible for doing things like maintaining the link
statistics that need to be collected periodically. Also I don't know
if you want to keep the slaves up if the master is up or not. In
addition I don't see any code in your current solution that calls
dev_open. I am assuming something was probably bringing up the
interface for you and then you enslaved it instead of the virtio
interface bringing up the interface itself.

        .ndo_start_xmit      = start_xmit,

Your original patch included a small set of changes for this function.
One thing you appear to have overlooked was the fact that
qdisc_skb_cb(skb)->slave_dev_queue_mapping relies on ndo_select_queue.
It means you are missing at least one new ndo_op that is not currently
provided by virtio. In addition we may want to look at providing a
change of the queue mapping for the combined interface since the VF
may support more queues than the virtio currently does. In my mind we
probably don't even need a qdisc for the upper level device anyway. We
could probably improve our performance if we could make the device not
have a qdisc and even more if we could make it run with LLTX since the
lower device has both covered for us already.

        .ndo_validate_addr   = eth_validate_addr,
        .ndo_set_mac_address = virtnet_set_mac_address,
        .ndo_set_rx_mode     = virtnet_set_rx_mode,

I already mentioned most of the L2 address/filtering code would
probably have to go since the VF drivers aren't usually allowed to do
things like go into full promiscuous or change their MAC address
anyway, and we don't want the address of a MAC address based bond to
be changed.

        .ndo_get_stats64     = virtnet_stats,

You already modified this in your first rev of the patch.  Your
solution is okay I suppose, though it might be more interesting if you
could just provide a merged version of the stats of the 2 interfaces
instead of just capturing some of the Tx/Rx stats.

        .ndo_vlan_rx_add_vid = virtnet_vlan_rx_add_vid,
        .ndo_vlan_rx_kill_vid = virtnet_vlan_rx_kill_vid,

These can both go since we could assume the combined interface is more
than likely "VLAN challenged" due to the fact that the primary use
case is VF migration. Otherwise we need to be able to guarantee that
any VLAN added to the interface is present on both the VF and the
virtio. Since that is extra work just calling the interface "VLAN
challenged" for now is easier.

#ifdef CONFIG_NET_POLL_CONTROLLER
        .ndo_poll_controller = virtnet_netpoll,
#endif

The polling logic needs to be updated so that the polling follows the
Tx packet path instead of just assuming everything is running through
virtio since a backup interface may or may not be capable of
transmitting packets when not in use.

        .ndo_bpf                = virtnet_xdp,
        .ndo_xdp_xmit           = virtnet_xdp_xmit,
        .ndo_xdp_flush          = virtnet_xdp_flush,

This whole block would have to be dropped for the combined interface.
That way we will at least get symmetric behavior between a VF and the
virtio data paths.

        .ndo_features_check     = passthru_features_check,

This part can mostly stay, but as I said the feature bits are going to
have to significantly change for the interface that is sitting on top
of the VF and virtio since the feature functionality likely differs
quite a bit.



I would go through the ethtool ops, but the fact is most of them just
don't apply. All bond implements is the get_drvinfo, get_link, and
get_link_ksettings and that is probably all that would be needed for
the virtio-bond interface.



Hopefully that clarifies things. In my mind the 2 netdev approach
would be the approach to consider for later. For now it is probably
easier to just have the virtio-bond, virtio-backup, and the VF all
present as it makes it easier to get away with just reusing existing
code since all the needed ops are exposed by the netdevs. Hiding them
is going to make things more difficult for debugging so I am strongly
opposed to hiding things.

I realize I told you I was willing to disagree and commit on this, but
after spending a full day reviewing the solution proposed and spending
some time crawling through the bonding code to get a better grasp of
things I am going to have to say the 2 netdev approach just isn't
feasible. We need to have 3 separate netdevs exposing 3 separate sets
of ndo/ethtool ops in order for things to work correctly. Anything
else is going to end up severely impacting features and/or
performance.

- Alex

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

