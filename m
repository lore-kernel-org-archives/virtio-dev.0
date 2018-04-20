Return-Path: virtio-dev-return-3921-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 5362C5818F9D
	for <virtio-dev@lists.oasis-open.org>; Fri, 20 Apr 2018 08:44:12 -0700 (PDT)
Date: Fri, 20 Apr 2018 18:43:54 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180420183505-mutt-send-email-mst@kernel.org>
References: <1524188524-28411-1-git-send-email-sridhar.samudrala@intel.com>
 <1524188524-28411-5-git-send-email-sridhar.samudrala@intel.com>
 <20180420082802.6ca37e4c@xeon-e3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180420082802.6ca37e4c@xeon-e3>
Subject: [virtio-dev] Re: [PATCH v7 net-next 4/4] netvsc: refactor notifier/event handling
 code to use the failover framework
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Sridhar Samudrala <sridhar.samudrala@intel.com>, davem@davemloft.net, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, kubakici@wp.pl, jasowang@redhat.com, loseweigh@gmail.com, jiri@resnulli.us
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Apr 20, 2018 at 08:28:02AM -0700, Stephen Hemminger wrote:
> On Thu, 19 Apr 2018 18:42:04 -0700
> Sridhar Samudrala <sridhar.samudrala@intel.com> wrote:
> 
> > Use the registration/notification framework supported by the generic
> > failover infrastructure.
> > 
> > Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> 
> Do what you want to other devices but leave netvsc alone.
> Adding these failover ops does not reduce the code size,

drivers/net/hyperv/Kconfig      |   1 +
drivers/net/hyperv/hyperv_net.h |   2 +
drivers/net/hyperv/netvsc_drv.c | 208 ++++++++++------------------------------
3 files changed, 55 insertions(+), 156 deletions(-)

100 lines gone.


> and really is
> no benefit.  The netvsc device driver needs to be backported to several
> other distributions and doing this makes that harder.
> 
> I will NAK patches to change to common code for netvsc

Wow.

> especially the
> three device model.

AFAIK these patches do not change netvsc to a three device model.

> MS worked hard with distro vendors to support transparent
> mode, ans we really can't have a new model;

That's why Sridhar worked hard to preserve a 2 device model for netvsc.

> or do backport.
>
> Plus, DPDK is now dependent on existing model.

DPDK does the kernel bypass thing, doesn't it? Why does the kernel care?

-- 
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

