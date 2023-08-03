Return-Path: <virtio-dev-return-13454-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17688C001DF
	for <virtio-dev@archiver.kernel.org>; Thu,  3 Aug 2023 15:33:00 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 5DE732B058
	for <virtio-dev@archiver.kernel.org>; Thu,  3 Aug 2023 15:32:55 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C8CD9986929
	for <virtio-dev@archiver.kernel.org>; Thu,  3 Aug 2023 15:32:54 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 3353A9866DC; Thu,  3 Aug 2023 15:32:54 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 99B979866DA
	for <virtio-dev@lists.oasis-open.org>; Thu,  3 Aug 2023 15:32:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691076771; x=1691681571;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q8r0UjDI0wHV30WjgDQTC930f7GVcVtVcqE/KmwOhO0=;
        b=aYsh93tyNZt4JMoc0/Pxqz/jLH1EzOTQLxI/WWPXmz3/HjYft9kdpZvBpHHkVEUb4d
         YDcI4WsqYW2rStKs+YN/HedjfrZbITa8pn501sWOMUel0slrBehyL3dSsEpj1ytQpcVe
         tizThySjmXfllRcOizf78l4HDcz6fW+GqLf1cFYNLLTMyiE8O0XM0vLSJDtmoY1pY+XA
         qylrj6ilQetJhhXX+hEVUKi9aoYISk+COeASIvHbW+wrNnwJjrq1UcUczxwojccT6tld
         nZhMPk3X7CRbUmtsC0WDJzXEgiVQUXUey2ruhMy8IVhG6rZVbsHKNYMravxDCVV1JJer
         hmzw==
X-Gm-Message-State: ABy/qLaGCbXPfDtWZBh7rFKzuGDsuf4J94mSrTAoj2eaCd6KQCt775OU
	NWby7k3WpYFLN47tZ9behcafKQ==
X-Google-Smtp-Source: APBJJlF0PprqPVkXKEqz0bFs1E/f4/3/ETe9SCBjZkkVUr+UId6qh9ic4HeY11H2sB4/p5jrzp0pOQ==
X-Received: by 2002:a2e:998b:0:b0:2b9:6871:e989 with SMTP id w11-20020a2e998b000000b002b96871e989mr7494890lji.19.1691076771191;
        Thu, 03 Aug 2023 08:32:51 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: virtio-comment@lists.oasis-open.org
Cc: eric.auger@redhat.com,
	virtio-dev@lists.oasis-open.org,
	Jean-Philippe Brucker <jean-philippe@linaro.org>
Date: Thu,  3 Aug 2023 16:32:34 +0100
Message-ID: <20230803153238.541803-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] [PATCH 0/4] virtio-iommu: Minor specification fixes

Patches 1 and 2 fix typos in the IOMMU device type. Patch 3 removes a
contradictory statement, and a useless one. Patch 4 adds some
information about removal of endpoints managed by the IOMMU, following a
recent fix in the Linux driver.

Jean-Philippe Brucker (4):
  virtio-iommu: Fix typo in label
  virtio-iommu: Fix RESV_MEM typo
  virtio-iommu: Fix contradictory and unnecessary statements
  virtio-iommu: Clarify hot-unplug behavior

 device-types/iommu/description.tex | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

-- 
2.41.0


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

