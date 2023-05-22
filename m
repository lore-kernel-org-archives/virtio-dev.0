Return-Path: <virtio-dev-return-12776-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47C52C7EE2A
	for <virtio-dev@archiver.kernel.org>; Mon, 22 May 2023 19:10:16 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 6F1F0CA670
	for <virtio-dev@archiver.kernel.org>; Mon, 22 May 2023 19:10:15 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 74C279863E7
	for <virtio-dev@archiver.kernel.org>; Mon, 22 May 2023 19:10:14 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 5914998631A; Mon, 22 May 2023 19:10:14 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 46329986327
	for <virtio-dev@lists.oasis-open.org>; Mon, 22 May 2023 19:10:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: AvlVNmboNv-zMJ61-uoTCw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684782610; x=1687374610;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZEsK6H+8XVVop6J2XP9y8pIMo6YCycGfR8NuHd7bNbw=;
        b=OQbTrAXbKY4JTSNm8fxoQZxnqzuUS3j+1+9WxNy60VnYkLeThQ3T2tz9T1UPARwv+S
         VF3mBEYL3GY1TQ2nQ96EldhBzHPGF/twLsjrciO1nqjqnQlJOZjlawEc84do0O0iIDdr
         e22ri7TPEqv74mL8ltNPXwQt0zMka4aTpg+Rx78F9bapX68UrQHPHdXzaKa3Py2iWO7u
         hW4dRbluYgTQnv48RUj/z9+lArr86+d+2XdI//IVOtYy7j05YTBvcOWZVFKtjh8R1uBG
         Xm/g9l9DWx1HvzXQsWOGUVWyB71W8mcVZJFUkJSH7cPafE97xyh+AIthi46rR5q5JXCA
         CmhA==
X-Gm-Message-State: AC+VfDz22jCHvv5C2mmZ6O/6dv25U9W+f1+mAQdDhl8775NNK+DND9PO
	2QNJ6wzVLcePQDRdw8kFfEuNxtjO4/U51OLT6MT76Frp8ecgWxCw8xowTOeWroEOoq4YqSpdD2k
	hWesLgRbo5K2ApII3Df0ZxMsXyMfY
X-Received: by 2002:a1c:cc02:0:b0:3f4:fc5e:fbf2 with SMTP id h2-20020a1ccc02000000b003f4fc5efbf2mr8574797wmb.8.1684782610070;
        Mon, 22 May 2023 12:10:10 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ67mEqYkulKuw1eqjexi0VF9E/tVrotqpOoYZIiJ55JoDw8IJJA1HKQmT5Wl1WnMNyNS+ibkw==
X-Received: by 2002:a1c:cc02:0:b0:3f4:fc5e:fbf2 with SMTP id h2-20020a1ccc02000000b003f4fc5efbf2mr8574781wmb.8.1684782609758;
        Mon, 22 May 2023 12:10:09 -0700 (PDT)
Date: Mon, 22 May 2023 15:10:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org,
	Jason Wang <jasowang@redhat.com>, Parav Pandit <parav@nvidia.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Message-ID: <20230522150743-mutt-send-email-mst@kernel.org>
References: <20230522121200.40939-1-hengqi@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <20230522121200.40939-1-hengqi@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [Proposal] Relationship between XDP and rx-csum in virtio-net

On Mon, May 22, 2023 at 08:12:00PM +0800, Heng Qi wrote:
> 1) Add a feature bit to the virtio specification to tell the sender that a fully
> csumed packet must be sent.

Who is the sender in this picture? The driver?

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

