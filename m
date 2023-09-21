Return-Path: <virtio-dev-return-13897-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47DEBCD494B
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 04:02:43 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id ABB217A089
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 04:02:42 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A428398668A
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 04:02:42 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 97F25983D6F; Thu, 21 Sep 2023 04:02:42 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8A80798667C
	for <virtio-dev@lists.oasis-open.org>; Thu, 21 Sep 2023 04:02:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 8plzT_dxPZGeQN4rMxNgkA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695268957; x=1695873757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q3CBdKyILBp28VnJEa5zG61NOexWm9hUrQDNPRcpQak=;
        b=vauGs9IjhV8+pmgTcwVN8dOeSwxTeP1OZuTNdwqgNygwBD89xPC+apC8jFKwn0J6z/
         6QQd4EFxnijTuFdFNTPqr8u66Vwg6B/8BQcoZbYYuuV1qryt0HgPO7aJXB+T+StN3tDR
         4ZukhcpTmk+e11if50lYFETTXswCq3O1pvjv3Bm8wjNlh4+x99wonRNKdlo8T5HhNZDl
         gxM9Ylg61oo2diklojlknLcL+tL0W8aXgA50+gj09TLDv6thM0eA7T9yhBsM8NouJ4G9
         g9rFu1RKPG3Dh1Bt+keN34M5gV2KTCkrJ3JROFPCDCSz+n0Ytmpg8HNBI//j4TsK6K4R
         0SOA==
X-Gm-Message-State: AOJu0Yw7TVTjqTtuxRUBH0MVxC9rY8p3T3anCicqrdkN0sCGQXgnM36G
	90dQhQAP0Q/55EJytNu6FKiL2zu/g1AC3fB4oqNUQEYfthJuRYMmmWFRKoosnbl4s17w7pl7K41
	SARWezpioJfUyaYO+K9Vb5TXd0tOHgek78x97mk/qYY5i
X-Received: by 2002:ac2:5bc7:0:b0:502:a4f4:ced9 with SMTP id u7-20020ac25bc7000000b00502a4f4ced9mr3646470lfn.62.1695268957789;
        Wed, 20 Sep 2023 21:02:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzwkVMLJGpoQ2SGEHIc8tZy+pnpfSpDdznj88DPWByPlY47GEZZRQImRjoM20oTCKp0BWwajYyyswTeJJW/3s=
X-Received: by 2002:ac2:5bc7:0:b0:502:a4f4:ced9 with SMTP id
 u7-20020ac25bc7000000b00502a4f4ced9mr3646413lfn.62.1695268957090; Wed, 20 Sep
 2023 21:02:37 -0700 (PDT)
MIME-Version: 1.0
References: <f1fe513e-d42d-03a6-348c-5e58aac0a759@intel.com>
 <PH0PR12MB5481323A3B4D67EB66328476DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <5f01772f-eb27-bfe0-7f69-b83fbd90dda0@intel.com> <PH0PR12MB5481ABF4B9BC2082BC54AB1DDCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230918144312-mutt-send-email-mst@kernel.org> <bb402c34-ad07-063a-f4f5-d8c6b3a642c7@intel.com>
 <20230920054836-mutt-send-email-mst@kernel.org> <2f67fb85-2238-9c34-a265-b0f97b7ab7e1@intel.com>
 <20230920075243-mutt-send-email-mst@kernel.org> <ec70e1c7-ffc3-fb6e-0b0a-6f51d7d9d0a5@intel.com>
 <20230920083057-mutt-send-email-mst@kernel.org> <CACGkMEuAEOVvrw2SKhP2fpcDjvtVvYOv21BGoA7RU_3S+AFxYw@mail.gmail.com>
 <PH0PR12MB5481840951E19EA1AE843C69DCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB5481840951E19EA1AE843C69DCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 21 Sep 2023 12:02:25 +0800
Message-ID: <CACGkMEspOB_=Po=q+-SAyXG8TDhLVRg0=nC2hpw=7oFirbCN_w@mail.gmail.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Zhu, Lingshan" <lingshan.zhu@intel.com>, 
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and vq state

On Thu, Sep 21, 2023 at 11:51=E2=80=AFAM Parav Pandit <parav@nvidia.com> wr=
ote:
>
>
>
> > From: Jason Wang <jasowang@redhat.com>
> > Sent: Thursday, September 21, 2023 8:45 AM
> > The main issue I see so far is that
> > you want to couple migration with admin commands but I don't see much
> > advantages to doing this.
> >
> The way I read above comment is, to draw a parallel line: descriptor post=
ing in virtio spec is tied to virtqueues. What is the advantage of it?

Are you saying virtio can't live without admin commands? Again, let's
not shift concepts.

> Well, it is one way to achieve it.
> There may be different way to do all bulk data transfer without admin com=
mands.

Why is virtqueue the only way to do bulk data transferring? Can't DMA
be initiated by other-way?

Thanks

> What it the advantage of it, please list down them in [1] for the command=
 where you can find alternative.
>
> [1] https://lore.kernel.org/virtio-comment/20230909142911.524407-7-parav@=
nvidia.com/T/#md9fcfa1ba997463de8c7fb8c6d1786b224b0bead


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

