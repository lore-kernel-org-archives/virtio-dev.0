Return-Path: <virtio-dev-return-13950-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31AF1E81817
	for <virtio-dev@archiver.kernel.org>; Tue, 26 Sep 2023 04:37:37 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 606FD2A829
	for <virtio-dev@archiver.kernel.org>; Tue, 26 Sep 2023 04:37:36 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3AC8398640F
	for <virtio-dev@archiver.kernel.org>; Tue, 26 Sep 2023 04:37:36 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 1C9FE986378; Tue, 26 Sep 2023 04:37:36 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0AE3F98639D
	for <virtio-dev@lists.oasis-open.org>; Tue, 26 Sep 2023 04:37:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 7-rO7X-gP5adzg-sfNUibg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695703051; x=1696307851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r9EX4+8yhuAq3xW3VfbwariqR4yTqRU8oCASQAU62c8=;
        b=JiRmlPVK5eqR+4rF8YYo7k38uhteJUuLAedGqESQ8FaG6zcleRaIkaaLsNvNovF8lj
         NNF0w74F64mwmZpgWv1BNWT8mz6bRg5k3HUdBzuyHDloTajG6JhB64xIAB8Gqqrvsb+o
         a6zUet8eE0YRSf2DDbwXzIj8q1qmzjlJzmfxrkatV6wC+zHBCBdr7ural1C1by6NFoFG
         SYs0bC99EYq7FwKwWfmwrBa8+xkqjGBX7QYghhalL3zHOwn4HXepjJGjzffVu5LTiNeW
         bwO28cPDK8AZNftn8aSjvQFfhIb+4RQ0nZbgSztZI16SAU/emuyQrS9pvu6m+eFgWLAt
         pzkg==
X-Gm-Message-State: AOJu0YzHgcd18EbXuRvSdr0sHK7qkUhCil1NZUhQbmefYSQ4Uv5kXfPp
	pDuV9Tyl5KHTr2uOEGwQ9tiZhIBS8jITRyRjAUniRhPp08Y6n2mpfaT3xs9n/UuaEOpaGJ7Uh95
	a8FJcKomQvHl/uN2222RKJrqo/J6VMD0H3UxRMLDLRHGC
X-Received: by 2002:a05:6512:2245:b0:500:a66b:b189 with SMTP id i5-20020a056512224500b00500a66bb189mr10083138lfu.51.1695703051358;
        Mon, 25 Sep 2023 21:37:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhKJ8xt0uHTx3sqSQPczTzalqhFdrHkPqUSudhJzv9nn1D/ufig3LTzqqR5vLSm9huR8RtcHqjtdPfIXmMeZs=
X-Received: by 2002:a05:6512:2245:b0:500:a66b:b189 with SMTP id
 i5-20020a056512224500b00500a66bb189mr10083116lfu.51.1695703050935; Mon, 25
 Sep 2023 21:37:30 -0700 (PDT)
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
 <CACGkMEtW88zJkDQL58NqLzzudq=f+SmzJ8bha55Dd2fd=FRGBQ@mail.gmail.com>
 <PH0PR12MB5481573D6EE3BE03FB7C3D70DCFCA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEvOxraeVB-5g7dJ-KBN=63kpmDfDdqaiQVyDh8egDjsGw@mail.gmail.com> <PH0PR12MB5481C11F6D68A892A091E2AFDCC3A@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB5481C11F6D68A892A091E2AFDCC3A@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 26 Sep 2023 12:37:19 +0800
Message-ID: <CACGkMEvtyDXKHE4w9uH_9eqbckTGF8fZkNUuKr+mkzP0o31z_w@mail.gmail.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Zhu, Lingshan" <lingshan.zhu@intel.com>, 
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and vq state

On Tue, Sep 26, 2023 at 11:40=E2=80=AFAM Parav Pandit <parav@nvidia.com> wr=
ote:
>
>
>
> > From: Jason Wang <jasowang@redhat.com>
> > Sent: Tuesday, September 26, 2023 8:16 AM
> >
> > On Mon, Sep 25, 2023 at 6:41=E2=80=AFPM Parav Pandit <parav@nvidia.com>=
 wrote:
> > >
> > >
> > >
> > > > From: Jason Wang <jasowang@redhat.com>
> > > > Sent: Friday, September 22, 2023 8:38 AM
> > >
> > > > > Device context has no overlap.
> > > >
> > > > I can give you one example, e.g debugging.
> > > >
> > > Almost every feature needs debugging. :) So I am omitting it for time
> > > being.
> >
> > Well, I don't think so. We have a lot of handy tools for that (ethtool =
-d?).
> Sure add something specific for debug and explicitly mention that it is f=
or debug like -d.
> Every feature and functionality needs debug, not specifically device cont=
ext.
> So add infra for debug.

Why do you think it's an infra? All you need to do is a simple decoupling.

> Device migration series is not the vehicle to piggy back on.
>
> > > > 1) define virtqueue state, inflight descriptors in the section of
> > > > basic facility but not under the admin commands
> > > It will be part of the device context such a way that so that one can=
 only read
> > the vq state only instead of full device context.
> > > This will work.
> >
> > I'm not sure what it looks like, but I think they are well decoupled in=
 this series.
> > E.g driver can choose to just read e.g last_avail_idx and report to eth=
tool or
> > watchdog.
> >
> Once its done it will be visible how it looks like.
> The key is it needs to cover BOTH use cases.
>
> > As I replied in other thread, I see several problems:
> >
> > 1) layer violation, PCI specific state were mixed into the basic facili=
ties
>
> After agreeing to see merged donctext, now you are hinting that you don=
=E2=80=99t agree to merge two.

