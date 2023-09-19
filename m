Return-Path: <virtio-dev-return-13811-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF81FCD3437
	for <virtio-dev@archiver.kernel.org>; Tue, 19 Sep 2023 04:32:25 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 2DC9EC6123
	for <virtio-dev@archiver.kernel.org>; Tue, 19 Sep 2023 04:32:25 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1F070986533
	for <virtio-dev@archiver.kernel.org>; Tue, 19 Sep 2023 04:32:25 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 11CC79864C2; Tue, 19 Sep 2023 04:32:25 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0163298637D
	for <virtio-dev@lists.oasis-open.org>; Tue, 19 Sep 2023 04:32:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: BkmndlaDPJiflDWy3llBrQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695097937; x=1695702737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hCNysx7LRdLWpSgJwGgqOfSaZjeSSXbJh0BVES7djIs=;
        b=B58JrxhGoIKSLsc+1w2AlAWrEshLR4Uzos1Q30pAJAR+wmv6e/Ylg0gkKm5Qmu69q2
         aMYVV7cINkkuWGz1kr9ziBoyJQrK4rFZFMesaiC9iNTWo+7EvzI/W+8BhENSzZZO0Lu3
         UuO51cALHYEzg99MHiUU7z//fXcHZD4G6qHWer5hJGA0rIgWzgzYizKBCXebVPUphaS4
         vWlB3sbjdR7g+97c+zEABzAm61WZoFu9uRNrXKTpkaxL4xaZOCKkmJj9BrcyBNFKNBJu
         ev+0ODd/kpEgKuPCY4UUcmTd1llJZrozTqUsbWekCsECaVVTCRRpeW0EWWJZuzVdTZeV
         HYBg==
X-Gm-Message-State: AOJu0YwR6xcIr+fVyt3zDvadHWZ5t9XLRnCMOsmCYt9jp5p6MEBUc2AH
	8EaYSSpNSzvy4HUOe0JoXhmQn7c/4hZqFLp0/yRtHcFrf+M5is/fgEREUBb6ArP3HwLOaeNzxls
	vfoBZU0m5sfISh8J+6UTrrlGq+Sn54g8pkQxpztDEEmD5
X-Received: by 2002:a19:e055:0:b0:503:cca:e52f with SMTP id g21-20020a19e055000000b005030ccae52fmr4393615lfj.51.1695097936590;
        Mon, 18 Sep 2023 21:32:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFY8ybduH4shEU2CAuwgJdNtacbLdh2jmkMJt4ivpbJjtweFN1NWuftx3wWEooJCL6nZQYMdSU3D9oWg0GIKrw=
X-Received: by 2002:a19:e055:0:b0:503:cca:e52f with SMTP id
 g21-20020a19e055000000b005030ccae52fmr4393587lfj.51.1695097936010; Mon, 18
 Sep 2023 21:32:16 -0700 (PDT)
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
 <CACGkMEt6=AC4pYEoxNn2dpbLLEKTLj-SYV2eSUAi1ZA1LWR3qg@mail.gmail.com>
 <PH0PR12MB5481E49BFCE50AA8F8373F45DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEtor0uDs9xUDXH1ZA3n9Zb9kzP9MAYwN5h6em+39gNfXg@mail.gmail.com>
 <PH0PR12MB54812276639E77E75EC7FEC6DCF0A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEt09Wi2Hg3bgpSW0Dgh6Bqwk4wbtyb_=uwUOM71SPURBw@mail.gmail.com> <PH0PR12MB5481685198A3226BF76120C7DCF4A@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB5481685198A3226BF76120C7DCF4A@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 19 Sep 2023 12:32:04 +0800
Message-ID: <CACGkMEuVqOPrb42o2FbUJoFrRC_F5KkFNC_VgSwVV4qDW1H0Og@mail.gmail.com>
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
> > Sent: Thursday, September 14, 2023 8:39 AM
> >
> > On Wed, Sep 13, 2023 at 2:39=E2=80=AFPM Parav Pandit <parav@nvidia.com>=
 wrote:
