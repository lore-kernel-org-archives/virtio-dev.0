Return-Path: virtio-dev-return-3098-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 3EDDF1CB807D
	for <virtio-dev@lists.oasis-open.org>; Sun, 28 Jan 2018 20:26:57 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180128150237.35237d84@xeon-e3>
References: <1515736720-39368-1-git-send-email-sridhar.samudrala@intel.com>
 <1515736720-39368-3-git-send-email-sridhar.samudrala@intel.com>
 <CADGSJ22BsdB-hDb0xebSyWrwDuBJaFACjb26PDoqAd2Ah+tsQg@mail.gmail.com>
 <20180122233205-mutt-send-email-mst@kernel.org> <CADGSJ209vrdjnEAweLg84FwN3sf+1W+APmvB=NjFkMNAhsOyrg@mail.gmail.com>
 <20180124004556-mutt-send-email-mst@kernel.org> <CADGSJ2308J=tb1B1zrPi0bFzqYSoLfJsRZxBg6wT+wuCfRO6vw@mail.gmail.com>
 <731db0a0-85e7-a88e-6e0e-c540086347b5@intel.com> <CADGSJ205yeyGV2nJ9Cr=FwPypxAHb12jx3WitS6UmWSJ9VP42Q@mail.gmail.com>
 <20180127000831-mutt-send-email-mst@kernel.org> <20180126144704.6e1a9628@cakuba.netronome.com>
 <5fa8c6c6-4a94-91fa-fdbb-ee7b624d703f@intel.com> <20180126183003.591cd5c5@cakuba.netronome.com>
 <20180128150237.35237d84@xeon-e3>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Sun, 28 Jan 2018 20:26:53 -0800
Message-ID: <CAKgT0UfEHc6T4MbAwFjx4c2TK1hL-_eGDpSiBEY_ryN_4UaPoQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [virtio-dev] Re: [RFC PATCH net-next v2 2/2] virtio_net: Extend
 virtio to use VF datapath when available
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Jakub Kicinski <kubakici@wp.pl>, "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Siwei Liu <loseweigh@gmail.com>, David Miller <davem@davemloft.net>, Netdev <netdev@vger.kernel.org>, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, "Brandeburg, Jesse" <jesse.brandeburg@intel.com>, Alexander Duyck <alexander.h.duyck@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Sun, Jan 28, 2018 at 3:02 PM, Stephen Hemminger
<stephen@networkplumber.org> wrote:
> On Fri, 26 Jan 2018 18:30:03 -0800
> Jakub Kicinski <kubakici@wp.pl> wrote:
>
>> On Fri, 26 Jan 2018 15:30:35 -0800, Samudrala, Sridhar wrote:
>> > On 1/26/2018 2:47 PM, Jakub Kicinski wrote:
>> > > On Sat, 27 Jan 2018 00:14:20 +0200, Michael S. Tsirkin wrote:
>> > >> On Fri, Jan 26, 2018 at 01:46:42PM -0800, Siwei Liu wrote:
>> > >>>> and the VM is not expected to do any tuning/optimizations on the VF driver
>> > >>>> directly,
>> > >>>> i think the current patch that follows the netvsc model of 2 netdevs(virtio
>> > >>>> and vf) should
>> > >>>> work fine.
>> > >>> OK. For your use case that's fine. But that's too specific scenario
>> > >>> with lots of restrictions IMHO, perhaps very few users will benefit
>> > >>> from it, I'm not sure. If you're unwilling to move towards it, we'd
>> > >>> take this one and come back with a generic solution that is able to
>> > >>> address general use cases for VF/PT live migration .
>> > >> I think that's a fine approach. Scratch your own itch!  I imagine a very
>> > >> generic virtio-switchdev providing host routing info to guests could
>> > >> address lots of usecases. A driver could bind to that one and enslave
>> > >> arbitrary other devices.  Sounds reasonable.
>> > >>
>> > >> But given the fundamental idea of a failover was floated at least as
>> > >> early as 2013, and made 0 progress since precisely because it kept
>> > >> trying to address more and more features, and given netvsc is already
>> > >> using the basic solution with some success, I'm not inclined to block
>> > >> this specific effort waiting for the generic one.
>> > > I think there is an agreement that the extra netdev will be useful for
>> > > more advanced use cases, and is generally preferable.  What is the
>> > > argument for not doing that from the start?  If it was made I must have
>> > > missed it.  Is it just unwillingness to write the extra 300 lines of
>> > > code?  Sounds like a pretty weak argument when adding kernel ABI is at
>> > > stake...
>> >
>> > I am still not clear on the need for the extra netdev created by
>> > virtio_net. The only advantage i can see is that the stats can be
>> > broken between VF and virtio datapaths compared to the aggregrated
>> > stats on virtio netdev as seen with the 2 netdev approach.
>>
>> Maybe you're not convinced but multiple arguments were made.
>>
>> > With 2 netdev model, any VM image that has a working network
>> > configuration will transparently get VF based acceleration without
>> > any changes.
>>
>> Nothing happens transparently.  Things may happen automatically.  The
>> VF netdev doesn't disappear with netvsc.  The PV netdev transforms into
>> something it did not use to be.  And configures and reports some
>> information from the PV (e.g. speed) but PV doesn't pass traffic any
>> longer.
>>
>> > 3 netdev model breaks this configuration starting with the creation
>> > and naming of the 2 devices to udev needing to be aware of master and
>> > slave virtio-net devices.
>>
>> I don't understand this comment.  There is one virtio-net device and
>> one "virtio-bond" netdev.  And user space has to be aware of the special
>> automatic arrangement anyway, because it can't touch the VF.  It
>> doesn't make any difference whether it ignores the VF or PV and VF.
>> It simply can't touch the slaves, no matter how many there are.
>>
>> > Also, from a user experience point of view, loading a virtio-net with
>> > BACKUP feature enabled will now show 2 virtio-net netdevs.
>>
>> One virtio-net and one virtio-bond, which represents what's happening.
>>
>> > For live migration with advanced usecases that Siwei is suggesting, i
>> > think we need a new driver with a new device type that can track the
>> > VF specific feature settings even when the VF driver is unloaded.
>
> I see no added value of the 3 netdev model, there is no need for a bond
> device.

