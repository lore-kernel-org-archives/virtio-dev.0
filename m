Return-Path: <virtio-dev-return-13988-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68F51E95A91
	for <virtio-dev@archiver.kernel.org>; Mon,  9 Oct 2023 08:50:38 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 9E5D23E56C
	for <virtio-dev@archiver.kernel.org>; Mon,  9 Oct 2023 08:50:37 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 63D6F98654A
	for <virtio-dev@archiver.kernel.org>; Mon,  9 Oct 2023 08:50:37 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 3B4ED9864CE; Mon,  9 Oct 2023 08:50:37 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 67B549864F0
	for <virtio-dev@lists.oasis-open.org>; Mon,  9 Oct 2023 08:49:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: Si_mN5eLOKmGQP0AGhf3BA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696841385; x=1697446185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9mtx/C1KnmzAX4E30FkVXLS1Q6Oc1Gzr0YvsrEXNgYA=;
        b=MphHgHV7UP4AR3+rQWXUEagyXACC+acuTs7TcZf/bi63OygBIz6vpFlLTnJ/lhy/bd
         tVxXHYP3PDyg1DmSgdZ/9P/GwMiqnxrjEWkkIgvvAtYl71LqLbhLuF1zcwbfiF+1LQ42
         wJ2w9PYEHyrgCnFCiYAADW+Jm2itJE5/FVqq9kznZswSrKbZRoIMaahUC0rLb7fCUHVe
         LrqxtKJF/ZrZGO811VmcG7fFqQLYL+xvCB1rkVFhnjgO9IEWdzhFy/P7pLvLfGyj5wsj
         2qZFUN0grVUsmdNbgckI9tuX4mPhNpKGOf3kh9pBh/Rr9dexflVfAUtrzN7On4+g9TBQ
         01eg==
X-Gm-Message-State: AOJu0YyMx/m8HMyudF7jBDvGfBuSC0P0edcCzgwgmJAr1grFlFcGhE6r
	k0G/TpTZaGiE7OZI1a8sl/k5EfjgHyCc8Y1A2tLWkw1RQwHaq486U8c+lyoWCpcAWxhuE+qFTSg
	2aMS0isM8ChUhDLiQoaueMjLcbhEYTV8P4tDBF5jG7jdLaCYaCqFxTgM=
X-Received: by 2002:a05:6512:1115:b0:500:b42f:1830 with SMTP id l21-20020a056512111500b00500b42f1830mr15996055lfg.63.1696841385251;
        Mon, 09 Oct 2023 01:49:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGiToGYqM+wQkhWP1gl/lhL97cLSsgiT1bSIuWt69LpmHZILxNd9QyoaCMnOjMxcxbbwtMu+97oJ0rlLg5aFXE=
X-Received: by 2002:a05:6512:1115:b0:500:b42f:1830 with SMTP id
 l21-20020a056512111500b00500b42f1830mr15996037lfg.63.1696841384741; Mon, 09
 Oct 2023 01:49:44 -0700 (PDT)
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
 <CACGkMEvOxraeVB-5g7dJ-KBN=63kpmDfDdqaiQVyDh8egDjsGw@mail.gmail.com>
 <PH0PR12MB5481C11F6D68A892A091E2AFDCC3A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEvtyDXKHE4w9uH_9eqbckTGF8fZkNUuKr+mkzP0o31z_w@mail.gmail.com> <PH0PR12MB548182A6DC73C850462B546EDCC3A@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB548182A6DC73C850462B546EDCC3A@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 9 Oct 2023 16:49:33 +0800
Message-ID: <CACGkMEvLjV4Q8ETHCfVEiqnN1awLiogR79t3VEHTNXZk5qsQdw@mail.gmail.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Zhu, Lingshan" <lingshan.zhu@intel.com>, 
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and vq state

