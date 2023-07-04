Return-Path: <virtio-dev-return-13215-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DBF1EB64D9
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Jul 2023 14:55:08 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 6E53042827
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Jul 2023 14:55:07 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 49B64986637
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Jul 2023 14:55:07 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 2E5B1986597; Tue,  4 Jul 2023 14:55:07 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1AB54986599
	for <virtio-dev@lists.oasis-open.org>; Tue,  4 Jul 2023 14:55:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: LX9AGaDfPFWw_wTRtvuG5g-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688482502; x=1691074502;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EmGEvptwJkM6UoX38+QPWD8ud5IKVgmApDNdi1W8v9U=;
        b=AcyAwFDmicftXY2XpwA4ezDgE8GI92glSPZ2rYLATutopmH8ejMoE/r4HRT8Ui7FlJ
         1a7jNDTDd8YVjgDe/0Smk4OQxt7zuInBskmNsQ0zb7u4LXYb8ZWK1v5rAPPT78xw9eCg
         loVnuwU6/nTtuhUblEZMHp3w264eSub7cGiZYUWULDc7PmjI/sV/QV5qEuSHuKLmHbMP
         PyS9r+cogyDY01sFnzEPs3/TXPB5uw6rBDm7qk7kqkqSKxMEEVMRzAo5I+iVh4SL5gFs
         D/7QR0e+G4KY7FCdWiuN5tkGqHYOiaQ+vAxK4GUUL/mnBspEgLhmisIlyKilfPXGZHJ4
         JEFg==
X-Gm-Message-State: ABy/qLYBUStR5rq1SgrAjPWdp2EnAtrUynS/tcckKHI0VsFOyx/5q5lu
	qPfeSVVboae9g6rLfshsRKiaLjhnrODj70hpfiqeZI6sK/8K4ZvKgX0RxFApfqwl0GvxHhQQ4fa
	H2UAXykssyaGZHGlX0t6G06YNFmNc
X-Received: by 2002:a0c:e64b:0:b0:62d:fd45:4d6a with SMTP id c11-20020a0ce64b000000b0062dfd454d6amr9018595qvn.16.1688482502418;
        Tue, 04 Jul 2023 07:55:02 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFcv7mXEP+P8uaHnGHMCyY2IQQ38jVnHxCx+dZMs0x/sr0mlEtHosc5lhtn+CK3mNkoMl7mrg==
X-Received: by 2002:a0c:e64b:0:b0:62d:fd45:4d6a with SMTP id c11-20020a0ce64b000000b0062dfd454d6amr9018582qvn.16.1688482502175;
        Tue, 04 Jul 2023 07:55:02 -0700 (PDT)
Date: Tue, 4 Jul 2023 16:54:53 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, slp@redhat.com, 
	mst@redhat.com, marcandre.lureau@redhat.com, stefanha@redhat.com, 
	viresh.kumar@linaro.org, takahiro.akashi@linaro.org, erik.schilling@linaro.org, 
	manos.pitsidianakis@linaro.org, mathieu.poirier@linaro.org
Message-ID: <3ogh7u3ezp7vlrp3ticquoajgsnpnglplm44osrsd7gvxv2lyn@g22qgf4vwgp5>
References: <20230704123600.1808604-1-alex.bennee@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20230704123600.1808604-1-alex.bennee@linaro.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: Re: [virtio-dev] [RFC PATCH] docs/interop: define STANDALONE
 protocol feature for vhost-user

On Tue, Jul 04, 2023 at 01:36:00PM +0100, Alex Bennée wrote:
>Currently QEMU has to know some details about the back-end to be able
>to setup the guest. While various parts of the setup can be delegated
>to the backend (for example config handling) this is a very piecemeal
>approach.
>
>This patch suggests a new feature flag (VHOST_USER_PROTOCOL_F_STANDALONE)
>which the back-end can advertise which allows a probe message to be
>sent to get all the details QEMU needs to know in one message.
>
>Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>
>---
>Initial RFC for discussion. I intend to prototype this work with QEMU
>and one of the rust-vmm vhost-user daemons.

Thanks for starting this discussion!

I'm comparing with vhost-vdpa IOCTLs, so my questions may be
superficial, but they help me understand the differences.

