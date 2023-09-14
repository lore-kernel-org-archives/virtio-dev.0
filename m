Return-Path: <virtio-dev-return-13752-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34CE0EE021B
	for <virtio-dev@archiver.kernel.org>; Thu, 14 Sep 2023 03:09:16 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 760E62CADB
	for <virtio-dev@archiver.kernel.org>; Thu, 14 Sep 2023 03:09:15 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4A7E9986649
	for <virtio-dev@archiver.kernel.org>; Thu, 14 Sep 2023 03:09:15 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 2C9B7983BBB; Thu, 14 Sep 2023 03:09:15 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 17E07983D42
	for <virtio-dev@lists.oasis-open.org>; Thu, 14 Sep 2023 03:09:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: KJXtkTC8PfWj0fkfH7JEGg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694660950; x=1695265750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2xjeIT/mTn5s7x9cXhy+Lkhn2ZrgddPDGWcshGeU1PM=;
        b=crmjUahhZTFuF/c94BmX3mbzCr+L0Me78bwAP/8PEkcJhoFAe2muJI7Bo76d+kbedC
         17m8iqMN8r7XeYZGep3RVz0DR98FBrM2fSF9n00P/0OpL1QgT40YmwyXmi2WnZbZYOVg
         nmk6b9/BIyaWd/L2Sb5EWOR+5xw0xfjN20q/ZJFGQbb3y7waUflebaVlBYVBbG9xw55A
         fHp4bOHnftyErOBl2JgB37VQ3+yF7Z1pXml1X4TlUaf21dmmldFaZh2ShD2wFiyGP6nW
         Ygrk4GrJz5/B5o4/S6K86ylx8Lt4m8R68Y17x6Um+Q3ddABA4s+6chZDoL9TBG51mFqC
         UWEA==
X-Gm-Message-State: AOJu0YzLSj5PXnI+TtzvuL5s9lDq6D7mgbfR6S+E4YBtIP0MEY0y6JLp
	UYbEcdo3qSpty/gHMGZSOyPcTqCOR5LItiihIoYTSNKaf8/n8a7L4E9c2jajE/KWTKI1uTJ1Eyo
	EotEgeO/FsNniWkPeNIFnlfdHy6GW8TUjeXbjzyt4vkMI
X-Received: by 2002:ac2:4f13:0:b0:500:a41d:354c with SMTP id k19-20020ac24f13000000b00500a41d354cmr3907987lfr.28.1694660950596;
        Wed, 13 Sep 2023 20:09:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAwK9sIyuBtEjIDsMGiXKYjJ8K27gfLo1lDCA0t/KzKHrANdFGwyirJd8rY6nUJ9k+Teb8XfmNv49ZSxulxW8=
X-Received: by 2002:ac2:4f13:0:b0:500:a41d:354c with SMTP id
 k19-20020ac24f13000000b00500a41d354cmr3907976lfr.28.1694660950182; Wed, 13
 Sep 2023 20:09:10 -0700 (PDT)
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
 <CACGkMEtor0uDs9xUDXH1ZA3n9Zb9kzP9MAYwN5h6em+39gNfXg@mail.gmail.com> <PH0PR12MB54812276639E77E75EC7FEC6DCF0A@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB54812276639E77E75EC7FEC6DCF0A@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 14 Sep 2023 11:08:58 +0800
Message-ID: <CACGkMEt09Wi2Hg3bgpSW0Dgh6Bqwk4wbtyb_=uwUOM71SPURBw@mail.gmail.com>
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

On Wed, Sep 13, 2023 at 2:39=E2=80=AFPM Parav Pandit <parav@nvidia.com> wro=
te:
>
>
> > From: Jason Wang <jasowang@redhat.com>
> > Sent: Wednesday, September 13, 2023 10:15 AM
>
> [..]
> > > > > [1]
> > > > > https://lists.oasis-open.org/archives/virtio-comment/202309/msg00=
0
> > > > > 61.h
> > > > > tml
> > > >
> > > > The series works for stateless devices. Before we introduce device
> > > > states in the spec, we can't migrate stateful devices. So the devic=
e
> > > > context doesn't make much sense right now.
> > > The series works for stateful devices too. The device context covers =
it.
> >
> > How? Can it be used for migrating any existing stateful devices? Don't =
we need
> > to define what context means for a specific stateful device before you =
can
> > introduce things like device context? Please go through the archives fo=
r the
> > relevant discussions (e.g virtio-FS), it's not as simple as introducing=
 a device
> > context API.
> >
> A device will have its own context for example RSS definition, or flow fi=
lters tomorrow.

If you know there are things that are missing when posting the
patches, please use the RFC tag.

