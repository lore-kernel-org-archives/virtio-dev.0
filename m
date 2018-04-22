Return-Path: virtio-dev-return-3935-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 5EF5D58191AB
	for <virtio-dev@lists.oasis-open.org>; Sun, 22 Apr 2018 10:06:50 -0700 (PDT)
Date: Sun, 22 Apr 2018 20:06:47 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180422200259-mutt-send-email-mst@kernel.org>
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
> +#if IS_ENABLED(CONFIG_NET_FAILOVER)
> +
> +int failover_create(struct net_device *standby_dev,
> +		    struct failover **pfailover);

Should we rename all these structs net_failover?
It's possible to extend the concept to storage I think.

> +void failover_destroy(struct failover *failover);
> +
> +int failover_register(struct net_device *standby_dev, struct failover_ops *ops,
> +		      struct failover **pfailover);
> +void failover_unregister(struct failover *failover);
> +
> +int failover_slave_unregister(struct net_device *slave_dev);
> +
> +#else
> +
> +static inline
> +int failover_create(struct net_device *standby_dev,
> +		    struct failover **pfailover);
> +{
> +	return 0;

Does this make callers do something sane?
Shouldn't these return an error?

> +}
> +
> +static inline
> +void failover_destroy(struct failover *failover)
> +{
> +}
> +
> +static inline
> +int failover_register(struct net_device *standby_dev, struct failover_ops *ops,
> +		      struct pfailover **pfailover);
> +{
> +	return 0;
> +}

struct pfailover seems like a typo.

> +
> +static inline
> +void failover_unregister(struct failover *failover)
> +{
> +}
> +
> +static inline
> +int failover_slave_unregister(struct net_device *slave_dev)
> +{
> +	return 0;
> +}

Does anyone test return value of unregister?
should this be void?

> +
> +#endif
> +
> +#endif /* _NET_FAILOVER_H */

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

