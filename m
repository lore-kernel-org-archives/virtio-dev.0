Return-Path: virtio-dev-return-3273-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 409FA581910D
	for <virtio-dev@lists.oasis-open.org>; Sun, 25 Feb 2018 14:17:23 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180223160305.71fb2db2@xeon-e3>
References: <1518804682-16881-1-git-send-email-sridhar.samudrala@intel.com>
 <20180216183817.42b07af6@cakuba.netronome.com> <CAKgT0UfU9gV2Y7hWFQi0vJoD9kYeoq+7cXmwAjXeV5zxXHa3dQ@mail.gmail.com>
 <CADGSJ217HahFJsGmNXMD6SwWiK374+u_YET8QqdsmofCRFZr=Q@mail.gmail.com>
 <CAKgT0Uda7Bmzf06RMmD7hCVLr8hHQxaY8Fk7w9Qy=7Vi6NODwQ@mail.gmail.com> <20180223160305.71fb2db2@xeon-e3>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Sun, 25 Feb 2018 14:17:10 -0800
Message-ID: <CAKgT0Uc4sFv+Z+3H-_=6g-VeQgk_pPpPfbpu6U1Vct_GAXjwkw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [virtio-dev] Re: [RFC PATCH v3 0/3] Enable virtio_net to act as a backup for a
 passthru device
To: Stephen Hemminger <stephen@networkplumber.org>, Jakub Kicinski <kubakici@wp.pl>, "Michael S. Tsirkin" <mst@redhat.com>, Siwei Liu <loseweigh@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Jason Wang <jasowang@redhat.com>
Cc: Sridhar Samudrala <sridhar.samudrala@intel.com>, David Miller <davem@davemloft.net>, Netdev <netdev@vger.kernel.org>, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, "Brandeburg, Jesse" <jesse.brandeburg@intel.com>, "Duyck, Alexander H" <alexander.h.duyck@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Feb 23, 2018 at 4:03 PM, Stephen Hemminger
<stephen@networkplumber.org> wrote:
> (pruned to reduce thread)
>
> On Wed, 21 Feb 2018 16:17:19 -0800
> Alexander Duyck <alexander.duyck@gmail.com> wrote:
>
>> >>> FWIW two solutions that immediately come to mind is to export "backup"
>> >>> as phys_port_name of the backup virtio link and/or assign a name to the
>> >>> master like you are doing already.  I think team uses team%d and bond
>> >>> uses bond%d, soft naming of master devices seems quite natural in this
>> >>> case.
>> >>
>> >> I figured I had overlooked something like that.. Thanks for pointing
>> >> this out. Okay so I think the phys_port_name approach might resolve
>> >> the original issue. If I am reading things correctly what we end up
>> >> with is the master showing up as "ens1" for example and the backup
>> >> showing up as "ens1nbackup". Am I understanding that right?
>> >>
>> >> The problem with the team/bond%d approach is that it creates a new
>> >> netdevice and so it would require guest configuration changes.
>> >>
>> >>> IMHO phys_port_name == "backup" if BACKUP bit is set on slave virtio
>> >>> link is quite neat.
>> >>
>> >> I agree. For non-"backup" virio_net devices would it be okay for us to
>> >> just return -EOPNOTSUPP? I assume it would be and that way the legacy
>> >> behavior could be maintained although the function still exists.
>> >>
>> >>>> - When the 'active' netdev is unplugged OR not present on a destination
>> >>>>   system after live migration, the user will see 2 virtio_net netdevs.
>> >>>
>> >>> That's necessary and expected, all configuration applies to the master
>> >>> so master must exist.
>> >>
>> >> With the naming issue resolved this is the only item left outstanding.
>> >> This becomes a matter of form vs function.
>> >>
>> >> The main complaint about the "3 netdev" solution is a bit confusing to
>> >> have the 2 netdevs present if the VF isn't there. The idea is that
>> >> having the extra "master" netdev there if there isn't really a bond is
>> >> a bit ugly.
>> >
>> > Is it this uglier in terms of user experience rather than
>> > functionality? I don't want it dynamically changed between 2-netdev
>> > and 3-netdev depending on the presence of VF. That gets back to my
>> > original question and suggestion earlier: why not just hide the lower
>> > netdevs from udev renaming and such? Which important observability
>> > benefits users may get if exposing the lower netdevs?
>> >
>> > Thanks,
>> > -Siwei
>>
>> The only real advantage to a 2 netdev solution is that it looks like
>> the netvsc solution, however it doesn't behave like it since there are
>> some features like XDP that may not function correctly if they are
>> left enabled in the virtio_net interface.
>>
>> As far as functionality the advantage of not hiding the lower devices
>> is that they are free to be managed. The problem with pushing all of
>> the configuration into the upper device is that you are limited to the
>> intersection of the features of the lower devices. This can be
>> limiting for some setups as some VFs support things like more queues,
>> or better interrupt moderation options than others so trying to make
>> everything work with one config would be ugly.
>>
>
>
> Let's not make XDP the blocker for doing the best solution
> from the end user point of view. XDP is just yet another offload
> thing which needs to be handled.  The current backup device solution
> used in netvsc doesn't handle the full range of offload options
> (things like flow direction, DCB, etc); no one but the HW vendors
> seems to care.

XDP isn't the blocker here. As far as I am concerned we can go either
way, with a 2 netdev or a 3 netdev solution. We just need to make sure
we are aware of all the trade-offs, and make a decision one way or the
other. This is quickly turning into a bikeshed and I would prefer us
to all agree, or at least disagree and commit, on which way to go
before we burn more cycles on a patch set that seems to be getting
tied up in debate.

With the 2 netdev solution we have to limit the functionality so that
we don't break things when we bypass the guts of the driver to hand
traffic off to the VF. Then ends up meaning that we are stuck with an
extra qdisc and Tx queue lock in the transmit path of the VF, and we
cannot rely on any in-driver Rx functionality to work such as
in-driver XDP. However the advantage here is that this is how netvsc
is already doing things.

The issue with the 3 netdev solution is that you are stuck with 2
netdevs ("ens1", "ens1nbackup") when the VF is not present. It could
be argued this isn't a very elegant looking solution, especially when
the VF is not present. With virtio this makes more sense though as you
are still able to expose the full functionality of the lower device so
you don't have to strip or drop any of the existing net device ops if
the "backup" bit is present.

Ultimately I would have preferred to have the 3 netdev solution go
with virtio only as it would have allowed for healthy competition
between the two designs and we could have seen which one would have
ultimately won out, but if we have to decide this now we need to do so
before we put too much more effort into the patches as these end up
becoming two very different solutions, especially if we have to apply
the solution to both drivers. My preference would still be 3 netdevs
since we could apply this to netvsc without too many changes, but I
will agree with whatever conclusion we can come to in terms of how
this is supposed to work for both netvsc and virtio_bypass.

- Alex

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

