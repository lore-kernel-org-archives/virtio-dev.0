Return-Path: virtio-dev-return-3733-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 7AC6258191B1
	for <virtio-dev@lists.oasis-open.org>; Thu,  5 Apr 2018 14:08:35 -0700 (PDT)
From: Sridhar Samudrala <sridhar.samudrala@intel.com>
Date: Thu,  5 Apr 2018 14:08:21 -0700
Message-Id: <1522962503-3963-3-git-send-email-sridhar.samudrala@intel.com>
In-Reply-To: <1522962503-3963-1-git-send-email-sridhar.samudrala@intel.com>
References: <1522962503-3963-1-git-send-email-sridhar.samudrala@intel.com>
Subject: [virtio-dev] [RFC PATCH net-next v5 2/4] net: Introduce generic bypass module
To: mst@redhat.com, stephen@networkplumber.org, davem@davemloft.net, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, kubakici@wp.pl, sridhar.samudrala@intel.com, jasowang@redhat.com, loseweigh@gmail.com, jiri@resnulli.us
List-ID: <virtio-dev.lists.oasis-open.org>

This provides a generic interface for paravirtual drivers to listen
for netdev register/unregister/link change events from pci ethernet
devices with the same MAC and takeover their datapath. The notifier and
event handling code is based on the existing netvsc implementation. A
paravirtual driver can use this module by registering a set of ops and
each instance of the device when it is probed.

Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
---
 include/net/bypass.h |  80 ++++++++++
 net/Kconfig          |  18 +++
 net/core/Makefile    |   1 +
 net/core/bypass.c    | 406 +++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 505 insertions(+)
 create mode 100644 include/net/bypass.h
 create mode 100644 net/core/bypass.c

diff --git a/include/net/bypass.h b/include/net/bypass.h
new file mode 100644
index 000000000000..e2dd122f951a
--- /dev/null
+++ b/include/net/bypass.h
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2018, Intel Corporation. */
+
+#ifndef _NET_BYPASS_H
+#define _NET_BYPASS_H
+
+#include <linux/netdevice.h>
+
+struct bypass_ops {
+	int (*register_child)(struct net_device *bypass_netdev,
+			      struct net_device *child_netdev);
+	int (*join_child)(struct net_device *bypass_netdev,
+			  struct net_device *child_netdev);
+	int (*unregister_child)(struct net_device *bypass_netdev,
+				struct net_device *child_netdev);
+	int (*release_child)(struct net_device *bypass_netdev,
+			     struct net_device *child_netdev);
+	int (*update_link)(struct net_device *bypass_netdev,
+			   struct net_device *child_netdev);
+	rx_handler_result_t (*handle_frame)(struct sk_buff **pskb);
+};
+
+struct bypass_instance {
+	struct list_head list;
+	struct net_device __rcu *bypass_netdev;
+	struct bypass *bypass;
+};
+
+struct bypass {
+	struct list_head list;
+	const struct bypass_ops *ops;
+	const struct net_device_ops *netdev_ops;
+	struct list_head instance_list;
+	struct mutex lock;
+};
+
+#if IS_ENABLED(CONFIG_NET_BYPASS)
+
+struct bypass *bypass_register_driver(const struct bypass_ops *ops,
+				      const struct net_device_ops *netdev_ops);
+void bypass_unregister_driver(struct bypass *bypass);
+
+int bypass_register_instance(struct bypass *bypass, struct net_device *dev);
+int bypass_unregister_instance(struct bypass *bypass, struct net_device	*dev);
+
+int bypass_unregister_child(struct net_device *child_netdev);
+
+#else
+
+static inline
+struct bypass *bypass_register_driver(const struct bypass_ops *ops,
+				      const struct net_device_ops *netdev_ops)
+{
+	return NULL;
+}
+
+static inline void bypass_unregister_driver(struct bypass *bypass)
+{
+}
+
+static inline int bypass_register_instance(struct bypass *bypass,
+					   struct net_device *dev)
+{
+	return 0;
+}
+
+static inline int bypass_unregister_instance(struct bypass *bypass,
+					     struct net_device *dev)
+{
+	return 0;
+}
+
+static inline int bypass_unregister_child(struct net_device *child_netdev)
+{
+	return 0;
+}
+
+#endif
+
+#endif /* _NET_BYPASS_H */
diff --git a/net/Kconfig b/net/Kconfig
index 0428f12c25c2..994445f4a96a 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -423,6 +423,24 @@ config MAY_USE_DEVLINK
 	  on MAY_USE_DEVLINK to ensure they do not cause link errors when
 	  devlink is a loadable module and the driver using it is built-in.
 
