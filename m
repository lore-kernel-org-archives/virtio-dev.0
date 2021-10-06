Return-Path: <mst@redhat.com>
Date: Wed, 6 Oct 2021 16:53:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2] Add device reset timeout field
Message-ID: <20211006163309-mutt-send-email-mst@kernel.org>
References: <20211006141033.612283-1-parav@nvidia.com>
 <20211006111143-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54811E06DAED3F7D60955A84DCB09@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54811E06DAED3F7D60955A84DCB09@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Parav Pandit <parav@nvidia.com>
Cc: "cohuck@redhat.com" <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Max Gurtovoy <mgurtovoy@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Oct 06, 2021 at 04:11:19PM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Wednesday, October 6, 2021 8:52 PM
> > 
> > On Wed, Oct 06, 2021 at 05:10:33PM +0300, Parav Pandit wrote:
> > > Motivation:
> > > ==========
> > > Currently when driver initiates a device reset operation, a device may
> > > not be able finish the reset operation immediately. In such case
> > > driver waits for an arbitrary amount of time in a hope that device
> > > will finish the reset.
> > 
> > Hmm does it? Where does spec say that it does? Does not linux really wait
> > forever?
> This proposal doesn't claim that spec says so.
> Linux pci transport waits infinitely.
> Infinite is a valid arbitrary amount. Isn't it ?:-)
> 
> > 
> > > Depending on the device type and its backend implementation a device
> > > timeout can be different. Trying to wait for all device type in same
> > > value may not be efficient or adequate.
> > 
> > Right but do we really want a timeout at all?
> Yes, so that instead of waiting infinitely, it can be time bounded. More below.
> > Why not wait until device is ready or until ctrl-c?
> Device may not be ready at all if its hotunplug is already initiated.
> A device may not come back at all from reset.
> Hence, device providing an upper bound is good hint to driver.
> 
> [..]
> 
> > >
> > > +Once the driver initiates a reset, the device may not be able to
> > > +finish the reset immediately. To accommodate that situation, the
> > > +device can provide a hint to the driver about how long it might take
> > > +the device to complete the reset. The driver should wait at least for
> > > +the time specified by the device to let device finish the reset or if the device
> > status field to become 0 within the specified time interval.
> > > +
> > >  \devicenormative{\subsection}{Device Status Field}{Basic Facilities
> > > of a Virtio Device / Device Status Field}
> > >
> > >  The device MUST NOT consume buffers or send any used buffer
> > 
> > First, do not use should outside normative sections. e.g. you can say "is
> > expected".
> > 
> should is used in same section which has used _must_ in it.

yea, some of these things slip through.

> Can you please help me understand what makes a section normative?

It starts with 
\devicenormative
or
\drivernormative

and is linked from the conformance section.



> 
> > second, I don't see a story around compatibility here.
> Device reset timeout is supported only when device offers the new VIRTIO_DEV_RESET_TIMEOUT.
> When such feature is not offered, driver follows the guidance provided in this proposal.
> Compatibility is covered with the feature bit.

Well hmm. Problem is, devices need to be reset before feature bits
are read.

> > previously pci drivers did wait, other drivers didn't.
> >
> The newer driver that implements updated spec, will adhere to newer content of the spec.

right but we can't just unconditionally say driver must wait,
this would declare old driver non-compliant and we promised
not to do that.

> > I think drivers that actually do wait should somehow let the device know it's
> > ready to wait.
> >
> Why should driver tell device that it is waiting?
> Driver initiated a reset, device may take its time for reset and eventually comes out.
> What can device do differently by knowing that driver is waiting for reset to finish?
> Device usually follow its standard steps to complete the reset action.
> I do not anticipate that device will do reset differently if it knows that no one is waiting for reset to finish.

I think it might matter for hypervisors, these can thinkably block the
write until reset completes if driver is not going to wait.  For the
hardware - if driver is not waiting then hardware has to block the
response to the following non posted transaction whatever that is.
Doing that blocks the cpu and generally breaks the whole
timeout idea. Which you seem to want for some reason ...


> 
> > Third how about making e.g. 0 a special value meaning no limit wait forever?
> The whole idea is to have some finite/deterministic behavior,

I guess I'm being dense, I just don't yet understand the motivation.
The cost is difficulty in migration since each and every
piece of hardware will have a different timeout.

The idea is to have finite behaviour, I got that, but
I don't really know where does the requirement come from,
in what sense it's deterministic and why do we worry
about reset specifically.

Recovering from failure when hardware is broken?

Can we even trust timeout values hardware gives us then?

What about a ton of other stuff like command vq commands
timing out?

> and hence the reasonable finite value.
> When value is not specified, driver is expected to choose reasonable value terminate the reset operation.

No one has any idea what's reasonable.
There's no reason for a driver to choose any
value - it has nothing else to do.

> Do you propose 0 as no limit to follow current driver behavior?

Or maybe 0 will make driver poll.

-- 
MST

