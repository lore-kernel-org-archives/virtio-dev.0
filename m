Return-Path: virtio-dev-return-3253-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 7CCB75818203
	for <virtio-dev@lists.oasis-open.org>; Wed, 21 Feb 2018 09:56:39 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180221165848.GD1996@nanopsycho>
References: <20180220104224.GA2031@nanopsycho> <CAKgT0UdU8PDXduzxp4kKfur-DLeFQSJj7-fhW_eTgVzd+AcViw@mail.gmail.com>
 <20180220162933.GD2031@nanopsycho> <509bbbf9-4db7-dc78-a05e-403452a7407a@intel.com>
 <20180220201410.GF2031@nanopsycho> <20180220143356.3467084d@cakuba.netronome.com>
 <20180221095159.GA1996@nanopsycho> <CAKgT0UdyhrVr=pYZb=AJq9sWWUVb_BadbJTcqY1AwHHTw8cmQw@mail.gmail.com>
 <20180221161105.GC1996@nanopsycho> <CAKgT0Ud+6eiY7ycyju1SToeatH1R7KBDcUOqjn9Pu2k5uOr5Wg@mail.gmail.com>
 <20180221165848.GD1996@nanopsycho>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 21 Feb 2018 09:56:35 -0800
Message-ID: <CAKgT0UeZS_SzNfiMX3ujy+a9WZWySVdyTpyQ=b=RJJrAG3JO=w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [virtio-dev] Re: [RFC PATCH v3 0/3] Enable virtio_net to act as a backup for a
 passthru device
