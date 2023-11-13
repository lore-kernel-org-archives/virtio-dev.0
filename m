Return-Path: <virtio-dev-return-14056-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9A66C4167B
	for <virtio-dev@archiver.kernel.org>; Mon, 13 Nov 2023 06:20:33 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 10AA42A839
	for <virtio-dev@archiver.kernel.org>; Mon, 13 Nov 2023 06:20:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F1CD298680E
	for <virtio-dev@archiver.kernel.org>; Mon, 13 Nov 2023 06:20:31 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id E06089865E0; Mon, 13 Nov 2023 06:20:31 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C4859986675
	for <virtio-dev@lists.oasis-open.org>; Mon, 13 Nov 2023 06:20:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699856408; x=1700461208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lUjklFKSOnUusYvRpeq6KaOQ/4IfHLZPfwfFhGfaHNY=;
        b=R8Wes3XAWoBcgNgKUwg5OK4gfxWLuNy0yU/LzzFYJm9BF7T3McWIf/45vZfjQ75BHG
         nvOQwKYanlXwBeKvxKGSsOn46/K9dadiS9T55hLqjvPRlzt/8tJm47MyW/jBvhdLZWlz
         JKtrW4H+v1cqpARWrQXI2SqOpeA7v5VapA7rC5UqZiQYEtIX3BnwINvM491YfiGohpBA
         4f2HJHU92KF4Z32AAE4+Sgr9pNK1QCXUThl91TVbenD3rXi8DQzx9Qx6G0Zn6m7rb1Qv
         g9Ai+xFge4YLqjHzupDxP662NduaLLbeT66OyGvcA3khSCwqpq9gOe0tf8C4+Edf06NN
         yo/w==
X-Gm-Message-State: AOJu0YwW5+ELbeqcQwe/rvz+GgXR+rLCHrxkyPfbovm8I2I8h/UlGslw
	wI4CVh8AXbm+OM5XZ2tNQ/8qvg==
X-Google-Smtp-Source: AGHT+IGP+P5SIY11qzeMNA70gpGGcRBBbHKPpcX/4bR+xuiexgy2Or1OG5jCbjv5jFpY9kUuh/8yqw==
X-Received: by 2002:a17:90b:1d11:b0:27d:5946:5e2c with SMTP id on17-20020a17090b1d1100b0027d59465e2cmr3506870pjb.12.1699856408434;
        Sun, 12 Nov 2023 22:20:08 -0800 (PST)
From: David Stevens <stevensd@chromium.org>
To: virtio-comment@lists.oasis-open.org,
	virtio-dev@lists.oasis-open.org
Cc: David Stevens <stevensd@chromium.org>
Date: Mon, 13 Nov 2023 15:19:50 +0900
Message-ID: <20231113061950.122683-2-stevensd@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231113061950.122683-1-stevensd@chromium.org>
References: <20231113061950.122683-1-stevensd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] [PATCH v2 1/1] Define a low power mode for devices

Define a low power mode for virtio devices where the devices are
expected to maintain their state. This gives drivers an option for power
management besides simply resetting their device. In the virtualization
use case, this allows the guest to be suspended even with stateful
virtio devices like gpu and fs.

Low power mode is primarily defined at the transport layer. The only
part that depends on device-type specific details is whether a given
virtqueue is device driven or driver driven.

This change only defines the transport-specific implementation for
Virtio over PCI.
---
 content.tex       | 45 +++++++++++++++++++++++++++++++++++++++++++++
 transport-pci.tex |  7 +++++++
 2 files changed, 52 insertions(+)

diff --git a/content.tex b/content.tex
index 0a62dce5f65f..7016778c38d6 100644
--- a/content.tex
+++ b/content.tex
@@ -502,6 +502,51 @@ \section{Exporting Objects}\label{sec:Basic Facilities of a Virtio Device / Expo
 types. It is RECOMMENDED that devices generate version 4
 UUIDs as specified by \hyperref[intro:rfc4122]{[RFC4122]}.
 
+\section{Low Power Mode}\label{sec:Basic Facilities of a Virtio Device / Low Power Mode}
+
+Low power mode is a state a driver can put its device into to try to
+reduce the resource consumption of the device. While in low power
+mode, a device can generate wakeup events to inform its driver about
+device driven events. How a device is put into and taken out of low
+power mode is transport specific, as is how wakeup events are
+implemented.
+
+\devicenormative{\subsection}{Low Power Mode}{Basic Facilities of a Virtio
+Device / Low Power Mode}
+
+A device in low power mode MUST maintain its state such that all
+driver visible state after exiting low power mode exactly matches
+driver visible state before entering low power mode.
+
+A device in low power mode MUST continue to operate device driven
+queues. Device driven queues are queues where the driver provides
+buffers to the device that the device holds onto for an indeterminate
+time until some device-side event occurs (e.g. event queues, rx
+queues). When sending a used buffer notification for such a queue, the
+device MUST generate a wakeup event.
+
+A device in low power mode MUST continue to send configuration change
+notifications. When sending a configuration change notification, the
+device MUST generate a wakeup event.
+
+A device in low power mode SHOULD NOT generate wakeup events for
+driver driven queues. A device SHOULD stop sending used buffer
+notifications for such queues until after exiting the low power state.
+
+A device in low power mode SHOULD minimize its resource usage,
+although what steps to take are specific to a particular device
+implementation.
+
+\drivernormative{\subsection}{Low Power Mode}{Basic Facilities of a Virtio
+Device / Low Power Mode}
+
+A driver MUST not interact with a device in low power mode except
+to take the device out of low power mode or to handle wakeup events
+generated by the device.
+
+A driver MAY use wakeup events as a trigger to take the device out of
+low power mode, but it MAY also ignore wakeup events.
+
 \input{admin.tex}
 
 \chapter{General Initialization And Device Operation}\label{sec:General Initialization And Device Operation}
diff --git a/transport-pci.tex b/transport-pci.tex
index a5c6719ea871..6694e0f72d46 100644
--- a/transport-pci.tex
+++ b/transport-pci.tex
@@ -1212,3 +1212,10 @@ \subsubsection{Driver Handling Interrupts}\label{sec:Virtio Transport Options /
         re-examine the configuration space to see what changed.
     \end{itemize}
 \end{itemize}
+
+\subsubsection{Low Power Mode}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Low Power Mode}
+
+Low power mode corresponds to the device power management state
+D3\textsubscript{Hot}. A device advertises support for low power mode
+by presenting the PCI Power Management Capability. Wakeup events are
+implemented as PCI Power Management Events (PMEs).
-- 
2.42.0.869.gea05f2083d-goog


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

