Return-Path: <virtio-dev-return-13947-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17696E81813
	for <virtio-dev@archiver.kernel.org>; Tue, 26 Sep 2023 02:46:02 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 50A4E2B00E
	for <virtio-dev@archiver.kernel.org>; Tue, 26 Sep 2023 02:46:02 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3FA6898640A
	for <virtio-dev@archiver.kernel.org>; Tue, 26 Sep 2023 02:46:02 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 26632986378; Tue, 26 Sep 2023 02:46:02 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 15AB898639D
	for <virtio-dev@lists.oasis-open.org>; Tue, 26 Sep 2023 02:46:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 42OEWAAxNfWtPvGi7oCHiA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695696357; x=1696301157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ZLjjDnswIFyP/Da7wc3Eq3GMCb4f5uWhcEX9o1MmOQ=;
        b=vdTIEj2LneOXKZKk0bP5N+zmY3/5Zq2tHcINutdqPB1kUtEMu4YKQ8P4Ke8bHWxffU
         fYsjzS4SAMUnpxCd9XTT7RRTiqUPTeHOwaDhFBukeO4MUkejG8NesDI+xJRbY3oGfOV4
         QuT/tGBuaDqw9F8OoblQiirR1Ns+d315z6NVuYlnMN/OwEpdpKmkG8WRX9/CtAkhGpps
         BZSjFB3Ig2oNRdcrJhEdukyLV4jpURVadH3X/raZBbWvxig2FOvEZ/LdML3gEsu0NCNT
         ic1uqxi/TvVGahsp3WO7mqV4Rx/A9n7MUvbB395H5EX0qVFdmCQOhCVMyyUXXYX8noLW
         vSyw==
X-Gm-Message-State: AOJu0Yx6WvBWRmnfNzZF4dc6P/WIbCHr2TX2ex1Zkkz+Bi6Se7kp8fCI
	3Cs5zHvTCveZXJ24jZgqmhQQ7mUTNUbDV5gFUx0L3/PcE8bUZ89tkuECMDf5vyBqcAAfr7X/A0p
	lnYlRL3YeKZq9IDZfBS6mMCcoQqbZ50octhzwZg+zsza/
X-Received: by 2002:a05:6512:39d2:b0:503:2089:d3b8 with SMTP id k18-20020a05651239d200b005032089d3b8mr8877456lfu.8.1695696357235;
        Mon, 25 Sep 2023 19:45:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQLOzhpVVOtHn1tN0RYvAEYedDJTkpVnDx3JxE4vJrHiGfSTc0P88D8jZzy1LfpO6Ry0XBMurZjeZq5M/CJG8=
X-Received: by 2002:a05:6512:39d2:b0:503:2089:d3b8 with SMTP id
 k18-20020a05651239d200b005032089d3b8mr8877442lfu.8.1695696356879; Mon, 25 Sep
 2023 19:45:56 -0700 (PDT)
MIME-Version: 1.0
References: <PH0PR12MB5481C41D4F32DA26D5831471DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <67680965-b115-32c7-dfdf-c56ab37bdd81@intel.com> <213a0f94-cee2-d8c5-3c5d-d2d7fc920e75@intel.com>
 <PH0PR12MB5481AE8C6E5EAFE9A4ADA6F6DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <f1fe513e-d42d-03a6-348c-5e58aac0a759@intel.com> <PH0PR12MB5481323A3B4D67EB66328476DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <5f01772f-eb27-bfe0-7f69-b83fbd90dda0@intel.com> <PH0PR12MB5481ABF4B9BC2082BC54AB1DDCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230918144312-mutt-send-email-mst@kernel.org> <bb402c34-ad07-063a-f4f5-d8c6b3a642c7@intel.com>
 <20230920054836-mutt-send-email-mst@kernel.org> <CACGkMEsn+9AqgmurN8-GXkcu8UxAr62_woJn3XZN+oUkTQNPUg@mail.gmail.com>
 <PH0PR12MB5481830365A80EF4583A3FFADCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEshxAU3Mjo7vczBNRb=P=FnenO4mPb9HJL0Ma3ZRbe-oA@mail.gmail.com>
 <PH0PR12MB548172996D62E37714A9776BDCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEtW88zJkDQL58NqLzzudq=f+SmzJ8bha55Dd2fd=FRGBQ@mail.gmail.com> <PH0PR12MB5481573D6EE3BE03FB7C3D70DCFCA@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB5481573D6EE3BE03FB7C3D70DCFCA@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 26 Sep 2023 10:45:45 +0800
