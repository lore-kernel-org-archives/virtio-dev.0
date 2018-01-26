Return-Path: virtio-dev-return-3083-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 3BC7E581922A
	for <virtio-dev@lists.oasis-open.org>; Fri, 26 Jan 2018 08:59:03 -0800 (PST)
Date: Fri, 26 Jan 2018 18:58:50 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180126185617-mutt-send-email-mst@kernel.org>
References: <1515736720-39368-1-git-send-email-sridhar.samudrala@intel.com>
 <1515736720-39368-3-git-send-email-sridhar.samudrala@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1515736720-39368-3-git-send-email-sridhar.samudrala@intel.com>
Subject: [virtio-dev] Re: [RFC PATCH net-next v2 2/2] virtio_net: Extend virtio to use VF
 datapath when available
To: Sridhar Samudrala <sridhar.samudrala@intel.com>
Cc: stephen@networkplumber.org, davem@davemloft.net, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, kubakici@wp.pl
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Jan 11, 2018 at 09:58:39PM -0800, Sridhar Samudrala wrote:
> @@ -2859,6 +3123,42 @@ static struct virtio_driver virtio_net_driver = {
>  #endif
>  };
>  
> +static int virtio_netdev_event(struct notifier_block *this,
> +			       unsigned long event, void *ptr)
> +{
> +	struct net_device *event_dev = netdev_notifier_info_to_dev(ptr);
> +
> +	/* Skip our own events */
> +	if (event_dev->netdev_ops == &virtnet_netdev)
> +		return NOTIFY_DONE;
> +
> +	/* Avoid non-Ethernet type devices */
> +	if (event_dev->type != ARPHRD_ETHER)
> +		return NOTIFY_DONE;
> +
> +	/* Avoid Vlan dev with same MAC registering as VF */
> +	if (is_vlan_dev(event_dev))
> +		return NOTIFY_DONE;
> +
> +	/* Avoid Bonding master dev with same MAC registering as VF */
> +	if ((event_dev->priv_flags & IFF_BONDING) &&
> +	    (event_dev->flags & IFF_MASTER))
> +		return NOTIFY_DONE;
> +
> +	switch (event) {
> +	case NETDEV_REGISTER:
> +		return virtnet_register_vf(event_dev);
> +	case NETDEV_UNREGISTER:
> +		return virtnet_unregister_vf(event_dev);
> +	default:
> +		return NOTIFY_DONE;
> +	}
> +}
> +
> +static struct notifier_block virtio_netdev_notifier = {
> +	.notifier_call = virtio_netdev_event,
> +};
> +
>  static __init int virtio_net_driver_init(void)
>  {
>  	int ret;
> @@ -2877,6 +3177,8 @@ static __init int virtio_net_driver_init(void)
>          ret = register_virtio_driver(&virtio_net_driver);
>  	if (ret)
>  		goto err_virtio;
> +
> +	register_netdevice_notifier(&virtio_netdev_notifier);
>  	return 0;
>  err_virtio:
>  	cpuhp_remove_multi_state(CPUHP_VIRT_NET_DEAD);
> @@ -2889,6 +3191,7 @@ module_init(virtio_net_driver_init);
>  
>  static __exit void virtio_net_driver_exit(void)
>  {
> +	unregister_netdevice_notifier(&virtio_netdev_notifier);
>  	unregister_virtio_driver(&virtio_net_driver);
>  	cpuhp_remove_multi_state(CPUHP_VIRT_NET_DEAD);
>  	cpuhp_remove_multi_state(virtionet_online);

I have a question here: what if PT device driver module loads
and creates a device before virtio?


> -- 
> 2.14.3

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