+config NET_BYPASS
+	tristate "Bypass interface"
+	---help---
+	  This provides a generic interface for paravirtual drivers to listen
+	  for netdev register/unregister/link change events from pci ethernet
+	  devices with the same MAC and takeover their datapath. This also
+	  enables live migration of a VM with direct attached VF by failing
+	  over to the paravirtual datapath when the VF is unplugged.
+
+config MAY_USE_BYPASS
+	tristate
+	default m if NET_BYPASS=m
+	default y if NET_BYPASS=y || NET_BYPASS=n
+	help
+	  Drivers using the bypass infrastructure should have a dependency
+	  on MAY_USE_BYPASS to ensure they do not cause link errors when
+	  bypass is a loadable module and the driver using it is built-in.
+
 endif   # if NET
 
 # Used by archs to tell that they support BPF JIT compiler plus which flavour.
diff --git a/net/core/Makefile b/net/core/Makefile
index 6dbbba8c57ae..a9727ed1c8fc 100644
--- a/net/core/Makefile
+++ b/net/core/Makefile
@@ -30,3 +30,4 @@ obj-$(CONFIG_DST_CACHE) += dst_cache.o
 obj-$(CONFIG_HWBM) += hwbm.o
 obj-$(CONFIG_NET_DEVLINK) += devlink.o
 obj-$(CONFIG_GRO_CELLS) += gro_cells.o
