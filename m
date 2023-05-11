Return-Path: <virtio-dev-return-12642-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9B07C77B7F
	for <virtio-dev@archiver.kernel.org>; Thu, 11 May 2023 07:17:20 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id CEB561462D4
	for <virtio-dev@archiver.kernel.org>; Thu, 11 May 2023 07:17:19 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A5D489865F9
	for <virtio-dev@archiver.kernel.org>; Thu, 11 May 2023 07:17:19 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 85D96983E4E; Thu, 11 May 2023 07:17:19 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 72C919865CF
	for <virtio-dev@lists.oasis-open.org>; Thu, 11 May 2023 07:17:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: gCrN8AYoPN-z32WB9QUWMQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683789435; x=1686381435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1MXUewrml6JW8tlcesM4+bkL5sxPvMv0l4QzwQ3v8l0=;
        b=KotNq5rMILMl4VLtZ1yd0olf4Gu4NusdnWmOjpqdcwmP3xEG0KKPlwOmmBcKvxJyfH
         KXDMC65RT4sx5JTq3P1YqUSoY8Ka6/MYGT32Aq/y9osnz98KBDJJxlEtwpD6Z07hU+4S
         TMx2AqVa55lE33s/z5Gs/T59u4EBOionuT7gYy4JwcG/6oglAkXDSL0h7k5IvcD2/bl5
         4JmTHNOy9N7cQdpbi5Tla/zrl8lTWifomuH2cVIif17xYCzlpckxwjb58/L0y4mBCs8h
         StqLgRgygIvJRR3ZZEUhceAzY6j1yYODcXIxTaqLpWgPpeiLobjhNQZcDWTuLmbTZ9Uf
         YXxw==
X-Gm-Message-State: AC+VfDzwRb700gXMjHEh24KCNpSlq/jH9P4NGSp1qCpDgE9IdsaGDY4g
	fmPeT4cgLgttx9Xrb40YQw5NVPGWu+QW73FFCzgWoB+g1gytBRxSDSAQ7Ue4wWnhfORMzSPEk5y
	k2kXOl7OTEX6C9N9XLLiznW/4G9wNqCe3mMrCmg0Ag9FW
X-Received: by 2002:ac2:5d2d:0:b0:4e9:bf83:11a4 with SMTP id i13-20020ac25d2d000000b004e9bf8311a4mr2242792lfb.7.1683789435627;
        Thu, 11 May 2023 00:17:15 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7o3OhXy630NpjEseCh+xu1z+hQOhj03WMVOqRmGv5yClnd2aiVEcYf1dDUvW+TKkzYWQxF0Dsu1oF2IAorox4=
X-Received: by 2002:ac2:5d2d:0:b0:4e9:bf83:11a4 with SMTP id
 i13-20020ac25d2d000000b004e9bf8311a4mr2242777lfb.7.1683789435286; Thu, 11 May
 2023 00:17:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230506000135.628899-1-parav@nvidia.com> <CACGkMEt_2B68a+BZ4-vfeDf_eYj5ZhxrDNd6dxuiF85qr0yN2g@mail.gmail.com>
 <20230507093959-mutt-send-email-mst@kernel.org> <CACGkMEtfMbcu2OPsH6P2tA1aHh2FKygv=xkJ-e1XQzb62nE1vQ@mail.gmail.com>
 <b33fe999-8491-30b4-5021-589a2fe87398@nvidia.com> <CACGkMEsSJVG8mzuo3BH1xQzz5TyNbO+o3GcYwoXchcYVOczTTg@mail.gmail.com>
 <PH0PR12MB5481AC52CCAE9636E17C7565DC769@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEu1oU0wzygicS0bApoWuRaWkWsPivKRiq-ghezB=hg+Fw@mail.gmail.com> <d79a83db-46eb-7f7e-da8e-f39b58b1bc0f@nvidia.com>
In-Reply-To: <d79a83db-46eb-7f7e-da8e-f39b58b1bc0f@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 11 May 2023 15:17:03 +0800
Message-ID: <CACGkMEsR1bJGWjn7TTrvMZV3=fCqggWXjXRXK179YiTUxVTc6g@mail.gmail.com>
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

On Thu, May 11, 2023 at 12:04=E2=80=AFAM Parav Pandit <parav@nvidia.com> wr=
ote:
>
>
>
> On 5/9/2023 11:51 PM, Jason Wang wrote:
> > On Tue, May 9, 2023 at 11:56=E2=80=AFAM Parav Pandit <parav@nvidia.com>=
 wrote:
> >>
> >> SIOV does not require mediation.
> >> Composition is optional like VFs.
> >
> > This is not what I read from SIOV spec.
> >
> SIOV R1 spec was defined by _a_ vendor and it is undergoing upgrade to
> more practical use now. So we should let them finish the work.
>

That's fine.

> It is hard to comment in this forum about it.

Yes.