>---
> docs/interop/vhost-user.rst | 37 +++++++++++++++++++++++++++++++++++++
> hw/virtio/vhost-user.c      |  8 ++++++++
> 2 files changed, 45 insertions(+)
>
>diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
>index 5a070adbc1..85b1b1583a 100644
>--- a/docs/interop/vhost-user.rst
>+++ b/docs/interop/vhost-user.rst
>@@ -275,6 +275,21 @@ Inflight description
>
> :queue size: a 16-bit size of virtqueues
>
>+Backend specifications
>+^^^^^^^^^^^^^^^^^^^^^^
>+
>++-----------+-------------+------------+------------+
>+| device id | config size |   min_vqs  |   max_vqs  |
>++-----------+-------------+------------+------------+
>+
>+:device id: a 32-bit value holding the VirtIO device ID
>+
>+:config size: a 32-bit value holding the config size (see ``VHOST_USER_GET_CONFIG``)
>+
>+:min_vqs: a 32-bit value holding the minimum number of vqs supported

Why do we need the minimum?

>+
>+:max_vqs: a 32-bit value holding the maximum number of vqs supported, must be >= min_vqs

Is this overlap with VHOST_USER_GET_QUEUE_NUM?

>+
> C structure
> -----------
>
>@@ -296,6 +311,7 @@ In QEMU the vhost-user message is implemented with the following struct:
>           VhostUserConfig config;
>           VhostUserVringArea area;
>           VhostUserInflight inflight;
>+          VhostUserBackendSpecs specs;
>       };
>   } QEMU_PACKED VhostUserMsg;
>
>@@ -316,6 +332,7 @@ replies. Here is a list of the ones that do:
> * ``VHOST_USER_GET_VRING_BASE``
> * ``VHOST_USER_SET_LOG_BASE`` (if ``VHOST_USER_PROTOCOL_F_LOG_SHMFD``)
> * ``VHOST_USER_GET_INFLIGHT_FD`` (if ``VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD``)
>+* ``VHOST_USER_GET_BACKEND_SPECS`` (if ``VHOST_USER_PROTOCOL_F_STANDALONE``)
>
> .. seealso::
>
>@@ -885,6 +902,13 @@ Protocol features
>   #define VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS  15
>   #define VHOST_USER_PROTOCOL_F_STATUS               16
>   #define VHOST_USER_PROTOCOL_F_XEN_MMAP             17
>+  #define VHOST_USER_PROTOCOL_F_STANDALONE           18
>+
>+Some features are only valid in the presence of other supporting
>+features. In the case of ``VHOST_USER_PROTOCOL_F_STANDALONE`` the
>+backend must also support ``VHOST_USER_PROTOCOL_F_CONFIG`` and
>+``VHOST_USER_PROTOCOL_F_STATUS``.
>+

What about adding a new section where we will describe what we mean
with "standalone" devices?

For example that the entire virtio device is emulated in the backend,
etc.

By the way, I was thinking more about F_FULL_DEVICE, but I'm not good
with names, so I'll just throw out an idea :-)

Thanks,
Stefano

>
> Front-end message types
> -----------------------
>@@ -1440,6 +1464,19 @@ Front-end message types
>   query the back-end for its device status as defined in the Virtio
>   specification.
>
>+``VHOST_USER_GET_BACKEND_SPECS``
>+  :id: 41
>+  :request payload: N/A
>+  :reply payload: ``Backend specifications``
>+
>+  When the ``VHOST_USER_PROTOCOL_F_STANDALONE`` protocol feature has been
>+  successfully negotiated, this message is submitted by the front-end to
>+  query the back-end for its capabilities. This is intended to remove
>+  the need for the front-end to know ahead of time what the VirtIO
>+  device the backend emulates is.
>+
>+  The reply contains the device id, size of the config space and the
>+  range of VirtQueues the backend supports.
>
> Back-end message types
> ----------------------
>diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
>index c4e0cbd702..28b021d5d3 100644
>--- a/hw/virtio/vhost-user.c
>+++ b/hw/virtio/vhost-user.c
>@@ -202,6 +202,13 @@ typedef struct VhostUserInflight {
>     uint16_t queue_size;
> } VhostUserInflight;
>
>+typedef struct VhostUserBackendSpecs {
>+    uint32_t device_id;
>+    uint32_t config_size;
>+    uint32_t min_vqs;
>+    uint32_t max_vqs;
>+} VhostUserBackendSpecs;
>+
> typedef struct {
>     VhostUserRequest request;
>
>@@ -226,6 +233,7 @@ typedef union {
>         VhostUserCryptoSession session;
>         VhostUserVringArea area;
>         VhostUserInflight inflight;
>+        VhostUserBackendSpecs specs;
> } VhostUserPayload;
>
> typedef struct VhostUserMsg {
>-- 
>2.39.2
>
>
>---------------------------------------------------------------------
>To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
>For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

