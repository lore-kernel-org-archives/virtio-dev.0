Return-Path: <virtio-dev-return-12641-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97A33C7EE22
	for <virtio-dev@archiver.kernel.org>; Thu, 11 May 2023 07:07:05 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id F3FD5FD56F
	for <virtio-dev@archiver.kernel.org>; Thu, 11 May 2023 07:07:04 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E0F369865F9
	for <virtio-dev@archiver.kernel.org>; Thu, 11 May 2023 07:07:04 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id D3899983E4E; Thu, 11 May 2023 07:07:04 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C277C9865CE
	for <virtio-dev@lists.oasis-open.org>; Thu, 11 May 2023 07:07:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: yr5_sZgmM3ODmGaMTImtcw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683788820; x=1686380820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I/QHV4xMwXOY5GO8la2DP1z397Icl64TKKtqQX0jhRw=;
        b=SbKAjNv96NjDDtqJpLTvYT+Bsue+lFAGg7nik/XqsjGY2VCeDvXJ5R8YoENzNTuLiI
         WyuTevXrYLTYeF1b2iQXLG1gxmLUkXT2EXtr+6NKT4Izshl9s4lOTZ6euXozoXPuwQ5L
         Li/cwIrTwenaaSUBb+ufEQtGDTPEoCfOyu2DK+N0JPoxESXbHAactZVcbZ5PZtO2i4zs
         LA3Xg4T4ic6Cs6ucia/vN9WhpO4Fm67JdCQ39lB2EbAGPOTkIJqwa0P2uaES0HYAhY/O
         ID9nLwvSQ3zL0WSNCLmxJe7bWn2aM9RXx+RuBnSbcBfEQ3fa5oCnCRInMZnjTG36sLIg
         Piqw==
X-Gm-Message-State: AC+VfDxz5OymzBz35i1pKmg8dzMaDiuRTXiMxeY2dR1Kx9RjeU2HddD5
	t1NPnrZYE/KZKyRF9CIVZgHK74Kd695P8jJ1a9gR6cPbkuRHFrV2wjbfR2jO/nCNW8Yny/Y6Xkb
	BgvChCeC1JHOIE2PdZv3fFvDZEOJ8fb+eyAYJoUwsDI20
X-Received: by 2002:ac2:51d1:0:b0:4f1:45aa:d419 with SMTP id u17-20020ac251d1000000b004f145aad419mr2396786lfm.58.1683788820202;
        Thu, 11 May 2023 00:07:00 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5h5XWoBOBB4uKgNzo/hV3vste/0HWjnvqEbg9mzV8MbcX3jyLHdSwwD9hUoQuoHR/aI4rlN2k4kMgus7VCkAQ=
X-Received: by 2002:ac2:51d1:0:b0:4f1:45aa:d419 with SMTP id
 u17-20020ac251d1000000b004f145aad419mr2396776lfm.58.1683788819869; Thu, 11
 May 2023 00:06:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230506000135.628899-1-parav@nvidia.com> <CACGkMEt_2B68a+BZ4-vfeDf_eYj5ZhxrDNd6dxuiF85qr0yN2g@mail.gmail.com>
 <20230507093959-mutt-send-email-mst@kernel.org> <CACGkMEtfMbcu2OPsH6P2tA1aHh2FKygv=xkJ-e1XQzb62nE1vQ@mail.gmail.com>
 <20230510014534-mutt-send-email-mst@kernel.org> <43ec1c8d-7d11-2400-3649-1fe366b1e21b@nvidia.com>
 <20230510121417-mutt-send-email-mst@kernel.org> <PH0PR12MB5481F030A76141320F03956EDC779@PH0PR12MB5481.namprd12.prod.outlook.com>
 <PH0PR12MB5481CEB307F413E53B03D502DC779@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB5481CEB307F413E53B03D502DC779@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 11 May 2023 15:06:48 +0800
Message-ID: <CACGkMEtm5AS50YmPi6A5=gzZZ9Jm55NEJ3GKOTzv-Z0m5E5J_w@mail.gmail.com>
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
Subject: [virtio-dev] Re: [PATCH v2 0/2] transport-pci: Introduce legacy registers access
 using AQ

On Thu, May 11, 2023 at 5:08=E2=80=AFAM Parav Pandit <parav@nvidia.com> wro=
te:
>
> Hi Jason, Michel,
>
> > From: virtio-comment@lists.oasis-open.org <virtio-comment@lists.oasis-
> > open.org> On Behalf Of Parav Pandit
> > Sent: Wednesday, May 10, 2023 1:34 PM
> >
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: Wednesday, May 10, 2023 12:16 PM
> > >
> > > On Wed, May 10, 2023 at 12:11:50PM -0400, Parav Pandit wrote:
> > > >
> > > >
> > > > On 5/10/2023 2:04 AM, Michael S. Tsirkin wrote:
> > > > > On Mon, May 08, 2023 at 10:23:39AM +0800, Jason Wang wrote:
> > > > > > > I thought so too originally. Unfortunately I now think that
> > > > > > > no, legacy is not going to be a byproduct of transport
> > > > > > > virtqueue for modern - it is different enough that it needs d=
edicated
> > commands.
> > > > > >
> > > > > > If you mean the transport virtqueue, I think some dedicated
> > > > > > commands for legacy are needed. Then it would be a transport
> > > > > > that supports transitional devices. It would be much better tha=
n
> > > > > > having commands for a partial transport like this patch did.
> > > > >
> > > > > OK I am beginning to get what you are saying.  So your criticism
> > > > > is
> > > > > this: what if device supports vq transport for modern, and we wan=
t
> > > > > to build a transitional device on top.  how will that look. yes?
> > > > > A reasonable thing to include at least in the commit log. Parav?
> > > > >
> > > > I am still trying to understand what is "vq transport for modern"?
> > > > Do you mean transporting currently defined config space access over=
 vq?
