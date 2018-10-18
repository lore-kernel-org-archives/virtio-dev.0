Return-Path: virtio-dev-return-4900-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D957A985E9B
	for <virtio-dev@lists.oasis-open.org>; Thu, 18 Oct 2018 23:20:26 +0000 (UTC)
MIME-Version: 1.0
References: <20180918111540-mutt-send-email-mst@kernel.org>
 <CADGSJ21CujSW=aF7BqdXmSFahLwSgPmG3_KFF5mSeVA5Z8PkQg@mail.gmail.com>
 <20180919230502-mutt-send-email-mst@kernel.org> <CADGSJ22OybVCOsBmqdAHLPBU0PKF13xWz3YtHT=Pw5bT_a71BA@mail.gmail.com>
 <20180920220951-mutt-send-email-mst@kernel.org> <CADGSJ23GRrt25k1G9wD3JhA6en4MuXLE9WA24Ep8PLgkyk_4=A@mail.gmail.com>
 <20180927121739-mutt-send-email-mst@kernel.org> <CADGSJ22JC9asjQ3nVV5e-ajxB-pggJ6ToMGqG072Q5TvFVCKBQ@mail.gmail.com>
 <20181002083928-mutt-send-email-mst@kernel.org> <CADGSJ23NaaPXrgoL1-ySs=SWytE65SORatOFMSapzFsKZUH4yA@mail.gmail.com>
 <20181005101419-mutt-send-email-mst@kernel.org> <CADGSJ22QYRX3GBjDqGgauwiHi6p4FpbUwpromD0=nY+w2FDm=Q@mail.gmail.com>
In-Reply-To: <CADGSJ22QYRX3GBjDqGgauwiHi6p4FpbUwpromD0=nY+w2FDm=Q@mail.gmail.com>
From: Siwei Liu <loseweigh@gmail.com>
Date: Thu, 18 Oct 2018 16:20:13 -0700
Message-ID: <CADGSJ21XgTvbMF7b281O7qiXko=hA8nH9Cw2DZC+7Og=g4E3Dw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [virtio-dev] [PATCH v4] content: Introduce VIRTIO_NET_F_STANDBY feature
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Venu Busireddy <venu.busireddy@oracle.com>, Cornelia Huck <cohuck@redhat.com>, "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, virtio-dev <virtio-dev@lists.oasis-open.org>, liran.alon@oracle.com
List-ID: <virtio-dev.lists.oasis-open.org>

To be honest, I don't understand why there's resistance of using PV to
initiate datapath switching, and the point of relying on very specifc
PF behavior for datapath swtiching, There's even no point to alter the
SR-IOV driver model to accomondate the (zero) downtime requirement,
how potentally can Windows work with that? The current MAC based
scheme is very fragile when dealing with errors, and the past lesson
learnt leads me to believe that those drivers errors in the hot plug
path, even not common, is NOT neglectable.

-Siwei

On Wed, Oct 10, 2018 at 6:26 PM Siwei Liu <loseweigh@gmail.com> wrote:
>
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
>
> > Further, the need to poke at PF filters
> > with set vf does not match the current security model where
> > any security related configuration such as MAC filtering is done upfront.
>
> The security model belongs to the VM policy not the VF, right? I think
> same MAC address will always be used on the VM as it starts with
> virtio. Why it is a security issue that VF starts with an unused MAC
> before it's able to be used in the guest?
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
> specific guest or specific NIC device is a slippery slope. The only
> thing that's reliable is the semantics of ndo_vf_xxx interface for the
> PF. You seem to overly assume too much on the specific PF behaviour
> which is not defined in the interface itself.
>
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
>
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
>
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

