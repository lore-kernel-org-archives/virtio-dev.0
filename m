Return-Path: virtio-dev-return-5116-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0B815985C25
	for <virtio-dev@lists.oasis-open.org>; Tue,  4 Dec 2018 03:59:48 +0000 (UTC)
Date: Mon, 3 Dec 2018 22:59:44 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181203224508-mutt-send-email-mst@kernel.org>
References: <20181128123424-mutt-send-email-mst@kernel.org>
 <0a81c110-610e-2183-3483-95faf53c3fce@intel.com>
 <20181128135154-mutt-send-email-mst@kernel.org>
 <1aeab969-f47f-42c3-31a0-b4c5df647d58@oracle.com>
 <20181128195226-mutt-send-email-mst@kernel.org>
 <cca54913-42c0-55bf-986e-8670c49fb8fe@oracle.com>
 <20181129160950-mutt-send-email-mst@kernel.org>
 <2f44fe5e-ee7d-96cd-dd85-f663fa04c7d0@oracle.com>
 <20181130004530-mutt-send-email-mst@kernel.org>
 <3035130f-ad02-39d7-a897-aec3a3f2fee5@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3035130f-ad02-39d7-a897-aec3a3f2fee5@oracle.com>
Subject: Re: [virtio-dev] [PATCH v4] content: Introduce VIRTIO_NET_F_STANDBY
 feature
To: si-wei liu <si-wei.liu@oracle.com>
Cc: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, Carolyn <carolyn.wyborny@intel.com>, Sameeh Jubran <sameeh@daynix.com>, Siwei Liu <loseweigh@gmail.com>, venu.busireddy@oracle.com, cohuck@redhat.com, virtio-dev <virtio-dev@lists.oasis-open.org>, liran.alon@oracle.com, Yan Vugenfirer <yan@daynix.com>, "Brandeburg, Jesse" <jesse.brandeburg@intel.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Dec 03, 2018 at 06:09:19PM -0800, si-wei liu wrote:
> > I agree. But a single flag is not much of an extension. We don't even
> > need it in netlink, can be anywhere in e.g. sysfs.
> I think sysfs attribute is for exposing the capability, while you still need
> to set up macvtap with some special mode via netlink. That way it doesn't
> break current behavior, and when VF's MAC filter is added macvtap would need
> to react to remove the filter from NIC. And add the one back when VF's MAC
> is removed.

All this will be up to the developers actually working on it. My
understanding is that intel is going to just change the behaviour
unconditionally, and it's already the case for Mellanox.
That creates a critical mass large enough that maybe others
just need to confirm.

...


> > Meanwhile what's missing and was missing all along for the change you
> > seem to be advocating for to get off the ground is people who
> > are ready to actually send e.g. spec, guest driver, test patches.
> Partly because it hadn't been converged to the best way to do it (even the
> group ID mechanism with PCI bridge can address our need you don't seem to
> think it is valuable). The in-kernel approach is fine at its appearance, but
> I personally don't believe changing every legacy driver is the way to go.
> It's the choice of implementation and what has been implemented in those
> drivers today IMHO is nothing wrong.

It's not a question of being wrong as such.
A standard behaviour is clearly better than each driver doing its
own thing which is the case now. As long as we ar standardizing,
let's standardize on something that matches our needs?
But I really see no problem with also supporting other options,
as long as someone is prepared to actually put in the work.


> > 
> > > >    Still this assumes just creating a VF
> > > > doesn't yet program the on-card filter to cause packet drops.
> > > Suppose this behavior is fixable in legacy Intel NIC, you would still need
> > > to evacuate the filter programmed by macvtap previously when VF's filter
> > > gets activated (typically when VF's netdev is netif_running() in a Linux
> > > guest). That's what we and NetVSC call as "datapath switching", and where
> > > this could be handled (driver, net core, or userspace) is the core for the
> > > architectural design that I spent much time on.
> > > 
> > > Having said it, I don't expect or would desperately wait on one vendor to
> > > fix a legacy driver which wasn't quite motivated, then no work would be done
> > > on that.
> > Then that device can't be used with the mechanism in question.
> > Or if there are lots of drivers like this maybe someone will be
> > motivated enough to post a better implementation with a new
> > feature bit. It's not that I'm arguing against that.
> > 
> > But given the options of teaching management to play with
> > netlink API in response to guest actions, and with VCPU stopped,
> > and doing it all in host kernel drivers, I know I'll prefer host kernel
> > changes.
> We have some internal patches that leverage management to respond to various
> guest actions. If you're interested we can post them. The thing is no one
> would like to work on the libvirt changes, while internally we have our own
> orchestration software which is not libvirt. But if you think it's fine we
> can definitely share our QEMU patches while leaving out libvirt.
> 
> Thanks,
> -Siwei

Sure, why not.

The following is generally necessary for any virtio project to happen:
- guest patches
- qemu patches
- spec documentation

Some extras are sometimes a dependency, e.g. host kernel patches.


Typically at least two of these are enough for people to
be able to figure out how things work.




> > 
> > > If you'd go the way, please make sure Intel could change their
> > > driver first.
> > We'll see what happens with that. It's Sridhar from intel that implemented
> > the guest changes after all, so I expect he's motivated to make them
> > work well.
> > 
> > 
> > > >    Let's
> > > > assume drivers are fixed to do that. How does userspace know
> > > > that's the case? We might need some kind of attribute so
> > > > userspace can detect it.
> > > Where do you envision the new attribute could be at? Supposedly it'd be
> > > exposed by the kernel, which constitutes a new API or API changes.
> > > 
> > > 
> > > Thanks,
> > > -Siwei
> > People add e.g. new attributes in sysfs left and right.  It's unlikely
> > to be a matter of serious contention.
> > 
> > > > > > Question is how does userspace know driver isn't broken in this respect?
> > > > > > Let's add a "vf failover" flag somewhere so this can be probed?
> > > > > > 
> > ---------------------------------------------------------------------
> > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> > 

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

