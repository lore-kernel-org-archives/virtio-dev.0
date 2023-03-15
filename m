Return-Path: <virtio-dev-return-11620-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46906C61DA4
	for <virtio-dev@archiver.kernel.org>; Wed, 15 Mar 2023 12:10:20 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 7B91042907
	for <virtio-dev@archiver.kernel.org>; Wed, 15 Mar 2023 12:10:19 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5D3B0986414
	for <virtio-dev@archiver.kernel.org>; Wed, 15 Mar 2023 12:10:19 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 44715986402; Wed, 15 Mar 2023 12:10:19 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 32513986406
	for <virtio-dev@lists.oasis-open.org>; Wed, 15 Mar 2023 12:10:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: UNW9y_p2N6-Sp6oHSXzDMA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678882216;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=is9D8VteCEMaMmGa4QCOngrvVVD0S6RorAW18QMTc7E=;
        b=35vViZ75+9opQ8SCmDIoB9QLIXvWJ7fGq5BgehoqtJnNPRGkdg2V0vL7z+f68SrLyF
         n7p2r1L++NVH3o8utMowO5KHwBhjgQn+15XYmm7KtIKldvS/8doE9j2fJ4kn48XkA5kA
         2s+1eMJGsAHGHFueFS9o137wkSNUweDdqQxjYEuiuTySdo4T/6eZpsJSn0UvDG+feefk
         NwvJPC4lihDFEmNjVLmpRAK/xE2l0yD0rpCOfkJIwF7K3FT47iIsGcveEh6QVLFRKUGz
         rsM9Dc2+ukXvvb2iuNTGV+nrXL6KSFzsXsQxd7sFcDbD8EyUZ0Np/j6Hr59ou7XzdpF/
         +djw==
X-Gm-Message-State: AO0yUKX3Va2eBP40v6UDT3I47LZxGm56vduL7qfrBOZW8E5b/Hb4vkIh
	IK8p2pzluymHVeH90r4BIbExsV/V2rpRyVtKgyRTu9glFfitQ4zxdHWcpTLU+D8WCVRXMt4adyF
	FpfXSP0qAvrf57X/5eUrzlxfv0l9+
X-Received: by 2002:a05:600c:4e8f:b0:3ed:32cd:be64 with SMTP id f15-20020a05600c4e8f00b003ed32cdbe64mr2190737wmq.29.1678882216318;
        Wed, 15 Mar 2023 05:10:16 -0700 (PDT)
X-Google-Smtp-Source: AK7set/V7o9FJ5o2qAtEqvDgO12S0YZyowCf4PbjIf5H+RcYr1huxo4b+Vmu2fc9hXPFvzdvp4HMZA==
X-Received: by 2002:a05:600c:4e8f:b0:3ed:32cd:be64 with SMTP id f15-20020a05600c4e8f00b003ed32cdbe64mr2190718wmq.29.1678882216062;
        Wed, 15 Mar 2023 05:10:16 -0700 (PDT)
Date: Wed, 15 Mar 2023 08:10:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, virtio-dev@lists.oasis-open.org,
	virtio-comment@lists.oasis-open.org,
	Jason Wang <jasowang@redhat.com>,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Message-ID: <20230315075954-mutt-send-email-mst@kernel.org>
References: <20230306154817.14115-1-hengqi@linux.alibaba.com>
 <c81de233-227c-73c8-a4bd-d43aa374dd86@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <c81de233-227c-73c8-a4bd-d43aa374dd86@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] Re: [PATCH v10] virtio-net: support inner
 header hash

On Tue, Mar 14, 2023 at 11:23:55PM -0400, Parav Pandit wrote:
> If not, for now it may be better to skip vxlan and nvegre as they inherently
> have unique outer header UDP src port based on the inner header.

So what's left, GRE?  GRE is actually different, in that it's not IP at
all.

So if we are talking about GRE, hash is indeed not calculated at all at
the moment, right?  And I would say a natural first step for GRE is
actually adding a hash type that will support this protocol.

How about doing that? It seems like this should be a small step
and completely uncontroversial.


-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

