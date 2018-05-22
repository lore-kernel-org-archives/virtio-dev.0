Return-Path: virtio-dev-return-4123-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id DB5675818E24
	for <virtio-dev@lists.oasis-open.org>; Tue, 22 May 2018 08:32:33 -0700 (PDT)
Date: Tue, 22 May 2018 18:32:30 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180522181804-mutt-send-email-mst@kernel.org>
References: <1526954781-35359-1-git-send-email-sridhar.samudrala@intel.com>
 <1526954781-35359-3-git-send-email-sridhar.samudrala@intel.com>
 <20180522090637.GE2149@nanopsycho>
 <20180522090853.GF2149@nanopsycho>
 <20180522161007-mutt-send-email-mst@kernel.org>
 <20180522131422.GG2149@nanopsycho>
 <20180522161509-mutt-send-email-mst@kernel.org>
 <20180522132626.GH2149@nanopsycho>
 <20180522163502-mutt-send-email-mst@kernel.org>
 <20180522151343.GJ2149@nanopsycho>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180522151343.GJ2149@nanopsycho>
Subject: [virtio-dev] Re: [PATCH net-next v11 2/5] netvsc: refactor notifier/event
 handling code to use the failover framework
To: Jiri Pirko <jiri@resnulli.us>
Cc: Sridhar Samudrala <sridhar.samudrala@intel.com>, stephen@networkplumber.org, davem@davemloft.net, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, kubakici@wp.pl, jasowang@redhat.com, loseweigh@gmail.com, aaron.f.brown@intel.com, anjali.singhai@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, May 22, 2018 at 05:13:43PM +0200, Jiri Pirko wrote:
> Tue, May 22, 2018 at 03:39:33PM CEST, mst@redhat.com wrote:
> >On Tue, May 22, 2018 at 03:26:26PM +0200, Jiri Pirko wrote:
> >> Tue, May 22, 2018 at 03:17:37PM CEST, mst@redhat.com wrote:
> >> >On Tue, May 22, 2018 at 03:14:22PM +0200, Jiri Pirko wrote:
> >> >> Tue, May 22, 2018 at 03:12:40PM CEST, mst@redhat.com wrote:
> >> >> >On Tue, May 22, 2018 at 11:08:53AM +0200, Jiri Pirko wrote:
> >> >> >> Tue, May 22, 2018 at 11:06:37AM CEST, jiri@resnulli.us wrote:
> >> >> >> >Tue, May 22, 2018 at 04:06:18AM CEST, sridhar.samudrala@intel.com wrote:
> >> >> >> >>Use the registration/notification framework supported by the generic
> >> >> >> >>failover infrastructure.
> >> >> >> >>
> >> >> >> >>Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> >> >> >> >
> >> >> >> >In previous patchset versions, the common code did
> >> >> >> >netdev_rx_handler_register() and netdev_upper_dev_link() etc
> >> >> >> >(netvsc_vf_join()). Now, this is still done in netvsc. Why?
> >> >> >> >
> >> >> >> >This should be part of the common "failover" code.
> >> >> >> >
> >> >> >> 
> >> >> >> Also note that in the current patchset you use IFF_FAILOVER flag for
> >> >> >> master, yet for the slave you use IFF_SLAVE. That is wrong.
> >> >> >> IFF_FAILOVER_SLAVE should be used.
> >> >> >
> >> >> >Or drop IFF_FAILOVER_SLAVE and set both IFF_FAILOVER and IFF_SLAVE?
> >> >> 
> >> >> No. IFF_SLAVE is for bonding.
> >> >
> >> >What breaks if we reuse it for failover?
> >> 
> >> This is exposed to userspace. IFF_SLAVE is expected for bonding slaves.
> >> And failover slave is not a bonding slave.
> >
> >That does not really answer the question.  I'd claim it's sufficiently
> >like a bond slave for IFF_SLAVE to make sense.
> >
> >In fact you will find that netvsc already sets IFF_SLAVE, and so
> 
> netvsc does the whole failover thing in a wrong way. This patchset is
> trying to fix it.

Maybe, but we don't need gratuitous changes either, especially if they
break userspace.

> >does e.g. the eql driver.
> >
> >The advantage of using IFF_SLAVE is that userspace knows to skip it.  If
> 
> The userspace should know how to skip other types of slaves - team,
> bridge, ovs, etc.
> The "master link" should be the one to look at.
> 

How should existing userspace know which ones to skip and which one is
the master?  Right now userspace seems to assume whatever does not have
IFF_SLAVE should be looked at. Are you saying that's not the right thing
to do and userspace should be fixed? What should userspace do in
your opinion that will be forward compatible with future kernels?

> 
> >we don't set IFF_SLAVE existing userspace tries to use the lowerdev.
> 
> Each master type has a IFF_ master flag and IFF_ slave flag.

Could you give some examples please?

> In private
> flag. I don't see no reason to break this pattern here.

Other masters are setup from userspace, this one is set up automatically
by kernel. So the bar is higher, we need an interface that existing
userspace knows about.  We can't just say "oh if userspace set this up
it should know to skip lowerdevs".

Otherwise multiple interfaces with same mac tend to confuse userspace.

-- 
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

