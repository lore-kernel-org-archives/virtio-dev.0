Return-Path: virtio-dev-return-4127-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id AEAF41CB807B
	for <virtio-dev@lists.oasis-open.org>; Tue, 22 May 2018 12:54:47 -0700 (PDT)
Date: Tue, 22 May 2018 22:54:35 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180522204216-mutt-send-email-mst@kernel.org>
References: <20180522161007-mutt-send-email-mst@kernel.org>
 <20180522131422.GG2149@nanopsycho>
 <20180522161509-mutt-send-email-mst@kernel.org>
 <20180522132626.GH2149@nanopsycho>
 <20180522163502-mutt-send-email-mst@kernel.org>
 <20180522151343.GJ2149@nanopsycho>
 <20180522181804-mutt-send-email-mst@kernel.org>
 <20180522154501.GL2149@nanopsycho>
 <20180522194633-mutt-send-email-mst@kernel.org>
 <20180522173844.GP2149@nanopsycho>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180522173844.GP2149@nanopsycho>
Subject: [virtio-dev] Re: [PATCH net-next v11 2/5] netvsc: refactor notifier/event
 handling code to use the failover framework
To: Jiri Pirko <jiri@resnulli.us>
Cc: Sridhar Samudrala <sridhar.samudrala@intel.com>, stephen@networkplumber.org, davem@davemloft.net, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, kubakici@wp.pl, jasowang@redhat.com, loseweigh@gmail.com, aaron.f.brown@intel.com, anjali.singhai@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, May 22, 2018 at 07:38:44PM +0200, Jiri Pirko wrote:
> >> >> In private
> >> >> flag. I don't see no reason to break this pattern here.
> >> >
> >> >Other masters are setup from userspace, this one is set up automatically
> >> >by kernel. So the bar is higher, we need an interface that existing
> >> >userspace knows about.  We can't just say "oh if userspace set this up
> >> >it should know to skip lowerdevs".
> >> >
> >> >Otherwise multiple interfaces with same mac tend to confuse userspace.
> >> 
> >> No difference, really.
> >> Regardless who does the setup, and independent userspace deamon should
> >> react accordingly.
> >
> >If the deamon does the setup itself, it's reasonable to require that it
> >learns about new flags each time we add a new driver.  If it doesn't,
> >then I think it's less reasonable.
> 
> No need. The "IFLA_MASTER" attr is always there to be looked at. That is
> enough.

Oh so if it has an master, skip it? Sorry, I misunderstood what you were
saying earlier.

Thanks, this makes sense to me.

-- 
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

