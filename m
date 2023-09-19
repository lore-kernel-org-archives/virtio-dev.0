Return-Path: <virtio-dev-return-13813-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B168CD3437
	for <virtio-dev@archiver.kernel.org>; Tue, 19 Sep 2023 04:36:05 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id B346B2A88B
	for <virtio-dev@archiver.kernel.org>; Tue, 19 Sep 2023 04:36:04 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A8C6798655A
	for <virtio-dev@archiver.kernel.org>; Tue, 19 Sep 2023 04:36:04 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 99F0C98637D; Tue, 19 Sep 2023 04:36:04 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8C8169864D1
	for <virtio-dev@lists.oasis-open.org>; Tue, 19 Sep 2023 04:36:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: wGTrSW7hOXCrHGivxXvrOA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695098160; x=1695702960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yCqNnjNme5X5mvUSrEqsbsK19gWbbL3Tnj3PC54jxUs=;
        b=VuGJn/zhcBXtPMr8/pXZ+3pcHf9W3Mb6iUcxHzAYELN1fNdzH5Yrzn0oE/EpxzaogF
         970d/hCzxLxeaZYAlzGf8uFzD7C5h9Z5eNCl7jt/upXbVqaF5MX1ZwUIB0hH2qymWr62
         JslMtpUgxphvbCznyQiY0TyFbwI++cXZH0tY2ZNw95CkqDdZHntlkHujKjYGh7F2Nsvh
         yRPIDfskVDmbCmi2D8vLVxZHuZh4He0WYhgHn8x71PUEtgfKkV1bmrviNvXtq27Fo+mD
         uwfMP2pYkjrBTFt03BWQ7s6xKcx7dfjkUFliN6NXtBh6jyk0Jym3p42OpspvywkP2OL8
         oEmw==
X-Gm-Message-State: AOJu0YzvbVqPvI+bZ8iZU7dpu20pFQznf1CwCqQmpBYG4Sx5QuSU+kfx
	ChQSmuRFcbM9AI4nv4v4zsvqOonzgN9ftXPKVS9xqAA5wYElja2/M++DyUXFSOmJJT9GKPR3zc8
	Fhr907QhyIdlBXkOoLIm9eybcCep/ED2GDPiPaJ0KWWye
X-Received: by 2002:a19:e012:0:b0:502:fe11:a68f with SMTP id x18-20020a19e012000000b00502fe11a68fmr6856909lfg.28.1695098160387;
        Mon, 18 Sep 2023 21:36:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbvno9p/hQKmCn7U0uI1Oh30TxO3FxoFMQwE2juB8PehIhyEi8dZNbhkUVXfneI0y1B+sOQZ3iFVj6UmiCLE8=
X-Received: by 2002:a19:e012:0:b0:502:fe11:a68f with SMTP id
 x18-20020a19e012000000b00502fe11a68fmr6856903lfg.28.1695098160063; Mon, 18
 Sep 2023 21:36:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230906081637.32185-1-lingshan.zhu@intel.com>
 <20230906081637.32185-6-lingshan.zhu@intel.com> <20230906043016-mutt-send-email-mst@kernel.org>
 <CACGkMEu4R_nUFmpoNesmjJ-PtoE5brpWh8NLruWhEWycm2K4yg@mail.gmail.com>
 <PH0PR12MB5481A50B1B13CE1756B98D0DDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEtMmwWGJDYe5BLvLCcetThv-yfPR2QbphNuuh+bp-+ikg@mail.gmail.com>
 <PH0PR12MB5481ED8DC23DC6D42665FB8EDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <eb6c350e-1198-7d83-a553-99c9c8c21edc@intel.com> <PH0PR12MB5481760E00AD18DB8BF91636DCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <ad1dd3a6-7c11-5c6b-b50f-d608ec027dcd@intel.com> <PH0PR12MB54819C4A4220712DCD57AD56DCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <fff7720f-6019-bd87-b14b-c0bf996f3959@intel.com> <PH0PR12MB5481D11A7DF45292103D9290DCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <88b8b14c-88d8-1f76-0e6e-7b5f334171f1@intel.com> <PH0PR12MB5481CBE0CDFF4ACD712F371CDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <2b3e8da1-5cbb-f990-0c1d-c0e894a73486@intel.com> <PH0PR12MB5481E8114A659954251F17DCDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEtAe3j+A=gNEOJiZF8rcJnT-zw7Xg67LLM92FZCm0XqyQ@mail.gmail.com>
 <PH0PR12MB5481B44B636DA997885AABBEDCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEtFWZAQ0fKFBJYpRGR_RCNyDZSxXY+22y==PbuZqHzrVA@mail.gmail.com>
 <PH0PR12MB5481169EDDE5B82D71BCCE95DCF0A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEt0OHL7pwR7pY-xv9PdLHxM1oLw3vOVdVwys4=W_VodGw@mail.gmail.com> <PH0PR12MB54818C170FD45AC707216669DCF4A@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB54818C170FD45AC707216669DCF4A@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 19 Sep 2023 12:35:47 +0800
