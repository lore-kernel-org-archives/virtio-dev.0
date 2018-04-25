Return-Path: virtio-dev-return-3960-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 50B1E5818FBB
	for <virtio-dev@lists.oasis-open.org>; Wed, 25 Apr 2018 15:57:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180426011221-mutt-send-email-mst@kernel.org>
References: <1524188524-28411-5-git-send-email-sridhar.samudrala@intel.com>
 <20180420082802.6ca37e4c@xeon-e3> <20180420160058.GB2150@nanopsycho.orion>
 <20180423100406.71b95f74@xeon-e3> <20180423202204-mutt-send-email-mst@kernel.org>
 <20180423104440.2fe6cfd2@xeon-e3> <20180423205019-mutt-send-email-mst@kernel.org>
 <CADGSJ20ge75T+ddxtUBT4d9m1i3=HLOAHJEoS7Cg0bqnXrutwA@mail.gmail.com>
 <20180423230037-mutt-send-email-mst@kernel.org> <CADGSJ22WMxXEtR9QpRa9_ZqgmTbgWHZz2j4hsUnRJrM9zTsW4w@mail.gmail.com>
 <20180426011221-mutt-send-email-mst@kernel.org>
From: Siwei Liu <loseweigh@gmail.com>
Date: Wed, 25 Apr 2018 15:57:57 -0700
Message-ID: <CADGSJ20vck5V8JCoF0Tq9PWfBu7QYPDvg0yAZ_8Xkig7TKU7Lw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [virtio-dev] Re: [PATCH v7 net-next 4/4] netvsc: refactor notifier/event handling
 code to use the failover framework
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, Jiri Pirko <jiri@resnulli.us>, Sridhar Samudrala <sridhar.samudrala@intel.com>, David Miller <davem@davemloft.net>, Netdev <netdev@vger.kernel.org>, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, "Brandeburg, Jesse" <jesse.brandeburg@intel.com>, Alexander Duyck <alexander.h.duyck@intel.com>, Jakub Kicinski <kubakici@wp.pl>, Jason Wang <jasowang@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Apr 25, 2018 at 3:22 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Wed, Apr 25, 2018 at 02:38:57PM -0700, Siwei Liu wrote:
>> On Mon, Apr 23, 2018 at 1:06 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>> > On Mon, Apr 23, 2018 at 12:44:39PM -0700, Siwei Liu wrote:
>> >> On Mon, Apr 23, 2018 at 10:56 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
>> >> > On Mon, Apr 23, 2018 at 10:44:40AM -0700, Stephen Hemminger wrote:
>> >> >> On Mon, 23 Apr 2018 20:24:56 +0300
>> >> >> "Michael S. Tsirkin" <mst@redhat.com> wrote:
>> >> >>
>> >> >> > On Mon, Apr 23, 2018 at 10:04:06AM -0700, Stephen Hemminger wrote:
>> >> >> > > > >
>> >> >> > > > >I will NAK patches to change to common code for netvsc especially the
>> >> >> > > > >three device model.  MS worked hard with distro vendors to support transparent
>> >> >> > > > >mode, ans we really can't have a new model; or do backport.
>> >> >> > > > >
>> >> >> > > > >Plus, DPDK is now dependent on existing model.
>> >> >> > > >
>> >> >> > > > Sorry, but nobody here cares about dpdk or other similar oddities.
>> >> >> > >
>> >> >> > > The network device model is a userspace API, and DPDK is a userspace application.
>> >> >> >
>> >> >> > It is userspace but are you sure dpdk is actually poking at netdevs?
>> >> >> > AFAIK it's normally banging device registers directly.
>> >> >> >
>> >> >> > > You can't go breaking userspace even if you don't like the application.
>> >> >> >
>> >> >> > Could you please explain how is the proposed patchset breaking
>> >> >> > userspace? Ignoring DPDK for now, I don't think it changes the userspace
>> >> >> > API at all.
>> >> >> >
>> >> >>
>> >> >> The DPDK has a device driver vdev_netvsc which scans the Linux network devices
>> >> >> to look for Linux netvsc device and the paired VF device and setup the
>> >> >> DPDK environment.  This setup creates a DPDK failsafe (bondingish) instance
>> >> >> and sets up TAP support over the Linux netvsc device as well as the Mellanox
>> >> >> VF device.
>> >> >>
>> >> >> So it depends on existing 2 device model. You can't go to a 3 device model
>> >> >> or start hiding devices from userspace.
>> >> >
>> >> > Okay so how does the existing patch break that? IIUC does not go to
>> >> > a 3 device model since netvsc calls failover_register directly.
>> >> >
>> >> >> Also, I am working on associating netvsc and VF device based on serial number
>> >> >> rather than MAC address. The serial number is how Windows works now, and it makes
>> >> >> sense for Linux and Windows to use the same mechanism if possible.
>> >> >
>> >> > Maybe we should support same for virtio ...
>> >> > Which serial do you mean? From vpd?
>> >> >
>> >> > I guess you will want to keep supporting MAC for old hypervisors?
>> >> >
>> >> > It all seems like a reasonable thing to support in the generic core.
>> >>
>> >> That's the reason why I chose explicit identifier rather than rely on
>> >> MAC address to bind/pair a device. MAC address can change. Even if it
>> >> can't, malicious guest user can fake MAC address to skip binding.
>> >>
>> >> -Siwei
>> >
>> > Address should be sampled at device creation to prevent this
>> > kind of hack. Not that it buys the malicious user much:
>> > if you can poke at MAC addresses you probably already can
>> > break networking.
>>
>> I don't understand why poking at MAC address may potentially break
>> networking.
>
> Set a MAC address to match another device on the same LAN,
> packets will stop reaching that MAC.

