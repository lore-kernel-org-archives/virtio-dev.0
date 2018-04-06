Return-Path: virtio-dev-return-3743-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 59B8458191BA
	for <virtio-dev@lists.oasis-open.org>; Fri,  6 Apr 2018 15:59:17 -0700 (PDT)
References: <1522962503-3963-1-git-send-email-sridhar.samudrala@intel.com>
 <1522962503-3963-4-git-send-email-sridhar.samudrala@intel.com>
 <20180406124814.GA24525@nanopsycho>
From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Message-ID: <bb4f0821-246f-1052-de8b-d96be3388ed3@intel.com>
Date: Fri, 6 Apr 2018 15:59:14 -0700
MIME-Version: 1.0
In-Reply-To: <20180406124814.GA24525@nanopsycho>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: [virtio-dev] Re: [RFC PATCH net-next v5 3/4] virtio_net: Extend virtio to use VF
 datapath when available
To: Jiri Pirko <jiri@resnulli.us>
Cc: mst@redhat.com, stephen@networkplumber.org, davem@davemloft.net, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, kubakici@wp.pl, jasowang@redhat.com, loseweigh@gmail.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 4/6/2018 5:48 AM, Jiri Pirko wrote:
> Thu, Apr 05, 2018 at 11:08:22PM CEST, sridhar.samudrala@intel.com wrote:

<snip>
> 	
>> +
>> +static void virtnet_bypass_set_rx_mode(struct net_device *dev)
>> +{
>> +	struct virtnet_bypass_info *vbi = netdev_priv(dev);
>> +	struct net_device *child_netdev;
>> +
>> +	rcu_read_lock();
>> +
>> +	child_netdev = rcu_dereference(vbi->active_netdev);
>> +	if (child_netdev) {
>> +		dev_uc_sync_multiple(child_netdev, dev);
>> +		dev_mc_sync_multiple(child_netdev, dev);
>> +	}
>> +
>> +	child_netdev = rcu_dereference(vbi->backup_netdev);
>> +	if (child_netdev) {
>> +		dev_uc_sync_multiple(child_netdev, dev);
>> +		dev_mc_sync_multiple(child_netdev, dev);
>> +	}
>> +
>> +	rcu_read_unlock();
>> +}
> This should be moved to bypass module.

Sure. All these bypass ndo_ops can be moved to bypass module and any
paravirtual driver that want to go with 3 netdev model can reuse these functions.


