Return-Path: <virtio-dev-return-13999-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9441CDB482
	for <virtio-dev@archiver.kernel.org>; Thu, 12 Oct 2023 10:03:26 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 45CBA7BAF1
	for <virtio-dev@archiver.kernel.org>; Thu, 12 Oct 2023 10:03:26 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 240D198683A
	for <virtio-dev@archiver.kernel.org>; Thu, 12 Oct 2023 10:03:26 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 0352A986474; Thu, 12 Oct 2023 10:03:26 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E79DB98660E
	for <virtio-dev@lists.oasis-open.org>; Thu, 12 Oct 2023 10:03:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: SCtfBNd0M9GmFFmw0CGoIw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697105003; x=1697709803;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M62v0Gq8hQyDKYn0ak83r88Nch9qHOT1pYlWXgZLzlo=;
        b=RNHAOxMDHWI0R4hXVNGlh+dEZ5ASeXckroj/2lQHi3n/fQUBzcTQLhCWPa1yAbU/qX
         VlvUU2ZG9lvrlK0pIUyHf56CRP/vkvDGZhggy0bXekFIERbzHlThUGIGr079zkOMC6dg
         LP/AX1R6XzhMwu/ZinOqtz/3O6j0ExN22VcmbvrzqI/Gq/9BD+8XQx1lOYoVLkmv8aR8
         8vBlUXt+9H9CpaD9HwBJ69dW/HlLP7mW7+aQqA8Slte/rjNjobJrVmeaxdjA09yEWDlI
         hI2VmI+Kg3WNn5iW3ZXC9doLedKUX9b2rKZT81IKk+tD+RzAZgI7IMvh0I9U8tHcIPr4
         S6+g==
X-Gm-Message-State: AOJu0Yx7icgHA6q1ZsbSr0aj6MDgr+PwdUzyROtfffzxk6cgIMiF+f6j
	wmNv8ANY6Jbs54YawNEVYsxHQxOWtHZyugolu1b3266S7TqoXdSboMcXmg9Ra5RTND0cyRwXp3c
	Dd8bKyuu/x7eYBuKAGkU4+6fWCnqp
X-Received: by 2002:a05:600c:2154:b0:401:519:c9 with SMTP id v20-20020a05600c215400b00401051900c9mr20707677wml.13.1697105002920;
        Thu, 12 Oct 2023 03:03:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbCAhhBSZTgGCvg5bYcEy0aVlDFx5WjIaQrxj+zLp3RARAIfgqr+JQwQw4u53F9Fd+0BMuxg==
X-Received: by 2002:a05:600c:2154:b0:401:519:c9 with SMTP id v20-20020a05600c215400b00401051900c9mr20707660wml.13.1697105002543;
        Thu, 12 Oct 2023 03:03:22 -0700 (PDT)
Date: Thu, 12 Oct 2023 06:03:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>,
	"Zhu, Lingshan" <lingshan.zhu@intel.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Message-ID: <20231012060042-mutt-send-email-mst@kernel.org>
References: <PH0PR12MB5481830365A80EF4583A3FFADCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEshxAU3Mjo7vczBNRb=P=FnenO4mPb9HJL0Ma3ZRbe-oA@mail.gmail.com>
 <PH0PR12MB548172996D62E37714A9776BDCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEtW88zJkDQL58NqLzzudq=f+SmzJ8bha55Dd2fd=FRGBQ@mail.gmail.com>
 <PH0PR12MB5481573D6EE3BE03FB7C3D70DCFCA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEvOxraeVB-5g7dJ-KBN=63kpmDfDdqaiQVyDh8egDjsGw@mail.gmail.com>
 <PH0PR12MB5481C11F6D68A892A091E2AFDCC3A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEvtyDXKHE4w9uH_9eqbckTGF8fZkNUuKr+mkzP0o31z_w@mail.gmail.com>
 <PH0PR12MB548182A6DC73C850462B546EDCC3A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEvLjV4Q8ETHCfVEiqnN1awLiogR79t3VEHTNXZk5qsQdw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEvLjV4Q8ETHCfVEiqnN1awLiogR79t3VEHTNXZk5qsQdw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: Re: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and
 vq state

On Mon, Oct 09, 2023 at 04:49:33PM +0800, Jason Wang wrote:
> > If something is needed for debug please proceed to add such debug interface.
> 
> Most debugging is simply the dumping of device states so I don't know
> what you want to say here.

Donnu about Parav but I want to say that I'd like to see driver
support for the debugging interface before we add it to
spec. General "may be useful" doesn't cut it  - too easy to
justify anything by "debugging".


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

