Return-Path: virtio-dev-return-3247-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 900135818036
	for <virtio-dev@lists.oasis-open.org>; Tue, 20 Feb 2018 13:02:45 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180220201410.GF2031@nanopsycho>
References: <1518804682-16881-1-git-send-email-sridhar.samudrala@intel.com>
 <20180220104224.GA2031@nanopsycho> <CAKgT0UdU8PDXduzxp4kKfur-DLeFQSJj7-fhW_eTgVzd+AcViw@mail.gmail.com>
 <20180220162933.GD2031@nanopsycho> <509bbbf9-4db7-dc78-a05e-403452a7407a@intel.com>
 <20180220201410.GF2031@nanopsycho>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 20 Feb 2018 13:02:33 -0800
Message-ID: <CAKgT0Uc2TcZhaxVfGRaD_2C1Dgoe+ax3xLh1FKbu1uUF4=k1qg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [virtio-dev] Re: [RFC PATCH v3 0/3] Enable virtio_net to act as a backup for a
 passthru device
To: Jiri Pirko <jiri@resnulli.us>
Cc: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stephen Hemminger <stephen@networkplumber.org>, David Miller <davem@davemloft.net>, Netdev <netdev@vger.kernel.org>, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, "Brandeburg, Jesse" <jesse.brandeburg@intel.com>, "Duyck, Alexander H" <alexander.h.duyck@intel.com>, Jakub Kicinski <kubakici@wp.pl>, Jason Wang <jasowang@redhat.com>, Siwei Liu <loseweigh@gmail.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Feb 20, 2018 at 12:14 PM, Jiri Pirko <jiri@resnulli.us> wrote:
> Tue, Feb 20, 2018 at 06:14:32PM CET, sridhar.samudrala@intel.com wrote:
>>On 2/20/2018 8:29 AM, Jiri Pirko wrote:
>>> Tue, Feb 20, 2018 at 05:04:29PM CET, alexander.duyck@gmail.com wrote:
>>> > On Tue, Feb 20, 2018 at 2:42 AM, Jiri Pirko <jiri@resnulli.us> wrote:
>>> > > Fri, Feb 16, 2018 at 07:11:19PM CET, sridhar.samudrala@intel.com wrote:
>>> > > > Patch 1 introduces a new feature bit VIRTIO_NET_F_BACKUP that can be
>>> > > > used by hypervisor to indicate that virtio_net interface should act as
>>> > > > a backup for another device with the same MAC address.
>>> > > >
>>> > > > Ppatch 2 is in response to the community request for a 3 netdev
>>> > > > solution.  However, it creates some issues we'll get into in a moment.
>>> > > > It extends virtio_net to use alternate datapath when available and
>>> > > > registered. When BACKUP feature is enabled, virtio_net driver creates
>>> > > > an additional 'bypass' netdev that acts as a master device and controls
>>> > > > 2 slave devices.  The original virtio_net netdev is registered as
>>> > > > 'backup' netdev and a passthru/vf device with the same MAC gets
>>> > > > registered as 'active' netdev. Both 'bypass' and 'backup' netdevs are
>>> > > > associated with the same 'pci' device.  The user accesses the network
>>> > > > interface via 'bypass' netdev. The 'bypass' netdev chooses 'active' netdev
>>> > > > as default for transmits when it is available with link up and running.
>>> > > Sorry, but this is ridiculous. You are apparently re-implemeting part
>>> > > of bonding driver as a part of NIC driver. Bond and team drivers
>>> > > are mature solutions, well tested, broadly used, with lots of issues
>>> > > resolved in the past. What you try to introduce is a weird shortcut
>>> > > that already has couple of issues as you mentioned and will certanly
>>> > > have many more. Also, I'm pretty sure that in future, someone comes up
>>> > > with ideas like multiple VFs, LACP and similar bonding things.
>>> > The problem with the bond and team drivers is they are too large and
>>> > have too many interfaces available for configuration so as a result
>>> > they can really screw this interface up.
>>> What? Too large is which sense? Why "too many interfaces" is a problem?
>>> Also, team has only one interface to userspace team-generic-netlink.
>>>
>>>
>>> > Essentially this is meant to be a bond that is more-or-less managed by
>>> > the host, not the guest. We want the host to be able to configure it
>>> How is it managed by the host? In your usecase the guest has 2 netdevs:
>>> virtio_net, pci vf.
>>> I don't see how host can do any managing of that, other than the
>>> obvious. But still, the active/backup decision is done in guest. This is
>>> a simple bond/team usecase. As I said, there is something needed to be
>>> implemented in userspace in order to handle re-appear of vf netdev.
>>> But that should be fairly easy to do in teamd.
>>
>>The host manages the active/backup decision by
>>- assigning the same MAC address to both VF and virtio interfaces
>>- setting a BACKUP feature bit on virtio that enables virtio to transparently
>>take
>>  over the VFs datapath.
>>- only enable one datapath at anytime so that packets don't get looped back
>>- during live migration enable virtio datapth, unplug vf on the source and
>>replug
>>  vf on the destination.
>>
>>The VM is not expected and doesn't have any control of setting the MAC
>>address
>>or bringing up/down the links.
>>
>>This is the model that is currently supported with netvsc driver on Azure.
>
> Yeah, I can see it now :( I guess that the ship has sailed and we are
> stuck with this ugly thing forever...
>
> Could you at least make some common code that is shared in between
> netvsc and virtio_net so this is handled in exacly the same way in both?
>
> The fact that the netvsc/virtio_net kidnaps a netdev only because it
> has the same mac is going to give me some serious nighmares...
> I think we need to introduce some more strict checks.

In order for that to work we need to settle on a model for these. The
issue is that netvsc is using what we refer to as the "2 netdev" model
where they don't expose the paravirtual interface as its own netdev.
The opinion of Jakub and others has been that we should do a "3
netdev" model in the case of virtio_net since otherwise we will lose
functionality such as in-driver XDP and have to deal with an extra set
of qdiscs and Tx queue locks on transmit path.

Really at this point I am good either way, but we need to probably
have Stephen, Jakub, and whoever else had an opinion on the matter
sort out the 2 vs 3 argument before we could proceed on that. Most of
patch 2 in the set can easily be broken out into a separate file later
if we decide to go that route.

Thanks.

- Alex

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

