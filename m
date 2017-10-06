Return-Path: virtio-dev-return-2594-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 75E031CB8082
	for <virtio-dev@lists.oasis-open.org>; Fri,  6 Oct 2017 07:24:50 -0700 (PDT)
From: Halil Pasic <pasic@linux.vnet.ibm.com>
References: <1505092240-10864-1-git-send-email-longpeng2@huawei.com>
 <2d8ae3d3-438b-da84-4959-cf63f4f4ce99@linux.vnet.ibm.com>
 <59B9D439.10807@huawei.com>
 <7e490af1-9caa-c96d-5f62-308f1b5d8805@linux.vnet.ibm.com>
 <59BF1E9B.2030408@huawei.com>
Date: Fri, 6 Oct 2017 16:24:32 +0200
MIME-Version: 1.0
In-Reply-To: <59BF1E9B.2030408@huawei.com>
Content-Type: multipart/mixed;
 boundary="------------5B50C45D320FE57F9CCC7C66"
Content-Language: en-US
Message-Id: <64d90f78-a2ae-be37-672b-e47aa3d4ecb2@linux.vnet.ibm.com>
Subject: [virtio-dev] Re: [Qemu-devel] [virtio-dev] Re: [virtio-dev] Re: [RFC 0/8]
 virtio-crypto: add multiplexing mode support
To: "Longpeng (Mike)" <longpeng2@huawei.com>
Cc: weidong.huang@huawei.com, mst@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org, john.griffin@intel.com, Varun.Sethi@freescale.com, denglingli@chinamobile.com, arei.gonglei@hotmail.com, virtio-dev@lists.oasis-open.org, agraf@suse.de, arei.gonglei@huawei.com, vincent.jardin@6wind.com, Ola.Liljedahl@arm.com, luonengjun@huawei.com, xin.zeng@intel.com, liang.j.ma@intel.com, stefanha@redhat.com, Jani.Kokkonen@huawei.com, brian.a.keating@intel.com, wangxinxin.wang@huawei.com, cohuck@redhat.com, mike.caraman@nxp.com
List-ID: <virtio-dev.lists.oasis-open.org>

--------------5B50C45D320FE57F9CCC7C66
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit



On 09/18/2017 03:17 AM, Longpeng (Mike) wrote:
> 
> 
> On 2017/9/16 1:33, Halil Pasic wrote:
> 
>>
>>
>> On 09/14/2017 02:58 AM, Longpeng (Mike) wrote:
>>>
>>>
>>> On 2017/9/14 2:14, Halil Pasic wrote:
>>>
>>>>
>>>>
>>>> On 09/11/2017 03:10 AM, Longpeng(Mike) wrote:
>>>>> *NOTE*
>>>>> The code realization is based on the latest virtio crypto spec:
>>>>>  [PATCH v19 0/2] virtio-crypto: virtio crypto device specification
>>>>>    https://lists.nongnu.org/archive/html/qemu-devel/2017-08/msg05217.html
>>>>>
>>>>> In session mode, the process of create/close a session
>>>>> makes we have a least one full round-trip cost from guest to host to guest
>>>>> to be able to send any data for symmetric algorithms. It gets ourself into
>>>>> synchronization troubles in some scenarios like a web server handling lots
>>>>> of small requests whose algorithms and keys are different.
>>>>>
>>>>> We can support one-blob request (no sessions) as well for symmetric
>>>>> algorithms, including HASH, MAC services. The benefit is obvious for
>>>>> HASH service because it's usually a one-blob operation.
>>>>>
>>>>
>>>> Hi!
>>>>
>>>> I've just started looking at this. Patch #1 modifies linux/virtio_crypto.h
>>>> which if I compare with the (almost) latest linux master is different. Thus
>>>> I would expect a corresponding kernel patch set too, but I haven't received
>>>> one, nor did I find a reference in the cover letter.
>>>>
>>>> I think if I want to test the new features I need the kernel counter-part
>>>> too, or?
>>>>
>>>> Could you point me to the kernel counterpart?
>>>>
>>>
>>>
>>> Hi Halil,
>>>
>>> We haven't implemented the kernel frontend part yet, but there's a testcase
>>> based on qtest, you can use it.
>>>
>>> Please see the attachment.
>>>
>>
>> Thanks Longpeng! I have two problems with this: first I can't use this on s390x
>> and as you may have noticed I'm working mostly on s390x (that's what I'm payed
>> for). OK, my laptop is amd64 so I was able to try it out, and that leads to the
>> next problem. I can't test before/after and cross version stuff with this. That
>> hurts me because I have a feeling things can be done simpler but that feeling has
>> failed me before, so I tend to try out first and then start a discussion.
>>
>> Is some kernel patch series already in the pipeline? 
>>
> 
> 
> Hi Halil，
> 
> Thank for your comments about the v19 spec first, we'll close look at them recently.
> 
> I'm so sorry that the kernel frontend driver isn't in the pipeline, so maybe you
> can start a x86/tcg VM on your s390x machine or amd64 laptop and then debug this
> feature with the testcase.
> 
> If it's not convenient to you, I'll wrote an experimental version of the kernel
> frontend driver these days. :)
> 

