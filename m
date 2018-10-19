Return-Path: virtio-dev-return-4902-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9877E985EA9
	for <virtio-dev@lists.oasis-open.org>; Fri, 19 Oct 2018 03:45:44 +0000 (UTC)
Date: Thu, 18 Oct 2018 23:45:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181018233115-mutt-send-email-mst@kernel.org>
References: <20180919230502-mutt-send-email-mst@kernel.org>
 <CADGSJ22OybVCOsBmqdAHLPBU0PKF13xWz3YtHT=Pw5bT_a71BA@mail.gmail.com>
 <20180920220951-mutt-send-email-mst@kernel.org>
 <CADGSJ23GRrt25k1G9wD3JhA6en4MuXLE9WA24Ep8PLgkyk_4=A@mail.gmail.com>
 <20180927121739-mutt-send-email-mst@kernel.org>
 <CADGSJ22JC9asjQ3nVV5e-ajxB-pggJ6ToMGqG072Q5TvFVCKBQ@mail.gmail.com>
 <20181002083928-mutt-send-email-mst@kernel.org>
 <CADGSJ23NaaPXrgoL1-ySs=SWytE65SORatOFMSapzFsKZUH4yA@mail.gmail.com>
 <20181005101419-mutt-send-email-mst@kernel.org>
 <CADGSJ22QYRX3GBjDqGgauwiHi6p4FpbUwpromD0=nY+w2FDm=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADGSJ22QYRX3GBjDqGgauwiHi6p4FpbUwpromD0=nY+w2FDm=Q@mail.gmail.com>
Subject: Re: [virtio-dev] [PATCH v4] content: Introduce VIRTIO_NET_F_STANDBY
 feature
To: Siwei Liu <loseweigh@gmail.com>
Cc: Venu Busireddy <venu.busireddy@oracle.com>, Cornelia Huck <cohuck@redhat.com>, "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, virtio-dev <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Oct 10, 2018 at 06:26:50PM -0700, Siwei Liu wrote:
> On Fri, Oct 5, 2018 at 12:18 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, Oct 04, 2018 at 05:03:14PM -0700, Siwei Liu wrote:
> > > On Tue, Oct 2, 2018 at 5:43 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Tue, Oct 02, 2018 at 01:42:09AM -0700, Siwei Liu wrote:
> > > > > The VF's MAC can be updated by PF/host on the fly at any time. One can
> > > > > start with a random MAC but use group ID to pair device instead. And
> > > > > only update MAC address to the real one when moving MAC filter around
> > > > > after PV says OK to switch datapath.
> > > > >
> > > > > Do you see any problem with this design?
> > > >
> > > > Isn't this what I proposed:
> > > >         Maybe we can
> > > >         start VF with a temporary MAC, then change it to a final one when guest
> > > >         tries to use it. It will work but we run into fact that MACs are
> > > >         currently programmed by mgmnt - in many setups qemu does not have the
> > > >         rights to do it.
> > > >
> > > > ?
> > > >
> > > > If yes I don't see a problem with the interface design, even though
> > > > implementation wise it's more work as it will have to include management
> > > > changes.
> > >
> > > I thought we discussed this design a while back:
> > > https://www.spinics.net/lists/netdev/msg512232.html
> > >
> > > ... plug in a VF with a random MAC filter programmed in prior, and
> > > initially use that random MAC within guest. This would require:
> > > a) not relying on permanent MAC address to do pairing during the
> > > initial discovery, e.g. use the failover group ID as in this
> > > discussion
> > > b) host to toggle the MAC address filter: which includes taking down
> > > the tap device to return the MAC back to PF, followed by assigning
> > > that MAC to VF using "ip link ... set vf ..."
> > > c) notify guest to reload/reset VF driver for the change of hardware MAC address
> > > d) until VF reloads the driver it won't be able to use the datapath,
> > > so very short period of network outage is (still) expected
> > >
> > > though I still don't think this design can elimnate downtime.
> >
> >
> > No, my idea is somewhat different. As you say there is a problem
> > of delay at point (c).
> That's true, I never say the downtime can be avoided because of this
> delay in the guest side. But with this the downtime gets to the bare
> minimum and in most situations packets won't be lost on reception as
> long as the PF sets up the filter in timely manner.

