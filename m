Return-Path: virtio-dev-return-4103-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id F2A3258191B0
	for <virtio-dev@lists.oasis-open.org>; Mon, 21 May 2018 19:06:24 -0700 (PDT)
From: Sridhar Samudrala <sridhar.samudrala@intel.com>
Date: Mon, 21 May 2018 19:06:17 -0700
Message-Id: <1526954781-35359-2-git-send-email-sridhar.samudrala@intel.com>
In-Reply-To: <1526954781-35359-1-git-send-email-sridhar.samudrala@intel.com>
References: <1526954781-35359-1-git-send-email-sridhar.samudrala@intel.com>
Subject: [virtio-dev] [PATCH net-next v11 1/5] net: Introduce generic failover module
To: mst@redhat.com, stephen@networkplumber.org, davem@davemloft.net, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, kubakici@wp.pl, sridhar.samudrala@intel.com, jasowang@redhat.com, loseweigh@gmail.com, jiri@resnulli.us, aaron.f.brown@intel.com, anjali.singhai@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

The failover module provides a generic interface for paravirtual drivers
to register a netdev and a set of ops with a failover instance. The ops
are used as event handlers that get called to handle netdev register/
unregister/link change/name change events on slave pci ethernet devices
with the same mac address as the failover netdev.

This enables paravirtual drivers to use a VF as an accelerated low latency
datapath. It also allows migration of VMs with direct attached VFs by
failing over to the paravirtual datapath when the VF is unplugged.

Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
---
 Documentation/networking/failover.rst |  18 +++
 MAINTAINERS                           |   8 +
 include/linux/netdevice.h             |  16 ++
 include/net/failover.h                |  31 ++++
 net/Kconfig                           |  13 ++
 net/core/Makefile                     |   1 +
 net/core/failover.c                   | 273 ++++++++++++++++++++++++++++++++++
 7 files changed, 360 insertions(+)
 create mode 100644 Documentation/networking/failover.rst
 create mode 100644 include/net/failover.h
 create mode 100644 net/core/failover.c

diff --git a/Documentation/networking/failover.rst b/Documentation/networking/failover.rst
new file mode 100644
index 000000000000..f0c8483cdbf5
--- /dev/null
+++ b/Documentation/networking/failover.rst
@@ -0,0 +1,18 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+========
+FAILOVER
+========
+
+Overview
+========
+
+The failover module provides a generic interface for paravirtual drivers
+to register a netdev and a set of ops with a failover instance. The ops
+are used as event handlers that get called to handle netdev register/
+unregister/link change/name change events on slave pci ethernet devices
+with the same mac address as the failover netdev.
+
+This enables paravirtual drivers to use a VF as an accelerated low latency
+datapath. It also allows live migration of VMs with direct attached VFs by
+failing over to the paravirtual datapath when the VF is unplugged.
diff --git a/MAINTAINERS b/MAINTAINERS
index 658880464b9d..aed9575ddc53 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5413,6 +5413,14 @@ S:	Maintained
 F:	Documentation/hwmon/f71805f
 F:	drivers/hwmon/f71805f.c
 
