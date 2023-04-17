Return-Path: <virtio-dev-return-12245-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1084FC77B61
	for <virtio-dev@archiver.kernel.org>; Mon, 17 Apr 2023 03:22:54 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 7A7AE419AA
	for <virtio-dev@archiver.kernel.org>; Mon, 17 Apr 2023 03:22:53 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6B0AE98634A
	for <virtio-dev@archiver.kernel.org>; Mon, 17 Apr 2023 03:22:53 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 5DCBA9862EE; Mon, 17 Apr 2023 03:22:53 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 46CD4986386
	for <virtio-dev@lists.oasis-open.org>; Mon, 17 Apr 2023 03:22:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: oEOxEB3VPBex51CH58iPGw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681701764; x=1684293764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KVGyvE39KnGfLXEy5PIKWeBTPQoSdrPXIYsodSUKstQ=;
        b=BAalLqA7YXVFSvQKAL1iaNUHpUYx5bEDnAHFsWrkxn/Leo6PslGmZ7Gekj3CgImfai
         1w8BjL1TNxxkwcFwu1DbpHFPyyH8OGO4DF6lpp8qcq6y5j0fBRK8i+dkCRYgRiww3iry
         A5ENmO6WCLCYqp8xTft+pm3FhKnuKCS+BoCsr0OTdEPFjrWORD0bDhOhXOijaR8zsmhb
         KIiWqNLZmx0JdgHMmBLa3ehglvFRxA1+12rqIIHFURCaxdiTU4WFrnPMIkCyKMxufg8A
         dc3OHMJx999u8pzh72efJvYFTW9AG/oCC/lx5qGFhswuXCHVYnpnF2j3shD76B0Ziwc1
         3OIw==
X-Gm-Message-State: AAQBX9coxMd24TMHsQ9f1USuTr9t2/NjVz4mzXl4M0lueGKAuFvJLf+p
	4f12Z8hgbqxZCJGWmUiwSA20S6r7gfFs7EVmb5GNEgy+4rLqXQxJ5MnZ0wrPOPBr2esLSdA6qmO
	oF/l23PZwUgg5nAmERVBpm+lTH7oJmeuR5hKakuiWkmvq
X-Received: by 2002:a9d:7b48:0:b0:6a5:ed61:5823 with SMTP id f8-20020a9d7b48000000b006a5ed615823mr117544oto.2.1681701764374;
        Sun, 16 Apr 2023 20:22:44 -0700 (PDT)
X-Google-Smtp-Source: AKy350a7AP1CpZR9rqlb00RzDqfXoJdj9/Fe3LZWadyVqZQlRcIkBlEaKBBUkSpyYtwRbuIb9LST4wOkwc7Go+BwlXo=
X-Received: by 2002:a9d:7b48:0:b0:6a5:ed61:5823 with SMTP id
 f8-20020a9d7b48000000b006a5ed615823mr117536oto.2.1681701764101; Sun, 16 Apr
 2023 20:22:44 -0700 (PDT)
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
 <CACGkMEsHtC99kTTa0TrfeJuhV+F7e-WF7XRgbLJkCBQeAxW8pA@mail.gmail.com> <PH0PR12MB5481C29561D5E48BA5D8AEEEDC999@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB5481C29561D5E48BA5D8AEEEDC999@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 17 Apr 2023 11:22:33 +0800
Message-ID: <CACGkMEseO=4xDA+pH2x=CaJ6XyzHEx1ZFO-+uevJH50kLeSWhA@mail.gmail.com>
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

On Fri, Apr 14, 2023 at 11:51=E2=80=AFAM Parav Pandit <parav@nvidia.com> wr=
ote:
>
>
>
> > From: Jason Wang <jasowang@redhat.com>
> > Sent: Thursday, April 13, 2023 11:38 PM
>
> > > > 1) spec doesn't enforce the size of a specific structure
> > > Spec will be extended in coming time.
> >
> > It's too late to do any new restriction without introducing a flag.
> We are really diverging from the topic.
> I don=E2=80=99t think it is late. The work in this area of PCI VF has not=
 even begun fully.

I meant it needs a new feature flag.

>
> > Mandating size may easily end up with a architecte specific solution.
> >
> Unlikely. Other standard device types are also expanding this way.

I think we are talking about software technologies instead of device
design here.

For devices it works.But for hypervisor, it needs to deal with the
size that doesn't match arch's page size.

>
> > >
> > > > 2) bing vendor locked thus a blocker for live migration as it
> > > > mandate the layout for the guest, mediation layer is a must in this
> > > > case to maintain cross vendor compatibility
> > > >
> > > With PCI VF will have compatibility check and also vendor recommendat=
ions.
> >
> > I'm not sure what type of recommendations you want.
> >
> > We've already had:
> >
> > 1) features
> > 2) config
> >
> Those cover the large part.

I meant you can't have recommendations in features and config. What's
more, assuming you have two generations of device

gen1: features x,y
gen2: features x,y,z

You won't be able to do migration between gen1 and gen2 without
mediation. Such technologies have been used by cpu features for years.
I am not sure why it became a problem for you.

> Apart from it some of the PCI device layout compat checks will be covered=
 too.
>
> > And what you proposed is to allow the management to know the exact
> > hardware layout in order to check the compatibility? And the management
> > needs to evolve as new structures are added.
> Mostly not mgmt stack may not need to evolve a lot.
> Because most layouts should be growing within the device context and not =
at the PCI capabilities etc area.
>
> And even if it does, its fine as large part of it standard PCI spec defin=
itions.

So as mentioned in another thread, this is a PCI specific solution:

1) feature and config are basic virtio facility
2) capability is not but specific to PCI transport

Checking PCI capability layout in the virtio management is a layer
violation which can't work for future transport like SIOV or adminq.
Management should only see virtio device otherwise the solution
becomes transport specific.

>
> > This complicates the work of
> > management's furtherly which I'm not sure it can work.
> >
> Well, once we work towards it, it can work. :)
>
> > >
> > > > Hypervisor needs to start from a mediation method and do BAR
> > > > assignment only when possible.
> > > >
> > > Not necessarily.
> > >
> > > > > Cons:
> > > > > a. More AQ commands work in sw
> > > >
> > > > Note that this needs to be done on top of the transport virtqueue.
> > > > And we need to carefully design the command sets since they could b=
e
> > > > mutually exclusive.
> > > >
> > > Not sure what more to expect out of transport virtqueue compared to A=
Q.
> > > I didn=E2=80=99t follow, which part could be mutually exclusive?
> >
> > Transport VQ allows a modern device to be transported via adminq.
> >
> May be for devices it can work. Hypervisor mediation with CC on horizon f=
or new capabilities is being reduced.
> So we don=E2=80=99t see transport vq may not be path forward.
>
> > And you want to add commands to transport for legacy devices.
> >
> Yes only legacy emulation who do not care about hypervisor mediation.
>
> > Can a driver use both the modern transport commands as well as the lega=
cy
> > transport commands?
> Hard to answer, I likely do not understand as driver namespace is unclear=
.

Things might be simplified if we use separate queues for admin,
transport and legacy.

> Let me try.
>
> A modern driver in guest VM accessing a transitional device has its own t=
ransport vq for say config space RW.
> This transport queue can directly reach to the device without hypervisor =
mediation, - yes.
> Same device if accessed via some legacy guest VM driver, it will gets its=
 config space accessed via transport VQ (AVQ) of the hypervisor PF AQ.

Not only the config space, but we can revisit those issues when we
agree to use adminq (or other like PASID which is even more flexible).

Thanks


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

