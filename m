Return-Path: virtio-dev-return-4874-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BA1C8985D5F
	for <virtio-dev@lists.oasis-open.org>; Thu, 27 Sep 2018 00:18:41 +0000 (UTC)
MIME-Version: 1.0
In-Reply-To: <20180920220951-mutt-send-email-mst@kernel.org>
References: <20180907173251-mutt-send-email-mst@kernel.org>
 <9bc2db49-77ea-1391-b964-a29da44ff617@intel.com> <20180912111819-mutt-send-email-mst@kernel.org>
 <20180918122052.349ba42e.cohuck@redhat.com> <20180918093310-mutt-send-email-mst@kernel.org>
 <20180918151337.GA7432@vbusired-dt> <20180918111540-mutt-send-email-mst@kernel.org>
 <CADGSJ21CujSW=aF7BqdXmSFahLwSgPmG3_KFF5mSeVA5Z8PkQg@mail.gmail.com>
 <20180919230502-mutt-send-email-mst@kernel.org> <CADGSJ22OybVCOsBmqdAHLPBU0PKF13xWz3YtHT=Pw5bT_a71BA@mail.gmail.com>
 <20180920220951-mutt-send-email-mst@kernel.org>
From: Siwei Liu <loseweigh@gmail.com>
Date: Wed, 26 Sep 2018 17:18:38 -0700
Message-ID: <CADGSJ23GRrt25k1G9wD3JhA6en4MuXLE9WA24Ep8PLgkyk_4=A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [virtio-dev] [PATCH v4] content: Introduce VIRTIO_NET_F_STANDBY feature
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Venu Busireddy <venu.busireddy@oracle.com>, Cornelia Huck <cohuck@redhat.com>, "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, virtio-dev <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Sep 20, 2018 at 7:23 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Thu, Sep 20, 2018 at 04:57:56PM -0700, Siwei Liu wrote:
>> On Wed, Sep 19, 2018 at 8:11 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>> > On Tue, Sep 18, 2018 at 11:48:46AM -0700, Siwei Liu wrote:
>> >> On Tue, Sep 18, 2018 at 8:31 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
>> >> > On Tue, Sep 18, 2018 at 10:13:37AM -0500, Venu Busireddy wrote:
>> >> >> On 2018-09-18 09:35:48 -0400, Michael S. Tsirkin wrote:
>> >> >> > On Tue, Sep 18, 2018 at 12:20:52PM +0200, Cornelia Huck wrote:
>> >> >> > > On Wed, 12 Sep 2018 11:22:12 -0400
>> >> >> > > "Michael S. Tsirkin" <mst@redhat.com> wrote:
>> >> >> > >
>> >> >> > > > On Wed, Sep 12, 2018 at 08:17:45AM -0700, Samudrala, Sridhar wrote:
>> >> >> > > > >
>> >> >> > > > >
>> >> >> > > > > On 9/7/2018 2:34 PM, Michael S. Tsirkin wrote:
>> >> >> > > > > > On Wed, Aug 15, 2018 at 11:49:15AM -0700, Sridhar Samudrala wrote:
>> >> >> > > > > > > VIRTIO_NET_F_STANDBY feature enables hypervisor to indicate virtio_net
>> >> >> > > > > > > device to act as a standby for another device with the same MAC address.
>> >> >> > > > > > >
>> >> >> > > > > > > Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
>> >> >> > > > > > > Acked-by: Cornelia Huck <cohuck@redhat.com>
>> >> >> > > > > > > Fixes: https://github.com/oasis-tcs/virtio-spec/issues/18
>> >> >> > > > > > Applied but when do you plan to add documentation as pointed
>> >> >> > > > > > out by Jan and Halil?
>> >> >> > > > >
>> >> >> > > > > I thought additional documentation will be done as part of the Qemu enablement
>> >> >> > > > > patches and i hope someone in RH is looking into it.
>> >> >> > > > >
>> >> >> > > > > Does it make sense to add a link to to the kernel documentation of this feature in
>> >> >> > > > > the spec
>> >> >> > > > >  https://www.kernel.org/doc/html/latest/networking/net_failover.html
>> >> >> > > >
>> >> >> > > >
>> >> >> > > > I do not think this will address the comments posted.  Specifically we
>> >> >> > > > should probably include documentation for what is a standby and primary:
>> >> >> > > > what is expected of driver (maintain configuration on standby, support
>> >> >> > > > primary coming and going, transmit on standby only if there is no
>> >> >> > > > primary) and of device (have same mac for standby as for standby).
>> >> >> > >
>> >> >> > > Yes, we need some definitive statements of what a driver and a device
>> >> >> > > is supposed to do in order to conform; it might make sense to discuss
>> >> >> > > this in conjunction with discussion on any QEMU patches (have not
>> >> >> > > checked whether anything has been posted, just returned from vacation).
>> >> >> > >
>> >> >> > > I assume that we still stick with the plan to implement/document
>> >> >> > > MAC-based handling first and then enhance with other methods later?
>> >> >> >
>> >> >> > I'm fine with that at least. If someone wants to work on
>> >> >> > other methods straight away, that's also fine by me.
>> >> >>
>> >> >> Patch set [1] implements the failover-group-id mechanism. Are you
>> >> >> thinking of some other method?
>> >> >>
>> >> >> Venu
>> >> >>
>> >> >> [1] https://lists.oasis-open.org/archives/virtio-dev/201806/msg00384.html
>> >> >>
>> >> >
>> >> > Yes, the grouping mechanism seems fine to me (I don't remember
>> >> > about the implementation, it's been a while).
>> >> >
>> >> > It is not by itself sufficient though, is it?
>> >>
>> >> I do understand that the group ID patch is incomplete though it's a
>> >> base patch for the real work.
>> >>
>> >> >
>> >> > MAC is assumed to be shared to avoid things like ARP/neighboor
>> >> > rediscovery, right?
>> >>
>> >> True, but does this really need to be part of the guest-host
>> >> interface? Or rather, I don't see how MAC based matching can be done
>> >> on the host part.
>> >
>> > mac address matching does not need to affect host side.
>>
>> Did you realize that the host side can't have duplicate MAC address
>> filters for both PV and VF at the same time?
>>
>> If hot adding a VF with duplicate MAC address filter programmed in
>> prior, the PV path for virtio in the host side is effectively
>> disabled. However, the fact that VF gets hot plugged by QEMU/libvirt
>> does not mean it's ready and usable in the guest. You end up with
>> unusable guest networking, *temporarily only when VF is successfully
>> probed and properly enslabed*. As of now, no guest-host handshake was
>> defined in the spec to make virtio driver aware of hotplug event thus
>> VF's exposure, and zero handshake was done to switch the datapath when
>> VF driver is ready and usable in guest. The current implementation
>> relies on the lucky side that all the entire hot plug process will be
>> successul in the guest.
>
> I think it's a PF bug then. PF driver should ignore filters
> for VFs which have not been enabled by guest since reset.

Even so, the fact is that if the design is tied to MAC based matching
you end up with relying on that MAC address to pair device, which
loses the flexibility to move MAC filter at some point later after
assigning VF to guest.

>
>> BTW netvsc mitigate potential failure in the hotplug and driver
>> probing by acknowledging the hypervisor through a DATAPATH_SWITCH
>> hypercall (VMbus message) when VF driver is enslaved and ready, only
>> then hypervisor will kick off datapath switching by moving the MAC
>> address filter.
>
> We can do it without need for PV.  We can detect e.g. bus master enable.

I'm not sure if it's valid to assume master enable/disable is the
right point to move the filter, although it improves a bit than do
nothing. The thing is that from device (QEMU) perspective it knows
nothing and should not assume too much about guest implementation -
the time to move the filter around means the VF driver is fully ready
in guest and properly handled by the bond driver (net_failover), so
the primary can take over the datapath going forward. While the bus
master enable usually happens earlier than that, which does not
indicate anything about readiness on the control side that the
bond/failver driver can actually see this VF and "manage" it. This
strictly does not form any guest-host handshake to me. Think about
what if VM user changes VF to a different netns, or rebind it to DPDK
PMD? These just demostrate a few things that can get well covered by
this design, and I suspect the errors in the real life would be much
more complex.

> Move the filter when enabled, move it back when disabled e.g. by
> VF reset. Or maybe MSE, or both.

MSE is on the PF and shared by all VFs, why it's relevant?

>
>> >
>> >> Are you going to expose MAC address to VFIO?
>> >
>> > If mac of a VF is programmed by libvirt through the PF
>> > (that's already the case), VFIO does not need to care about it.
>> >
>> >>
>> >> The thing is the current MAC based implementation has intrinsic flaw
>> >> that doesn't propagate errors to hypervisor, or there's no back
>> >> channel for guest to unwind the hot plug action upon failure in
>> >> probing or enslaving the primary.
>> >
>> > I guess you can eject the primary if you like. But
>> > why does hypervisor need to know? On error, just don't use primary,
>> > use standby.
>>
>> Forget about the grouping mechanism first.
>
> OK :)
>
>> What guest kernel change do
>> you propose to make virtio driver know every possible error, think
>> about how many moving targets it needs to specifically track with or
>> has to depend on during the hot plug and driver probing process? If
>> someone starts to implement the code and think about various error
>> cases as a whole, I bet it would be more clear why grouping is
>> relevant in the first place.
>>
>> -Siwei
>
> It just seems that no one's been motivated to do it so far.

It's just that the MAC matching design is simply too broken. We have
root disk hosted on networked storage, i.e. iSCSI, that can't tolerate
any potential network failure if the design itself is not error proof.
IOW our criteria for network downtime and errors is super rigorous..

-Siwei

>
>> >
>> >> If you think about a more robust
>> >> implementation, another grouping mechanism rather than MAC is pretty
>> >> much required.
>> >>
>> >> Thanks,
>> >> -Siwei
>> >
>> > I don't really know what is the flaw, or how is it fixed by a grouping
>> > mechanism. All this motivation was never described as part of work on
>> > an alternate grouping.
>> >
>> >> > If true that implies that to avoid guest confusion visibility of the
>> >> > primary needs to be controlled by standby's driver.
>> >> > This makes this patchset incomplete.
>> >> >
>> >> > For this work to be complete what is needed is:
>> >> > - hypervisor: add control of primary's visibility to guest
>> >> > - guest: add support for this grouping to the failover driver
>> >> >
>> >> > We also need
>> >> > - spec: document matching rules based on the pci bridge
>> >> >
>> >> > and it's helpful to have a spec proposal with implementation, but I
>> >> > would say at least proposed patches to one of the above 2 would be
>> >> > helpful before we include this in spec.
>> >> >
>> >> > --
>> >> > MST
>> >> >
>> >> > ---------------------------------------------------------------------
>> >> > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
>> >> > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>> >> >

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

