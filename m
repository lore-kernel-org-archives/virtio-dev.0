Return-Path: <virtio-dev-return-13931-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AF2BE7D0C3
	for <virtio-dev@archiver.kernel.org>; Fri, 22 Sep 2023 03:14:06 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id A1A482AEDC
	for <virtio-dev@archiver.kernel.org>; Fri, 22 Sep 2023 03:14:05 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 70E489866B2
	for <virtio-dev@archiver.kernel.org>; Fri, 22 Sep 2023 03:14:05 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 4D3E69864C1; Fri, 22 Sep 2023 03:14:05 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3B88C98669D
	for <virtio-dev@lists.oasis-open.org>; Fri, 22 Sep 2023 03:14:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: H0eIiGQGNEOuGJmAotFLrA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695352439; x=1695957239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8i/7LjNOjME4FRJnNURWQl90prMZteLBN5sFxwtSl+8=;
        b=Jxrf+KFqAC2PiEahgNdPpz1I1QH0SQRa8X217f+Iux1IZvIOOLYZ36f0qB2cd62zEM
         ftktmGS/KDYvScpXJfvXhFVbrACDxWb587nk+ZaRd468cy1hZilyzBHQGRQcFN8jaeON
         5s2IAZjoi8VWPihfAMgZyf0AnagBZq2UFJ7qB9Gc9FKY8lj1YsTuxyaBEqzdxftuF/GP
         h2sYywk6aqkjJ0Yk1BekYh3lzfhvfq+mL4Ax/Hvog6xaWVxLMeIa2FeXETqNnneaVV+j
         x2YzBhTmEC1BkyxxpHBik6FxEqSlmHCeEHAiz4BsoTCWAqWMRaOJywSH6T2uRdnYfT/p
         UZrA==
X-Gm-Message-State: AOJu0YzHz2OG/7hDLz8TtH0h0+Qa3Zd+X4fa9NZCRHMUkQjMV1ao5ZDn
	OLoJbI1qI1v0eSmdhOGOMTFlIUOlHvmEOurj+L26CwEkZpuY0684gzqwvu52sxeF7FMMr8MFK0M
	kp8OcN4pbCELTXkZMz2/aQTOgTcd6cjuckGiHV/0kktWlj5XNQsrdelc=
X-Received: by 2002:a05:6512:b9e:b0:503:436:6d08 with SMTP id b30-20020a0565120b9e00b0050304366d08mr9054481lfv.16.1695352439489;
        Thu, 21 Sep 2023 20:13:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3ZOhr7FBlSQFRFrV3hWNfBrlyISa4/tlGhS9EtUStiHkuFl8b7am9BlQKPJnrXgfnD7o0O6LgsfwoI5I2XPM=
X-Received: by 2002:a05:6512:b9e:b0:503:436:6d08 with SMTP id
 b30-20020a0565120b9e00b0050304366d08mr9054477lfv.16.1695352439187; Thu, 21
 Sep 2023 20:13:59 -0700 (PDT)
MIME-Version: 1.0
References: <f1fe513e-d42d-03a6-348c-5e58aac0a759@intel.com>
 <PH0PR12MB5481323A3B4D67EB66328476DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <5f01772f-eb27-bfe0-7f69-b83fbd90dda0@intel.com> <PH0PR12MB5481ABF4B9BC2082BC54AB1DDCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230918144312-mutt-send-email-mst@kernel.org> <bb402c34-ad07-063a-f4f5-d8c6b3a642c7@intel.com>
 <20230920054836-mutt-send-email-mst@kernel.org> <2f67fb85-2238-9c34-a265-b0f97b7ab7e1@intel.com>
 <20230920075243-mutt-send-email-mst@kernel.org> <ec70e1c7-ffc3-fb6e-0b0a-6f51d7d9d0a5@intel.com>
 <20230920083057-mutt-send-email-mst@kernel.org> <CACGkMEuAEOVvrw2SKhP2fpcDjvtVvYOv21BGoA7RU_3S+AFxYw@mail.gmail.com>
 <PH0PR12MB5481840951E19EA1AE843C69DCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEspOB_=Po=q+-SAyXG8TDhLVRg0=nC2hpw=7oFirbCN_w@mail.gmail.com>
 <PH0PR12MB5481E3D047621B4C273AFC2EDCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEv_FN6x0FwQhx2uBnbOVJpF_j4hBJx1u9QCSfjnOB=J2g@mail.gmail.com> <PH0PR12MB5481DBB812423F9B8E7837C4DCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB5481DBB812423F9B8E7837C4DCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 22 Sep 2023 11:13:47 +0800
