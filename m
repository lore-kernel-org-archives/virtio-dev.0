Return-Path: <virtio-dev-return-13453-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D169EB64DD
	for <virtio-dev@archiver.kernel.org>; Thu,  3 Aug 2023 15:32:54 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id C26C71318C7
	for <virtio-dev@archiver.kernel.org>; Thu,  3 Aug 2023 15:32:53 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A33F098670B
	for <virtio-dev@archiver.kernel.org>; Thu,  3 Aug 2023 15:32:53 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 94A3A9866D8; Thu,  3 Aug 2023 15:32:53 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7FAFD9866DE
	for <virtio-dev@lists.oasis-open.org>; Thu,  3 Aug 2023 15:32:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691076772; x=1691681572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o6nES6n5CsxZ2X4Z6tR/DYCUzzXnUwdOGjZ7jDpkFP4=;
        b=CiP+kBuzCW1ts4l5H7ZFVM+ax2u/vp/4iMiRtxglJwei0F9gcruo0Lmhvds1tpvgBI
         SZkPmUUPnPWds+nsH59nKR+nueWz0iUH2od0Fw//VFBPBWRBFIBgAhyu4WevwVjGXNrX
         qWvunUTLbPirL+w+yE3bW6YJg3Ho4g9Lmz+Joni2+f+JiFDLyXV2YHA9JmraIwHmRgRv
         6GhRj4EWQv+MpXD35Dn2aHAqzYJW4LCMSHhBD+UN6DIJNYGD9izw+hiHN49NPt/0CGHl
         nu7LeJGt3cUXw6dlXcY+Rr8zQoX3Ir7IaQjDSc4Htvh0+kkmgmsnLlR3akgONdyj/gDv
         LGAQ==
X-Gm-Message-State: ABy/qLaM8f+NeHsgUEGMvF+azTp851rs0gwGPRPSYnrrEC14arHIZisT
	/0v9sXdPllJxXQZilHYcoQ9f1Q==
X-Google-Smtp-Source: APBJJlE9pOL/5G7IaYJ0rLEX6RZRU8zy/X1afHqK8HvqBSQ3IPg42H6wVgoY2UiGz234Gvb7p3SdWA==
X-Received: by 2002:a05:600c:4d0d:b0:3fe:2120:eb7c with SMTP id u13-20020a05600c4d0d00b003fe2120eb7cmr8302569wmp.0.1691076772069;
        Thu, 03 Aug 2023 08:32:52 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: virtio-comment@lists.oasis-open.org
Cc: eric.auger@redhat.com,
	virtio-dev@lists.oasis-open.org,
	Jean-Philippe Brucker <jean-philippe@linaro.org>
Date: Thu,  3 Aug 2023 16:32:36 +0100
Message-ID: <20230803153238.541803-3-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230803153238.541803-1-jean-philippe@linaro.org>
References: <20230803153238.541803-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] [PATCH 2/4] virtio-iommu: Fix RESV_MEM typo

Remove an extra word in the RESV_MEM description.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 device-types/iommu/description.tex | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/device-types/iommu/description.tex b/device-types/iommu/description.tex
index d13a880..c9b43db 100644
--- a/device-types/iommu/description.tex
+++ b/device-types/iommu/description.tex
@@ -758,8 +758,8 @@ \subsubsection{PROBE properties}\label{sec:Device Types / IOMMU Device / Device
 \begin{description}
   \item[VIRTIO_IOMMU_RESV_MEM_T_RESERVED (0)]
     These virtual addresses cannot be used in a MAP requests. The region
-    is be reserved by the device, for example, if the platform needs to
-    setup DMA mappings of its own.
+    is reserved by the device, for example if the platform needs
+    to setup DMA mappings of its own.
 
   \item[VIRTIO_IOMMU_RESV_MEM_T_MSI (1)]
     This region is a doorbell for Message Signaled Interrupts (MSIs). It
-- 
2.41.0


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

