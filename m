Return-Path: virtio-dev-return-3997-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 80D635818E8A
	for <virtio-dev@lists.oasis-open.org>; Fri, 27 Apr 2018 17:43:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180427012530-mutt-send-email-mst@kernel.org>
References: <20180423202204-mutt-send-email-mst@kernel.org>
 <20180423104440.2fe6cfd2@xeon-e3> <20180423205019-mutt-send-email-mst@kernel.org>
 <CADGSJ20ge75T+ddxtUBT4d9m1i3=HLOAHJEoS7Cg0bqnXrutwA@mail.gmail.com>
 <20180423230037-mutt-send-email-mst@kernel.org> <CADGSJ22WMxXEtR9QpRa9_ZqgmTbgWHZz2j4hsUnRJrM9zTsW4w@mail.gmail.com>
 <20180426011221-mutt-send-email-mst@kernel.org> <CADGSJ20vck5V8JCoF0Tq9PWfBu7QYPDvg0yAZ_8Xkig7TKU7Lw@mail.gmail.com>
 <20180426050934-mutt-send-email-mst@kernel.org> <CADGSJ22D=NTWtjVeLKsgvcesy0b_ugzb9XGHGsWOktUEFhYN_Q@mail.gmail.com>
 <20180427012530-mutt-send-email-mst@kernel.org>
From: Siwei Liu <loseweigh@gmail.com>
Date: Fri, 27 Apr 2018 17:43:28 -0700
Message-ID: <CADGSJ229p-kg2CUuJ2O64a7OP5Ktja_FjDh0PtN_HTdRutD2kQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [virtio-dev] Re: [PATCH v7 net-next 4/4] netvsc: refactor notifier/event handling
 code to use the failover framework
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, Jiri Pirko <jiri@resnulli.us>, Sridhar Samudrala <sridhar.samudrala@intel.com>, David Miller <davem@davemloft.net>, Netdev <netdev@vger.kernel.org>, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, "Brandeburg, Jesse" <jesse.brandeburg@intel.com>, Alexander Duyck <alexander.h.duyck@intel.com>, Jakub Kicinski <kubakici@wp.pl>, Jason Wang <jasowang@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Apr 26, 2018 at 4:42 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Thu, Apr 26, 2018 at 03:14:46PM -0700, Siwei Liu wrote:
>> On Wed, Apr 25, 2018 at 7:28 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>> > On Wed, Apr 25, 2018 at 03:57:57PM -0700, Siwei Liu wrote:
>> >> On Wed, Apr 25, 2018 at 3:22 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>> >> > On Wed, Apr 25, 2018 at 02:38:57PM -0700, Siwei Liu wrote:
>> >> >> On Mon, Apr 23, 2018 at 1:06 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>> >> >> > On Mon, Apr 23, 2018 at 12:44:39PM -0700, Siwei Liu wrote:
>> >> >> >> On Mon, Apr 23, 2018 at 10:56 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
>> >> >> >> > On Mon, Apr 23, 2018 at 10:44:40AM -0700, Stephen Hemminger wrote:
>> >> >> >> >> On Mon, 23 Apr 2018 20:24:56 +0300
>> >> >> >> >> "Michael S. Tsirkin" <mst@redhat.com> wrote:
>> >> >> >> >>
>> >> >> >> >> > On Mon, Apr 23, 2018 at 10:04:06AM -0700, Stephen Hemminger wrote:
>> >> >> >> >> > > > >
>> >> >> >> >> > > > >I will NAK patches to change to common code for netvsc especially the
>> >> >> >> >> > > > >three device model.  MS worked hard with distro vendors to support transparent
>> >> >> >> >> > > > >mode, ans we really can't have a new model; or do backport.
>> >> >> >> >> > > > >
>> >> >> >> >> > > > >Plus, DPDK is now dependent on existing model.
>> >> >> >> >> > > >
>> >> >> >> >> > > > Sorry, but nobody here cares about dpdk or other similar oddities.
>> >> >> >> >> > >
>> >> >> >> >> > > The network device model is a userspace API, and DPDK is a userspace application.
>> >> >> >> >> >
>> >> >> >> >> > It is userspace but are you sure dpdk is actually poking at netdevs?
>> >> >> >> >> > AFAIK it's normally banging device registers directly.
>> >> >> >> >> >
>> >> >> >> >> > > You can't go breaking userspace even if you don't like the application.
>> >> >> >> >> >
>> >> >> >> >> > Could you please explain how is the proposed patchset breaking
>> >> >> >> >> > userspace? Ignoring DPDK for now, I don't think it changes the userspace
>> >> >> >> >> > API at all.
>> >> >> >> >> >
>> >> >> >> >>
>> >> >> >> >> The DPDK has a device driver vdev_netvsc which scans the Linux network devices
>> >> >> >> >> to look for Linux netvsc device and the paired VF device and setup the
>> >> >> >> >> DPDK environment.  This setup creates a DPDK failsafe (bondingish) instance
>> >> >> >> >> and sets up TAP support over the Linux netvsc device as well as the Mellanox
>> >> >> >> >> VF device.
>> >> >> >> >>
>> >> >> >> >> So it depends on existing 2 device model. You can't go to a 3 device model
>> >> >> >> >> or start hiding devices from userspace.
>> >> >> >> >
>> >> >> >> > Okay so how does the existing patch break that? IIUC does not go to
>> >> >> >> > a 3 device model since netvsc calls failover_register directly.
>> >> >> >> >
>> >> >> >> >> Also, I am working on associating netvsc and VF device based on serial number
>> >> >> >> >> rather than MAC address. The serial number is how Windows works now, and it makes
>> >> >> >> >> sense for Linux and Windows to use the same mechanism if possible.
>> >> >> >> >
>> >> >> >> > Maybe we should support same for virtio ...
>> >> >> >> > Which serial do you mean? From vpd?
>> >> >> >> >
>> >> >> >> > I guess you will want to keep supporting MAC for old hypervisors?
>> >> >> >> >
>> >> >> >> > It all seems like a reasonable thing to support in the generic core.
>> >> >> >>
>> >> >> >> That's the reason why I chose explicit identifier rather than rely on
>> >> >> >> MAC address to bind/pair a device. MAC address can change. Even if it
>> >> >> >> can't, malicious guest user can fake MAC address to skip binding.
>> >> >> >>
>> >> >> >> -Siwei
>> >> >> >
>> >> >> > Address should be sampled at device creation to prevent this
>> >> >> > kind of hack. Not that it buys the malicious user much:
>> >> >> > if you can poke at MAC addresses you probably already can
>> >> >> > break networking.
>> >> >>
>> >> >> I don't understand why poking at MAC address may potentially break
>> >> >> networking.
>> >> >
>> >> > Set a MAC address to match another device on the same LAN,
>> >> > packets will stop reaching that MAC.
>> >>
>> >> What I meant was guest users may create a virtual link, say veth that
>> >> has exactly the same MAC address as that for the VF, which can easily
>> >> get around of the binding procedure.
>> >
>> > This patchset limits binding to PCI devices so it won't be affected
>> > by any hacks around virtual devices.
>>
>> Wait, I vaguely recall you seemed to like to generalize this feature
>> to non-PCI device.
>
> It's purely a layering thing.  It is cleaner not to have PCI specific
> data in the device-specific transport-independent section of the virtio
> spec.
>
OK. So looks like you think it's okay to include PCI specific concept
but not the data? Like a feature indicating the virtio device is
behind a (external) PCI bridge, and perhaps also includes the data
present in the PCI bridge/function's capability?

