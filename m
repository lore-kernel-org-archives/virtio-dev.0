Return-Path: <virtio-dev-return-12266-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5115AC77B75
	for <virtio-dev@archiver.kernel.org>; Tue, 18 Apr 2023 01:02:10 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id A68104434A
	for <virtio-dev@archiver.kernel.org>; Tue, 18 Apr 2023 01:02:09 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9B46E9863FB
	for <virtio-dev@archiver.kernel.org>; Tue, 18 Apr 2023 01:02:09 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 8EE099863E3; Tue, 18 Apr 2023 01:02:09 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7DC589863E7
	for <virtio-dev@lists.oasis-open.org>; Tue, 18 Apr 2023 01:02:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: Ery-nPGROLSGyCU2n3nZpA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681779719; x=1684371719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UTGTph0pC6UdLlfMw8+jivxp4zJiPkXAY0gCi/0OVeQ=;
        b=G8ushjVjbqmOOWFtyTLNEU5fuFaz5oNYFkzpc8XyZeRZEcBFaoETpRaDXpDejxm+mS
         FlFawEsNBLAgmtELT+iVuFEFSbbIp8UGTZLNvzufdubs53ejCoNkfVjdE++ieP5eJUOa
         C9SIUtu/ywmqhDa/oqqTnW33orT4iUJKFn7D/YfcHTiJB8ISO9MYXKW5miHivLbcdyMP
         9vctwoh3QESlu3832R1uM6u5lVqG4XRB7kSCE0UtLxBFaA9swH0HY6wdlbFodUzP9oTA
         xSkKnlW/0z99P/NrGOvHrtm3ZTxwzzyCJgg97XVOOaEPNLny07dWtZQsX9ID1wwpzjup
         4YXQ==
X-Gm-Message-State: AAQBX9ev2A628HmA8Pysyhd8lGc09jGTPrqexw4Cz/+38YAMXBSHF7C5
	hpQbdawuwpsuSvX6U10diNYzaV8CuxdMVuJ82oMaGTNtODmFiC27cK3CzYrdWMNkBQKW0S+mLvS
	phJf8SIP256l8XCCvNmXB8tuLYZPtCcYWIe/g9MC72asW
X-Received: by 2002:a05:6870:a784:b0:187:e1d0:ea18 with SMTP id x4-20020a056870a78400b00187e1d0ea18mr209669oao.9.1681779718944;
        Mon, 17 Apr 2023 18:01:58 -0700 (PDT)
X-Google-Smtp-Source: AKy350Y/e7JACBRt7koB3XvrmBdGnTQEsetGx5I0s67hzl2dTSyUMPFMp8jMi8TPwO9bOulMS1qt6QsnqDm9j1fWZAw=
X-Received: by 2002:a05:6870:a784:b0:187:e1d0:ea18 with SMTP id
 x4-20020a056870a78400b00187e1d0ea18mr209657oao.9.1681779718616; Mon, 17 Apr
 2023 18:01:58 -0700 (PDT)
MIME-Version: 1.0
References: <PH0PR12MB548118F57BB4B4A4F8DC9D7ADC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEvYsz1fSPG+fKpRaZ05Ut7ffKwvMPvR8xbRBsXA_6vGQw@mail.gmail.com>
 <PH0PR12MB548137D7A25C99EAA42B4D12DC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEshW82qztmGw8YJWJ8=QCoRd6cPxQ+ySazxsO_o+U6c4Q@mail.gmail.com>
 <PH0PR12MB548147CF939CB9C2A0586310DC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEu2B_GogDR9HUwB7mT8fkGh+Q_buPLz4nhwhK7h9k6BQQ@mail.gmail.com>
 <PH0PR12MB5481F0CF5A555A6BB2CE856CDC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEuNOYOxvcSzrs0UFEyk+xOkGUpOfhK8rOy_Mebz5b5wdg@mail.gmail.com>
 <a74d3107-d38c-df15-e2ff-f848635f24bd@nvidia.com> <CACGkMEt+bGN7UYEopXPj0+deAnYm1VUNp05VvGHcJnkd8LzbGg@mail.gmail.com>
 <20230413130326-mutt-send-email-mst@kernel.org> <PH0PR12MB54819A5D8FCEC6375D80897DDC989@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEvSSXyXQnRs=OiaSJnSEYHP83chL6-B5ZPCGx6TeW9W5Q@mail.gmail.com>
 <PH0PR12MB548135CF5268D979A6D8EDE8DC999@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEsHtC99kTTa0TrfeJuhV+F7e-WF7XRgbLJkCBQeAxW8pA@mail.gmail.com>
 <PH0PR12MB5481C29561D5E48BA5D8AEEEDC999@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEseO=4xDA+pH2x=CaJ6XyzHEx1ZFO-+uevJH50kLeSWhA@mail.gmail.com> <PH0PR12MB5481FFC95F54AD048927FF12DC9C9@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB5481FFC95F54AD048927FF12DC9C9@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 18 Apr 2023 09:01:47 +0800
