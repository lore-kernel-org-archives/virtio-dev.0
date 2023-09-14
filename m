Return-Path: <virtio-dev-return-13753-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DE08EE021A
	for <virtio-dev@archiver.kernel.org>; Thu, 14 Sep 2023 03:11:28 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 9F73C602F2
	for <virtio-dev@archiver.kernel.org>; Thu, 14 Sep 2023 03:11:27 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 75FD898664F
	for <virtio-dev@archiver.kernel.org>; Thu, 14 Sep 2023 03:11:27 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 5971C98663D; Thu, 14 Sep 2023 03:11:27 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 488DA986639
	for <virtio-dev@lists.oasis-open.org>; Thu, 14 Sep 2023 03:11:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: eHaYyof0MqShy4lmYkgK1g-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694661082; x=1695265882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kzQWa5wh+dvVks5DlKFnXT8Up3k5eb/zKUE94Zs3v6g=;
        b=U+msEL0M0kMbNE992FZ1K1ONrdO5szIeftiewBKDMOsftO3wZOasQKZlvEHlwUdzo/
         afDcek8lWsY4QqWJzlKL2Byu8lyTMjXLscWrXWHYBOGV51WpsFWANqIH5fIy+bJlIRdu
         goYzqdVcnkqewHZobS7qSInDVAIB2fdvo4kjhYeVFaUAtpPZ3AlRRKSVMTbv0Bl7LuZQ
         wSHh8HK0h876P6CbR0yxoxjoxQxm9dRSyDIVRmPrFe93cj+QlYfTjrA12Yc2M75RbPGL
         eBEbxIo9lZtjzoel/uyiFyR46QWc8MezxHhxX1k3i3EsUk3KVhEAnb2tzNmAsHyijpHm
         WOAA==
X-Gm-Message-State: AOJu0YxHKLdYjvM1nCN2axMaNKdUdkiBy0esUs0NWTY/Gcufwu3qeeFp
	KaBxSGayJMnnyiL507y3NHk8UKajG2++9+uY8BypZKIdvcNyJfKJ+PUeTQW0z4BVRLWCIRMGDzl
	W2Yj90G2DtItElT4H+p2xWuPrNYV/4jj9hVe8Tz4zuPOYuOJnkvfFpuM=
X-Received: by 2002:a05:6512:1151:b0:500:9bbf:da17 with SMTP id m17-20020a056512115100b005009bbfda17mr4058272lfg.51.1694661082765;
        Wed, 13 Sep 2023 20:11:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKy+6DSRjU/mep65tJ+HokwX7uM28ImaPCwX0OizGbHysSRufCJerxI3NOG30a05SDHPNNIaFW5yvgmcWU+Dc=
X-Received: by 2002:a05:6512:1151:b0:500:9bbf:da17 with SMTP id
 m17-20020a056512115100b005009bbfda17mr4058255lfg.51.1694661082416; Wed, 13
 Sep 2023 20:11:22 -0700 (PDT)
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
 <CACGkMEtFWZAQ0fKFBJYpRGR_RCNyDZSxXY+22y==PbuZqHzrVA@mail.gmail.com> <PH0PR12MB5481169EDDE5B82D71BCCE95DCF0A@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB5481169EDDE5B82D71BCCE95DCF0A@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 14 Sep 2023 11:11:11 +0800
Message-ID: <CACGkMEt0OHL7pwR7pY-xv9PdLHxM1oLw3vOVdVwys4=W_VodGw@mail.gmail.com>
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

On Wed, Sep 13, 2023 at 2:06=E2=80=AFPM Parav Pandit <parav@nvidia.com> wro=
te:
>
>
> > From: Jason Wang <jasowang@redhat.com>
> > Sent: Wednesday, September 13, 2023 10:14 AM
> > To: Parav Pandit <parav@nvidia.com>
>
> > > One can build infinite level of nesting to not do passthrough, at the=
 end user
> > applications remains slow.
> >
> > We are talking about nested virtualization but nested emulation. I won'=
t repeat
> > the definition of virtualization but no matter how much level of nestin=
g, the
> > hypervisor will try hard to let the application run natively for most o=
f the time,
> > otherwise it's not the nested virtualization at all.
> >
> > Nested virtualization has been supported by all major cloud vendors, pl=
ease
> > read the relevant documentation for the performance implications. Virti=
o
> > community is not the correct place to debate whether a nest is useful. =
We need
> > to make sure the datapath could be assigned to any nest layers without =
losing
> > any fundamental facilities like migration.
> >
> I am not debating. You or Lingshan claim or imply that mediation is the o=
nly way to progress.

Let me correct your temiology again. It's "trap and emulation" . It
means the workload runs mostly native but sometimes is trapped by the
hypervisor.

And it's not the only way. It's the start point since all current
virtio spec is built upon this methodology.

> And for sure virtio do not need to live in the dark shadow of mediation a=
lways.

99% of virtio devices are implemented in this way (which is what you
call dark and shadow) now.

> For nesting use case sure one can do mediation related mode.
>
> So only mediation is not the direction.

CPU and MMU virtualization were all built in this way.

