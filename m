Return-Path: virtio-dev-return-3861-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 8E0AD5818F65
	for <virtio-dev@lists.oasis-open.org>; Wed, 18 Apr 2018 11:43:27 -0700 (PDT)
References: <1523386790-12396-1-git-send-email-sridhar.samudrala@intel.com>
 <1523386790-12396-3-git-send-email-sridhar.samudrala@intel.com>
 <20180411155127.GQ2028@nanopsycho>
 <6a8c1ff5-153a-e40a-91b3-48532b8d3a38@intel.com>
 <20180418092515.GB1989@nanopsycho>
From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Message-ID: <dd0d53f0-f5da-cb7d-f8f6-d0c8245eb3cf@intel.com>
Date: Wed, 18 Apr 2018 11:43:15 -0700
MIME-Version: 1.0
In-Reply-To: <20180418092515.GB1989@nanopsycho>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: [virtio-dev] Re: [RFC PATCH net-next v6 2/4] net: Introduce generic bypass module
To: Jiri Pirko <jiri@resnulli.us>
Cc: mst@redhat.com, stephen@networkplumber.org, davem@davemloft.net, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, kubakici@wp.pl, jasowang@redhat.com, loseweigh@gmail.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 4/18/2018 2:25 AM, Jiri Pirko wrote:
> Wed, Apr 11, 2018 at 09:13:52PM CEST, sridhar.samudrala@intel.com wrote:
>> On 4/11/2018 8:51 AM, Jiri Pirko wrote:
>>> Tue, Apr 10, 2018 at 08:59:48PM CEST, sridhar.samudrala@intel.com wrote:
>>>> This provides a generic interface for paravirtual drivers to listen
>>>> for netdev register/unregister/link change events from pci ethernet
>>>> devices with the same MAC and takeover their datapath. The notifier and
>>>> event handling code is based on the existing netvsc implementation.
>>>>
>>>> It exposes 2 sets of interfaces to the paravirtual drivers.
>>>> 1. existing netvsc driver that uses 2 netdev model. In this model, no
>>>> master netdev is created. The paravirtual driver registers each bypass
>>>> instance along with a set of ops to manage the slave events.
>>>>       bypass_master_register()
>>>>       bypass_master_unregister()
>>>> 2. new virtio_net based solution that uses 3 netdev model. In this model,
>>>> the bypass module provides interfaces to create/destroy additional master
>>>> netdev and all the slave events are managed internally.
>>>>        bypass_master_create()
>>>>        bypass_master_destroy()
>>>>
>>>> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
>>>> ---
>>>> include/linux/netdevice.h |  14 +
>>>> include/net/bypass.h      |  96 ++++++
>>>> net/Kconfig               |  18 +
>>>> net/core/Makefile         |   1 +
>>>> net/core/bypass.c         | 844 ++++++++++++++++++++++++++++++++++++++++++++++
>>>> 5 files changed, 973 insertions(+)
>>>> create mode 100644 include/net/bypass.h
>>>> create mode 100644 net/core/bypass.c
>>>>
>>>> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
>>>> index cf44503ea81a..587293728f70 100644
>>>> --- a/include/linux/netdevice.h
>>>> +++ b/include/linux/netdevice.h
>>>> @@ -1430,6 +1430,8 @@ enum netdev_priv_flags {
>>>> 	IFF_PHONY_HEADROOM		= 1<<24,
>>>> 	IFF_MACSEC			= 1<<25,
>>>> 	IFF_NO_RX_HANDLER		= 1<<26,
>>>> +	IFF_BYPASS			= 1 << 27,
>>>> +	IFF_BYPASS_SLAVE		= 1 << 28,
>>> I wonder, why you don't follow the existing coding style... Also, please
>>> add these to into the comment above.
>> To avoid checkpatch warnings. If it is OK to ignore these warnings, I can switch back
>> to the existing coding style to be consistent.
> Please do.
>
>
>>>
>>>> };
>>>>
>>>> #define IFF_802_1Q_VLAN			IFF_802_1Q_VLAN
>>>> @@ -1458,6 +1460,8 @@ enum netdev_priv_flags {
>>>> #define IFF_RXFH_CONFIGURED		IFF_RXFH_CONFIGURED
>>>> #define IFF_MACSEC			IFF_MACSEC
>>>> #define IFF_NO_RX_HANDLER		IFF_NO_RX_HANDLER
>>>> +#define IFF_BYPASS			IFF_BYPASS
>>>> +#define IFF_BYPASS_SLAVE		IFF_BYPASS_SLAVE
>>>>
>>>> /**
>>>>    *	struct net_device - The DEVICE structure.
>>>> @@ -4308,6 +4312,16 @@ static inline bool netif_is_rxfh_configured(const struct net_device *dev)
>>>> 	return dev->priv_flags & IFF_RXFH_CONFIGURED;
>>>> }
>>>>
>>>> +static inline bool netif_is_bypass_master(const struct net_device *dev)
>>>> +{
>>>> +	return dev->priv_flags & IFF_BYPASS;
>>>> +}
>>>> +
>>>> +static inline bool netif_is_bypass_slave(const struct net_device *dev)
>>>> +{
>>>> +	return dev->priv_flags & IFF_BYPASS_SLAVE;
>>>> +}
>>>> +
>>>> /* This device needs to keep skb dst for qdisc enqueue or ndo_start_xmit() */
>>>> static inline void netif_keep_dst(struct net_device *dev)
>>>> {
>>>> diff --git a/include/net/bypass.h b/include/net/bypass.h
>>>> new file mode 100644
>>>> index 000000000000..86b02cb894cf
>>>> --- /dev/null
>>>> +++ b/include/net/bypass.h
>>>> @@ -0,0 +1,96 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +/* Copyright (c) 2018, Intel Corporation. */
>>>> +
>>>> +#ifndef _NET_BYPASS_H
>>>> +#define _NET_BYPASS_H
>>>> +
>>>> +#include <linux/netdevice.h>
>>>> +
>>>> +struct bypass_ops {
>>>> +	int (*slave_pre_register)(struct net_device *slave_netdev,
>>>> +				  struct net_device *bypass_netdev);
>>>> +	int (*slave_join)(struct net_device *slave_netdev,
>>>> +			  struct net_device *bypass_netdev);
>>>> +	int (*slave_pre_unregister)(struct net_device *slave_netdev,
>>>> +				    struct net_device *bypass_netdev);
>>>> +	int (*slave_release)(struct net_device *slave_netdev,
>>>> +			     struct net_device *bypass_netdev);
>>>> +	int (*slave_link_change)(struct net_device *slave_netdev,
>>>> +				 struct net_device *bypass_netdev);
>>>> +	rx_handler_result_t (*handle_frame)(struct sk_buff **pskb);
>>>> +};
>>>> +
>>>> +struct bypass_master {
>>>> +	struct list_head list;
>>>> +	struct net_device __rcu *bypass_netdev;
>>>> +	struct bypass_ops __rcu *ops;
>>>> +};
>>>> +
>>>> +/* bypass state */
>>>> +struct bypass_info {
>>>> +	/* passthru netdev with same MAC */
>>>> +	struct net_device __rcu *active_netdev;
>>> You still use "active"/"backup" names which is highly misleading as
>>> it has completely different meaning that in bond for example.
>>> I noted that in my previous review already. Please change it.
>> I guess the issue is with only the 'active'  name. 'backup' should be fine as it also
>> matches with the BACKUP feature bit we are adding to virtio_net.
> I think that "backup" is also misleading. Both "active" and "backup"
> mean a *state* of slaves. This should be named differently.
>
>
>
>> With regards to alternate names for 'active', you suggested 'stolen', but i
>> am not too happy with it.
>> netvsc uses vf_netdev, are you OK with this? Or another option is 'passthru'
> No. The netdev could be any netdevice. It does not have to be a "VF".
> I think "stolen" is quite appropriate since it describes the modus
> operandi. The bypass master steals some netdevice according to some
> match.
>
> But I don't insist on "stolen". Just sounds right.

We are adding VIRTIO_NET_F_BACKUP as a new feature bit to enable this feature, So i think
'backup' name is consistent.

The intent is to restrict the 'active' netdev to be a VF. If there is a way to check that
a PCI device is a VF in the guest kernel, we could restrict 'active' netdev to be a VF.

Will look for any suggestions in the next day or two. If i don't get any, i will go
with 'stolen'

<snip>


> +
> +static struct net_device *bypass_master_get_bymac(u8 *mac,
> +						  struct bypass_ops **ops)
> +{
> +	struct bypass_master *bypass_master;
> +	struct net_device *bypass_netdev;
> +
> +	spin_lock(&bypass_lock);
> +	list_for_each_entry(bypass_master, &bypass_master_list, list) {
>>> As I wrote the last time, you don't need this list, spinlock.
>>> You can do just something like:
>>>           for_each_net(net) {
>>>                   for_each_netdev(net, dev) {
>>> 			if (netif_is_bypass_master(dev)) {
>> This function returns the upper netdev as well as the ops associated
>> with that netdev.
>> bypass_master_list is a list of 'struct bypass_master' that associates
> Well, can't you have it in netdev priv?

We cannot do this for 2-netdev model as there is no bypass_netdev created.

>
>
>> 'bypass_netdev' with 'bypass_ops' and gets added via bypass_master_register().
>> We need 'ops' only to support the 2 netdev model of netvsc. ops will be
>> NULL for 3-netdev model.
> I see :(
>
>
>>
>>>
>>>
>>>
>>>> +		bypass_netdev = rcu_dereference(bypass_master->bypass_netdev);
>>>> +		if (ether_addr_equal(bypass_netdev->perm_addr, mac)) {
>>>> +			*ops = rcu_dereference(bypass_master->ops);
>>> I don't see how rcu_dereference is ok here.
>>> 1) I don't see rcu_read_lock taken
>>> 2) Looks like bypass_master->ops has the same value across the whole
>>>      existence.
>> We hold rtnl_lock(), i think i need to change this to rtnl_dereference.
>> Yes. ops doesn't change.
> If it does not change, you can just access it directly.
>
>
>>>
>>>> +			spin_unlock(&bypass_lock);
>>>> +			return bypass_netdev;
>>>> +		}
>>>> +	}
>>>> +	spin_unlock(&bypass_lock);
>>>> +	return NULL;
>>>> +}
>>>> +
>>>> +static int bypass_slave_register(struct net_device *slave_netdev)
>>>> +{
>>>> +	struct net_device *bypass_netdev;
>>>> +	struct bypass_ops *bypass_ops;
>>>> +	int ret, orig_mtu;
>>>> +
>>>> +	ASSERT_RTNL();
>>>> +
>>>> +	bypass_netdev = bypass_master_get_bymac(slave_netdev->perm_addr,
>>>> +						&bypass_ops);
>>> For master, could you use word "master" in the variables so it is clear?
>>> Also, "dev" is fine instead of "netdev".
>>> Something like "bpmaster_dev"
>> bypass_master is of  type struct bypass_master,  bypass_netdev is of type struct net_device.
> I was trying to point out, that "bypass_netdev" represents a "master"
> netdev, yet it does not say master. That is why I suggested
> "bpmaster_dev"
>
>
>> I can change all _netdev suffixes to _dev to make the names shorter.
> ok.
>
>
>>
>>>
>>>> +	if (!bypass_netdev)
>>>> +		goto done;
>>>> +
>>>> +	ret = bypass_slave_pre_register(slave_netdev, bypass_netdev,
>>>> +					bypass_ops);
>>>> +	if (ret != 0)
>>> 	Just "if (ret)" will do. You have this on more places.
>> OK.
>>
>>
>>>
>>>> +		goto done;
>>>> +
>>>> +	ret = netdev_rx_handler_register(slave_netdev,
>>>> +					 bypass_ops ? bypass_ops->handle_frame :
>>>> +					 bypass_handle_frame, bypass_netdev);
>>>> +	if (ret != 0) {
>>>> +		netdev_err(slave_netdev, "can not register bypass rx handler (err = %d)\n",
>>>> +			   ret);
>>>> +		goto done;
>>>> +	}
>>>> +
>>>> +	ret = netdev_upper_dev_link(slave_netdev, bypass_netdev, NULL);
>>>> +	if (ret != 0) {
>>>> +		netdev_err(slave_netdev, "can not set master device %s (err = %d)\n",
>>>> +			   bypass_netdev->name, ret);
>>>> +		goto upper_link_failed;
>>>> +	}
>>>> +
>>>> +	slave_netdev->priv_flags |= IFF_BYPASS_SLAVE;
>>>> +
>>>> +	if (netif_running(bypass_netdev)) {
>>>> +		ret = dev_open(slave_netdev);
>>>> +		if (ret && (ret != -EBUSY)) {
>>>> +			netdev_err(bypass_netdev, "Opening slave %s failed ret:%d\n",
>>>> +				   slave_netdev->name, ret);
>>>> +			goto err_interface_up;
>>>> +		}
>>>> +	}
>>>> +
>>>> +	/* Align MTU of slave with master */
>>>> +	orig_mtu = slave_netdev->mtu;
>>>> +	ret = dev_set_mtu(slave_netdev, bypass_netdev->mtu);
>>>> +	if (ret != 0) {
>>>> +		netdev_err(bypass_netdev, "unable to change mtu of %s to %u register failed\n",
>>>> +			   slave_netdev->name, bypass_netdev->mtu);
>>>> +		goto err_set_mtu;
>>>> +	}
>>>> +
>>>> +	ret = bypass_slave_join(slave_netdev, bypass_netdev, bypass_ops);
>>>> +	if (ret != 0)
>>>> +		goto err_join;
>>>> +
>>>> +	call_netdevice_notifiers(NETDEV_JOIN, slave_netdev);
>>>> +
>>>> +	netdev_info(bypass_netdev, "bypass slave:%s registered\n",
>>>> +		    slave_netdev->name);
>>>> +
>>>> +	goto done;
>>>> +
>>>> +err_join:
>>>> +	dev_set_mtu(slave_netdev, orig_mtu);
>>>> +err_set_mtu:
>>>> +	dev_close(slave_netdev);
>>>> +err_interface_up:
>>>> +	netdev_upper_dev_unlink(slave_netdev, bypass_netdev);
>>>> +	slave_netdev->priv_flags &= ~IFF_BYPASS_SLAVE;
>>>> +upper_link_failed:
>>>> +	netdev_rx_handler_unregister(slave_netdev);
>>>> +done:
>>>> +	return NOTIFY_DONE;
>>>> +}
>>>> +
>>>> +static int bypass_slave_pre_unregister(struct net_device *slave_netdev,
>>>> +				       struct net_device *bypass_netdev,
>>>> +				       struct bypass_ops *bypass_ops)
>>>> +{
>>>> +	struct net_device *backup_netdev, *active_netdev;
>>>> +	struct bypass_info *bi;
>>>> +
>>>> +	if (bypass_ops) {
>>>> +		if (!bypass_ops->slave_pre_unregister)
>>>> +			return -EINVAL;
>>>> +
>>>> +		return bypass_ops->slave_pre_unregister(slave_netdev,
>>>> +							bypass_netdev);
>>>> +	}
>>>> +
>>>> +	bi = netdev_priv(bypass_netdev);
>>>> +	active_netdev = rtnl_dereference(bi->active_netdev);
>>>> +	backup_netdev = rtnl_dereference(bi->backup_netdev);
>>>> +
>>>> +	if (slave_netdev != active_netdev && slave_netdev != backup_netdev)
>>>> +		return -EINVAL;
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static int bypass_slave_release(struct net_device *slave_netdev,
>>>> +				struct net_device *bypass_netdev,
>>>> +				struct bypass_ops *bypass_ops)
>>>> +{
>>>> +	struct net_device *backup_netdev, *active_netdev;
>>>> +	struct bypass_info *bi;
>>>> +
>>>> +	if (bypass_ops) {
>>>> +		if (!bypass_ops->slave_release)
>>>> +			return -EINVAL;
>>> I think it would be good to make the API to the driver more strict and
>>> have a separate set of ops for "active" and "backup" netdevices.
>>> That should stop people thinking about extending this to more slaves in
>>> the future.
>> We have checks in slave_pre_register() that allows only 1 'backup' and 1
>> 'active' slave.
> I'm very well aware of that. I just thought that explicit ops for the
> two slaves would make this more clear.
>
>
>>
>>>
>>>
>>>> +
>>>> +		return bypass_ops->slave_release(slave_netdev, bypass_netdev);
>>>> +	}
>>>> +
>>>> +	bi = netdev_priv(bypass_netdev);
>>>> +	active_netdev = rtnl_dereference(bi->active_netdev);
>>>> +	backup_netdev = rtnl_dereference(bi->backup_netdev);
>>>> +
>>>> +	if (slave_netdev == backup_netdev) {
>>>> +		RCU_INIT_POINTER(bi->backup_netdev, NULL);
>>>> +	} else {
>>>> +		RCU_INIT_POINTER(bi->active_netdev, NULL);
>>>> +		if (backup_netdev) {
>>>> +			bypass_netdev->min_mtu = backup_netdev->min_mtu;
>>>> +			bypass_netdev->max_mtu = backup_netdev->max_mtu;
>>>> +		}
>>>> +	}
>>>> +
>>>> +	dev_put(slave_netdev);
>>>> +
>>>> +	netdev_info(bypass_netdev, "bypass slave:%s released\n",
>>>> +		    slave_netdev->name);
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +int bypass_slave_unregister(struct net_device *slave_netdev)
>>>> +{
>>>> +	struct net_device *bypass_netdev;
>>>> +	struct bypass_ops *bypass_ops;
>>>> +	int ret;
>>>> +
>>>> +	if (!netif_is_bypass_slave(slave_netdev))
>>>> +		goto done;
>>>> +
>>>> +	ASSERT_RTNL();
>>>> +
>>>> +	bypass_netdev = bypass_master_get_bymac(slave_netdev->perm_addr,
>>>> +						&bypass_ops);
>>>> +	if (!bypass_netdev)
>>>> +		goto done;
>>>> +
>>>> +	ret = bypass_slave_pre_unregister(slave_netdev, bypass_netdev,
>>>> +					  bypass_ops);
>>>> +	if (ret != 0)
>>>> +		goto done;
>>>> +
>>>> +	netdev_rx_handler_unregister(slave_netdev);
>>>> +	netdev_upper_dev_unlink(slave_netdev, bypass_netdev);
>>>> +	slave_netdev->priv_flags &= ~IFF_BYPASS_SLAVE;
>>>> +
>>>> +	bypass_slave_release(slave_netdev, bypass_netdev, bypass_ops);
>>>> +
>>>> +	netdev_info(bypass_netdev, "bypass slave:%s unregistered\n",
>>>> +		    slave_netdev->name);
>>>> +
>>>> +done:
>>>> +	return NOTIFY_DONE;
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(bypass_slave_unregister);
>>>> +
>>>> +static bool bypass_xmit_ready(struct net_device *dev)
>>>> +{
>>>> +	return netif_running(dev) && netif_carrier_ok(dev);
>>>> +}
>>>> +
>>>> +static int bypass_slave_link_change(struct net_device *slave_netdev)
>>>> +{
>>>> +	struct net_device *bypass_netdev, *active_netdev, *backup_netdev;
>>>> +	struct bypass_ops *bypass_ops;
>>>> +	struct bypass_info *bi;
>>>> +
>>>> +	if (!netif_is_bypass_slave(slave_netdev))
>>>> +		goto done;
>>>> +
>>>> +	ASSERT_RTNL();
>>>> +
>>>> +	bypass_netdev = bypass_master_get_bymac(slave_netdev->perm_addr,
>>>> +						&bypass_ops);
>>>> +	if (!bypass_netdev)
>>>> +		goto done;
>>>> +
>>>> +	if (bypass_ops) {
>>>> +		if (!bypass_ops->slave_link_change)
>>>> +			goto done;
>>>> +
>>>> +		return bypass_ops->slave_link_change(slave_netdev,
>>>> +						     bypass_netdev);
>>>> +	}
>>>> +
>>>> +	if (!netif_running(bypass_netdev))
>>>> +		return 0;
>>>> +
>>>> +	bi = netdev_priv(bypass_netdev);
>>>> +
>>>> +	active_netdev = rtnl_dereference(bi->active_netdev);
>>>> +	backup_netdev = rtnl_dereference(bi->backup_netdev);
>>>> +
>>>> +	if (slave_netdev != active_netdev && slave_netdev != backup_netdev)
>>>> +		goto done;
>>> You don't need this check. "if (!netif_is_bypass_slave(slave_netdev))"
>>> above is enough.
>> I think we need this check to not allow events from a slave that is not
>> attached to this master but has the same MAC.
> Why do we need such events? Seems wrong to me.

We want to avoid events from a netdev that is mis-configured with the same MAC as
a bypass setup.

>   Consider:
>
> bp1      bp2
> a1 b1    a2 b2
>
>
> a1 and a2 have the same mac and bp1 and bp2 have the same mac.

We should not have 2 bypass configs with the same MAC.
I need to add a check in the bypass_master_register() to prevent this.

The above check is to avoid cases where we have
bp1(a1, b1) with mac1
and a2 is mis-configured with mac1, we want to avoid using a2 link events to update bp1.

> Now bypass_master_get_bymac() will return always bp1 or bp2 - depending on
> the order of creation.
> Let's say it will return bp1. Then when we have event for a2, the
> bypass_ops->slave_link_change is called with (a2, bp1). That is wrong.
>
>
> You cannot use bypass_master_get_bymac() here.
>
>
>
>>>
>>>> +
>>>> +	if ((active_netdev && bypass_xmit_ready(active_netdev)) ||
>>>> +	    (backup_netdev && bypass_xmit_ready(backup_netdev))) {
>>>> +		netif_carrier_on(bypass_netdev);
>>>> +		netif_tx_wake_all_queues(bypass_netdev);
>>>> +	} else {
>>>> +		netif_carrier_off(bypass_netdev);
>>>> +		netif_tx_stop_all_queues(bypass_netdev);
>>>> +	}
>>>> +
>>>> +done:
>>>> +	return NOTIFY_DONE;
>>>> +}
>>>> +
>>>> +static bool bypass_validate_event_dev(struct net_device *dev)
>>>> +{
>>>> +	/* Skip parent events */
>>>> +	if (netif_is_bypass_master(dev))
>>>> +		return false;
>>>> +
>>>> +	/* Avoid non-Ethernet type devices */
>>>> +	if (dev->type != ARPHRD_ETHER)
>>>> +		return false;
>>>> +
>>>> +	/* Avoid Vlan dev with same MAC registering as VF */
>>>> +	if (is_vlan_dev(dev))
>>>> +		return false;
>>>> +
>>>> +	/* Avoid Bonding master dev with same MAC registering as slave dev */
>>>> +	if ((dev->priv_flags & IFF_BONDING) && (dev->flags & IFF_MASTER))
>>> Yeah, this is certainly incorrect. One thing is, you should be using the
>>> helpers netif_is_bond_master().
>>> But what about the rest? macsec, macvlan, team, bridge, ovs and others?
>>>
>>> You need to do it not by blacklisting, but with whitelisting. You need
>>> to whitelist VF devices. My port flavours patchset might help with this.
>> May be i can use netdev_has_lower_dev() helper to make sure that the slave
> I don't see such function in the code.

It is netdev_has_any_lower_dev(). I need to export it.

>
>
>> device is not an upper dev.
>> Can you point to your port flavours patchset? Is it upstream?
> I sent rfc couple of weeks ago:
> [patch net-next RFC 00/12] devlink: introduce port flavours and common phys_port_name generation




---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