Message-ID: <CACGkMEutqWiq7A76LcE+wDoS+81rgANBtxeccjw7JL4iLn3_gQ@mail.gmail.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>, 
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>, 
	Satananda Burla <sburla@marvell.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, 
	Yan Vugenfirer <yan@daynix.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [virtio-comment] Re: [PATCH 09/11] transport-pci: Describe PCI
 MMR dev config registers

On Tue, Apr 18, 2023 at 1:23=E2=80=AFAM Parav Pandit <parav@nvidia.com> wro=
te:
>
>
>
> > From: Jason Wang <jasowang@redhat.com>
> > Sent: Sunday, April 16, 2023 11:23 PM
> >
> > On Fri, Apr 14, 2023 at 11:51=E2=80=AFAM Parav Pandit <parav@nvidia.com=
> wrote:
> > >
> > >
> > >
> > > > From: Jason Wang <jasowang@redhat.com>
> > > > Sent: Thursday, April 13, 2023 11:38 PM
> > >
> > > > > > 1) spec doesn't enforce the size of a specific structure
> > > > > Spec will be extended in coming time.
> > > >
> > > > It's too late to do any new restriction without introducing a flag.
> > > We are really diverging from the topic.
> > > I don=E2=80=99t think it is late. The work in this area of PCI VF has=
 not even begun fully.
> >
> > I meant it needs a new feature flag.
> >
> Ok.
> > >
> > > > Mandating size may easily end up with a architecte specific solutio=
n.
> > > >
> > > Unlikely. Other standard device types are also expanding this way.
> >
> > I think we are talking about software technologies instead of device de=
sign
> > here.
> >
> Isn't the size of BAR and its cap_len exposed by the device?

Somehow, it's more about how the hypervisor is going to use this,
memory mapped or trapping. For either case, the hypervisor needs to
have virtio knowledge in order to finish this.

>
> > For devices it works.But for hypervisor, it needs to deal with the size=
 that
> > doesn't match arch's page size.
> >
> PCI BAR size of the VF can learn the system page size being different for=
 x86 (4K) and arm (64K).
> PCI transport seems to support it.

Yes this is for SR-IOV but not for other cases. We could invent new
facilities for sure but the hypervisor can not have this assumption.

>
> PCI PF on bare-metal has to understand the highest page size anyway if fo=
r some reason bare-metal host wants to map this PF to the VM.
>
> A hypevisor mediating and emulating needs to learn the system page size a=
nyway.
> If underlying device page size is smaller, hypevisor may end up mediating=
 it.

Exactly. So what I want to say is, for whatever case, a hypervisor
needs to have virtio knowledge in order to achieve these.

>
> > I meant you can't have recommendations in features and config.
> Sure. There is none.
>
> > What's more,
> > assuming you have two generations of device
> >
> > gen1: features x,y
> > gen2: features x,y,z
> >
> > You won't be able to do migration between gen1 and gen2 without mediati=
on.
> Gen1 can easily migrate to gen2, because gen1 has smaller subset than gen=
2.
> When gen2 device is composed, feature z is disabled.

Sure, but this requires a lot of features that do not exist in the
spec. E.g it assumes the device could be composed on demand which
seems to fit the idea of transport virtqueue. So it adds dependencies
for migration where a simple mediation could be used to solve this
without bothering the spec.