> > >
> > >
> > > > From: Jason Wang <jasowang@redhat.com>
> > > > Sent: Wednesday, September 13, 2023 10:15 AM
> > >
> > > [..]
> > > > > > > [1]
> > > > > > > https://lists.oasis-open.org/archives/virtio-comment/202309/m=
s
> > > > > > > g000
> > > > > > > 61.h
> > > > > > > tml
> > > > > >
> > > > > > The series works for stateless devices. Before we introduce
> > > > > > device states in the spec, we can't migrate stateful devices. S=
o
> > > > > > the device context doesn't make much sense right now.
> > > > > The series works for stateful devices too. The device context cov=
ers it.
> > > >
> > > > How? Can it be used for migrating any existing stateful devices?
> > > > Don't we need to define what context means for a specific stateful
> > > > device before you can introduce things like device context? Please
> > > > go through the archives for the relevant discussions (e.g
> > > > virtio-FS), it's not as simple as introducing a device context API.
> > > >
> > > A device will have its own context for example RSS definition, or flo=
w filters
> > tomorrow.
> >
> > If you know there are things that are missing when posting the patches,=
 please
> > use the RFC tag.
> >
> It is not missing. They are optional, which is why it is not needed in th=
is series.
>
> > > The device context will be extended post the first series.
> > >
> > > > And what's more, how can it handle the migration compatibility?
> > > It will be taken care in follow on as we all know that this to be che=
cked.
> >
> > You don't even mention it anywhere in your series.
> >
> Migration compatibility is topic in itself regardless of device migration=
 series.

Why? Without compatibility support, migration can't work in the
production environment.

> It is part of the feature provisioning phase needed regardless.

Definitely not, it is something that must be considered even without
any feature. It's about the robustness of the migration protocol.
Sometimes you need to do that since some states were lost in the
previous version of protocols or formats .

> Like how you and Lingshan wanted to keep the suspend bit series small and=
 logical, device migration series is also logically split for the functiona=
lity.
> I don=E2=80=99t see a need to mention the long known missing functionalit=
y and common to both approaches.

Again, your proposal needs to describe at least the plan for dealing
with migration compatibility since you want a passthrough based
solution. That's the point.

>
> > > I will include the notes of future follow up work items in v1, which =
will be
> > taken care post this series.
> > >
> > > > > > Dirty page tracking in virtio is not a must for live migration
> > > > > > to work. It can be done via platform facilities or even
> > > > > > software. And to make it more efficient, it needs to utilize
> > > > > > transport facilities instead of a
> > > > general one.
> > > > > >
> > > > > It is also optional in the spec proposal.
> > > > > Most platforms claimed are not able to do efficiently either,
> > > >
> > > > Most platforms are working towards an efficient way. But we are
> > > > talking about different things, hardware based dirty page logging i=
s
> > > > not a must, that is what I'm saying. For example, KVM doesn't use h=
ardware
> > to log dirty pages.
> > > >
> > > I also said same, that hw based dirty page logging is not must. :) On=
e
> > > day hw mmu will be able to track everything efficiently. I have not s=
een it
> > happening yet.
> >
> > How do you define efficiency? KVM uses page fault and most modern IOMMU
> > support PRI now.
> >
> One cannot define PRI as mandatory feature.

There's no way to mandate PRI, it's a PCI specific facility.

> In our research and experiments we see that PRI is significantly slower t=
o handle page faults.
> Yet different topic...

PRI's performance is definitely another topic, it's just an example
that tracking dirty pages by device is optional and transport (PCI)
can evolve for sure. What's more important, it demonstrates the basic
design of virtio, which is trying to leverage the transport instead of
a mandatory reveinting of everything.

>
> Efficiency is defined by the downtime of the multiple devices in a VM.

Ok, but you tend to ignore my question regarding the downtime.

> And leading OS allowed device advancements by allowing device to report d=
irty pages in cpu and platform agnostic way...
>

It has many things that I don't see a good answer for. For example,
the QOS raised by Ling Shan.

> One can use post-copy approach as well, current device migration is aroun=
d established pre-copy approach.

Another drawback of your proposal. With transport specific assistance
like PRI, you can do both pre and post. But the point is we need to
make sure pre-copy downtime can satisfy the requirement instead of
switching to another.

>
> > >
> > > > > hence the vfio subsystem added the support for it.
> > > >
> > > > As an open standard, if it is designed for a specific software
> > > > subsystem on a specific OS, it's a failure.
> > > >
> > > It is not.
> > > One need accept that, in certain areas virtio is following the trails=
 of