Message-ID: <CACGkMEv-0YTk-oVzHYSKKuE1FtOyET1LNth-dx_z0REiNy02tw@mail.gmail.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "Zhu, Lingshan" <lingshan.zhu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	"eperezma@redhat.com" <eperezma@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>, 
	"stefanha@redhat.com" <stefanha@redhat.com>, 
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, 
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [virtio-comment] [PATCH 5/5] virtio-pci: implement VIRTIO_F_QUEUE_STATE

On Sun, Sep 17, 2023 at 1:22=E2=80=AFPM Parav Pandit <parav@nvidia.com> wro=
te:
>
>
> > From: Jason Wang <jasowang@redhat.com>
> > Sent: Thursday, September 14, 2023 8:41 AM
> >
> > On Wed, Sep 13, 2023 at 2:06=E2=80=AFPM Parav Pandit <parav@nvidia.com>=
 wrote:
> > >
> > >
> > > > From: Jason Wang <jasowang@redhat.com>
> > > > Sent: Wednesday, September 13, 2023 10:14 AM
> > > > To: Parav Pandit <parav@nvidia.com>
> > >
> > > > > One can build infinite level of nesting to not do passthrough, at
> > > > > the end user
> > > > applications remains slow.
> > > >
> > > > We are talking about nested virtualization but nested emulation. I
> > > > won't repeat the definition of virtualization but no matter how muc=
h
> > > > level of nesting, the hypervisor will try hard to let the
> > > > application run natively for most of the time, otherwise it's not t=
he nested
> > virtualization at all.
> > > >
> > > > Nested virtualization has been supported by all major cloud vendors=
,
> > > > please read the relevant documentation for the performance
> > > > implications. Virtio community is not the correct place to debate
> > > > whether a nest is useful. We need to make sure the datapath could b=
e
> > > > assigned to any nest layers without losing any fundamental faciliti=
es like
> > migration.
> > > >
> > > I am not debating. You or Lingshan claim or imply that mediation is t=
he only
> > way to progress.
> >
> > Let me correct your temiology again. It's "trap and emulation" . It mea=
ns the
> > workload runs mostly native but sometimes is trapped by the hypervisor.
> >
>
> > And it's not the only way. It's the start point since all current virti=
o spec is built
> > upon this methodology.
> Current spec is not the steering point to define new methods.
> So we will build the spec infra to support passthrough.
>

Passthrough migration actually, passthrough is already supported now.

> Mediation/trap-emulation where hypervisor is involved is also second use =
case that you are addressing.
>
> And hence, both are not mutually exclusive.
> Hence we should not debate that anymore.
>
> >
> > > And for sure virtio do not need to live in the dark shadow of mediati=
on always.
> >
> > 99% of virtio devices are implemented in this way (which is what you ca=
ll dark
> > and shadow) now.
> >
> What I am saying is one should not say mediation/trap-emulation is the on=
ly way for virtio.

Then using things like "dark shadow" is not fair.

> So let passthrough device migration to progress.

Then you need to answer or address the concerns.

>
> > > For nesting use case sure one can do mediation related mode.
> > >
> > > So only mediation is not the direction.
> >
> > CPU and MMU virtualization were all built in this way.
> >
> Not anymore. Both of them have vcpus and viommu where may things are not =
trapped.

We are talking about different things. I'm saying trap is a must but
you say not all are trapped.

> So as I said both has pros and cons and users will pick what fits their n=
eed and use case.
>
> > >
> > > > > So for such N and M being > 1, one can use software base emulatio=
n
> > anyway.
> > > >
> > > > No, only the control path is trapped, the datapath is still passthr=
ough.
> > > >
> > > Again, it depends on the use case.
> >
> > No matter what use case, the definition and methodology of virtualizati=
on
> > stands still.
> >
> I will stop debating this because the core technical question is not answ=
ered.
> I don=E2=80=99t see a technology available that virtio can utilize to it.
> That is interface that can work without messing with device status and fl=
r while device migration is ongoing.

Again, you need to justify it. For example, why does it mess up device
status? Why is rest ok but not suspending?

At least so far, I don't see good answers for thoses.