Sorry for asking tough questions. I still need to understand and
digest the boundary of this layering thing.

>
>> But now you're saying it should stick to PCI. It's
>> not that I'm reluctant with sticking to PCI. The fact is that I don't
>> think we can go with implementation until the semantics of the
>> so-called _F_STANDBY feature can be clearly defined into the spec.
>> Previously the boundary of using MAC address as the identifier for
>> bonding was quite confusing to me. And now PCI adds to the matrix.
>
> PCI is simply one way to exclude software NICs. It's not the most
> elegant one, but it will cover many setups.  We can add more types, but
> we do want to exclude software devices since these have
> not been supplied by the hypervisor.

I'm afraid it's a loose end. The real thing is there's no way to
indicate VF or passthrough device on Linux, even true on some other
OS. There's no such flag exists yet. Even the emulated e1000 and
rltk8139 device looks the same as PCI device. And as part of the
requirements of being a spec, the behaviour and expectation need to be
precisely described for implementations to follow. There's no point to
assume just one OS will implement this feature so it needs to depend
on specifics of that OS.

>
>> However it still does not gurantee uniqueness I think. It's almost
>> incorrect of choosing MAC address as the ID in the beginning since
>> that has the implication of breaking existing configs.
>
> IMO there's no chance it will break any existing config since
> no existing config sets _F_STANDBY.

True, but it breaks people's expectation that it has to rely on MAC
address being unique when turning it on for live migration, and once
it happens some configs with same MAC address would break (for e.g.
bonding setup can have it for cross subnet failover and site
replication). Unless this limitation is clearly documented in the spec
I don't think people will notice that until it breaks.