I agree a full-blown bond isn't what is needed. However, just forking
traffic out from virtio to a VF doesn't really solve things either.

One of the issues as I see it is the fact that the qdisc model with
the merged device gets to be pretty ugly. There is the fact that every
packet that goes to the VF has to pass through the qdisc code twice.
There is the dual nature of the 2 netdev solution that also introduces
the potential for head-of-line blocking since the virtio could put
back pressure on the upper qdisc layer which could stall the VF
traffic when switching over. I hope we could avoid issues like that by
maintaining qdiscs per device queue instead of on an upper device that
is half software interface and half not. Ideally the virtio-bond
device could operate without a qdisc and without needing any
additional locks so there shouldn't be head of line blocking occurring
between the two interfaces and overhead could be kept minimal.

Also in the case of virtio there is support for in-driver XDP. As
Sridhar stated, when using the 2 netdev model "we cannot support XDP
in this model and it needs to be disabled". That sounds like a step
backwards instead of forwards. I would much rather leave the XDP
enabled at the lower dev level, and then if we want we can use the
generic XDP at the virtio-bond level to capture traffic on both
interfaces at the same time.

In the case of netvsc you have control of both sides of a given link
so you can match up the RSS tables, queue configuration and everything
is somewhat symmetric since you are running the PF and all the HyperV
subchannels. Most of the complexity is pushed down into the host and
your subchannel management is synchronized there if I am not mistaken.
We don't have this in the case of this virtio-bond setup. Instead a
single bit is set indicating "backup" without indicating what that
means to topology other than the fact that this virtio interface is
the backup for some other interface. We are essentially blind other
than having the link status for the VF and virtio and knowing that the
virtio is intended to be the backup.

We might be able to get to a 2 or maybe even a 1 netdev solution at
some point in the future, but  I don't think that time is now. For now
a virtio-bond type solution would allow us to address most of the use
cases with minimal modification to the existing virtio and can deal
with feature and/or resource asymmetry.

- Alex

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

