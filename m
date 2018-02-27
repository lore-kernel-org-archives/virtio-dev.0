Return-Path: virtio-dev-return-3293-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 02AF958191A7
	for <virtio-dev@lists.oasis-open.org>; Mon, 26 Feb 2018 17:18:24 -0800 (PST)
Date: Tue, 27 Feb 2018 03:18:12 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180227030424-mutt-send-email-mst@kernel.org>
References: <CAKgT0Ud+6eiY7ycyju1SToeatH1R7KBDcUOqjn9Pu2k5uOr5Wg@mail.gmail.com>
 <20180221165848.GD1996@nanopsycho>
 <CAKgT0UeZS_SzNfiMX3ujy+a9WZWySVdyTpyQ=b=RJJrAG3JO=w@mail.gmail.com>
 <20180221193832.GE1996@nanopsycho>
 <CAKgT0Ud--R7Mw1_jFckskhGmGLZgZbTZ24TuvJ+UWvm_MAQR9w@mail.gmail.com>
 <20180222081115.GC1994@nanopsycho>
 <CAKgT0UeVhPOgRM0J6fyGDAJrTnqjc6AtC8+_UMs=hojZAajtdg@mail.gmail.com>
 <20180223155904.27b11865@xeon-e3>
 <20180226071924.GA2063@nanopsycho>
 <20180226170218.6b1dcf22@xeon-e3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180226170218.6b1dcf22@xeon-e3>
Subject: [virtio-dev] Re: [RFC PATCH v3 0/3] Enable virtio_net to act as a backup for a
 passthru device
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Jiri Pirko <jiri@resnulli.us>, Alexander Duyck <alexander.duyck@gmail.com>, Jakub Kicinski <kubakici@wp.pl>, "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, David Miller <davem@davemloft.net>, Netdev <netdev@vger.kernel.org>, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, "Brandeburg, Jesse" <jesse.brandeburg@intel.com>, "Duyck, Alexander H" <alexander.h.duyck@intel.com>, Jason Wang <jasowang@redhat.com>, Siwei Liu <loseweigh@gmail.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Feb 26, 2018 at 05:02:18PM -0800, Stephen Hemminger wrote:
> On Mon, 26 Feb 2018 08:19:24 +0100
> Jiri Pirko <jiri@resnulli.us> wrote:
> 
> > Sat, Feb 24, 2018 at 12:59:04AM CET, stephen@networkplumber.org wrote:
> > >On Thu, 22 Feb 2018 13:30:12 -0800
> > >Alexander Duyck <alexander.duyck@gmail.com> wrote:
> > >  
> > >> > Again, I undertand your motivation. Yet I don't like your solution.
> > >> > But if the decision is made to do this in-driver bonding. I would like
> > >> > to see it baing done some generic way:
> > >> > 1) share the same "in-driver bonding core" code with netvsc
> > >> >    put to net/core.
> > >> > 2) the "in-driver bonding core" will strictly limit the functionality,
> > >> >    like active-backup mode only, one vf, one backup, vf netdev type
> > >> >    check (so noone could enslave a tap or anything else)
> > >> > If user would need something more, he should employ team/bond.    
> > >
> > >Sharing would be good, but netvsc world would really like to only have
> > >one visible network device.  
> > 
> > Why do you mind? All would be the same, there would be just another
> > netdevice unused by the vm user (same as the vf netdev).
> > 
> 
> I mind because our requirement is no changes to userspace.
> No special udev rules, no bonding script, no setup.

Agreed. It is mostly fine from this point of view, except that you need
to know to skip the slaves.  Maybe we could look at some kind of
trick e.g. pretending link is down for slaves?

> Things like cloudinit running on current distro's expect to see a single
> eth0.  The VF device show up can also be an issue because distro's have
> stupid rules like Network Manager trying to start DHCP on every interface.
> We deal with that now by doing stuff like udev rules to get it to stop
> but that is still causing user errors.

So the ideal of a single net device isn't achieved by netvsc.

Since you have scripts to skip the PT device, can't they
hind the PV slave too? How do they identify the device to skip?

I agree it would be nice to have a way to hide the extra netdev
from userspace.

The benefit of the separation is that each slave device can
be configured with e.g. its own native ethtool commands for
optimum performance.

-- 
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

