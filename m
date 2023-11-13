Return-Path: <virtio-dev-return-14057-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0C4BC4167B
	for <virtio-dev@archiver.kernel.org>; Mon, 13 Nov 2023 06:20:42 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id AA70660D2D
	for <virtio-dev@archiver.kernel.org>; Mon, 13 Nov 2023 06:20:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9ADDC9867EC
	for <virtio-dev@archiver.kernel.org>; Mon, 13 Nov 2023 06:20:34 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 8B87F9865E0; Mon, 13 Nov 2023 06:20:34 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7036B986602
	for <virtio-dev@lists.oasis-open.org>; Mon, 13 Nov 2023 06:20:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699856403; x=1700461203;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=40AnNMTnTA5JbfUmtrf6+OxPtYqdB23qjRlhAiosjOY=;
        b=uTlbmKEvpNgabDYrVofQZ6GScT6QPU9bkmyD++UppylElMEfqG8MPNZipYBkpnYRQT
         54CuBRuVZPHPNhIWGTiHMnwnXVv2mC9kErFOlNT0t3xdXtKzZjLvTtK3B+030GaQM9m9
         lJW7XI5mu1ml7rBqGFc5Ja3b+iXMYMiW08Tvj4dM3nEpuuY6/z83ZqfZX4NBwZeiaAt6
         HrgzZ7a4SkKwiPnBladoIKZYdLe+WCOngzwJ81EzEYO2M/7KMdP4l8MONQsSUZZIUCWU
         aoT2DI2llCrS4l/+jvSLd2irUGxooxxWKgsJtJCqfyIrqgQeRd3iZIUU6afpGmRUPgK4
         MG0A==
X-Gm-Message-State: AOJu0YydQugvOBsgPyZlSH2nDlKd6S1ns7UWVLVzN5c9cxEriL5I+Twj
	2ZcZCAzZ75klp7ZpycyXouGCrQ==
X-Google-Smtp-Source: AGHT+IHlesSrSlmMAd1ftZsjf/KL7ghDnrOyNKQB+bYvggaRRlH84Bu6koiwR2GphIkoOQXXsaFGKA==
X-Received: by 2002:a05:6358:6f1d:b0:169:a9d4:3faf with SMTP id r29-20020a0563586f1d00b00169a9d43fafmr6164780rwn.11.1699856402953;
        Sun, 12 Nov 2023 22:20:02 -0800 (PST)
From: David Stevens <stevensd@chromium.org>
To: virtio-comment@lists.oasis-open.org,
	virtio-dev@lists.oasis-open.org
Cc: David Stevens <stevensd@chromium.org>
Date: Mon, 13 Nov 2023 15:19:49 +0900
Message-ID: <20231113061950.122683-1-stevensd@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] [PATCH v2 0/1] Define low power mode for devices

The virtio spec currently does not include the concept of device power
management. The lack means that there is no good action drivers can take
when they are requested to put the device into a low power state (e.g.
when a guest is entering a system-wide low power state like S0ix/S3).
Stateless devices can be handled - albeit inefficiently - by resetting
and reinitialzing the device. However, stateful devices cannot support
this situation. This patch defines a low power mode for devices that can
be used in this situation.

Low power mode is mostly defined at the transport layer, and all
device-side power optimizations are optional. This avoids the need for
invasive device-by-device definitions. It also pushes the requirement
onto the device side, to simplify what driver side changes are
necessary to just [1].

I believe this patch may address the virtio-gpu issue which [2] is
trying to address by avoiding the reset altogether when the guest enters
S3.

[1] https://lore.kernel.org/lkml/20231113055138.117392-1-stevensd@chromium.org/
[2] https://lore.kernel.org/lkml/20230919114242.2283646-1-Jiqian.Chen@amd.com/

v1 -> v2:
 - Define virtio-pci support on top of PCI power management.
 - Add more conformance requirements.

David Stevens (1):
  Define a low power mode for devices

 content.tex       | 45 +++++++++++++++++++++++++++++++++++++++++++++
 transport-pci.tex |  7 +++++++
 2 files changed, 52 insertions(+)

-- 
2.42.0.869.gea05f2083d-goog


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

