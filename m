Return-Path: virtio-dev-return-3824-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 762075818EFF
	for <virtio-dev@lists.oasis-open.org>; Wed, 11 Apr 2018 12:14:06 -0700 (PDT)
References: <1523386790-12396-1-git-send-email-sridhar.samudrala@intel.com>
 <1523386790-12396-3-git-send-email-sridhar.samudrala@intel.com>
 <20180411155127.GQ2028@nanopsycho>
From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Message-ID: <6a8c1ff5-153a-e40a-91b3-48532b8d3a38@intel.com>
Date: Wed, 11 Apr 2018 12:13:52 -0700
MIME-Version: 1.0
In-Reply-To: <20180411155127.GQ2028@nanopsycho>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: [virtio-dev] Re: [RFC PATCH net-next v6 2/4] net: Introduce generic bypass module
To: Jiri Pirko <jiri@resnulli.us>
Cc: mst@redhat.com, stephen@networkplumber.org, davem@davemloft.net, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, kubakici@wp.pl, jasowang@redhat.com, loseweigh@gmail.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 4/11/2018 8:51 AM, Jiri Pirko wrote:
> Tue, Apr 10, 2018 at 08:59:48PM CEST, sridhar.samudrala@intel.com wrote:
>> This provides a generic interface for paravirtual drivers to listen
>> for netdev register/unregister/link change events from pci ethernet
>> devices with the same MAC and takeover their datapath. The notifier and
>> event handling code is based on the existing netvsc implementation.
>>
>> It exposes 2 sets of interfaces to the paravirtual drivers.
>> 1. existing netvsc driver that uses 2 netdev model. In this model, no
>> master netdev is created. The paravirtual driver registers each bypass
>> instance along with a set of ops to manage the slave events.
>>      bypass_master_register()
>>      bypass_master_unregister()
>> 2. new virtio_net based solution that uses 3 netdev model. In this model,
>> the bypass module provides interfaces to create/destroy additional master
>> netdev and all the slave events are managed internally.
>>       bypass_master_create()
>>       bypass_master_destroy()
>>
>> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
>> ---
>> include/linux/netdevice.h |  14 +
>> include/net/bypass.h      |  96 ++++++
>> net/Kconfig               |  18 +
>> net/core/Makefile         |   1 +
>> net/core/bypass.c         | 844 ++++++++++++++++++++++++++++++++++++++++++++++
>> 5 files changed, 973 insertions(+)
>> create mode 100644 include/net/bypass.h
>> create mode 100644 net/core/bypass.c
>>
>> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
>> index cf44503ea81a..587293728f70 100644
>> --- a/include/linux/netdevice.h
>> +++ b/include/linux/netdevice.h
>> @@ -1430,6 +1430,8 @@ enum netdev_priv_flags {
>> 	IFF_PHONY_HEADROOM		= 1<<24,
>> 	IFF_MACSEC			= 1<<25,
>> 	IFF_NO_RX_HANDLER		= 1<<26,
>> +	IFF_BYPASS			= 1 << 27,
>> +	IFF_BYPASS_SLAVE		= 1 << 28,
> I wonder, why you don't follow the existing coding style... Also, please
> add these to into the comment above.

To avoid checkpatch warnings. If it is OK to ignore these warnings, I can switch back
to the existing coding style to be consistent.

>
>
>> };
>>
>> #define IFF_802_1Q_VLAN			IFF_802_1Q_VLAN
>> @@ -1458,6 +1460,8 @@ enum netdev_priv_flags {
>> #define IFF_RXFH_CONFIGURED		IFF_RXFH_CONFIGURED
>> #define IFF_MACSEC			IFF_MACSEC
>> #define IFF_NO_RX_HANDLER		IFF_NO_RX_HANDLER
>> +#define IFF_BYPASS			IFF_BYPASS
>> +#define IFF_BYPASS_SLAVE		IFF_BYPASS_SLAVE
>>
>> /**
>>   *	struct net_device - The DEVICE structure.
>> @@ -4308,6 +4312,16 @@ static inline bool netif_is_rxfh_configured(const struct net_device *dev)
>> 	return dev->priv_flags & IFF_RXFH_CONFIGURED;
>> }
>>
>> +static inline bool netif_is_bypass_master(const struct net_device *dev)
>> +{
>> +	return dev->priv_flags & IFF_BYPASS;
>> +}
>> +
>> +static inline bool netif_is_bypass_slave(const struct net_device *dev)
>> +{
>> +	return dev->priv_flags & IFF_BYPASS_SLAVE;
>> +}
>> +
>> /* This device needs to keep skb dst for qdisc enqueue or ndo_start_xmit() */
>> static inline void netif_keep_dst(struct net_device *dev)
>> {
>> diff --git a/include/net/bypass.h b/include/net/bypass.h
>> new file mode 100644
>> index 000000000000..86b02cb894cf
>> --- /dev/null
>> +++ b/include/net/bypass.h
>> @@ -0,0 +1,96 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (c) 2018, Intel Corporation. */
>> +
>> +#ifndef _NET_BYPASS_H
>> +#define _NET_BYPASS_H
>> +
>> +#include <linux/netdevice.h>
>> +
>> +struct bypass_ops {
>> +	int (*slave_pre_register)(struct net_device *slave_netdev,
>> +				  struct net_device *bypass_netdev);
>> +	int (*slave_join)(struct net_device *slave_netdev,
>> +			  struct net_device *bypass_netdev);
>> +	int (*slave_pre_unregister)(struct net_device *slave_netdev,
>> +				    struct net_device *bypass_netdev);
>> +	int (*slave_release)(struct net_device *slave_netdev,
>> +			     struct net_device *bypass_netdev);
>> +	int (*slave_link_change)(struct net_device *slave_netdev,
>> +				 struct net_device *bypass_netdev);
>> +	rx_handler_result_t (*handle_frame)(struct sk_buff **pskb);
>> +};
>> +
>> +struct bypass_master {
>> +	struct list_head list;
>> +	struct net_device __rcu *bypass_netdev;
>> +	struct bypass_ops __rcu *ops;
>> +};
>> +
>> +/* bypass state */
>> +struct bypass_info {
>> +	/* passthru netdev with same MAC */
>> +	struct net_device __rcu *active_netdev;
> You still use "active"/"backup" names which is highly misleading as
> it has completely different meaning that in bond for example.
> I noted that in my previous review already. Please change it.

I guess the issue is with only the 'active'  name. 'backup' should be fine as it also
matches with the BACKUP feature bit we are adding to virtio_net.

With regards to alternate names for 'active', you suggested 'stolen', but i
am not too happy with it.
netvsc uses vf_netdev, are you OK with this? Or another option is 'passthru'



>
>
>> +
>> +	/* virtio_net netdev */
>> +	struct net_device __rcu *backup_netdev;
>> +
>> +	/* active netdev stats */
>> +	struct rtnl_link_stats64 active_stats;
>> +
>> +	/* backup netdev stats */
>> +	struct rtnl_link_stats64 backup_stats;
>> +
>> +	/* aggregated stats */
>> +	struct rtnl_link_stats64 bypass_stats;
>> +
>> +	/* spinlock while updating stats */
>> +	spinlock_t stats_lock;
>> +};
>> +
>> +#if IS_ENABLED(CONFIG_NET_BYPASS)
>> +
>> +int bypass_master_create(struct net_device *backup_netdev,
>> +			 struct bypass_master **pbypass_master);
>> +void bypass_master_destroy(struct bypass_master *bypass_master);
>> +
>> +int bypass_master_register(struct net_device *dev, struct bypass_ops *ops,
>> +			   struct bypass_master **pbypass_master);
>> +void bypass_master_unregister(struct bypass_master *bypass_master);
>> +
>> +int bypass_slave_unregister(struct net_device *slave_netdev);
>> +
>> +#else
>> +
>> +static inline
>> +int bypass_master_create(struct net_device *backup_netdev,
>> +			 struct bypass_master **pbypass_master);
>> +{
>> +	return 0;
>> +}
>> +
>> +static inline
>> +void bypass_master_destroy(struct bypass_master *bypass_master)
>> +{
>> +}
>> +
>> +static inline
>> +int bypass_master_register(struct net_device *dev, struct bypass_ops *ops,
>> +			   struct pbypass_master **pbypass_master);
>> +{
>> +	return 0;
>> +}
>> +
>> +static inline
>> +void bypass_master_unregister(struct bypass_master *bypass_master)
>> +{
>> +}
>> +
>> +static inline
>> +int bypass_slave_unregister(struct net_device *slave_netdev)
>> +{
>> +	return 0;
>> +}
>> +
>> +#endif
>> +
>> +#endif /* _NET_BYPASS_H */
>> diff --git a/net/Kconfig b/net/Kconfig
>> index 0428f12c25c2..994445f4a96a 100644
>> --- a/net/Kconfig
>> +++ b/net/Kconfig
>> @@ -423,6 +423,24 @@ config MAY_USE_DEVLINK
>> 	  on MAY_USE_DEVLINK to ensure they do not cause link errors when
>> 	  devlink is a loadable module and the driver using it is built-in.
>>
>> +config NET_BYPASS
>> +	tristate "Bypass interface"
>> +	---help---
>> +	  This provides a generic interface for paravirtual drivers to listen
>> +	  for netdev register/unregister/link change events from pci ethernet
>> +	  devices with the same MAC and takeover their datapath. This also
>> +	  enables live migration of a VM with direct attached VF by failing
>> +	  over to the paravirtual datapath when the VF is unplugged.
>> +
>> +config MAY_USE_BYPASS
>> +	tristate
>> +	default m if NET_BYPASS=m
>> +	default y if NET_BYPASS=y || NET_BYPASS=n
>> +	help
>> +	  Drivers using the bypass infrastructure should have a dependency
>> +	  on MAY_USE_BYPASS to ensure they do not cause link errors when
>> +	  bypass is a loadable module and the driver using it is built-in.
>> +
>> endif   # if NET
>>
>> # Used by archs to tell that they support BPF JIT compiler plus which flavour.
>> diff --git a/net/core/Makefile b/net/core/Makefile
>> index 6dbbba8c57ae..a9727ed1c8fc 100644
>> --- a/net/core/Makefile
>> +++ b/net/core/Makefile
>> @@ -30,3 +30,4 @@ obj-$(CONFIG_DST_CACHE) += dst_cache.o
>> obj-$(CONFIG_HWBM) += hwbm.o
>> obj-$(CONFIG_NET_DEVLINK) += devlink.o
>> obj-$(CONFIG_GRO_CELLS) += gro_cells.o
>> +obj-$(CONFIG_NET_BYPASS) += bypass.o
>> diff --git a/net/core/bypass.c b/net/core/bypass.c
>> new file mode 100644
>> index 000000000000..b5b9cb554c3f
>> --- /dev/null
>> +++ b/net/core/bypass.c
>> @@ -0,0 +1,844 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (c) 2018, Intel Corporation. */
>> +
>> +/* A common module to handle registrations and notifications for paravirtual
>> + * drivers to enable accelerated datapath and support VF live migration.
>> + *
>> + * The notifier and event handling code is based on netvsc driver.
>> + */
>> +
>> +#include <linux/netdevice.h>
>> +#include <linux/etherdevice.h>
>> +#include <linux/ethtool.h>
>> +#include <linux/module.h>
>> +#include <linux/slab.h>
>> +#include <linux/netdevice.h>
>> +#include <linux/netpoll.h>
>> +#include <linux/rtnetlink.h>
>> +#include <linux/if_vlan.h>
>> +#include <linux/pci.h>
>> +#include <net/sch_generic.h>
>> +#include <uapi/linux/if_arp.h>
>> +#include <net/bypass.h>
>> +
>> +static LIST_HEAD(bypass_master_list);
>> +static DEFINE_SPINLOCK(bypass_lock);
>> +
>> +static int bypass_slave_pre_register(struct net_device *slave_netdev,
>> +				     struct net_device *bypass_netdev,
>> +				     struct bypass_ops *bypass_ops)
>> +{
>> +	struct bypass_info *bi;
>> +	bool backup;
>> +
>> +	if (bypass_ops) {
>> +		if (!bypass_ops->slave_pre_register)
>> +			return -EINVAL;
>> +
>> +		return bypass_ops->slave_pre_register(slave_netdev,
>> +						      bypass_netdev);
>> +	}
>> +
>> +	bi = netdev_priv(bypass_netdev);
>> +	backup = (slave_netdev->dev.parent == bypass_netdev->dev.parent);
>> +	if (backup ? rtnl_dereference(bi->backup_netdev) :
>> +			rtnl_dereference(bi->active_netdev)) {
>> +		netdev_err(bypass_netdev, "%s attempting to register as slave dev when %s already present\n",
>> +			   slave_netdev->name, backup ? "backup" : "active");
>> +		return -EEXIST;
>> +	}
>> +
>> +	/* Avoid non pci devices as active netdev */
>> +	if (!backup && (!slave_netdev->dev.parent ||
>> +			!dev_is_pci(slave_netdev->dev.parent)))
>> +		return -EINVAL;
>> +
>> +	return 0;
>> +}
>> +
>> +static int bypass_slave_join(struct net_device *slave_netdev,
>> +			     struct net_device *bypass_netdev,
>> +			     struct bypass_ops *bypass_ops)
>> +{
>> +	struct bypass_info *bi;
>> +	bool backup;
>> +
>> +	if (bypass_ops) {
>> +		if (!bypass_ops->slave_join)
>> +			return -EINVAL;
>> +
>> +		return bypass_ops->slave_join(slave_netdev, bypass_netdev);
>> +	}
>> +
>> +	bi = netdev_priv(bypass_netdev);
>> +	backup = (slave_netdev->dev.parent == bypass_netdev->dev.parent);
>> +
>> +	dev_hold(slave_netdev);
>> +
>> +	if (backup) {
>> +		rcu_assign_pointer(bi->backup_netdev, slave_netdev);
>> +		dev_get_stats(bi->backup_netdev, &bi->backup_stats);
>> +	} else {
>> +		rcu_assign_pointer(bi->active_netdev, slave_netdev);
>> +		dev_get_stats(bi->active_netdev, &bi->active_stats);
>> +		bypass_netdev->min_mtu = slave_netdev->min_mtu;
>> +		bypass_netdev->max_mtu = slave_netdev->max_mtu;
>> +	}
>> +
>> +	netdev_info(bypass_netdev, "bypass slave:%s joined\n",
>> +		    slave_netdev->name);
>> +
>> +	return 0;
>> +}
>> +
>> +/* Called when slave dev is injecting data into network stack.
>> + * Change the associated network device from lower dev to virtio.
>> + * note: already called with rcu_read_lock
>> + */
>> +static rx_handler_result_t bypass_handle_frame(struct sk_buff **pskb)
>> +{
>> +	struct sk_buff *skb = *pskb;
>> +	struct net_device *ndev = rcu_dereference(skb->dev->rx_handler_data);
>> +
>> +	skb->dev = ndev;
>> +
>> +	return RX_HANDLER_ANOTHER;
>> +}
>> +
>> +static struct net_device *bypass_master_get_bymac(u8 *mac,
>> +						  struct bypass_ops **ops)
>> +{
>> +	struct bypass_master *bypass_master;
>> +	struct net_device *bypass_netdev;
>> +
>> +	spin_lock(&bypass_lock);
>> +	list_for_each_entry(bypass_master, &bypass_master_list, list) {
> As I wrote the last time, you don't need this list, spinlock.
> You can do just something like:
>          for_each_net(net) {
>                  for_each_netdev(net, dev) {
> 			if (netif_is_bypass_master(dev)) {

This function returns the upper netdev as well as the ops associated
with that netdev.
bypass_master_list is a list of 'struct bypass_master' that associates
'bypass_netdev' with 'bypass_ops' and gets added via bypass_master_register().
We need 'ops' only to support the 2 netdev model of netvsc. ops will be
NULL for 3-netdev model.


>
>
>
>
>> +		bypass_netdev = rcu_dereference(bypass_master->bypass_netdev);
>> +		if (ether_addr_equal(bypass_netdev->perm_addr, mac)) {
>> +			*ops = rcu_dereference(bypass_master->ops);
> I don't see how rcu_dereference is ok here.
> 1) I don't see rcu_read_lock taken
> 2) Looks like bypass_master->ops has the same value across the whole
>     existence.

We hold rtnl_lock(), i think i need to change this to rtnl_dereference.
Yes. ops doesn't change.

>
>
>> +			spin_unlock(&bypass_lock);
>> +			return bypass_netdev;
>> +		}
>> +	}
>> +	spin_unlock(&bypass_lock);
>> +	return NULL;
>> +}
>> +
>> +static int bypass_slave_register(struct net_device *slave_netdev)
>> +{
>> +	struct net_device *bypass_netdev;
>> +	struct bypass_ops *bypass_ops;
>> +	int ret, orig_mtu;
>> +
>> +	ASSERT_RTNL();
>> +
>> +	bypass_netdev = bypass_master_get_bymac(slave_netdev->perm_addr,
>> +						&bypass_ops);
> For master, could you use word "master" in the variables so it is clear?
> Also, "dev" is fine instead of "netdev".
> Something like "bpmaster_dev"

bypass_master is of  type struct bypass_master,  bypass_netdev is of type struct net_device.
I can change all _netdev suffixes to _dev to make the names shorter.


>
>
>> +	if (!bypass_netdev)
>> +		goto done;
>> +
>> +	ret = bypass_slave_pre_register(slave_netdev, bypass_netdev,
>> +					bypass_ops);
>> +	if (ret != 0)
> 	Just "if (ret)" will do. You have this on more places.

OK.


>
>
>> +		goto done;
>> +
>> +	ret = netdev_rx_handler_register(slave_netdev,
>> +					 bypass_ops ? bypass_ops->handle_frame :
>> +					 bypass_handle_frame, bypass_netdev);
>> +	if (ret != 0) {
>> +		netdev_err(slave_netdev, "can not register bypass rx handler (err = %d)\n",
>> +			   ret);
>> +		goto done;
>> +	}
>> +
>> +	ret = netdev_upper_dev_link(slave_netdev, bypass_netdev, NULL);
>> +	if (ret != 0) {
>> +		netdev_err(slave_netdev, "can not set master device %s (err = %d)\n",
>> +			   bypass_netdev->name, ret);
>> +		goto upper_link_failed;
>> +	}
>> +
>> +	slave_netdev->priv_flags |= IFF_BYPASS_SLAVE;
>> +
>> +	if (netif_running(bypass_netdev)) {
>> +		ret = dev_open(slave_netdev);
>> +		if (ret && (ret != -EBUSY)) {
>> +			netdev_err(bypass_netdev, "Opening slave %s failed ret:%d\n",
>> +				   slave_netdev->name, ret);
>> +			goto err_interface_up;
>> +		}
>> +	}
>> +
>> +	/* Align MTU of slave with master */
>> +	orig_mtu = slave_netdev->mtu;
>> +	ret = dev_set_mtu(slave_netdev, bypass_netdev->mtu);
>> +	if (ret != 0) {
>> +		netdev_err(bypass_netdev, "unable to change mtu of %s to %u register failed\n",
>> +			   slave_netdev->name, bypass_netdev->mtu);
>> +		goto err_set_mtu;
>> +	}
>> +
>> +	ret = bypass_slave_join(slave_netdev, bypass_netdev, bypass_ops);
>> +	if (ret != 0)
>> +		goto err_join;
>> +
>> +	call_netdevice_notifiers(NETDEV_JOIN, slave_netdev);
>> +
>> +	netdev_info(bypass_netdev, "bypass slave:%s registered\n",
>> +		    slave_netdev->name);
>> +
>> +	goto done;
>> +
>> +err_join:
>> +	dev_set_mtu(slave_netdev, orig_mtu);
>> +err_set_mtu:
>> +	dev_close(slave_netdev);
>> +err_interface_up:
>> +	netdev_upper_dev_unlink(slave_netdev, bypass_netdev);
>> +	slave_netdev->priv_flags &= ~IFF_BYPASS_SLAVE;
>> +upper_link_failed:
>> +	netdev_rx_handler_unregister(slave_netdev);
>> +done:
>> +	return NOTIFY_DONE;
>> +}
>> +
>> +static int bypass_slave_pre_unregister(struct net_device *slave_netdev,
>> +				       struct net_device *bypass_netdev,
>> +				       struct bypass_ops *bypass_ops)
>> +{
>> +	struct net_device *backup_netdev, *active_netdev;
>> +	struct bypass_info *bi;
>> +
>> +	if (bypass_ops) {
>> +		if (!bypass_ops->slave_pre_unregister)
>> +			return -EINVAL;
>> +
>> +		return bypass_ops->slave_pre_unregister(slave_netdev,
>> +							bypass_netdev);
>> +	}
>> +
>> +	bi = netdev_priv(bypass_netdev);
>> +	active_netdev = rtnl_dereference(bi->active_netdev);
>> +	backup_netdev = rtnl_dereference(bi->backup_netdev);
>> +
>> +	if (slave_netdev != active_netdev && slave_netdev != backup_netdev)
>> +		return -EINVAL;
>> +
>> +	return 0;
>> +}
>> +
>> +static int bypass_slave_release(struct net_device *slave_netdev,
>> +				struct net_device *bypass_netdev,
>> +				struct bypass_ops *bypass_ops)
>> +{
>> +	struct net_device *backup_netdev, *active_netdev;
>> +	struct bypass_info *bi;
>> +
>> +	if (bypass_ops) {
>> +		if (!bypass_ops->slave_release)
>> +			return -EINVAL;
> I think it would be good to make the API to the driver more strict and
> have a separate set of ops for "active" and "backup" netdevices.
> That should stop people thinking about extending this to more slaves in
> the future.

We have checks in slave_pre_register() that allows only 1 'backup' and 1
'active' slave.


>
>
>
>> +
>> +		return bypass_ops->slave_release(slave_netdev, bypass_netdev);
>> +	}
>> +
>> +	bi = netdev_priv(bypass_netdev);
>> +	active_netdev = rtnl_dereference(bi->active_netdev);
>> +	backup_netdev = rtnl_dereference(bi->backup_netdev);
>> +
>> +	if (slave_netdev == backup_netdev) {
>> +		RCU_INIT_POINTER(bi->backup_netdev, NULL);
>> +	} else {
>> +		RCU_INIT_POINTER(bi->active_netdev, NULL);
>> +		if (backup_netdev) {
>> +			bypass_netdev->min_mtu = backup_netdev->min_mtu;
>> +			bypass_netdev->max_mtu = backup_netdev->max_mtu;
>> +		}
>> +	}
>> +
>> +	dev_put(slave_netdev);
>> +
>> +	netdev_info(bypass_netdev, "bypass slave:%s released\n",
>> +		    slave_netdev->name);
>> +
>> +	return 0;
>> +}
>> +
>> +int bypass_slave_unregister(struct net_device *slave_netdev)
>> +{
>> +	struct net_device *bypass_netdev;
>> +	struct bypass_ops *bypass_ops;
>> +	int ret;
>> +
>> +	if (!netif_is_bypass_slave(slave_netdev))
>> +		goto done;
>> +
>> +	ASSERT_RTNL();
>> +
>> +	bypass_netdev = bypass_master_get_bymac(slave_netdev->perm_addr,
>> +						&bypass_ops);
>> +	if (!bypass_netdev)
>> +		goto done;
>> +
>> +	ret = bypass_slave_pre_unregister(slave_netdev, bypass_netdev,
>> +					  bypass_ops);
>> +	if (ret != 0)
>> +		goto done;
>> +
>> +	netdev_rx_handler_unregister(slave_netdev);
>> +	netdev_upper_dev_unlink(slave_netdev, bypass_netdev);
>> +	slave_netdev->priv_flags &= ~IFF_BYPASS_SLAVE;
>> +
>> +	bypass_slave_release(slave_netdev, bypass_netdev, bypass_ops);
>> +
>> +	netdev_info(bypass_netdev, "bypass slave:%s unregistered\n",
>> +		    slave_netdev->name);
>> +
>> +done:
>> +	return NOTIFY_DONE;
>> +}
>> +EXPORT_SYMBOL_GPL(bypass_slave_unregister);
>> +
>> +static bool bypass_xmit_ready(struct net_device *dev)
>> +{
>> +	return netif_running(dev) && netif_carrier_ok(dev);
>> +}
>> +
>> +static int bypass_slave_link_change(struct net_device *slave_netdev)
>> +{
>> +	struct net_device *bypass_netdev, *active_netdev, *backup_netdev;
>> +	struct bypass_ops *bypass_ops;
>> +	struct bypass_info *bi;
>> +
>> +	if (!netif_is_bypass_slave(slave_netdev))
>> +		goto done;
>> +
>> +	ASSERT_RTNL();
>> +
>> +	bypass_netdev = bypass_master_get_bymac(slave_netdev->perm_addr,
>> +						&bypass_ops);
>> +	if (!bypass_netdev)
>> +		goto done;
>> +
>> +	if (bypass_ops) {
>> +		if (!bypass_ops->slave_link_change)
>> +			goto done;
>> +
>> +		return bypass_ops->slave_link_change(slave_netdev,
>> +						     bypass_netdev);
>> +	}
>> +
>> +	if (!netif_running(bypass_netdev))
>> +		return 0;
>> +
>> +	bi = netdev_priv(bypass_netdev);
>> +
>> +	active_netdev = rtnl_dereference(bi->active_netdev);
>> +	backup_netdev = rtnl_dereference(bi->backup_netdev);
>> +
>> +	if (slave_netdev != active_netdev && slave_netdev != backup_netdev)
>> +		goto done;
> You don't need this check. "if (!netif_is_bypass_slave(slave_netdev))"
> above is enough.

I think we need this check to not allow events from a slave that is not
attached to this master but has the same MAC.

>
>
>> +
>> +	if ((active_netdev && bypass_xmit_ready(active_netdev)) ||
>> +	    (backup_netdev && bypass_xmit_ready(backup_netdev))) {
>> +		netif_carrier_on(bypass_netdev);
>> +		netif_tx_wake_all_queues(bypass_netdev);
>> +	} else {
>> +		netif_carrier_off(bypass_netdev);
>> +		netif_tx_stop_all_queues(bypass_netdev);
>> +	}
>> +
>> +done:
>> +	return NOTIFY_DONE;
>> +}
>> +
>> +static bool bypass_validate_event_dev(struct net_device *dev)
>> +{
>> +	/* Skip parent events */
>> +	if (netif_is_bypass_master(dev))
>> +		return false;
>> +
>> +	/* Avoid non-Ethernet type devices */
>> +	if (dev->type != ARPHRD_ETHER)
>> +		return false;
>> +
>> +	/* Avoid Vlan dev with same MAC registering as VF */
>> +	if (is_vlan_dev(dev))
>> +		return false;
>> +
>> +	/* Avoid Bonding master dev with same MAC registering as slave dev */
>> +	if ((dev->priv_flags & IFF_BONDING) && (dev->flags & IFF_MASTER))
> Yeah, this is certainly incorrect. One thing is, you should be using the
> helpers netif_is_bond_master().
> But what about the rest? macsec, macvlan, team, bridge, ovs and others?
>
> You need to do it not by blacklisting, but with whitelisting. You need
> to whitelist VF devices. My port flavours patchset might help with this.

May be i can use netdev_has_lower_dev() helper to make sure that the slave
device is not an upper dev.
Can you point to your port flavours patchset? Is it upstream?

>
>
>> +		return false;
>> +
>> +	return true;
>> +}
>> +
>> +static int
>> +bypass_event(struct notifier_block *this, unsigned long event, void *ptr)
>> +{
>> +	struct net_device *event_dev = netdev_notifier_info_to_dev(ptr);
>> +
>> +	if (!bypass_validate_event_dev(event_dev))
>> +		return NOTIFY_DONE;
>> +
>> +	switch (event) {
>> +	case NETDEV_REGISTER:
>> +		return bypass_slave_register(event_dev);
>> +	case NETDEV_UNREGISTER:
>> +		return bypass_slave_unregister(event_dev);
>> +	case NETDEV_UP:
>> +	case NETDEV_DOWN:
>> +	case NETDEV_CHANGE:
>> +		return bypass_slave_link_change(event_dev);
>> +	default:
>> +		return NOTIFY_DONE;
>> +	}
>> +}
>> +
>> +static struct notifier_block bypass_notifier = {
>> +	.notifier_call = bypass_event,
>> +};
>> +
>> +int bypass_open(struct net_device *dev)
>> +{
>> +	struct bypass_info *bi = netdev_priv(dev);
>> +	struct net_device *active_netdev, *backup_netdev;
>> +	int err;
>> +
>> +	netif_carrier_off(dev);
>> +	netif_tx_wake_all_queues(dev);
>> +
>> +	active_netdev = rtnl_dereference(bi->active_netdev);
>> +	if (active_netdev) {
>> +		err = dev_open(active_netdev);
>> +		if (err)
>> +			goto err_active_open;
>> +	}
>> +
>> +	backup_netdev = rtnl_dereference(bi->backup_netdev);
>> +	if (backup_netdev) {
>> +		err = dev_open(backup_netdev);
>> +		if (err)
>> +			goto err_backup_open;
>> +	}
>> +
>> +	return 0;
>> +
>> +err_backup_open:
>> +	dev_close(active_netdev);
>> +err_active_open:
>> +	netif_tx_disable(dev);
>> +	return err;
>> +}
>> +EXPORT_SYMBOL_GPL(bypass_open);
>> +
>> +int bypass_close(struct net_device *dev)
>> +{
>> +	struct bypass_info *vi = netdev_priv(dev);
> This should be probably "bi"

Yes.


>
>
>> +	struct net_device *slave_netdev;
>> +
>> +	netif_tx_disable(dev);
>> +
>> +	slave_netdev = rtnl_dereference(vi->active_netdev);
>> +	if (slave_netdev)
>> +		dev_close(slave_netdev);
>> +
>> +	slave_netdev = rtnl_dereference(vi->backup_netdev);
>> +	if (slave_netdev)
>> +		dev_close(slave_netdev);
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(bypass_close);
>> +
>> +static netdev_tx_t bypass_drop_xmit(struct sk_buff *skb, struct net_device *dev)
>> +{
>> +	atomic_long_inc(&dev->tx_dropped);
>> +	dev_kfree_skb_any(skb);
>> +	return NETDEV_TX_OK;
>> +}
>> +
>> +netdev_tx_t bypass_start_xmit(struct sk_buff *skb, struct net_device *dev)
>> +{
>> +	struct bypass_info *bi = netdev_priv(dev);
> If you rename the other variable to "bpmaster_dev", it would be nice to
> rename this to bpinfo or something more descriptive. "bi" is too short
> to know what that is right away.

Will rename bypass_netdev to bypass_dev. bypass indicates that it is
an upper master dev.


>
>
>> +	struct net_device *xmit_dev;
> Don't mix "dev" and "netdev" in one .c file. Just use "dev" for all.

OK.


>
>
>
>> +
>> +	/* Try xmit via active netdev followed by backup netdev */
>> +	xmit_dev = rcu_dereference_bh(bi->active_netdev);
>> +	if (!xmit_dev || !bypass_xmit_ready(xmit_dev)) {
>> +		xmit_dev = rcu_dereference_bh(bi->backup_netdev);
>> +		if (!xmit_dev || !bypass_xmit_ready(xmit_dev))
>> +			return bypass_drop_xmit(skb, dev);
>> +	}
>> +
>> +	skb->dev = xmit_dev;
>> +	skb->queue_mapping = qdisc_skb_cb(skb)->slave_dev_queue_mapping;
>> +
>> +	return dev_queue_xmit(skb);
>> +}
>> +EXPORT_SYMBOL_GPL(bypass_start_xmit);
>> +
>> +u16 bypass_select_queue(struct net_device *dev, struct sk_buff *skb,
>> +			void *accel_priv, select_queue_fallback_t fallback)
>> +{
>> +	/* This helper function exists to help dev_pick_tx get the correct
>> +	 * destination queue.  Using a helper function skips a call to
>> +	 * skb_tx_hash and will put the skbs in the queue we expect on their
>> +	 * way down to the bonding driver.
>> +	 */
>> +	u16 txq = skb_rx_queue_recorded(skb) ? skb_get_rx_queue(skb) : 0;
>> +
>> +	/* Save the original txq to restore before passing to the driver */
>> +	qdisc_skb_cb(skb)->slave_dev_queue_mapping = skb->queue_mapping;
>> +
>> +	if (unlikely(txq >= dev->real_num_tx_queues)) {
>> +		do {
>> +			txq -= dev->real_num_tx_queues;
>> +		} while (txq >= dev->real_num_tx_queues);
>> +	}
>> +
>> +	return txq;
>> +}
>> +EXPORT_SYMBOL_GPL(bypass_select_queue);
>> +
>> +/* fold stats, assuming all rtnl_link_stats64 fields are u64, but
>> + * that some drivers can provide 32bit values only.
>> + */
>> +static void bypass_fold_stats(struct rtnl_link_stats64 *_res,
>> +			      const struct rtnl_link_stats64 *_new,
>> +			      const struct rtnl_link_stats64 *_old)
>> +{
>> +	const u64 *new = (const u64 *)_new;
>> +	const u64 *old = (const u64 *)_old;
>> +	u64 *res = (u64 *)_res;
>> +	int i;
>> +
>> +	for (i = 0; i < sizeof(*_res) / sizeof(u64); i++) {
>> +		u64 nv = new[i];
>> +		u64 ov = old[i];
>> +		s64 delta = nv - ov;
>> +
>> +		/* detects if this particular field is 32bit only */
>> +		if (((nv | ov) >> 32) == 0)
>> +			delta = (s64)(s32)((u32)nv - (u32)ov);
>> +
>> +		/* filter anomalies, some drivers reset their stats
>> +		 * at down/up events.
>> +		 */
>> +		if (delta > 0)
>> +			res[i] += delta;
>> +	}
>> +}
>> +
>> +void bypass_get_stats(struct net_device *dev, struct rtnl_link_stats64 *stats)
>> +{
>> +	struct bypass_info *bi = netdev_priv(dev);
> You can WARN_ON and return in case the dev is not bypass master, just
> to catch buggy drivers. Same with other helpers.

I can make this static and not export this helper as well as all
bypass_netdev ops.

>
>
>> +	const struct rtnl_link_stats64 *new;
>> +	struct rtnl_link_stats64 temp;
>> +	struct net_device *slave_netdev;
>> +
>> +	spin_lock(&bi->stats_lock);
>> +	memcpy(stats, &bi->bypass_stats, sizeof(*stats));
>> +
>> +	rcu_read_lock();
>> +
>> +	slave_netdev = rcu_dereference(bi->active_netdev);
>> +	if (slave_netdev) {
>> +		new = dev_get_stats(slave_netdev, &temp);
>> +		bypass_fold_stats(stats, new, &bi->active_stats);
>> +		memcpy(&bi->active_stats, new, sizeof(*new));
>> +	}
>> +
>> +	slave_netdev = rcu_dereference(bi->backup_netdev);
>> +	if (slave_netdev) {
>> +		new = dev_get_stats(slave_netdev, &temp);
>> +		bypass_fold_stats(stats, new, &bi->backup_stats);
>> +		memcpy(&bi->backup_stats, new, sizeof(*new));
>> +	}
>> +
>> +	rcu_read_unlock();
>> +
>> +	memcpy(&bi->bypass_stats, stats, sizeof(*stats));
>> +	spin_unlock(&bi->stats_lock);
>> +}
>> +EXPORT_SYMBOL_GPL(bypass_get_stats);
>> +
>> +int bypass_change_mtu(struct net_device *dev, int new_mtu)
>> +{
>> +	struct bypass_info *bi = netdev_priv(dev);
>> +	struct net_device *active_netdev, *backup_netdev;
>> +	int ret = 0;
> Pointless initialization.
>
>
>> +
>> +	active_netdev = rcu_dereference(bi->active_netdev);
>> +	if (active_netdev) {
>> +		ret = dev_set_mtu(active_netdev, new_mtu);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	backup_netdev = rcu_dereference(bi->backup_netdev);
>> +	if (backup_netdev) {
>> +		ret = dev_set_mtu(backup_netdev, new_mtu);
>> +		if (ret) {
>> +			dev_set_mtu(active_netdev, dev->mtu);
>> +			return ret;
>> +		}
>> +	}
>> +
>> +	dev->mtu = new_mtu;
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(bypass_change_mtu);
>> +
>> +void bypass_set_rx_mode(struct net_device *dev)
>> +{
>> +	struct bypass_info *bi = netdev_priv(dev);
>> +	struct net_device *slave_netdev;
>> +
>> +	rcu_read_lock();
>> +
>> +	slave_netdev = rcu_dereference(bi->active_netdev);
>> +	if (slave_netdev) {
>> +		dev_uc_sync_multiple(slave_netdev, dev);
>> +		dev_mc_sync_multiple(slave_netdev, dev);
>> +	}
>> +
>> +	slave_netdev = rcu_dereference(bi->backup_netdev);
>> +	if (slave_netdev) {
>> +		dev_uc_sync_multiple(slave_netdev, dev);
>> +		dev_mc_sync_multiple(slave_netdev, dev);
>> +	}
>> +
>> +	rcu_read_unlock();
>> +}
>> +EXPORT_SYMBOL_GPL(bypass_set_rx_mode);
>> +
>> +static const struct net_device_ops bypass_netdev_ops = {
>> +	.ndo_open		= bypass_open,
>> +	.ndo_stop		= bypass_close,
>> +	.ndo_start_xmit		= bypass_start_xmit,
>> +	.ndo_select_queue	= bypass_select_queue,
>> +	.ndo_get_stats64	= bypass_get_stats,
>> +	.ndo_change_mtu		= bypass_change_mtu,
>> +	.ndo_set_rx_mode	= bypass_set_rx_mode,
>> +	.ndo_validate_addr	= eth_validate_addr,
>> +	.ndo_features_check	= passthru_features_check,
>> +};
>> +
>> +#define BYPASS_DRV_NAME "bypass"
>> +#define BYPASS_DRV_VERSION "0.1"
>> +
>> +static void bypass_ethtool_get_drvinfo(struct net_device *dev,
>> +				       struct ethtool_drvinfo *drvinfo)
>> +{
>> +	strlcpy(drvinfo->driver, BYPASS_DRV_NAME, sizeof(drvinfo->driver));
>> +	strlcpy(drvinfo->version, BYPASS_DRV_VERSION, sizeof(drvinfo->version));
>> +}
>> +
>> +int bypass_ethtool_get_link_ksettings(struct net_device *dev,
>> +				      struct ethtool_link_ksettings *cmd)
>> +{
>> +	struct bypass_info *bi = netdev_priv(dev);
>> +	struct net_device *slave_netdev;
>> +
>> +	slave_netdev = rtnl_dereference(bi->active_netdev);
>> +	if (!slave_netdev || !bypass_xmit_ready(slave_netdev)) {
>> +		slave_netdev = rtnl_dereference(bi->backup_netdev);
>> +		if (!slave_netdev || !bypass_xmit_ready(slave_netdev)) {
>> +			cmd->base.duplex = DUPLEX_UNKNOWN;
>> +			cmd->base.port = PORT_OTHER;
>> +			cmd->base.speed = SPEED_UNKNOWN;
>> +
>> +			return 0;
>> +		}
>> +	}
>> +
>> +	return __ethtool_get_link_ksettings(slave_netdev, cmd);
>> +}
>> +EXPORT_SYMBOL_GPL(bypass_ethtool_get_link_ksettings);
>> +
>> +static const struct ethtool_ops bypass_ethtool_ops = {
>> +	.get_drvinfo            = bypass_ethtool_get_drvinfo,
>> +	.get_link               = ethtool_op_get_link,
>> +	.get_link_ksettings     = bypass_ethtool_get_link_ksettings,
>> +};
>> +
>> +static void bypass_register_existing_slave(struct net_device *bypass_netdev)
>> +{
>> +	struct net *net = dev_net(bypass_netdev);
>> +	struct net_device *dev;
>> +
>> +	rtnl_lock();
>> +	for_each_netdev(net, dev) {
>> +		if (dev == bypass_netdev)
>> +			continue;
>> +		if (!bypass_validate_event_dev(dev))
>> +			continue;
>> +		if (ether_addr_equal(bypass_netdev->perm_addr, dev->perm_addr))
>> +			bypass_slave_register(dev);
>> +	}
>> +	rtnl_unlock();
>> +}
>> +
>> +int bypass_master_register(struct net_device *dev, struct bypass_ops *ops,
>> +			   struct bypass_master **pbypass_master)
>> +{
>> +	struct bypass_master *bypass_master;
>> +
>> +	bypass_master = kzalloc(sizeof(*bypass_master), GFP_KERNEL);
>> +	if (!bypass_master)
>> +		return -ENOMEM;
>> +
>> +	rcu_assign_pointer(bypass_master->ops, ops);
>> +	dev_hold(dev);
>> +	dev->priv_flags |= IFF_BYPASS;
>> +	rcu_assign_pointer(bypass_master->bypass_netdev, dev);
>> +
>> +	spin_lock(&bypass_lock);
>> +	list_add_tail(&bypass_master->list, &bypass_master_list);
>> +	spin_unlock(&bypass_lock);
>> +
>> +	bypass_register_existing_slave(dev);
>> +
>> +	*pbypass_master = bypass_master;
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(bypass_master_register);
>> +
>> +void bypass_master_unregister(struct bypass_master *bypass_master)
>> +{
>> +	struct net_device *bypass_netdev;
>> +
>> +	bypass_netdev = rcu_dereference(bypass_master->bypass_netdev);
>> +
>> +	bypass_netdev->priv_flags &= ~IFF_BYPASS;
>> +	dev_put(bypass_netdev);
>> +
>> +	spin_lock(&bypass_lock);
>> +	list_del(&bypass_master->list);
>> +	spin_unlock(&bypass_lock);
>> +
>> +	kfree(bypass_master);
>> +}
>> +EXPORT_SYMBOL_GPL(bypass_master_unregister);
>> +
>> +int bypass_master_create(struct net_device *backup_netdev,
>> +			 struct bypass_master **pbypass_master)
>> +{
>> +	struct device *dev = backup_netdev->dev.parent;
>> +	struct net_device *bypass_netdev;
>> +	int err;
>> +
>> +	/* Alloc at least 2 queues, for now we are going with 16 assuming
>> +	 * that most devices being bonded won't have too many queues.
>> +	 */
>> +	bypass_netdev = alloc_etherdev_mq(sizeof(struct bypass_info), 16);
>> +	if (!bypass_netdev) {
>> +		dev_err(dev, "Unable to allocate bypass_netdev!\n");
>> +		return -ENOMEM;
>> +	}
>> +
>> +	dev_net_set(bypass_netdev, dev_net(backup_netdev));
>> +	SET_NETDEV_DEV(bypass_netdev, dev);
>> +
>> +	bypass_netdev->netdev_ops = &bypass_netdev_ops;
>> +	bypass_netdev->ethtool_ops = &bypass_ethtool_ops;
>> +
>> +	/* Initialize the device options */
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
>> +	memcpy(bypass_netdev->dev_addr, backup_netdev->dev_addr,
>> +	       bypass_netdev->addr_len);
>> +
>> +	bypass_netdev->min_mtu = backup_netdev->min_mtu;
>> +	bypass_netdev->max_mtu = backup_netdev->max_mtu;
>> +
>> +	err = register_netdev(bypass_netdev);
>> +	if (err < 0) {
>> +		dev_err(dev, "Unable to register bypass_netdev!\n");
>> +		goto err_register_netdev;
>> +	}
>> +
>> +	netif_carrier_off(bypass_netdev);
>> +
>> +	err = bypass_master_register(bypass_netdev, NULL, pbypass_master);
>> +	if (err < 0)
> just "if (err)" would do.

OK

>
>
>> +		goto err_bypass;
>> +
>> +	return 0;
>> +
>> +err_bypass:
>> +	unregister_netdev(bypass_netdev);
>> +err_register_netdev:
>> +	free_netdev(bypass_netdev);
>> +
>> +	return err;
>> +}
>> +EXPORT_SYMBOL_GPL(bypass_master_create);
>> +
>> +void bypass_master_destroy(struct bypass_master *bypass_master)
>> +{
>> +	struct net_device *bypass_netdev;
>> +	struct net_device *slave_netdev;
>> +	struct bypass_info *bi;
>> +
>> +	if (!bypass_master)
>> +		return;
>> +
>> +	bypass_netdev = rcu_dereference(bypass_master->bypass_netdev);
>> +	bi = netdev_priv(bypass_netdev);
>> +
>> +	netif_device_detach(bypass_netdev);
>> +
>> +	rtnl_lock();
>> +
>> +	slave_netdev = rtnl_dereference(bi->active_netdev);
>> +	if (slave_netdev)
>> +		bypass_slave_unregister(slave_netdev);
>> +
>> +	slave_netdev = rtnl_dereference(bi->backup_netdev);
>> +	if (slave_netdev)
>> +		bypass_slave_unregister(slave_netdev);
>> +
>> +	bypass_master_unregister(bypass_master);
>> +
>> +	unregister_netdevice(bypass_netdev);
>> +
>> +	rtnl_unlock();
>> +
>> +	free_netdev(bypass_netdev);
>> +}
>> +EXPORT_SYMBOL_GPL(bypass_master_destroy);
>> +
>> +static __init int
>> +bypass_init(void)
>> +{
>> +	register_netdevice_notifier(&bypass_notifier);
>> +
>> +	return 0;
>> +}
>> +module_init(bypass_init);
>> +
>> +static __exit
>> +void bypass_exit(void)
>> +{
>> +	unregister_netdevice_notifier(&bypass_notifier);
>> +}
>> +module_exit(bypass_exit);
>> +
>> +MODULE_DESCRIPTION("Bypass infrastructure/interface for Paravirtual drivers");
>> +MODULE_LICENSE("GPL v2");
>> -- 
>> 2.14.3
>>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

