Return-Path: <virtio-dev-return-14270-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6869AC46CD2
	for <virtio-dev@archiver.kernel.org>; Wed, 24 Jan 2024 11:16:07 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 8AADE2B379
	for <virtio-dev@archiver.kernel.org>; Wed, 24 Jan 2024 11:16:06 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EAEAA986833
	for <virtio-dev@archiver.kernel.org>; Wed, 24 Jan 2024 11:16:05 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 2AEE098680E; Wed, 24 Jan 2024 11:16:05 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C77699867D8
	for <virtio-dev@lists.oasis-open.org>; Wed, 24 Jan 2024 11:16:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 4lhZiMiTO-G_43m3KH2u4Q-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706094959; x=1706699759;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GwiE2/yz8VhnNvodkElUD2FNEZjMCAX4OtwMgtRG1vQ=;
        b=VyLbvH7LwCLXvBMf/GHvLHUNHhgcFiJo6NHTU5X/4aiTSCtxzLJVani5Mp0VwQ/dp/
         guRTqsUVf+oeHa1zWLuNybilwMmwtXMQF5BNAhCZK23/yWV9eadSMvgIv9uY6Eo8ZRV0
         T+Xybr7vHOyQ2P7QOzUK0gf3gWWEZvW1tuprpN19x+q+/BMLMgw6X8dXzL4y/geJGFJ1
         k65xyHvE4kVatsgDp4y80ZJiXBSqyvRTbvzSFkLUNac8vN4G8vaktjDsZxww5Ue8Mk5k
         va31d4Uc3wdAwcRUD4x0x9Q4qVIIEpcwxisEP3LV+2gm7BbXYcas9nmElQBpsT/HzsWX
         r6kA==
X-Gm-Message-State: AOJu0Yx39K02smlDkj4HwkEoCzbsaAMCTIntLkfQ6i895/ttZ86LmMec
	LImMswOKI6Z8zo11+zNBoyafYs3Q8C2EcpwzRT1l+jJC34q48WrjBV++lVfe0B1fKTIwT/FRO5Y
	gig6i3NCbhM1CUDPOcAyUxn1Xw6niluYuTo2BfLlIS88wpq/P/cAff3HASu8YjQdzyA==
X-Received: by 2002:a19:645a:0:b0:50e:6cce:f83 with SMTP id b26-20020a19645a000000b0050e6cce0f83mr2928869lfj.41.1706094959037;
        Wed, 24 Jan 2024 03:15:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHTRHEN8mFK5cqzvzp8Sx8nWHspL6QOzlqLGQIiWfe0VnIgfOIIq4y7deU8ObGip8FGIoxIZQ==
X-Received: by 2002:a19:645a:0:b0:50e:6cce:f83 with SMTP id b26-20020a19645a000000b0050e6cce0f83mr2928861lfj.41.1706094958581;
        Wed, 24 Jan 2024 03:15:58 -0800 (PST)
Date: Wed, 24 Jan 2024 06:15:55 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: virtio@lists.oasis-open.org
Message-ID: <ff9a6d805e7d510cde77b9989bef90aa21ffe4b4.1706094950.git.mst@redhat.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] [PATCH] virtio-net: clarify error handling for coalescing

This is not a huge deal since it's a SHOULD anyway,
so make the new requirement SHOULD too.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 device-types/net/description.tex | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/device-types/net/description.tex b/device-types/net/description.tex
index aff5e08..d1d25fe 100644
--- a/device-types/net/description.tex
+++ b/device-types/net/description.tex
@@ -1792,7 +1792,11 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
 
 The device MUST ignore \field{reserved}.
 
-The device SHOULD respond to VIRTIO_NET_CTRL_NOTF_COAL_TX_SET and VIRTIO_NET_CTRL_NOTF_COAL_RX_SET commands with VIRTIO_NET_ERR if it was not able to change the parameters.
+The device SHOULD respond to VIRTIO_NET_CTRL_NOTF_COAL_TX_SET and
+VIRTIO_NET_CTRL_NOTF_COAL_RX_SET commands with VIRTIO_NET_ERR if
+it was not able to change coalescing parameters. In this case,
+the parameters SHOULD remain unchanged, for all VQs.
+
 
 The device MUST respond to the VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET command with VIRTIO_NET_ERR if it was not able to change the parameters.
 
-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