> > advancement already done in sw stack.
> > > So that virtio spec advancement fits in to supply such use cases.
> > > And blocking such advancement of virtio spec to promote only_mediatio=
n
> > approach is not good either.
> > >
> > > BTW: One can say the mediation approach is also designed for specific
> > software subsystem and hence failure.
> > > I will stay away from quoting it, as I don=E2=80=99t see it this way.
> >
> > The proposal is based on well known technology since the birth of virtu=
alization.
> Sure, but that does not change the fact that such series is also targeted=
 for a specific software subsystem..

How, this series reuses the existing capability by introducing just
two more registers on the existing common cfg structure and you think
it targets a specific software subsystem? If this is true, I think you
are actually challenging the design of the whole modern PCI transport.

> And hence failure.

Failure in what sense?

>
> I didn=E2=80=99t say that, I said the opposite that yes, since the virtio=
 is in catch up mode, it is defining the interface so that it can fit into =
these OS platforms.
> Mostly multiple of them, who all support passthrough devices.

We are talking about different things again.

>
> > I never knew a mainstream hypervisor that doesn't do trap and emulate, =
did
> > you?
> >
> It does trap and emulation for PCI config space, not for virtio interface=
s like queues, config space and more for passthrough devices.

Well, we are in the context of live migration, no? We all know
passthrough just works fine with the existing virtio spec...

>
> > >
> > > > >
> > > > > > The FLR, P2P demonstrates the fragility of a simple passthrough
> > > > > > method and how it conflicts with live migration and complicates
> > > > > > the device
> > > > implementation.
> > > > > Huh, it shows the opposite.
> > > > > It shows that both will seamlessly work.
> > > >
> > > > Have you even tried your proposal with a prototype device?
> > > Of course, it is delivered to user for 1.5 years ago before bringing =
it to the
> > spec with virtio-net and virtio-blk devices.
> >
> > I hope this is your serious answer, but it looks like it is not. Your p=
roposal misses
> > a lot of states as I pointed out in another thread, how can it work in =
fact?
> >
> Which states?

Let me repeat it for the third time. You don't even cover all the
functionality of common cfg, how can guests see a consistent common
cfg state?

> What is posted in series [1] is minimal and base required items,

You need to prove it is minimal, instead of ignoring my questions. For
example, dirty page tracking is definitely optional.

> optional one is omitted as it can be done incrementally.
> Lingshan had hard time digesting the basics of P2P and dirty page trackin=
g work in this short series.

You never explain why this series needs to deal with P2P and dirty
page tracking.

> So there is no point in pushing large part of the device context and maki=
ng the series blurry.

I don't see a good definition of "device context" and most of the
device context has been covered by the existing PCI capabilities.

> It will be done incrementally subsequently.
>
> > > > >
> > > > > > And it means you need to audit all PCI features and do
> > > > > > workaround if there're any possible issues (or using a whitelis=
t).
> > > > > No need for any of this.
> > > >
> > > > You need to prove this otherwise it's fragile. It's the duty of the
> > > > author to justify not the reviewer.
> > > >
> > > One cannot post patches and nor review giant series in one go.
> > > Hence the work to be split on a logical boundary.
> > > Features provisioning, pci layout etc is secondary tasks to take care=
 of.
> >
> > Again, if you know something is missing, you need to explain it in the =
series
> > instead of waiting for some reviewers to point it out and say it's well=
-known
> > afterwards.
> >
> The patch set cannot be a laundry list of items missing in virtio spec.
> It is short and focused on the device migration.

You need to mention it in the cover letter at least for a big picture
at least, what's wrong with this? It helps to save time for everyone
or people will keep asking similar questions. Is this too hard to be
understood?

>
> > >
> > > > For example FLR is required to be done in 100ms. How could you
> > > > achieve this during the live migration? How does it affect the down=
time and
> > FRS?
> > > >
> > > Good technical question to discuss instead of passthrough vs
> > > mediation. :)
> > >
> > > Device administration work is separate from the device operational pa=
rt.
> > > The device context records what is the current device context, when t=
he FLR
> > occurs, the device stops all the operations.
> > > And on next read of the device context the FLRed context is returned.
> >
> > Firstly, you didn't explain how it affects the live migration, for exam=
ple, what
> > happens if we try to migrate while FLR is ongoing.
> > Secondly, you ignore the other two questions.
> >
> > Let's save the time of both.
> >
> There is nothing to explain about device reset and live migration, becaus=
e there is absolutely there is no touch points.

