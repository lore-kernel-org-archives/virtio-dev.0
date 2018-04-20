Return-Path: virtio-dev-return-3909-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 6AC875818EF8
	for <virtio-dev@lists.oasis-open.org>; Thu, 19 Apr 2018 20:34:55 -0700 (PDT)
Date: Fri, 20 Apr 2018 06:34:42 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180420054853-mutt-send-email-mst@kernel.org>
References: <1524188524-28411-1-git-send-email-sridhar.samudrala@intel.com>
 <1524188524-28411-3-git-send-email-sridhar.samudrala@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524188524-28411-3-git-send-email-sridhar.samudrala@intel.com>
Subject: [virtio-dev] Re: [PATCH v7 net-next 2/4] net: Introduce generic failover module
To: Sridhar Samudrala <sridhar.samudrala@intel.com>
Cc: stephen@networkplumber.org, davem@davemloft.net, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, kubakici@wp.pl, jasowang@redhat.com, loseweigh@gmail.com, jiri@resnulli.us
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Apr 19, 2018 at 06:42:02PM -0700, Sridhar Samudrala wrote:
> +static struct net_device *failover_get_bymac(u8 *mac, struct failover_ops **ops)
> +{
> +	struct net_device *failover_dev;
> +	struct failover *failover;
> +
> +	spin_lock(&failover_lock);
> +	list_for_each_entry(failover, &failover_list, list) {
> +		failover_dev = rtnl_dereference(failover->failover_dev);
> +		if (ether_addr_equal(failover_dev->perm_addr, mac)) {
> +			*ops = rtnl_dereference(failover->ops);
> +			spin_unlock(&failover_lock);
> +			return failover_dev;
> +		}
> +	}
> +	spin_unlock(&failover_lock);
> +	return NULL;
> +}

So it bothers me that this ties to just any device at all.

I thought hard about it, and I see a nice solution.
Here goes:

QEMU has a pci-bridge-seat device. It is used currently to
group e.g. input devices for multiseat support.

Now if you squint at it hard enough, you can see we are also
in a grouping problem. So how about the following:

1. allocate a virtio pci bridge device failover grouping id (reserve through virtio TC).
2. only group two devices in a failover configuration if both
   are under the same bridge with this id (in addition to a mac check).

In particular a bridged configuration makes it easier to
make sure the standby is enumerated before the primary.
In fact we could fail init of failover if we see
appear standby *after* primary.

And this allows many devices with the same ethernet address
without any issues - just under separate bridges.

Further if we ever want to enumerate in parallel this can
be supported by adding a driver for the bridge.

In fact, I see how down the road such a device could
be the beginning of the more ambitious plan to
expose a powerful switchdev interface for
more advanced 


So far so good, but I see a couple of issues:

- it is PCI specific
	 Not a big deal: we limit ourselves to PCI anyway ATM.

- does not work across PCI domains - which are helpful for NUMA
  (e.g. we want to be able to move to primary
   which is on a different numa
   node without losing connectivity).

	Idea: add a "group ID" register to each of these pci bridge
	devices (e.g. in device specific config space).
	Match two bridges if they have the same group ID.

- all these extra bridges slow enumeration down somewhat

	Idea: as a fallback if no bridge is found,
	just assume all devices match, which will result
	in falling back on the "match by mac" logic like in
	this patchset. Will be fine for simple setups.
	

Thoughts?

-- 
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

