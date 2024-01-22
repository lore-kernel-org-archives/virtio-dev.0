Return-Path: <virtio-dev-return-14260-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A487C47DD3
	for <virtio-dev@archiver.kernel.org>; Mon, 22 Jan 2024 07:36:33 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 6E2F071F43
	for <virtio-dev@archiver.kernel.org>; Mon, 22 Jan 2024 07:36:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5D01A9866D8
	for <virtio-dev@archiver.kernel.org>; Mon, 22 Jan 2024 07:36:32 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 4FE35986542; Mon, 22 Jan 2024 07:36:32 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3C9F1986530
	for <virtio-dev@lists.oasis-open.org>; Mon, 22 Jan 2024 07:36:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 50rMsjhIP4CCIN1ZERHkIg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705908985; x=1706513785;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t3PFvBnaiKejuiLaUjd3NDS98s4hhkvPqYlfpAgJyDE=;
        b=VmvZYbu2c9I36iTzL/zndeknkVZqNI8MppOPQg4uTuYvOuFjvoKM5gmyfbiRP18ZTT
         X290EJdXQzybFPAHareAyRjbJDK+4rfIT8eW7z+rkY3i+nPuXSqocnnSfOX+54hvuO4o
         hHX4P/j2E0T369iWfjHdcOjdISIUjYj2TmMA1ncy6B3x++aPxZ5GU9LTJMnYWGAYehLB
         EV5WvYJ3PKWrzo/BLpoKiuKBBBZFhv+AqioAR1mpFiuxwIQOa9ngDnl0mAQU4EFd7oNc
         Ikc5r/Tq9+J0CQy+RbN9/G60S/lCnTp7VOSyDK+0m4vFEm0wCSiJukUPhHfHs6BYPf6i
         5Oow==
X-Gm-Message-State: AOJu0YxJy4NgaiLQvXNhvGLOvg59Cu/XhLYKL66bfgATZHW4QuYxFaMn
	Pdr1PgcOUgleUWM4Ei998lwnqC+n6no6h5fKOThrFj2LP+7d6NYVYPu7OeoJY5wNk6ld0O259k7
	thvJxEH6RWkxHxYyXjXK3gH++jEl9oBgjfBFesw8LQ+RrixC3bLFw/igGpODnp9WNLw==
X-Received: by 2002:a0d:eb81:0:b0:5d4:90a:c3bc with SMTP id u123-20020a0deb81000000b005d4090ac3bcmr2054287ywe.30.1705908985073;
        Sun, 21 Jan 2024 23:36:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEgm3FTl4JcBxgK8mPS9AZf/Nel7GOQM5AAgqxNmNaOcH3/8eQQanWdeIh0omEI0wvrTjruWA==
X-Received: by 2002:a0d:eb81:0:b0:5d4:90a:c3bc with SMTP id u123-20020a0deb81000000b005d4090ac3bcmr2054278ywe.30.1705908984783;
        Sun, 21 Jan 2024 23:36:24 -0800 (PST)
Date: Mon, 22 Jan 2024 02:36:19 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Message-ID: <20240122022002-mutt-send-email-mst@kernel.org>
References: <1705323962-96063-1-git-send-email-hengqi@linux.alibaba.com>
 <PH0PR12MB5481EA21646CEA571FF2D3F9DC6C2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <3977e2c2-f514-4b51-a646-6f729df7403d@linux.alibaba.com>
 <DM8PR12MB5480872B5E7A67D65325485BDC772@DM8PR12MB5480.namprd12.prod.outlook.com>
 <db56402e-2432-4902-b58d-6b43a4f1dd0e@linux.alibaba.com>
 <PH0PR12MB5481E1A236C868B671275DCBDC752@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481E1A236C868B671275DCBDC752@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] RE: [virtio-dev] RE: [virtio-comment] [PATCH
 v2] virtio-net: support setting coalescing params for multiple vqs

On Mon, Jan 22, 2024 at 05:03:38AM +0000, Parav Pandit wrote:
> > >>> The right test on Linux to do without rtnl lock which is anyway ugly
> > >>> and
> > >> wrong semantic to use blocking the whole netdev stack.
> > >>> (in case if you used that).
> > >> Do you have any good directions and attempts to remove rtnl_lock?
> > >>
> > > I think per device lock instead of rtnl is first step that we can start with.
> > 
> Wil check internally who if someone already started working on it.

I feel the issue is at the conceptual level. Yes some drivers will take
a command and just queue it for execution later, but this means that
errors can not be propagated back at all. Imagine device with mac
0x123 in promisc mode. Now commands:

1- program MAC 0xabcdef
2- disable promisc mode

If command 1 fails but 2 proceeds then packets with MAC 0xabc
will be dropped.

Any attempts to batch arbitrary commands will have this issue -
be it at driver or device level.

So, here's my question: what exactly is the guest behaviour
that is driving this work? Is it with a linux guest? which
commands does userspace issue that we need to send multiple
vq coalescing commands? If all you want is to send
same config to all VQs then why not just use
VIRTIO_NET_CTRL_NOTF_COAL_RX_SET as opposed to
VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET ?


-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

