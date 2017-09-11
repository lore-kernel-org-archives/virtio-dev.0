Return-Path: virtio-dev-return-2530-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id C9E8E581815E
	for <virtio-dev@lists.oasis-open.org>; Sun, 10 Sep 2017 18:14:42 -0700 (PDT)
From: "Longpeng(Mike)" <longpeng2@huawei.com>
Date: Mon, 11 Sep 2017 09:10:33 +0800
Message-ID: <1505092240-10864-2-git-send-email-longpeng2@huawei.com>
In-Reply-To: <1505092240-10864-1-git-send-email-longpeng2@huawei.com>
References: <1505092240-10864-1-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [virtio-dev] [RFC 1/8] virtio-crypto: add new definations for multiplexing mode
To: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org
Cc: luonengjun@huawei.com, mst@redhat.com, cohuck@redhat.com, stefanha@redhat.com, denglingli@chinamobile.com, Jani.Kokkonen@huawei.com, Ola.Liljedahl@arm.com, Varun.Sethi@freescale.com, xin.zeng@intel.com, brian.a.keating@intel.com, liang.j.ma@intel.com, john.griffin@intel.com, weidong.huang@huawei.com, mike.caraman@nxp.com, agraf@suse.de, jasowang@redhat.com, vincent.jardin@6wind.com, arei.gonglei@hotmail.com, pasic@linux.vnet.ibm.com, wangxinxin.wang@huawei.com, arei.gonglei@huawei.com, "Longpeng(Mike)" <longpeng2@huawei.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Adds the defination of the control/operation header for
multiplexing mode.

Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
---
 include/standard-headers/linux/virtio_crypto.h | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/include/standard-headers/linux/virtio_crypto.h b/include/standard-headers/linux/virtio_crypto.h
index 5ff0b4e..987fb1e 100755
--- a/include/standard-headers/linux/virtio_crypto.h
+++ b/include/standard-headers/linux/virtio_crypto.h
@@ -38,6 +38,13 @@
 #define VIRTIO_CRYPTO_SERVICE_MAC    2
 #define VIRTIO_CRYPTO_SERVICE_AEAD   3
 
+/* The features for virtio crypto device */
+#define VIRTIO_CRYPTO_F_MUX_MODE	0
+#define VIRTIO_CRYPTO_F_CIPHER_STATELESS_MODE	1
+#define VIRTIO_CRYPTO_F_HASH_STATELESS_MODE	2
+#define VIRTIO_CRYPTO_F_MAC_STATELESS_MODE	3
+#define VIRTIO_CRYPTO_F_AEAD_STATELESS_MODE	4
+
 #define VIRTIO_CRYPTO_OPCODE(service, op)   (((service) << 8) | (op))
 
 struct virtio_crypto_ctrl_header {
@@ -234,7 +241,7 @@ struct virtio_crypto_destroy_session_req {
 	uint8_t padding[48];
 };
 
-/* The request of the control virtqueue's packet */
+/* The request of the control virtqueue's packet for non-MUX mode */
 struct virtio_crypto_op_ctrl_req {
 	struct virtio_crypto_ctrl_header header;
 
@@ -253,6 +260,11 @@ struct virtio_crypto_op_ctrl_req {
 	} u;
 };
 
+/* The request of the control virtqueue's packet for MUX mode */
+struct virtio_crypto_op_ctrl_req_mux {
+	struct virtio_crypto_ctrl_header header;
+};
+
 struct virtio_crypto_op_header {
 #define VIRTIO_CRYPTO_CIPHER_ENCRYPT \
 	VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_CIPHER, 0x00)
@@ -390,7 +402,7 @@ struct virtio_crypto_aead_data_req {
 	uint8_t padding[32];
 };
 
-/* The request of the data virtqueue's packet */
+/* The request of the data virtqueue's packet for non-MUX mode */
 struct virtio_crypto_op_data_req {
 	struct virtio_crypto_op_header header;
 
@@ -403,6 +415,11 @@ struct virtio_crypto_op_data_req {
 	} u;
 };
 
+/* The request of the data virtqueue's packet for MUX mode */
+struct virtio_crypto_op_data_req_mux {
+	struct virtio_crypto_op_header header;
+};
+
 #define VIRTIO_CRYPTO_OK        0
 #define VIRTIO_CRYPTO_ERR       1
 #define VIRTIO_CRYPTO_BADMSG    2
-- 
1.8.3.1



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

