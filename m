Return-Path: <virtio-dev-return-13979-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83070E7109E
	for <virtio-dev@archiver.kernel.org>; Wed, 27 Sep 2023 21:44:02 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id BB2F5613CF
	for <virtio-dev@archiver.kernel.org>; Wed, 27 Sep 2023 21:44:01 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8FDA9986511
	for <virtio-dev@archiver.kernel.org>; Wed, 27 Sep 2023 21:44:01 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 72AA7983FE2; Wed, 27 Sep 2023 21:44:01 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5B6669862F5
	for <virtio-dev@lists.oasis-open.org>; Wed, 27 Sep 2023 21:44:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: wj1CCfiRMX29LOOm5sNIbw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695851036; x=1696455836;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SW+uFED85GiHwNzDD3A2v8vk0SEOM3fROn/d6oEzLC4=;
        b=Xy4kKR/MggHXDyLVRJt7qCuHIVaXqD1zgEykHNo9h0b+TMIES3tE68M9Unaf2w/WfK
         e9PcAkLs005ysV0z5M3afZ4qO4DJufqGb4/TBy5OwZVSPwQYCpTT/5ykRK5HZSCXp+Bg
         RgsaXQprkLkiloIC9BmvyvWYuSMcofgqp7KUBtZn9Y6RKGhpZIqlIn/QqH60O/BtYHDQ
         eQzRbHOmsSC1nONpQtExiEIF3FazHuTd7g1SEO3qJzBt9dxd86CA9SvooAIz4kJVlkbC
         8PEms9nai6B5H6xrHjmw4UOcOs5aJbVjr9d/clr0X5iTc+lqlRzJuwpXhOzLDOPiC739
         f2tQ==
X-Gm-Message-State: AOJu0YzXZHlYW+6PirvGahqoxp5yj7peja3cONUJdCPRktxLEwlc6uow
	ykl3unbL6+xz0qkQqfORrmVzH41arA1ooKo9NINdvJiXdRRxjeiY6z4qHDlYoJX5FArkK1gu1vn
	kHbZgTeOiiYDphttqoxl6zeEJexZu
X-Received: by 2002:a05:600c:229a:b0:405:358c:ba74 with SMTP id 26-20020a05600c229a00b00405358cba74mr5893541wmf.0.1695851036670;
        Wed, 27 Sep 2023 14:43:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCQYj2ManDW9LGEjIvbjygXYnmf4gMHt8x9K9MyKE3lZUMoApHUa0j/l1JdZ3aFKT2a/PZfg==
X-Received: by 2002:a05:600c:229a:b0:405:358c:ba74 with SMTP id 26-20020a05600c229a00b00405358cba74mr5893535wmf.0.1695851036326;
        Wed, 27 Sep 2023 14:43:56 -0700 (PDT)
Date: Wed, 27 Sep 2023 17:43:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Jason Wang <jasowang@redhat.com>,
	"Zhu, Lingshan" <lingshan.zhu@intel.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Message-ID: <20230927174152-mutt-send-email-mst@kernel.org>
References: <PH0PR12MB5481ABF4B9BC2082BC54AB1DDCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230918144312-mutt-send-email-mst@kernel.org>
 <bb402c34-ad07-063a-f4f5-d8c6b3a642c7@intel.com>
 <20230920054836-mutt-send-email-mst@kernel.org>
 <CACGkMEsn+9AqgmurN8-GXkcu8UxAr62_woJn3XZN+oUkTQNPUg@mail.gmail.com>
 <PH0PR12MB5481830365A80EF4583A3FFADCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEshxAU3Mjo7vczBNRb=P=FnenO4mPb9HJL0Ma3ZRbe-oA@mail.gmail.com>
 <PH0PR12MB548172996D62E37714A9776BDCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEtW88zJkDQL58NqLzzudq=f+SmzJ8bha55Dd2fd=FRGBQ@mail.gmail.com>
 <PH0PR12MB5481573D6EE3BE03FB7C3D70DCFCA@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481573D6EE3BE03FB7C3D70DCFCA@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: Re: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and
 vq state

On Mon, Sep 25, 2023 at 10:41:12AM +0000, Parav Pandit wrote:
> 
> 
> > From: Jason Wang <jasowang@redhat.com>
> > Sent: Friday, September 22, 2023 8:38 AM
> 
> > > Device context has no overlap.
> > 
> > I can give you one example, e.g debugging.
> >
> Almost every feature needs debugging. :)
> So I am omitting it for time being.
> 
>  
> > >
> > > Dirty page tracking has no overlap. What do you want to profile and monitor?
> > In case if you want to profile, it can be used without migration command
> > anyway?
> > 
> > It works like a dirty bit of PTE. We all know it has a broader use case than
> > logging. For example, tracking working set and do optimization on
> > IOMMU/IOTLB or even device IOTLB.
> > 
> > 1) Try to prove your facility can only work for one specific cases
> > 2) Try to prove your facility can work for more than one cases
> > 
> > Which one is easier and more beneficial to virtio?
> > 
> > 
> > > If you describe, may be we I can split "device migration" chapter to
> > > two pieces, Device management and device migration.
> > >
> > > Device migration will use these basic facility.
> > > Would that help you?
> > 
> > Definitely, but it needs to be done by not making it under the subsection of
> > admin commands, that's it.
> > 
> > Let me repeat once again here for the possible steps to collaboration:
> > 
> > 1) define virtqueue state, inflight descriptors in the section of basic facility but
> > not under the admin commands
> It will be part of the device context such a way that so that one can only read the vq state only instead of full device context.
> This will work.
> 
> > 2) define the dirty page tracking, device context/states in the section of basic
> > facility but not under the admin commands
> Great.
> Device context is already defined in the basic facility outside of the admin commands in [1].
> Current text is around device migration and spec evolves it can adopt more generic text without device migration.
> 
> [1] https://lists.oasis-open.org/archives/virtio-comment/202309/msg00064.html
> 
> > 3) define transport specific interfaces or admin commands to access them
> >
> As you also envisioned, it is done using admin commands to access it.
> 
> > Does this work? It seems you refused such steps in the past.
> > 
> I didn’t.
> There must be some confusion in many emails we both exchanged, because already posted v0 has it split such as device context.
> 
> For dirty page tracking I couldn’t find a solid use case without device migration, so I asked which you already replied above.
> 
> > Actually, I would like to leave 2) as it's very complicated which might not
> > converge easily.
> >
> I will split current "device migration" section to two.
> 1. device management
> 2. device migration
> 
> Device management covers device mode, device context and dirty page tracking.
> Device migration refers to device management section.
> 
> We can omit the dirty page tracking commands for a moment and first close on the device mode and device context as first step.
> Since it is already part of v0 and it is needed, I will keep it in subsequent v1 but moved to device management section.
> 
> Michael,
> Are you ok with this approach to step forward?

I actually like it that your current series is more or less complete.
I would rather you did not drop parts of functionality, for me at least
it's hard to see how things will work otherwise.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

