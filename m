Return-Path: virtio-dev-return-3801-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id D8DB65818017
	for <virtio-dev@lists.oasis-open.org>; Tue, 10 Apr 2018 16:29:03 -0700 (PDT)
Date: Wed, 11 Apr 2018 02:28:51 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180411022807-mutt-send-email-mst@kernel.org>
References: <1523386790-12396-1-git-send-email-sridhar.samudrala@intel.com>
 <1523386790-12396-5-git-send-email-sridhar.samudrala@intel.com>
 <20180410142608.50f15b45@xeon-e3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180410142608.50f15b45@xeon-e3>
Subject: [virtio-dev] Re: [RFC PATCH net-next v6 4/4] netvsc: refactor notifier/event
 handling code to use the bypass framework
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Sridhar Samudrala <sridhar.samudrala@intel.com>, davem@davemloft.net, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, kubakici@wp.pl, jasowang@redhat.com, loseweigh@gmail.com, jiri@resnulli.us
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Apr 10, 2018 at 02:26:08PM -0700, Stephen Hemminger wrote:
> On Tue, 10 Apr 2018 11:59:50 -0700
> Sridhar Samudrala <sridhar.samudrala@intel.com> wrote:
> 
> > Use the registration/notification framework supported by the generic
> > bypass infrastructure.
> > 
> > Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> > ---
> 
> Thanks for doing this.  Your current version has couple show stopper
> issues.
> 
> First, the slave device is instantly taking over the slave.
> This doesn't allow udev/systemd to do its device rename of the slave
> device. Netvsc uses a delayed work to workaround this.

Interesting. Does this mean udev must act within a specific time window
then?

> Secondly, the select queue needs to call queue selection in VF.
> The bonding/teaming logic doesn't work well for UDP flows.
> Commit b3bf5666a510 ("hv_netvsc: defer queue selection to VF")
> fixed this performance problem.
> 
> Lastly, more indirection is bad in current climate.
> 
> I am not completely adverse to this but it needs to be fast, simple
> and completely transparent.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

