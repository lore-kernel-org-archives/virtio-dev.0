Return-Path: <virtio-dev-return-13594-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68CB1CA0FE1
	for <virtio-dev@archiver.kernel.org>; Fri,  1 Sep 2023 11:00:40 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 93343C6111
	for <virtio-dev@archiver.kernel.org>; Fri,  1 Sep 2023 11:00:39 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 69BF69865A3
	for <virtio-dev@archiver.kernel.org>; Fri,  1 Sep 2023 11:00:39 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 4D0EA986589; Fri,  1 Sep 2023 11:00:39 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3C44698658C
	for <virtio-dev@lists.oasis-open.org>; Fri,  1 Sep 2023 11:00:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693566037; x=1694170837;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wz9n8fqsI7jiFNwYpSgDyJmxy3p7QY81tAlou+VirwE=;
        b=e9QXdE0SwwrGz79BHjIELhYMYJjpDVVptoU3v3XOjH7l4s4UuZ2shQWhbZiuJipzIb
         o7e/j8AygMA84nBbwoO83PYx7wAHVbR6ELh2056OE8W58e3vsiA9E5/Xccy3klp2+Olm
         PCibe2g29GQU4q2Ww+NZvXES9y1uyPo/H1zHzk2X8FllJxf1+5xNTA7z7diQCT4Q/l1P
         6KxBrzT5InMhWAyhGfFfhVhb6Cf385Mx5eS9yMmiRbykhTdu93KnXZ7KOXs9FLCiGeaX
         v+hVVZmKpixEwtDZx4zvuVEopO+P3gzTyI1Rs3Q3X9NXbETaTXO+OVbHw4QvXGCVqHxp
         vnxg==
X-Gm-Message-State: AOJu0YyjWcxkjvSc92EMEqyMvPNIPMQWokuhM9jgTNOy1YP0nADB8Q58
	4V12UX+IZnhFW1KNTPpnZrLcEw==
X-Google-Smtp-Source: AGHT+IGh/sgWTZUny+y2lH4VfX+G4sFgF/tDfU4lH4e7mn2APqbe4Lk7xUbBwsDPnCU+ed1gsBJDIg==
X-Received: by 2002:a5d:4410:0:b0:317:5ece:e169 with SMTP id z16-20020a5d4410000000b003175ecee169mr1573956wrq.68.1693566037191;
        Fri, 01 Sep 2023 04:00:37 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: slp@redhat.com,
	mst@redhat.com,
	marcandre.lureau@redhat.com,
	stefanha@redhat.com,
	viresh.kumar@linaro.org,
	sgarzare@redhat.com,
	takahiro.akashi@linaro.org,
	erik.schilling@linaro.org,
	manos.pitsidianakis@linaro.org,
	mathieu.poirier@linaro.org
Cc: qemu-devel@nongnu.org,
	virtio-dev@lists.oasis-open.org,
	virtio-comment@lists.oasis-open.org,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri,  1 Sep 2023 12:00:18 +0100
Message-Id: <20230901110018.3704459-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] [RFC PATCH v2] docs/interop: define PROBE feature for vhost-user VirtIO devices

Currently QEMU has to know some details about the VirtIO device
supported by a vhost-user daemon to be able to setup the guest. This
makes it hard for QEMU to add support for additional vhost-user
daemons without adding specific stubs for each additional VirtIO
device.

This patch suggests a new feature flag (VHOST_USER_PROTOCOL_F_PROBE)
which the back-end can advertise which allows a probe message to be
sent to get all the details QEMU needs to know in one message.

Together with the existing features VHOST_USER_PROTOCOL_F_STATUS and
VHOST_USER_PROTOCOL_F_CONFIG we can create "standalone" vhost-user
daemons which are capable of handling all aspects of the VirtIO
transactions with only a generic stub on the QEMU side. These daemons
can also be used without QEMU in situations where there isn't a full
VMM managing their setup.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - dropped F_STANDALONE in favour of F_PROBE
  - split probe details across several messages
  - probe messages don't automatically imply a standalone daemon
  - add wording where probe details interact (F_MQ/F_CONFIG)
  - define VMM and make clear QEMU is only one of many potential VMMs
  - reword commit message
---
 docs/interop/vhost-user.rst | 90 ++++++++++++++++++++++++++++++++-----
 hw/virtio/vhost-user.c      |  8 ++++
 2 files changed, 88 insertions(+), 10 deletions(-)

diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
index 5a070adbc1..ba3b5e07b7 100644
--- a/docs/interop/vhost-user.rst
+++ b/docs/interop/vhost-user.rst
@@ -7,6 +7,7 @@ Vhost-user Protocol
 ..
   Copyright 2014 Virtual Open Systems Sarl.
   Copyright 2019 Intel Corporation
+  Copyright 2023 Linaro Ltd
   Licence: This work is licensed under the terms of the GNU GPL,
            version 2 or later. See the COPYING file in the top-level
            directory.
@@ -27,17 +28,31 @@ The protocol defines 2 sides of the communication, *front-end* and
 *back-end*. The *front-end* is the application that shares its virtqueues, in
 our case QEMU. The *back-end* is the consumer of the virtqueues.
 