On Tue, Sep 26, 2023 at 1:21=E2=80=AFPM Parav Pandit <parav@nvidia.com> wro=
te:
>
>
>
> > From: Jason Wang <jasowang@redhat.com>
> > Sent: Tuesday, September 26, 2023 10:07 AM
> >
> > On Tue, Sep 26, 2023 at 11:40=E2=80=AFAM Parav Pandit <parav@nvidia.com=
> wrote:
> > >
> > >
> > >
> > > > From: Jason Wang <jasowang@redhat.com>
> > > > Sent: Tuesday, September 26, 2023 8:16 AM
> > > >
> > > > On Mon, Sep 25, 2023 at 6:41=E2=80=AFPM Parav Pandit <parav@nvidia.=
com> wrote:
> > > > >
> > > > >
> > > > >
> > > > > > From: Jason Wang <jasowang@redhat.com>
> > > > > > Sent: Friday, September 22, 2023 8:38 AM
> > > > >
> > > > > > > Device context has no overlap.
> > > > > >
> > > > > > I can give you one example, e.g debugging.
> > > > > >
> > > > > Almost every feature needs debugging. :) So I am omitting it for
> > > > > time being.
> > > >
> > > > Well, I don't think so. We have a lot of handy tools for that (etht=
ool -d?).
> > > Sure add something specific for debug and explicitly mention that it =
is for
> > debug like -d.
> > > Every feature and functionality needs debug, not specifically device =
context.
> > > So add infra for debug.
> >
> > Why do you think it's an infra? All you need to do is a simple decoupli=
ng.
> >
> It is too vague comment for me.
> Everything you need to debug can be queried from the device if needed.
> So please add the debug infrastructure for it.
>
> It may be useful outside of debug too.
>
> Practically any query interface added, can be used by the member driver f=
or debug purposes.
>
> > > Device migration series is not the vehicle to piggy back on.
> > >
> > > > > > 1) define virtqueue state, inflight descriptors in the section
> > > > > > of basic facility but not under the admin commands
> > > > > It will be part of the device context such a way that so that one
> > > > > can only read
> > > > the vq state only instead of full device context.
> > > > > This will work.
> > > >
> > > > I'm not sure what it looks like, but I think they are well decouple=
d in this
> > series.
> > > > E.g driver can choose to just read e.g last_avail_idx and report to
> > > > ethtool or watchdog.
> > > >
> > > Once its done it will be visible how it looks like.
> > > The key is it needs to cover BOTH use cases.
> > >
> > > > As I replied in other thread, I see several problems:
> > > >
> > > > 1) layer violation, PCI specific state were mixed into the basic
> > > > facilities
> > >
> > > After agreeing to see merged donctext, now you are hinting that you d=
on=E2=80=99t
> > agree to merge two.
> >
> > It's not a merging, it's about decoupling. I'm fine if you don't do cou=
pling and
> > layer violation.
> >
> Admin command is decoupled from admin virtqueue already.
> Device context is decoupled from admin command already.
> Dirty page tracking is decpupled from admin command already.
> Device mode is decoupled from admin command already.

Again, this is not what I read from your series.

>
>
> > > I disagree if you are leaning towards that direction.
> > > I hope my deduction from your above comment is incorrect.
> >
> > I agree to seek a way to unify but it doesn't mean everything in your c=
urrent
> > proposal is correct. Basic facility part should be transport independen=
t.
> >
> Can you please comment in my series what is incorrect? I would like to di=
scuss there, similar to your ask here.
>
>
> > >
> > > There is no violation. PCI specific device context will be captured i=
n PCI
> > specific section.
> >
> > Is that what you've done in your series now?
> >
> It will be added in the v1 of my series.
>
> > > Device type contexts will be captured in those device type sections.
> > >
> > > TLVs will cover many of the device context information.
> > >
> > > > 2) I don't see a good definition on "device context"
> > > > 3) TLV works fine for queue but not registers
> > > >
> > > Please definition of device context in [1].
> > >
> > > [1]
> > > https://lists.oasis-open.org/archives/virtio-comment/202309/msg00064.=
h
> > > tml
> > >
> > > > What needs to be done first is to describe what device context mean=
s
> > > > and what it contains. Not the actual data structure since it may va=
ry.
> > > >
> > > Sure, it is already defined in device migration theory of operation s=
ection in
> > [2].
> >
> > It's too vague, for example it's not easy to infer if the following bel=
ong to device
> > context:
> >
> I am 100% confident and challenge you that theory of operation explained =
in my series is sigficantly better than commit log of Lingshan saying "main=
 use case is live migration".
>
> > 1) dirty pages
>
> Above does not. Once you read each patch it should be clear, because dirt=
y pages in not part of the device context.

This is not what I read from your series.

>
> > 2) virtqueue adresses
> >
> It is part of the device context is listed in the patch.
>
> > etc.
> >
> > > I will try to take it out and put in device management section, so
> > > that device migration can refer to it and Some other basic facility a=
lso can
> > refer to it (which must need to explain a use case beyond silly debug p=
oint).
> >
> > It's silly to ship a product without any debugging facilities.
> >
> :)
> How come until now no one debug virtio last_avail_index in the device?

ethtool -d is more than just indices, no?

People can easily instrument the Qemu kernel via a lot of mature
debugging facilities. Or are you saying those facilities can be used
across the PCI interfaces? If not, how?