>
>> I don't think
>> libvirt or QEMU today retricts the MAC address to be unique per VM
>> instance. Neither the virtio spec mentions that.
>
> You really don't have to.
>
>> In addition, it's difficult to fake PCI device on Linux does not mean
>> the same applies to other OSes that is going to implement this VirtIO
>> feature. It's a fragile assumption IMHO.
>
> What an OS does internally is its own business.
>
> What we are telling the guest here is simply that the virtio NIC is
> actually the same device as some other NIC. At this point we do not
> specify this other NIC in any way. So how do you find it?  Well it has
> to have the same MAC clearly.

Well this condition is absolutely neccessary but not sufficient. There
should be some other unique key to help find the NIC as the MAC cannot
be unique as what people generally thought it be.

>
> You point out that there could be multiple NICs with the same
> MAC in theory. It's a broken config generally but since it
> kind of works in some setups maybe it's worth supporting.
> If so we can look for ways to make the matching more specific by e.g.
> adding more flags but I see that as a separate issue,
> and pretty narrow in scope.

Well there are precedents that people thought something broken but
soon find out users already depends on the "broken" behaviour.
Nowadays widely use of virtualization technology make MAC address
duplication really cheap. It's not that uncommon as one might think.

Unless the expectation can be explicitly documented in the spec, I
don't feel it's something users can easily infer from what the new
feature should target - live migration.

>
>> >
>> >> There's no explicit flag to
>> >> identify a VF or pass-through device AFAIK. And sometimes this happens
>> >> maybe due to user misconfiguring the link. This process should be
>> >> hardened to avoid from any potential configuration errors.
>> >
>> > They are still PCI devices though.
>> >
>> >> >
>> >> >> Unlike VF, passthrough PCI endpoint device has its freedom
>> >> >> to change the MAC address. Even on a VF setup it's not neccessarily
>> >> >> always safe to assume the VF's MAC address cannot or shouldn't be
>> >> >> changed. That depends on the specific need whether the host admin
>> >> >> wants to restrict guest from changing the MAC address, although in
>> >> >> most cases it's true.
>> >> >>
>> >> >> I understand we can use the perm_addr to distinguish. But as said,
>> >> >> this will pose limitation of flexible configuration where one can
>> >> >> assign VFs with identical MAC address at all while each VF belongs to
>> >> >> different PF and/or different subnet for e.g. load balancing.
>> >> >> And
>> >> >> furthermore, the QEMU device model never uses MAC address to be
>> >> >> interpreted as an identifier, which requires to be unique per VM
>> >> >> instance. Why we're introducing this inconsistency?
>> >> >>
>> >> >> -Siwei
>> >> >
>> >> > Because it addresses most of the issues and is simple.  That's already
>> >> > much better than what we have now which is nothing unless guest
>> >> > configures things manually.
>> >>
>> >> Did you see my QEMU patch for using BDF as the grouping identifier?
>> >
>> > Yes. And I don't think it can work because bus numbers are
>> > guest specified.
>>
>> I know it's not ideal but perhaps its the best one can do in the KVM
>> world without adding complex config e.g. PCI bridge.
>
> KVM is just a VMX/SVM driver. I think you mean QEMU.  And well -
> "best one can do" is a high bar to clear.
>
>

Glad you'd have to admit that there's no better way *without
introducing complex PCI bridge setup* in the KVM, oops, QEMU without
KVM? err, QEMU with KVM world.

>> Even if bus
>> number is guest specified, it's readily available in the guest and
>> recognizable by any OS, while on the QEMU configuration users specify
>> an id instead of the bus number. Unlike Hyper-V PCI bus, I don't think
>> there exists a para-virtual PCI bus in QEMU backend to expose VPD
>> capability to a passthrough device.
>
> We can always add more interfaces if we need them.  But let's be clear
> that we are adding an interface and what are we trying to fix by doing
> it. Let's not mix it as part of the failover discussion.

I'm sorry, I don't understand why this should not be part of the
failover discussion.

There's a lot of ambiguity about the semantics and the expectation of
the _F_STANDBY feature, and that should be recorded in virtio-dev. If
you think we should run it with a different thread, I can definitely
fork a new thread to continue.

As you may wonder, the other aspects unclear to me now are:
- does this feature imply the device model already? The 3-netdev?
- should clear the feature bit upon unsuccessful creation of the
failover interface or failure to enslave the VF?
- does the feature bit indicate migratability status for the
corresponding VF/PT device?
- does the feature expect automatic bonding by default or always?
- does the guest user have the freedom to disable/re-enable the
automatic bonding? such that they can use raw VF for DPDK or RDMA
after the migration
- ...

I hope the answer won't just be to look at what the current
implementation is doing. The discussion will be helpful, at least not
harmful, for people to understand the intention and definition
clearly, since live migration itself is just too complicated.

