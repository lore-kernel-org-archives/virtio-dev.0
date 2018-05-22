Return-Path: virtio-dev-return-4119-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 92F6158191BB
	for <virtio-dev@lists.oasis-open.org>; Tue, 22 May 2018 06:17:48 -0700 (PDT)
Date: Tue, 22 May 2018 16:17:37 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180522161509-mutt-send-email-mst@kernel.org>
References: <1526954781-35359-1-git-send-email-sridhar.samudrala@intel.com>
 <1526954781-35359-3-git-send-email-sridhar.samudrala@intel.com>
 <20180522090637.GE2149@nanopsycho>
 <20180522090853.GF2149@nanopsycho>
 <20180522161007-mutt-send-email-mst@kernel.org>
 <20180522131422.GG2149@nanopsycho>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180522131422.GG2149@nanopsycho>
Subject: [virtio-dev] Re: [PATCH net-next v11 2/5] netvsc: refactor notifier/event
 handling code to use the failover framework
To: Jiri Pirko <jiri@resnulli.us>
Cc: Sridhar Samudrala <sridhar.samudrala@intel.com>, stephen@networkplumber.org, davem@davemloft.net, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, kubakici@wp.pl, jasowang@redhat.com, loseweigh@gmail.com, aaron.f.brown@intel.com, anjali.singhai@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, May 22, 2018 at 03:14:22PM +0200, Jiri Pirko wrote:
> Tue, May 22, 2018 at 03:12:40PM CEST, mst@redhat.com wrote:
> >On Tue, May 22, 2018 at 11:08:53AM +0200, Jiri Pirko wrote:
> >> Tue, May 22, 2018 at 11:06:37AM CEST, jiri@resnulli.us wrote:
> >> >Tue, May 22, 2018 at 04:06:18AM CEST, sridhar.samudrala@intel.com wrote:
> >> >>Use the registration/notification framework supported by the generic
> >> >>failover infrastructure.
> >> >>
> >> >>Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> >> >
> >> >In previous patchset versions, the common code did
> >> >netdev_rx_handler_register() and netdev_upper_dev_link() etc
> >> >(netvsc_vf_join()). Now, this is still done in netvsc. Why?
> >> >
> >> >This should be part of the common "failover" code.
> >> >
> >> 
> >> Also note that in the current patchset you use IFF_FAILOVER flag for
> >> master, yet for the slave you use IFF_SLAVE. That is wrong.
> >> IFF_FAILOVER_SLAVE should be used.
> >
> >Or drop IFF_FAILOVER_SLAVE and set both IFF_FAILOVER and IFF_SLAVE?
> 
> No. IFF_SLAVE is for bonding.

What breaks if we reuse it for failover?

-- 
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