>
>
>> +
>> +static const struct net_device_ops virtnet_bypass_netdev_ops = {
>> +	.ndo_open		= virtnet_bypass_open,
>> +	.ndo_stop		= virtnet_bypass_close,
>> +	.ndo_start_xmit		= virtnet_bypass_start_xmit,
>> +	.ndo_select_queue	= virtnet_bypass_select_queue,
>> +	.ndo_get_stats64	= virtnet_bypass_get_stats,
>> +	.ndo_change_mtu		= virtnet_bypass_change_mtu,
>> +	.ndo_set_rx_mode	= virtnet_bypass_set_rx_mode,
>> +	.ndo_validate_addr	= eth_validate_addr,
>> +	.ndo_features_check	= passthru_features_check,
>> +};
>> +
>> +static int
>> +virtnet_bypass_ethtool_get_link_ksettings(struct net_device *dev,
>> +					  struct ethtool_link_ksettings *cmd)
>> +{
>> +	struct virtnet_bypass_info *vbi = netdev_priv(dev);
>> +	struct net_device *child_netdev;
>> +
>> +	child_netdev = rtnl_dereference(vbi->active_netdev);
>> +	if (!child_netdev || !virtnet_bypass_xmit_ready(child_netdev)) {
>> +		child_netdev = rtnl_dereference(vbi->backup_netdev);
>> +		if (!child_netdev || !virtnet_bypass_xmit_ready(child_netdev)) {
>> +			cmd->base.duplex = DUPLEX_UNKNOWN;
>> +			cmd->base.port = PORT_OTHER;
>> +			cmd->base.speed = SPEED_UNKNOWN;
>> +
>> +			return 0;
>> +		}
>> +	}
>> +
>> +	return __ethtool_get_link_ksettings(child_netdev, cmd);
>> +}
>> +
>> +#define BYPASS_DRV_NAME "virtnet_bypass"
>> +#define BYPASS_DRV_VERSION "0.1"
>> +
>> +static void virtnet_bypass_ethtool_get_drvinfo(struct net_device *dev,
>> +					       struct ethtool_drvinfo *drvinfo)
>> +{
>> +	strlcpy(drvinfo->driver, BYPASS_DRV_NAME, sizeof(drvinfo->driver));
>> +	strlcpy(drvinfo->version, BYPASS_DRV_VERSION, sizeof(drvinfo->version));
>> +}
>> +
>> +static const struct ethtool_ops virtnet_bypass_ethtool_ops = {
>> +	.get_drvinfo            = virtnet_bypass_ethtool_get_drvinfo,
>> +	.get_link               = ethtool_op_get_link,
>> +	.get_link_ksettings     = virtnet_bypass_ethtool_get_link_ksettings,
>> +};
>> +
>> +static int virtnet_bypass_join_child(struct net_device *bypass_netdev,
>> +				     struct net_device *child_netdev)
>> +{
>> +	struct virtnet_bypass_info *vbi;
>> +	bool backup;
>> +
>> +	vbi = netdev_priv(bypass_netdev);
>> +	backup = (child_netdev->dev.parent == bypass_netdev->dev.parent);
>> +	if (backup ? rtnl_dereference(vbi->backup_netdev) :
>> +			rtnl_dereference(vbi->active_netdev)) {
>> +		netdev_info(bypass_netdev,
>> +			    "%s attempting to join bypass dev when %s already present\n",
>> +			    child_netdev->name, backup ? "backup" : "active");
> Bypass module should check if there is already some other netdev
> enslaved and refuse right there.

This will work for virtio-net with 3 netdev model, but this check has to be done by netvsc
as its bypass_netdev is same as the backup_netdev.
Will add a flag while registering with the bypass module to indicate if the driver is doing
a 2 netdev or 3 netdev model and based on that flag this check can be done in bypass module
for 3 netdev scenario.



>
> The active/backup terminology is quite confusing. From the bonding world
> that means active is the one which is currently used for tx of the
> packets. And it depends on link and other things what netdev is declared
> active. However here, it is different. Backup is always the virtio_net
> instance even when it is active. Odd. Please change the terminology.
> For "active" I suggest to use name "stolen".

I am not too happy with 'stolen' name. Will see if i can come up with a
better name.


>
> *** Also, the 2 slave netdev pointers should be stored in the bypass
> module instance, not in the drivers.

Will move virtnet_bypass_info struct to bypass.h

>
>
>
>> +		return -EEXIST;
>> +	}
>> +
>> +	dev_hold(child_netdev);
>> +
>> +	if (backup) {
>> +		rcu_assign_pointer(vbi->backup_netdev, child_netdev);
>> +		dev_get_stats(vbi->backup_netdev, &vbi->backup_stats);
>> +	} else {
>> +		rcu_assign_pointer(vbi->active_netdev, child_netdev);
>> +		dev_get_stats(vbi->active_netdev, &vbi->active_stats);
>> +		bypass_netdev->min_mtu = child_netdev->min_mtu;
>> +		bypass_netdev->max_mtu = child_netdev->max_mtu;
>> +	}
>> +
>> +	netdev_info(bypass_netdev, "child:%s joined\n", child_netdev->name);
>> +
>> +	return 0;
>> +}
>> +
>> +static int virtnet_bypass_register_child(struct net_device *bypass_netdev,
>> +					 struct net_device *child_netdev)
>> +{
>> +	struct virtnet_bypass_info *vbi;
>> +	bool backup;
>> +
>> +	vbi = netdev_priv(bypass_netdev);
>> +	backup = (child_netdev->dev.parent == bypass_netdev->dev.parent);
>> +	if (backup ? rtnl_dereference(vbi->backup_netdev) :
>> +			rtnl_dereference(vbi->active_netdev)) {
>> +		netdev_info(bypass_netdev,
>> +			    "%s attempting to register bypass dev when %s already present\n",
>> +			    child_netdev->name, backup ? "backup" : "active");
>> +		return -EEXIST;
>> +	}
>> +
>> +	/* Avoid non pci devices as active netdev */
>> +	if (!backup && (!child_netdev->dev.parent ||
>> +			!dev_is_pci(child_netdev->dev.parent)))
>> +		return -EINVAL;
>> +
>> +	netdev_info(bypass_netdev, "child:%s registered\n", child_netdev->name);
>> +
>> +	return 0;
>> +}
>> +
>> +static int virtnet_bypass_release_child(struct net_device *bypass_netdev,
>> +					struct net_device *child_netdev)
>> +{
>> +	struct net_device *backup_netdev, *active_netdev;
>> +	struct virtnet_bypass_info *vbi;
>> +
>> +	vbi = netdev_priv(bypass_netdev);
>> +	active_netdev = rtnl_dereference(vbi->active_netdev);
>> +	backup_netdev = rtnl_dereference(vbi->backup_netdev);
>> +
>> +	if (child_netdev != active_netdev && child_netdev != backup_netdev)
>> +		return -EINVAL;
>> +
>> +	netdev_info(bypass_netdev, "child:%s released\n", child_netdev->name);
>> +
>> +	return 0;
>> +}
>> +
>> +static int virtnet_bypass_unregister_child(struct net_device *bypass_netdev,
>> +					   struct net_device *child_netdev)
>> +{
>> +	struct net_device *backup_netdev, *active_netdev;
>> +	struct virtnet_bypass_info *vbi;
>> +
>> +	vbi = netdev_priv(bypass_netdev);
>> +	active_netdev = rtnl_dereference(vbi->active_netdev);
>> +	backup_netdev = rtnl_dereference(vbi->backup_netdev);
>> +
>> +	if (child_netdev != active_netdev && child_netdev != backup_netdev)
>> +		return -EINVAL;
>> +
>> +	if (child_netdev == backup_netdev) {
>> +		RCU_INIT_POINTER(vbi->backup_netdev, NULL);
>> +	} else {
>> +		RCU_INIT_POINTER(vbi->active_netdev, NULL);
>> +		if (backup_netdev) {
>> +			bypass_netdev->min_mtu = backup_netdev->min_mtu;
>> +			bypass_netdev->max_mtu = backup_netdev->max_mtu;
>> +		}
>> +	}
>> +
>> +	dev_put(child_netdev);
>> +
>> +	netdev_info(bypass_netdev, "child:%s unregistered\n",
>> +		    child_netdev->name);
>> +
>> +	return 0;
>> +}
>> +
>> +static int virtnet_bypass_update_link(struct net_device *bypass_netdev,
>> +				      struct net_device *child_netdev)
>> +{
>> +	struct net_device *active_netdev, *backup_netdev;
>> +	struct virtnet_bypass_info *vbi;
>> +
>> +	if (!netif_running(bypass_netdev))
>> +		return 0;
>> +
>> +	vbi = netdev_priv(bypass_netdev);
>> +
>> +	active_netdev = rtnl_dereference(vbi->active_netdev);
>> +	backup_netdev = rtnl_dereference(vbi->backup_netdev);
>> +
>> +	if (child_netdev != active_netdev && child_netdev != backup_netdev)
>> +		return -EINVAL;
>> +
>> +	if ((active_netdev && virtnet_bypass_xmit_ready(active_netdev)) ||
>> +	    (backup_netdev && virtnet_bypass_xmit_ready(backup_netdev))) {
>> +		netif_carrier_on(bypass_netdev);
>> +		netif_tx_wake_all_queues(bypass_netdev);
>> +	} else {
>> +		netif_carrier_off(bypass_netdev);
>> +		netif_tx_stop_all_queues(bypass_netdev);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +/* Called when child dev is injecting data into network stack.
>> + * Change the associated network device from lower dev to virtio.
>> + * note: already called with rcu_read_lock
>> + */
>> +static rx_handler_result_t virtnet_bypass_handle_frame(struct sk_buff **pskb)
>> +{
>> +	struct sk_buff *skb = *pskb;
>> +	struct net_device *ndev = rcu_dereference(skb->dev->rx_handler_data);
>> +
>> +	skb->dev = ndev;
>> +
>> +	return RX_HANDLER_ANOTHER;
>> +}
> Hmm, you have the rx_handler defined in drivers and you register it in
> bypass module. It is odd because here you assume that the bypass module
> passed "ndev" and rx_handler_data. Also, you don't need advanced
> features rx_handler provides.
> Instead, just register a common rx_handler defined in the bypass module
> and have simple skb_rx callback here (static void).

Will move the rx_handler also to bypass.c


>
>
>> +
>> +static const struct bypass_ops virtnet_bypass_ops = {
>> +	.register_child		= virtnet_bypass_register_child,
>> +	.join_child		= virtnet_bypass_join_child,
>> +	.unregister_child	= virtnet_bypass_unregister_child,
>> +	.release_child		= virtnet_bypass_release_child,
>> +	.update_link		= virtnet_bypass_update_link,
>> +	.handle_frame		= virtnet_bypass_handle_frame,
>> +};
>> +
>> +static struct bypass *virtnet_bypass;
>> +
>> +static int virtnet_bypass_create(struct virtnet_info *vi)
>> +{
>> +	struct net_device *backup_netdev = vi->dev;
>> +	struct device *dev = &vi->vdev->dev;
>> +	struct net_device *bypass_netdev;
>> +	int res;
>> +
>> +	/* Alloc at least 2 queues, for now we are going with 16 assuming
>> +	 * that most devices being bonded won't have too many queues.
>> +	 */
>> +	bypass_netdev = alloc_etherdev_mq(sizeof(struct virtnet_bypass_info),
>> +					  16);
>> +	if (!bypass_netdev) {
>> +		dev_err(dev, "Unable to allocate bypass_netdev!\n");
>> +		return -ENOMEM;
>> +	}
>> +
>> +	dev_net_set(bypass_netdev, dev_net(backup_netdev));
>> +	SET_NETDEV_DEV(bypass_netdev, dev);
>> +
>> +	bypass_netdev->netdev_ops = &virtnet_bypass_netdev_ops;
>> +	bypass_netdev->ethtool_ops = &virtnet_bypass_ethtool_ops;
>> +
>> +	/* Initialize the device options */
>> +	bypass_netdev->flags |= IFF_MASTER;
> I think I pointed that out already. Don't use "IFF_MASTER". That is
> specific to bonding. As I suggested in the reply to the patch #2, you
> should introduce IFF_BYPASS. Also, this flag should be set by the bypass
> module. Just create the netdev and do things specific to virtio and then
> call to bypass module, pass the netdev so it can do the rest. I think
> that the flags, features etc would be also fine to set there.

OK.


>
>
>> +	bypass_netdev->priv_flags |= IFF_UNICAST_FLT | IFF_NO_QUEUE;
>> +	bypass_netdev->priv_flags &= ~(IFF_XMIT_DST_RELEASE |
>> +				       IFF_TX_SKB_SHARING);
>> +
>> +	/* don't acquire bypass netdev's netif_tx_lock when transmitting */
>> +	bypass_netdev->features |= NETIF_F_LLTX;
>> +
>> +	/* Don't allow bypass devices to change network namespaces. */
>> +	bypass_netdev->features |= NETIF_F_NETNS_LOCAL;
>> +
>> +	bypass_netdev->hw_features = NETIF_F_HW_CSUM | NETIF_F_SG |
>> +				     NETIF_F_FRAGLIST | NETIF_F_ALL_TSO |
>> +				     NETIF_F_HIGHDMA | NETIF_F_LRO;
>> +
>> +	bypass_netdev->hw_features |= NETIF_F_GSO_ENCAP_ALL;
>> +	bypass_netdev->features |= bypass_netdev->hw_features;
>> +
>> +	/* For now treat bypass netdev as VLAN challenged since we
>> +	 * cannot assume VLAN functionality with a VF
> Why? I don't see such drivers. But to be 100% correct, you should check
> the NETIF_F_VLAN_CHALLENGED feature in bypass module during VF enslave
> and forbid to do so if it is on.

Will look into it.


>
>
>> +	 */
>> +	bypass_netdev->features |= NETIF_F_VLAN_CHALLENGED;
>> +
>> +	memcpy(bypass_netdev->dev_addr, backup_netdev->dev_addr,
>> +	       bypass_netdev->addr_len);
>> +
>> +	bypass_netdev->min_mtu = backup_netdev->min_mtu;
>> +	bypass_netdev->max_mtu = backup_netdev->max_mtu;
>> +
>> +	res = register_netdev(bypass_netdev);
>> +	if (res < 0) {
>> +		dev_err(dev, "Unable to register bypass_netdev!\n");
>> +		goto err_register_netdev;
>> +	}
>> +
>> +	netif_carrier_off(bypass_netdev);
>> +
>> +	res = bypass_register_instance(virtnet_bypass, bypass_netdev);
>> +	if (res < 0)
>> +		goto err_bypass;
>> +
>> +	rcu_assign_pointer(vi->bypass_netdev, bypass_netdev);
>> +
>> +	return 0;
>> +
>> +err_bypass:
>> +	unregister_netdev(bypass_netdev);
>> +err_register_netdev:
>> +	free_netdev(bypass_netdev);
>> +
>> +	return res;
>> +}
>> +
>> +static void virtnet_bypass_destroy(struct virtnet_info *vi)
>> +{
>> +	struct net_device *bypass_netdev;
>> +	struct virtnet_bypass_info *vbi;
>> +	struct net_device *child_netdev;
>> +
>> +	bypass_netdev = rcu_dereference(vi->bypass_netdev);
>> +	/* no device found, nothing to free */
>> +	if (!bypass_netdev)
>> +		return;
>> +
>> +	vbi = netdev_priv(bypass_netdev);
>> +
>> +	netif_device_detach(bypass_netdev);
>> +
>> +	rtnl_lock();
>> +
>> +	child_netdev = rtnl_dereference(vbi->active_netdev);
>> +	if (child_netdev)
>> +		bypass_unregister_child(child_netdev);
>> +
>> +	child_netdev = rtnl_dereference(vbi->backup_netdev);
>> +	if (child_netdev)
>> +		bypass_unregister_child(child_netdev);
>> +
>> +	unregister_netdevice(bypass_netdev);
>> +
>> +	bypass_unregister_instance(virtnet_bypass, bypass_netdev);
>> +
>> +	rtnl_unlock();
>> +
>> +	free_netdev(bypass_netdev);
>> +}
>> +
>> +/* END of functions supporting VIRTIO_NET_F_BACKUP feature. */
>> +
>> static int virtnet_probe(struct virtio_device *vdev)
>> {
>> 	int i, err = -ENOMEM;
>> @@ -2839,10 +3432,15 @@ static int virtnet_probe(struct virtio_device *vdev)
>>
>> 	virtnet_init_settings(dev);
>>
>> +	if (virtio_has_feature(vdev, VIRTIO_NET_F_BACKUP)) {
>> +		if (virtnet_bypass_create(vi) != 0)
> You need to do:
> 		err = virtnet_bypass_create(vi);
> 		if (err)
> otherwise you ignore err and virtnet_probe would return 0;

Sure.


>
>
>> +			goto free_vqs;
>> +	}
>> +
>> 	err = register_netdev(dev);
>> 	if (err) {
>> 		pr_debug("virtio_net: registering device failed\n");
>> -		goto free_vqs;
>> +		goto free_bypass;
>> 	}
>>
>> 	virtio_device_ready(vdev);
>> @@ -2879,6 +3477,8 @@ static int virtnet_probe(struct virtio_device *vdev)
>> 	vi->vdev->config->reset(vdev);
>>
>> 	unregister_netdev(dev);
>> +free_bypass:
>> +	virtnet_bypass_destroy(vi);
>> free_vqs:
>> 	cancel_delayed_work_sync(&vi->refill);
>> 	free_receive_page_frags(vi);
>> @@ -2913,6 +3513,8 @@ static void virtnet_remove(struct virtio_device *vdev)
>>
>> 	unregister_netdev(vi->dev);
>>
>> +	virtnet_bypass_destroy(vi);
>> +
>> 	remove_vq_common(vi);
>>
>> 	free_netdev(vi->dev);
>> @@ -2996,6 +3598,11 @@ static __init int virtio_net_driver_init(void)
>> {
>> 	int ret;
>>
>> +	virtnet_bypass = bypass_register_driver(&virtnet_bypass_ops,
>> +						&virtnet_bypass_netdev_ops);
>> +	if (!virtnet_bypass)
>> +		return -ENOMEM;
> If CONFIG_NET_BYPASS is undefined, you will always return -ENOMEM here.

Will fix.


>
>
>> +
>> 	ret = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN, "virtio/net:online",
>> 				      virtnet_cpu_online,
>> 				      virtnet_cpu_down_prep);
>> @@ -3010,12 +3617,14 @@ static __init int virtio_net_driver_init(void)
>>          ret = register_virtio_driver(&virtio_net_driver);
>> 	if (ret)
>> 		goto err_virtio;
>> +
>> 	return 0;
>> err_virtio:
>> 	cpuhp_remove_multi_state(CPUHP_VIRT_NET_DEAD);
>> err_dead:
>> 	cpuhp_remove_multi_state(virtionet_online);
>> out:
>> +	bypass_unregister_driver(virtnet_bypass);
>> 	return ret;
>> }
>> module_init(virtio_net_driver_init);
>> @@ -3025,6 +3634,7 @@ static __exit void virtio_net_driver_exit(void)
>> 	unregister_virtio_driver(&virtio_net_driver);
>> 	cpuhp_remove_multi_state(CPUHP_VIRT_NET_DEAD);
>> 	cpuhp_remove_multi_state(virtionet_online);
>> +	bypass_unregister_driver(virtnet_bypass);
>> }
>> module_exit(virtio_net_driver_exit);
>>
>> -- 
>> 2.14.3
>>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

