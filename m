Return-Path: <virtio-dev-return-13456-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FE20C001DF
	for <virtio-dev@archiver.kernel.org>; Thu,  3 Aug 2023 15:33:13 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 94D1E3E332
	for <virtio-dev@archiver.kernel.org>; Thu,  3 Aug 2023 15:32:57 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2D41B9868F3
	for <virtio-dev@archiver.kernel.org>; Thu,  3 Aug 2023 15:32:57 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id E5B309866ED; Thu,  3 Aug 2023 15:32:56 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B210F98683A
	for <virtio-dev@lists.oasis-open.org>; Thu,  3 Aug 2023 15:32:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691076773; x=1691681573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U7Qn0xJjSdBvmi+1CrGzh6Qk7TvbOKSSojPGMhoeiO4=;
        b=a0OZmZseJw+LDEc2uZ1Fyk0Px7+PkNFQjLvXwLX20Ke4JZ2WTeCdSE2PFVfsjTYCiY
         tAt1dSAO5vyqsMRCNJ3k7lkDaTH/IsGFy/HtbHzYHmZ2jIBMhO+gh+2vOjhZ6CXiocRp
         WaWS2YPG2IQ1BN+P9K7ADM3OJ39N9UGSaZSmPhRPmxPrxdtLJ2/Vyxij+AgiJQoE91pZ
         zR4YFv7PFXRConmESrnvQ0Rq50TDREucHbwWvUW5jW487YYgc/4VPjluuLlK13GYd395
         oR4qHUaotncTPtCXDku9ynl6Q++nN35HZp2hJEXtDq8fmagTgIky0fwce2sCHVsIwaRa
         Ey0A==
X-Gm-Message-State: ABy/qLb+wWv+NYT1TI0X3L7C9StGVgf4Jsl/YCbJglFDM5qqOmaLisKA
	Xnmx1plpvQL6fFTcrEBBmIf9WIQkjLl75eF0vik=
X-Google-Smtp-Source: APBJJlFLy2n4DZlzNu2UmOJp/C3KxtTXSPWYdgLQyIs55q8FzbT8/9q+WAG6C/aCDYjhkjCNIS7tew==
X-Received: by 2002:a7b:cbd8:0:b0:3fe:228a:e782 with SMTP id n24-20020a7bcbd8000000b003fe228ae782mr7653768wmi.37.1691076772951;
        Thu, 03 Aug 2023 08:32:52 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: virtio-comment@lists.oasis-open.org
Cc: eric.auger@redhat.com,
	virtio-dev@lists.oasis-open.org,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu,  3 Aug 2023 16:32:38 +0100
Message-ID: <20230803153238.541803-5-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230803153238.541803-1-jean-philippe@linaro.org>
References: <20230803153238.541803-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] [PATCH 4/4] virtio-iommu: Clarify hot-unplug behavior

Since it is not obvious what the virtio-iommu device or driver should do
when an endpoint is removed [1], add some guidance in the specification.
Follow the same principle as other (hardware) IOMMU devices: clearing
endpoint ID state on endpoint removal is the responsibility of the
driver, not the IOMMU device.

On most hardware IOMMU devices, the endpoint ID state is kept in tables
managed by the driver, so intuitively the driver should be updating the
tables on hot-unplug, so that a new endpoint plugged later with the same
ID does not inherit stale translations. Besides, hardware IOMMUs have no
knowledge of endpoint removal. It is less obvious for virtio-iommu
because endpoint states are managed with ATTACH/DETACH requests, and a
virtual platform could in theory update the endpoint state when it is
removed. Existing VMMs like QEMU don't do it, and rightly expect the
driver to manage endpoint ID state like with other IOMMUs. It is not
invalid for a VMM to clean up state on endpoint removal, but a driver
shouldn't count on it.

[1] https://lore.kernel.org/all/15bf1b00-3aa0-973a-3a86-3fa5c4d41d2c@daynix.com/

Reported-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 device-types/iommu/description.tex | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/device-types/iommu/description.tex b/device-types/iommu/description.tex
index fb1b840..63ccd41 100644
--- a/device-types/iommu/description.tex
+++ b/device-types/iommu/description.tex
@@ -407,6 +407,11 @@ \subsubsection{DETACH request}
 After all endpoints have been successfully detached from a domain, it
 ceases to exist and its ID can be reused by the driver for another domain.
 
+When an endpoint is removed from the platform (for example
+unplugged, or disabled with PCIe SR-IOV), the device is not
+required to detach the endpoint ID from its domain. It is the
+driver's responsibility to detach the endpoint before removal.
+
 \drivernormative{\paragraph}{DETACH request}{Device Types / IOMMU Device / Device operations / DETACH request}
 
 The driver SHOULD set \field{reserved} to zero.
-- 
2.41.0


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

