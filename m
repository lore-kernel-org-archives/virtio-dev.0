Return-Path: virtio-dev-return-3330-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 059785818CAD
	for <virtio-dev@lists.oasis-open.org>; Wed, 28 Feb 2018 12:48:17 -0800 (PST)
Date: Wed, 28 Feb 2018 22:48:12 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180228223809-mutt-send-email-mst@kernel.org>
References: <20180220104224.GA2031@nanopsycho>
 <CAKgT0UdU8PDXduzxp4kKfur-DLeFQSJj7-fhW_eTgVzd+AcViw@mail.gmail.com>
 <20180227084959.GB2005@nanopsycho>
 <CAKgT0Ucp8WhkORpVVy2VWwuvxZHZjXKn6YfHfVaLAVVybf3t5w@mail.gmail.com>
 <20180227134149.2bff667e@cakuba.netronome.com>
 <20180228070839.GA19654@nanopsycho>
 <20180228160647-mutt-send-email-mst@kernel.org>
 <20180228151131.GF19654@nanopsycho>
 <20180228174449-mutt-send-email-mst@kernel.org>
 <20180228192501.GB2389@nanopsycho>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180228192501.GB2389@nanopsycho>
Subject: [virtio-dev] Re: [RFC PATCH v3 0/3] Enable virtio_net to act as a backup for a
 passthru device
To: Jiri Pirko <jiri@resnulli.us>
Cc: Jakub Kicinski <kubakici@wp.pl>, Alexander Duyck <alexander.duyck@gmail.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>, Stephen Hemminger <stephen@networkplumber.org>, David Miller <davem@davemloft.net>, Netdev <netdev@vger.kernel.org>, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, "Brandeburg, Jesse" <jesse.brandeburg@intel.com>, "Duyck, Alexander H" <alexander.h.duyck@intel.com>, Jason Wang <jasowang@redhat.com>, Siwei Liu <loseweigh@gmail.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Feb 28, 2018 at 08:25:01PM +0100, Jiri Pirko wrote:
> Wed, Feb 28, 2018 at 04:45:39PM CET, mst@redhat.com wrote:
> >On Wed, Feb 28, 2018 at 04:11:31PM +0100, Jiri Pirko wrote:
> >> Wed, Feb 28, 2018 at 03:32:44PM CET, mst@redhat.com wrote:
> >> >On Wed, Feb 28, 2018 at 08:08:39AM +0100, Jiri Pirko wrote:
> >> >> Tue, Feb 27, 2018 at 10:41:49PM CET, kubakici@wp.pl wrote:
> >> >> >On Tue, 27 Feb 2018 13:16:21 -0800, Alexander Duyck wrote:
> >> >> >> Basically we need some sort of PCI or PCIe topology mapping for the
> >> >> >> devices that can be translated into something we can communicate over
> >> >> >> the communication channel. 
> >> >> >
> >> >> >Hm.  This is probably a completely stupid idea, but if we need to
> >> >> >start marshalling configuration requests/hints maybe the entire problem
> >> >> >could be solved by opening a netlink socket from hypervisor?  Even make
> >> >> >teamd run on the hypervisor side...
> >> >> 
> >> >> Interesting. That would be more trickier then just to fwd 1 genetlink
> >> >> socket to the hypervisor.
> >> >> 
> >> >> Also, I think that the solution should handle multiple guest oses. What
> >> >> I'm thinking about is some generic bonding description passed over some
> >> >> communication channel into vm. The vm either use it for configuration,
> >> >> or ignores it if it is not smart enough/updated enough.
> >> >
> >> >For sure, we could build virtio-bond to pass that info to guests.
> >> 
> >> What do you mean by "virtio-bond". virtio_net extension?
> >
> >I mean a new device supplying topology information to guests,
> >with updates whenever VMs are started, stopped or migrated.
> 
> Good. Any idea how that device would look like? Also, any idea how to
> handle in in kernel and how to pass along this info to userspace?
> Is there anything similar out there?
> 
> Thanks!

E.g. balloon is used to pass hints about amount of memory
guest should use. We could do something similar.

I imagine device can send a configuration interrupt
on each topology change. Kernel wakes up userspace pollers.
Userspace starts doing reads from a char device and
figures out what changed.

Which info is needed there? I am not sure.
How about list of MAC/VLAN addresses coupled to list of
devices to queue on (specified by mac? by PCI address)?

Or do we ever need to go higher level and make decisions
based on IP addresses as well?

-- 
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

