Return-Path: <virtio-dev-return-11675-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AD0BC74A5B
	for <virtio-dev@archiver.kernel.org>; Tue, 21 Mar 2023 09:06:00 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id B168626A56
	for <virtio-dev@archiver.kernel.org>; Tue, 21 Mar 2023 09:05:59 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8E22E98646A
	for <virtio-dev@archiver.kernel.org>; Tue, 21 Mar 2023 09:05:59 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 7B78B98642A; Tue, 21 Mar 2023 09:05:59 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 63A6298643E
	for <virtio-dev@lists.oasis-open.org>; Tue, 21 Mar 2023 09:05:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: Jie-1cgyNxu0iL-5eZx6zw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679389554;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L4Fl/1d9Rvh8rETH9822Klufr7ZEtmXiSFNUPC5+ccY=;
        b=CYrsr4evTICmGQhYQF5yAt1Pe4n/P2UEl5EIqegANo3GpZ2wV+jP8/JetPRXVd8Pzz
         m+vNZ2Yo3ieGcF4nT7RNXvFmehLFPMYJHSbIBsAn7/ghuTiWKDEAlD2h/MZJnSSC4RHP
         z+8j0nKk6atc5M8v1UsNFbStNP35KD6TRALLo2yrO0yhgeQEZuKtMUJ6t0UmNuQoDrHO
         yJ3B7qwHJmHxkb+kRLg1DHmzVq9aljtMY6jNCEjxuKpBPH37NkT3Ur9MmnzuTsycMWQO
         heRnSsttL+35Vy5ssx278Y/I7WlBAmPgJeBAADnZc8k5hE/BilpSQnJrzYI7znqcQ5Cx
         HYhQ==
X-Gm-Message-State: AO0yUKVcaTeIePnFuMPbcc43eAUg7Rd8YtIv8v8VwIh19z2BFDmidbFs
	wUFO8VCsoqJowVeHHIMaeSgVxLdHExch0HN0xzp9HQlA+ccNL+SRiuI6XpzNLMerc70ur0DZXov
	GAr9SZket2399yLnKRLWjFIVvt8AR
X-Received: by 2002:a5d:53c5:0:b0:2d0:8d4e:43c6 with SMTP id a5-20020a5d53c5000000b002d08d4e43c6mr1429521wrw.65.1679389554439;
        Tue, 21 Mar 2023 02:05:54 -0700 (PDT)
X-Google-Smtp-Source: AK7set+cSkwKQq0QjcjVr/BadhyvadHKT6J8YqL0HqpGA/KVTHOTVaXlma9Wp+JEmo9EEMF3PZKp9w==
X-Received: by 2002:a5d:53c5:0:b0:2d0:8d4e:43c6 with SMTP id a5-20020a5d53c5000000b002d08d4e43c6mr1429501wrw.65.1679389554094;
        Tue, 21 Mar 2023 02:05:54 -0700 (PDT)
Date: Tue, 21 Mar 2023 05:05:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: virtio-dev@lists.oasis-open.org, pasic@linux.ibm.com, cohuck@redhat.com,
	virtio-comment@lists.oasis-open.org, shahafs@nvidia.com
Message-ID: <20230321050119-mutt-send-email-mst@kernel.org>
References: <20230321041036.201439-1-parav@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230321041036.201439-1-parav@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v2 0/7] Rename queue index to queue number

On Tue, Mar 21, 2023 at 06:10:29AM +0200, Parav Pandit wrote:
> 1. Currently, virtqueue is identified between driver and device
> interchangeably using either number of index terminology.
> 
> 2. Between PCI and MMIO transport the queue size (depth) is
> defined as queue_size and QueueNum respectively.
> 
> To avoid confusion and to have consistency, unify them to use as Number.
> 
> Solution:
> a. Use virtqueue number description, and rename MMIO register as QueueSize.
> b. Replace virtqueue index to virtqueue number
> c. RSS area of virtio net has inherited some logic, describe it
> using abstract rq_handle.
> 
> Patch summary:
> patch-1 renames index to number for pci transport
> patch-2 renames mmio register from Num to Size
> patch-3 renames index to number for mmio transport
> patch-4 renames num field to size for ccw transport
> patch-5 renames index field to queue_select for ccw transport
> patch-6 for virtio-net removes duplicate example from requirements
> patch-7 for virtio-net updates rss description to use vq number
> 
> This series only improves the documentation, it does not change any
> transport or device functionality.
> 
> Please review.
> This series fixes the issue [1].
> 
> [1] https://github.com/oasis-tcs/virtio-spec/issues/163

OK overall but I feel this lacks a definition of what a virtqueue number
is in some transport and device independent place.
Maybe in the virtqueues chapter?
Just "
Each virtqueue is identified by a 0 based virtqueue number. Thus
virtqueues are numbered 0,1,2 and so on.
"

will do.

> ---
> changelog:
> v1->v2:
> - added patches for virtio net for rss area
> - added patches for covering ccw transport
> - added missing entries to refer in mmio transport
> 
> Parav Pandit (7):
>   transport-pci: Refer to the vq by its number
>   transport-mmio: Rename QueueNum register
>   transport-mmio: Refer to the vq by its number
>   transport-ccw: Rename queue depth/size to other transports
>   transport-ccw: Refer to the vq by its number
>   virtio-net: Avoid duplicate receive queue example
>   virtio-net: Describe RSS using receive queue handle
> 
>  device-types/net/description.tex | 26 +++++++++++----
>  transport-ccw.tex                | 39 +++++++++++++++-------
>  transport-mmio.tex               | 56 +++++++++++++++++++-------------
>  transport-pci.tex                |  6 ++--
>  4 files changed, 84 insertions(+), 43 deletions(-)
> 
> -- 
> 2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

