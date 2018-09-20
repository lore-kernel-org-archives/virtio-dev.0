Return-Path: virtio-dev-return-4867-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7647F985D8C
	for <virtio-dev@lists.oasis-open.org>; Thu, 20 Sep 2018 03:11:41 +0000 (UTC)
Date: Wed, 19 Sep 2018 23:11:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180919230502-mutt-send-email-mst@kernel.org>
References: <1534358955-35869-1-git-send-email-sridhar.samudrala@intel.com>
 <20180907173251-mutt-send-email-mst@kernel.org>
 <9bc2db49-77ea-1391-b964-a29da44ff617@intel.com>
 <20180912111819-mutt-send-email-mst@kernel.org>
 <20180918122052.349ba42e.cohuck@redhat.com>
 <20180918093310-mutt-send-email-mst@kernel.org>
 <20180918151337.GA7432@vbusired-dt>
 <20180918111540-mutt-send-email-mst@kernel.org>
 <CADGSJ21CujSW=aF7BqdXmSFahLwSgPmG3_KFF5mSeVA5Z8PkQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADGSJ21CujSW=aF7BqdXmSFahLwSgPmG3_KFF5mSeVA5Z8PkQg@mail.gmail.com>
Subject: Re: [virtio-dev] [PATCH v4] content: Introduce VIRTIO_NET_F_STANDBY
 feature
To: Siwei Liu <loseweigh@gmail.com>
Cc: Venu Busireddy <venu.busireddy@oracle.com>, Cornelia Huck <cohuck@redhat.com>, "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, virtio-dev <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Sep 18, 2018 at 11:48:46AM -0700, Siwei Liu wrote:
> On Tue, Sep 18, 2018 at 8:31 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> > On Tue, Sep 18, 2018 at 10:13:37AM -0500, Venu Busireddy wrote:
> >> On 2018-09-18 09:35:48 -0400, Michael S. Tsirkin wrote:
> >> > On Tue, Sep 18, 2018 at 12:20:52PM +0200, Cornelia Huck wrote:
> >> > > On Wed, 12 Sep 2018 11:22:12 -0400
> >> > > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >> > >
> >> > > > On Wed, Sep 12, 2018 at 08:17:45AM -0700, Samudrala, Sridhar wrote:
> >> > > > >
> >> > > > >
> >> > > > > On 9/7/2018 2:34 PM, Michael S. Tsirkin wrote:
> >> > > > > > On Wed, Aug 15, 2018 at 11:49:15AM -0700, Sridhar Samudrala wrote:
> >> > > > > > > VIRTIO_NET_F_STANDBY feature enables hypervisor to indicate virtio_net
> >> > > > > > > device to act as a standby for another device with the same MAC address.
> >> > > > > > >
> >> > > > > > > Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> >> > > > > > > Acked-by: Cornelia Huck <cohuck@redhat.com>
> >> > > > > > > Fixes: https://github.com/oasis-tcs/virtio-spec/issues/18
> >> > > > > > Applied but when do you plan to add documentation as pointed
> >> > > > > > out by Jan and Halil?
> >> > > > >
> >> > > > > I thought additional documentation will be done as part of the Qemu enablement
> >> > > > > patches and i hope someone in RH is looking into it.
> >> > > > >
> >> > > > > Does it make sense to add a link to to the kernel documentation of this feature in
> >> > > > > the spec
> >> > > > >  https://www.kernel.org/doc/html/latest/networking/net_failover.html
> >> > > >
> >> > > >
> >> > > > I do not think this will address the comments posted.  Specifically we
> >> > > > should probably include documentation for what is a standby and primary:
> >> > > > what is expected of driver (maintain configuration on standby, support
> >> > > > primary coming and going, transmit on standby only if there is no
> >> > > > primary) and of device (have same mac for standby as for standby).
> >> > >
> >> > > Yes, we need some definitive statements of what a driver and a device
> >> > > is supposed to do in order to conform; it might make sense to discuss
> >> > > this in conjunction with discussion on any QEMU patches (have not
> >> > > checked whether anything has been posted, just returned from vacation).
> >> > >
> >> > > I assume that we still stick with the plan to implement/document
> >> > > MAC-based handling first and then enhance with other methods later?
> >> >
> >> > I'm fine with that at least. If someone wants to work on
> >> > other methods straight away, that's also fine by me.
> >>
> >> Patch set [1] implements the failover-group-id mechanism. Are you
> >> thinking of some other method?
> >>
> >> Venu
> >>
> >> [1] https://lists.oasis-open.org/archives/virtio-dev/201806/msg00384.html
> >>
> >
> > Yes, the grouping mechanism seems fine to me (I don't remember
> > about the implementation, it's been a while).
> >
> > It is not by itself sufficient though, is it?
> 
> I do understand that the group ID patch is incomplete though it's a
> base patch for the real work.
> 
> >
> > MAC is assumed to be shared to avoid things like ARP/neighboor
> > rediscovery, right?
> 
> True, but does this really need to be part of the guest-host
> interface? Or rather, I don't see how MAC based matching can be done
> on the host part.

mac address matching does not need to affect host side.

> Are you going to expose MAC address to VFIO?

If mac of a VF is programmed by libvirt through the PF
(that's already the case), VFIO does not need to care about it.

> 
> The thing is the current MAC based implementation has intrinsic flaw
> that doesn't propagate errors to hypervisor, or there's no back
> channel for guest to unwind the hot plug action upon failure in
> probing or enslaving the primary.

I guess you can eject the primary if you like. But
why does hypervisor need to know? On error, just don't use primary,
use standby.

> If you think about a more robust
> implementation, another grouping mechanism rather than MAC is pretty
> much required.
> 
> Thanks,
> -Siwei

I don't really know what is the flaw, or how is it fixed by a grouping
mechanism. All this motivation was never described as part of work on
an alternate grouping.

> > If true that implies that to avoid guest confusion visibility of the
> > primary needs to be controlled by standby's driver.
> > This makes this patchset incomplete.
> >
> > For this work to be complete what is needed is:
> > - hypervisor: add control of primary's visibility to guest
> > - guest: add support for this grouping to the failover driver
> >
> > We also need
> > - spec: document matching rules based on the pci bridge
> >
> > and it's helpful to have a spec proposal with implementation, but I
> > would say at least proposed patches to one of the above 2 would be
> > helpful before we include this in spec.
> >
> > --
> > MST
> >
> > ---------------------------------------------------------------------
> > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> >

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