>
> Gen2 to gen1 migration can do software-based migration anyway or through =
mediation.
> But because gen2 may need to migrate to gen1, hence gen2 to gen2 migratio=
n also should be done through mediation, doesn=E2=80=99t make sense to me.

It really depends on the design:

1) if you want to expose any features that is done by admin virtqueue
to a guest, mediation is a must (e.g if you want do live migration for
L1)
2) mediation is a must for the idea of transport virtqueue

>
> > Such technologies have been used by cpu features for years.
> > I am not sure why it became a problem for you.
> >
> > > Apart from it some of the PCI device layout compat checks will be cov=
ered
> > too.
> > >
> > > > And what you proposed is to allow the management to know the exact
> > > > hardware layout in order to check the compatibility? And the
> > > > management needs to evolve as new structures are added.
> > > Mostly not mgmt stack may not need to evolve a lot.
> > > Because most layouts should be growing within the device context and =
not at
> > the PCI capabilities etc area.
> > >
> > > And even if it does, its fine as large part of it standard PCI spec d=
efinitions.
> >
> > So as mentioned in another thread, this is a PCI specific solution:
> >
> > 1) feature and config are basic virtio facility
> > 2) capability is not but specific to PCI transport
> >
> So any LM solution will have transport specific checks and virtio level c=
hecks.

So here's the model that is used by Qemu currently:

1) Device is emulated, it's the charge of the libvirt to launch Qemu
and present a stable ABI for guests.
2) Datapath doesn't need to care about the hardware details since the
hardware layout is invisible from guest

You can see, it's more than sufficient for libvirt to check
features/config space, it doesn't need to care about the hardware BAR
layout. Migration is much easier in this way. And we can use transport
other than PCI in the guest in this case for live migration.

>
> > Checking PCI capability layout in the virtio management is a layer viol=
ation
> > which can't work for future transport like SIOV or adminq.
> Virtio management that will have transport level checks is not a violatio=
n.
> SIOV will define its own transport anyway. Not to mix with ccw/mmio or pc=
i.
>
> > Management should only see virtio device otherwise the solution becomes
> > transport specific.
> >
> Solution needs to cover transport as well as transport is integral part o=
f the virtio spec.
> Each transport layer will implement feature/config/cap in its own way.

If we can avoid those hardware details to be checked, we should not go
for that. It's a great ease of the management layer.

Thanks

>
> > >
> > > > This complicates the work of
> > > > management's furtherly which I'm not sure it can work.
> > > >
> > > Well, once we work towards it, it can work. :)
> > >
> > > > >
> > > > > > Hypervisor needs to start from a mediation method and do BAR
> > > > > > assignment only when possible.
> > > > > >
> > > > > Not necessarily.
> > > > >
> > > > > > > Cons:
> > > > > > > a. More AQ commands work in sw
> > > > > >
> > > > > > Note that this needs to be done on top of the transport virtque=
ue.
> > > > > > And we need to carefully design the command sets since they
> > > > > > could be mutually exclusive.
> > > > > >
> > > > > Not sure what more to expect out of transport virtqueue compared =
to AQ.
> > > > > I didn=E2=80=99t follow, which part could be mutually exclusive?
> > > >
> > > > Transport VQ allows a modern device to be transported via adminq.
> > > >
> > > May be for devices it can work. Hypervisor mediation with CC on horiz=
on for
> > new capabilities is being reduced.
> > > So we don=E2=80=99t see transport vq may not be path forward.
> > >
> > > > And you want to add commands to transport for legacy devices.
> > > >
> > > Yes only legacy emulation who do not care about hypervisor mediation.
> > >
> > > > Can a driver use both the modern transport commands as well as the
> > > > legacy transport commands?
> > > Hard to answer, I likely do not understand as driver namespace is unc=
lear.
> >
> > Things might be simplified if we use separate queues for admin, transpo=
rt and
> > legacy.
> >
> Do you mean say we have three AQs, AQ_1, AQ_2, and AQ_3;
> AQ_1 of the PF used by admin work as SIOV device create, SRIOV MSIX confi=
guration.
> AQ_2 of the PF used for transporting legacy config access of the PCI VF
> AQ_3 of the PF for some transport work.
>
> If yes, sounds find to me.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

