Return-Path: virtio-dev-return-4152-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 157DB1CB80F0
	for <virtio-dev@lists.oasis-open.org>; Thu, 24 May 2018 03:33:35 -0700 (PDT)
From: Tiwei Bie <tiwei.bie@intel.com>
Date: Thu, 24 May 2018 18:33:32 +0800
Message-Id: <20180524103336.21233-3-tiwei.bie@intel.com>
In-Reply-To: <20180524103336.21233-1-tiwei.bie@intel.com>
References: <20180524103336.21233-1-tiwei.bie@intel.com>
Subject: [virtio-dev] [PATCH 2/6] vhost-user: allow slave to send fds via slave channel
To: mst@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org
Cc: tiwei.bie@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

Introduce VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD protocol
feature to allow slave to send at most 8 descriptors
in each message to master via ancillary data using the
slave channel.

Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
---
 docs/interop/vhost-user.txt |  5 +++++
 hw/virtio/vhost-user.c      | 27 +++++++++++++++++----------
 2 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/docs/interop/vhost-user.txt b/docs/interop/vhost-user.txt
index 534caab18a..682a683eb4 100644
--- a/docs/interop/vhost-user.txt
+++ b/docs/interop/vhost-user.txt
@@ -367,6 +367,10 @@ The fd is provided via VHOST_USER_SET_SLAVE_REQ_FD ancillary data.
 A slave may then send VHOST_USER_SLAVE_* messages to the master
 using this fd communication channel.
 
+If VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD protocol feature is negotiated,
+slave can send file descriptors (at most 8 descriptors in each message)
+to master via ancillary data using this fd communication channel.
+
 Protocol features
 -----------------
 
@@ -380,6 +384,7 @@ Protocol features
 #define VHOST_USER_PROTOCOL_F_CRYPTO_SESSION 7
 #define VHOST_USER_PROTOCOL_F_PAGEFAULT      8
 #define VHOST_USER_PROTOCOL_F_CONFIG         9
+#define VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD  10
 
 Master message types
 --------------------
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index da0756effe..75a3faef2a 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -30,6 +30,7 @@
 
 #define VHOST_MEMORY_MAX_NREGIONS    8
 #define VHOST_USER_F_PROTOCOL_FEATURES 30
+#define VHOST_USER_SLAVE_MAX_FDS     8
 
 /*
  * Maximum size of virtio device config space
@@ -47,6 +48,7 @@ enum VhostUserProtocolFeature {
     VHOST_USER_PROTOCOL_F_CRYPTO_SESSION = 7,
     VHOST_USER_PROTOCOL_F_PAGEFAULT = 8,
     VHOST_USER_PROTOCOL_F_CONFIG = 9,
+    VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD = 10,
     VHOST_USER_PROTOCOL_F_MAX
 };
 
@@ -854,10 +856,10 @@ static void slave_read(void *opaque)
     int size, ret = 0;
     struct iovec iov;
     struct msghdr msgh;
-    int fd = -1;
+    int fd[VHOST_USER_SLAVE_MAX_FDS];
     char control[CMSG_SPACE(sizeof(fd))];
     struct cmsghdr *cmsg;
-    size_t fdsize;
+    int i, fdsize = 0;
 
     memset(&msgh, 0, sizeof(msgh));
     msgh.msg_iov = &iov;
@@ -865,6 +867,8 @@ static void slave_read(void *opaque)
     msgh.msg_control = control;
     msgh.msg_controllen = sizeof(control);
 
+    memset(fd, -1, sizeof(fd));
+
     /* Read header */
     iov.iov_base = &hdr;
     iov.iov_len = VHOST_USER_HDR_SIZE;
@@ -885,7 +889,7 @@ static void slave_read(void *opaque)
             if (cmsg->cmsg_level == SOL_SOCKET &&
                 cmsg->cmsg_type == SCM_RIGHTS) {
                     fdsize = cmsg->cmsg_len - CMSG_LEN(0);
-                    memcpy(&fd, CMSG_DATA(cmsg), fdsize);
+                    memcpy(fd, CMSG_DATA(cmsg), fdsize);
                     break;
             }
     }
@@ -913,14 +917,15 @@ static void slave_read(void *opaque)
         break;
     default:
         error_report("Received unexpected msg type.");
-        if (fd != -1) {
-            close(fd);
-        }
         ret = -EINVAL;
     }
 
-    /* Message handlers need to make sure that fd will be consumed. */
-    fd = -1;
+    /* Close the remaining file descriptors. */
+    for (i = 0; i < fdsize; i++) {
+        if (fd[i] != -1) {
+            close(fd[i]);
+        }
+    }
 
     /*
      * REPLY_ACK feature handling. Other reply types has to be managed
@@ -954,8 +959,10 @@ err:
     qemu_set_fd_handler(u->slave_fd, NULL, NULL, NULL);
     close(u->slave_fd);
     u->slave_fd = -1;
-    if (fd != -1) {
-        close(fd);
+    for (i = 0; i < fdsize; i++) {
+        if (fd[i] != -1) {
+            close(fd[i]);
+        }
     }
     return;
 }
-- 
2.17.0


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