> Please really stop such arguments.
>
> If something is needed for debug please proceed to add such debug interfa=
ce.

Most debugging is simply the dumping of device states so I don't know
what you want to say here. We all know we can't easily add things like
dynamic debugging to a hardware.

>
> > And I've given you other examples like hibernation but you ignore them =
again.
> No. I didn=E2=80=99t ignore. In fact I asked AMD expert to extend his pro=
posal beyond GPU and more.
>
> > And what's more important, you ignores my question, let me ask you agai=
n
> > here:
> >
> > 1) Try to prove your facility can only work for one specific case
> > 2) Try to prove your facility can work for more than one cases
> >
> > Which one is easier and more beneficial to virtio?
> >
> #1 is easier than #2 as it needs only solve specific case.
> #2 may be more useful when one establishes two cases _really_ exists.
>
> > The decoupling is just a matter of relocating the text, does it block a=
ny of your
> > proposals? Why do you choose to refuse such a simple change with such a=
 huge
> > advantage?
>
> I repeat, I didn=E2=80=99t refuse. I just don=E2=80=99t see a point of wr=
iting something without a solid use case defined.
> If debug is a use case, one must write "debug" there..

Why? For example ethtool -d just dump registers. But from the view of
device, those registers is not necessarily named wtih "debug".

Again, the debugging is just a dump of device states. We are not
inventing debugging facilities for e.g SoC.

>
> >
> > >
> > > [2]
> > > https://lists.oasis-open.org/archives/virtio-comment/202309/msg00062.=
h
> > > tml
> > >
> > > > >
> > > > > > 3) define transport specific interfaces or admin commands to
> > > > > > access them
> > > > > >
> > > > > As you also envisioned, it is done using admin commands to access=
 it.
> > > >
> > > > That's fine, but it should allow other ways.
> > > >
> > > For passthrough admin commands fits the design.
> > > Sure, you need to draft it how to do other ways..
> >
> > So, it looks to me you never examine this series carefully.
> >
> Please stay to technical discussions.
> I examined and there is zero description beyond "main use case is live mi=
gration".

Virtio spec is not a suitable place to repeat the definition of live
migration since it's a well-known technology.

>
> I don=E2=80=99t see the way how your proposals fits the passthrough case.

Please explain why.

>
> > >  > >
> > > > > > Does this work? It seems you refused such steps in the past.
> > > > > >
> > > > > I didn=E2=80=99t.
> > > > > There must be some confusion in many emails we both exchanged,
> > > > > because
> > > > already posted v0 has it split such as device context.
> > > > >
> > > > > For dirty page tracking I couldn=E2=80=99t find a solid use case =
without
> > > > > device
> > > > migration, so I asked which you already replied above.
> > > >
> > > > First, you never explain why such coupling gives us any benefit.
> > > It is not coupled. Device migration uses this facility. So it is matt=
er of text
> > organization in the spec.
> > > Not the design.
> > >
> > > > Second, I've given you sufficient examples but you tend to ignore
> > > > them. Why not go through Qemu codes then you will see the answer.
> > > You gave example of debug, and profiling. You didn=E2=80=99t explain =
the use case of
> > how to actually connect and how to profile etc.
> >
> > How much evidence do you need me to provide? Do I need to give you the
> > manpages of ethtool -d? For profiling, is it too hard to think, for exa=
mple, to give
> > non retire hints to IOTLB via a specific IOPTE if we found a page is di=
rty?
> >
> Sounds useful, but this is a very different use case than live migration.
> If I think further, this interface may be useful in the data path side, w=
hen mapping/unmapping is done.
> So it can actually use the existing interface.
> A side interface may not be useful as it may be coming slightly less as o=
pposed to existing hint of DMA interface.
>
> > Compare the evidence or proof you've provided, how much you have provid=
ed
> > so far? Or could you please prove the device context can only work for
> > migration?
> >
> Virtio spec development is not proof based method.

It's you that wants the reviewers to use a proof based method. For
example, I'm saying logging has more use cases than migration and then
you want me to give proofs.

I'm saying it has more use cases, you want me to prove. I prove and
then I want you to prove it can't be used outside live migration,
you're saying you don't want to be proof based. Self contradictary,
no?

> I wont go this route.

Then let's don't use double standard.

> Please review the patches and comment.
>
> Device context works well for the device migration use case.

You're sending patches for comments not for parse.

> If you don=E2=80=99t understand specific text in the patches, please comm=
ent there to proceed.

I will but you never give any concrete comments to this series.

