Return-Path: virtio-dev-return-3251-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 9828A5818203
	for <virtio-dev@lists.oasis-open.org>; Wed, 21 Feb 2018 08:50:01 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180221161105.GC1996@nanopsycho>
References: <1518804682-16881-1-git-send-email-sridhar.samudrala@intel.com>
 <20180220104224.GA2031@nanopsycho> <CAKgT0UdU8PDXduzxp4kKfur-DLeFQSJj7-fhW_eTgVzd+AcViw@mail.gmail.com>
 <20180220162933.GD2031@nanopsycho> <509bbbf9-4db7-dc78-a05e-403452a7407a@intel.com>
 <20180220201410.GF2031@nanopsycho> <20180220143356.3467084d@cakuba.netronome.com>
 <20180221095159.GA1996@nanopsycho> <CAKgT0UdyhrVr=pYZb=AJq9sWWUVb_BadbJTcqY1AwHHTw8cmQw@mail.gmail.com>
 <20180221161105.GC1996@nanopsycho>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 21 Feb 2018 08:49:49 -0800
Message-ID: <CAKgT0Ud+6eiY7ycyju1SToeatH1R7KBDcUOqjn9Pu2k5uOr5Wg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [virtio-dev] Re: [RFC PATCH v3 0/3] Enable virtio_net to act as a backup for a
 passthru device
To: Jiri Pirko <jiri@resnulli.us>
Cc: Jakub Kicinski <kubakici@wp.pl>, "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stephen Hemminger <stephen@networkplumber.org>, David Miller <davem@davemloft.net>, Netdev <netdev@vger.kernel.org>, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, "Brandeburg, Jesse" <jesse.brandeburg@intel.com>, "Duyck, Alexander H" <alexander.h.duyck@intel.com>, Jason Wang <jasowang@redhat.com>, Siwei Liu <loseweigh@gmail.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Feb 21, 2018 at 8:11 AM, Jiri Pirko <jiri@resnulli.us> wrote:
> Wed, Feb 21, 2018 at 04:56:48PM CET, alexander.duyck@gmail.com wrote:
>>On Wed, Feb 21, 2018 at 1:51 AM, Jiri Pirko <jiri@resnulli.us> wrote:
>>> Tue, Feb 20, 2018 at 11:33:56PM CET, kubakici@wp.pl wrote:
>>>>On Tue, 20 Feb 2018 21:14:10 +0100, Jiri Pirko wrote:
>>>>> Yeah, I can see it now :( I guess that the ship has sailed and we are
>>>>> stuck with this ugly thing forever...
>>>>>
>>>>> Could you at least make some common code that is shared in between
>>>>> netvsc and virtio_net so this is handled in exacly the same way in both?
>>>>
>>>>IMHO netvsc is a vendor specific driver which made a mistake on what
>>>>behaviour it provides (or tried to align itself with Windows SR-IOV).
>>>>Let's not make a far, far more commonly deployed and important driver
>>>>(virtio) bug-compatible with netvsc.
>>>
>>> Yeah. netvsc solution is a dangerous precedent here and in my opinition
>>> it was a huge mistake to merge it. I personally would vote to unmerge it
>>> and make the solution based on team/bond.
>>>
>>>
>>>>
>>>>To Jiri's initial comments, I feel the same way, in fact I've talked to
>>>>the NetworkManager guys to get auto-bonding based on MACs handled in
>>>>user space.  I think it may very well get done in next versions of NM,
>>>>but isn't done yet.  Stephen also raised the point that not everybody is
>>>>using NM.
>>>
>>> Can be done in NM, networkd or other network management tools.
>>> Even easier to do this in teamd and let them all benefit.
>>>
>>> Actually, I took a stab to implement this in teamd. Took me like an hour
>>> and half.
>>>
>>> You can just run teamd with config option "kidnap" like this:
>>> # teamd/teamd -c '{"kidnap": true }'
>>>
>>> Whenever teamd sees another netdev to appear with the same mac as his,
>>> or whenever teamd sees another netdev to change mac to his,
>>> it enslaves it.
>>>
>>> Here's the patch (quick and dirty):
>>>
>>> Subject: [patch teamd] teamd: introduce kidnap feature
>>>
>>> Signed-off-by: Jiri Pirko <jiri@mellanox.com>
>>
>>So this doesn't really address the original problem we were trying to
>>solve. You asked earlier why the netdev name mattered and it mostly
>>has to do with configuration. Specifically what our patch is
>>attempting to resolve is the issue of how to allow a cloud provider to
>>upgrade their customer to SR-IOV support and live migration without
>>requiring them to reconfigure their guest. So the general idea with
>>our patch is to take a VM that is running with virtio_net only and
>>allow it to instead spawn a virtio_bypass master using the same netdev
>>name as the original virtio, and then have the virtio_net and VF come
>>up and be enslaved by the bypass interface. Doing it this way we can
>>allow for multi-vendor SR-IOV live migration support using a guest
>>that was originally configured for virtio only.
>>
>>The problem with your solution is we already have teaming and bonding
>>as you said. There is already a write-up from Red Hat on how to do it
>>(https://access.redhat.com/documentation/en-us/red_hat_virtualization/4.1/html/virtual_machine_management_guide/sect-migrating_virtual_machines_between_hosts).
>>That is all well and good as long as you are willing to keep around
>>two VM images, one for virtio, and one for SR-IOV with live migration.
>
> You don't need 2 images. You need only one. The one with the team setup.
> That's it. If another netdev with the same mac appears, teamd will
> enslave it and run traffic on it. If not, ok, you'll go only through
> virtio_net.

Isn't that going to cause the routing table to get messed up when we
rearrange the netdevs? We don't want to have an significant disruption
 in traffic when we are adding/removing the VF. It seems like we would
need to invalidate any entries that were configured for the virtio_net
and reestablish them on the new team interface. Part of the criteria
we have been working with is that we should be able to transition from
having a VF to not or vice versa without seeing any significant
disruption in the traffic.

Also how does this handle any static configuration? I am assuming that
everything here assumes the team will be brought up as soon as it is
seen and assigned a DHCP address.

The solution as you have proposed seems problematic at best. I don't
see how the team solution works without introducing some sort of
traffic disruption to either add/remove the VF and bring up/tear down
the team interface. At that point we might as well just give up on
this piece of live migration support entirely since the disruption was
what we were trying to avoid. We might as well just hotplug out the VF
and hotplug in a virtio at the same bus device and function number and
just let udev take care of renaming it for us. The idea was supposed
to be a seamless transition between the two interfaces.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

