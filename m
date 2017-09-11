Return-Path: virtio-dev-return-2524-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 858D258190CA
	for <virtio-dev@lists.oasis-open.org>; Sun, 10 Sep 2017 18:11:30 -0700 (PDT)
From: "Longpeng(Mike)" <longpeng2@huawei.com>
Date: Mon, 11 Sep 2017 09:10:40 +0800
Message-ID: <1505092240-10864-9-git-send-email-longpeng2@huawei.com>
In-Reply-To: <1505092240-10864-1-git-send-email-longpeng2@huawei.com>
References: <1505092240-10864-1-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [virtio-dev] [RFC 8/8] virtio-crypto: add host feature bits support
To: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org
Cc: luonengjun@huawei.com, mst@redhat.com, cohuck@redhat.com, stefanha@redhat.com, denglingli@chinamobile.com, Jani.Kokkonen@huawei.com, Ola.Liljedahl@arm.com, Varun.Sethi@freescale.com, xin.zeng@intel.com, brian.a.keating@intel.com, liang.j.ma@intel.com, john.griffin@intel.com, weidong.huang@huawei.com, mike.caraman@nxp.com, agraf@suse.de, jasowang@redhat.com, vincent.jardin@6wind.com, arei.gonglei@hotmail.com, pasic@linux.vnet.ibm.com, wangxinxin.wang@huawei.com, arei.gonglei@huawei.com
List-ID: <virtio-dev.lists.oasis-open.org>

From: Gonglei <arei.gonglei@huawei.com>

We enable all feature bits acquiescently.

Signed-off-by: Gonglei <arei.gonglei@huawei.com>
---
 hw/virtio/virtio-crypto.c         | 15 +++++++++++++++
 include/hw/virtio/virtio-crypto.h |  1 +
 2 files changed, 16 insertions(+)

diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
index d58ffba..69c5ad5 100755
--- a/hw/virtio/virtio-crypto.c
+++ b/hw/virtio/virtio-crypto.c
@@ -1095,6 +1095,11 @@ static uint64_t virtio_crypto_get_features(VirtIODevice *vdev,
                                            uint64_t features,
                                            Error **errp)
 {
+    VirtIOCrypto *vcrypto = VIRTIO_CRYPTO(vdev);
+
+    /* Firstly sync all virtio-crypto possible supported features */
+    features |= vcrypto->host_features;
+
     return features;
 }
 
@@ -1210,6 +1215,16 @@ static const VMStateDescription vmstate_virtio_crypto = {
 };
 
 static Property virtio_crypto_properties[] = {
+    DEFINE_PROP_BIT("mux_mode", VirtIOCrypto, host_features,
+                    VIRTIO_CRYPTO_F_MUX_MODE, true),
+    DEFINE_PROP_BIT("cipher_stateless_mode", VirtIOCrypto, host_features,
+                    VIRTIO_CRYPTO_F_CIPHER_STATELESS_MODE, true),
+    DEFINE_PROP_BIT("hash_stateless_mode", VirtIOCrypto, host_features,
+                    VIRTIO_CRYPTO_F_HASH_STATELESS_MODE, true),
+    DEFINE_PROP_BIT("mac_stateless_mode", VirtIOCrypto, host_features,
+                    VIRTIO_CRYPTO_F_MAC_STATELESS_MODE, true),
+    DEFINE_PROP_BIT("aead_stateless_mode", VirtIOCrypto, host_features,
+                    VIRTIO_CRYPTO_F_AEAD_STATELESS_MODE, true),
     DEFINE_PROP_LINK("cryptodev", VirtIOCrypto, conf.cryptodev,
                      TYPE_CRYPTODEV_BACKEND, CryptoDevBackend *),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/include/hw/virtio/virtio-crypto.h b/include/hw/virtio/virtio-crypto.h
index 465ad20..30ea51d 100755
--- a/include/hw/virtio/virtio-crypto.h
+++ b/include/hw/virtio/virtio-crypto.h
@@ -97,6 +97,7 @@ typedef struct VirtIOCrypto {
     int multiqueue;
     uint32_t curr_queues;
     size_t config_size;
+    uint32_t host_features;
 } VirtIOCrypto;
 
 #endif /* _QEMU_VIRTIO_CRYPTO_H */
-- 
1.8.3.1



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