+FAILOVER MODULE
+M:	Sridhar Samudrala <sridhar.samudrala@intel.com>
+L:	netdev@vger.kernel.org
+S:	Supported
+F:	net/core/failover.c
+F:	include/net/failover.h
+F:	Documentation/networking/failover.rst
+
 FANOTIFY
 M:	Jan Kara <jack@suse.cz>
 R:	Amir Goldstein <amir73il@gmail.com>
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 03ed492c4e14..0f4ba52b641d 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1421,6 +1421,8 @@ struct net_device_ops {
  *	entity (i.e. the master device for bridged veth)
  * @IFF_MACSEC: device is a MACsec device
  * @IFF_NO_RX_HANDLER: device doesn't support the rx_handler hook
+ * @IFF_FAILOVER: device is a failover master device
+ * @IFF_FAILOVER_SLAVE: device is lower dev of a failover master device
  */
 enum netdev_priv_flags {
 	IFF_802_1Q_VLAN			= 1<<0,
@@ -1450,6 +1452,8 @@ enum netdev_priv_flags {
 	IFF_PHONY_HEADROOM		= 1<<24,
 	IFF_MACSEC			= 1<<25,
 	IFF_NO_RX_HANDLER		= 1<<26,
+	IFF_FAILOVER			= 1<<27,
+	IFF_FAILOVER_SLAVE		= 1<<28,
 };
 
 #define IFF_802_1Q_VLAN			IFF_802_1Q_VLAN
@@ -1478,6 +1482,8 @@ enum netdev_priv_flags {
 #define IFF_RXFH_CONFIGURED		IFF_RXFH_CONFIGURED
 #define IFF_MACSEC			IFF_MACSEC
 #define IFF_NO_RX_HANDLER		IFF_NO_RX_HANDLER
+#define IFF_FAILOVER			IFF_FAILOVER
+#define IFF_FAILOVER_SLAVE		IFF_FAILOVER_SLAVE
 
 /**
  *	struct net_device - The DEVICE structure.
@@ -4321,6 +4327,16 @@ static inline bool netif_is_rxfh_configured(const struct net_device *dev)
 	return dev->priv_flags & IFF_RXFH_CONFIGURED;
 }
 
+static inline bool netif_is_failover(const struct net_device *dev)
+{
+	return dev->priv_flags & IFF_FAILOVER;
+}
+
+static inline bool netif_is_failover_slave(const struct net_device *dev)
+{
+	return dev->priv_flags & IFF_FAILOVER_SLAVE;
+}
+
 /* This device needs to keep skb dst for qdisc enqueue or ndo_start_xmit() */
 static inline void netif_keep_dst(struct net_device *dev)
 {
diff --git a/include/net/failover.h b/include/net/failover.h
new file mode 100644
index 000000000000..fea9d0b978c8
--- /dev/null
+++ b/include/net/failover.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2018, Intel Corporation. */
+
+#ifndef _FAILOVER_H
+#define _FAILOVER_H
+
+#include <linux/netdevice.h>
+
+struct failover_ops {
+	int (*slave_register)(struct net_device *slave_dev,
+			      struct net_device *failover_dev);
+	int (*slave_unregister)(struct net_device *slave_dev,
+				struct net_device *failover_dev);
+	int (*slave_link_change)(struct net_device *slave_dev,
+				 struct net_device *failover_dev);
+	int (*slave_name_change)(struct net_device *slave_dev,
+				 struct net_device *failover_dev);
+};
+
+struct failover {
+	struct list_head list;
+	struct net_device __rcu *failover_dev;
+	struct failover_ops __rcu *ops;
+};
+
+struct failover *failover_register(struct net_device *dev,
+				   struct failover_ops *ops);
+void failover_unregister(struct failover *failover);
+int failover_slave_unregister(struct net_device *slave_dev);
+
+#endif /* _FAILOVER_H */
diff --git a/net/Kconfig b/net/Kconfig
index df8d45ef47d8..d581c4f0f1c4 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -430,6 +430,19 @@ config MAY_USE_DEVLINK
 config PAGE_POOL
        bool
 
+config FAILOVER
+	tristate "Generic failover module"
+	help
+	  The failover module provides a generic interface for paravirtual
+	  drivers to register a netdev and a set of ops with a failover
+	  instance. The ops are used as event handlers that get called to
+	  handle netdev register/unregister/link change/name change events
+	  on slave pci ethernet devices with the same mac address as the
+	  failover netdev. This enables paravirtual drivers to use a
+	  VF as an accelerated low latency datapath. It also allows live
+	  migration of VMs with direct attached VFs by failing over to the
+	  paravirtual datapath when the VF is unplugged.
+
 endif   # if NET
 
 # Used by archs to tell that they support BPF JIT compiler plus which flavour.
diff --git a/net/core/Makefile b/net/core/Makefile
index 7080417f8bc8..80175e6a2eb8 100644
--- a/net/core/Makefile
+++ b/net/core/Makefile
@@ -31,3 +31,4 @@ obj-$(CONFIG_DST_CACHE) += dst_cache.o
 obj-$(CONFIG_HWBM) += hwbm.o
 obj-$(CONFIG_NET_DEVLINK) += devlink.o
 obj-$(CONFIG_GRO_CELLS) += gro_cells.o
+obj-$(CONFIG_FAILOVER) += failover.o
diff --git a/net/core/failover.c b/net/core/failover.c
new file mode 100644
index 000000000000..48ee713a1ef4
--- /dev/null
+++ b/net/core/failover.c
@@ -0,0 +1,273 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2018, Intel Corporation. */
+
+/* A common module to handle registrations and notifications for paravirtual
+ * drivers to enable accelerated datapath and support VF live migration.
+ *
+ * The notifier and event handling code is based on netvsc driver.
+ */
+
+#include <linux/module.h>
+#include <linux/etherdevice.h>
+#include <uapi/linux/if_arp.h>
+#include <linux/rtnetlink.h>
+#include <net/failover.h>
+
+static LIST_HEAD(failover_list);
+static DEFINE_SPINLOCK(failover_lock);
+
+static struct net_device *failover_get_bymac(u8 *mac, struct failover_ops **ops)
+{
+	struct net_device *failover_dev;
+	struct failover *failover;
+
+	spin_lock(&failover_lock);
+	list_for_each_entry(failover, &failover_list, list) {
+		failover_dev = rtnl_dereference(failover->failover_dev);
+		if (ether_addr_equal(failover_dev->perm_addr, mac)) {
+			*ops = rtnl_dereference(failover->ops);
+			spin_unlock(&failover_lock);
+			return failover_dev;
+		}
+	}
+	spin_unlock(&failover_lock);
+	return NULL;
+}
+
+/**
+ * failover_slave_register - Register a slave netdev
+ *
+ * @slave_dev: slave netdev that is being registered
+ *
+ * Registers a slave device to a failover instance. Only ethernet devices
+ * are supported.
+ */
+static int failover_slave_register(struct net_device *slave_dev)
+{
+	struct net_device *failover_dev;
+	struct failover_ops *fops;
+
+	if (slave_dev->type != ARPHRD_ETHER)
+		goto done;
+
+	ASSERT_RTNL();
+
+	failover_dev = failover_get_bymac(slave_dev->perm_addr, &fops);
+	if (!failover_dev)
+		goto done;
+
+	if (fops && fops->slave_register)
+		return fops->slave_register(slave_dev, failover_dev);
+
+done:
+	return NOTIFY_DONE;
+}
+
+/**
+ * failover_slave_unregister - Unregister a slave netdev
+ *
+ * @slave_dev: slave netdev that is being unregistered
+ *
+ * Unregisters a slave device from a failover instance.
+ */
+int failover_slave_unregister(struct net_device *slave_dev)
+{
+	struct net_device *failover_dev;
+	struct failover_ops *fops;
+
+	if (!netif_is_failover_slave(slave_dev))
+		goto done;
+
+	ASSERT_RTNL();
+
+	failover_dev = failover_get_bymac(slave_dev->perm_addr, &fops);
+	if (!failover_dev)
+		goto done;
+
+	if (fops && fops->slave_unregister)
+		return fops->slave_unregister(slave_dev, failover_dev);
+
+done:
+	return NOTIFY_DONE;
+}
+EXPORT_SYMBOL_GPL(failover_slave_unregister);
+
+static int failover_slave_link_change(struct net_device *slave_dev)
+{
+	struct net_device *failover_dev;
+	struct failover_ops *fops;
+
+	if (!netif_is_failover_slave(slave_dev))
+		goto done;
+
+	ASSERT_RTNL();
+
+	failover_dev = failover_get_bymac(slave_dev->perm_addr, &fops);
+	if (!failover_dev)
+		goto done;
+
+	if (!netif_running(failover_dev))
+		goto done;
+
+	if (fops && fops->slave_link_change)
+		return fops->slave_link_change(slave_dev, failover_dev);
+
+done:
+	return NOTIFY_DONE;
+}
+
+static int failover_slave_name_change(struct net_device *slave_dev)
+{
+	struct net_device *failover_dev;
+	struct failover_ops *fops;
+
+	if (!netif_is_failover_slave(slave_dev))
+		goto done;
+
+	ASSERT_RTNL();
+
+	failover_dev = failover_get_bymac(slave_dev->perm_addr, &fops);
+	if (!failover_dev)
+		goto done;
+
+	if (!netif_running(failover_dev))
+		goto done;
+
+	if (fops && fops->slave_name_change)
+		return fops->slave_name_change(slave_dev, failover_dev);
+
+done:
+	return NOTIFY_DONE;
+}
+
+static int
+failover_event(struct notifier_block *this, unsigned long event, void *ptr)
+{
+	struct net_device *event_dev = netdev_notifier_info_to_dev(ptr);
+
+	/* Skip parent events */
+	if (netif_is_failover(event_dev))
+		return NOTIFY_DONE;
+
+	switch (event) {
+	case NETDEV_REGISTER:
+		return failover_slave_register(event_dev);
+	case NETDEV_UNREGISTER:
+		return failover_slave_unregister(event_dev);
+	case NETDEV_UP:
+	case NETDEV_DOWN:
+	case NETDEV_CHANGE:
+		return failover_slave_link_change(event_dev);
+	case NETDEV_CHANGENAME:
+		return failover_slave_name_change(event_dev);
+	default:
+		return NOTIFY_DONE;
+	}
+}
+
+static struct notifier_block failover_notifier = {
+	.notifier_call = failover_event,
+};
+
+static void
+failover_existing_slave_register(struct net_device *failover_dev)
+{
+	struct net *net = dev_net(failover_dev);
+	struct net_device *dev;
+
+	rtnl_lock();
+	for_each_netdev(net, dev) {
+		if (netif_is_failover(dev))
+			continue;
+		if (ether_addr_equal(failover_dev->perm_addr, dev->perm_addr))
+			failover_slave_register(dev);
+	}
+	rtnl_unlock();
+}
+
+/**
+ * failover_register - Register a failover instance
+ *
+ * @dev: failover netdev
+ * @ops: failover ops
+ *
+ * Allocate and register a failover instance for a failover netdev. ops
+ * provides handlers for slave device register/unregister/link change/
+ * name change events.
+ *
+ * Return: pointer to failover instance
+ */
+struct failover *failover_register(struct net_device *dev,
+				   struct failover_ops *ops)
+{
+	struct failover *failover;
+
+	if (dev->type != ARPHRD_ETHER)
+		return ERR_PTR(-EINVAL);
+
+	failover = kzalloc(sizeof(*failover), GFP_KERNEL);
+	if (!failover)
+		return ERR_PTR(-ENOMEM);
+
+	rcu_assign_pointer(failover->ops, ops);
+	dev_hold(dev);
+	dev->priv_flags |= IFF_FAILOVER;
+	rcu_assign_pointer(failover->failover_dev, dev);
+
+	spin_lock(&failover_lock);
+	list_add_tail(&failover->list, &failover_list);
+	spin_unlock(&failover_lock);
+
+	netdev_info(dev, "failover master:%s registered\n", dev->name);
+
+	failover_existing_slave_register(dev);
+
+	return failover;
+}
+EXPORT_SYMBOL_GPL(failover_register);
+
+/**
+ * failover_unregister - Unregister a failover instance
+ *
+ * @failover: pointer to failover instance
+ *
+ * Unregisters and frees a failover instance.
+ */
+void failover_unregister(struct failover *failover)
+{
+	struct net_device *failover_dev;
+
+	failover_dev = rcu_dereference(failover->failover_dev);
+
+	netdev_info(failover_dev, "failover master:%s unregistered\n",
+		    failover_dev->name);
+
+	failover_dev->priv_flags &= ~IFF_FAILOVER;
+	dev_put(failover_dev);
+
+	spin_lock(&failover_lock);
+	list_del(&failover->list);
+	spin_unlock(&failover_lock);
+
+	kfree(failover);
+}
+EXPORT_SYMBOL_GPL(failover_unregister);
+
+static __init int
+failover_init(void)
+{
+	register_netdevice_notifier(&failover_notifier);
+
+	return 0;
+}
+module_init(failover_init);
+
+static __exit
+void failover_exit(void)
+{
+	unregister_netdevice_notifier(&failover_notifier);
+}
+module_exit(failover_exit);
+
+MODULE_DESCRIPTION("Generic failover infrastructure/interface");
+MODULE_LICENSE("GPL v2");
-- 
2.14.3


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

