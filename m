Return-Path: virtio-dev-return-3080-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id CA4225819210
	for <virtio-dev@lists.oasis-open.org>; Fri, 26 Jan 2018 00:14:22 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180124004556-mutt-send-email-mst@kernel.org>
References: <1515736720-39368-1-git-send-email-sridhar.samudrala@intel.com>
 <1515736720-39368-3-git-send-email-sridhar.samudrala@intel.com>
 <CADGSJ22BsdB-hDb0xebSyWrwDuBJaFACjb26PDoqAd2Ah+tsQg@mail.gmail.com>
 <20180122233205-mutt-send-email-mst@kernel.org> <CADGSJ209vrdjnEAweLg84FwN3sf+1W+APmvB=NjFkMNAhsOyrg@mail.gmail.com>
 <20180124004556-mutt-send-email-mst@kernel.org>
From: Siwei Liu <loseweigh@gmail.com>
Date: Fri, 26 Jan 2018 00:14:09 -0800
Message-ID: <CADGSJ2308J=tb1B1zrPi0bFzqYSoLfJsRZxBg6wT+wuCfRO6vw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [virtio-dev] Re: [RFC PATCH net-next v2 2/2] virtio_net: Extend virtio to use VF
 datapath when available
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Sridhar Samudrala <sridhar.samudrala@intel.com>, Stephen Hemminger <stephen@networkplumber.org>, David Miller <davem@davemloft.net>, Netdev <netdev@vger.kernel.org>, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, "Brandeburg, Jesse" <jesse.brandeburg@intel.com>, Alexander Duyck <alexander.h.duyck@intel.com>, Jakub Kicinski <kubakici@wp.pl>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Jan 23, 2018 at 2:58 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Tue, Jan 23, 2018 at 12:24:47PM -0800, Siwei Liu wrote:
>> On Mon, Jan 22, 2018 at 1:41 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>> > On Mon, Jan 22, 2018 at 12:27:14PM -0800, Siwei Liu wrote:
>> >> First off, as mentioned in another thread, the model of stacking up
>> >> virt-bond functionality over virtio seems a wrong direction to me.
>> >> Essentially the migration process would need to carry over all guest
>> >> side configurations previously done on the VF/PT and get them moved to
>> >> the new device being it virtio or VF/PT.
>> >
>> > I might be wrong but I don't see why we should worry about this usecase.
>> > Whoever has a bond configured already has working config for migration.
>> > We are trying to help people who don't, not convert existig users.
>>
>> That has been placed in the view of cloud providers that the imported
>> images from the store must be able to run unmodified thus no
>> additional setup script is allowed (just as Stephen mentioned in
>> another mail). Cloud users don't care about live migration themselves
>> but the providers are required to implement such automation mechanism
>> to make this process transparent if at all possible. The user does not
>> care about the device underneath being VF or not, but they do care
>> about consistency all across and the resulting performance
>> acceleration in making VF the prefered datapath. It is not quite
>> peculiar user cases but IMHO *any* approach proposed for live
>> migration should be able to persist the state including network config
>> e.g. as simple as MTU. Actually this requirement has nothing to do
>> with virtio but our target users are live migration agnostic, being it
>> tracking DMA through dirty pages, using virtio as the helper, or
>> whatsoever, the goal of persisting configs across remains same.
>
> So the patching being discussed here will mostly do exactly that if your
> original config was simply a single virtio net device.
>

True, but I don't see the patch being discussed starts with good
foundation of supporting the same for VF/PT device. That is the core
of the issue.

>
> What kind of configs do your users have right now?

Any configs be it generic or driver specific that the VF/PT device
supports and have been enabled/configured. General network configs
(MAC, IP address, VLAN, MTU, iptables rules), ethtool settings
(hardware offload, # of queues and ring entris, RSC options, rss
rxfh-indir table, rx-flow-hash, et al) , bpf/XDP program being run, tc
flower offload, just to name a few. As cloud providers we don't limit
users from applying driver specific tuning to the NIC/VF, and
sometimes this is essential to achieving best performance for their
workload. We've seen cases like tuning coalescing parameters for
getting low latency, changing rx-flow-hash function for better VXLAN
throughput, or even adopting quite advanced NIC features such as flow
director or cloud filter. We don't expect users to compromise even a
little bit on these. That is once we turn on live migration for the VF
or pass through devices in the VM, it all takes place under the hood,
users (guest admins, applications) don't have to react upon it or even
notice the change. I should note that the majority of live migrations
take place between machines with completely identical hardware, it's
more critical than necessary to keep the config as-is across the move,
stealth while quiet.

As you see generic bond or bridge cannot suffice the need. That's why
we need a new customized virt bond driver, and tailor it for VM live
migration specifically. Leveraging para-virtual e.g. virtio net device
as the backup path is one thing, tracking through driver config
changes in order to re-config as necessary is another. I would think
without considering the latter, the proposal being discussed is rather
incomplete, and remote to be useful in production.

>
>
>> >
>> >> Without the help of a new
>> >> upper layer bond driver that enslaves virtio and VF/PT devices
>> >> underneath, virtio will be overloaded with too much specifics being a
>> >> VF/PT backup in the future.
>> >
>> > So this paragraph already includes at least two conflicting
>> > proposals. On the one hand you want a separate device for
>> > the virtual bond, on the other you are saying a separate
>> > driver.
>>
>> Just to be crystal clear: separate virtual bond device (netdev ops,
>> not necessarily bus device) for VM migration specifically with a
>> separate driver.
>
> Okay, but note that any config someone had on a virtio device won't
> propagate to that bond.
>
>> >
>> > Further, the reason to have a separate *driver* was that
>> > some people wanted to share code with netvsc - and that
>> > one does not create a separate device, which you can't
>> > change without breaking existing configs.
>>
>> I'm not sure I understand this statement. netvsc is already another
>> netdev being created than the enslaved VF netdev, why it bothers?
>
> Because it shipped, so userspace ABI is frozen.  You can't really add a
> netdevice and enslave an existing one without a risk of breaking some
> userspace configs.
>

