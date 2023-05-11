Return-Path: <virtio-dev-return-12640-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E5F4C7EE22
	for <virtio-dev@archiver.kernel.org>; Thu, 11 May 2023 07:05:30 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 8283386685
	for <virtio-dev@archiver.kernel.org>; Thu, 11 May 2023 07:05:29 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6ADA49865EB
	for <virtio-dev@archiver.kernel.org>; Thu, 11 May 2023 07:05:29 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 4F23B983E4E; Thu, 11 May 2023 07:05:29 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3FCE99865CE
	for <virtio-dev@lists.oasis-open.org>; Thu, 11 May 2023 07:04:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: woyI-o9vPdqt8f68Cdd6dA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683788692; x=1686380692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jaDamBumYh0TGQgIx3NmVB+sIPTV+eNiFtd4Il2nPM0=;
        b=aHXgY5W/SKmyvNB4R+ZwmIB8JJXn8KCX+Dh+d90f9z+B+e5/Ch74CwZNI0bqAPkErg
         UZBAb5+ofBYpF7zM0A4hWF+cX9MiqJjPe08kX0LtScP6Vzp7zA3DcR6sxg6cythskXIm
         H9aJg1+Bd5aZH4Pri5RQ9VZFT9qNKX+VeXWHMADryiP2gON2Pb9/b5rRRUYi5bY5PkSy
         fC6j05++wy94tD6CZp61cs2zeYynprgE7tqhqukX1qsKi8UgJc4u4TGb3cl4XjgcewVG
         7uWGtnctiHwRG+lB5JwohDfZ6OEqgMNgp2DFJfjHzGm857lvHBNi1FC6Or4RvRQ0o86Z
         a5vQ==
X-Gm-Message-State: AC+VfDw98IZCnUAHIMBaoVFoQNincbTUUEoPX9W3dZh/At1A2iWa0mbz
	7/ZS/m6p54zTeBnuu/hPiV7NcohDBNbM8EVgR3IkUDOQ+WCfsUXbdjPKetpEZIyBRtkkogkNios
	rj8ftjU0GDg2ZVUHz8TxSCss60t5VgHaQlOru71pvNFbC
X-Received: by 2002:ac2:4adc:0:b0:4eb:40d4:e0d2 with SMTP id m28-20020ac24adc000000b004eb40d4e0d2mr2196450lfp.38.1683788692047;
        Thu, 11 May 2023 00:04:52 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7q1dP/0Lalc5IAacQljym+H4oGXop1tbHeoJf2IFXf5xFVAu4ILcJ2cmiuiR2JJ2wYJyzKbTg82uzsH/RFlI4=
X-Received: by 2002:ac2:4adc:0:b0:4eb:40d4:e0d2 with SMTP id
 m28-20020ac24adc000000b004eb40d4e0d2mr2196444lfp.38.1683788691683; Thu, 11
 May 2023 00:04:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230506000135.628899-1-parav@nvidia.com> <CACGkMEt_2B68a+BZ4-vfeDf_eYj5ZhxrDNd6dxuiF85qr0yN2g@mail.gmail.com>
 <20230507093959-mutt-send-email-mst@kernel.org> <CACGkMEtfMbcu2OPsH6P2tA1aHh2FKygv=xkJ-e1XQzb62nE1vQ@mail.gmail.com>
 <20230510014534-mutt-send-email-mst@kernel.org> <CACGkMEvTs9oMewgrQpYZu1v1wdUXtxsvjqB6CPRf+y4C8EN_KQ@mail.gmail.com>
 <20230510033812-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230510033812-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 11 May 2023 15:04:40 +0800
Message-ID: <CACGkMEsp0i7EyyBBp06wJzrVBLNbH7MP_TT-j7b5c_yavgAmqw@mail.gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>, virtio-dev@lists.oasis-open.org, cohuck@redhat.com, 
	david.edmondson@oracle.com, sburla@marvell.com, yishaih@nvidia.com, 
	maorg@nvidia.com, virtio-comment@lists.oasis-open.org, shahafs@nvidia.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [PATCH v2 0/2] transport-pci: Introduce legacy registers access
 using AQ