>
> > > So for such N and M being > 1, one can use software base emulation an=
yway.
> >
> > No, only the control path is trapped, the datapath is still passthrough=
.
> >
> Again, it depends on the use case.

No matter what use case, the definition and methodology of
virtualization stands still.

>
> > >
> > > >
> > > > And exposing the whole device to the guest drivers will have
> > > > security implications, your proposal has demonstrated that you need
> > > > a workaround for
> > > There is no security implications in passthrough.
> >
> > How can you prove this or is it even possible for you to prove this?
> Huh, when you claim that it is not secure, please point out exactly what =
is not secure.
> Please take with PCI SIG and file CVE to PCI sig.

I am saying it has security implications. That is why you need to
explain why you think it doesn't. What's more, the implications are
obviously nothing related to PCI SIG but a vendor virtio hardware
implementation.

>
> > You expose all device details to guests (especially the transport speci=
fic details),
> > the attack surface is increased in this way.
> One can say it is the opposite.
> Attack surface is increased in hypervisor due to mediation poking at ever=
ything controlled by the guest.
>

We all know such a stack has been widely used for decades. But you
want to say your new stack is much more secure than this?

>
> >
> > What's more, a simple passthrough may lose the chance to workaround
> > hardware erratas and you will finally get back to the trap and emulatio=
n.
> Hardware errata's is not the starting point to build the software stack a=
nd spec.

It's not the starting point. But it's definitely something that needs
to be considered, go and see kernel codes (especially the KVM part)
and you will get the answer.

> What you imply is, one must never use vfio stack, one must not use vcpu a=
cceleration and everything must be emulated.

Do I say so? Trap and emulation is the common methodology used in KVM
and VFIO. And if you want to replace it with a complete passthrough,
you need to prove your method can work.

>
> Same argument of hardware errata applied to data path too.

Anything makes datapath different? Xen used to fallback to shadow page
tables to workaround hardware TDP errata in the past.

> One should not implement in hw...
>
> I disagree with such argument.

It's not my argument.

>
> You can say nesting is requirement for some use cases, so spec should sup=
port it without blocking the passthrough mode.
> Then it is fair discussion.
>
> I will not debate further on passthrough vs control path mediation as eit=
her_or approach.
>
> >
> > >
> > > > FLR at least.
> > > It is actually the opposite.
> > > FLR is supported with the proposal without any workarounds and mediat=
ion.
> >
> > It's an obvious drawback but not an advantage. And it's not a must for =
live
> > migration to work. You need to prove the FLR doesn't conflict with the =
live
> > migration, and it's not only FLR but also all the other PCI facilities.
> I don=E2=80=99t know what you mean by prove. It is already clear from the=
 proposal FLR is not messing with rest of the device migration infrastructu=
re.
> You should read [1].

I don't think you answered my question in that thread.

>
> > one other
> > example is P2P and what's the next? As more features were added to the =
PCI
> > spec, you will have endless work in auditing the possible conflict with=
 the
> > passthrough based live migration.
> >
> This drawback equally applies to mediation route where one need to do mor=
e than audit where the mediation layer to be extended.

No, for trap and emulation we don't need to do that. We only do
datapath assignments.

> So each method has its pros and cons. One suits one use case, other suits=
 other use case.
> Therefore, again attempting to claim that only mediation approach is the =
only way to progress is incorrect.

I never say things like this, it is your proposal that mandates
migration with admin commands. Could you please read what is proposed
in this series carefully?

On top of this series, you can build your amd commands easily. But
there's nothing that can be done on top of your proposal.

>
> In fact audit is still better than mediation because most audits are read=
 only work as opposed to endlessly extending trapping and adding support in=
 core stack.

One reality that you constantly ignore is that such trapping and
device models have been widely used by a lot of cloud vendors for more
than a decade.

> Again, it is a choice that user make with the tradeoff.
>
> > >
> > > >
> > > > For non standard device we don't have choices other than
> > > > passthrough, but for standard devices we have other choices.
> > >
> > > Passthrough is basic requirement that we will be fulfilling.
> >
> > It has several drawbacks that I would not like to repeat. We all know e=
ven for
> > VFIO, it requires a trap instead of a complete passthrough.
> >
> Sure. Both has pros and cons.
> And both can co-exist.

I don't see how it can co-exist with your proposal. I can see how
admin commands can co-exist on top of this series.

>
> > > If one wants to do special nesting, may be, there.
> >
> > Nesting is not special. Go and see how it is supported by major cloud v=
endors
> > and you will get the answer. Introducing an interface in virtio that is=
 hard to be
> > virtualized is even worse than writing a compiler that can not do boots=
trap
> > compilation.
> We checked with more than two major cloud vendors and passthrough suffice=
 their use cases and they are not doing nesting.
> And other virtio vendor would also like to support native devices. So aga=
in, please do not portray that nesting is the only thing and passthrough mu=
st not be done.

Where do I say passthrough must not be done? I'm saying you need to
justify your proposal instead of simply saying "hey, you are wrong".

Again, nesting is not the only issue, the key point is that it's
partial and not self contained.

Thanks

>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