I still don't understand this concern. Like said, before this patch
becomes reality, users interact with raw VF interface all the time.
Now this patch introduces a virtio net devive and enslave the VF.
Users have to interact with two interfaces - IP address and friends
configured on the VF will get lost and users have to reconfigure
virtio all over again. But some other configs e.g. ethtool needs to
remain on the VF. How does it guarantee existing configs won't broken?
Appears to me this is nothing different than having both virtio and VF
netdevs enslaved and users operates on the virt-bond interface
directly.

One thing I'd like to point out is the configs are mostly done in the
control plane. It's entirely possible to separate the data and control
paths in the new virt-bond driver: in the data plane, it may bypass
the virt-bond layer and quickly fall through to the data path of
virtio or VF slave; while in the control plane, the virt-bond may
disguise itself as the active slave, delegate the config changes to
the real driver, relay and expose driver config/state to the user. By
doing that the users and userspace applications just interact with one
single interface, the same way they interacted with the VF interface
as before. Users don't have to deal with the other two enslaved
interfaces directly - those automatically enslaved devices should be
made invisible from userspace applications and admins, and/or be
masked out from regular access by existing kernel APIs.

I don't find it a good reason to reject the idea if we can sort out
ways not to break existing ABI or APIs.


>
>> In
>> the Azure case, the stock image to be imported does not bind to a
>> specific driver but only MAC address.
>
> I'll let netvsc developers decide this, on the surface I don't think
> it's reasonable to assume everyone only binds to a MAC.

Sure. The point I wanted to make was that cloud providers are super
elastic in provisioning images - those driver or device specifics
should have been dehydrated from the original images thus make it
flexible enough to deploy to machines with vast varieties of hardware.
Although it's not necessarily the case everyone binds to a MAC, it's
worth taking a look at what the target users are doing and what the
pain points really are and understand what could be done to solve core
problems. Hyper-V netvsc can also benefit once moved to it, I'd
believe.

>
>
>> And people just deal with the
>> new virt-bond netdev rather than the underlying virtio and VF. And
>> both these two underlying netdevs should be made invisible to prevent
>> userspace script from getting them misconfigured IMHO.
>>
>> A separate driver was for code sharing for sure, only just netvsc but
>> could be other para-virtual devices floating around: any PV can serve
>> as the side channel and the backup path for VF/PT. Once we get the new
>> driver working atop virtio we may define ops and/or protocol needed to
>> talk to various other PV frontend that may implement the side channel
>> of its own for datapath switching (e.g. virtio is one of them, Xen PV
>> frontend can be another). I just don't like to limit the function to
>> virtio only and we have to duplicate code then it starts to scatter
>> around all over the places.
>>
>> I understand right now we start it as simple so it may just be fine
>> that the initial development activities center around virtio. However,
>> from cloud provider/vendor perspective I don't see the proposed scheme
>> limits to virtio only. Any other PV driver which has the plan to
>> support the same scheme can benefit. The point is that we shouldn't be
>> limiting the scheme to virtio specifics so early which is hard to have
>> it promoted to a common driver once we get there.
>
> The whole idea has been floating around for years. It would always
> get being drowned in this kind of "lets try to cover all use-cases"
> discussions, and never make progress.
> So let's see some working code merged. If it works fine for virtio
> and turns out to be a good fit for netvsc, we can share code.

I think we at least should start with a separate netdev other than
virtio. That is what we may agree to have to do without comprise I'd
hope.

>
>
>> >
>> > So some people want a fully userspace-configurable switchdev, and that
>> > already exists at some level, and maybe it makes sense to add more
>> > features for performance.
>> >
>> > But the point was that some host configurations are very simple,
>> > and it probably makes sense to pass this information to the guest
>> > and have guest act on it directly. Let's not conflate the two.
>>
>> It may be fine to push some of the configurations from host but that
>> perhaps doesn't cover all the cases: how is it possible for the host
>> to save all network states and configs done by the guest before
>> migration. Some of the configs might come from future guest which is
>> unknown to host. Anyhow the bottom line is that the guest must be able
>> to act on those configuration request changes automatically without
>> involving users intervention.
>>
>> Regards,
>> -Siwei
>
> All use-cases are *already* covered by existing kernel APIs.  Just use a
> bond, or a bridge, or whatever. It's just that they are so generic and
> hard to use, that userspace to do it never surfaced.

As mentioned earlier, for which I cannot stress enough, the existing
generic bond or bridge doesn't work. We need a new net device that
works for live migration specifically and fits it well.

>
> So I am interested in some code that handles some simple use-cases
> in the kernel, with a simple kernel API.

It should be fine, I like simple stuffs too and wouldn't like to make
complications. The concept of hiding auto-managed interfaces is not
new and has even been implemented by other operating systems already.
Not sure if that is your compatibility concern. We start with simple
for sure, but simple != in-expandable then make potential users
impossible to use at all.


Thanks,
-Siwei

>
>> >
>> > --
>> > MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

