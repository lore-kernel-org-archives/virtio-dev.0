Return-Path: <virtio-dev-return-13902-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A04C6CD494B
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 04:20:38 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id AD8472A898
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 04:20:33 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D87B8983D6F
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 04:20:32 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 1700F986680; Thu, 21 Sep 2023 04:20:32 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B619898667D
	for <virtio-dev@lists.oasis-open.org>; Thu, 21 Sep 2023 04:20:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: vgNpELJUPpyZJbhvYhd1hQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695270008; x=1695874808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uJwovoBs9Zojog7VPpNADpqR9yuMS6Mhta9Wtl9XZC8=;
        b=wDt8n0rXr2aCKiWBj0re6LoKjCqWVwRK3hA32na3bRx53HOZ9MX07guiNpaf5mRWvG
         JtK9+er3j/9UsJnBplEcNRKaBHFywWe6FK6veJeM0YAt1Akq6tyu7GqlqHYAtw+ZQypC
         B3yJdUkKFrX6sabpg0X0kz6m+mFF0W2BJeoiIOz4ApoIKHE20YXEBxCF8vZnTzZFkKoJ
         Z+c4F0ERNk2y1kPjgRafpmNbuA2iLOrT/5Dw5upEwap6uhlOsZcrjvchPceon+9qISul
         VAymwThbck1zbB+R+jYIuMCD3pIXpYdsTldfYQinEsrd9XvhpoY0QHjD9Y9S+2KZME5d
         6Fhg==
X-Gm-Message-State: AOJu0YxX3Y4AiqXD82bel2BjBzAbJ3qzEAahCrxFYsxPao35ufEnTtB0
	n9iOnRNYbdQ1jdYj69OtaN5qcNPhSLl3DqGTwHbNTG050XknJqMQoCo+BHVvlbUZ7mzE2QsO7Sq
	xV8U3FTqRJQTW7DolVV+NfkI2dsou2gaE1n32FpClaOJO
X-Received: by 2002:ac2:5e65:0:b0:502:fdca:2ea6 with SMTP id a5-20020ac25e65000000b00502fdca2ea6mr3420578lfr.61.1695270008522;
        Wed, 20 Sep 2023 21:20:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJXmWbrJMUG4217SusqdpBqPuT133Gs+uKlTt2axwHKe1DLAWfAN/uj4hzK9s9wCtjrnDC0EXcnAsgHpp89vc=
X-Received: by 2002:ac2:5e65:0:b0:502:fdca:2ea6 with SMTP id
 a5-20020ac25e65000000b00502fdca2ea6mr3420567lfr.61.1695270008178; Wed, 20 Sep
 2023 21:20:08 -0700 (PDT)
MIME-Version: 1.0
References: <f1fe513e-d42d-03a6-348c-5e58aac0a759@intel.com>
 <PH0PR12MB5481323A3B4D67EB66328476DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <5f01772f-eb27-bfe0-7f69-b83fbd90dda0@intel.com> <PH0PR12MB5481ABF4B9BC2082BC54AB1DDCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230918144312-mutt-send-email-mst@kernel.org> <bb402c34-ad07-063a-f4f5-d8c6b3a642c7@intel.com>
 <20230920054836-mutt-send-email-mst@kernel.org> <2f67fb85-2238-9c34-a265-b0f97b7ab7e1@intel.com>
 <20230920075243-mutt-send-email-mst@kernel.org> <ec70e1c7-ffc3-fb6e-0b0a-6f51d7d9d0a5@intel.com>
 <20230920083057-mutt-send-email-mst@kernel.org> <CACGkMEuAEOVvrw2SKhP2fpcDjvtVvYOv21BGoA7RU_3S+AFxYw@mail.gmail.com>
 <PH0PR12MB5481840951E19EA1AE843C69DCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEspOB_=Po=q+-SAyXG8TDhLVRg0=nC2hpw=7oFirbCN_w@mail.gmail.com> <PH0PR12MB5481E3D047621B4C273AFC2EDCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB5481E3D047621B4C273AFC2EDCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 21 Sep 2023 12:19:56 +0800
Message-ID: <CACGkMEv_FN6x0FwQhx2uBnbOVJpF_j4hBJx1u9QCSfjnOB=J2g@mail.gmail.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Zhu, Lingshan" <lingshan.zhu@intel.com>, 
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and vq state

On Thu, Sep 21, 2023 at 12:11=E2=80=AFPM Parav Pandit <parav@nvidia.com> wr=
ote:
>
>
>
> > From: Jason Wang <jasowang@redhat.com>
> > Sent: Thursday, September 21, 2023 9:32 AM
> >
> > On Thu, Sep 21, 2023 at 11:51=E2=80=AFAM Parav Pandit <parav@nvidia.com=
> wrote:
> > >
> > >
> > >
> > > > From: Jason Wang <jasowang@redhat.com>
> > > > Sent: Thursday, September 21, 2023 8:45 AM The main issue I see so
> > > > far is that you want to couple migration with admin commands but I
> > > > don't see much advantages to doing this.
> > > >
> > > The way I read above comment is, to draw a parallel line: descriptor =
posting in
> > virtio spec is tied to virtqueues. What is the advantage of it?
> >
> > Are you saying virtio can't live without admin commands? Again, let's n=
ot shift
> > concepts.
> >
> No, I did not say that.
> I just don=E2=80=99t see how functionalities proposed in [1] can be done =
without admin commands by the _device_ for member device passthrough requir=
ement.
>
> You made point as "don=E2=80=99t see much advantage with migration done u=
sing admin commands".

Parav, I think I've clarified several times:

migration using the admin command is probably fine in some use cases.

What's not fine, is:

Mandate the admin command to be the only way for migration.

Are we on the same page for my concern now?

> What is the advantage of descriptor posting using virtqueue. It is the wa=
y of virtio spec...
>
> > > Well, it is one way to achieve it.
> > > There may be different way to do all bulk data transfer without admin
> > commands.
> >
> > Why is virtqueue the only way to do bulk data transferring? Can't DMA b=
e
> > initiated by other-way?
> >
>
> Sure, what is the disadvantage of existing mechanism of virtqueue that ca=
n do following.
> 1. Ability to do DMA
> 2. agnostic of the DMA who do not want to do DMA

I don't understand this.

> 3. Ability to multiple command executions in parallel

Each device has their self-contained interface, why can't the commands
be executed in parallel.

> 4. Non blocking interface for driver that does not require any kind of po=
lling

Are you saying the interrupt can only work for virtqueue?

>
> Why to invent new DMA scheme which at does all the 4 tasks?

It's simply because admin virtqueue can not work for all the cases. I
think you've agreed on this, no?

> First please list down disadvantages of admin queue + show all 4 things a=
re achieved using new DMA interface.
> That will help to understand why new dma interface is needed.

I can give you a simple example. For example, what happens if we want
to migrate the owner? Having another owner for this owner is not a
good answer.

Thanks


>
>
>
> > Thanks
> >
> > > What it the advantage of it, please list down them in [1] for the com=
mand
> > where you can find alternative.
> > >
> > > [1]
> > > https://lore.kernel.org/virtio-comment/20230909142911.524407-7-parav@=
n
> > > vidia.com/T/#md9fcfa1ba997463de8c7fb8c6d1786b224b0bead
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