> The device context will be extended post the first series.
>
> > And what's more, how can it handle the migration compatibility?
> It will be taken care in follow on as we all know that this to be checked=
.

You don't even mention it anywhere in your series.

> I will include the notes of future follow up work items in v1, which will=
 be taken care post this series.
>
> > > > Dirty page tracking in virtio is not a must for live migration to
> > > > work. It can be done via platform facilities or even software. And
> > > > to make it more efficient, it needs to utilize transport facilities=
 instead of a
> > general one.
> > > >
> > > It is also optional in the spec proposal.
> > > Most platforms claimed are not able to do efficiently either,
> >
> > Most platforms are working towards an efficient way. But we are talking=
 about
> > different things, hardware based dirty page logging is not a must, that=
 is what
> > I'm saying. For example, KVM doesn't use hardware to log dirty pages.
> >
> I also said same, that hw based dirty page logging is not must. :)
> One day hw mmu will be able to track everything efficiently. I have not s=
een it happening yet.

How do you define efficiency? KVM uses page fault and most modern
IOMMU support PRI now.

>
> > > hence the vfio subsystem added the support for it.
> >
> > As an open standard, if it is designed for a specific software subsyste=
m on a
> > specific OS, it's a failure.
> >
> It is not.
> One need accept that, in certain areas virtio is following the trails of =
advancement already done in sw stack.
> So that virtio spec advancement fits in to supply such use cases.
> And blocking such advancement of virtio spec to promote only_mediation ap=
proach is not good either.
>
> BTW: One can say the mediation approach is also designed for specific sof=
tware subsystem and hence failure.
> I will stay away from quoting it, as I don=E2=80=99t see it this way.

The proposal is based on well known technology since the birth of
virtualization. I never knew a mainstream hypervisor that doesn't do
trap and emulate, did you?

>
> > >
> > > > The FLR, P2P demonstrates the fragility of a simple passthrough
> > > > method and how it conflicts with live migration and complicates the=
 device
> > implementation.
> > > Huh, it shows the opposite.
> > > It shows that both will seamlessly work.
> >
> > Have you even tried your proposal with a prototype device?
> Of course, it is delivered to user for 1.5 years ago before bringing it t=
o the spec with virtio-net and virtio-blk devices.

I hope this is your serious answer, but it looks like it is not. Your
proposal misses a lot of states as I pointed out in another thread,
how can it work in fact?

>
> >
> > >
> > > > And it means you need to audit all PCI features and do workaround i=
f
> > > > there're any possible issues (or using a whitelist).
> > > No need for any of this.
> >
> > You need to prove this otherwise it's fragile. It's the duty of the aut=
hor to justify
> > not the reviewer.
> >
> One cannot post patches and nor review giant series in one go.
> Hence the work to be split on a logical boundary.
> Features provisioning, pci layout etc is secondary tasks to take care of.

Again, if you know something is missing, you need to explain it in the
series instead of waiting for some reviewers to point it out and say
it's well-known afterwards.

>
> > For example FLR is required to be done in 100ms. How could you achieve =
this
> > during the live migration? How does it affect the downtime and FRS?
> >
> Good technical question to discuss instead of passthrough vs mediation. :=
)
>
> Device administration work is separate from the device operational part.
> The device context records what is the current device context, when the F=
LR occurs, the device stops all the operations.
> And on next read of the device context the FLRed context is returned.

Firstly, you didn't explain how it affects the live migration, for
example, what happens if we try to migrate while FLR is ongoing.
Secondly, you ignore the other two questions.

Let's save the time of both.

>
> > >
> > > > This is tricky and we are migrating virtio not virtio-pci. If we
> > > > don't use simple passthrough we don't need to care about this.
> > > >
> > > Exactly, we are migrating virtio device for the PCI transport.
> >
> > No, the migration facility is a general requirement for all transport.
> It is for all transport. One can extend when do for MMIO.

By using admin commands? It can not perform well for registered.

>
> > Starting from a PCI specific (actually your proposal does not even cove=
r all even
> > for PCI) solution which may easily end up with issues in other transpor=
ts.
> >
> Like?

The admin command/virtqueue itself may not work well for other
transport. That's the drawback of your proposal while this proposal
doesn't do any coupling.

>
> > Even if you want to migrate virtio for PCI,  please at least read Qemu =
migration
> > codes for virtio and PCI, then you will soon realize that a lot of thin=
gs are
> > missing in your proposal.
> >
> Device context is something that will be extended.
> VIRTIO_PCI_CAP_PCI_CFG will also be added as optional item for PCI transp=
ort.

This is just one mini stuff, how about PCI config space and others?

