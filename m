Return-Path: virtio-dev-return-3689-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id F0CB258191D7
	for <virtio-dev@lists.oasis-open.org>; Sun,  1 Apr 2018 02:33:29 -0700 (PDT)
From: Si-Wei Liu <si-wei.liu@oracle.com>
Date: Sun,  1 Apr 2018 05:13:09 -0400
Message-Id: <1522573990-5242-3-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1522573990-5242-1-git-send-email-si-wei.liu@oracle.com>
References: <1522573990-5242-1-git-send-email-si-wei.liu@oracle.com>
Subject: [virtio-dev] [RFC PATCH 2/3] netdev: kernel-only IFF_HIDDEN netdevice
To: mst@redhat.com, jiri@resnulli.us, stephen@networkplumber.org, alexander.h.duyck@intel.com, davem@davemloft.net, jesse.brandeburg@intel.com, kubakici@wp.pl, jasowang@redhat.com, sridhar.samudrala@intel.com, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

Hidden netdevice is not visible to userspace such that
typical network utilites e.g. ip, ifconfig and et al,
cannot sense its existence or configure it. Internally
hidden netdev may associate with an upper level netdev
that userspace has access to. Although userspace cannot
manipulate the lower netdev directly, user may control
or configure the underlying hidden device through the
upper-level netdev. For identification purpose, the
kobject for hidden netdev still presents in the sysfs
hierarchy, however, no uevent message will be generated
when the sysfs entry is created, modified or destroyed.

