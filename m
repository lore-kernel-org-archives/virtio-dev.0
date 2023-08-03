Return-Path: <virtio-dev-return-13457-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65CB5EB64DD
	for <virtio-dev@archiver.kernel.org>; Thu,  3 Aug 2023 15:33:25 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 218177413C
	for <virtio-dev@archiver.kernel.org>; Thu,  3 Aug 2023 15:32:58 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 93DBC986988
	for <virtio-dev@archiver.kernel.org>; Thu,  3 Aug 2023 15:32:57 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 43B1698690A; Thu,  3 Aug 2023 15:32:57 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2611098686D
	for <virtio-dev@lists.oasis-open.org>; Thu,  3 Aug 2023 15:32:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691076772; x=1691681572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kWfUmBqz7pP9olSU6iWXYZrROKtIgUBIhjeHz2dC5Zk=;
        b=huuKyGFSzbwv3XyKqpOnMOvDLeilYiDh6T0Xw5rD9uhLPJGt9l1AVO8fle471JaCFd
         GBknyLkzaaioI4RDqTaJBU/zM1Rg4R2P2lzyMByo7S8G3W9VLBxIatwAtm9ApoXnqgtK
         VOYgDqdoi58HitQ/lBjZ1aK+sG15b7tD57BNbHIwRPhelMMdJ1Pj1RXE5FEqWehlggl6
         SZrH+J43wuWBzvKwmxjf7jEN6EQS+M+EHBdQjaWTuqIifOYbCdnNyUztokoerzuD8Jm2
         8oDelNX3Sc+nMpqfENUsvnvquMAN14g3X/UdXreplH1ZRXXpNiRxFxiB07Q9lj/fWPdR
         c8Bg==
X-Gm-Message-State: ABy/qLY2qaV1OWGb5RGFNJcCj0JVkFM0vhTXHle/MM5i07t4HZG/Cwzc
	p0OMZCxwopB98iFiTJLmLGJWRZotADCWE73ecjI=
X-Google-Smtp-Source: APBJJlEavmLPgIaVY+G3bIdCFyV3jn7kqdec7JwrEbD6u1W0mBrtJTVyYXVtNkWBGQ0APfM8UluMKA==
X-Received: by 2002:a05:600c:2a54:b0:3fa:934c:8350 with SMTP id x20-20020a05600c2a5400b003fa934c8350mr7678878wme.27.1691076772519;
        Thu, 03 Aug 2023 08:32:52 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: virtio-comment@lists.oasis-open.org
Cc: eric.auger@redhat.com,
	virtio-dev@lists.oasis-open.org,
	Jean-Philippe Brucker <jean-philippe@linaro.org>
Date: Thu,  3 Aug 2023 16:32:37 +0100
Message-ID: <20230803153238.541803-4-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230803153238.541803-1-jean-philippe@linaro.org>
References: <20230803153238.541803-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] [PATCH 3/4] virtio-iommu: Fix contradictory and unnecessary statements

In the device-normative statement for the ATTACH request, we say:

  If another endpoint is already attached to the domain identified by
  \field{domain}, then the device MAY attach the endpoint identified by
  \field{endpoint} to the domain.

and later:

  If properties of the endpoint (obtained with a PROBE request) are
  compatible with properties of other endpoints already attached to the
  requested domain, then the device SHOULD attach the endpoint.

These statements contradict each others. Attaching multiple endpoints to
one domain is a convenience that allows using fewer page table
resources. The device is always allowed to reject a second attach
request, in which case the driver simply creates a separate domain for
the second endpoint. Remove the "SHOULD" statement and keep the "MAY"
one.

Also remove the following statement which doesn't add anything useful.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 device-types/iommu/description.tex | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/device-types/iommu/description.tex b/device-types/iommu/description.tex
index c9b43db..fb1b840 100644
--- a/device-types/iommu/description.tex
+++ b/device-types/iommu/description.tex
@@ -383,12 +383,9 @@ \subsubsection{ATTACH request}\label{sec:Device Types / IOMMU Device / Device op
 VIRTIO_IOMMU_S_UNSUPP.
 
 If properties of the endpoint (obtained with a PROBE request) are
-compatible with properties of other endpoints already attached to the
-requested domain, then the device SHOULD attach the endpoint. Otherwise
-the device SHOULD reject the request and set \field{status} to
-VIRTIO_IOMMU_S_UNSUPP.
-
-A device that does not reject the request MUST attach the endpoint.
+not compatible with properties of other endpoints already
+attached to the domain, the device SHOULD reject the request and
+set \field{status} to VIRTIO_IOMMU_S_UNSUPP.
 
 \subsubsection{DETACH request}
 
-- 
2.41.0


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

