Return-Path: virtio-dev-return-3244-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 43C2E5819233
	for <virtio-dev@lists.oasis-open.org>; Tue, 20 Feb 2018 09:14:35 -0800 (PST)
References: <1518804682-16881-1-git-send-email-sridhar.samudrala@intel.com>
 <20180220104224.GA2031@nanopsycho>
 <CAKgT0UdU8PDXduzxp4kKfur-DLeFQSJj7-fhW_eTgVzd+AcViw@mail.gmail.com>
 <20180220162933.GD2031@nanopsycho>
From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Message-ID: <509bbbf9-4db7-dc78-a05e-403452a7407a@intel.com>
Date: Tue, 20 Feb 2018 09:14:32 -0800
MIME-Version: 1.0
In-Reply-To: <20180220162933.GD2031@nanopsycho>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: [virtio-dev] Re: [RFC PATCH v3 0/3] Enable virtio_net to act as a backup for a
 passthru device
To: Jiri Pirko <jiri@resnulli.us>, Alexander Duyck <alexander.duyck@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Stephen Hemminger <stephen@networkplumber.org>, David Miller <davem@davemloft.net>, Netdev <netdev@vger.kernel.org>, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, "Brandeburg, Jesse" <jesse.brandeburg@intel.com>, "Duyck, Alexander H" <alexander.h.duyck@intel.com>, Jakub Kicinski <kubakici@wp.pl>, Jason Wang <jasowang@redhat.com>, Siwei Liu <loseweigh@gmail.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On 2/20/2018 8:29 AM, Jiri Pirko wrote:
> Tue, Feb 20, 2018 at 05:04:29PM CET, alexander.duyck@gmail.com wrote:
>> On Tue, Feb 20, 2018 at 2:42 AM, Jiri Pirko <jiri@resnulli.us> wrote:
>>> Fri, Feb 16, 2018 at 07:11:19PM CET, sridhar.samudrala@intel.com wrote:
>>>> Patch 1 introduces a new feature bit VIRTIO_NET_F_BACKUP that can be
>>>> used by hypervisor to indicate that virtio_net interface should act as
>>>> a backup for another device with the same MAC address.
>>>>
>>>> Ppatch 2 is in response to the community request for a 3 netdev
>>>> solution.  However, it creates some issues we'll get into in a moment.
>>>> It extends virtio_net to use alternate datapath when available and
>>>> registered. When BACKUP feature is enabled, virtio_net driver creates
>>>> an additional 'bypass' netdev that acts as a master device and controls
>>>> 2 slave devices.  The original virtio_net netdev is registered as
>>>> 'backup' netdev and a passthru/vf device with the same MAC gets
>>>> registered as 'active' netdev. Both 'bypass' and 'backup' netdevs are
>>>> associated with the same 'pci' device.  The user accesses the network
>>>> interface via 'bypass' netdev. The 'bypass' netdev chooses 'active' netdev
>>>> as default for transmits when it is available with link up and running.
>>> Sorry, but this is ridiculous. You are apparently re-implemeting part
>>> of bonding driver as a part of NIC driver. Bond and team drivers
>>> are mature solutions, well tested, broadly used, with lots of issues
>>> resolved in the past. What you try to introduce is a weird shortcut
>>> that already has couple of issues as you mentioned and will certanly
>>> have many more. Also, I'm pretty sure that in future, someone comes up
>>> with ideas like multiple VFs, LACP and similar bonding things.
>> The problem with the bond and team drivers is they are too large and
>> have too many interfaces available for configuration so as a result
>> they can really screw this interface up.
> What? Too large is which sense? Why "too many interfaces" is a problem?
> Also, team has only one interface to userspace team-generic-netlink.
>
>
>> Essentially this is meant to be a bond that is more-or-less managed by
>> the host, not the guest. We want the host to be able to configure it
> How is it managed by the host? In your usecase the guest has 2 netdevs:
> virtio_net, pci vf.
> I don't see how host can do any managing of that, other than the
> obvious. But still, the active/backup decision is done in guest. This is
> a simple bond/team usecase. As I said, there is something needed to be
> implemented in userspace in order to handle re-appear of vf netdev.
> But that should be fairly easy to do in teamd.

The host manages the active/backup decision by
- assigning the same MAC address to both VF and virtio interfaces
- setting a BACKUP feature bit on virtio that enables virtio to 
transparently take
   over the VFs datapath.
- only enable one datapath at anytime so that packets don't get looped back
- during live migration enable virtio datapth, unplug vf on the source 
and replug
   vf on the destination.

The VM is not expected and doesn't have any control of setting the MAC 
address
or bringing up/down the links.

This is the model that is currently supported with netvsc driver on Azure.

>
>
>> and have it automatically kick in on the guest. For now we want to
>> avoid adding too much complexity as this is meant to be just the first
> That's what I fear, "for now"..
>
>
>> step. Trying to go in and implement the whole solution right from the
>> start based on existing drivers is going to be a massive time sink and
>> will likely never get completed due to the fact that there is always
>> going to be some other thing that will interfere.
> "implement the whole solution right from the start based on existing
> drivers" - what solution are you talking about? I don't understand this
> para.
>
>
>> My personal hope is that we can look at doing a virtio-bond sort of
>> device that will handle all this as well as providing a communication
>> channel, but that is much further down the road. For now we only have
>> a single bit so the goal for now is trying to keep this as simple as
>> possible.
> Oh. So there is really intention to do re-implementation of bonding
> in virtio. That is plain-wrong in my opinion.
>
> Could you just use bond/team, please, and don't reinvent the wheel with
> this abomination?



>
>>> What is the reason for this abomination? According to:
>>> https://marc.info/?l=linux-virtualization&m=151189725224231&w=2
>>> The reason is quite weak.
>>> User in the vm sees 2 (or more) netdevices, he puts them in bond/team
>>> and that's it. This works now! If the vm lacks some userspace features,
>>> let's fix it there! For example the MAC changes is something that could
>>> be easily handled in teamd userspace deamon.
>> I think you might have missed the point of this. This is meant to be a
>> simple interface so the guest should not be able to change the MAC
>> address, and it shouldn't require any userspace daemon to setup or
>> tear down. Ideally with this solution the virtio bypass will come up
>> and be assigned the name of the original virtio, and the "backup"
>> interface will come up and be assigned the name of the original virtio
>> with an additional "nbackup" tacked on via the phys_port_name, and
>> then whenever a VF is added it will automatically be enslaved by the
>> bypass interface, and it will be removed when the VF is hotplugged
>> out.
>>
>> In my mind the difference between this and bond or team is where the
>> configuration interface lies. In the case of bond it is in the kernel.
>> If my understanding is correct team is mostly in user space. With this
>> the configuration interface is really down in the hypervisor and
>> requests are communicated up to the guest. I would prefer not to make
>> virtio_net dependent on the bonding or team drivers, or worse yet a
>> userspace daemon in the guest. For now I would argue we should keep
>> this as simple as possible just to support basic live migration. There
>> has already been discussions of refactoring this after it is in so
>> that we can start to combine the functionality here with what is there
>> in bonding/team, but the differences in configuration interface and
>> the size of the code bases will make it challenging to outright merge
>> this into something like that.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

