Return-Path: virtio-dev-return-3538-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 9E11A5818F76
	for <virtio-dev@lists.oasis-open.org>; Tue, 13 Mar 2018 17:41:55 -0700 (PDT)
References: <1519934923-39372-1-git-send-email-sridhar.samudrala@intel.com>
 <1519934923-39372-3-git-send-email-sridhar.samudrala@intel.com>
 <20180312201231.GA17283@nanopsycho>
 <4bfb0f35-cbb4-b9e1-b8b6-9fb723c29140@intel.com>
 <20180312210812.GB17283@nanopsycho>
From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Message-ID: <45ca2aec-6475-06e6-7a38-be6b8aeb362b@intel.com>
Date: Tue, 13 Mar 2018 17:36:23 -0700
MIME-Version: 1.0
In-Reply-To: <20180312210812.GB17283@nanopsycho>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH v4 2/2] virtio_net: Extend virtio to use VF datapath when
 available
To: Jiri Pirko <jiri@resnulli.us>
Cc: mst@redhat.com, stephen@networkplumber.org, davem@davemloft.net, netdev@vger.kernel.org, virtio-dev@lists.oasis-open.org, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, kubakici@wp.pl
List-ID: <virtio-dev.lists.oasis-open.org>

On 3/12/2018 2:08 PM, Jiri Pirko wrote:
> Mon, Mar 12, 2018 at 09:58:06PM CET, sridhar.samudrala@intel.com wrote:
>>
>> On 3/12/2018 1:12 PM, Jiri Pirko wrote:
>>> Thu, Mar 01, 2018 at 09:08:43PM CET, sridhar.samudrala@intel.com wrote:
>>>> This patch enables virtio_net to switch over to a VF datapath when a VF
>>>> netdev is present with the same MAC address. It allows live migration
>>>> of a VM with a direct attached VF without the need to setup a bond/team
>>>> between a VF and virtio net device in the guest.
>>>>
>>>> The hypervisor needs to enable only one datapath at any time so that
>>>> packets don't get looped back to the VM over the other datapath. When a VF
>>>> is plugged, the virtio datapath link state can be marked as down. The
>>>> hypervisor needs to unplug the VF device from the guest on the source host
>>>> and reset the MAC filter of the VF to initiate failover of datapath to
>>>> virtio before starting the migration. After the migration is completed,
>>>> the destination hypervisor sets the MAC filter on the VF and plugs it back
>>>> to the guest to switch over to VF datapath.
>>>>
>>>> When BACKUP feature is enabled, an additional netdev(bypass netdev) is
>>>> created that acts as a master device and tracks the state of the 2 lower
>>>> netdevs. The original virtio_net netdev is marked as 'backup' netdev and a
>>>> passthru device with the same MAC is registered as 'active' netdev.
>>>>
>>>> This patch is based on the discussion initiated by Jesse on this thread.
>>>> https://marc.info/?l=linux-virtualization&m=151189725224231&w=2
>>>>
>>>> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
>>>> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
>>>> Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
>>> [...]
>>>
>>>
>>>> +static int virtnet_bypass_register_child(struct net_device *child_netdev)
>>>> +{
>>>> +	struct virtnet_bypass_info *vbi;
>>>> +	struct net_device *dev;
>>>> +	bool backup;
>>>> +	int ret;
>>>> +
>>>> +	if (child_netdev->addr_len != ETH_ALEN)
>>>> +		return NOTIFY_DONE;
>>>> +
>>>> +	/* We will use the MAC address to locate the virtnet_bypass netdev
>>>> +	 * to associate with the child netdev. If we don't find a matching
>>>> +	 * bypass netdev, move on.
>>>> +	 */
>>>> +	dev = get_virtnet_bypass_bymac(dev_net(child_netdev),
>>>> +				       child_netdev->perm_addr);
>>>> +	if (!dev)
>>>> +		return NOTIFY_DONE;
>>>> +
>>>> +	vbi = netdev_priv(dev);
>>>> +	backup = (child_netdev->dev.parent == dev->dev.parent);
>>>> +	if (backup ? rtnl_dereference(vbi->backup_netdev) :
>>>> +			rtnl_dereference(vbi->active_netdev)) {
>>>> +		netdev_info(dev,
>>>> +			    "%s attempting to join bypass dev when %s already present\n",
>>>> +			    child_netdev->name, backup ? "backup" : "active");
>>>> +		return NOTIFY_DONE;
>>>> +	}
>>>> +
>>>> +	/* Avoid non pci devices as active netdev */
>>>> +	if (!backup && (!child_netdev->dev.parent ||
>>>> +			!dev_is_pci(child_netdev->dev.parent)))
>>>> +		return NOTIFY_DONE;
>>>> +
>>>> +	ret = netdev_rx_handler_register(child_netdev,
>>>> +					 virtnet_bypass_handle_frame, dev);
>>>> +	if (ret != 0) {
>>>> +		netdev_err(child_netdev,
>>>> +			   "can not register bypass receive handler (err = %d)\n",
>>>> +			   ret);
>>>> +		goto rx_handler_failed;
>>>> +	}
>>>> +
>>>> +	ret = netdev_upper_dev_link(child_netdev, dev, NULL);
>>>> +	if (ret != 0) {
>>>> +		netdev_err(child_netdev,
>>>> +			   "can not set master device %s (err = %d)\n",
>>>> +			   dev->name, ret);
>>>> +		goto upper_link_failed;
>>>> +	}
>>>> +
>>>> +	child_netdev->flags |= IFF_SLAVE;
>>>> +
>>>> +	if (netif_running(dev)) {
>>>> +		ret = dev_open(child_netdev);
>>>> +		if (ret && (ret != -EBUSY)) {
>>>> +			netdev_err(dev, "Opening child %s failed ret:%d\n",
>>>> +				   child_netdev->name, ret);
>>>> +			goto err_interface_up;
>>>> +		}
>>>> +	}
>>> Much of this function is copy of netvsc_vf_join, should be shared with
>>> netvsc.
>> Yes. This is based on netvsc_register_vf() and netvsc_vf_join(). But modified
>> to handle registration of 2 child netdevs(backup virtio and active vf).  In case
>> of netvsc, they only register VF. There is no backup netdev.
>> I think trying to make this code shareable with netvsc will introduce additional
>> checks and make it convoluted.
> No problem.

Not clear what you meant here?
Want to confirm that you are agreeing that it is OK to not share this function
with netvsc.


>
>
>>
>>>
>>>> +
>>>> +	/* Align MTU of child with master */
>>>> +	ret = dev_set_mtu(child_netdev, dev->mtu);
>>>> +	if (ret) {
>>>> +		netdev_err(dev,
>>>> +			   "unable to change mtu of %s to %u register failed\n",
>>>> +			   child_netdev->name, dev->mtu);
>>>> +		goto err_set_mtu;
>>>> +	}
>>>> +
>>>> +	call_netdevice_notifiers(NETDEV_JOIN, child_netdev);
>>>> +
>>>> +	netdev_info(dev, "registering %s\n", child_netdev->name);
>>>> +
>>>> +	dev_hold(child_netdev);
>>>> +	if (backup) {
>>>> +		rcu_assign_pointer(vbi->backup_netdev, child_netdev);
>>>> +		dev_get_stats(vbi->backup_netdev, &vbi->backup_stats);
>>>> +	} else {
>>>> +		rcu_assign_pointer(vbi->active_netdev, child_netdev);
>>>> +		dev_get_stats(vbi->active_netdev, &vbi->active_stats);
>>>> +		dev->min_mtu = child_netdev->min_mtu;
>>>> +		dev->max_mtu = child_netdev->max_mtu;
>>>> +	}
>>>> +
>>>> +	return NOTIFY_OK;
>>>> +
>>>> +err_set_mtu:
>>>> +	dev_close(child_netdev);
>>>> +err_interface_up:
>>>> +	netdev_upper_dev_unlink(child_netdev, dev);
>>>> +	child_netdev->flags &= ~IFF_SLAVE;
>>>> +upper_link_failed:
>>>> +	netdev_rx_handler_unregister(child_netdev);
>>>> +rx_handler_failed:
>>>> +	return NOTIFY_DONE;
>>>> +}
>>>> +
>>>> +static int virtnet_bypass_unregister_child(struct net_device *child_netdev)
>>>> +{
>>>> +	struct virtnet_bypass_info *vbi;
>>>> +	struct net_device *dev, *backup;
>>>> +
>>>> +	dev = get_virtnet_bypass_byref(child_netdev);
>>>> +	if (!dev)
>>>> +		return NOTIFY_DONE;
>>>> +
>>>> +	vbi = netdev_priv(dev);
>>>> +
>>>> +	netdev_info(dev, "unregistering %s\n", child_netdev->name);
>>>> +
>>>> +	netdev_rx_handler_unregister(child_netdev);
>>>> +	netdev_upper_dev_unlink(child_netdev, dev);
>>>> +	child_netdev->flags &= ~IFF_SLAVE;
>>>> +
>>>> +	if (child_netdev->dev.parent == dev->dev.parent) {
>>>> +		RCU_INIT_POINTER(vbi->backup_netdev, NULL);
>>>> +	} else {
>>>> +		RCU_INIT_POINTER(vbi->active_netdev, NULL);
>>>> +		backup = rtnl_dereference(vbi->backup_netdev);
>>>> +		if (backup) {
>>>> +			dev->min_mtu = backup->min_mtu;
>>>> +			dev->max_mtu = backup->max_mtu;
>>>> +		}
>>>> +	}
>>>> +
>>>> +	dev_put(child_netdev);
>>>> +
>>>> +	return NOTIFY_OK;
>>>> +}
>>>> +
>>>> +static int virtnet_bypass_update_link(struct net_device *child_netdev)
>>>> +{
>>>> +	struct net_device *dev, *active, *backup;
>>>> +	struct virtnet_bypass_info *vbi;
>>>> +
>>>> +	dev = get_virtnet_bypass_byref(child_netdev);
>>>> +	if (!dev || !netif_running(dev))
>>>> +		return NOTIFY_DONE;
>>>> +
>>>> +	vbi = netdev_priv(dev);
>>>> +
>>>> +	active = rtnl_dereference(vbi->active_netdev);
>>>> +	backup = rtnl_dereference(vbi->backup_netdev);
>>>> +
>>>> +	if ((active && virtnet_bypass_xmit_ready(active)) ||
>>>> +	    (backup && virtnet_bypass_xmit_ready(backup))) {
>>>> +		netif_carrier_on(dev);
>>>> +		netif_tx_wake_all_queues(dev);
>>>> +	} else {
>>>> +		netif_carrier_off(dev);
>>>> +		netif_tx_stop_all_queues(dev);
>>>> +	}
>>>> +
>>>> +	return NOTIFY_OK;
>>>> +}
>>>> +
>>>> +static int virtnet_bypass_event(struct notifier_block *this,
>>>> +				unsigned long event, void *ptr)
>>>> +{
>>>> +	struct net_device *event_dev = netdev_notifier_info_to_dev(ptr);
>>>> +
>>>> +	/* Skip our own events */
>>>> +	if (event_dev->netdev_ops == &virtnet_bypass_netdev_ops)
>>>> +		return NOTIFY_DONE;
>>>> +
>>>> +	/* Avoid non-Ethernet type devices */
>>>> +	if (event_dev->type != ARPHRD_ETHER)
>>>> +		return NOTIFY_DONE;
>>>> +
>>>> +	/* Avoid Vlan dev with same MAC registering as child dev */
>>>> +	if (is_vlan_dev(event_dev))
>>>> +		return NOTIFY_DONE;
>>>> +
>>>> +	/* Avoid Bonding master dev with same MAC registering as child dev */
>>>> +	if ((event_dev->priv_flags & IFF_BONDING) &&
>>>> +	    (event_dev->flags & IFF_MASTER))
>>>> +		return NOTIFY_DONE;
>>>> +
>>>> +	switch (event) {
>>>> +	case NETDEV_REGISTER:
>>>> +		return virtnet_bypass_register_child(event_dev);
>>>> +	case NETDEV_UNREGISTER:
>>>> +		return virtnet_bypass_unregister_child(event_dev);
>>>> +	case NETDEV_UP:
>>>> +	case NETDEV_DOWN:
>>>> +	case NETDEV_CHANGE:
>>>> +		return virtnet_bypass_update_link(event_dev);
>>>> +	default:
>>>> +		return NOTIFY_DONE;
>>>> +	}
>>>> +}
>>> For example this function is 1:1 copy of netvsc, even with comments
>>> and bugs (like IFF_BODING check).
>>>
>>> This is also something that should be shared with netvsc.
>> The problem is with the calls that are made from this function.
>> Sharing would have been possible if both virtio and netvsc went with
>> same netdev model.
> ops? You can still share.