Do you think this is a valid answer to my above question? Let's don't
exhaust the patience from any reviewer.

> device_status is just another registers like rest of them.

I don't see device status itself as anything related to FLR.

> One does not need to poke around registers when doing passthrough.
>
> > >
> > > > >
> > > > > > This is tricky and we are migrating virtio not virtio-pci. If w=
e
> > > > > > don't use simple passthrough we don't need to care about this.
> > > > > >
> > > > > Exactly, we are migrating virtio device for the PCI transport.
> > > >
> > > > No, the migration facility is a general requirement for all transpo=
rt.
> > > It is for all transport. One can extend when do for MMIO.
> >
> > By using admin commands? It can not perform well for registered.
> >
> Yes, admin commands using AQ on MMIO based owner device will also be just=
 fine.

Can admin commands be implemented efficiently via registered? I would
like to see how it can work.

MMIO doesn't have the concepts of group owner etc at all or do you
know how to build one?

>
> > >
> > > > Starting from a PCI specific (actually your proposal does not even
> > > > cover all even for PCI) solution which may easily end up with issue=
s in other
> > transports.
> > > >
> > > Like?
> >
> > The admin command/virtqueue itself may not work well for other transpor=
t.
> > That's the drawback of your proposal while this proposal doesn't do any
> > coupling.
> >
> There is no coupling in the spec of admin command with virtqueue as Micha=
el consistently insisted.
> And in my proposal also there is no such coupling.

I hope so but I don't think so. We need to at least do this explicitly
by moving all the state definitions to the "basic facility" part.

>
> > >
> > > > Even if you want to migrate virtio for PCI,  please at least read
> > > > Qemu migration codes for virtio and PCI, then you will soon realize
> > > > that a lot of things are missing in your proposal.
> > > >
> > > Device context is something that will be extended.
> > > VIRTIO_PCI_CAP_PCI_CFG will also be added as optional item for PCI
> > transport.
> >
> > This is just one mini stuff, how about PCI config space and others?
> >
> No need to migrate the PCI config space, because migration is of the virt=
io device, and not the underlying transport.

Let me ask you a simple question, if you don't migrate the PCI config
space, how can you guarantee that guests see the same config space
state after migration? What happens if a specific capability exists
only in the src but not the destination? Or do you want to provision
PCI capabilities?

> Therefore, one can migrate from virtio member device to a fully software =
based device as well and vis versa.

Please answer my question above.

>
> > Again, please read Qemu codes, a lot of things are missing in your prop=
osal
> > now. If everything is fine to do passthrough based live migration, I'm =
pretty sure
> > you need more than what Qemu has since it can only do a small fraction =
of the
> > whole PCI.
> >
> I will read.
> Many of the pieces may be implemented by the device over time following t=
he charter.
>
> > >
> > > > > As usual, if you have to keep arguing about not doing
> > > > > passhthrough, we are
> > > > surely past that point.
> > > >
> > > > Who is "we"?
> > > >
> > > We =3D You and me.
> > > From 2021, you keep objecting that passthrough must not be done.
> >
> > This is a big misunderstanding, you need to justify it or at least addr=
ess the
> > concerns from any reviewer.
> >
> They are getting addressed, if you have comments, please post those comme=
nts in the actual series.
> I wouldn=E2=80=99t diverge to discuss in different series here.

Well, Lingshan's series was posted before you and it's you that keep
referring to your proposal here. What's more, I've asked some
questions but most of them don't have a good answer.  So I need to
stop before I can ask more.

>
> > > And blocking the work done by other technical committee members to
> > improve the virtio spec to make that happen is simply wrong.
> >
> > It's unrealistic to think that one will be 100% correct. Justify your p=
roposal or
> > why I was wrong instead of ignoring my questions and complaining. That =
is why
> > we need a community. If it doesn't work, virtio provides another proces=
s for
> > convergence.
> >
> I am not expecting you to be correct at all. I totally agree that you may=
 miss something, I may miss something.