It's not a merging, it's about decoupling. I'm fine if you don't do
coupling and layer violation.

> I disagree if you are leaning towards that direction.
> I hope my deduction from your above comment is incorrect.

I agree to seek a way to unify but it doesn't mean everything in your
current proposal is correct. Basic facility part should be transport
independent.

>
> There is no violation. PCI specific device context will be captured in PC=
I specific section.

Is that what you've done in your series now?

> Device type contexts will be captured in those device type sections.
>
> TLVs will cover many of the device context information.
>
> > 2) I don't see a good definition on "device context"
> > 3) TLV works fine for queue but not registers
> >
> Please definition of device context in [1].
>
> [1] https://lists.oasis-open.org/archives/virtio-comment/202309/msg00064.=
html
>
> > What needs to be done first is to describe what device context means an=
d what
> > it contains. Not the actual data structure since it may vary.
> >
> Sure, it is already defined in device migration theory of operation secti=
on in [2].

It's too vague, for example it's not easy to infer if the following
belong to device context:

1) dirty pages
2) virtqueue adresses

etc.

> I will try to take it out and put in device management section, so that d=
evice migration can refer to it and
> Some other basic facility also can refer to it (which must need to explai=
n a use case beyond silly debug point).

It's silly to ship a product without any debugging facilities.

And I've given you other examples like hibernation but you ignore them
again. And what's more important, you ignores my question, let me ask
you again here:

1) Try to prove your facility can only work for one specific case
2) Try to prove your facility can work for more than one cases

Which one is easier and more beneficial to virtio?

The decoupling is just a matter of relocating the text, does it block
any of your proposals? Why do you choose to refuse such a simple
change with such a huge advantage?

>
> [2] https://lists.oasis-open.org/archives/virtio-comment/202309/msg00062.=
html
>
> > >
> > > > 3) define transport specific interfaces or admin commands to access
> > > > them
> > > >
> > > As you also envisioned, it is done using admin commands to access it.
> >
> > That's fine, but it should allow other ways.
> >
> For passthrough admin commands fits the design.
> Sure, you need to draft it how to do other ways..

So, it looks to me you never examine this series carefully.

>  > >
> > > > Does this work? It seems you refused such steps in the past.
> > > >
> > > I didn=E2=80=99t.
> > > There must be some confusion in many emails we both exchanged, becaus=
e
> > already posted v0 has it split such as device context.
> > >
> > > For dirty page tracking I couldn=E2=80=99t find a solid use case with=
out device
> > migration, so I asked which you already replied above.
> >
> > First, you never explain why such coupling gives us any benefit.
> It is not coupled. Device migration uses this facility. So it is matter o=
f text organization in the spec.
> Not the design.
>
> > Second, I've given you sufficient examples but you tend to ignore them.=
 Why
> > not go through Qemu codes then you will see the answer.
> You gave example of debug, and profiling. You didn=E2=80=99t explain the =
use case of how to actually connect and how to profile etc.

How much evidence do you need me to provide? Do I need to give you the
manpages of ethtool -d? For profiling, is it too hard to think, for
example, to give non retire hints to IOTLB via a specific IOPTE if we
found a page is dirty?

Compare the evidence or proof you've provided, how much you have
provided so far? Or could you please prove the device context can only
work for migration?

>
> > > > Actually, I would like to leave 2) as it's very complicated which
> > > > might not converge easily.
> > > >
> > > I will split current "device migration" section to two.
> > > 1. device management
> > > 2. device migration
> > >
> > > Device management covers device mode, device context and dirty page
> > tracking.
> >
> > I don't see any connection between "management" and "device context".
> >
> You have better name than device management?
> May be device operation.
> May be it is just better to have the device context just the way it is in=
 [1] under basic facility.

I don't understand this.

>
> > > Device migration refers to device management section.
> > >
> > > We can omit the dirty page tracking commands for a moment and first c=
lose
> > on the device mode and device context as first step.
> > > Since it is already part of v0 and it is needed, I will keep it in su=
bsequent v1 but
> > moved to device management section.
> >
> > Could you please answer what's wrong with the first 4 patches in this s=
eries?
> >

I'd leave Ling Shan to comment on this.

> 1. cover letter is missing the problem statement and use case
> 2. why queue suspend and both device suspend are introduced, only one sho=
uld be there. The design description is missing.
> 3. Even though it claims under some random basic facility, cover letter c=
learly states the main use case is "live migration".
> 4. Patch 4 is not needed at all. When device is suspended, it is _suspend=
ed_. It does not do any bifurcation.
> 5. only suspend bit of patch2 is not enough to cover P2P. One needs suspe=
nd and freeze both covered in series [1].
> 6. Finally the whole description of 1 to 4 need to be split in the device=
 operation, so that both passthrough and medication can utilize it using ad=
min cmd and otherwise.
> Since Zhu, told that dirty tracking and inflight descriptors will be done=
, I presume he will propose to do over admin q or command interface.
> And since all can run over the admin commands, the plumbing done in 1 to =
4 can be made using admin commands.
>
> Until now we could not establish creating yet another DMA interface that =
is better than q interface.
> So ...
> To me both the methods will start looking more converged to me over admin=
 command and queues.

This is self-contradictory with what you've said before.

We're in an endless circle now. The main reason is that you keep
ignoring comments.

Another question you keep ignoring is: what prevents this proposal
from being used in the passthrough setups? I'm pretty sure if you can
get the right answer, you will understand the big picture.

Thanks




>
> Passthrough will use them over owner device.
> Mediation somehow need to do over member device.
> Mediation will not use any device suspend command because it needs to kee=
p bisecting everything.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

