Return-Path: <virtio-dev-return-12797-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29033C7EE29
	for <virtio-dev@archiver.kernel.org>; Wed, 24 May 2023 01:17:57 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 419472B00F
	for <virtio-dev@archiver.kernel.org>; Wed, 24 May 2023 01:17:57 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 23980986408
	for <virtio-dev@archiver.kernel.org>; Wed, 24 May 2023 01:17:57 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 0FE6198628B; Wed, 24 May 2023 01:17:57 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EEBC69863FB
	for <virtio-dev@lists.oasis-open.org>; Wed, 24 May 2023 01:17:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: oCoqdDnnN1WxqQVBAwe27g-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684891073; x=1687483073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JjJsVAZoakMcwKYxQPVQcRdcijUC0/csYa39GfPgSK0=;
        b=ch+HyNGZOk7EJbX8jVjI93jde4n/GvxydrcVGn4DbdHjqyY29RYQwDtaMq1F+c9VMx
         7omiETvDF/23C/u8A+eOpj5HW7y/Zpbd6IPNCaE6wOS2vohCzIssoP534zFSnEqIxqY8
         mpubMdz8O54GtpCI/1qVLu99Arm8QN5s0qIiCKPunBL1ahIeL3rWAyzPe59rB2z/qMVJ
         tSjoSEHgLZ67S8eukTjMBPze5siaJyjQFkY0z1mJxtpBlVrtetV6bWmB9tvRjt/KoD+W
         bw9Lk9M5T+YPNGPtlR7OU+2P4MxjV9jpuQnY2yhePfmt2VUTZ1bdSHZwXCpaQZRjjiXg
         HYQQ==
X-Gm-Message-State: AC+VfDw5CVnthYPPZ477TOO6tZ41tyGz3EwoqLFyRskFNi11OFozyAtk
	iKOAsuUZaXfftXkQeb5p50phgcoLZ8vR5G3r8a976x1wxupdy/MHTm/JR3yB1IGsXOTnyQo+r7u
	Qj5Y6bQlxalZi9FtRtMBxCltKijCJE6AD4tUwyLsQ9CUr
X-Received: by 2002:a2e:b165:0:b0:2ac:87f6:7b4a with SMTP id a5-20020a2eb165000000b002ac87f67b4amr5527818ljm.2.1684891073032;
        Tue, 23 May 2023 18:17:53 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7aFXC7fPhpR/CI4xPY31T02r9muE2FE/0oRKOFSRL1xfS8YCoi5Z3HCN4wyj1/L28O+a+NI9aJ7qLj/+wToXU=
X-Received: by 2002:a2e:b165:0:b0:2ac:87f6:7b4a with SMTP id
 a5-20020a2eb165000000b002ac87f67b4amr5527816ljm.2.1684891072718; Tue, 23 May
 2023 18:17:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230519015520-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481AABA8A22DC088B5D7CFDDC7C9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230521050829-mutt-send-email-mst@kernel.org> <PH0PR12MB548161A2D28C387C9AF23B81DC429@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230521102050-mutt-send-email-mst@kernel.org> <PH0PR12MB54815D83C3287FE7B3A2947CDC429@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230522154149-mutt-send-email-mst@kernel.org> <PH0PR12MB5481A2AD326E7F0A7CEFC223DC439@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230522170700-mutt-send-email-mst@kernel.org> <PH0PR12MB54818BD5421AC200C2DEEDCFDC409@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230523141718-mutt-send-email-mst@kernel.org> <PH0PR12MB548124A538CE4CCCE76F068FDC409@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB548124A538CE4CCCE76F068FDC409@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 24 May 2023 09:17:41 +0800
Message-ID: <CACGkMEuixsBibSq_pEQvcKOH0WBQWnta4Q2c28SV8qTS8gaVcA@mail.gmail.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>, 
	"david.edmondson@oracle.com" <david.edmondson@oracle.com>, "sburla@marvell.com" <sburla@marvell.com>, 
	Yishai Hadas <yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>, 
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [virtio-comment] RE: [PATCH v2 1/2] transport-pci: Introduce
 legacy registers access commands

Hi Parav:

On Wed, May 24, 2023 at 6:22=E2=80=AFAM Parav Pandit <parav@nvidia.com> wro=
te:
>
>
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Tuesday, May 23, 2023 2:49 PM
> > > > iokit is from my previous work experience not virtio.
> > > > For virtio we had a lot of trouble with hacks like this on windows.
> > > I don't know why windows driver need to talk to PF driver until now w=
hen the
> > AQ doesn't exists.
> >
> > What is it you want to know?
> >
> Why a VF driver needs to talk to a PF driver in windows without AQ?
>
> > > > That's an important platform.
> > > >
> > > I am not sure how important is it.
> > > What I learnt that a decade has passed and even after that virtio dri=
vers are
> > not part of the OS distro.
> >
> > Because with QEMU they are so easy to side-load. So we never bothered.
> >
> I don't understand your comment.
> I was saying to my knowledge a Windows OS do not have a virtio drivers in=
 their distro which you said is important.