What I meant was guest users may create a virtual link, say veth that
has exactly the same MAC address as that for the VF, which can easily
get around of the binding procedure. There's no explicit flag to
identify a VF or pass-through device AFAIK. And sometimes this happens
maybe due to user misconfiguring the link. This process should be
hardened to avoid from any potential configuration errors.

>
>> Unlike VF, passthrough PCI endpoint device has its freedom
>> to change the MAC address. Even on a VF setup it's not neccessarily
>> always safe to assume the VF's MAC address cannot or shouldn't be
>> changed. That depends on the specific need whether the host admin
>> wants to restrict guest from changing the MAC address, although in
>> most cases it's true.
>>
>> I understand we can use the perm_addr to distinguish. But as said,
>> this will pose limitation of flexible configuration where one can
>> assign VFs with identical MAC address at all while each VF belongs to
>> different PF and/or different subnet for e.g. load balancing.
>> And
>> furthermore, the QEMU device model never uses MAC address to be
>> interpreted as an identifier, which requires to be unique per VM
>> instance. Why we're introducing this inconsistency?
>>
>> -Siwei
>
> Because it addresses most of the issues and is simple.  That's already
> much better than what we have now which is nothing unless guest
> configures things manually.

Did you see my QEMU patch for using BDF as the grouping identifier?
And there can be others like what you suggested, but the point is that
it's requried to support explicit grouping mechanism from day one,
before the backup property cast into stones. This is orthogonal to
device model being proposed, be it 1-netdev or not. Delaying it would
just mean support and compatibility burden, appearing more like a
design flaw rather than a feature to add later on.

>
> I think ideally the infrastructure should suppport flexible matching of
> NICs - netvsc is already reported to be moving to some kind of serial
> address.
>
As Stephen said, Hyper-V supports the serial UUID thing from day-one.
It's just the Linux netvsc guest driver itself does not leverage that
ID from the very beginging.

Regards,
-Siwei

>
>> >
>> >
>> >
>> >
>> >>
>> >> >
>> >> > --
>> >> > MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