To: Jiri Pirko <jiri@resnulli.us>
Cc: Jakub Kicinski <kubakici@wp.pl>, "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stephen Hemminger <stephen@networkplumber.org>, David Miller <davem@davemloft.net>, Netdev <netdev@vger.kernel.org>, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, "Brandeburg, Jesse" <jesse.brandeburg@intel.com>, "Duyck, Alexander H" <alexander.h.duyck@intel.com>, Jason Wang <jasowang@redhat.com>, Siwei Liu <loseweigh@gmail.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Feb 21, 2018 at 8:58 AM, Jiri Pirko <jiri@resnulli.us> wrote:
> Wed, Feb 21, 2018 at 05:49:49PM CET, alexander.duyck@gmail.com wrote:
>>On Wed, Feb 21, 2018 at 8:11 AM, Jiri Pirko <jiri@resnulli.us> wrote:
>>> Wed, Feb 21, 2018 at 04:56:48PM CET, alexander.duyck@gmail.com wrote:
>>>>On Wed, Feb 21, 2018 at 1:51 AM, Jiri Pirko <jiri@resnulli.us> wrote:
>>>>> Tue, Feb 20, 2018 at 11:33:56PM CET, kubakici@wp.pl wrote:
>>>>>>On Tue, 20 Feb 2018 21:14:10 +0100, Jiri Pirko wrote:
>>>>>>> Yeah, I can see it now :( I guess that the ship has sailed and we are
>>>>>>> stuck with this ugly thing forever...
>>>>>>>
>>>>>>> Could you at least make some common code that is shared in between
>>>>>>> netvsc and virtio_net so this is handled in exacly the same way in both?
>>>>>>
>>>>>>IMHO netvsc is a vendor specific driver which made a mistake on what
>>>>>>behaviour it provides (or tried to align itself with Windows SR-IOV).
>>>>>>Let's not make a far, far more commonly deployed and important driver
>>>>>>(virtio) bug-compatible with netvsc.
>>>>>
>>>>> Yeah. netvsc solution is a dangerous precedent here and in my opinition
>>>>> it was a huge mistake to merge it. I personally would vote to unmerge it
>>>>> and make the solution based on team/bond.
>>>>>
>>>>>
>>>>>>
>>>>>>To Jiri's initial comments, I feel the same way, in fact I've talked to
>>>>>>the NetworkManager guys to get auto-bonding based on MACs handled in
>>>>>>user space.  I think it may very well get done in next versions of NM,
>>>>>>but isn't done yet.  Stephen also raised the point that not everybody is
>>>>>>using NM.
>>>>>
>>>>> Can be done in NM, networkd or other network management tools.
>>>>> Even easier to do this in teamd and let them all benefit.
>>>>>
>>>>> Actually, I took a stab to implement this in teamd. Took me like an hour
>>>>> and half.
>>>>>
>>>>> You can just run teamd with config option "kidnap" like this:
>>>>> # teamd/teamd -c '{"kidnap": true }'
>>>>>
>>>>> Whenever teamd sees another netdev to appear with the same mac as his,
>>>>> or whenever teamd sees another netdev to change mac to his,
>>>>> it enslaves it.
>>>>>
>>>>> Here's the patch (quick and dirty):
>>>>>
>>>>> Subject: [patch teamd] teamd: introduce kidnap feature
>>>>>
>>>>> Signed-off-by: Jiri Pirko <jiri@mellanox.com>
>>>>
>>>>So this doesn't really address the original problem we were trying to
>>>>solve. You asked earlier why the netdev name mattered and it mostly
>>>>has to do with configuration. Specifically what our patch is
>>>>attempting to resolve is the issue of how to allow a cloud provider to
>>>>upgrade their customer to SR-IOV support and live migration without
>>>>requiring them to reconfigure their guest. So the general idea with
>>>>our patch is to take a VM that is running with virtio_net only and
>>>>allow it to instead spawn a virtio_bypass master using the same netdev
>>>>name as the original virtio, and then have the virtio_net and VF come
>>>>up and be enslaved by the bypass interface. Doing it this way we can
>>>>allow for multi-vendor SR-IOV live migration support using a guest
>>>>that was originally configured for virtio only.
>>>>
>>>>The problem with your solution is we already have teaming and bonding
>>>>as you said. There is already a write-up from Red Hat on how to do it
>>>>(https://access.redhat.com/documentation/en-us/red_hat_virtualization/4.1/html/virtual_machine_management_guide/sect-migrating_virtual_machines_between_hosts).
>>>>That is all well and good as long as you are willing to keep around
>>>>two VM images, one for virtio, and one for SR-IOV with live migration.
>>>
>>> You don't need 2 images. You need only one. The one with the team setup.
>>> That's it. If another netdev with the same mac appears, teamd will
>>> enslave it and run traffic on it. If not, ok, you'll go only through
>>> virtio_net.
>>
>>Isn't that going to cause the routing table to get messed up when we
>>rearrange the netdevs? We don't want to have an significant disruption
>> in traffic when we are adding/removing the VF. It seems like we would
>>need to invalidate any entries that were configured for the virtio_net
>>and reestablish them on the new team interface. Part of the criteria
>>we have been working with is that we should be able to transition from
>>having a VF to not or vice versa without seeing any significant
>>disruption in the traffic.
>
> What? You have routes on the team netdev. virtio_net and VF are only
> slaves. What are you talking about? I don't get it :/

So lets walk though this by example. The general idea of the base case
for all this is somebody starting with virtio_net, we will call the
interface "ens1" for now. It comes up and is assigned a dhcp address
and everything works as expected. Now in order to get better
performance we want to add a VF "ens2", but we don't want a new IP
address. Now if I understand correctly what will happen is that when
"ens2" appears on the system teamd will then create a new team
interface "team0". Before teamd can enslave ens1 it has to down the
interface if I understand things correctly. This means that we have to
disrupt network traffic in order for this to work.

To give you an idea of where we were before this became about trying
to do this in the team or bonding driver, we were debating a 2 netdev
model versus a 3 netdev model. I will call out the model and the
advantages/disadvantages of those below.

2 Netdev model, "ens1", enslaves "ens2".
- Requires dropping in-driver XDP in order to work (won't capture VF
traffic otherwise)
- VF takes performance hit for extra qdisc/Tx queue lock of virtio_net interface
- If you ass-u-me (I haven't been a fan of this model if you can't
tell) that it is okay to rip out in-driver XDP from virtio_net, then
you could transition between base virtio, virtio w/ backup bit set.
- Works for netvsc because they limit their features (no in-driver
XDP) to guarantee this works.

3 Netdev model, "ens1", enslaves "ens1nbackup" and "ens2"
- Exposes 2 netdevs "ens1" and "ens1nbackup" when only virtio is present
- No extra qdisc or locking
- All virtio_net original functionality still present
- Not able to transition from virtio to virtio w/ backup without
disruption (requires hot-plug)

The way I see it the only way your team setup could work would be
something closer to the 3 netdev model. Basically we would be
requiring the user to always have the team0 present in order to make
certain that anything like XDP would be run on the team interface
instead of assuming that the virtio_net could run by itself. I will
add it as a third option here to compare to the other 2.

3 Netdev "team" model, "team0", enslaves "ens1" and "ens2"
- Requires guest to configure teamd
- Exposes "team0" and "ens1" when only virtio is present
- No extra qdisc or locking
- Doesn't require "backup" bit in virtio

>>
>>Also how does this handle any static configuration? I am assuming that
>>everything here assumes the team will be brought up as soon as it is
>>seen and assigned a DHCP address.
>
> Again. You configure whatever you need on the team netdev.

Just so we are clear, are you then saying that the team0 interface
will always be present with this configuration? You had made it sound
like it would disappear if you didn't have at least 2 interfaces.

>>
>>The solution as you have proposed seems problematic at best. I don't
>>see how the team solution works without introducing some sort of
>>traffic disruption to either add/remove the VF and bring up/tear down
>>the team interface. At that point we might as well just give up on
>>this piece of live migration support entirely since the disruption was
>>what we were trying to avoid. We might as well just hotplug out the VF
>>and hotplug in a virtio at the same bus device and function number and
>>just let udev take care of renaming it for us. The idea was supposed
>>to be a seamless transition between the two interfaces.
>
> Alex. What you are trying to do in this patchset and what netvsc does it
> essentialy in-driver bonding. Same thing mechanism, rx_handler,
> everything. I don't really understand what are you talking about. With
> use of team you will get exactly the same behaviour.

So the goal of the "in-driver bonding" is to make the bonding as
non-intrusive as possible and require as little user intervention as
possible. I agree that much of the handling is the same, however the
control structure and requirements are significantly different. That
has been what I have been trying to explain. You keep wanting to use
the existing structures, but they don't really apply cleanly because
they push control for the interface up into the guest, and that
doesn't make much sense in the case of virtualization. What is
happening here is that we are exposing a bond that the guest should
have no control over, or at least as little as possible. In addition
making the user have to add additional configuration in the guest
means that there is that much more that can go wrong if they screw it
up.

The other problem here is that the transition needs to be as seamless
as possible between just a standard virtio_net setup and this new
setup. With either the team or bonding setup you end up essentially
forcing the guest to have the bond/team always there even if they are
running only a single interface. Only if they "upgrade" the VM by
adding a VF then it finally gets to do anything.

What this comes down to for us is the following requirements:
1. The name of the interface cannot change when going from virtio_net,
to virtio_net being bypassed using a VF. We cannot create an interface
on top of the interface, if anything we need to push the original
virtio_net out of the way so that the new team interface takes its
place in the configuration of the system. Otherwise a VM with VF w/
live migration will require a different configuration than one that
just runs virtio_net.
2. We need some way to signal if this VM should be running in an
"upgraded" mode or not. We have been using the backup bit in
virtio_net to do that. If it isn't "upgraded" then we don't need the
team/bond and we can just run with virtio_net.
3. We cannot introduce any downtime on the interface when adding a VF
or removing it. The link must stay up the entire time and be able to
handle packets.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