>
> > > It doesn't need to because guest is anyway going to do whatever it do=
es.
> >
> > yes. But hypervisor can do work-arounds or detect broken functionality =
and
> > stop cleanly.
> >
> You mentioned this several times.
> Below requirement still holds fine.
>
> > > The clear requirement is: to not fix legacy but to support legacy.
> > > Fixing legacy is role of 1.x. Not the role of legacy interface itself=
 using
> > AQ/MMIO.
> >
>  > And for purpose of BAR mapping, such BAR in the VF can be mapped too.
> > > You didn't answer why VF BAR is a problem and suggest PF BAR.
> >
> > VF BAR by itself is not a problem. Discovering VF BAR mapping offset th=
rough PF
> > is.
> >
> At the end of the email you right that "AQ is fine" but here you write di=
scovering that through the PF AQ is.
> How to interpret your comment?
>
> > > If notification for VF is in VF -> hence other config registers also =
in VF, such
> > blanket statements does not help.
> >
> > not other config registers. what's needed in VF driver should be retrie=
vable
> > through VF.
> >
> This applies to the modern device, for legacy emulation, I don't see this=
 a mandatory.
>
> > > Your comments and suggestions are helpful.
> > > Some of them follow the loop that doesn't help.
> > > Again, thanks a lot for the inputs and reviews.
> > >
> > > The design discussion helped to produce two solutions here than what =
was
> > started in v0.
> >
> > OK good. Now I suggest you make an effort to come up with some compromi=
se
> > that will make this thread stop. I really can't say I even remember wha=
t we said
> > in the beginning.
>
> > You had this idea of starting with a problem statement document how abo=
ut
> > doing that? Because I feel every time people bring up some idea and a p=
roblem
> > this idea would solve, you go "this is out of scope". Let's decide what=
 the scope
> > is?
> >
> The requirements are simple and straightforward at start of the cover let=
ter.
> i.e. for quick reference in short: A PCI VF passthrough to guest VM to su=
pport legacy + 1.x.
>
> I propose:
> Method-1:
> 1. VF legacy registers access over AQ of PF
> 2. VF driver notifications using MMIO of VF
>
> Method-2:
> 1. legacy registers access using two MMIO registers (data and addr)
> 2. VF driver notifications using MMIO of VF
>

Based on your above summary (and a more detailed one in another
thread), it's not hard to see the tricky part is the try to
provide/mediate modern features for legacy. Assuming we all agree:

1) We want transitional devices but not legacy only devices
2) Mediation is a must for legacy

Then finding a way to reuse a modern interface is much better than
building a new path back to the old legacy maze. I really think we
should go with a way to meditate on top of a modern device. This
probably requires some new feature bit(s) like
VIRTIO_NET_F_LEGACY_HEADER but it has the lowest cost.

1) no new hardware interface like registers/capabilities etc
2) no datapath meditation, hypervisor will negotiate
VIRTIO_NET_F_LEGACY_HEADER for legacy guest drivers
3) endian is fine, hypervisor know it's modern so it's little
4) reset is fine, hypervisor know it's modern so it can do proper meditatio=
n
5) notification is fine, hypervisor know it's modern so it can use
modern notification areas
6) all the behaviour is deterministic, no undocumented or code defined
legacy behaviours

Anything that prevents you from adding things like VIRTIO_NET_F_LEGACY_HEAD=
ER?

You wrote the following in v1:

"""
There is virtio PCI VF.
The user who attaches this VF to the VM, it doesn=E2=80=99t know if its gue=
st
is to run legacy driver or 1.x
Hence hypervisor doesn=E2=80=99t want to run special stack when guest may
(likely) be 1.x and device also supports 1.x.
"""

I don't understand this actually. For "special stack", are you
referring to the mediation path for legacy? I don't see how
VIRTIO_NET_F_LEGACY_HEADER differs from new hardware interfaces like
admin virtqueue in this regard. If management stack wants a
transitional device, Hypervisor just need

1) for modern BAR, assign it directly to the VM if it wishes, no
mediation at all
2) for legacy BAR, trap and mediate

The only difference happens in 2), that is which kind of interfaces
should we go, existing modern or new legacy like admin virtqueue.

Or as Michael said, it would be better to explain how the hypervisor
expects to work may help.

Thanks


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

