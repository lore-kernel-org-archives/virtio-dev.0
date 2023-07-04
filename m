Return-Path: <virtio-dev-return-13213-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84502EB64D9
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Jul 2023 12:36:40 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 9C5F9190907
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Jul 2023 12:36:39 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7E7039865F6
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Jul 2023 12:36:39 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 5DCFA986593; Tue,  4 Jul 2023 12:36:39 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 49C88986595
	for <virtio-dev@lists.oasis-open.org>; Tue,  4 Jul 2023 12:36:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688474197; x=1691066197;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sdqM9qea1gluYMtuxISIShwJNmf3aOXgi8u2chJ8Mqc=;
        b=aaBy51qK8XbW7Wi3tbTEnadnAmQ8fAIokeOefexm+d/O9k3Jyz8+aTsssdCWNSAZY7
         O8h5Oiks3qpdhugdRFWVnBKhnp06nJ7vEzMOiEZRk9D5hqknsMSZ03LUUucewpFM5mvU
         0x1T2SfPUn49xXMtPuMUz+BEUoUO75ntER0UJAN/KNE3yE/P33wtrfyVrf4Du/MQRIbp
         qQJTsYGmivgCP8g0w+P+RfSqv7/7D9s0FOEgwDYzH+Fu9eptDdAwAHfLthi6W71999V6
         D6+AW4SlZYVWAUVHrkbqgx5It+P60sOlR/AKR6uqpVShTIRxxIYLpBNBUkpt/1xb62Xm
         XsvQ==
X-Gm-Message-State: ABy/qLboJuza4LRowG0xW0FWkpvzCHSKMVnEYjOs62eRtVNKxO5p0MWC
	ASDXONEQmkRto77giLgQnkWGYg==
X-Google-Smtp-Source: APBJJlF5bvL3gi1v3zWPv3B1bXUa9h+fhIfUgkdWSqdKmBeq2DBxu2CN6lTXrui4wd13YhXvQxqojQ==
X-Received: by 2002:a5d:670a:0:b0:313:eadf:b82d with SMTP id o10-20020a5d670a000000b00313eadfb82dmr9395725wru.69.1688474197450;
        Tue, 04 Jul 2023 05:36:37 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: virtio-dev@lists.oasis-open.org,
	slp@redhat.com,
	mst@redhat.com,
	marcandre.lureau@redhat.com,
	stefanha@redhat.com,
	viresh.kumar@linaro.org,
	sgarzare@redhat.com,
	takahiro.akashi@linaro.org,
	erik.schilling@linaro.org,
	manos.pitsidianakis@linaro.org,
	mathieu.poirier@linaro.org,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue,  4 Jul 2023 13:36:00 +0100
Message-Id: <20230704123600.1808604-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] [RFC PATCH] docs/interop: define STANDALONE protocol feature for vhost-user

Currently QEMU has to know some details about the back-end to be able
to setup the guest. While various parts of the setup can be delegated
to the backend (for example config handling) this is a very piecemeal
approach.

This patch suggests a new feature flag (VHOST_USER_PROTOCOL_F_STANDALONE)
which the back-end can advertise which allows a probe message to be
sent to get all the details QEMU needs to know in one message.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
Initial RFC for discussion. I intend to prototype this work with QEMU
and one of the rust-vmm vhost-user daemons.
---
 docs/interop/vhost-user.rst | 37 +++++++++++++++++++++++++++++++++++++
 hw/virtio/vhost-user.c      |  8 ++++++++
 2 files changed, 45 insertions(+)

diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
index 5a070adbc1..85b1b1583a 100644
--- a/docs/interop/vhost-user.rst
+++ b/docs/interop/vhost-user.rst
@@ -275,6 +275,21 @@ Inflight description
 
 :queue size: a 16-bit size of virtqueues
 
+Backend specifications
+^^^^^^^^^^^^^^^^^^^^^^
+
++-----------+-------------+------------+------------+
+| device id | config size |   min_vqs  |   max_vqs  |
++-----------+-------------+------------+------------+
+
+:device id: a 32-bit value holding the VirtIO device ID
+
+:config size: a 32-bit value holding the config size (see ``VHOST_USER_GET_CONFIG``)
+
+:min_vqs: a 32-bit value holding the minimum number of vqs supported
+
+:max_vqs: a 32-bit value holding the maximum number of vqs supported, must be >= min_vqs
+
 C structure
 -----------
 
@@ -296,6 +311,7 @@ In QEMU the vhost-user message is implemented with the following struct:
           VhostUserConfig config;
           VhostUserVringArea area;
           VhostUserInflight inflight;
+          VhostUserBackendSpecs specs;
       };
   } QEMU_PACKED VhostUserMsg;
 
@@ -316,6 +332,7 @@ replies. Here is a list of the ones that do:
 * ``VHOST_USER_GET_VRING_BASE``
 * ``VHOST_USER_SET_LOG_BASE`` (if ``VHOST_USER_PROTOCOL_F_LOG_SHMFD``)
 * ``VHOST_USER_GET_INFLIGHT_FD`` (if ``VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD``)
+* ``VHOST_USER_GET_BACKEND_SPECS`` (if ``VHOST_USER_PROTOCOL_F_STANDALONE``)
 
 .. seealso::
 
@@ -885,6 +902,13 @@ Protocol features
   #define VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS  15
   #define VHOST_USER_PROTOCOL_F_STATUS               16
   #define VHOST_USER_PROTOCOL_F_XEN_MMAP             17
+  #define VHOST_USER_PROTOCOL_F_STANDALONE           18
+
+Some features are only valid in the presence of other supporting
+features. In the case of ``VHOST_USER_PROTOCOL_F_STANDALONE`` the
+backend must also support ``VHOST_USER_PROTOCOL_F_CONFIG`` and
+``VHOST_USER_PROTOCOL_F_STATUS``.
+
 
 Front-end message types
 -----------------------
@@ -1440,6 +1464,19 @@ Front-end message types
   query the back-end for its device status as defined in the Virtio
   specification.
 
+``VHOST_USER_GET_BACKEND_SPECS``
+  :id: 41
+  :request payload: N/A
+  :reply payload: ``Backend specifications``
+
+  When the ``VHOST_USER_PROTOCOL_F_STANDALONE`` protocol feature has been
+  successfully negotiated, this message is submitted by the front-end to
+  query the back-end for its capabilities. This is intended to remove
+  the need for the front-end to know ahead of time what the VirtIO
+  device the backend emulates is.
+
+  The reply contains the device id, size of the config space and the
+  range of VirtQueues the backend supports.
 
 Back-end message types
 ----------------------
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index c4e0cbd702..28b021d5d3 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -202,6 +202,13 @@ typedef struct VhostUserInflight {
     uint16_t queue_size;
 } VhostUserInflight;
 
+typedef struct VhostUserBackendSpecs {
+    uint32_t device_id;
+    uint32_t config_size;
+    uint32_t min_vqs;
+    uint32_t max_vqs;
+} VhostUserBackendSpecs;
+
 typedef struct {
     VhostUserRequest request;
 
@@ -226,6 +233,7 @@ typedef union {
         VhostUserCryptoSession session;
         VhostUserVringArea area;
         VhostUserInflight inflight;
+        VhostUserBackendSpecs specs;
 } VhostUserPayload;
 
 typedef struct VhostUserMsg {
-- 
2.39.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