>
> >>
> >>>>
> >>>> Hence, the transport we built is to consider this in mind for the
> >>>> coming future.
> >>>
> >>> For transport virtqueue, it's not specific to PCI. It could be used i=
n a much
> >>> broader use case.
> >>>
> >> May be.
> >> More below.
> >>
> >>>> So if each VF has its own configq, or cmdq, it totally make sense to
> >>>> me which is bootstrap interface to transport existing config space i=
nterface.
> >>>> The problem is: it is not backward compatible; Hence a device has no
> >>>> way of when to support both or only new configq.
> >>>
> >>> Providing compatibility in software is much more simpler than inventi=
ng new
> >>> hardware interfaces. Isn't it? (e.g if we want to provide compatibili=
ty for VF on
> >>> a SIOV device). And inventing a new hardware interface for compatibil=
ity might
> >>> not always work, it may break the advantages of the new hardware (lik=
e
> >>> scalability).
> >>>
> >> What I proposed below is new hardware interface for new features.
> >> Not for compatibility.
> >
> > I'm confused, the proposal is for legacy drives so it's for
> > compatibility for sure. No?
> This proposal is to get legacy devices to work over a PCI VF.
>
> a configq/cmdq discussion is for new features for PF, VF, and SF/SIOV
> devices to work in _non_ backward compatible way,
> because for new
> features there is no such thing as backward compatibility between guest
> driver and the device.

Ok, so what command did configq/cmdq have? I thought it was similar to
transport virtqueue, but it looks more like a control virtqueue here.

>
> >
> >> Compatibility is coming at a cost which is not scaling.
> >> If you attempt to scale, it breaks the future path forward to go witho=
ut mediation.
> >>
> >>>>
> >>>> So eve growing these fields and optionally placement on configq
> >>>> doesn't really help and device builder to build it efficiently
> >>>> (without much predictability).
> >>>
> >>> Config queue is not the only choice, we have a lot of other choices (=
for example
> >>> PASID may help to reduce the on-chip resources).
> >>>
> >> PASID is for process isolation security construct, it is not for trans=
portation.
> >
> > I meant with PASID you don't even need a BAR.
> >
> Not sure I fully understand, but my guess is, this is coming from
> mediation thought process.

Not actually. I meant, for example without PASID, for modern devices,
the common cfg structure must be placed on a BAR through MMIO.

But with the help of PASID, it could stay in the memory and the device
can fetch it via DMA. The help to reduce the resources for registers.

>
> >> Same, SIOV and VFs do not prefer mediation going forward in the use ca=
ses we come across.
> >
> > Unless you don't want to provide VF compatibility for SIOV.
> I do not understand what compatibility is this between which two elements=
?
> VF has its identify currently and SIOV will have its own identity in futu=
re.

Ok, so it really depends on how to implement the transport for SIOV. I
guess it won't use registers/BAR any more. If this is true, if we want
to run a virtio-pci driver, it needs some mediation.

It works like what you proposed here. Someday, SR-IOV or BAR transport
will become "legacy", but we need a way to make the "legacy virtio-pci
driver" work.

>
> >>>
> >>> Just to be sure we're on the same page. The proposal of both you and =
mine are
> >>> based on the adminq for PF not VF. The reason is obvious:
> >>> adminq per VF won't work without PASID, since it would have security =
issues.
> >>>
> >> The current proposal for legacy should be seen as separate and not to =
intermix with per VF based configuration queue.
> >>
> >> adminvq/config/control vq per VF and SIOV both devices will work witho=
ut PASID (unrelated to legacy).
> >> Because they are like any other queue, such as txq, rxq, cvq. All of t=
hese queues are non-mediated today for PF, VF devices.
> >> (And so additional configq follows the natural model for config space =
access).
> >
> > This is only true if:
> >
> > 1) you don't want to provide any backward compatibility for current
> > PCI transport,
> There is no concept of backward compatibility for new features.
> There will be new driver anyway in the guest.
>
> yes, I don't see a point in mediating 1.x config space for existing
> drivers as it is requires mediation.
>
> > this means you need to use new drivers in the guest
> > 2) you don't want to do live migration
> >
> Not sure how you assert this.
>
> Live migration at VF level for the passthrough device can be just fine
> without any mediation as long as all the parameters on src and dst side
> match.
> We already discussed in v0, so I prefer to avoid this again and focus on
> the patch in discussion.

I agree we are far from the topic of legacy support. But my point
stands still. We can discuss when live migration patches were posted
by somebody.

>
> > If you need one of the above, PASID is a must.
>
> A PCI VF passthrough device LM without mediation is achievable without
> PASID for all the existing defined features using config space.
>
> and also possible when new features are communicated over configq/cmdq.
>
> Transporting existing config space using some additional queue is _not_
> the objective, because building a scalable system where device has zero
> knowledge about needed backward compatibility is hard.
> I provided the example of 100 Vfs with 30 and (30+40) bytes config
> layout previously.
>
> Yet we are repeating and diverging from the discussion, that we should
> not intermix:
> 1. How to access legacy registers of the VF

With what you proposed, we don't even need legacy registers for VF. We
just need to keep its semantic via the admin virtqueue commands.

> vs
> 2. How to access existing or new configuration of the VF
>
> Because both have very different requirements.
>

Thanks


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