For that end, a separate namescope needs to be carved
out for IFF_HIDDEN netdevs. As of now netdev name that
starts with colon i.e. ':' is invalid in userspace,
since socket ioctls such as SIOCGIFCONF use ':' as the
separator for ifname. The absence of namescope started
with ':' can rightly be used as the namescope for
the kernel-only IFF_HIDDEN netdevs.

Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
---
 include/linux/netdevice.h   |  12 ++
 include/net/net_namespace.h |   2 +
 net/core/dev.c              | 281 ++++++++++++++++++++++++++++++++++++++------
 net/core/net_namespace.c    |   1 +
 4 files changed, 263 insertions(+), 33 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index ef789e1..1a70f3a 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1380,6 +1380,7 @@ struct net_device_ops {
  * @IFF_PHONY_HEADROOM: the headroom value is controlled by an external
  *	entity (i.e. the master device for bridged veth)
  * @IFF_MACSEC: device is a MACsec device
+ * @IFF_HIDDEN: device is not visible to userspace
  */
 enum netdev_priv_flags {
 	IFF_802_1Q_VLAN			= 1<<0,
@@ -1410,6 +1411,7 @@ enum netdev_priv_flags {
 	IFF_RXFH_CONFIGURED		= 1<<25,
 	IFF_PHONY_HEADROOM		= 1<<26,
 	IFF_MACSEC			= 1<<27,
+	IFF_HIDDEN			= 1<<28,
 };
 
 #define IFF_802_1Q_VLAN			IFF_802_1Q_VLAN
@@ -1439,6 +1441,7 @@ enum netdev_priv_flags {
 #define IFF_TEAM			IFF_TEAM
 #define IFF_RXFH_CONFIGURED		IFF_RXFH_CONFIGURED
 #define IFF_MACSEC			IFF_MACSEC
+#define IFF_HIDDEN			IFF_HIDDEN
 
 /**
  *	struct net_device - The DEVICE structure.
@@ -1659,6 +1662,7 @@ enum netdev_priv_flags {
 struct net_device {
 	char			name[IFNAMSIZ];
 	struct hlist_node	name_hlist;
+	struct hlist_node	name_cmpl_hlist;
 	struct dev_ifalias	__rcu *ifalias;
 	/*
 	 *	I/O specific fields
@@ -1680,6 +1684,7 @@ struct net_device {
 	unsigned long		state;
 
 	struct list_head	dev_list;
+	struct list_head	dev_cmpl_list;
 	struct list_head	napi_list;
 	struct list_head	unreg_list;
 	struct list_head	close_list;
@@ -2326,6 +2331,7 @@ struct netdev_lag_lower_state_info {
 #define NETDEV_UDP_TUNNEL_PUSH_INFO	0x001C
 #define NETDEV_UDP_TUNNEL_DROP_INFO	0x001D
 #define NETDEV_CHANGE_TX_QUEUE_LEN	0x001E
+#define NETDEV_PRE_GETNAME	0x001F
 
 int register_netdevice_notifier(struct notifier_block *nb);
 int unregister_netdevice_notifier(struct notifier_block *nb);
@@ -2393,6 +2399,8 @@ static inline void netdev_notifier_info_init(struct netdev_notifier_info *info,
 		for_each_netdev_rcu(&init_net, slave)	\
 			if (netdev_master_upper_dev_get_rcu(slave) == (bond))
 #define net_device_entry(lh)	list_entry(lh, struct net_device, dev_list)
+#define for_each_netdev_complete(net, d)		\
+		list_for_each_entry(d, &(net)->dev_cmpl_head, dev_cmpl_list)
 
 static inline struct net_device *next_net_device(struct net_device *dev)
 {
@@ -2462,6 +2470,10 @@ static inline void unregister_netdevice(struct net_device *dev)
 	unregister_netdevice_queue(dev, NULL);
 }
 
+void netdev_set_hidden(struct net_device *dev);
+int hide_netdevice(struct net_device *dev);
+void unhide_netdevice(struct net_device *dev);
+
 int netdev_refcnt_read(const struct net_device *dev);
 void free_netdev(struct net_device *dev);
 void netdev_freemem(struct net_device *dev);
diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index 0490084..f9ce9b4 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -80,7 +80,9 @@ struct net {
 	struct sock		*genl_sock;
 
 	struct list_head 	dev_base_head;
+	struct list_head 	dev_cmpl_head;
 	struct hlist_head 	*dev_name_head;
+	struct hlist_head 	*dev_name_cmpl_head;
 	struct hlist_head	*dev_index_head;
 	unsigned int		dev_base_seq;	/* protected by rtnl_mutex */
 	int			ifindex;
diff --git a/net/core/dev.c b/net/core/dev.c
index 613fb40..a991b35 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -211,6 +211,13 @@ static inline struct hlist_head *dev_name_hash(struct net *net, const char *name
 	return &net->dev_name_head[hash_32(hash, NETDEV_HASHBITS)];
 }
 
+static inline struct hlist_head *dev_cname_hash(struct net *net, const char *name)
+{
+	unsigned int hash = full_name_hash(net, name, strnlen(name, IFNAMSIZ));
+
+	return &net->dev_name_cmpl_head[hash_32(hash, NETDEV_HASHBITS)];
+}
+
 static inline struct hlist_head *dev_index_hash(struct net *net, int ifindex)
 {
 	return &net->dev_index_head[ifindex & (NETDEV_HASHENTRIES - 1)];
@@ -237,11 +244,19 @@ static void list_netdevice(struct net_device *dev)
 
 	ASSERT_RTNL();
 
+
 	write_lock_bh(&dev_base_lock);
-	list_add_tail_rcu(&dev->dev_list, &net->dev_base_head);
-	hlist_add_head_rcu(&dev->name_hlist, dev_name_hash(net, dev->name));
-	hlist_add_head_rcu(&dev->index_hlist,
-			   dev_index_hash(net, dev->ifindex));
+	if (!(dev->priv_flags & IFF_HIDDEN)) {
+		list_add_tail_rcu(&dev->dev_list, &net->dev_base_head);
+		hlist_add_head_rcu(&dev->name_hlist,
+				   dev_name_hash(net, dev->name));
+		hlist_add_head_rcu(&dev->index_hlist,
+				   dev_index_hash(net, dev->ifindex));
+	}
+	list_add_tail_rcu(&dev->dev_cmpl_list,
+			  &net->dev_cmpl_head);
+	hlist_add_head_rcu(&dev->name_cmpl_hlist,
+			   dev_cname_hash(net, dev->name));
 	write_unlock_bh(&dev_base_lock);
 
 	dev_base_seq_inc(net);
@@ -256,9 +271,13 @@ static void unlist_netdevice(struct net_device *dev)
 
 	/* Unlink dev from the device chain */
 	write_lock_bh(&dev_base_lock);
-	list_del_rcu(&dev->dev_list);
-	hlist_del_rcu(&dev->name_hlist);
-	hlist_del_rcu(&dev->index_hlist);
+	if (!(dev->priv_flags & IFF_HIDDEN)) {
+		list_del_rcu(&dev->dev_list);
+		hlist_del_rcu(&dev->name_hlist);
+		hlist_del_rcu(&dev->index_hlist);
+	}
+	list_del_rcu(&dev->dev_cmpl_list);
+	hlist_del_rcu(&dev->name_cmpl_hlist);
 	write_unlock_bh(&dev_base_lock);
 
 	dev_base_seq_inc(dev_net(dev));
@@ -736,11 +755,15 @@ int dev_fill_metadata_dst(struct net_device *dev, struct sk_buff *skb)
 struct net_device *__dev_get_by_name(struct net *net, const char *name)
 {
 	struct net_device *dev;
-	struct hlist_head *head = dev_name_hash(net, name);
+	struct hlist_head *head = dev_cname_hash(net, name);
+	bool hidden_name = (*name == ':');
 
-	hlist_for_each_entry(dev, head, name_hlist)
+	hlist_for_each_entry(dev, head, name_cmpl_hlist) {
+		if (hidden_name && !(dev->priv_flags & IFF_HIDDEN))
+			continue;
 		if (!strncmp(dev->name, name, IFNAMSIZ))
 			return dev;
+	}
 
 	return NULL;
 }
@@ -1015,15 +1038,7 @@ struct net_device *__dev_get_by_flags(struct net *net, unsigned short if_flags,
 }
 EXPORT_SYMBOL(__dev_get_by_flags);
 
-/**
- *	dev_valid_name - check if name is okay for network device
- *	@name: name string
- *
- *	Network device names need to be valid file names to
- *	to allow sysfs to work.  We also disallow any kind of
- *	whitespace.
- */
-bool dev_valid_name(const char *name)
+static bool __dev_valid_name(const char *name, bool hidden)
 {
 	if (*name == '\0')
 		return false;
@@ -1033,12 +1048,27 @@ bool dev_valid_name(const char *name)
 		return false;
 
 	while (*name) {
-		if (*name == '/' || *name == ':' || isspace(*name))
+		if (*name == '/' || isspace(*name))
+			return false;
+		if (!hidden && *name == ':')
 			return false;
 		name++;
 	}
 	return true;
 }
+
+/**
+ *	dev_valid_name - check if name is okay for network device
+ *	@name: name string
+ *
+ *	Network device names need to be valid file names to
+ *	to allow sysfs to work.  We also disallow any kind of
+ *	whitespace.
+ */
+bool dev_valid_name(const char *name)
+{
+	return __dev_valid_name(name, false);
+}
 EXPORT_SYMBOL(dev_valid_name);
 
 /**
@@ -1064,9 +1094,6 @@ static int __dev_alloc_name(struct net *net, const char *name, char *buf)
 	unsigned long *inuse;
 	struct net_device *d;
 
-	if (!dev_valid_name(name))
-		return -EINVAL;
-
 	p = strchr(name, '%');
 	if (p) {
 		/*
@@ -1082,7 +1109,7 @@ static int __dev_alloc_name(struct net *net, const char *name, char *buf)
 		if (!inuse)
 			return -ENOMEM;
 
-		for_each_netdev(net, d) {
+		for_each_netdev_complete(net, d) {
 			if (!sscanf(d->name, name, &i))
 				continue;
 			if (i < 0 || i >= max_netdevices)
@@ -1139,18 +1166,18 @@ static int dev_alloc_name_ns(struct net *net,
 
 int dev_alloc_name(struct net_device *dev, const char *name)
 {
+	if (!dev_valid_name(name))
+		return -EINVAL;
+
 	return dev_alloc_name_ns(dev_net(dev), dev, name);
 }
 EXPORT_SYMBOL(dev_alloc_name);
 
-int dev_get_valid_name(struct net *net, struct net_device *dev,
-		       const char *name)
+static int __dev_get_name(struct net *net, struct net_device *dev,
+			  const char *name)
 {
 	BUG_ON(!net);
 
-	if (!dev_valid_name(name))
-		return -EINVAL;
-
 	if (strchr(name, '%'))
 		return dev_alloc_name_ns(net, dev, name);
 	else if (__dev_get_by_name(net, name))
@@ -1160,6 +1187,15 @@ int dev_get_valid_name(struct net *net, struct net_device *dev,
 
 	return 0;
 }
+
+int dev_get_valid_name(struct net *net, struct net_device *dev,
+		       const char *name)
+{
+	if (!__dev_valid_name(name, (dev->priv_flags & IFF_HIDDEN)))
+		return -EINVAL;
+
+	return __dev_get_name(net, dev, name);
+}
 EXPORT_SYMBOL(dev_get_valid_name);
 
 /**
@@ -1221,12 +1257,15 @@ int dev_change_name(struct net_device *dev, const char *newname)
 
 	write_lock_bh(&dev_base_lock);
 	hlist_del_rcu(&dev->name_hlist);
+	hlist_del_rcu(&dev->name_cmpl_hlist);
 	write_unlock_bh(&dev_base_lock);
 
 	synchronize_rcu();
 
 	write_lock_bh(&dev_base_lock);
 	hlist_add_head_rcu(&dev->name_hlist, dev_name_hash(net, dev->name));
+	hlist_add_head_rcu(&dev->name_cmpl_hlist,
+			   dev_cname_hash(net, dev->name));
 	write_unlock_bh(&dev_base_lock);
 
 	ret = call_netdevice_notifiers(NETDEV_CHANGENAME, dev);
@@ -1594,7 +1633,7 @@ int register_netdevice_notifier(struct notifier_block *nb)
 	if (dev_boot_phase)
 		goto unlock;
 	for_each_net(net) {
-		for_each_netdev(net, dev) {
+		for_each_netdev_complete(net, dev) {
 			err = call_netdevice_notifier(nb, NETDEV_REGISTER, dev);
 			err = notifier_to_errno(err);
 			if (err)
@@ -1614,7 +1653,7 @@ int register_netdevice_notifier(struct notifier_block *nb)
 rollback:
 	last = dev;
 	for_each_net(net) {
-		for_each_netdev(net, dev) {
+		for_each_netdev_complete(net, dev) {
 			if (dev == last)
 				goto outroll;
 
@@ -1659,7 +1698,7 @@ int unregister_netdevice_notifier(struct notifier_block *nb)
 		goto unlock;
 
 	for_each_net(net) {
-		for_each_netdev(net, dev) {
+		for_each_netdev_complete(net, dev) {
 			if (dev->flags & IFF_UP) {
 				call_netdevice_notifier(nb, NETDEV_GOING_DOWN,
 							dev);
@@ -7642,6 +7681,11 @@ int register_netdevice(struct net_device *dev)
 	spin_lock_init(&dev->addr_list_lock);
 	netdev_set_addr_lockdep_class(dev);
 
+	ret = call_netdevice_notifiers(NETDEV_PRE_GETNAME, dev);
+	ret = notifier_to_errno(ret);
+	if (ret)
+		goto out;
+
 	ret = dev_get_valid_name(net, dev, dev->name);
 	if (ret < 0)
 		goto out;
@@ -8461,6 +8505,166 @@ int dev_change_net_namespace(struct net_device *dev, struct net *net, const char
 }
 EXPORT_SYMBOL_GPL(dev_change_net_namespace);
 
+/**
+ *	netdev_set_hidden - indicate a hidden netdev before or at
+ *			    early point of driver registration
+ *	@dev: device
+ *
+ *	Callers must hold the rtnl semaphore, typically before or
+ *	at some early point (e.g in NETDEV_PRE_GETNAME notifier)
+ *	of driver registrationr, or it won't take effect to hide
+ *	the netdev post registration.
+ */
+void netdev_set_hidden(struct net_device *dev)
+{
+	dev->priv_flags |= IFF_HIDDEN;
+	strlcpy(dev->name, ":eth%d", IFNAMSIZ);
+}
+EXPORT_SYMBOL(netdev_set_hidden);
+
+/**
+ *	hide_netdevice - hide device from userspace's visibility
+ *	@dev: device
+ *
+ *	This function shuts down a device interface and removes it
+ *	from all userspace visible dev lists, and moves it to 
+ *	comprehensive dev lists containing both userspace-visible
+ *	and kernel-only devices. On success 0 is returned, on
+ *	a failure a netagive errno code is returned.
+ */
+int hide_netdevice(struct net_device *dev)
+{
+	int err;
+
+	rtnl_lock();
+
+	err = 0;
+	/* Get out if there is nothing to do */
+	if (dev->priv_flags & IFF_HIDDEN)
+		goto out;
+
+	err = -EINVAL;
+	/* Ensure the device has been registrered */
+	if (dev->reg_state != NETREG_REGISTERED)
+		goto out;
+
+	err = __dev_get_name(dev_net(dev), dev, ":eth%d");
+       	if (err < 0)
+		goto out;
+
+	/*
+	 * And now a mini version of register_netdevice unregister_netdevice.
+	 */
+
+	/* If device is running close it first. */
+	dev_close(dev);
+
+	/* And unlink it from device chain */
+	unlist_netdevice(dev);
+	synchronize_net();
+
+	/* Shutdown queueing discipline. */
+	dev_shutdown(dev);
+
+	/* Notify protocols, that we are about to destroy
+	 * this device. They should clean all the things.
+	 *
+	 * Note that dev->reg_state stays at NETREG_REGISTERED.
+	 * This is wanted because this way 8021q and macvlan know
+	 * the device is just moving and can keep their slaves up.
+	 */
+	call_netdevice_notifiers(NETDEV_UNREGISTER, dev);
+	rcu_barrier();
+	call_netdevice_notifiers(NETDEV_UNREGISTER_FINAL, dev);
+	rtmsg_ifinfo(RTM_DELLINK, dev, ~0U, GFP_KERNEL);
+
+	/*
+	 *	Flush the unicast and multicast chains
+	 */
+	dev_uc_flush(dev);
+	dev_mc_flush(dev);
+
+	/* Send a netdev-removed uevent to the old namespace */
+	kobject_uevent(&dev->dev.kobj, KOBJ_REMOVE);
+	netdev_adjacent_del_links(dev);
+
+	/* Fixup kobjects */
+	err = device_rename(&dev->dev, dev->name);
+	WARN_ON(err);
+
+	dev->priv_flags |= IFF_HIDDEN;
+	list_netdevice(dev);
+
+	/* Notify protocols, that a new device appeared. */
+	call_netdevice_notifiers(NETDEV_REGISTER, dev);
+
+	synchronize_net();
+	err = 0;
+out:
+	rtnl_unlock();
+	return err;
+}
+EXPORT_SYMBOL(hide_netdevice);
+
+/**
+ *	unhide_netdevice - make a hidden device visible to userspace
+ *	@dev: device
+ *
+ *	This function moves a hidden device to userspace visible
+ *	interfaces. A %NETDEV_REGISTER message will be sent to
+ *	the netdev notifier chain.
+ */
+void unhide_netdevice(struct net_device *dev)
+{
+	int err;
+
+	rtnl_lock();
+	/* Get out if there is nothing to do */
+	if (!(dev->priv_flags & IFF_HIDDEN))
+		goto out;
+
+	/* Ensure the device has been registrered */
+	if (dev->reg_state != NETREG_REGISTERED)
+		goto out;
+
+	err = __dev_get_name(dev_net(dev), dev, "eth%d");
+	WARN_ON(err < 0);
+
+	/* If device is running close it first. */
+	dev_close(dev);
+	unlist_netdevice(dev);
+	synchronize_net();
+
+	/* Shutdown queueing discipline. */
+	dev_shutdown(dev);
+
+	call_netdevice_notifiers(NETDEV_UNREGISTER, dev);
+	rcu_barrier();
+	call_netdevice_notifiers(NETDEV_UNREGISTER_FINAL, dev);
+	dev_uc_flush(dev);
+	dev_mc_flush(dev);
+
+	/* Send a netdev-add uevent to the new namespace */
+	kobject_uevent(&dev->dev.kobj, KOBJ_ADD);
+	netdev_adjacent_add_links(dev);
+
+	/* Fixup kobjects */
+	err = device_rename(&dev->dev, dev->name);
+	WARN_ON(err);
+
+	/* Add the device back in the hashes */
+	dev->priv_flags &= ~IFF_HIDDEN;
+	list_netdevice(dev);
+
+	call_netdevice_notifiers(NETDEV_REGISTER, dev);
+
+	rtmsg_ifinfo(RTM_NEWLINK, dev, ~0U, GFP_KERNEL);
+	synchronize_net();
+out:
+	rtnl_unlock();
+}
+EXPORT_SYMBOL(unhide_netdevice);
+
 static int dev_cpu_dead(unsigned int oldcpu)
 {
 	struct sk_buff **list_skb;
@@ -8571,13 +8775,19 @@ static struct hlist_head * __net_init netdev_create_hash(void)
 /* Initialize per network namespace state */
 static int __net_init netdev_init(struct net *net)
 {
-	if (net != &init_net)
+	if (net != &init_net) {
 		INIT_LIST_HEAD(&net->dev_base_head);
+		INIT_LIST_HEAD(&net->dev_cmpl_head);
+	}
 
 	net->dev_name_head = netdev_create_hash();
 	if (net->dev_name_head == NULL)
 		goto err_name;
 
+	net->dev_name_cmpl_head = netdev_create_hash();
+	if (net->dev_name_cmpl_head == NULL)
+		goto err_cname;
+
 	net->dev_index_head = netdev_create_hash();
 	if (net->dev_index_head == NULL)
 		goto err_idx;
@@ -8585,6 +8795,8 @@ static int __net_init netdev_init(struct net *net)
 	return 0;
 
 err_idx:
+	kfree(net->dev_name_cmpl_head);
+err_cname:
 	kfree(net->dev_name_head);
 err_name:
 	return -ENOMEM;
@@ -8676,9 +8888,12 @@ void func(const struct net_device *dev, const char *fmt, ...)	\
 static void __net_exit netdev_exit(struct net *net)
 {
 	kfree(net->dev_name_head);
+	kfree(net->dev_name_cmpl_head);
 	kfree(net->dev_index_head);
-	if (net != &init_net)
+	if (net != &init_net) {
 		WARN_ON_ONCE(!list_empty(&net->dev_base_head));
+		WARN_ON_ONCE(!list_empty(&net->dev_cmpl_head));
+	}
 }
 
 static struct pernet_operations __net_initdata netdev_net_ops = {
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index 60a71be..1c399e9 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -37,6 +37,7 @@
 struct net init_net = {
 	.count		= ATOMIC_INIT(1),
 	.dev_base_head	= LIST_HEAD_INIT(init_net.dev_base_head),
+	.dev_cmpl_head	= LIST_HEAD_INIT(init_net.dev_cmpl_head),
 };
 EXPORT_SYMBOL(init_net);
 
-- 
1.8.3.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

