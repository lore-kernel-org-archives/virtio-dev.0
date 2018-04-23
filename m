Return-Path: virtio-dev-return-3938-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 7728358191AE
	for <virtio-dev@lists.oasis-open.org>; Mon, 23 Apr 2018 10:25:08 -0700 (PDT)
Date: Mon, 23 Apr 2018 20:24:56 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180423202204-mutt-send-email-mst@kernel.org>
References: <1524188524-28411-1-git-send-email-sridhar.samudrala@intel.com>
 <1524188524-28411-5-git-send-email-sridhar.samudrala@intel.com>
 <20180420082802.6ca37e4c@xeon-e3>
 <20180420160058.GB2150@nanopsycho.orion>
 <20180423100406.71b95f74@xeon-e3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180423100406.71b95f74@xeon-e3>
Subject: [virtio-dev] Re: [PATCH v7 net-next 4/4] netvsc: refactor notifier/event handling
 code to use the failover framework
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Jiri Pirko <jiri@resnulli.us>, Sridhar Samudrala <sridhar.samudrala@intel.com>, davem@davemloft.net, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, kubakici@wp.pl, jasowang@redhat.com, loseweigh@gmail.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Apr 23, 2018 at 10:04:06AM -0700, Stephen Hemminger wrote:
> > >
> > >I will NAK patches to change to common code for netvsc especially the
> > >three device model.  MS worked hard with distro vendors to support transparent
> > >mode, ans we really can't have a new model; or do backport.
> > >
> > >Plus, DPDK is now dependent on existing model.  
> > 
> > Sorry, but nobody here cares about dpdk or other similar oddities.
> 
> The network device model is a userspace API, and DPDK is a userspace application.

It is userspace but are you sure dpdk is actually poking at netdevs?
AFAIK it's normally banging device registers directly.

> You can't go breaking userspace even if you don't like the application.

Could you please explain how is the proposed patchset breaking
userspace? Ignoring DPDK for now, I don't think it changes the userspace
API at all.

-- 
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