> > > > If so, is this VQ belong to the guest or hypervisor?
> > >
> > > https://lore.kernel.org/all/20220826100034.200432-2-
> > > lingshan.zhu%40intel.com/t.mbox.gz
> >
> > The gz link is not accessible.
> > But I got the right link [1].
> >
> > [1] https://lore.kernel.org/all/20220826100034.200432-2-
> > lingshan.zhu@intel.com/
> >
> > 1. Above patch cover letter [1] is missing the basic objective/problem
> > statement.
> > i.e. why a transport virtqueue is needed?
> > But I probably get the idea of [1] as we did the AQ.
> >
> > 2. Commit log says about
> > a. querying resource of management device (aka group owner in AQ now) b=
.
> > creating and destroying the managed device  (aka group owner creating g=
roup
> > member devices) c. configure the managed device (aka group owner
> > configuring/composing group member devices such as VFs, SFs, SIOV).
> >
> > So, all above 2.a to 2.c belongs to the admin group owner and group
> > management commands like how it is defined in the AQ proposal.

Yes, the plan is to rebase on top of AQ. Lingshan may add more details here=
.

> >
> > So, 3 out of the 4 motivations are achieved by AQ proposal.
> > This AQ belongs to the hypervisor. I am clear on this part.
> >
> > 4th point in cover letter is: "config virtqueues of the managed device"=
.
> >
> > This work belongs to the driver -> device direct communication using a =
queue
> > from driver to device.
> > So, I imagine this work can be done using a queue by the guest driver a=
nd
> > serviced by the device like how a guest driver configures the queue tod=
ay
> > without any mediation.
> > For PCI, MMIO transport, surely this can be done by the PCI device dire=
ctly
> > being is PF, VF or SIOV.
> > (Instead of config register, using a new queue interface). Looks fine t=
o me.

Great.

> >
> > Can this new cfg queue mediated like CVQ that is done in a sw? May be y=
es.
> > Should it be always mediated when it is of VF, SIOV Device? Mostly no b=
ecause
> > it is yet another VQ for PF, VF, SIOV.

Yes, the mediation is always conditional but not mandated when doing the de=
sign.

> >
> > I am yet to parse rest of the 4 patches, please give me some time to re=
view it.
>
> I went over the past work of [1], [2].
>
> [1] https://lore.kernel.org/all/20220826100034.200432-2-lingshan.zhu@inte=
l.com/
> [2] https://lists.oasis-open.org/archives/virtio-comment/202208/msg00141.=
html
>
> The "virtio q as transport" in [2] is bit misleading as its only role is =
to transport the _registers_ of the SIOV_R1 device through its parent PF.
> Rest of the work is the pure management work to manage the life cycle of =
SIOV devices (create/delete/configure/compose).

I think this can be tweaked for static provisioning setups like
SR-IOV. E.g group owner can choose to not advertise the life cycle
management commands. Then the hypervisor may know the provisioning is
transport specific.

>
> And the motivation is also clear is to provide composing a virtio device =
for the guest VM for the backward compatibility for 1.x part of the specifi=
cation.
>
> It seems fine and indeed orthogonal to me that: it is for backward compat=
ibility for already defined config fields for existing guest VM driver.
>
> It does not conflict with the cfgq/cmdq idea whose main purpose is for th=
e new config fields, new use cases that doesn't require any mediation.
> Such cfgq works across PF, VF, SF/SIOV devices in uniform way without med=
iation.

My understanding is that the cfgq/cmdq could be done on top, since the
commands are part of transport unless I miss something.

> It also scales device register memory also very well in predictable way.
>
> The registers and feature bits access described in [2], can certainly be =
done using new non_legacy new AQ commands.
> Both legacy and non-legacy command have different semantics as Michael me=
ntioned.
>
> The AQ semantics that Michael did as opposed to "virtqueue as transport" =
fits well for the use case described in [1].
>
> There are changes on going in MSI-X area and SIOV, so you might want to w=
ait for it.

I think you meant IMS, actually, it's not hard to add new commands to
support a general IMS. We can start from a virtio specific one (as it
looks a common requirement not only for PCI/SIOV but also for
transport like MMIO)

> Or proposed command in [1] should be tagged as siov_r1, then things will =
be cleaner.

Maybe we can say, one of the implementations is siov_r1, since it can
be used to implement devices in other transport. One of the main
motivations for transport virtqueue is to reduce the transport
specific resources to ease the virtio device implementation.

>
> With that I don't see legacy 3 commands anyway conflict with [1].

It doesn't, but it's not elegant since:

1) Modern transport, admin virtqueue with well defined transport commands
2) Legacy transport, works moe like a PCI transport on top of the
admin virtqueue

Transport virtqueue tend to be transport independent, but 2) tie it
somehow to the PCI. That's why I suggest to

1) introduce legacy transport commands

or

2) tweak your proposal to become a PCI over admin virtqueue

> Some commands functionality is common between [1] and this proposal.
> But that's how the legacy is. It is confined to legacy emulation.
> So [1] can be done as follow_on to AQ and these series.
>
> A small note about [2].
> virtio_transportq_ctrl_dev_attribute should be detached from CREATE call =
and split to two commands.
> So that VF and SF/SIOV can both utilize it.
> SF/SIOV_R1 can use the creation and config part.
> VFs will use only the device features + config space.

Good point. This could be fixed.

Thanks

>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

