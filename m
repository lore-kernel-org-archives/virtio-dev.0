Return-Path: virtio-dev-return-3594-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 4F6055819045
	for <virtio-dev@lists.oasis-open.org>; Mon, 19 Mar 2018 00:17:37 -0700 (PDT)
From: Tiwei Bie <tiwei.bie@intel.com>
Date: Mon, 19 Mar 2018 15:15:35 +0800
Message-Id: <20180319071537.28649-5-tiwei.bie@intel.com>
In-Reply-To: <20180319071537.28649-1-tiwei.bie@intel.com>
References: <20180319071537.28649-1-tiwei.bie@intel.com>
Subject: [virtio-dev] [PATCH v2 4/6] vfio: support getting VFIOGroup from groupfd
To: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, alex.williamson@redhat.com, jasowang@redhat.com, pbonzini@redhat.com, stefanha@redhat.com
Cc: cunming.liang@intel.com, dan.daly@intel.com, jianfeng.tan@intel.com, zhihong.wang@intel.com, xiao.w.wang@intel.com, tiwei.bie@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

Add an API to support getting VFIOGroup from groupfd. When
groupfd is shared by another process, the VFIOGroup may not
have its container and address space in QEMU.

Besides, add a reference counter to better support getting
VFIOGroup multiple times.

Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
---
 hw/vfio/common.c              | 97 ++++++++++++++++++++++++++++++++++++++++++-
 include/hw/vfio/vfio-common.h |  2 +
 2 files changed, 98 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 5e84716218..24ec0f2c8d 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1038,6 +1038,11 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
     int ret, fd;
     VFIOAddressSpace *space;
 
+    if (as == NULL) {
+        vfio_kvm_device_add_group(group);
+        return 0;
+    }
+
     space = vfio_get_address_space(as);
 
     QLIST_FOREACH(container, &space->containers, next) {
@@ -1237,6 +1242,10 @@ static void vfio_disconnect_container(VFIOGroup *group)
 {
     VFIOContainer *container = group->container;
 
+    if (container == NULL) {
+        return;
+    }
+
     QLIST_REMOVE(group, container_next);
     group->container = NULL;
 
@@ -1275,6 +1284,86 @@ static void vfio_disconnect_container(VFIOGroup *group)
     }
 }
 
+static int vfio_groupfd_to_groupid(int groupfd)
+{
+    char linkname[PATH_MAX];
+    char pathname[PATH_MAX];
+    char *filename;
+    int groupid, len;
+
+    snprintf(linkname, sizeof(linkname), "/proc/self/fd/%d", groupfd);
+
+    len = readlink(linkname, pathname, sizeof(pathname));
+    if (len <= 0 || len >= sizeof(pathname)) {
+        return -1;
+    }
+    pathname[len] = '\0';
+
+    filename = g_path_get_basename(pathname);
+    groupid = atoi(filename);
+    g_free(filename);
+
+    return groupid;
+}
+
+/*
+ * The @as param could be NULL. In this case, groupfd is shared by
+ * another process which will setup the DMA mapping for this group,
+ * and this group won't have container and address space in QEMU.
+ */
+VFIOGroup *vfio_get_group_from_fd(int groupfd, AddressSpace *as, Error **errp)
+{
+    VFIOGroup *group;
+    int groupid;
+
+    groupid = vfio_groupfd_to_groupid(groupfd);
+    if (groupid < 0) {
+        return NULL;
+    }
+
+    QLIST_FOREACH(group, &vfio_group_list, next) {
+        if (group->groupid == groupid) {
+            /* Found it.  Now is it already in the right context? */
+            if ((group->container == NULL && as == NULL) ||
+                (group->container && group->container->space->as == as)) {
+                    group->refcnt++;
+                    return group;
+            }
+            error_setg(errp, "group %d used in multiple address spaces",
+                       group->groupid);
+            return NULL;
+        }
+    }
+
+    group = g_malloc0(sizeof(*group));
+
+    group->fd = groupfd;
+    group->groupid = groupid;
+    group->refcnt = 1;
+
+    QLIST_INIT(&group->device_list);
+
+    if (vfio_connect_container(group, as, errp)) {
+        error_prepend(errp, "failed to setup container for group %d: ",
+                      groupid);
+        goto free_group_exit;
+    }
+
+    if (QLIST_EMPTY(&vfio_group_list)) {
+        qemu_register_reset(vfio_reset_handler, NULL);
+    }
+
+    QLIST_INSERT_HEAD(&vfio_group_list, group, next);
+
+    return group;
+
+free_group_exit:
+    g_free(group);
+
+    return NULL;
+}
+
+/* The @as param cannot be NULL. */
 VFIOGroup *vfio_get_group(int groupid, AddressSpace *as, Error **errp)
 {
     VFIOGroup *group;
@@ -1284,7 +1373,8 @@ VFIOGroup *vfio_get_group(int groupid, AddressSpace *as, Error **errp)
     QLIST_FOREACH(group, &vfio_group_list, next) {
         if (group->groupid == groupid) {
             /* Found it.  Now is it already in the right context? */
-            if (group->container->space->as == as) {
+            if (group->container && group->container->space->as == as) {
+                group->refcnt++;
                 return group;
             } else {
                 error_setg(errp, "group %d used in multiple address spaces",
@@ -1317,6 +1407,7 @@ VFIOGroup *vfio_get_group(int groupid, AddressSpace *as, Error **errp)
     }
 
     group->groupid = groupid;
+    group->refcnt = 1;
     QLIST_INIT(&group->device_list);
 
     if (vfio_connect_container(group, as, errp)) {
@@ -1348,6 +1439,10 @@ void vfio_put_group(VFIOGroup *group)
         return;
     }
 
+    if (--group->refcnt > 0) {
+        return;
+    }
+
     vfio_kvm_device_del_group(group);
     vfio_disconnect_container(group);
     QLIST_REMOVE(group, next);
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index d9360148e6..b820f7984c 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -137,6 +137,7 @@ struct VFIODeviceOps {
 typedef struct VFIOGroup {
     int fd;
     int groupid;
+    int refcnt;
     VFIOContainer *container;
     QLIST_HEAD(, VFIODevice) device_list;
     QLIST_ENTRY(VFIOGroup) next;
@@ -180,6 +181,7 @@ void vfio_region_exit(VFIORegion *region);
 void vfio_region_finalize(VFIORegion *region);
 void vfio_reset_handler(void *opaque);
 VFIOGroup *vfio_get_group(int groupid, AddressSpace *as, Error **errp);
+VFIOGroup *vfio_get_group_from_fd(int groupfd, AddressSpace *as, Error **errp);
 void vfio_put_group(VFIOGroup *group);
 int vfio_get_device(VFIOGroup *group, const char *name,
                     VFIODevice *vbasedev, Error **errp);
-- 
2.11.0


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

