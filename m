Return-Path: <virtio-dev-return-12210-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E3E9C77B61
	for <virtio-dev@archiver.kernel.org>; Thu, 13 Apr 2023 17:20:27 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 608793DF5F
	for <virtio-dev@archiver.kernel.org>; Thu, 13 Apr 2023 17:20:26 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id ECFFA9866B9
	for <virtio-dev@archiver.kernel.org>; Thu, 13 Apr 2023 17:20:25 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 646CE986601; Thu, 13 Apr 2023 17:20:25 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 883B89865FF
	for <virtio-dev@lists.oasis-open.org>; Thu, 13 Apr 2023 17:19:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: ketpOMFIOgiaPNt5U79MMw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681406388; x=1683998388;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jncgUJ/B0Vp+9U2pj78BUyTcKZQC5hyOuOS4128HBoM=;
        b=lViLjzJAeG3C/W6niRaT6yyJTG054XLGCf1ys7m8UD92QYk9f87oAy9MrT9LB/aIkd
         jeO9Sl7R/4kjEXbtlCemdK5PZRaflkGzoQYrrpn+TH9y7748aRSgG4caQk0BODwv+raw
         v+BorsTXImIqg4aBxvAh95eghs+yk22hiXzZ21PJeKoTmMp7xxXZBIeKn/n4IzRZ50w8
         OA9GaIxyiJOfDGKMAMv/ja1ZZFYFUNvGhlSlRMgqBA6/v8dQfvNvoU8UBnB4m2tYSSbH
         k0z/NSBQziJ57g/R5eL06ZpB/pWdWF/vEUulc18/jXo61k6/4qru45ZQbmfwZqh/Bnpl
         J39g==
X-Gm-Message-State: AAQBX9dleAMIFcR2KNT0qtb1REC2vSUqucDpz3D03cYKl4HeGYo3YDKj
	leCP5V8vtZ9GDSCaPn4mGZaxDQuS8fLgvhO+BKFWInAnRvkYA613xZLwGixbBQc4EWRpQlw5Jpn
	EzfXK8Uzc8JcosIV1ycTymV76DQ1T
X-Received: by 2002:a7b:c8ce:0:b0:3f0:ad5a:d69f with SMTP id f14-20020a7bc8ce000000b003f0ad5ad69fmr1523064wml.25.1681406388132;
        Thu, 13 Apr 2023 10:19:48 -0700 (PDT)
X-Google-Smtp-Source: AKy350YxVwTJKdJ5rGCVg2oKRRyL7OQzNbk5+os+U4MC+dYgVrQbL4ZDwdZxH/6tkhX2lhD0bYQVjQ==
X-Received: by 2002:a7b:c8ce:0:b0:3f0:ad5a:d69f with SMTP id f14-20020a7bc8ce000000b003f0ad5ad69fmr1523056wml.25.1681406387872;
        Thu, 13 Apr 2023 10:19:47 -0700 (PDT)
Date: Thu, 13 Apr 2023 13:19:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>,
	Satananda Burla <sburla@marvell.com>,
	Maxime Coquelin <maxime.coquelin@redhat.com>,
	Yan Vugenfirer <yan@daynix.com>
Message-ID: <20230413130326-mutt-send-email-mst@kernel.org>
References: <PH0PR12MB548118F57BB4B4A4F8DC9D7ADC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEvYsz1fSPG+fKpRaZ05Ut7ffKwvMPvR8xbRBsXA_6vGQw@mail.gmail.com>
 <PH0PR12MB548137D7A25C99EAA42B4D12DC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEshW82qztmGw8YJWJ8=QCoRd6cPxQ+ySazxsO_o+U6c4Q@mail.gmail.com>
 <PH0PR12MB548147CF939CB9C2A0586310DC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEu2B_GogDR9HUwB7mT8fkGh+Q_buPLz4nhwhK7h9k6BQQ@mail.gmail.com>
 <PH0PR12MB5481F0CF5A555A6BB2CE856CDC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEuNOYOxvcSzrs0UFEyk+xOkGUpOfhK8rOy_Mebz5b5wdg@mail.gmail.com>
 <a74d3107-d38c-df15-e2ff-f848635f24bd@nvidia.com>
 <CACGkMEt+bGN7UYEopXPj0+deAnYm1VUNp05VvGHcJnkd8LzbGg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEt+bGN7UYEopXPj0+deAnYm1VUNp05VvGHcJnkd8LzbGg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] Re: [PATCH 09/11] transport-pci: Describe PCI
 MMR dev config registers

On Thu, Apr 13, 2023 at 01:14:15PM +0800, Jason Wang wrote:
> > >>>> The proposed solution in this series enables it and avoid per field sw
> > >>> interpretation and mediation in parsing values etc.

... except for reset, notifications, and maybe more down the road.


> > >>> I don't think it's possible. See the discussion about ORDER_PLATFORM and
> > >>> ACCESS_PLATFORM in previous threads.
> > >>>
> > >> I have read the previous thread.
> > >> Hypervisor will be limiting to those platforms where ORDER_PLATFORM is not needed.
> > >
> > > So you introduce a bunch of new facilities that only work on some
> > > specific archs. This breaks the architecture independence of virtio
> > > since 1.0.
> > The defined spec for PCI device does not work today for transitional
> > device for virtualization. Only works in limited PF case.
> > Hence this update.
> 
> I fully understand the motivation. I just want to say
> 
> 1) compare to the MMIO ar BAR0, this proposal doesn't provide much advantages
> 2) mediate on top of modern devices allows us to not worry about the
> device design which is hard for legacy

I begin to think so, too. When I proposed this it looked like just a
single capability will be enough, without a lot of mess.  But it seems
that addressing this fully is getting more and more complex.
The one thing we can't do in software is different header size for
virtio net. For starters, let's add a capability to address that?

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

