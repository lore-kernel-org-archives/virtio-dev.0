Return-Path: virtio-dev-return-2520-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 7E77658190D2
	for <virtio-dev@lists.oasis-open.org>; Sun, 10 Sep 2017 18:11:27 -0700 (PDT)
From: "Longpeng(Mike)" <longpeng2@huawei.com>
Date: Mon, 11 Sep 2017 09:10:36 +0800
Message-ID: <1505092240-10864-5-git-send-email-longpeng2@huawei.com>
In-Reply-To: <1505092240-10864-1-git-send-email-longpeng2@huawei.com>
References: <1505092240-10864-1-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [virtio-dev] [RFC 4/8] cryptodev: add stateless mode cipher support
To: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org
Cc: luonengjun@huawei.com, mst@redhat.com, cohuck@redhat.com, stefanha@redhat.com, denglingli@chinamobile.com, Jani.Kokkonen@huawei.com, Ola.Liljedahl@arm.com, Varun.Sethi@freescale.com, xin.zeng@intel.com, brian.a.keating@intel.com, liang.j.ma@intel.com, john.griffin@intel.com, weidong.huang@huawei.com, mike.caraman@nxp.com, agraf@suse.de, jasowang@redhat.com, vincent.jardin@6wind.com, arei.gonglei@hotmail.com, pasic@linux.vnet.ibm.com, wangxinxin.wang@huawei.com, arei.gonglei@huawei.com, "Longpeng(Mike)" <longpeng2@huawei.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Adds stateless mode cipher support.

Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
---
 backends/cryptodev.c              | 21 +++++++++++++++++++++
 include/hw/virtio/virtio-crypto.h |  1 +
 include/sysemu/cryptodev.h        | 18 ++++++++++++++++++
 3 files changed, 40 insertions(+)

diff --git a/backends/cryptodev.c b/backends/cryptodev.c
index 1764c17..a76a312 100755
--- a/backends/cryptodev.c
+++ b/backends/cryptodev.c
@@ -120,6 +120,21 @@ static int cryptodev_backend_sym_operation(
     return -VIRTIO_CRYPTO_ERR;
 }
 
+static int cryptodev_backend_sym_stateless_operation(
+                 CryptoDevBackend *backend,
+                 CryptoDevBackendSymStatelessInfo *op_info,
+                 uint32_t queue_index, Error **errp)
+{
+    CryptoDevBackendClass *bc =
+                      CRYPTODEV_BACKEND_GET_CLASS(backend);
+
+    if (bc->do_sym_stateless_op) {
+        return bc->do_sym_stateless_op(backend, op_info, queue_index, errp);
+    }
+
+    return -VIRTIO_CRYPTO_ERR;
+}
+
 int cryptodev_backend_crypto_operation(
                  CryptoDevBackend *backend,
                  void *opaque,
@@ -133,6 +148,12 @@ int cryptodev_backend_crypto_operation(
 
         return cryptodev_backend_sym_operation(backend,
                          op_info, queue_index, errp);
+    } else if (req->flags == CRYPTODEV_BACKEND_ALG_SYM_STATELESS) {
+        CryptoDevBackendSymStatelessInfo *op_info;
+        op_info = req->u.sym_stateless_info;
+
+        return cryptodev_backend_sym_stateless_operation(backend,
+                         op_info, queue_index, errp);
     } else {
         error_setg(errp, "Unsupported cryptodev alg type: %" PRIu32 "",
                    req->flags);
diff --git a/include/hw/virtio/virtio-crypto.h b/include/hw/virtio/virtio-crypto.h
index a00a0bf..465ad20 100755
--- a/include/hw/virtio/virtio-crypto.h
+++ b/include/hw/virtio/virtio-crypto.h
@@ -73,6 +73,7 @@ typedef struct VirtIOCryptoReq {
     struct VirtIOCrypto *vcrypto;
     union {
         CryptoDevBackendSymOpInfo *sym_op_info;
+        CryptoDevBackendSymStatelessInfo *sym_stateless_info;
     } u;
 } VirtIOCryptoReq;
 
diff --git a/include/sysemu/cryptodev.h b/include/sysemu/cryptodev.h
index a9d0d1e..aa2fcd8 100755
--- a/include/sysemu/cryptodev.h
+++ b/include/sysemu/cryptodev.h
@@ -58,6 +58,7 @@ typedef struct CryptoDevBackend CryptoDevBackend;
 
 enum CryptoDevBackendAlgType {
     CRYPTODEV_BACKEND_ALG_SYM,
+    CRYPTODEV_BACKEND_ALG_SYM_STATELESS,
     CRYPTODEV_BACKEND_ALG__MAX,
 };
 
@@ -146,6 +147,20 @@ typedef struct CryptoDevBackendSymOpInfo {
     uint8_t data[0];
 } CryptoDevBackendSymOpInfo;
 
+/**
+ * CryptoDevBackendSymStatelessInfo:
+ *
+ * @session_info: session information, see above
+ *  CryptoDevBackendSymSessionInfo
+ * @op_info: crypto operation information, see above
+ *  CryptoDevBackendSymOpInfo, @session_id is ignored
+ *
+ **/
+typedef struct CryptoDevBackendSymStatelessInfo {
+    CryptoDevBackendSymSessionInfo session_info;
+    CryptoDevBackendSymOpInfo op_info;
+} CryptoDevBackendSymStatelessInfo;
+
 typedef struct CryptoDevBackendClass {
     ObjectClass parent_class;
 
@@ -161,6 +176,9 @@ typedef struct CryptoDevBackendClass {
     int (*do_sym_op)(CryptoDevBackend *backend,
                      CryptoDevBackendSymOpInfo *op_info,
                      uint32_t queue_index, Error **errp);
+    int (*do_sym_stateless_op)(CryptoDevBackend *backend,
+                     CryptoDevBackendSymStatelessInfo *op_info,
+                     uint32_t queue_index, Error **errp);
 } CryptoDevBackendClass;
 
 
-- 
1.8.3.1



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

