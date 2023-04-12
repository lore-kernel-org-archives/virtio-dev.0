Return-Path: <virtio-dev-return-12181-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19B63C7619A
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Apr 2023 05:12:17 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 672DA3250
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Apr 2023 05:12:16 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5CD0F986549
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Apr 2023 05:12:16 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 51F10986509; Wed, 12 Apr 2023 05:12:16 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 40A4F98650E
	for <virtio-dev@lists.oasis-open.org>; Wed, 12 Apr 2023 05:12:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: bxvIQwruNrunkCo_onRVcg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681276328;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e/d3A4gx6awjnCS+UqmFyZ2zuplRG02Yk/eSwjUAJo8=;
        b=zarAndEj4b/PG1FDS3/sxOIpRSbIzCQV4gRArElIzUJI7dgJtY/do9sSHXLULX2QQP
         /AxvgjbTbHiiymOF7yYnUDknJA+IAKJuRAo21GhE2d1JCadqYyxO+t9j9SXSr0ZCa/tg
         6y7pJjpzH09pyzaEuxVYuLSq7dmkz0vBWbZDAlfC8XUi0KYBCS0SNxQU898D6xXRSydA
         DJb+1DdN3oqHuoBjXS7PKvA8eQj8GSsmnE0sTKKW5pn4pcathBoYN3UOK9+CIoLMvudg
         jmWpd0/Qucs2RFoawmjVV1qCn5wd+jDOf94vKfOt05/D2tQXhZFVVTUSJxvONSu7aGVq
         EpEg==
X-Gm-Message-State: AAQBX9eIWz8xktPJzM14h4tq065pbvWcVSm6LUEo+kxeHydDipuLTeWb
	jisx6ijpmwouaiK2m/Eq4uWCco21Q9EE4uZ9xhsw2vZ0rwGR++CThw8w/NFecyuBvlLUjW0vZdA
	I+jxTybnKyGnbFNm9P+pUYU+Woor6
X-Received: by 2002:a7b:cb45:0:b0:3ed:2eb5:c2dd with SMTP id v5-20020a7bcb45000000b003ed2eb5c2ddmr8492750wmj.39.1681276328105;
        Tue, 11 Apr 2023 22:12:08 -0700 (PDT)
X-Google-Smtp-Source: AKy350bXTUapFTahVvq7aao4ki/GmR2Qf4y9Q9fdL7WZoCtVpOI5drrVDODleCRvW/uGp80Wj33cCg==
X-Received: by 2002:a7b:cb45:0:b0:3ed:2eb5:c2dd with SMTP id v5-20020a7bcb45000000b003ed2eb5c2ddmr8492739wmj.39.1681276327825;
        Tue, 11 Apr 2023 22:12:07 -0700 (PDT)
Date: Wed, 12 Apr 2023 01:12:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Message-ID: <20230412010437-mutt-send-email-mst@kernel.org>
References: <20230330225834.506969-1-parav@nvidia.com>
 <20230412004331-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481EC4B82A0A57F08ABF3F7DC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481EC4B82A0A57F08ABF3F7DC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH 00/11] Introduce transitional mmr pci device

On Wed, Apr 12, 2023 at 04:52:09AM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Wednesday, April 12, 2023 12:48 AM
> 
> > Here is a counter proposal:
> > 
> > #define VIRTIO_NET_F_LEGACY_HEADER  52      /* Use the legacy 10 byte
> > header for all packets */
> > 
> > 
> > Yes, sorry to say, you need to emulate legacy pci in software.
> > 
> > With notification hacks, and reset hacks, and legacy interrupt hacks, and
> > writeable mac ...  this thing best belongs in vdpa anyway.
> 
> What? I don't follow.
> Suddenly you attribute everything as hack with least explanation.
> 

Again hacks is not a bad thing but it's an attempt at reusing things in
unexpected ways.

New issue I found today:
- if guest disables MSI-X host can not disable MSI-X.
  need some other channel to notify device about this.

Old issues we discussed before today:
- reset needs some special handling because real hardware
  can not guarantee returning 0 on the 1st read
- if guest writes into mac, reusing host mac (which is RO)
  will not work, need extra registers
- something about notification makes you want to poke
  at modern notification register? which of course
  is its own can of worms with VIRTIO_F_NOTIFICATION_DATA
  changing the format completely.


-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