> Hence, methodology for passthrough and mediation/trap-emulation is fundam=
entally different.
> And that is just fine.
>
> > >
> > > > >
> > > > > >
> > > > > > And exposing the whole device to the guest drivers will have
> > > > > > security implications, your proposal has demonstrated that you
> > > > > > need a workaround for
> > > > > There is no security implications in passthrough.
> > > >
> > > > How can you prove this or is it even possible for you to prove this=
?
> > > Huh, when you claim that it is not secure, please point out exactly w=
hat is not
> > secure.
> > > Please take with PCI SIG and file CVE to PCI sig.
> >
> > I am saying it has security implications. That is why you need to expla=
in why you
> > think it doesn't. What's more, the implications are obviously nothing r=
elated to
> > PCI SIG but a vendor virtio hardware implementation.
> >
> PCI passthough for virtio member devices and non virtio devices with P2P,=
 and their interaction is already there in the VM.
> Device migration is not adding/removing anything, nor touching any securi=
ty aspect of it.
> Because it does not need to it either.
> Device migration is making sure that it continue to exists.

Since we are discussing in the virtio community, what we care about is
the chance that guest(driver) can explore device security
vulnerabilities. In this context, exposing more means the increasing
of the attacking surfaces since we (cloud vendor) can't control guests
but the hypervisor.

>
> > >
> > > > You expose all device details to guests (especially the transport
> > > > specific details), the attack surface is increased in this way.
> > > One can say it is the opposite.
> > > Attack surface is increased in hypervisor due to mediation poking at
> > everything controlled by the guest.
> > >
> >
> > We all know such a stack has been widely used for decades. But you want=
 to say
> > your new stack is much more secure than this?
> >
> It can be yes, because it exposes all necessary things defined in the vir=
tio spec boundary today.
> And not involving hypervisor in core device operation.

That's perfectly fine if we can do this. But you need to justify this.

>
> > >
> > > >
> > > > What's more, a simple passthrough may lose the chance to workaround
> > > > hardware erratas and you will finally get back to the trap and emul=
ation.
> > > Hardware errata's is not the starting point to build the software sta=
ck and
> > spec.
> >
> > It's not the starting point. But it's definitely something that needs t=
o be
> > considered, go and see kernel codes (especially the KVM part) and you w=
ill get
> > the answer.
> >
> There are kernels which cannot be updated in field today in Nvidia cloud =
shipped by Redhat's OS variant.
>
> So it is invalid assumption that somehow data path does not have bug, but=
 large part of the control plane has bug, hence it should be done in softwa=
re...

Well, for sure there are cases that can't be worked around. But for
the case that it can, trap and emulation gives much more flexibility.

>
> > > What you imply is, one must never use vfio stack, one must not use vc=
pu
> > acceleration and everything must be emulated.
> >
> > Do I say so? Trap and emulation is the common methodology used in KVM a=
nd
> > VFIO. And if you want to replace it with a complete passthrough, you ne=
ed to
> > prove your method can work.
> >
> Please review patches. I do not plan to _replace_ is either.

You define all the migration stuffs in the admin commands section,
isn't this an implicit coupling?

> Those users who want to use passthrough, can use passthrough with major t=
raps+emulation on FLR, device_status, cvq, avq and without implementing AQ =
on every single member device.
> And those users who prefer trap+emualation can use that.
>
> > >
> > > Same argument of hardware errata applied to data path too.
> >
> > Anything makes datapath different? Xen used to fallback to shadow page =
tables
> > to workaround hardware TDP errata in the past.
> >
> > > One should not implement in hw...
> > >
> > > I disagree with such argument.
> >
> > It's not my argument.
> >
> You claimed that to overcome hw errata, one should use trap_emulation, so=
mehow only for portion of the functionality.
> And rest portion of the functionality does not have hw errata, hence hw s=
hould be use (for example for data path). :)

I've explained before, we all know there're errata that can't be a
workaround in any way.

>
> > >
> > > You can say nesting is requirement for some use cases, so spec should=
 support
> > it without blocking the passthrough mode.
> > > Then it is fair discussion.
> > >
> > > I will not debate further on passthrough vs control path mediation as
> > either_or approach.
> > >
> > > >
> > > > >
> > > > > > FLR at least.
> > > > > It is actually the opposite.
> > > > > FLR is supported with the proposal without any workarounds and
> > mediation.
> > > >
> > > > It's an obvious drawback but not an advantage. And it's not a must
> > > > for live migration to work. You need to prove the FLR doesn't
> > > > conflict with the live migration, and it's not only FLR but also al=
l the other
> > PCI facilities.
> > > I don=E2=80=99t know what you mean by prove. It is already clear from=
 the proposal
> > FLR is not messing with rest of the device migration infrastructure.
> > > You should read [1].
> >
> > I don't think you answered my question in that thread.
> >
> Please ask the question in that series if any, because there is no FLR, d=
evice reset interaction in passthrough between owner and member device.
>
> > >
> > > > one other
> > > > example is P2P and what's the next? As more features were added to
> > > > the PCI spec, you will have endless work in auditing the possible
> > > > conflict with the passthrough based live migration.
> > > >
> > > This drawback equally applies to mediation route where one need to do=
 more