Message-ID: <CACGkMEvOxraeVB-5g7dJ-KBN=63kpmDfDdqaiQVyDh8egDjsGw@mail.gmail.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Zhu, Lingshan" <lingshan.zhu@intel.com>, 
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and vq state

On Mon, Sep 25, 2023 at 6:41=E2=80=AFPM Parav Pandit <parav@nvidia.com> wro=
te:
>
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

Well, I don't think so. We have a lot of handy tools for that (ethtool -d?)=
.

>
>
> > >
> > > Dirty page tracking has no overlap. What do you want to profile and m=
onitor?
> > In case if you want to profile, it can be used without migration comman=
d
> > anyway?
> >
> > It works like a dirty bit of PTE. We all know it has a broader use case=
 than
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
> > Definitely, but it needs to be done by not making it under the subsecti=
on of
> > admin commands, that's it.
> >
> > Let me repeat once again here for the possible steps to collaboration:
> >
> > 1) define virtqueue state, inflight descriptors in the section of basic=
 facility but
> > not under the admin commands
> It will be part of the device context such a way that so that one can onl=
y read the vq state only instead of full device context.
> This will work.

I'm not sure what it looks like, but I think they are well decoupled
in this series. E.g driver can choose to just read e.g last_avail_idx
and report to ethtool or watchdog.

>
> > 2) define the dirty page tracking, device context/states in the section=
 of basic
> > facility but not under the admin commands
> Great.
> Device context is already defined in the basic facility outside of the ad=
min commands in [1].
> Current text is around device migration and spec evolves it can adopt mor=
e generic text without device migration.
>
> [1] https://lists.oasis-open.org/archives/virtio-comment/202309/msg00064.=
html

As I replied in other thread, I see several problems:

1) layer violation, PCI specific state were mixed into the basic facilities
2) I don't see a good definition on "device context"
3) TLV works fine for queue but not registers

What needs to be done first is to describe what device context means
and what it contains. Not the actual data structure since it may vary.

>
> > 3) define transport specific interfaces or admin commands to access the=
m
> >
> As you also envisioned, it is done using admin commands to access it.

That's fine, but it should allow other ways.

>
> > Does this work? It seems you refused such steps in the past.
> >
> I didn=E2=80=99t.
> There must be some confusion in many emails we both exchanged, because al=
ready posted v0 has it split such as device context.
>
> For dirty page tracking I couldn=E2=80=99t find a solid use case without =
device migration, so I asked which you already replied above.

First, you never explain why such coupling gives us any benefit.
Second, I've given you sufficient examples but you tend to ignore
them. Why not go through Qemu codes then you will see the answer.

>
> > Actually, I would like to leave 2) as it's very complicated which might=
 not
> > converge easily.
> >
> I will split current "device migration" section to two.
> 1. device management
> 2. device migration
>
> Device management covers device mode, device context and dirty page track=
ing.

I don't see any connection between "management" and "device context".

> Device migration refers to device management section.
>
> We can omit the dirty page tracking commands for a moment and first close=
 on the device mode and device context as first step.
> Since it is already part of v0 and it is needed, I will keep it in subseq=
uent v1 but moved to device management section.

Could you please answer what's wrong with the first 4 patches in this serie=
s?

Thakns

>
> Michael,
> Are you ok with this approach to step forward?


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

