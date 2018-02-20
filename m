Return-Path: virtio-dev-return-3246-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id B904758191F8
	for <virtio-dev@lists.oasis-open.org>; Tue, 20 Feb 2018 09:23:52 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180220162933.GD2031@nanopsycho>
References: <1518804682-16881-1-git-send-email-sridhar.samudrala@intel.com>
 <20180220104224.GA2031@nanopsycho> <CAKgT0UdU8PDXduzxp4kKfur-DLeFQSJj7-fhW_eTgVzd+AcViw@mail.gmail.com>
 <20180220162933.GD2031@nanopsycho>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 20 Feb 2018 09:23:49 -0800
Message-ID: <CAKgT0UehiC9O6JW9kjc+h9oHiHnCsqfExzawq+N51yV2tb=zwA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [virtio-dev] Re: [RFC PATCH v3 0/3] Enable virtio_net to act as a backup for a
 passthru device
To: Jiri Pirko <jiri@resnulli.us>
Cc: Sridhar Samudrala <sridhar.samudrala@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stephen Hemminger <stephen@networkplumber.org>, David Miller <davem@davemloft.net>, Netdev <netdev@vger.kernel.org>, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, "Brandeburg, Jesse" <jesse.brandeburg@intel.com>, "Duyck, Alexander H" <alexander.h.duyck@intel.com>, Jakub Kicinski <kubakici@wp.pl>, Jason Wang <jasowang@redhat.com>, Siwei Liu <loseweigh@gmail.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Feb 20, 2018 at 8:29 AM, Jiri Pirko <jiri@resnulli.us> wrote:
> Tue, Feb 20, 2018 at 05:04:29PM CET, alexander.duyck@gmail.com wrote:
>>On Tue, Feb 20, 2018 at 2:42 AM, Jiri Pirko <jiri@resnulli.us> wrote:
>>> Fri, Feb 16, 2018 at 07:11:19PM CET, sridhar.samudrala@intel.com wrote:
>>>>Patch 1 introduces a new feature bit VIRTIO_NET_F_BACKUP that can be
>>>>used by hypervisor to indicate that virtio_net interface should act as
>>>>a backup for another device with the same MAC address.
>>>>
>>>>Ppatch 2 is in response to the community request for a 3 netdev
>>>>solution.  However, it creates some issues we'll get into in a moment.
>>>>It extends virtio_net to use alternate datapath when available and
>>>>registered. When BACKUP feature is enabled, virtio_net driver creates
>>>>an additional 'bypass' netdev that acts as a master device and controls
>>>>2 slave devices.  The original virtio_net netdev is registered as
>>>>'backup' netdev and a passthru/vf device with the same MAC gets
>>>>registered as 'active' netdev. Both 'bypass' and 'backup' netdevs are
>>>>associated with the same 'pci' device.  The user accesses the network
>>>>interface via 'bypass' netdev. The 'bypass' netdev chooses 'active' netdev
>>>>as default for transmits when it is available with link up and running.
>>>
>>> Sorry, but this is ridiculous. You are apparently re-implemeting part
>>> of bonding driver as a part of NIC driver. Bond and team drivers
>>> are mature solutions, well tested, broadly used, with lots of issues
>>> resolved in the past. What you try to introduce is a weird shortcut
>>> that already has couple of issues as you mentioned and will certanly
>>> have many more. Also, I'm pretty sure that in future, someone comes up
>>> with ideas like multiple VFs, LACP and similar bonding things.
>>
>>The problem with the bond and team drivers is they are too large and
>>have too many interfaces available for configuration so as a result
>>they can really screw this interface up.
>
> What? Too large is which sense? Why "too many interfaces" is a problem?
> Also, team has only one interface to userspace team-generic-netlink.

Specifically I was working with bond. I had overlooked team for the
most part since it required an additional userspace daemon which
basically broke our requirement of no user-space intervention.

I was trying to focus on just doing an active/backup setup. The
problem is there are debugfs, sysfs, and procfs interfaces exposed
that we don't need and/or want. Adding any sort of interface to
exclude these would just bloat up the bonding driver, and leaving them
in would just be confusing since they would all need to be ignored. In
addition the steps needed to get the name to come out the same as the
original virtio interface would just bloat up bonding.

>>
>>Essentially this is meant to be a bond that is more-or-less managed by
>>the host, not the guest. We want the host to be able to configure it
>
> How is it managed by the host? In your usecase the guest has 2 netdevs:
> virtio_net, pci vf.
> I don't see how host can do any managing of that, other than the
> obvious. But still, the active/backup decision is done in guest. This is
> a simple bond/team usecase. As I said, there is something needed to be
> implemented in userspace in order to handle re-appear of vf netdev.
> But that should be fairly easy to do in teamd.
>
>
>>and have it automatically kick in on the guest. For now we want to
>>avoid adding too much complexity as this is meant to be just the first
>
> That's what I fear, "for now"..