Message-ID: <CACGkMEsOV2TgfFOozotT8v85rLX3F_5R_nE2-n52nQBW+b4M6Q@mail.gmail.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Zhu, Lingshan" <lingshan.zhu@intel.com>, 
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and vq state

On Thu, Sep 21, 2023 at 12:29=E2=80=AFPM Parav Pandit <parav@nvidia.com> wr=
ote:
>
>
>
> > From: Jason Wang <jasowang@redhat.com>
> > Sent: Thursday, September 21, 2023 9:50 AM
>
> > Parav, I think I've clarified several times:
> >
> > migration using the admin command is probably fine in some use cases.
> >
> This is definitely, was not clear to me.
> I am 100% clear now.

Great, thanks.

>
> > What's not fine, is:
> >
> > Mandate the admin command to be the only way for migration.
> >
> For sure, my series did not mandate that either.
> I kept asking if we both can converge it will be really good to merge two=
 use cases, we should.

I've replied in another thread.

> If we cannot because of technical issues, than both methods to exists to =
address two different use cases.
>
> > Are we on the same page for my concern now?
> >
> Yes.
>
> > > What is the advantage of descriptor posting using virtqueue. It is th=
e way of
> > virtio spec...
> > >
> > > > > Well, it is one way to achieve it.
> > > > > There may be different way to do all bulk data transfer without
> > > > > admin
> > > > commands.
> > > >
> > > > Why is virtqueue the only way to do bulk data transferring? Can't
> > > > DMA be initiated by other-way?
> > > >
> > >
> > > Sure, what is the disadvantage of existing mechanism of virtqueue tha=
t can do
> > following.
> > > 1. Ability to do DMA
> > > 2. agnostic of the DMA who do not want to do DMA
> >
> > I don't understand this.
> >
> Admin commands can work without DMA, right because they are transported u=
sing admin queue.
>
> > > 3. Ability to multiple command executions in parallel
> >
> > Each device has their self-contained interface, why can't the commands =
be
> > executed in parallel.
> >
> Within the device it cannot if the interface is synchronous.
>
> > > 4. Non blocking interface for driver that does not require any kind o=
f
> > > polling
> >
> > Are you saying the interrupt can only work for virtqueue?
> >
> No. I am saying if one has to invent a interface that satisfy above needs=
, it will become a virtqueue.
> And if it is not, one should list those disadvantages and cost of new int=
erface, and explain its benefits.
> Such interface should be generic one too.

See my question below.

>
> > >
> > > Why to invent new DMA scheme which at does all the 4 tasks?
> >
> > It's simply because admin virtqueue can not work for all the cases. I t=
hink you've
> > agreed on this, no?
> >
> I think it may work for nested case as well at the cost of replicating it=
 on each device and adding special plumbing to isolate it, so that guest ca=
nnot issue driver notifications to it.
>
> > > First please list down disadvantages of admin queue + show all 4 thin=
gs are
> > achieved using new DMA interface.
> > > That will help to understand why new dma interface is needed.
> >
> > I can give you a simple example. For example, what happens if we want t=
o
> > migrate the owner? Having another owner for this owner is not a good an=
swer.
>
> That is the nesting, don=E2=80=99t see any difference with other nesting.

It's not necessarily nesting. For example how do you migrate PF?

Thanks


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

