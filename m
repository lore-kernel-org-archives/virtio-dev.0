Return-Path: <virtio-dev-return-14117-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33FF4C4167B
	for <virtio-dev@archiver.kernel.org>; Tue,  5 Dec 2023 10:21:30 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 5CEC72B051
	for <virtio-dev@archiver.kernel.org>; Tue,  5 Dec 2023 10:21:29 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 389B49865D1
	for <virtio-dev@archiver.kernel.org>; Tue,  5 Dec 2023 10:21:29 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 188E1986458; Tue,  5 Dec 2023 10:21:29 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 09EC798645D
	for <virtio-dev@lists.oasis-open.org>; Tue,  5 Dec 2023 10:21:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701771687; x=1702376487;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XKAle7c0KCE5subRFaSdAZs4lzOnil8ymQEwH4jWdf8=;
        b=IwyvZy9+gUcVYPuCnhCJ1l4YCOmChwu17f1vUqU0YVgSgqUlyT21evk0X/YO881PPG
         S9woHLOa7OhLlkJ8UkQNNyhjpADrG1sgutZeZDprGQaIbflEJIIA2BzOfzhEuH35QnEv
         zcRFisHYw19pJOA2XVrEYJsBINmwyeMBA4QmWWSxxNzoriIqMg+h5Py2b3E7WVdoS9ge
         nK7pE7E4ej3Lpdd/XH8rBuICdECUsWd1ymvxfMuvUACcJriMX/7A/hiZkJkYtcJ6tLh8
         HPC4NudNQDRbqExAWLwluobH8hxoYPXgxr+sZO2mW9IprgACHj/TznVp3lV4D9ksDsLs
         PQhg==
X-Gm-Message-State: AOJu0YwuTKo+2fSsrHDWdIPHpucEq6xfwa3lVY2WwzcqgkF5oi/29aiG
	legQaYAzufY6aQOcuv5eTd35g3GmJSzIa5TSPPg=
X-Google-Smtp-Source: AGHT+IHOQ86rSMw5yMKnrCpIsCxkRGPtK7IJLo/fC+SwrxItZTR3LaUe3l9dCjDMoq4Fgfgy71kJEQ==
X-Received: by 2002:a05:6a00:1d8c:b0:6ce:3ae6:42e5 with SMTP id z12-20020a056a001d8c00b006ce3ae642e5mr853664pfw.21.1701771687426;
        Tue, 05 Dec 2023 02:21:27 -0800 (PST)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: virtio-dev@lists.oasis-open.org,
	Cornelia Huck <cohuck@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	stratos-dev@op-lists.linaro.org,
	Erik Schilling <erik.schilling@linaro.org>,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Tue,  5 Dec 2023 15:50:51 +0530
Message-Id: <3fbb010e96124cfbffd70709d9ce7a2a458322c8.1701771424.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] [PATCH] virtio-transport: Clarify requirements

The virtio documentation currently doesn't define any generic
requirements that are applicable to all transports. They can be useful
while adding support for a new transport.

This commit tries to define the same.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 content.tex | 48 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 46 insertions(+), 2 deletions(-)

diff --git a/content.tex b/content.tex
index 0a62dce5f65f..d4d5e7d7045b 100644
--- a/content.tex
+++ b/content.tex
@@ -631,8 +631,52 @@ \section{Device Cleanup}\label{sec:General Initialization And Device Operation /
 
 \chapter{Virtio Transport Options}\label{sec:Virtio Transport Options}
 
-Virtio can use various different buses, thus the standard is split
-into virtio general and bus-specific sections.
+The virtio devices are exposed to the guest as if they are physical
+devices using a specific transport method, like PCI, MMIO or Channel
+I/O. The transport methods define various aspects of the communication
+between the device and the driver, like device discovery, exchanging
+capabilities, interrupt handling, data transfer, etc.. Virtio can use
+various different buses, thus the standard is split into virtio general
+and bus-specific sections.
+
+\section{Virtio Transport Requirements}\label{sec:Virtio Transport Options / Virtio Transport Requirements}
+
+\devicenormative{\subsection}{Virtio Transport Requirements}{Virtio Transport Options}
+
+The device MUST present each event, in a transport defined way, from the
+moment it takes place until the driver acknowledges the event.
+
+The device MUST NOT access virtqueue's contents before the driver
+notifies that the queue is ready for access, in a transport defined way.
+
+The device MUST NOT access buffers on the virtqueue, after it has
+modified them and notified the driver about their availability.
+
+The device MUST reset the virtqueues if requested by the driver, in a
+transport defined way.
+
+\drivernormative{\subsection}{Virtio Transport Requirements}{Virtio Transport Options}
+
+The driver MUST NOT access guest memory locations outside what's made
+available by the device to the driver.
+
+The driver MUST NOT write to the read-only memory area and MUST NOT read
+from the write-only memory area.
+
+The driver MUST acknowledge events presented by the device, as mandated
+by the transport.
+
+The driver MUST NOT access virtqueue contents before the device notifies
+about the readiness of the same.
+
+The driver MUST NOT access buffers, after it has added them to the
+virtqueue and notified the device about their availability. The driver
+MAY access them after the device has processed them and notified the
+driver of their availability, in a transport defined way.
+
+The driver MAY ask the device to reset the virtqueues if, for example,
+the driver times out waiting for a notification from the device for a
+previously queued request.
 
 \input{transport-pci.tex}
 \input{transport-mmio.tex}
-- 
2.31.1.272.g89b43f80a514


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

