Return-Path: <virtio-dev-return-12234-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4504EC77B73
	for <virtio-dev@archiver.kernel.org>; Fri, 14 Apr 2023 06:57:27 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 464582A830
	for <virtio-dev@archiver.kernel.org>; Fri, 14 Apr 2023 06:57:25 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2799A986617
	for <virtio-dev@archiver.kernel.org>; Fri, 14 Apr 2023 06:57:25 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 1819C986600; Fri, 14 Apr 2023 06:57:25 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 075EA986601
	for <virtio-dev@lists.oasis-open.org>; Fri, 14 Apr 2023 06:57:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: hBuM0bdJM2Gkj4dMAVW5tQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681455441; x=1684047441;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FIO4F73JjJRpQcQnEl7LSbyxcLjDiN2ALWxD6WZNmv4=;
        b=hDzTq2avmsSL377zqWYZFsP09/LREVBTTIquigojhGYRzjO+U03CaXOvObxxehKBrR
         GOhZeqt/nEh9c0r+rXL8sA+kbEd1XNRWHnCYk4sn1tDFtKcUlLi2C8FaQwV2ti4ZqTOZ
         vLQQUS3tI3pML+8qmlLIA1kNtF2cP5zrVwZ6kRcWUvjuu3Dte83N4AS+N4sNTxpByLHT
         K5vqhCceP9czKqAZgZg5fIalTo2+S44zGrfEkAo/DM1fDPY/vQu++4xjM2dTyKanrnCA
         F53JY5YiChjjqqtY4Vg/UZ8ViiPQ2yKID6Ode5aakBXjuKty4bEBf628msqruh97U3Ip
         E3JA==
X-Gm-Message-State: AAQBX9e7NrTMmfh/b/hI1MxMbqSCYknmPoQB9nnR0vcwrMucfk9O1/Fp
	yrL7RML++AxZc/zbE1oCA8K2xYQ0X0jtRYjJCS3ZzA0d4AvPInajE9JeMQZGnPZNUi8/YNDYCuZ
	GVf5PIOoA7RlZzjh3J2IDvHJH1hhe
X-Received: by 2002:adf:e305:0:b0:2e4:c0b5:fdcb with SMTP id b5-20020adfe305000000b002e4c0b5fdcbmr3305855wrj.28.1681455441198;
        Thu, 13 Apr 2023 23:57:21 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZoYdL7vvB4oQth32PdEWdUhqmZCqTUmo/Iy8oeeSd63/lcDYVLMp5nIYj51g9lRsX+5hL4zg==
X-Received: by 2002:adf:e305:0:b0:2e4:c0b5:fdcb with SMTP id b5-20020adfe305000000b002e4c0b5fdcbmr3305838wrj.28.1681455440819;
        Thu, 13 Apr 2023 23:57:20 -0700 (PDT)
Date: Fri, 14 Apr 2023 02:57:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Jason Wang <jasowang@redhat.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>,
	Satananda Burla <sburla@marvell.com>,
	Maxime Coquelin <maxime.coquelin@redhat.com>,
	Yan Vugenfirer <yan@daynix.com>
Message-ID: <20230414025523-mutt-send-email-mst@kernel.org>
References: <CACGkMEu2B_GogDR9HUwB7mT8fkGh+Q_buPLz4nhwhK7h9k6BQQ@mail.gmail.com>
 <PH0PR12MB5481F0CF5A555A6BB2CE856CDC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEuNOYOxvcSzrs0UFEyk+xOkGUpOfhK8rOy_Mebz5b5wdg@mail.gmail.com>
 <a74d3107-d38c-df15-e2ff-f848635f24bd@nvidia.com>
 <CACGkMEt+bGN7UYEopXPj0+deAnYm1VUNp05VvGHcJnkd8LzbGg@mail.gmail.com>
 <f9f01f9d-f6ec-0daa-a11d-c75589dcbe6c@nvidia.com>
 <20230413163216-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54818B39801152ECBA138E73DC989@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEtMKqzN3E9S-pusTr=doYRtDvTZUie2PrygzPiH0p5fvg@mail.gmail.com>
 <PH0PR12MB5481EEEE5BFE68CDC6628455DC999@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481EEEE5BFE68CDC6628455DC999@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [virtio-comment] Re: [PATCH 09/11] transport-pci: Describe PCI
 MMR dev config registers

On Fri, Apr 14, 2023 at 02:43:21AM +0000, Parav Pandit wrote:
> 
> > From: Jason Wang <jasowang@redhat.com>
> > Sent: Thursday, April 13, 2023 10:37 PM
> 
> > I'm not sure I get this. With VIRTIO_NET_F_LEGACY_HEADER, we don't need
> > mediation for datapath. For the control path, mediation is a must for legacy and
> > it's very easy to keep it work for modern, what's wrong with that?
> 
> There is virtio PCI VF.
> The user who attaches this VF to the VM, it doesn’t know if its guest is to run legacy driver or 1.x
> Hence hypervisor doesn’t want to run special stack when guest may (likely) be 1.x and device also supports 1.x.
> 
> Therefore, MMIO BAR 0 emulation is better solution in this use case without any mediation.
> The current specification claim that transitional device "works", hence it is fine to extend BAR0 to be of MMIO type instead of IO type.
> 
> In some other cases control path or additional other mediation can be done.

Do you refer to the trick Jason proposed where BAR0 is memory but
otherwise matches legacy BAR0 exactly? Is this your preferred
solution at this point then?

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

