Return-Path: virtio-dev-return-3967-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 8D0341CB80F1
	for <virtio-dev@lists.oasis-open.org>; Wed, 25 Apr 2018 19:30:17 -0700 (PDT)
Date: Thu, 26 Apr 2018 05:30:05 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180426052908-mutt-send-email-mst@kernel.org>
References: <1524700768-38627-1-git-send-email-sridhar.samudrala@intel.com>
 <1524700768-38627-5-git-send-email-sridhar.samudrala@intel.com>
 <20180425170837.6520a577@xeon-e3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180425170837.6520a577@xeon-e3>
Subject: [virtio-dev] Re: [PATCH net-next v8 4/4] netvsc: refactor notifier/event handling
 code to use the failover framework
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Sridhar Samudrala <sridhar.samudrala@intel.com>, davem@davemloft.net, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, kubakici@wp.pl, jasowang@redhat.com, loseweigh@gmail.com, jiri@resnulli.us, aaron.f.brown@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Apr 25, 2018 at 05:08:37PM -0700, Stephen Hemminger wrote:
> On Wed, 25 Apr 2018 16:59:28 -0700
> Sridhar Samudrala <sridhar.samudrala@intel.com> wrote:
> 
> > Use the registration/notification framework supported by the generic
> > failover infrastructure.
> > 
> > Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> 
> NAK unless you prove this works on legacy distributions and with DPDK 18.05
> without modification.

It looks like it should work. What kind of proof are you looking for?

-- 
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

