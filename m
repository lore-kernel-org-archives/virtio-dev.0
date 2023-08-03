Return-Path: <virtio-dev-return-13455-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C1CAEB64DD
	for <virtio-dev@archiver.kernel.org>; Thu,  3 Aug 2023 15:33:06 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id AD31B2CAD5
	for <virtio-dev@archiver.kernel.org>; Thu,  3 Aug 2023 15:32:56 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A7B539866D8
	for <virtio-dev@archiver.kernel.org>; Thu,  3 Aug 2023 15:32:56 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 9558698641D; Thu,  3 Aug 2023 15:32:56 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 81EB99866DF
	for <virtio-dev@lists.oasis-open.org>; Thu,  3 Aug 2023 15:32:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691076771; x=1691681571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1clKC/JBSg9x6j9WPptX8/SuIaAxlu/0sjAhl54KE3o=;
        b=a6QY6zBbeciBu6oBcRGB4rAAv3InrJJGL3boQcA+fck3wHZR3LIj83bBC5JoFMF9Df
         9QDzyTM30POMQGZmKkogwTO2zGNqWxokChSWIVwd71TJJsbbzNcl5oT02PiihTBw0p71
         zt6eRJD9UU4EdCXSAdrZWjTy6lqqJ3oYGAyqIWeTclLCiYxtvdtbG1UhSEDvCNeZQm74
         lhx7pFltBYOH5znxok2DSrKw5CaEsJsI95JjDeEerr24UXaIuj+PdAaSm45E2l0nHT5+
         DjgxXDd+usdBjxMmf019BU+UaXw0wjLmd0ODulR5oTTAAx1aPEceNM/DsrfrMNEERVVx
         KaVQ==
X-Gm-Message-State: ABy/qLZzvkGNRUIXuo4fUlOi4zUl0o2OL6lL0M1V7shF5CrJWRTOnqUB
	TlhT7fywQtWosP59bq04hlv27A==
X-Google-Smtp-Source: APBJJlGCsV63dsgyrG3EsAtjheS/f8PmKOWYvrNvtvoAcJBwJk6VQZtPQGrUdB7fV0ZZC4hGjnL+lA==
X-Received: by 2002:a7b:c392:0:b0:3fc:62c:8275 with SMTP id s18-20020a7bc392000000b003fc062c8275mr7704934wmj.35.1691076771647;
        Thu, 03 Aug 2023 08:32:51 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: virtio-comment@lists.oasis-open.org
Cc: eric.auger@redhat.com,
	virtio-dev@lists.oasis-open.org,
	Jean-Philippe Brucker <jean-philippe@linaro.org>
Date: Thu,  3 Aug 2023 16:32:35 +0100
Message-ID: <20230803153238.541803-2-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230803153238.541803-1-jean-philippe@linaro.org>
References: <20230803153238.541803-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] [PATCH 1/4] virtio-iommu: Fix typo in label

Use the 'sec:' prefix like all other labels

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 device-types/iommu/description.tex | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/device-types/iommu/description.tex b/device-types/iommu/description.tex
index f8cbe88..d13a880 100644
--- a/device-types/iommu/description.tex
+++ b/device-types/iommu/description.tex
@@ -796,7 +796,7 @@ \subsubsection{PROBE properties}\label{sec:Device Types / IOMMU Device / Device
 The device SHOULD NOT allow accesses from the endpoint to RESV_MEM regions
 to affect any other component than the endpoint and the driver.
 
-\subsubsection{Fault reporting}\label{sev:Device Types / IOMMU Device / Device operations / Fault reporting}
+\subsubsection{Fault reporting}\label{sec:Device Types / IOMMU Device / Device operations / Fault reporting}
 
 The device can report translation faults and other significant
 asynchronous events on the event virtqueue. The driver initially populates
-- 
2.41.0


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

