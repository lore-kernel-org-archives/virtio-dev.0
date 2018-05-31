Return-Path: virtio-dev-return-4220-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 33FE15818097
	for <virtio-dev@lists.oasis-open.org>; Thu, 31 May 2018 11:36:11 -0700 (PDT)
Date: Thu, 31 May 2018 21:35:59 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180531212356-mutt-send-email-mst@kernel.org>
References: <1527180917-39737-1-git-send-email-sridhar.samudrala@intel.com>
 <1527180917-39737-3-git-send-email-sridhar.samudrala@intel.com>
 <20180530220635.206ee6d7@shemminger-XPS-13-9360>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180530220635.206ee6d7@shemminger-XPS-13-9360>
Subject: [virtio-dev] Re: [PATCH net-next v12 2/5] netvsc: refactor notifier/event
 handling code to use the failover framework
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Sridhar Samudrala <sridhar.samudrala@intel.com>, davem@davemloft.net, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, kubakici@wp.pl, jasowang@redhat.com, loseweigh@gmail.com, jiri@resnulli.us, aaron.f.brown@intel.com, anjali.singhai@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, May 30, 2018 at 10:06:35PM -0400, Stephen Hemminger wrote:
> On Thu, 24 May 2018 09:55:14 -0700
> Sridhar Samudrala <sridhar.samudrala@intel.com> wrote:
> 
> > Use the registration/notification framework supported by the generic
> > failover infrastructure.
> > 
> > Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> 
> Why was this merged? It was never signed off by any of the netvsc maintainers,
> and there were still issues unresolved.
> 
> There are also namespaces issues I am fixing and this breaks them.
> Will start my patch set with a revert for this. Sorry

As long as you finish the patch set with re-integrating with failover,
that's fine IMHO.

I suspect it's easier to add the code to failover though - namespace
things likely affect virtio as well. Lookup by ID would be an optional
feature for virtio, but probably a useful one - I won't ask you
to add it to virtio but it could be a mode in failover
that virtio will activate down the road. And reducing the number of
times we look cards up based on ID can only be a good thing.

-- 
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

