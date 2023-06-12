Return-Path: <virtio-dev-return-12938-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65E8FC7EE23
	for <virtio-dev@archiver.kernel.org>; Mon, 12 Jun 2023 06:25:52 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id A270F29FF3
	for <virtio-dev@archiver.kernel.org>; Mon, 12 Jun 2023 06:25:51 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 93059986534
	for <virtio-dev@archiver.kernel.org>; Mon, 12 Jun 2023 06:25:51 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 85B6D986486; Mon, 12 Jun 2023 06:25:51 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 72624986468
	for <virtio-dev@lists.oasis-open.org>; Mon, 12 Jun 2023 06:25:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: l6ZqFWxgPFOrqfN2hMmtLQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686551146; x=1689143146;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xO/EJv0MR+3whtouZDrF3MbVIlzXpABeF9/TW5JXY48=;
        b=Vf2joHn/5M5/DesznzB5kEqYQ+KfiLGKJzjrH2ZGvEO5uxlwEdn6EybFLbtEx+oRLF
         PSwXswD18spoihKXEeH8Qil0BtNEheUVB4WjIB0xIExVatCEzBl+g/TTWJ/nUyXdPlgw
         oGRxV4ibUUnvtxhEHWKl+YIe3Fv9l1bTOHY5dmnaVWSsgDe/hArBqrXUyZ2uL+XJhQPl
         ccWHqO0a9mZWVzWVbdq0VaBZWxtbP2CLiVUqPB+slMwiBXJvvi2DGh0aoHe7WlJItJ6w
         2nIm/CwiTxC8EfwPSlwXU/91fEC3vmtt1w8FBwoOTo56S6k2BbttqIVmBgTKgAffbLi0
         HkDw==
X-Gm-Message-State: AC+VfDyd0619yUIeIL/HAfCdv4lmei0C7sBu64s1bqY6DUVY/5XsP6EQ
	yeKUTfYLqpnRitVFeqeKzf61k3WnNbndqY3QjpmQmjTkdgI1koYglwP0CQgj9RFwV0Ut6bvtwl9
	Yh5r1YJMyHLE879BJLYEjbARCmGQ3
X-Received: by 2002:a5d:6745:0:b0:30a:e513:d596 with SMTP id l5-20020a5d6745000000b0030ae513d596mr3105749wrw.43.1686551146300;
        Sun, 11 Jun 2023 23:25:46 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6hnT324XVIjwoUgeGwbAKMp3hyuucEmHO94YUcL3c4xfsu+HhyzHnVXgk3xn+JUFBChIxDWw==
X-Received: by 2002:a5d:6745:0:b0:30a:e513:d596 with SMTP id l5-20020a5d6745000000b0030ae513d596mr3105739wrw.43.1686551146009;
        Sun, 11 Jun 2023 23:25:46 -0700 (PDT)
Date: Mon, 12 Jun 2023 02:25:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org,
	Parav Pandit <parav@nvidia.com>, Jason Wang <jasowang@redhat.com>
Message-ID: <20230612022526-mutt-send-email-mst@kernel.org>
References: <1686550355.2503424-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <1686550355.2503424-1-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: About custom device counter

On Mon, Jun 12, 2023 at 02:12:35PM +0800, Xuan Zhuo wrote:
> We hope to support device custom counter. That is, virtio spec provides a
> channel for driver and device, and both key and value are provided by device.
> 
> We discussed this issue earlier, and after some internal practice, I think it is
> still necessary to discuss this again.
> 
> It is very important, each cloud vendor will always have some special counters,
> these counters may not exist in another vendor. At the same time, if we have
> to discuss it in the spec every time we add a counter, or add a feature, I
> think it is very inconvenient. Manufacturers may add some new counters at any
> time based on some new requirements. Some counters may also be removed at any
> time.
> 
> Of course I know that doing this might hurt migration. But what I want to say is,
> why does it affect live migration? These counters we plan to give to users
> through ethtool -S, and some changes have taken place in the ethtool counters
> output by users. Does this have any practical impact? Or do we directly use
> some other output in a way, we can clearly tell the user that these counters
> may change during the migration process. For example, the driver is migrated
> to some new devices. These devices support some new counters. I think users
> should be able to see these new counters. These new counters may be the
> purpose of the migration.
> 
> We don't need to support live migration at this point.
> 
> Thanks.


Why not just document the thing?

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