>
> > >
> > > > > > Actually, I would like to leave 2) as it's very complicated
> > > > > > which might not converge easily.
> > > > > >
> > > > > I will split current "device migration" section to two.
> > > > > 1. device management
> > > > > 2. device migration
> > > > >
> > > > > Device management covers device mode, device context and dirty
> > > > > page
> > > > tracking.
> > > >
> > > > I don't see any connection between "management" and "device context=
".
> > > >
> > > You have better name than device management?
> > > May be device operation.
> > > May be it is just better to have the device context just the way it i=
s in [1] under
> > basic facility.
> >
> > I don't understand this.
> >
> Device context is defined in "basic facility" section.
> I will just keep it there.
>
> > >
> > > > > Device migration refers to device management section.
> > > > >
> > > > > We can omit the dirty page tracking commands for a moment and
> > > > > first close
> > > > on the device mode and device context as first step.
> > > > > Since it is already part of v0 and it is needed, I will keep it i=
n
> > > > > subsequent v1 but
> > > > moved to device management section.
> > > >
> > > > Could you please answer what's wrong with the first 4 patches in th=
is series?
> > > >
> >
> > I'd leave Ling Shan to comment on this.
> >
> > > 1. cover letter is missing the problem statement and use case 2. why
> > > queue suspend and both device suspend are introduced, only one should=
 be
> > there. The design description is missing.
> > > 3. Even though it claims under some random basic facility, cover lett=
er clearly
> > states the main use case is "live migration".
> > > 4. Patch 4 is not needed at all. When device is suspended, it is _sus=
pended_. It
> > does not do any bifurcation.
> > > 5. only suspend bit of patch2 is not enough to cover P2P. One needs s=
uspend
> > and freeze both covered in series [1].
> > > 6. Finally the whole description of 1 to 4 need to be split in the de=
vice
> > operation, so that both passthrough and medication can utilize it using=
 admin
> > cmd and otherwise.
> > > Since Zhu, told that dirty tracking and inflight descriptors will be =
done, I
> > presume he will propose to do over admin q or command interface.
> > > And since all can run over the admin commands, the plumbing done in 1=
 to 4
> > can be made using admin commands.
> > >
> > > Until now we could not establish creating yet another DMA interface t=
hat is
> > better than q interface.
> > > So ...
> > > To me both the methods will start looking more converged to me over a=
dmin
> > command and queues.
> >
> > This is self-contradictory with what you've said before.
> >
> > We're in an endless circle now. The main reason is that you keep ignori=
ng
> > comments.
> >
> You didn=E2=80=99t comment in the series that should be reviewed.
>
> We can start back as following.
> 1. We have two use cases, first agree that both use cases exist.
> If disagree, discuss...
> 2. Agree to improve device migration framework for both
> If disagree, discuss...
> 3. How to implement such functionality, discuss if both can use common fr=
amework.
> a. Discuss what are the technical touch points, which differs between two=
 use cases. What different framework is needed for each case.
> b. Discuss which are the common points that both can leverage.
>
> > Another question you keep ignoring is: what prevents this proposal from=
 being
> > used in the passthrough setups? I'm pretty sure if you can get the righ=
t answer,
> > you will understand the big picture.
> I answered this already.
> In passthrough mode, the passthrough device do not have access to any of =
the following facility.

What's wrong if they have? I had given sufficient proofs to
demonstrate that they are useful for guests.

> These facility must reside on the owner device.
> a. dirty page tracking
> b. incremental device context read/write
> c. device mode setting
>
> Your comment is, some of this useful for debug and IOTLB optimization, so=
 one can also avail this facility in the member device too.

Not only the member device but the use cases beyond migration, that's the p=
oint.

> This is fine, both can have it.
> In such use case one will have two AQs, one on owner device, one on the m=
ember device.

AQ on the member device for live migration requires PASID. And once we
have PASID why do we still bother with owner?

> Both operates at their own domain.
>
> For debug purpose you wanted to use non incremental device context.
> This is a different use case, and one should build it when it is _really_=
 needed.

The debugging is just a piggybacking if you don't couple context with
migration, isn't it?

> Putting that in the debug umbrella to use it for mediation use case is no=
t the right way to proceed.

I never say debugging has any relationship with mediation. Let me
repeat once again, try not couple dirty pages, device context with
migration. We can benefit from those decoupling.

> One should say, mediation requires non incremental device context and the=
 interface may look different, this is also fine.

This is not my point.

Thanks


>
> Please don=E2=80=99t try to contradict two series, and it will be really =
easy to work forward.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

