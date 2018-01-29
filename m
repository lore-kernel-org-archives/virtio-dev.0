Return-Path: virtio-dev-return-3100-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 624831CB8089
	for <virtio-dev@lists.oasis-open.org>; Mon, 29 Jan 2018 12:09:19 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180129202113-mutt-send-email-mst@kernel.org>
References: <20180124004556-mutt-send-email-mst@kernel.org>
 <CADGSJ2308J=tb1B1zrPi0bFzqYSoLfJsRZxBg6wT+wuCfRO6vw@mail.gmail.com>
 <731db0a0-85e7-a88e-6e0e-c540086347b5@intel.com> <CADGSJ205yeyGV2nJ9Cr=FwPypxAHb12jx3WitS6UmWSJ9VP42Q@mail.gmail.com>
 <20180127000831-mutt-send-email-mst@kernel.org> <20180126144704.6e1a9628@cakuba.netronome.com>
 <5fa8c6c6-4a94-91fa-fdbb-ee7b624d703f@intel.com> <20180126183003.591cd5c5@cakuba.netronome.com>
 <20180128150237.35237d84@xeon-e3> <CAKgT0UfEHc6T4MbAwFjx4c2TK1hL-_eGDpSiBEY_ryN_4UaPoQ@mail.gmail.com>
 <20180129202113-mutt-send-email-mst@kernel.org>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 29 Jan 2018 12:09:16 -0800
Message-ID: <CAKgT0UdV_Vppykx7TVeRoOSmc+6E1eBPYoF0+8eP3qXfWgH0gw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [virtio-dev] Re: [RFC PATCH net-next v2 2/2] virtio_net: Extend
 virtio to use VF datapath when available
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, Jakub Kicinski <kubakici@wp.pl>, "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, Siwei Liu <loseweigh@gmail.com>, David Miller <davem@davemloft.net>, Netdev <netdev@vger.kernel.org>, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, "Brandeburg, Jesse" <jesse.brandeburg@intel.com>, Alexander Duyck <alexander.h.duyck@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Jan 29, 2018 at 10:24 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Sun, Jan 28, 2018 at 08:26:53PM -0800, Alexander Duyck wrote:
>> >> > For live migration with advanced usecases that Siwei is suggesting, i
>> >> > think we need a new driver with a new device type that can track the
>> >> > VF specific feature settings even when the VF driver is unloaded.
>> >
>> > I see no added value of the 3 netdev model, there is no need for a bond
>> > device.
>>
>> I agree a full-blown bond isn't what is needed. However, just forking
>> traffic out from virtio to a VF doesn't really solve things either.
>>
>> One of the issues as I see it is the fact that the qdisc model with
>> the merged device gets to be pretty ugly. There is the fact that every
>> packet that goes to the VF has to pass through the qdisc code twice.
>> There is the dual nature of the 2 netdev solution that also introduces
>> the potential for head-of-line blocking since the virtio could put
>> back pressure on the upper qdisc layer which could stall the VF
>> traffic when switching over. I hope we could avoid issues like that by
>> maintaining qdiscs per device queue instead of on an upper device that
>> is half software interface and half not. Ideally the virtio-bond
>> device could operate without a qdisc and without needing any
>> additional locks so there shouldn't be head of line blocking occurring
>> between the two interfaces and overhead could be kept minimal.
>>
>> Also in the case of virtio there is support for in-driver XDP. As
>> Sridhar stated, when using the 2 netdev model "we cannot support XDP
>> in this model and it needs to be disabled". That sounds like a step
>> backwards instead of forwards. I would much rather leave the XDP
>> enabled at the lower dev level, and then if we want we can use the
>> generic XDP at the virtio-bond level to capture traffic on both
>> interfaces at the same time.
>
> I agree dropping XDP makes everything very iffy.
>
>> In the case of netvsc you have control of both sides of a given link
>> so you can match up the RSS tables, queue configuration and everything
>> is somewhat symmetric since you are running the PF and all the HyperV
>> subchannels. Most of the complexity is pushed down into the host and
>> your subchannel management is synchronized there if I am not mistaken.
>> We don't have this in the case of this virtio-bond setup. Instead a
>> single bit is set indicating "backup" without indicating what that
>> means to topology other than the fact that this virtio interface is
>> the backup for some other interface. We are essentially blind other
>> than having the link status for the VF and virtio and knowing that the
>> virtio is intended to be the backup.
>
> Would you be interested in posting at least a proof of concept
> patch for this approach? It's OK if there are some TODO stubs.
> It would be much easier to compare code to code rather than
> a high level description to code.

That is the general idea. I was hoping to go the bonding route last
week but I got too snarled up trying to untangle the features we
didn't need. I have some code I am working on but don't have an ETA
for when it will be done.

At this point I am hoping we can build something based on Sridhar's
original patch that can addresses the items I brought up and shifts to
more of a 3 netdev model. If I am not mistaken we might be able to do
it as a separate driver that has a pair of calls that allow for
adding/removing a virt-bond that is provided with a MAC address and a
device pointer so that we can do the bits necessary to get ourselves
swapped with the original virtio device and identify the virtio as the
backup channel.

Thanks.

- Alex

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