> And this is why I repeatedly, humbly ask to converge and jointly address =
the passthrough mode without trap+emulation method.
> The way I understood from your comment is, passthrough for hw based devic=
e must not be done and multiple of hw vendors disagree to it.

Again, this is a big misunderstanding. Passthrough can work doesn't
mean your proposal can work. I'm asking questions and want to figure
out if/how it can work correctly. But you keep ignoring them or
raising other unrelated issues.

>
> > >
> > > > Is something like what you said here passed the vote and written to
> > > > the spec?
> > > Not only me.
> > > The virtio technical committee has agreed for nested and hardware-bas=
ed
> > implementation _both_.
> > >
> > > " hardware-based implementations" is part of the virtio specification=
 charter
> > with ballot of [1].
> > >
> > > [1] https://lists.oasis-open.org/archives/virtio/202104/msg00038.html
> >
> > Let's don't do conceptual shifts, I was asking the passthrough but you =
give me
> > the hardware implementation.
> >
> Passthrough devices implemented by hw which does dirty tracking and follo=
wing the spec.

Why is passthrough coupled with dirty tracking?

>
> > >
> > > And passthrough hardware-based device is in the charter that we striv=
e to
> > support.
> > >
> > > > We all know the current virtio spec is not built upon passthrough.
> > >
> > > This efforts improve the passthrough hw based implementation that sho=
uld
> > not be blocked.
> >
> > Your proposal was posted only for several days and you think I would bl=
ock that
> > just because I asked several questions and some of them are not answere=
d?
> >
> If I misunderstood, then I am sorry.
> Lets progress and improve the passthrough use case without trap+emulation=
.

Unless any reviewer says no, the comments or concerns are a good
opportunity for you to justify your method. That's what I'm doing
right now and how the community works.

> Trap+emulation=3Dmediation is also a valid solution for nested case.

Again. Not only for the nested case. This method has been used for
cloud vendors now.

> And I frankly see a need for both as both are solving a different problem=
.

Then, let's don't couple state, suspending, dirty page tracking with
admin commands.

> Trap+emulation cannot achieve passthrough mode, hence my request was not =
to step on each other.

It's easy to not step on others, but it would end up with duplications for =
sure.

>
> When both can use the common infra, it is good to do that, when they cann=
ot, due to the technical challenges of underlying transport, they should ev=
olve differently.
>
> > >
> > > > > Virtio does not need to stay in the weird umbrella to always medi=
ate etc.
> > > >
> > > > It's not the mediation, we're not doing vDPA, the device model we
> > > > had in hardware and we present to guests are all virtio devices.
> > > > It's the trap and emulation which is fundamental in the world of
> > > > virtualization for the past decades. It's the model we used to
> > > > virtualize standard devices. If you want to debate this methodology=
, virtio
> > community is clearly the wrong forum.
> > > >
> > > I am not debating it at all. You keep bringing up the point of mediat=
ion.
> > >
> > > The proposal of [1] is clear that wants to do hardware based passthro=
ugh
> > devices with least amount of virtio level mediation.
> > >
> > > So somewhere mode of virtualizing has been used, that=E2=80=99s fine,=
 it can
> > > continue with full virtualization, mediation,
> > >
> > > And also hardware based passthrough device.
> > >
> > > > >
> > > > > Series [1] will be enhanced further to support virtio passthrough
> > > > > device for
> > > > device context and more.
> > > > > Even further we like to extend the support.
> > > > >
> > > > > > Since the functionality proposed in this series focus on the
> > > > > > minimal set of the functionality for migration, it is virtio
> > > > > > specific and self contained so nothing special is required to w=
ork in the
> > nest.
> > > > >
> > > > > Maybe it is.
> > > > >
> > > > > Again, I repeat and like to converge the admin commands between
> > > > passthrough and non-passthrough cases.
> > > >
> > > > You need to prove at least that your proposal can work for the
> > > > passthrough before we can try to converge.
> > > >
> > > What do you mean by "prove"? virtio specification development is not =
proof
> > based method.
> >
> > For example, several of my questions were ignored.
> >
> I didn=E2=80=99t ignore, but if I miss, I will answer.
>
> > >
> > > If you want to participate, please review the patches and help commun=
ity to
> > improve.
> >
> > See above.
> >
> > >
> > > > > If we can converge it is good.
> > > > > If not both modes can expand.
> > > > > It is not either or as use cases are different.
> > > >
> > > > Admin commands are not the cure for all, I've stated drawbacks in
> > > > other threads. Not repeating it again here.
> > > He he, sure, I am not attempting to cure all.
> > > One solution does not fit all cases.
> >
> > Then why do you want to couple migration with admin commands?
> >
> Because of following.
> 1. A device migration needs to bulk data transfer, this is something cann=
ot be done with tiny registers.
> Cannot be done through registers, because
> a. registers are slow for bidirectional communication
> b. do not scale well with scale of VFs