I've managed to do some experiments on my laptop using your testcase. Based
on that, I think the code presented here can be significantly simplified, and
same goes for the spec. I would like to share my experiment with you, and maybe
the rest of the people too, but I'm not sure what is the best way to do it.

I did my experimenting on top of this patch set plus your test. The first thing
I did is to decouple the virtio-crypto.h used by the test from the one used
for the qemu executable. Then the next patch refactors the control queue handling.
 
The basic idea behind the whole thing is that tinging about the requests put
on the virtqueues in terms of just complicates things unnecessarily. 

I could guess I will post the interesting part as a reply to this and the less
interesting part (decoupling) as an attachment. You are supposed to apply first
the attachment then the part after the scissors line.

Of course should you could respin the series preferably with the test
included I can rebase my stuff.

Please let me know about your opinion.

Regards,
Haill


----------------------------------8<-------------------------------------------
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Thu, 5 Oct 2017 20:10:56 +0200
Subject: [PATCH 2/2] wip: refactor ctrl qeue handling

Not meant for inclusion, but as a demonstrator for an alternative
approach of handling/introducing mux mode. The changes to
include/standard-headers/linux/virtio_crypto.h aren't necessary,
but I think making them here is good fro sparking a discussion.
For instance struct virtio_crypto_op_ctrl_req_mux is very weird,
as it does not describe/represent the whole request, but just
a header. The idea is to rewrite the hwole mux handling in this
fashion.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
---
 hw/virtio/virtio-crypto.c                      |   84 +++++++++---------------
 include/standard-headers/linux/virtio_crypto.h |   24 +-------
 2 files changed, 33 insertions(+), 75 deletions(-)

diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
index 69c5ad5..153712d 100644
--- a/hw/virtio/virtio-crypto.c
+++ b/hw/virtio/virtio-crypto.c
@@ -239,11 +239,7 @@ static void virtio_crypto_handle_ctrl(VirtIODevice *vdev, VirtQueue *vq)
     VirtIOCrypto *vcrypto = VIRTIO_CRYPTO(vdev);
     VirtQueueElement *elem;
     struct virtio_crypto_session_input input;
-    struct virtio_crypto_ctrl_header *generic_hdr;
-    union {
-        struct virtio_crypto_op_ctrl_req ctrl;
-        struct virtio_crypto_op_ctrl_req_mux mux_ctrl;
-    } req;
+    struct virtio_crypto_ctrl_header hdr;
 
     struct iovec *in_iov;
     struct iovec *out_iov;
@@ -253,9 +249,10 @@ static void virtio_crypto_handle_ctrl(VirtIODevice *vdev, VirtQueue *vq)
     uint32_t opcode;
     int64_t session_id;
     uint8_t status;
-    size_t s, exp_len;
-    void *sess;
+    size_t s;
 
