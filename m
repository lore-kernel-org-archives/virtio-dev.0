Return-Path: <virtio-dev-return-13139-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29178EB64D7
	for <virtio-dev@archiver.kernel.org>; Thu, 29 Jun 2023 03:17:51 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 673C56004D
	for <virtio-dev@archiver.kernel.org>; Thu, 29 Jun 2023 03:17:50 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4EF619865D4
	for <virtio-dev@archiver.kernel.org>; Thu, 29 Jun 2023 03:17:50 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 33F09986317; Thu, 29 Jun 2023 03:17:50 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 157A298658E
	for <virtio-dev@lists.oasis-open.org>; Thu, 29 Jun 2023 03:17:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: APMwPYpzP6OWWCX6GgJ4WQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688008666; x=1690600666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P/L1vqN6tztYqvMoNwM1vhPnJrcwSqwmW06TnqPTNF8=;
        b=KmAGmdaEIk555UW/iXo8ib/ueLwefMvccUASYq0Zl8OdeTRA+LntTtzdw93Kv2M4Pq
         km2+6HzJU6Y7dCYfbBwHxYAJ+ZqTtO2DDBuRa7eUZvqPT3o5MW0axvWN9afPQItH+51q
         sXWTrcBcJdiGXH4AmrLB7b/vgPbeJbkwWUaGD0xGwVN2DhyCNtId/x3KM9+b4ku7kMBA
         FCgZVQUz28cW7Bz6u0X+BFSSzZ54z15PO4Mdq8fcMtP4RonMzWOiGVUGamW93XnZJMQd
         k0T4dKbu23DELjq9bJ/ivdP1ViMStZv6vTBW0EALIB7ktBuraKGO8w4J1woXqTr0Y4ar
         zNWQ==
X-Gm-Message-State: AC+VfDxzx2tVuCovCzHi8OGy7hm5vIDs/ZmD6WkxdGT5ZcDvSV7chwqb
	HVY2UBlvFSKa5M/r07V2xHK9ve6AMfxsUwBMHiuFjMFpsN59T492YpGTfCGHsxljGu396F6CAQU
	shNVwANmth2ys0yhEUAEjxIKbhB/76e8H7kRRKwyXBeKD
X-Received: by 2002:a2e:3202:0:b0:2b5:9d78:213e with SMTP id y2-20020a2e3202000000b002b59d78213emr11171841ljy.22.1688008666368;
        Wed, 28 Jun 2023 20:17:46 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7Pkia1M7ilXuWTQiJmb1wTinrFEydGB4WEL/YHZeml5sKKv3SS8D5KmiNLf60JT4w4AORq+BQoHVQ8Y51QvrY=
X-Received: by 2002:a2e:3202:0:b0:2b5:9d78:213e with SMTP id
 y2-20020a2e3202000000b002b59d78213emr11171831ljy.22.1688008666048; Wed, 28
 Jun 2023 20:17:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230627163549.40028-1-hengqi@linux.alibaba.com>
 <CACGkMEvFmAiWDp8w=ytin21Oi+PcTb1X3Eve7Kt2NVr_RkhgmA@mail.gmail.com>
 <PH0PR12MB54811123CFCDEFE3B48D4381DC24A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEtgomh1EGNLqhXQssRW02nnHkamxT5rV5eZZ9BZFH=uJA@mail.gmail.com> <PH0PR12MB548102A43104218F481B8679DC24A@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB548102A43104218F481B8679DC24A@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 29 Jun 2023 11:17:34 +0800
Message-ID: <CACGkMEsk-eH19bdBgMvxrX-xqpOX=RELv-BadZdGq+K0_6xh+A@mail.gmail.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, 
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, 
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "Michael S . Tsirkin" <mst@redhat.com>, 
	Yuri Benditovich <yuri.benditovich@daynix.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [PATCH v19] virtio-net: support inner header hash

On Thu, Jun 29, 2023 at 12:00=E2=80=AFAM Parav Pandit <parav@nvidia.com> wr=
ote:
>
>
>
> > From: Jason Wang <jasowang@redhat.com>
> > Sent: Wednesday, June 28, 2023 1:38 AM
>
> [..]
> > > Provisioning is far simpler thing to do in device specific way than a=
sking device
> > to store this value in onchip area which is rarely accessed.
> >
> > Are you suggesting to not place any new fields in the config space?
> >
> Yes.

It's not the fault of config space itself, but the way to access the
config space, more below.

>
> > struct virtio_net_config {
> >         u8 mac[6];
> >         le16 status;
> >         le16 max_virtqueue_pairs;
> >         le16 mtu;
> >         le32 speed;
> >         u8 duplex;
> >         u8 rss_max_key_size;
> >         le16 rss_max_indirection_table_length;
> >         le32 supported_hash_types;
> > };
> >
> > Which of the above do you think can be accessed frequently and which pa=
rt of
> > the spec says it must be stored in the onchip area?
> >
> Most are not accessed frequently.
> The fact that they are in MMIO a device needs to place in a memory with t=
ight latency budget.

This really depends on the implementation and vendor architectures.
For example,

1) MSI BAR might require much more resources than a simple device
configuration space
2) I was told my some vendors that the virtqueue is much more valuable than=
 MMIO
3) We can introduce new ways to access the device configuration space

> Spec is not going to talk on onchip area, it is the reflection of spec th=
at forces certain inefficient implementation .

Exactly, it's implementation specific, so config space is fine, we
just need to invent new methods to access them that fit for your
hardware.

Thanks


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

