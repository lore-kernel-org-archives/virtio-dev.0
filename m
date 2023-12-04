Return-Path: <virtio-dev-return-14110-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03886C4167B
	for <virtio-dev@archiver.kernel.org>; Mon,  4 Dec 2023 09:41:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 4134F2CADD
	for <virtio-dev@archiver.kernel.org>; Mon,  4 Dec 2023 09:41:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 226939863F0
	for <virtio-dev@archiver.kernel.org>; Mon,  4 Dec 2023 09:41:34 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 041A798408C; Mon,  4 Dec 2023 09:41:34 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E6EFD986377
	for <virtio-dev@lists.oasis-open.org>; Mon,  4 Dec 2023 09:41:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701682892; x=1702287692;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fHYsh7OmxZQezOX7dfGh7Q9lPmJ2X1k3LnlsEPSJZwM=;
        b=BlYV9btC292N7a4zDMU2+nNxEH988JqrSXWQhPO8lGtb+kmMihBwardS9hG1dALHJ8
         D7MszgZIwd6iN/mlQY6ZTFvgsZuP1TN9WqVmiXTBDk04FDEQrAvRwvDMLFJGxJnHzX4U
         UpgEHwKhvQVrARJiBEfB4KjkaxrgmKnfLkOr9wWn8DVLd7g6jpi7BdU+rb+jZjOsBvl1
         tjjk/Dlk30cKtza3ip9n9zLDPoce8Z4yBnT103vK/QMooiYfrbB/oTUwPLQf93t0UJEA
         lxA8fSmVIvKozguYxhHK4G44959VIa2qnqihqja7gZxBt7ew5EsYCKgwi263V54OZvut
         xDDQ==
X-Gm-Message-State: AOJu0YyTusWB593v+S6GAYx9UaX3MDHxpZttuc+kaC9F6NGzvQjG81Gg
	pAOBzN74rKhuo6Jo5MLXD8dDzA==
X-Google-Smtp-Source: AGHT+IGIEI4bip3e8piTzZqoMd8OgbN+NjU8eQxeMZaml0g985zyVZ9DXfpIRXfgMythZ1JCcu4jfg==
X-Received: by 2002:a05:6a20:7d8f:b0:18c:8ff1:f0b with SMTP id v15-20020a056a207d8f00b0018c8ff10f0bmr2035975pzj.56.1701682892235;
        Mon, 04 Dec 2023 01:41:32 -0800 (PST)
From: David Stevens <stevensd@chromium.org>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	virtio-comment@lists.oasis-open.org,
	virtio-dev@lists.oasis-open.org
Cc: David Stevens <stevensd@chromium.org>
Date: Mon,  4 Dec 2023 18:41:22 +0900
Message-ID: <20231204094123.856214-1-stevensd@chromium.org>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] [PATCH v3 0/1] Define low power mode for devices

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

v2 -> v3:
 - Use different words for some concepts to avoid conflicts with other
   parts of the spec.
 - Rewrite various sentences to improve clarity.
v1 -> v2:
 - Define virtio-pci support on top of PCI power management.
 - Add more conformance requirements.

David Stevens (1):
  Define a low power mode for devices

 content.tex       | 61 +++++++++++++++++++++++++++++++++++++++++++++++
 transport-pci.tex |  9 +++++++
 2 files changed, 70 insertions(+)

-- 
2.43.0.rc2.451.g8631bc7472-goog


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