It's not really the bare minimum IMHO. E.g. fixing the PF to
defer filter update will give you less downtime.

> > Further, the need to poke at PF filters
> > with set vf does not match the current security model where
> > any security related configuration such as MAC filtering is done upfront.
> 
> The security model belongs to the VM policy not the VF, right? I think
> same MAC address will always be used on the VM as it starts with
> virtio. Why it is a security issue that VF starts with an unused MAC
> before it's able to be used in the guest?

Basically if guest is able to trigger MAC changes,
it might be able to exploit some bug to escalate that to
full network access. Completely blocking configuration
changes after setup feels safer.

Case in point, with QEMU a typical selinux policy will block
attempts to change MACs, that task will have to be
delegated to a suitably priveledged tool.


> 
> >
> >
> > So I have two suggestions:
> >
> > 1. Teach pf driver not to program the filter until vf driver actually goes up.
> >
> >    How do we know it went up? For example, it is highly likely
> >    that driver will send some kind of command on init.
> >    E.g. linux seems to always try to set the mac address during init.
> >    We can have any kind of command received by the PF enable
> >    the filter, until reset.
> 
> I'm not sure it's a valid assumption for any guest, say Windows. The
> VF can start with the MAC address advertised from PF in the first
> reset, and the MAC filter generally will be activated at that point.
> Some other PF/VF variants enable the filter after that until the VF is
> brought up in guest, while some others enable the filter even before
> the VF gets assigned to guest. Trying to assume the behaviour on
> specific guest or specific NIC device is a slippery slope.


Is all this just theoretical or do you observe any problems in practice?

> The only
> thing that's reliable is the semantics of ndo_vf_xxx interface for the
> PF.

ndo_vf_xxx is an internal Linux interface. That's not guaranteed to be
stable at all. I think you mean the netlink interface that triggers
that. That should be stable but if what you say above is true isn't
fully defined.

> You seem to overly assume too much on the specific PF behaviour
> which is not defined in the interface itself.

So IMHO it's something that we should fix in Linux,
making all devices behave consistently.

> >
> >    In absence of an appropriate command, QEMU can detect bus master
> >    enable and do that.
> >
> > 2. Create a variant of trusted VF where it starts out without a valid
> >    MAC, guest can set a softmac MAC but only can set it to the specific
> >    value that matches virtio.
> >    Alternatively - if it's preferred for some reason - allow
> >    guest to program just two MACs, the original one and the virtio one.
> >    Any other value is denied.
> 
> I am getting confused, I don't know why that's even needed. The
> management tool can set any predefined MAC that is deemed safe for VF
> to start with. Why it needs to be that complicated? What is the
> purpose of another model for trusted VF and softmac? It's the PF that
> changes the MAC not the VF.

This will give us a simple solution without guest driver changes for
when VF is trusted. In particular it will work e.g. for PFs as well.

> >
> >
> >
> > > However,
> > > it looks like as of today the MAC matching still haven't addressed the
> > > datapath switching and error handling in a clean way. As said, for
> > > SR-IOV live migration on iSCSI root disk there will be a lot of
> > > dancing parts going along the way, reliable network connectity and
> > > dedicated handshakes are critical to this kind of setup.
> > >
> > > -Siwei
> >
> > I think MAC matching removes downtime when device is removed but not
> > when it's re-added, yes. It has the advantage of an already present
> > linux driver support, but if you are prepared to work on
> > adding e.g. bridge based matching, that will go away.
> 
> The removal order and consequence will be the same between MAC
> matching and group ID based matching. It's just the initial discovery
> that's slightly different. Why do you think the downtime will be
> different for the removal scenario? And why do you think it's needed
> to alter the current PF driver behavior to support bridge based
> matching? Sorry I'm really confused about your suggestion. Those PF
> driver model changes are not needed acutally. The fact is that the
> bridge based matching is supposed to work quite well for any PF driver
> implementation no matter when the MAC address filters gets added or
> enabled.
> 
> Thanks,
> -Siwei

It seems that it requires a bunch of changes for all VF drivers
though.

> 
> >
> >
> > > >
> > > > --
> > > > MST
> > > >
> > > > ---------------------------------------------------------------------
> > > > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > > > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> > > >

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

