Return-Path: <virtio-dev-return-11399-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3627FC678D4
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 23:26:15 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 6DBBD42A63
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 23:26:14 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 661F498678A
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 23:26:14 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 5D4669866AF; Thu,  2 Mar 2023 23:26:14 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4ADD89866B0
	for <virtio-dev@lists.oasis-open.org>; Thu,  2 Mar 2023 23:26:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: jvDir6rmMAG3d0p23rG_nw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677799569;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jkli4sKWA2Vs6K5h1L60YlzxtdEzgrp/zw7ZmfT/S5U=;
        b=5NH+kt3EPB5yzmjjg3tW1y/XxDoDtwUTchM1B8bqsGhWjpsrBfsnd+WkGiC36idxJF
         mfQSfJTunm4e2DHg1ISRtDeuAbG10xBr4U2C/IWirVFTDKd2KrYr6UGfA4CkuEOWT0C8
         e/0zYifjqidsjk5KR2H5glyCVZzfOURKRlATarKihZio0RPEzpFbrRBqahx3tg/JIO00
         aEM26aqV9WCh5kY73KNFamSjTbzCAMFBSRv5DZka/0xT8nxDuFtJ1syvq1jv3NMw/2E9
         TkyFZPcR04d2QMGWs3ewoGX37pbnq4KVe57rfwJ+ckLnwjiph4b+2JbZZkFLSnQtaPBa
         6DFw==
X-Gm-Message-State: AO0yUKVtBjuMt0X3JQOvWMuvTpE1QC4JmpLHNN/Ad2V5bd1qMQYzV7zz
	9xRVY9zGyz9OXr0eR+bHIsbsC1n4aAjvrREvg8lbvPLyRg2YqP36rDVxTonfvO/VQmovcH4Xrbc
	riXNWsgeEWTbQC3A6K0u0GVuwWvuN
X-Received: by 2002:adf:f68d:0:b0:2c8:840:26ea with SMTP id v13-20020adff68d000000b002c8084026eamr29408wrp.12.1677799568844;
        Thu, 02 Mar 2023 15:26:08 -0800 (PST)
X-Google-Smtp-Source: AK7set992Zq2EL0moqpECZ5jxAMOK8PWa36d8wGfHqHKdIJt1V4bFWS2qmRa+il4xzFwu+wPxQOn0A==
X-Received: by 2002:adf:f68d:0:b0:2c8:840:26ea with SMTP id v13-20020adff68d000000b002c8084026eamr29397wrp.12.1677799568550;
        Thu, 02 Mar 2023 15:26:08 -0800 (PST)
Date: Thu, 2 Mar 2023 18:26:05 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: David Edmondson <david.edmondson@oracle.com>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	virtio-dev@lists.oasis-open.org, Parav Pandit <parav@nvidia.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jason Wang <jasowang@redhat.com>,
	virtio-comment@lists.oasis-open.org
Message-ID: <20230302182538-mutt-send-email-mst@kernel.org>
References: <20230301141027.59500-1-hengqi@linux.alibaba.com>
 <m2lekf1iq8.fsf@oracle.com>
 <d7a008c0-3f93-5dfa-6897-8436bf30708c@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <d7a008c0-3f93-5dfa-6897-8436bf30708c@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] [PATCH v10] virtio-net: support the virtqueue
 coalescing moderation

On Thu, Mar 02, 2023 at 08:46:03PM +0800, Heng Qi wrote:
> Have we decided yet, I see in Parav's thread it seems to be still under
> discussion? Michael should we be using index?

I don't know at this point. Maybe wait a bit more.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

