Return-Path: <virtio-dev-return-11677-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 734B0C6FD1D
	for <virtio-dev@archiver.kernel.org>; Tue, 21 Mar 2023 09:31:23 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id C55098748B
	for <virtio-dev@archiver.kernel.org>; Tue, 21 Mar 2023 09:31:22 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B7ACB986451
	for <virtio-dev@archiver.kernel.org>; Tue, 21 Mar 2023 09:31:22 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id ABC7D983DFC; Tue, 21 Mar 2023 09:31:22 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9BDE09863AC
	for <virtio-dev@lists.oasis-open.org>; Tue, 21 Mar 2023 09:31:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 0x3Y515ONnWcsSyg0NLwvg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679391079;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JzIbcr02G+W33S0WHGH17YzYkpk0gSkaDy9iXkeytME=;
        b=sUXN6IaZtiQL3fmXC0xfcbnT+9iDfa2bbTTqnU0YZYn5dD1HHXktrliUaothc/IFRb
         HZxSdkCi1HL/WKqtIVahno47l7btlBtZzVeH2uwKWi4iByHIql9MkKzyFRxJf3XmYZtf
         34C0buMF7YbRUlP5oHpEVoN3jQ+ha+9jEhOJFCGj79/2yQroGhwB0Tmd8YOu2scpK2HZ
         +8KQmRkxOTSn3TjFOu7dHESFwWuBtGDYnRbbuZjMAj6M1u/RtrqmOr8NRUgwLhLox4QE
         k2Q8tirRW2wMx1Bq9t11cg8mbyLMwkb39Pudjju55ZYuw8N7YvzVb97rPcIuKCSKL3Fj
         5K1Q==
X-Gm-Message-State: AO0yUKX4GqiDVl5B9redY7KPEYeAsT6P0mJdCLlwo91O59X5cGYM3y2w
	KspKw7NFXC5lWb6M+AGXjwPBnsRdHDD+zXy+qSAZ2WN5godGyEPa+d5jE5sUkR5qvo6mWQ2I8eP
	5S+rL4ncuVICtCABgy/1EwP9gKIrw
X-Received: by 2002:a05:600c:3794:b0:3eb:3947:41ea with SMTP id o20-20020a05600c379400b003eb394741eamr1733369wmr.37.1679391079368;
        Tue, 21 Mar 2023 02:31:19 -0700 (PDT)
X-Google-Smtp-Source: AK7set83a5kLYPxQseCGwbQfy54bilEAioFTvGeK+Skdq+MwCc/6WvQtJpuPIWOCAFRkLmB42AcqKw==
X-Received: by 2002:a05:600c:3794:b0:3eb:3947:41ea with SMTP id o20-20020a05600c379400b003eb394741eamr1733357wmr.37.1679391079123;
        Tue, 21 Mar 2023 02:31:19 -0700 (PDT)
Date: Tue, 21 Mar 2023 05:31:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: Cornelia Huck <cohuck@redhat.com>, virtio-dev@lists.oasis-open.org,
	virtio-comment@lists.oasis-open.org,
	Parav Pandit <parav@nvidia.com>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	David Edmondson <david.edmondson@oracle.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Message-ID: <20230321053045-mutt-send-email-mst@kernel.org>
References: <20230312124628.8527-1-hengqi@linux.alibaba.com>
 <87cz53js85.fsf@redhat.com>
 <99f20219-931a-7b67-9768-0c2f8f32d16e@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <99f20219-931a-7b67-9768-0c2f8f32d16e@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] [PATCH v12] virtio-net: support the virtqueue
 coalescing moderation

On Tue, Mar 21, 2023 at 10:41:55AM +0800, Heng Qi wrote:
> Yes, I think you are right. I see that the voting has already started, do I
> need to wait for the voting to end and repost a new version based on the
> results?

We can always cancel the vote, just ask.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