I used the expression "for now" as I see this being the first stage of
a multi-stage process.

Step 1 is to get a basic virtio-bypass driver added to virtio so that
it is at least comparable to netvsc in terms of feature set and
enables basic network live migration.

Step 2 is adding some sort of dirty page tracking, preferably via
something like a paravirtual iommu interface. Once we have that we can
defer the eviction of the VF until the very last moment of the live
migration. For now I need to work on testing a modification to allow
mapping the entire guest as being pass-through for DMA to the device,
and requiring dynamic for any DMA that is bidirectional or from the
device.

Step 3 will be to start looking at advanced configuration. That is
where we drop the implementation in step 1 and instead look at
spawning something that looks more like the team type interface,
however instead of working with a user-space daemon we would likely
need to work with some sort of mailbox or message queue coming up from
the hypervisor. Then we can start looking at doing things like passing
up blocks of eBPF code to handle Tx port selection or whatever we
need.

>
>>step. Trying to go in and implement the whole solution right from the
>>start based on existing drivers is going to be a massive time sink and
>>will likely never get completed due to the fact that there is always
>>going to be some other thing that will interfere.
>
> "implement the whole solution right from the start based on existing
> drivers" - what solution are you talking about? I don't understand this
> para.

You started mentioning much more complex configurations such as
multi-VF, LACP, and other such things. I fully own that this cannot
support that. My understanding is that the netvsc solution that is out
there cannot support anything like that either. The idea for now is to
keep this as simple as possible. It makes things like the possibility
of porting this to other OSes much easier.

>>
>>My personal hope is that we can look at doing a virtio-bond sort of
>>device that will handle all this as well as providing a communication
>>channel, but that is much further down the road. For now we only have
>>a single bit so the goal for now is trying to keep this as simple as
>>possible.
>
> Oh. So there is really intention to do re-implementation of bonding
> in virtio. That is plain-wrong in my opinion.
>
> Could you just use bond/team, please, and don't reinvent the wheel with
> this abomination?

So I have a question for you. Why did you create the team driver? The
bonding code was already there and does almost exactly the same thing.
I would think it has to do with where things are managed. That is the
same situation we have with this.

In my mind I don't see this something where we can just fit it into
one of these two drivers because of the same reason the bonding and
team drivers are split. We want to manage this interface somewhere
else. In my mind what we probably need to do is look at refactoring
the code since the control paths are in different locations for each
of these drivers, but much of the datapath is the same. That is where
I see things going eventually for this "virtio-bond" interface I
referenced, but for now this interface is not that since there isn't
really any communication channel present at all.

>>
>>> What is the reason for this abomination? According to:
>>> https://marc.info/?l=linux-virtualization&m=151189725224231&w=2
>>> The reason is quite weak.
>>> User in the vm sees 2 (or more) netdevices, he puts them in bond/team
>>> and that's it. This works now! If the vm lacks some userspace features,
>>> let's fix it there! For example the MAC changes is something that could
>>> be easily handled in teamd userspace deamon.
>>
>>I think you might have missed the point of this. This is meant to be a
>>simple interface so the guest should not be able to change the MAC
>>address, and it shouldn't require any userspace daemon to setup or
>>tear down. Ideally with this solution the virtio bypass will come up
>>and be assigned the name of the original virtio, and the "backup"
>>interface will come up and be assigned the name of the original virtio
>>with an additional "nbackup" tacked on via the phys_port_name, and
>>then whenever a VF is added it will automatically be enslaved by the
>>bypass interface, and it will be removed when the VF is hotplugged
>>out.
>>
>>In my mind the difference between this and bond or team is where the
>>configuration interface lies. In the case of bond it is in the kernel.
>>If my understanding is correct team is mostly in user space. With this
>>the configuration interface is really down in the hypervisor and
>>requests are communicated up to the guest. I would prefer not to make
>>virtio_net dependent on the bonding or team drivers, or worse yet a
>>userspace daemon in the guest. For now I would argue we should keep
>>this as simple as possible just to support basic live migration. There
>>has already been discussions of refactoring this after it is in so
>>that we can start to combine the functionality here with what is there
>>in bonding/team, but the differences in configuration interface and
>>the size of the code bases will make it challenging to outright merge
>>this into something like that.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