+obj-$(CONFIG_NET_BYPASS) += bypass.o
diff --git a/net/core/bypass.c b/net/core/bypass.c
new file mode 100644
index 000000000000..7bde962ec3d4
--- /dev/null
+++ b/net/core/bypass.c
@@ -0,0 +1,406 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2018, Intel Corporation. */
+
+/* A common module to handle registrations and notifications for paravirtual
+ * drivers to enable accelerated datapath and support VF live migration.
+ *
+ * The notifier and event handling code is based on netvsc driver.
+ */
+
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <linux/ethtool.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/netdevice.h>
+#include <linux/netpoll.h>
+#include <linux/rtnetlink.h>
+#include <linux/if_vlan.h>
+#include <net/sch_generic.h>
+#include <uapi/linux/if_arp.h>
+#include <net/bypass.h>
+
+static LIST_HEAD(bypass_list);
+
+static DEFINE_MUTEX(bypass_mutex);
+
+struct bypass_instance *bypass_instance_alloc(struct net_device *dev)
+{
+	struct bypass_instance *bypass_instance;
+
+	bypass_instance = kzalloc(sizeof(*bypass_instance), GFP_KERNEL);
+	if (!bypass_instance)
+		return NULL;
+
+	dev_hold(dev);
+	rcu_assign_pointer(bypass_instance->bypass_netdev, dev);
+
+	return bypass_instance;
+}
+
+void bypass_instance_free(struct bypass_instance *bypass_instance)
+{
+	struct net_device *bypass_netdev;
+
+	bypass_netdev = rcu_dereference(bypass_instance->bypass_netdev);
+
+	dev_put(bypass_netdev);
+	kfree(bypass_instance);
+}
+
+static struct bypass_instance *bypass_get_instance_bymac(u8 *mac)
+{
+	struct bypass_instance *bypass_instance;
+	struct net_device *bypass_netdev;
+	struct bypass *bypass;
+
+	list_for_each_entry(bypass, &bypass_list, list) {
+		mutex_lock(&bypass->lock);
+		list_for_each_entry(bypass_instance, &bypass->instance_list,
+				    list) {
+			bypass_netdev =
+				rcu_dereference(bypass_instance->bypass_netdev);
+			if (ether_addr_equal(bypass_netdev->perm_addr, mac)) {
+				mutex_unlock(&bypass->lock);
+				goto out;
+			}
+		}
+		mutex_unlock(&bypass->lock);
+	}
+
+	bypass_instance = NULL;
+out:
+	return bypass_instance;
+}
+
+static int bypass_register_child(struct net_device *child_netdev)
+{
+	struct bypass_instance *bypass_instance;
+	struct bypass *bypass;
+	struct net_device *bypass_netdev;
+	int ret, orig_mtu;
+
+	ASSERT_RTNL();
+
+	mutex_lock(&bypass_mutex);
+	bypass_instance = bypass_get_instance_bymac(child_netdev->perm_addr);
+	if (!bypass_instance) {
+		mutex_unlock(&bypass_mutex);
+		goto done;
+	}
+
+	bypass_netdev = rcu_dereference(bypass_instance->bypass_netdev);
+	bypass = bypass_instance->bypass;
+	mutex_unlock(&bypass_mutex);
+
+	if (!bypass->ops->register_child)
+		goto done;
+
+	ret = bypass->ops->register_child(bypass_netdev, child_netdev);
+	if (ret != 0)
+		goto done;
+
+	ret = netdev_rx_handler_register(child_netdev,
+					 bypass->ops->handle_frame,
+					 bypass_netdev);
+	if (ret != 0) {
+		netdev_err(child_netdev,
+			   "can not register bypass rx handler (err = %d)\n",
+			   ret);
+		goto rx_handler_failed;
+	}
+
+	ret = netdev_upper_dev_link(child_netdev, bypass_netdev, NULL);
+	if (ret != 0) {
+		netdev_err(child_netdev,
+			   "can not set master device %s (err = %d)\n",
+			   bypass_netdev->name, ret);
+		goto upper_link_failed;
+	}
+
+	child_netdev->flags |= IFF_SLAVE;
+
+	if (netif_running(bypass_netdev)) {
+		ret = dev_open(child_netdev);
+		if (ret && (ret != -EBUSY)) {
+			netdev_err(bypass_netdev,
+				   "Opening child %s failed ret:%d\n",
+				   child_netdev->name, ret);
+			goto err_interface_up;
+		}
+	}
+
+	/* Align MTU of child with master */
+	orig_mtu = child_netdev->mtu;
+	ret = dev_set_mtu(child_netdev, bypass_netdev->mtu);
+	if (ret != 0) {
+		netdev_err(bypass_netdev,
+			   "unable to change mtu of %s to %u register failed\n",
+			   child_netdev->name, bypass_netdev->mtu);
+		goto err_set_mtu;
+	}
+
+	ret = bypass->ops->join_child(bypass_netdev, child_netdev);
+	if (ret != 0)
+		goto err_join;
+
+	call_netdevice_notifiers(NETDEV_JOIN, child_netdev);
+
+	goto done;
+
+err_join:
+	dev_set_mtu(child_netdev, orig_mtu);
+err_set_mtu:
+	dev_close(child_netdev);
+err_interface_up:
+	netdev_upper_dev_unlink(child_netdev, bypass_netdev);
+	child_netdev->flags &= ~IFF_SLAVE;
+upper_link_failed:
+	netdev_rx_handler_unregister(child_netdev);
+rx_handler_failed:
+	bypass->ops->unregister_child(bypass_netdev, child_netdev);
+
+done:
+	return NOTIFY_DONE;
+}
+
+int bypass_unregister_child(struct net_device *child_netdev)
+{
+	struct bypass_instance *bypass_instance;
+	struct net_device *bypass_netdev;
+	struct bypass *bypass;
+	int ret;
+
+	ASSERT_RTNL();
+
+	mutex_lock(&bypass_mutex);
+	bypass_instance = bypass_get_instance_bymac(child_netdev->perm_addr);
+	if (!bypass_instance) {
+		mutex_unlock(&bypass_mutex);
+		goto done;
+	}
+
+	bypass_netdev = rcu_dereference(bypass_instance->bypass_netdev);
+	bypass = bypass_instance->bypass;
+	mutex_unlock(&bypass_mutex);
+
+	ret = bypass->ops->release_child(bypass_netdev, child_netdev);
+	if (ret != 0)
+		goto done;
+
+	netdev_rx_handler_unregister(child_netdev);
+	netdev_upper_dev_unlink(child_netdev, bypass_netdev);
+	child_netdev->flags &= ~IFF_SLAVE;
+
+	if (!bypass->ops->unregister_child)
+		goto done;
+
+	bypass->ops->unregister_child(bypass_netdev, child_netdev);
+
+done:
+	return NOTIFY_DONE;
+}
+EXPORT_SYMBOL(bypass_unregister_child);
+
+static int bypass_update_link(struct net_device *child_netdev)
+{
+	struct bypass_instance *bypass_instance;
+	struct net_device *bypass_netdev;
+	struct bypass *bypass;
+
+	ASSERT_RTNL();
+
+	mutex_lock(&bypass_mutex);
+	bypass_instance = bypass_get_instance_bymac(child_netdev->perm_addr);
+	if (!bypass_instance) {
+		mutex_unlock(&bypass_mutex);
+		goto done;
+	}
+
+	bypass_netdev = rcu_dereference(bypass_instance->bypass_netdev);
+	bypass = bypass_instance->bypass;
+	mutex_unlock(&bypass_mutex);
+
+	if (!bypass->ops->update_link)
+		goto done;
+
+	bypass->ops->update_link(bypass_netdev, child_netdev);
+
+done:
+	return NOTIFY_DONE;
+}
+
+static bool bypass_validate_child_dev(struct net_device *dev)
+{
+	/* Avoid non-Ethernet type devices */
+	if (dev->type != ARPHRD_ETHER)
+		return false;
+
+	/* Avoid Vlan dev with same MAC registering as VF */
+	if (is_vlan_dev(dev))
+		return false;
+
+	/* Avoid Bonding master dev with same MAC registering as child dev */
+	if ((dev->priv_flags & IFF_BONDING) && (dev->flags & IFF_MASTER))
+		return false;
+
+	return true;
+}
+
+static int
+bypass_event(struct notifier_block *this, unsigned long event, void *ptr)
+{
+	struct net_device *event_dev = netdev_notifier_info_to_dev(ptr);
+	struct bypass *bypass;
+
+	/* Skip Parent events */
+	mutex_lock(&bypass_mutex);
+	list_for_each_entry(bypass, &bypass_list, list) {
+		if (event_dev->netdev_ops == bypass->netdev_ops) {
+			mutex_unlock(&bypass_mutex);
+			return NOTIFY_DONE;
+		}
+	}
+	mutex_unlock(&bypass_mutex);
+
+	if (!bypass_validate_child_dev(event_dev))
+		return NOTIFY_DONE;
+
+	switch (event) {
+	case NETDEV_REGISTER:
+		return bypass_register_child(event_dev);
+	case NETDEV_UNREGISTER:
+		return bypass_unregister_child(event_dev);
+	case NETDEV_UP:
+	case NETDEV_DOWN:
+	case NETDEV_CHANGE:
+		return bypass_update_link(event_dev);
+	default:
+		return NOTIFY_DONE;
+	}
+}
+
+static struct notifier_block bypass_notifier = {
+	.notifier_call = bypass_event,
+};
+
+static void bypass_register_existing_child(struct net_device *bypass_netdev)
+{
+	struct net *net = dev_net(bypass_netdev);
+	struct net_device *dev;
+
+	rtnl_lock();
+	for_each_netdev(net, dev) {
+		if (dev == bypass_netdev)
+			continue;
+		if (!bypass_validate_child_dev(dev))
+			continue;
+		if (ether_addr_equal(bypass_netdev->perm_addr, dev->perm_addr))
+			bypass_register_child(dev);
+	}
+	rtnl_unlock();
+}
+
+int bypass_register_instance(struct bypass *bypass, struct net_device *dev)
+{
+	struct bypass_instance *bypass_instance;
+	struct net_device *bypass_netdev;
+	int ret = 0;
+
+	mutex_lock(&bypass->lock);
+	list_for_each_entry(bypass_instance, &bypass->instance_list, list) {
+		bypass_netdev = rcu_dereference(bypass_instance->bypass_netdev);
+		if (bypass_netdev == dev) {
+			ret = -EEXIST;
+			goto done;
+		}
+	}
+
+	bypass_instance = bypass_instance_alloc(dev);
+	if (!bypass_instance) {
+		ret = -ENOMEM;
+		goto done;
+	}
+
+	bypass_instance->bypass = bypass;
+	list_add_tail(&bypass_instance->list, &bypass->instance_list);
+
+done:
+	mutex_unlock(&bypass->lock);
+	bypass_register_existing_child(dev);
+	return ret;
+}
+EXPORT_SYMBOL(bypass_register_instance);
+
+int bypass_unregister_instance(struct bypass *bypass, struct net_device *dev)
+{
+	struct bypass_instance *bypass_instance;
+	struct net_device *bypass_netdev;
+	int ret = 0;
+
+	mutex_lock(&bypass->lock);
+	list_for_each_entry(bypass_instance, &bypass->instance_list, list) {
+		bypass_netdev = rcu_dereference(bypass_instance->bypass_netdev);
+		if (bypass_netdev == dev) {
+			list_del(&bypass_instance->list);
+			bypass_instance_free(bypass_instance);
+			goto done;
+		}
+	}
+
+	ret = -ENOENT;
+done:
+	mutex_unlock(&bypass->lock);
+	return ret;
+}
+EXPORT_SYMBOL(bypass_unregister_instance);
+
+struct bypass *bypass_register_driver(const struct bypass_ops *ops,
+				      const struct net_device_ops *netdev_ops)
+{
+	struct bypass *bypass;
+
+	bypass = kzalloc(sizeof(*bypass), GFP_KERNEL);
+	if (!bypass)
+		return NULL;
+
+	bypass->ops = ops;
+	bypass->netdev_ops = netdev_ops;
+	INIT_LIST_HEAD(&bypass->instance_list);
+
+	mutex_lock(&bypass_mutex);
+	list_add_tail(&bypass->list, &bypass_list);
+	mutex_unlock(&bypass_mutex);
+
+	return bypass;
+}
+EXPORT_SYMBOL_GPL(bypass_register_driver);
+
+void bypass_unregister_driver(struct bypass *bypass)
+{
+	mutex_lock(&bypass_mutex);
+	list_del(&bypass->list);
+	mutex_unlock(&bypass_mutex);
+
+	kfree(bypass);
+}
+EXPORT_SYMBOL_GPL(bypass_unregister_driver);
+
+static __init int
+bypass_init(void)
+{
+	register_netdevice_notifier(&bypass_notifier);
+
+	return 0;
+}
+module_init(bypass_init);
+
+static __exit
+void bypass_exit(void)
+{
+	unregister_netdevice_notifier(&bypass_notifier);
+}
+module_exit(bypass_exit);
+
+MODULE_DESCRIPTION("Bypass infrastructure/interface for Paravirtual drivers");
+MODULE_LICENSE("GPL v2");
-- 
2.14.3


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