On Wed, May 10, 2023 at 3:43=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Wed, May 10, 2023 at 03:01:25PM +0800, Jason Wang wrote:
> > On Wed, May 10, 2023 at 2:05=E2=80=AFPM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Mon, May 08, 2023 at 10:23:39AM +0800, Jason Wang wrote:
> > > > > I thought so too originally. Unfortunately I now think that no, l=
egacy is not
> > > > > going to be a byproduct of transport virtqueue for modern -
> > > > > it is different enough that it needs dedicated commands.
> > > >
> > > > If you mean the transport virtqueue, I think some dedicated command=
s
> > > > for legacy are needed. Then it would be a transport that supports
> > > > transitional devices. It would be much better than having commands =
for
> > > > a partial transport like this patch did.
> > >
> > > OK I am beginning to get what you are saying.  So your criticism is
> > > this: what if device supports vq transport for modern, and we want to
> > > build a transitional device on top.  how will that look. yes?
> >
> > Yes. I think it needs to be done through the transport virtqueue
> > otherwise the transport is not self-contained.
>
> I mean, any feature can be done over transport vq.
>
> But there is value in adding legacy commands to an otherwise
> modern device without reworking it completely to
> switch to a different transport.

There's probably no need for a rework since legacy is not complicated.
More below.

>
>
> > > A reasonable thing to include at least in the commit log. Parav?
> > >
> > > You are also asking what if the device uses transport vq,
> > > and we want transitional on top of that.
> > > It's a fair question but I don't exactly get why would
> > > this legacy support feature be wanted for the vq transport
> > > and not for other transports.
> >
> > Not sure I get the question, but all the existing transport support
> > legacy, if we want to have another, should the legacy support be a
> > must or not?
>
> This specific proposal is for tunneling legacy over admin vq.
> It can live alongside a normal modern VF, with hypervisor
> combining these to create a transitional device.

Exactly, but what I meant here is

If we decide to use the admin vq, is there any good reason to tie it
to PCI if we don't want to tunneling PCI over adminq?

Why not simply invent individual commands to access legacy facilities
like commands to access like what transport virtqueue did for modern
device?:

1) device features
2) driver features
3) queue address
4) queue size
5) queue select
6) queue notify
7) device status
8) ISR status
9) config msix
10) queue msix
11) device configuration space

It focuses on the facilities instead of transport specific details
like registers (we don't even need legacy registers in this case), I
gives more deterministic behavior so we don't need to care about the
cross registers read/write.

>
> > >
> > >
> > >
> > >
> > > > > Consider simplest case, multibyte fields. Legacy needs multibyte =
write,
> > > > > modern does not even need multibyte read.
> > > >
> > > > I'm not sure I will get here,
> > >
> > > What does this mean?
> >
> > I meant I don't get what the issue if "modern does not even need
> > multibyte read".
>
> parse error again. reword?

I meant we need two sets of command for legacy and modern. We can
choose not to expose multibyte reads for modern commands.

>
> > >
> > > > since we can't expose admin vq to
> > > > guests, it means we need some software mediation. So if we just
> > > > implement what PCI allows us, then everything would be fine (even i=
f
> > > > some method is not used).
> > > >
> > > > Thanks
> > >
> > > To repeat discussion on one of the previous versions, no it will not =
be
> > > fine because legacy virtio abuses pci in fundamentally broken ways.
> > > So yes you need a mediator on the host but even giving this
> > > mediator a chance to be robust on top of hardware
> > > means the hardware interface can not simply mirror legacy
> > > to hardware.
> > >
> > > For example, host mediator needs to trap writes into mac,
> > > buffer them and then send a 6 byte write.
> > > Now, pci actually does allow 6 byte writes, but legacy
> > > guests instead to 6 single byte writes for portability reasons.
> >
> > It's a known race condition, so PCI over adminq doesn't make it worse.
>
> it can however make it better - you can do a single 6 byte write command.
>

It would be tricky to detect when a legacy guest has finished writing
to the mac.

> > The mediator can just mirror what guests write over the admin
> > commands.
>
> and this "just" just isn't good enough, or we end up with hacks
> in hardware.

Yes but this "issue" exists in this proposal as well.

Thanks

>
> > Thanks
> >
> > > --
> > > MSr
> > >
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