That's pretty fine, but let's not limit it to a virtqueue. Virtqueue
may not work for all the cases:

I must repeat some of Ling Shan's questions since I don't see a good
answer for them now.

1) If you want to use virtqueue to do the migration with a downtime
requirement. Is the driver required to do some sort of software QOS?
For example what happens if one wants to migrate but the admin
virtqueue is out of space? And do we need a timeout for a specific
command and if yes what happens after the timeout?
2) Assuming one round of the migration requires several commands. Are
they allowed to be submitted in a batch? If yes, how is the ordering
guaranteed or we don't need it at all? If not, why do we even need a
queue?

If you're using an existing transport specific mechanism, you don't
need to care about the above. I'm not saying admin virtqueue can't
work but it definitely has more things to be considered.

>
> > > Admin commands are used to solve the specific problem for which the A=
Q is
> > designed for.
> > >
> > > One can make argument saying take pci fabric to 10 km distance, don=
=E2=80=99t bring
> > new virtio tcp transport...
> > >
> > > Drawing boundaries around virtio spec in certain way only makes it fu=
rther
> > inferior. So please do not block advancements bring in [1].
> >
> > As a reviewer, I ask questions but some of them are ignored, do you exp=
ect the
> > reviewer to figure out by themselves?
> Sure, please review.
>
> Many of them were not questions, but assertion and conclusions that it do=
es not fit nested.. and sub-optional etc.

I think we all agree that your proposal does not fit for nesting, no?
It demonstrates that work needs to be done in the basic facility
first.

What's more the conclusion is for coupling live migration with admin
command. This point has been clarified several times before.

>
> >
> > > We really would like to make it more robust with your rich experience=
 and
> > inputs, if you care to participate.
> >
> > We can collaborate for sure: as I pointed out in another threads, from =
what I
> > can see from the both proposals of the current version:
> >
> > I see a good opportunity to build your admin commands proposal on top o=
f this
> > proposal. Or it means, we can focus on what needs to be migrated first:
> >
> > 1) queue state
> This is just one small part of the device context
> So once a device context is read/written, it covers q.

That's a layer violation. Virtqueue is the basic facility, states need
to be defined there.

>
> > 2) inflight descriptors
> Same a q state, it is part of the device context.

Admin commands are not the only way to access device context. For
example, do you agree the virtqueue address is part of the device
context? If yes, it is available in the common configuration now.

>
> > 3) dirty pages (optional)
> > 4) device state(context) (optional)
> >
> It is same as #1 and #2.
> Splitting them from #1 and #2 is not needed.
>
> We can extend the device context to be selectively queried for nested cas=
e..
>
> > I'd leave 3 or 4 since they are very complicated features. Then we can =
invent an
> > interface to access those facilities? This is how this series is struct=
ured.
> >
> > And what's more, admin commands or transport specific interfaces. And w=
hen
> > we invent admin commands, you may realize you are inventing a new trans=
port
> > which is the idea of transport via admin commands.
>
> Not really. it is not a new transport at all.
> I explained you before when you quote is as transport, it must carry the =
driver notifications as well..
> Otherwise it is just set of commands..

I've explained that you need admin commands to save and load all
existing virtio PCI capabilities. This means a driver can just use
those commands to work. If not, please explain why I was wrong.

Thanks





>
> The new commands are self contained anyway of [1].
>
> [1] https://lore.kernel.org/virtio-comment/20230909142911.524407-1-parav@=
nvidia.com/T/#t


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