+#define payload_size(vdev, req) (virtio_crypto_in_mux_mode((vdev)) \
+        ? sizeof((req)) : VIRTIO_CRYPTO_CTRL_REQ_PAYLOAD_SIZE_NONMUX)
     for (;;) {
         elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
         if (!elem) {
@@ -273,47 +270,34 @@ static void virtio_crypto_handle_ctrl(VirtIODevice *vdev, VirtQueue *vq)
         in_num = elem->in_num;
         in_iov = elem->in_sg;
 
-        if (virtio_crypto_in_mux_mode(vdev)) {
-            exp_len = sizeof(req.mux_ctrl);
-            generic_hdr = (struct virtio_crypto_ctrl_header *)(&req.mux_ctrl);
-        } else {
-            exp_len = sizeof(req.ctrl);
-            generic_hdr = (struct virtio_crypto_ctrl_header *)(&req.ctrl);
-        }
-
-        s = iov_to_buf(out_iov, out_num, 0, generic_hdr, exp_len);
-        if (unlikely(s != exp_len)) {
+        s =  sizeof(hdr);
+        iov_to_buf(out_iov, out_num, 0, &hdr, s);
+        if (unlikely(s != iov_discard_front(&out_iov, &out_num, s))) {
             virtio_error(vdev, "virtio-crypto request ctrl_hdr too short");
             virtqueue_detach_element(vq, elem, 0);
             g_free(elem);
             break;
         }
 
-        iov_discard_front(&out_iov, &out_num, exp_len);
-
-        opcode = ldl_le_p(&generic_hdr->opcode);
-        queue_id = ldl_le_p(&generic_hdr->queue_id);
 
+        opcode = ldl_le_p(&hdr.opcode);
+        queue_id = ldl_le_p(&hdr.queue_id);
         switch (opcode) {
         case VIRTIO_CRYPTO_CIPHER_CREATE_SESSION:
-            if (virtio_crypto_in_mux_mode(vdev)) {
-                sess = g_new0(struct virtio_crypto_sym_create_session_req, 1);
-                exp_len = sizeof(struct virtio_crypto_sym_create_session_req);
-                s = iov_to_buf(out_iov, out_num, 0, sess, exp_len);
-                if (unlikely(s != exp_len)) {
-                    virtio_error(vdev, "virtio-crypto request additional "
-                                 "parameters too short");
-                    virtqueue_detach_element(vq, elem, 0);
-                    break;
-                }
-                iov_discard_front(&out_iov, &out_num, exp_len);
-            } else {
-                sess = &req.ctrl.u.sym_create_session;
+        {
+            struct virtio_crypto_sym_create_session_req req;
+            iov_to_buf(out_iov, out_num, 0, &req, sizeof(req));
+            s = payload_size(vdev, req);
+            if (unlikely(s != iov_discard_front(&out_iov, &out_num, s))) {
+                virtio_error(vdev, "virtio-crypto request additional "
+                             "parameters too short");
+                virtqueue_detach_element(vq, elem, 0);
+                break;
             }
 
             memset(&input, 0, sizeof(input));
 
-            session_id = virtio_crypto_create_sym_session(vcrypto, sess,
+            session_id = virtio_crypto_create_sym_session(vcrypto, &req,
                                     queue_id, opcode, out_iov, out_num);
             /* Serious errors, need to reset virtio crypto device */
             if (session_id == -EFAULT) {
@@ -338,27 +322,24 @@ static void virtio_crypto_handle_ctrl(VirtIODevice *vdev, VirtQueue *vq)
             virtqueue_push(vq, elem, sizeof(input));
             virtio_notify(vdev, vq);
             break;
+        }
         case VIRTIO_CRYPTO_CIPHER_DESTROY_SESSION:
         case VIRTIO_CRYPTO_HASH_DESTROY_SESSION:
         case VIRTIO_CRYPTO_MAC_DESTROY_SESSION:
         case VIRTIO_CRYPTO_AEAD_DESTROY_SESSION:
-            if (virtio_crypto_in_mux_mode(vdev)) {
-                sess = g_new0(struct virtio_crypto_destroy_session_req, 1);
-                exp_len = sizeof(struct virtio_crypto_destroy_session_req);
-                s = iov_to_buf(out_iov, out_num, 0, sess, exp_len);
-                if (unlikely(s != exp_len)) {
-                    virtio_error(vdev, "virtio-crypto request additional "
-                                 "parameters too short");
-                    virtqueue_detach_element(vq, elem, 0);
-                    break;
-                }
-                iov_discard_front(&out_iov, &out_num, exp_len);
-            } else {
-                sess = &req.ctrl.u.destroy_session;
+        {
+            struct virtio_crypto_destroy_session_req req;
+            iov_to_buf(out_iov, out_num, 0, &req, sizeof(req));
+            s = payload_size(vdev, req);
+            if (unlikely(s != iov_discard_front(&out_iov, &out_num, s))) {
+                virtio_error(vdev, "virtio-crypto request additional "
+                             "parameters too short");
+                virtqueue_detach_element(vq, elem, 0);
+                break;
             }
 
             status = virtio_crypto_handle_close_session(vcrypto,
-                                                sess, queue_id);
+                                                &req, queue_id);
             /* The status only occupy one byte, we can directly use it */
             s = iov_from_buf(in_iov, in_num, 0, &status, sizeof(status));
             if (unlikely(s != sizeof(status))) {
@@ -369,6 +350,7 @@ static void virtio_crypto_handle_ctrl(VirtIODevice *vdev, VirtQueue *vq)
             virtqueue_push(vq, elem, sizeof(status));
             virtio_notify(vdev, vq);
             break;
+        }
         case VIRTIO_CRYPTO_HASH_CREATE_SESSION:
         case VIRTIO_CRYPTO_MAC_CREATE_SESSION:
         case VIRTIO_CRYPTO_AEAD_CREATE_SESSION:
@@ -388,11 +370,9 @@ static void virtio_crypto_handle_ctrl(VirtIODevice *vdev, VirtQueue *vq)
             break;
         } /* end switch case */
 
-        if (virtio_crypto_in_mux_mode(vdev)) {
-            g_free(sess);
-        }
         g_free(elem);
     } /* end for loop */
+#undef payload_size
 }
 
 static void virtio_crypto_init_request(VirtIOCrypto *vcrypto, VirtQueue *vq,
diff --git a/include/standard-headers/linux/virtio_crypto.h b/include/standard-headers/linux/virtio_crypto.h
index 0ea61b2..7d53c22 100644
--- a/include/standard-headers/linux/virtio_crypto.h
+++ b/include/standard-headers/linux/virtio_crypto.h
@@ -241,29 +241,7 @@ struct virtio_crypto_destroy_session_req {
 	uint8_t padding[48];
 };
 
-/* The request of the control virtqueue's packet for non-MUX mode */
-struct virtio_crypto_op_ctrl_req {
-	struct virtio_crypto_ctrl_header header;
-
-	union {
-		struct virtio_crypto_sym_create_session_req
-			sym_create_session;
-		struct virtio_crypto_hash_create_session_req
-			hash_create_session;
-		struct virtio_crypto_mac_create_session_req
-			mac_create_session;
-		struct virtio_crypto_aead_create_session_req
-			aead_create_session;
-		struct virtio_crypto_destroy_session_req
-			destroy_session;
-		uint8_t padding[56];
-	} u;
-};
-
-/* The request of the control virtqueue's packet for MUX mode */
-struct virtio_crypto_op_ctrl_req_mux {
-	struct virtio_crypto_ctrl_header header;
-};
+#define VIRTIO_CRYPTO_CTRL_REQ_PAYLOAD_SIZE_NONMUX 56
 
 struct virtio_crypto_op_header {
 #define VIRTIO_CRYPTO_CIPHER_ENCRYPT \
-- 
1.7.1



--------------5B50C45D320FE57F9CCC7C66
Content-Type: text/x-patch;
 name="0001-wip-decouple-test-from-implemetation.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="0001-wip-decouple-test-from-implemetation.patch"

=46rom 1dc98c16d97b911cf204f8a9df6bb76a4249dc3b Mon Sep 17 00:00:00 2001
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Thu, 5 Oct 2017 20:14:04 +0200
Subject: [PATCH 1/2] wip: decouple test from implemetation

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
---
 tests/virtio-crypto-test.c |    2 +-
 tests/virtio_crypto.h      |  628 ++++++++++++++++++++++++++++++++++++++=
++++++
 2 files changed, 629 insertions(+), 1 deletions(-)
 create mode 100644 tests/virtio_crypto.h

diff --git a/tests/virtio-crypto-test.c b/tests/virtio-crypto-test.c
index 8825f1f..455b5d4 100644
--- a/tests/virtio-crypto-test.c
+++ b/tests/virtio-crypto-test.c
@@ -25,7 +25,7 @@
 #include "standard-headers/linux/virtio_ids.h"
 #include "standard-headers/linux/virtio_config.h"
 #include "standard-headers/linux/virtio_ring.h"
-#include "standard-headers/linux/virtio_crypto.h"
+#include "virtio_crypto.h"
 #include "standard-headers/linux/virtio_pci.h"
=20
 #define QVIRTIO_CRYPTO_TIMEOUT_US  (30 * 1000 * 1000)
diff --git a/tests/virtio_crypto.h b/tests/virtio_crypto.h
new file mode 100644
index 0000000..0ea61b2
--- /dev/null
+++ b/tests/virtio_crypto.h
@@ -0,0 +1,628 @@
+#ifndef _VIRTIO_CRYPTO_H
+#define _VIRTIO_CRYPTO_H
+/* This header is BSD licensed so anyone can use the definitions to impl=
ement
+ * compatible drivers/servers.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in th=
e
+ *    documentation and/or other materials provided with the distributio=
n.
+ * 3. Neither the name of IBM nor the names of its contributors
+ *    may be used to endorse or promote products derived from this softw=
are
+ *    without specific prior written permission.
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ * ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
+ * FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL IBM OR
+ * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
+ * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
+ * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
+ * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT
+ * OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
+ * SUCH DAMAGE.
+ */
+#include "standard-headers/linux/types.h"
+#include "standard-headers/linux/virtio_types.h"
+#include "standard-headers/linux/virtio_ids.h"
+#include "standard-headers/linux/virtio_config.h"
+
+
+#define VIRTIO_CRYPTO_SERVICE_CIPHER 0
+#define VIRTIO_CRYPTO_SERVICE_HASH   1
+#define VIRTIO_CRYPTO_SERVICE_MAC    2
+#define VIRTIO_CRYPTO_SERVICE_AEAD   3
+
+/* The features for virtio crypto device */
+#define VIRTIO_CRYPTO_F_MUX_MODE	0
+#define VIRTIO_CRYPTO_F_CIPHER_STATELESS_MODE	1
+#define VIRTIO_CRYPTO_F_HASH_STATELESS_MODE	2
+#define VIRTIO_CRYPTO_F_MAC_STATELESS_MODE	3
+#define VIRTIO_CRYPTO_F_AEAD_STATELESS_MODE	4
+
+#define VIRTIO_CRYPTO_OPCODE(service, op)   (((service) << 8) | (op))
+
+struct virtio_crypto_ctrl_header {
+#define VIRTIO_CRYPTO_CIPHER_CREATE_SESSION \
+	   VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_CIPHER, 0x02)
+#define VIRTIO_CRYPTO_CIPHER_DESTROY_SESSION \
+	   VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_CIPHER, 0x03)
+#define VIRTIO_CRYPTO_HASH_CREATE_SESSION \
+	   VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_HASH, 0x02)
+#define VIRTIO_CRYPTO_HASH_DESTROY_SESSION \
+	   VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_HASH, 0x03)
+#define VIRTIO_CRYPTO_MAC_CREATE_SESSION \
+	   VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_MAC, 0x02)
+#define VIRTIO_CRYPTO_MAC_DESTROY_SESSION \
+	   VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_MAC, 0x03)
+#define VIRTIO_CRYPTO_AEAD_CREATE_SESSION \
+	   VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AEAD, 0x02)
+#define VIRTIO_CRYPTO_AEAD_DESTROY_SESSION \
+	   VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AEAD, 0x03)
+	uint32_t opcode;
+	uint32_t algo;
+	uint32_t flag;
+	/* data virtqueue id */
+	uint32_t queue_id;
+};
+
+struct virtio_crypto_cipher_session_para {
+#define VIRTIO_CRYPTO_NO_CIPHER                 0
+#define VIRTIO_CRYPTO_CIPHER_ARC4               1
+#define VIRTIO_CRYPTO_CIPHER_AES_ECB            2
+#define VIRTIO_CRYPTO_CIPHER_AES_CBC            3
+#define VIRTIO_CRYPTO_CIPHER_AES_CTR            4
+#define VIRTIO_CRYPTO_CIPHER_DES_ECB            5
+#define VIRTIO_CRYPTO_CIPHER_DES_CBC            6
+#define VIRTIO_CRYPTO_CIPHER_3DES_ECB           7
+#define VIRTIO_CRYPTO_CIPHER_3DES_CBC           8
+#define VIRTIO_CRYPTO_CIPHER_3DES_CTR           9
+#define VIRTIO_CRYPTO_CIPHER_KASUMI_F8          10
+#define VIRTIO_CRYPTO_CIPHER_SNOW3G_UEA2        11
+#define VIRTIO_CRYPTO_CIPHER_AES_F8             12
+#define VIRTIO_CRYPTO_CIPHER_AES_XTS            13
+#define VIRTIO_CRYPTO_CIPHER_ZUC_EEA3           14
+	uint32_t algo;
+	/* length of key */
+	uint32_t keylen;
+
+#define VIRTIO_CRYPTO_OP_ENCRYPT  1
+#define VIRTIO_CRYPTO_OP_DECRYPT  2
+	/* encrypt or decrypt */
+	uint32_t op;
+	uint32_t padding;
+};
+
+struct virtio_crypto_session_input {
+	/* Device-writable part */
+	uint64_t session_id;
+	uint32_t status;
+	uint32_t padding;
+};
+
+struct virtio_crypto_cipher_session_req {
+	struct virtio_crypto_cipher_session_para para;
+	uint8_t padding[32];
+};
+
+struct virtio_crypto_hash_session_para {
+#define VIRTIO_CRYPTO_NO_HASH            0
+#define VIRTIO_CRYPTO_HASH_MD5           1
+#define VIRTIO_CRYPTO_HASH_SHA1          2
+#define VIRTIO_CRYPTO_HASH_SHA_224       3
+#define VIRTIO_CRYPTO_HASH_SHA_256       4
+#define VIRTIO_CRYPTO_HASH_SHA_384       5
+#define VIRTIO_CRYPTO_HASH_SHA_512       6
+#define VIRTIO_CRYPTO_HASH_SHA3_224      7
+#define VIRTIO_CRYPTO_HASH_SHA3_256      8
+#define VIRTIO_CRYPTO_HASH_SHA3_384      9
+#define VIRTIO_CRYPTO_HASH_SHA3_512      10
+#define VIRTIO_CRYPTO_HASH_SHA3_SHAKE128      11
+#define VIRTIO_CRYPTO_HASH_SHA3_SHAKE256      12
+	uint32_t algo;
+	/* hash result length */
+	uint32_t hash_result_len;
+	uint8_t padding[8];
+};
+
+struct virtio_crypto_hash_create_session_req {
+	struct virtio_crypto_hash_session_para para;
+	uint8_t padding[40];
+};
+
+struct virtio_crypto_mac_session_para {
+#define VIRTIO_CRYPTO_NO_MAC                       0
+#define VIRTIO_CRYPTO_MAC_HMAC_MD5                 1
+#define VIRTIO_CRYPTO_MAC_HMAC_SHA1                2
+#define VIRTIO_CRYPTO_MAC_HMAC_SHA_224             3
+#define VIRTIO_CRYPTO_MAC_HMAC_SHA_256             4
+#define VIRTIO_CRYPTO_MAC_HMAC_SHA_384             5
+#define VIRTIO_CRYPTO_MAC_HMAC_SHA_512             6
+#define VIRTIO_CRYPTO_MAC_CMAC_3DES                25
+#define VIRTIO_CRYPTO_MAC_CMAC_AES                 26
+#define VIRTIO_CRYPTO_MAC_KASUMI_F9                27
+#define VIRTIO_CRYPTO_MAC_SNOW3G_UIA2              28
+#define VIRTIO_CRYPTO_MAC_GMAC_AES                 41
+#define VIRTIO_CRYPTO_MAC_GMAC_TWOFISH             42
+#define VIRTIO_CRYPTO_MAC_CBCMAC_AES               49
+#define VIRTIO_CRYPTO_MAC_CBCMAC_KASUMI_F9         50
+#define VIRTIO_CRYPTO_MAC_XCBC_AES                 53
+	uint32_t algo;
+	/* hash result length */
+	uint32_t hash_result_len;
+	/* length of authenticated key */
+	uint32_t auth_key_len;
+	uint32_t padding;
+};
+
+struct virtio_crypto_mac_create_session_req {
+	struct virtio_crypto_mac_session_para para;
+	uint8_t padding[40];
+};
+
+struct virtio_crypto_aead_session_para {
+#define VIRTIO_CRYPTO_NO_AEAD     0
+#define VIRTIO_CRYPTO_AEAD_GCM    1
+#define VIRTIO_CRYPTO_AEAD_CCM    2
+#define VIRTIO_CRYPTO_AEAD_CHACHA20_POLY1305  3
+	uint32_t algo;
+	/* length of key */
+	uint32_t key_len;
+	/* hash result length */
+	uint32_t hash_result_len;
+	/* length of the additional authenticated data (AAD) in bytes */
+	uint32_t aad_len;
+	/* encrypt or decrypt, See above VIRTIO_CRYPTO_OP_* */
+	uint32_t op;
+	uint32_t padding;
+};
+
+struct virtio_crypto_aead_create_session_req {
+	struct virtio_crypto_aead_session_para para;
+	uint8_t padding[32];
+};
+
+struct virtio_crypto_alg_chain_session_para {
+#define VIRTIO_CRYPTO_SYM_ALG_CHAIN_ORDER_HASH_THEN_CIPHER  1
+#define VIRTIO_CRYPTO_SYM_ALG_CHAIN_ORDER_CIPHER_THEN_HASH  2
+	uint32_t alg_chain_order;
+/* Plain hash */
+#define VIRTIO_CRYPTO_SYM_HASH_MODE_PLAIN    1
+/* Authenticated hash (mac) */
+#define VIRTIO_CRYPTO_SYM_HASH_MODE_AUTH     2
+/* Nested hash */
+#define VIRTIO_CRYPTO_SYM_HASH_MODE_NESTED   3
+	uint32_t hash_mode;
+	struct virtio_crypto_cipher_session_para cipher_param;
+	union {
+		struct virtio_crypto_hash_session_para hash_param;
+		struct virtio_crypto_mac_session_para mac_param;
+		uint8_t padding[16];
+	} u;
+	/* length of the additional authenticated data (AAD) in bytes */
+	uint32_t aad_len;
+	uint32_t padding;
+};
+
+struct virtio_crypto_alg_chain_session_req {
+	struct virtio_crypto_alg_chain_session_para para;
+};
+
+struct virtio_crypto_sym_create_session_req {
+	union {
+		struct virtio_crypto_cipher_session_req cipher;
+		struct virtio_crypto_alg_chain_session_req chain;
+		uint8_t padding[48];
+	} u;
+
+	/* Device-readable part */
+
+/* No operation */
+#define VIRTIO_CRYPTO_SYM_OP_NONE  0
+/* Cipher only operation on the data */
+#define VIRTIO_CRYPTO_SYM_OP_CIPHER  1
+/*
+ * Chain any cipher with any hash or mac operation. The order
+ * depends on the value of alg_chain_order param
+ */
+#define VIRTIO_CRYPTO_SYM_OP_ALGORITHM_CHAINING  2
+	uint32_t op_type;
+	uint32_t padding;
+};
+
+struct virtio_crypto_destroy_session_req {
+	/* Device-readable part */
+	uint64_t  session_id;
+	uint8_t padding[48];
+};
+
+/* The request of the control virtqueue's packet for non-MUX mode */
+struct virtio_crypto_op_ctrl_req {
+	struct virtio_crypto_ctrl_header header;
+
+	union {
+		struct virtio_crypto_sym_create_session_req
+			sym_create_session;
+		struct virtio_crypto_hash_create_session_req
+			hash_create_session;
+		struct virtio_crypto_mac_create_session_req
+			mac_create_session;
+		struct virtio_crypto_aead_create_session_req
+			aead_create_session;
+		struct virtio_crypto_destroy_session_req
+			destroy_session;
+		uint8_t padding[56];
+	} u;
+};
+
+/* The request of the control virtqueue's packet for MUX mode */
+struct virtio_crypto_op_ctrl_req_mux {
+	struct virtio_crypto_ctrl_header header;
+};
+
+struct virtio_crypto_op_header {
+#define VIRTIO_CRYPTO_CIPHER_ENCRYPT \
+	VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_CIPHER, 0x00)
+#define VIRTIO_CRYPTO_CIPHER_DECRYPT \
+	VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_CIPHER, 0x01)
+#define VIRTIO_CRYPTO_HASH \
+	VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_HASH, 0x00)
+#define VIRTIO_CRYPTO_MAC \
+	VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_MAC, 0x00)
+#define VIRTIO_CRYPTO_AEAD_ENCRYPT \
+	VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AEAD, 0x00)
+#define VIRTIO_CRYPTO_AEAD_DECRYPT \
+	VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AEAD, 0x01)
+	uint32_t opcode;
+	/* algo should be service-specific algorithms */
+	uint32_t algo;
+	/* session_id should be service-specific algorithms */
+	uint64_t session_id;
+#define VIRTIO_CRYPTO_FLAG_SESSION_MODE	1
+	/* control flag to control the request */
+	uint32_t flag;
+	uint32_t padding;
+};
+
+struct virtio_crypto_cipher_para {
+	/*
+	 * Byte Length of valid IV/Counter
+	 *
+	 * For block ciphers in CBC or F8 mode, or for Kasumi in F8 mode, or fo=
r
+	 *   SNOW3G in UEA2 mode, this is the length of the IV (which
+	 *   must be the same as the block length of the cipher).
+	 * For block ciphers in CTR mode, this is the length of the counter
+	 *   (which must be the same as the block length of the cipher).
+	 * For AES-XTS, this is the 128bit tweak, i, from IEEE Std 1619-2007.
+	 *
+	 * The IV/Counter will be updated after every partial cryptographic
+	 * operation.
+	 */
+	uint32_t iv_len;
+	/* length of source data */
+	uint32_t src_data_len;
+	/* length of dst data */
+	uint32_t dst_data_len;
+	uint32_t padding;
+};
+
+struct virtio_crypto_hash_para {
+	/* length of source data */
+	uint32_t src_data_len;
+	/* hash result length */
+	uint32_t hash_result_len;
+};
+
+struct virtio_crypto_mac_para {
+	struct virtio_crypto_hash_para hash;
+};
+
+struct virtio_crypto_aead_para {
+	/*
+	 * Byte Length of valid IV data pointed to by the below iv_addr
+	 * parameter.
+	 *
+	 * For GCM mode, this is either 12 (for 96-bit IVs) or 16, in which
+	 *   case iv_addr points to J0.
+	 * For CCM mode, this is the length of the nonce, which can be in the
+	 *   range 7 to 13 inclusive.
+	 */
+	uint32_t iv_len;
+	/* length of additional auth data */
+	uint32_t aad_len;
+	/* length of source data */
+	uint32_t src_data_len;
+	/* length of dst data */
+	uint32_t dst_data_len;
+};
+
+struct virtio_crypto_cipher_data_req {
+	/* Device-readable part */
+	struct virtio_crypto_cipher_para para;
+	uint8_t padding[24];
+};
+
+struct virtio_crypto_hash_data_req {
+	/* Device-readable part */
+	struct virtio_crypto_hash_para para;
+	uint8_t padding[40];
+};
+
+struct virtio_crypto_mac_data_req {
+	/* Device-readable part */
+	struct virtio_crypto_mac_para para;
+	uint8_t padding[40];
+};
+
+struct virtio_crypto_alg_chain_data_para {
+	uint32_t iv_len;
+	/* Length of source data */
+	uint32_t src_data_len;
+	/* Length of destination data */
+	uint32_t dst_data_len;
+	/* Starting point for cipher processing in source data */
+	uint32_t cipher_start_src_offset;
+	/* Length of the source data that the cipher will be computed on */
+	uint32_t len_to_cipher;
+	/* Starting point for hash processing in source data */
+	uint32_t hash_start_src_offset;
+	/* Length of the source data that the hash will be computed on */
+	uint32_t len_to_hash;
+	/* Length of the additional auth data */
+	uint32_t aad_len;
+	/* Length of the hash result */
+	uint32_t hash_result_len;
+	uint32_t reserved;
+};
+
+struct virtio_crypto_alg_chain_data_req {
+	/* Device-readable part */
+	struct virtio_crypto_alg_chain_data_para para;
+};
+
+struct virtio_crypto_sym_data_req {
+	union {
+		struct virtio_crypto_cipher_data_req cipher;
+		struct virtio_crypto_alg_chain_data_req chain;
+		uint8_t padding[40];
+	} u;
+
+	/* See above VIRTIO_CRYPTO_SYM_OP_* */
+	uint32_t op_type;
+	uint32_t padding;
+};
+
+struct virtio_crypto_aead_data_req {
+	/* Device-readable part */
+	struct virtio_crypto_aead_para para;
+	uint8_t padding[32];
+};
+
+/* The request of the data virtqueue's packet for non-MUX mode */
+struct virtio_crypto_op_data_req {
+	struct virtio_crypto_op_header header;
+
+	union {
+		struct virtio_crypto_sym_data_req  sym_req;
+		struct virtio_crypto_hash_data_req hash_req;
+		struct virtio_crypto_mac_data_req mac_req;
+		struct virtio_crypto_aead_data_req aead_req;
+		uint8_t padding[48];
+	} u;
+};
+
+struct virtio_crypto_cipher_para_stateless {
+	struct {
+		/* See VIRTIO_CRYPTO_CIPHER* above */
+		uint32_t algo;
+		/* length of key */
+		uint32_t keylen;
+
+		/* See VIRTIO_CRYPTO_OP_* above */
+		uint32_t op;
+	} sess_para;
+
+	/*
+	 * Byte Length of valid IV/Counter
+	 */
+	uint32_t iv_len;
+	/* length of source data */
+	uint32_t src_data_len;
+	/* length of dst data */
+	uint32_t dst_data_len;
+};
+
+struct virtio_crypto_alg_chain_data_para_stateless {
+	struct {
+		/* See VIRTIO_CRYPTO_SYM_ALG_CHAIN_ORDER_* above */
+		uint32_t alg_chain_order;
+		/* length of the additional authenticated data in bytes */
+		uint32_t aad_len;
+
+		struct {
+			/* See VIRTIO_CRYPTO_CIPHER* above */
+			uint32_t algo;
+			/* length of key */
+			uint32_t keylen;
+			/* See VIRTIO_CRYPTO_OP_* above */
+			uint32_t op;
+		} cipher;
+
+		struct {
+			/* See VIRTIO_CRYPTO_HASH_* or _MAC_* above */
+			uint32_t algo;
+			/* length of authenticated key */
+			uint32_t auth_key_len;
+			/* See VIRTIO_CRYPTO_SYM_HASH_MODE_* above */
+			uint32_t hash_mode;
+		} hash;
+	} sess_para;
+
+	uint32_t iv_len;
+	/* Length of source data */
+	uint32_t src_data_len;
+	/* Length of destination data */
+	uint32_t dst_data_len;
+	/* Starting point for cipher processing in source data */
+	uint32_t cipher_start_src_offset;
+	/* Length of the source data that the cipher will be computed on */
+	uint32_t len_to_cipher;
+	/* Starting point for hash processing in source data */
+	uint32_t hash_start_src_offset;
+	/* Length of the source data that the hash will be computed on */
+	uint32_t len_to_hash;
+	/* Length of the additional auth data */
+	uint32_t aad_len;
+	/* Length of the hash result */
+	uint32_t hash_result_len;
+	uint32_t reserved;
+};
+
+struct virtio_crypto_hash_para_stateless {
+	struct {
+		/* See VIRTIO_CRYPTO_HASH_* above */
+		uint32_t algo;
+	} sess_para;
+
+	/* length of source data */
+	uint32_t src_data_len;
+	/* hash result length */
+	uint32_t hash_result_len;
+	uint32_t reserved;
+};
+
+struct virtio_crypto_mac_para_stateless {
+	struct {
+		/* See VIRTIO_CRYPTO_MAC_* above */
+		uint32_t algo;
+		/* length of authenticated key */
+		uint32_t auth_key_len;
+	} sess_para;
+
+	/* length of source data */
+	uint32_t src_data_len;
+	/* hash result length */
+	uint32_t hash_result_len;
+};
+
+struct virtio_crypto_aead_para_stateless {
+	struct {
+		/* See VIRTIO_CRYPTO_AEAD_* above */
+		uint32_t algo;
+		/* length of key */
+		uint32_t key_len;
+		/* encrypt or decrypt, See above VIRTIO_CRYPTO_OP_* */
+		uint32_t op;
+	} sess_para;
+
+	/*
+	 * Byte Length of valid IV data pointed to by the below iv_addr
+	 * parameter.
+	 */
+	uint32_t iv_len;
+	/* Authentication tag length */
+	uint32_t tag_len;
+	/* length of the additional authenticated data (AAD) in bytes */
+	uint32_t aad_len;
+	/* length of source data */
+	uint32_t src_data_len;
+	/* length of dst data, it should be at least src_data_len + tag_len */
+	uint32_t dst_data_len;
+};
+
+struct virtio_crypto_cipher_data_req_stateless {
+	/* Device-readable part */
+	struct virtio_crypto_cipher_para_stateless para;
+	uint8_t padding[48];
+};
+
+struct virtio_crypto_hash_data_req_stateless {
+	/* Device-readable part */
+	struct virtio_crypto_hash_para_stateless para;
+	uint8_t padding[64];
+};
+
+struct virtio_crypto_mac_data_req_stateless {
+	/* Device-readable part */
+	struct virtio_crypto_mac_para_stateless para;
+	uint8_t padding[64];
+};
+
+struct virtio_crypto_alg_chain_data_req_stateless {
+	/* Device-readable part */
+	struct virtio_crypto_alg_chain_data_para_stateless para;
+};
+
+struct virtio_crypto_sym_data_req_stateless {
+	union {
+		struct virtio_crypto_cipher_data_req_stateless cipher;
+		struct virtio_crypto_alg_chain_data_req_stateless chain;
+		uint8_t padding[72];
+	} u;
+
+	/* See above VIRTIO_CRYPTO_SYM_OP_* */
+	uint32_t op_type;
+	uint32_t padding;
+};
+
+struct virtio_crypto_aead_data_req_stateless {
+	/* Device-readable part */
+	struct virtio_crypto_aead_para_stateless para;
+	uint8_t padding[48];
+};
+
+/* The request of the data virtqueue's packet for MUX mode */
+struct virtio_crypto_op_data_req_mux {
+	struct virtio_crypto_op_header header;
+};
+
+#define VIRTIO_CRYPTO_OK        0
+#define VIRTIO_CRYPTO_ERR       1
+#define VIRTIO_CRYPTO_BADMSG    2
+#define VIRTIO_CRYPTO_NOTSUPP   3
+#define VIRTIO_CRYPTO_INVSESS   4 /* Invalid session id */
+
+/* The accelerator hardware is ready */
+#define VIRTIO_CRYPTO_S_HW_READY  (1 << 0)
+
+struct virtio_crypto_config {
+	/* See VIRTIO_CRYPTO_OP_* above */
+	uint32_t  status;
+
+	/*
+	 * Maximum number of data queue
+	 */
+	uint32_t  max_dataqueues;
+
+	/*
+	 * Specifies the services mask which the device support,
+	 * see VIRTIO_CRYPTO_SERVICE_* above
+	 */
+	uint32_t crypto_services;
+
+	/* Detailed algorithms mask */
+	uint32_t cipher_algo_l;
+	uint32_t cipher_algo_h;
+	uint32_t hash_algo;
+	uint32_t mac_algo_l;
+	uint32_t mac_algo_h;
+	uint32_t aead_algo;
+	/* Maximum length of cipher key */
+	uint32_t max_cipher_key_len;
+	/* Maximum length of authenticated key */
+	uint32_t max_auth_key_len;
+	uint32_t reserve;
+	/* Maximum size of each crypto request's content */
+	uint64_t max_size;
+};
+
+struct virtio_crypto_inhdr {
+	/* See VIRTIO_CRYPTO_* above */
+	uint8_t status;
+};
+#endif
--=20
1.7.1



--------------5B50C45D320FE57F9CCC7C66
Content-Type: text/plain; charset=us-ascii


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
--------------5B50C45D320FE57F9CCC7C66--