>
>> >
>> >> And there can be others like what you suggested, but the point is that
>> >> it's requried to support explicit grouping mechanism from day one,
>> >> before the backup property cast into stones.
>> >
>> > Let's start with addressing simple configs with just two NICs.
>> >
>> > Down the road I can see possible extensions that can work: for example,
>> > require that devices are on the same pci bridge. Or we could even make
>> > the virtio device actually include a pci bridge (as part of same
>> > or a child function), the PT would have to be
>> > behind it.
>> >
>> > As long as we are not breaking anything, adding more flags to fix
>> > non-working configurations is always fair game.
>>
>> While it may work, the PCI bridge has NUMA and IOMMU implications that
>> would restrict the current flexibility to group devices.
>
> It's interesting you should mention that.
>
> If you want to be flexible in placing the primary device WRT NUMA and
> IOMMU, and given that both IOMMU and NUMA are keyed by the bus address,
> then doesn't this completely break the idea of passing
> the bus address to the guest?

I'm confused. Isn't the NUMA and IOMMU disposition host admin should
explicitly define? In that case it's assumed that s/he understand the
implication and the bus address doesn't restrict the host admin from
placing the device according to the NUMA or IOMMU
consideration/constrait.

>
>> I'm not sure
>> if vIOMMU would have to be introduced inadvertently for
>> isolation/protection of devices under the PCI bridge which may cause
>> negative performance impact on the VF.
>
> No idea how do you introduce an IOMMU inadvertently.

If the virtio has to be behind a different bridge thus IOMMU domain
than that for VF (which does not actually need a guest IOMMU) then
your former proposal of grouping them *under the same bridge* would
come across hurtles.

>
>> >
>> >> This is orthogonal to
>> >> device model being proposed, be it 1-netdev or not. Delaying it would
>> >> just mean support and compatibility burden, appearing more like a
>> >> design flaw rather than a feature to add later on.
>> >
>> > Well it's mostly myself who gets to support it, and I see the device
>> > model as much more fundamental as userspace will come to depend
>> > on it. So I'm not too worried, let's take this one step at a time.
>> >
>> >> >
>> >> > I think ideally the infrastructure should suppport flexible matching of
>> >> > NICs - netvsc is already reported to be moving to some kind of serial
>> >> > address.
>> >> >
>> >> As Stephen said, Hyper-V supports the serial UUID thing from day-one.
>> >> It's just the Linux netvsc guest driver itself does not leverage that
>> >> ID from the very beginging.
>> >>
>> >> Regards,
>> >> -Siwei
>> >
>> > We could add something like this, too. For example,
>> > we could add a virtual VPD capability with a UUID.
>>
>> I'm not an expert on that and wonder how you could do this (add a
>> virtual VPD capability with a UUID to passthrough device) with
>> existing QEMU emulation model and native PCI bus.
>
>
> I think I see an elegant way to do that.
>
> You could put it in the port where you want to stick you PT device.
>
> Here's how it could work then:
>
>
> - standby virtio device is tied to a pci bridge.
>
>   Tied how? Well it could be
>   - behind this bridge

An external PCI bridge? This gets back to the first question I ask.
It's interesting a virtio feature should reference an externel object
which seems more like a layering problem at least to me.

>   - include a bridge internally
This internal one being a native PCI bridge or VirtIO PCI bridge? I'm
almost cerntain it should be the latter down the road. That determines
where the VPD or SN capability should reside.

>   - have the bridge as a PCI function
>   - include a bridge and the bridge as a PCI function
>   - have a VPD or serial capability with same UUID as the bridge
>
> - primary passthrough device is placed behind a bridge
>   *with the same ID*
>
>         - either simply behind the same bridge
>         - or behind another bridge with the same UUID.
>
Good. Decouple the concept of grouping to rely on same PCI bridge, and
another bridge with same UUID seems more flexible and promissing.

>
> The treatment could also be limited just to bridges which have a
> specific vendor/device id (maybe a good idea), or in any other arbitrary
> way.

I'd think anway VirtIO spec revision is unavoidable if you have to
involve PCI bridge. Not so complicated?

Regards,
-Siwei

>
>
>
>
>> >
>> > Do you know how exactly does hyperv pass the UUID for NICs?
>>
>> Stephen might know it more and can correct me. But my personal
>> interpretation is that the SN is a host generated 32 bit sequence
>> number which is unique per VM instance and gets propogated to guest
>> via the para-virtual Hyper-V PCI bus.
>>
>> Regards,
>> -Siwei
>
> Ah, so it's a Hyper-V thing.
>
>
>
>
>> >
>> >> >
>> >> >> >
>> >> >> >
>> >> >> >
>> >> >> >
>> >> >> >>
>> >> >> >> >
>> >> >> >> > --
>> >> >> >> > MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