-In the current implementation QEMU is the *front-end*, and the *back-end*
-is the external process consuming the virtio queues, for example a
-software Ethernet switch running in user space, such as Snabbswitch,
-or a block device back-end processing read & write to a virtual
-disk. In order to facilitate interoperability between various back-end
-implementations, it is recommended to follow the :ref:`Backend program
-conventions <backend_conventions>`.
+In the current implementation a Virtual Machine Manager (VMM) such as
+QEMU is the *front-end*, and the *back-end* is the external process
+consuming the virtio queues, for example a software Ethernet switch
+running in user space, such as Snabbswitch, or a block device back-end
+processing read & write to a virtual disk. In order to facilitate
+interoperability between various back-end implementations, it is
+recommended to follow the :ref:`Backend program conventions
+<backend_conventions>`.
 
 The *front-end* and *back-end* can be either a client (i.e. connecting) or
 server (listening) in the socket communication.
 
+Probing device details
+----------------------
+
+Traditionally the vhost-user daemon *back-end* shares configuration
+responsibilities with the VMM *front-end* which needs to know certain
+key bits of information about the device. This means the VMM needs to
+define at least a minimal stub for each VirtIO device it wants to
+support. If the daemon supports the right set of protocol features the
+VMM can probe the daemon for the information it needs to setup the
+device. See :ref:`Probing features for standalone daemons
+<probing_features>` for more details.
+
+
 Support for platforms other than Linux
 --------------------------------------
 
@@ -316,6 +331,7 @@ replies. Here is a list of the ones that do:
 * ``VHOST_USER_GET_VRING_BASE``
 * ``VHOST_USER_SET_LOG_BASE`` (if ``VHOST_USER_PROTOCOL_F_LOG_SHMFD``)
 * ``VHOST_USER_GET_INFLIGHT_FD`` (if ``VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD``)
+* ``VHOST_USER_GET_BACKEND_SPECS`` (if ``VHOST_USER_PROTOCOL_F_STANDALONE``)
 
 .. seealso::
 
@@ -396,9 +412,10 @@ must support changing some configuration aspects on the fly.
 Multiple queue support
 ----------------------
 
-Many devices have a fixed number of virtqueues.  In this case the front-end
-already knows the number of available virtqueues without communicating with the
-back-end.
+Many devices have a fixed number of virtqueues. In this case the
+*front-end* usually already knows the number of available virtqueues
+without communicating with the back-end. For standalone daemons this
+number can be can be probed with the ``VHOST_USER_GET_MIN_VQ`` message.
 
 Some devices do not have a fixed number of virtqueues.  Instead the maximum
 number of virtqueues is chosen by the back-end.  The number can depend on host
@@ -885,6 +902,23 @@ Protocol features
   #define VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS  15
   #define VHOST_USER_PROTOCOL_F_STATUS               16
   #define VHOST_USER_PROTOCOL_F_XEN_MMAP             17
+  #define VHOST_USER_PROTOCOL_F_PROBE                18
+
+.. _probing_features:
+
+Probing features for standalone daemons
+---------------------------------------
+
+The protocol feature ``VHOST_USER_PROTOCOL_F_PROBE`` enables a number
+of additional messages which allow the *front-end* to probe details
+about the VirtIO device from the *back-end*. However for a *back-end*
+to be described as standalone it must also support:
+
+  * ``VHOST_USER_PROTOCOL_F_STATUS``
+  * ``VHOST_USER_PROTOCOL_F_CONFIG`` (if there is a config space)
+
+which are required to ensure the *back-end* daemon can operate
+without the *front-end* managing some aspects of its configuration.
 
 Front-end message types
 -----------------------
@@ -1440,6 +1474,42 @@ Front-end message types
   query the back-end for its device status as defined in the Virtio
   specification.
 
+``VHOST_USER_GET_DEVICE_ID``
+  :id: 41
+  :request payload: N/A
+  :reply payload: ``u32``
+
+  When the ``VHOST_USER_PROTOCOL_F_PROBE`` protocol feature has been
+  successfully negotiated, this message is submitted by the front-end
+  to query what VirtIO device the back-end support. This is intended
+  to remove the need for the front-end to know ahead of time what the
+  VirtIO device the backend emulates is.
+
+``VHOST_USER_GET_CONFIG_SIZE``
+  :id: 42
+  :request payload: N/A
+  :reply payload: ``u32``
+
+  When the ``VHOST_USER_PROTOCOL_F_PROBE`` protocol feature has been
+  successfully negotiated, this message is submitted by the front-end
+  to query the size of the VirtIO device's config space. This is
+  intended to remove the need for the front-end to know ahead of time
+  what the size is. Replying with 0 when
+  ``VHOST_USER_PROTOCOL_F_CONFIG`` has been negotiated would indicate
+  an bug.
+
+``VHOST_USER_GET_MIN_VQ``
+  :id: 43
+  :request payload: N/A
+  :reply payload: ``u32``
+
+  When the ``VHOST_USER_PROTOCOL_F_PROBE`` protocol feature has been
+  successfully negotiated, this message is submitted by the front-end to
+  query minimum number of VQ's required to support the device. A
+  device may support more than this number of VQ's if it advertises
+  the ``VHOST_USER_PROTOCOL_F_MQ`` protocol feature. Reporting a
+  number greater than the result of ``VHOST_USER_GET_QUEUE_NUM`` would
+  indicate a bug.
 
 Back-end message types
 ----------------------
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 8dcf049d42..4d433cdf2b 100644
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