> > than audit where the mediation layer to be extended.
> >
> > No, for trap and emulation we don't need to do that. We only do datapat=
h
> > assignments.
> >
> It is required, because also such paths to be audited and extended as wit=
hout it the feature does not visible to the guest.

You need first answer the following questions:

1) Why FLR is a must for the guest
2) What's wrong with the current Qemu emulation of FLR for virtio-pci devic=
e

>
> > > So each method has its pros and cons. One suits one use case, other s=
uits
> > other use case.
> > > Therefore, again attempting to claim that only mediation approach is =
the only
> > way to progress is incorrect.
> >
> > I never say things like this, it is your proposal that mandates migrati=
on with
> > admin commands. Could you please read what is proposed in this series
> > carefully?
> >
> Admin commands are split from the AQ so one can use the admin commands in=
band as well.

How can it? It couples a lot of concepts like group, owner and
members. All of these have only existed in SR-IOV so far.

I don't know how to define those for MMIO where the design wants to be
as simple as possible.

> Though, I don=E2=80=99t see how it can functionality work without mediati=
on.
> This is the key technical difference between two approaches.
>
> > On top of this series, you can build your amd commands easily. But ther=
e's
> > nothing that can be done on top of your proposal.
> >
> I don=E2=80=99t see what more to be done on top of our proposal.

Actually it really has one, that is moving the description/definition
of those states to the basc facility part. But if we do this, why not
do it from the start? This is exactly what Lingshan's proposal did.

> If you hint nesting, than it can be done through a peer admin device to d=
elete such admin role.
>
> > >
> > > In fact audit is still better than mediation because most audits are =
read only
> > work as opposed to endlessly extending trapping and adding support in c=
ore
> > stack.
> >
> > One reality that you constantly ignore is that such trapping and device=
 models
> > have been widely used by a lot of cloud vendors for more than a decade.
> >
> It may be but, it is not the only option.

I don't say it's the only option. If most of the devices were built in
this way, we should first allow any new function to be available to
those devices and then consider other cases. Inventing a mechanism
that can't work for most of the existing devices is sub-optimal.

>
> > > Again, it is a choice that user make with the tradeoff.
> > >
> > > > >
> > > > > >
> > > > > > For non standard device we don't have choices other than
> > > > > > passthrough, but for standard devices we have other choices.
> > > > >
> > > > > Passthrough is basic requirement that we will be fulfilling.
> > > >
> > > > It has several drawbacks that I would not like to repeat. We all
> > > > know even for VFIO, it requires a trap instead of a complete passth=
rough.
> > > >
> > > Sure. Both has pros and cons.
> > > And both can co-exist.
> >
> > I don't see how it can co-exist with your proposal. I can see how admin
> > commands can co-exist on top of this series.
> >
> The reason to me both has difficulty is because both are solving differen=
t problem.
> And they can co-exist as two different methods to two different problems.

It's not hard to demonstrate how admin commands can be built on top.

>
> > >
> > > > > If one wants to do special nesting, may be, there.
> > > >
> > > > Nesting is not special. Go and see how it is supported by major
> > > > cloud vendors and you will get the answer. Introducing an interface
> > > > in virtio that is hard to be virtualized is even worse than writing
> > > > a compiler that can not do bootstrap compilation.
> > > We checked with more than two major cloud vendors and passthrough suf=
fice
> > their use cases and they are not doing nesting.
> > > And other virtio vendor would also like to support native devices. So=
 again,
> > please do not portray that nesting is the only thing and passthrough mu=
st not be
> > done.
> >
> > Where do I say passthrough must not be done? I'm saying you need to jus=
tify
> > your proposal instead of simply saying "hey, you are wrong".
> >
> I never said you are wrong. I replied to Lingshan that resuming/suspendin=
g queues after the device is suspended, is wrong, and it should not be done=
.
>
> > Again, nesting is not the only issue, the key point is that it's partia=
l and not self
> > contained.
>
> Admin commands are self-contained to the owner device.
> They are not self contained in the member device, because it cannot be.

There're cases that self contained is not required for example the
provisioning. Admin commands/queues fit perfectly there.

> Self containment cannot work with device reset, flr, dma flow.

How do you define self containment? We all know that virtio can't fly
without transporting specific things ...

For the context of "self contain" I mean the basic virtio facility
needs to be self contained.

> Self containment requires mediation or renamed trap+emulation; which is t=
he anti-goal of passtrough.
> And I am very interested if you can show how admin commands can work with=
 device reset, flr flow WITHOUT mediation approach.

Why is it the job for me? This proposal doesn't use admin commands at all.

Thanks





> Lingshan so far didn=E2=80=99t answer this.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