OK. looks like you want to see atleast some code shared between netvsc and virtio_net
even when they are using 2 different netdev models.
Will try to add a new file under net/core and move some functions that can be shared
between netvsc and virtio_net in BACKUP mode.


>
>
>>>
>>>> +
>>>> +static struct notifier_block virtnet_bypass_notifier = {
>>>> +	.notifier_call = virtnet_bypass_event,
>>>> +};
>>>> +
>>>> +static int virtnet_bypass_create(struct virtnet_info *vi)
>>>> +{
>>>> +	struct net_device *backup_netdev = vi->dev;
>>>> +	struct device *dev = &vi->vdev->dev;
>>>> +	struct net_device *bypass_netdev;
>>>> +	int res;
>>>> +
>>>> +	/* Alloc at least 2 queues, for now we are going with 16 assuming
>>>> +	 * that most devices being bonded won't have too many queues.
>>>> +	 */
>>>> +	bypass_netdev = alloc_etherdev_mq(sizeof(struct virtnet_bypass_info),
>>>> +					  16);
>>>> +	if (!bypass_netdev) {
>>>> +		dev_err(dev, "Unable to allocate bypass_netdev!\n");
>>>> +		return -ENOMEM;
>>>> +	}
>>>> +
>>>> +	dev_net_set(bypass_netdev, dev_net(backup_netdev));
>>>> +	SET_NETDEV_DEV(bypass_netdev, dev);
>>>> +
>>>> +	bypass_netdev->netdev_ops = &virtnet_bypass_netdev_ops;
>>>> +	bypass_netdev->ethtool_ops = &virtnet_bypass_ethtool_ops;
>>>> +
>>>> +	/* Initialize the device options */
>>>> +	bypass_netdev->flags |= IFF_MASTER;
>>>> +	bypass_netdev->priv_flags |= IFF_BONDING | IFF_UNICAST_FLT |
>>> No clue why you set IFF_BONDING here...
>> This is to indicate to the userspace that this is a master bond device.
> This is not a master bond device! If you say this, it makes me really
> worried....
>
Will remove IFF_BONDING in the next revision.


>
>> May be it is sufficient to just set IFF_MASTER.
>>
>>>
>>>
>>>
>>>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