Again, please read Qemu codes, a lot of things are missing in your
proposal now. If everything is fine to do passthrough based live
migration, I'm pretty sure you need more than what Qemu has since it
can only do a small fraction of the whole PCI.

>
> > > As usual, if you have to keep arguing about not doing passhthrough, w=
e are
> > surely past that point.
> >
> > Who is "we"?
> >
> We =3D You and me.
> From 2021, you keep objecting that passthrough must not be done.

This is a big misunderstanding, you need to justify it or at least
address the concerns from any reviewer.

> And blocking the work done by other technical committee members to improv=
e the virtio spec to make that happen is simply wrong.

It's unrealistic to think that one will be 100% correct. Justify your
proposal or why I was wrong instead of ignoring my questions and
complaining. That is why we need a community. If it doesn't work,
virtio provides another process for convergence.

>
> > Is something like what you said here passed the vote and written
> > to the spec?
> Not only me.
> The virtio technical committee has agreed for nested and hardware-based i=
mplementation _both_.
>
> " hardware-based implementations" is part of the virtio specification cha=
rter with ballot of [1].
>
> [1] https://lists.oasis-open.org/archives/virtio/202104/msg00038.html

Let's don't do conceptual shifts, I was asking the passthrough but you
give me the hardware implementation.

>
> And passthrough hardware-based device is in the charter that we strive to=
 support.
>
> > We all know the current virtio spec is not built upon passthrough.
>
> This efforts improve the passthrough hw based implementation that should =
not be blocked.

Your proposal was posted only for several days and you think I would
block that just because I asked several questions and some of them are
not answered?

>
> > > Virtio does not need to stay in the weird umbrella to always mediate =
etc.
> >
> > It's not the mediation, we're not doing vDPA, the device model we had i=
n
> > hardware and we present to guests are all virtio devices. It's the trap=
 and
> > emulation which is fundamental in the world of virtualization for the p=
ast
> > decades. It's the model we used to virtualize standard devices. If you =
want to
> > debate this methodology, virtio community is clearly the wrong forum.
> >
> I am not debating it at all. You keep bringing up the point of mediation.
>
> The proposal of [1] is clear that wants to do hardware based passthrough =
devices with least amount of virtio level mediation.
>
> So somewhere mode of virtualizing has been used, that=E2=80=99s fine, it =
can continue with full virtualization, mediation,
>
> And also hardware based passthrough device.
>
> > >
> > > Series [1] will be enhanced further to support virtio passthrough dev=
ice for
> > device context and more.
> > > Even further we like to extend the support.
> > >
> > > > Since the functionality proposed in this series focus on the minima=
l
> > > > set of the functionality for migration, it is virtio specific and
> > > > self contained so nothing special is required to work in the nest.
> > >
> > > Maybe it is.
> > >
> > > Again, I repeat and like to converge the admin commands between
> > passthrough and non-passthrough cases.
> >
> > You need to prove at least that your proposal can work for the passthro=
ugh
> > before we can try to converge.
> >
> What do you mean by "prove"? virtio specification development is not proo=
f based method.

For example, several of my questions were ignored.

>
> If you want to participate, please review the patches and help community =
to improve.

See above.

>
> > > If we can converge it is good.
> > > If not both modes can expand.
> > > It is not either or as use cases are different.
> >
> > Admin commands are not the cure for all, I've stated drawbacks in other
> > threads. Not repeating it again here.
> He he, sure, I am not attempting to cure all.
> One solution does not fit all cases.

Then why do you want to couple migration with admin commands?

> Admin commands are used to solve the specific problem for which the AQ is=
 designed for.
>
> One can make argument saying take pci fabric to 10 km distance, don=E2=80=
=99t bring new virtio tcp transport...
>
> Drawing boundaries around virtio spec in certain way only makes it furthe=
r inferior. So please do not block advancements bring in [1].

As a reviewer, I ask questions but some of them are ignored, do you
expect the reviewer to figure out by themselves?  If yes, then the
virtio community is not the only community that can block you.

> We really would like to make it more robust with your rich experience and=
 inputs, if you care to participate.

We can collaborate for sure: as I pointed out in another threads, from
what I can see from the both proposals of the current version:

I see a good opportunity to build your admin commands proposal on top
of this proposal. Or it means, we can focus on what needs to be
migrated first:

1) queue state
2) inflight descriptors
3) dirty pages (optional)
4) device state(context) (optional)

I'd leave 3 or 4 since they are very complicated features. Then we can
invent an interface to access those facilities? This is how this
series is structured.

And what's more, admin commands or transport specific interfaces. And
when we invent admin commands, you may realize you are inventing a new
transport which is the idea of transport via admin commands.

Thanks


>
> [1] https://lists.oasis-open.org/archives/virtio-comment/202309/msg00061.=
html


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

