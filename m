Return-Path: <virtio-dev-return-12622-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F02D1C77B7C
	for <virtio-dev@archiver.kernel.org>; Wed, 10 May 2023 07:01:44 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 29989C6242
	for <virtio-dev@archiver.kernel.org>; Wed, 10 May 2023 07:01:44 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1F2CF9865B0
	for <virtio-dev@archiver.kernel.org>; Wed, 10 May 2023 07:01:44 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 1383798656B; Wed, 10 May 2023 07:01:44 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 009D1983E52
	for <virtio-dev@lists.oasis-open.org>; Wed, 10 May 2023 07:01:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: ghQCt0iJMF-AIM6qzQj_AQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683702097; x=1686294097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gNkf9GMFEg/Zf8EsMon6CvaDyxQRrRDu6vLxmM6Zqsg=;
        b=OjM4WJifK7ZJQVape+GVmIkvQFXnLO1ysxYUkl3lRlQwgZICOD3CSZwCgbqocK02LT
         lnjKxsTgzYybvEzUzpABmiGywvCm1mhHJQiPiWa6GSkLC3Fz/ykCR7v5m7SSm5CfeHgS
         MxvcN4Rw/JtSswYhH3QWAZZVsdPiPZ2oorX/20abqU6RbLvb2ehyv/f7QoOoHDAqtQBS
         RWYfQHu6Ja7ByvAy5FaJoP6apkJg9NaEZCq8ECz/M2dMKNDeLKkdmTinowW1J3XOsrhx
         3JlU+dFb0iIHcH8O2mtK/GmYXOSdWOjmM1zhkuj7yWlc/q3pt2YeI1Yc+luJito7xah9
         gBTQ==
X-Gm-Message-State: AC+VfDyOVppunS3RpKtQq5bnNnKKbaNQ37EnkM3O/XPz/kYz8qiYMqll
	I9wPb5LdQKRds6ymcUNEzFeSsMbBuNPaptF8ZnAbJ182eFnN9NPM6UCtfaFkgYFRLFj6dFll1hC
	ae4mzjbPH+37XdHPnk/9Zv8RP3LT70fcCruv0FVyMPnbe
X-Received: by 2002:a2e:979a:0:b0:2ab:6e23:ef71 with SMTP id y26-20020a2e979a000000b002ab6e23ef71mr1704683lji.37.1683702097232;
        Wed, 10 May 2023 00:01:37 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5NkuDPWhriGGKRibBob/zEChSSbiFBPh/iJb+aAmvpXuM0u5R+VpTjAZsG83vFWpTafl1DcNXZTab6MOoGSk8=
X-Received: by 2002:a2e:979a:0:b0:2ab:6e23:ef71 with SMTP id
 y26-20020a2e979a000000b002ab6e23ef71mr1704670lji.37.1683702096914; Wed, 10
 May 2023 00:01:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230506000135.628899-1-parav@nvidia.com> <CACGkMEt_2B68a+BZ4-vfeDf_eYj5ZhxrDNd6dxuiF85qr0yN2g@mail.gmail.com>
 <20230507093959-mutt-send-email-mst@kernel.org> <CACGkMEtfMbcu2OPsH6P2tA1aHh2FKygv=xkJ-e1XQzb62nE1vQ@mail.gmail.com>
 <20230510014534-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230510014534-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 10 May 2023 15:01:25 +0800
Message-ID: <CACGkMEvTs9oMewgrQpYZu1v1wdUXtxsvjqB6CPRf+y4C8EN_KQ@mail.gmail.com>
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

On Wed, May 10, 2023 at 2:05=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Mon, May 08, 2023 at 10:23:39AM +0800, Jason Wang wrote:
> > > I thought so too originally. Unfortunately I now think that no, legac=
y is not
> > > going to be a byproduct of transport virtqueue for modern -
> > > it is different enough that it needs dedicated commands.
> >
> > If you mean the transport virtqueue, I think some dedicated commands
> > for legacy are needed. Then it would be a transport that supports
> > transitional devices. It would be much better than having commands for
> > a partial transport like this patch did.
>
> OK I am beginning to get what you are saying.  So your criticism is
> this: what if device supports vq transport for modern, and we want to
> build a transitional device on top.  how will that look. yes?

Yes. I think it needs to be done through the transport virtqueue
otherwise the transport is not self-contained.

> A reasonable thing to include at least in the commit log. Parav?
>
> You are also asking what if the device uses transport vq,
> and we want transitional on top of that.
> It's a fair question but I don't exactly get why would
> this legacy support feature be wanted for the vq transport
> and not for other transports.

Not sure I get the question, but all the existing transport support
legacy, if we want to have another, should the legacy support be a
must or not?

>
>
>
>
> > > Consider simplest case, multibyte fields. Legacy needs multibyte writ=
e,
> > > modern does not even need multibyte read.
> >
> > I'm not sure I will get here,
>
> What does this mean?

I meant I don't get what the issue if "modern does not even need
multibyte read".

>
> > since we can't expose admin vq to
> > guests, it means we need some software mediation. So if we just
> > implement what PCI allows us, then everything would be fine (even if
> > some method is not used).
> >
> > Thanks
>
> To repeat discussion on one of the previous versions, no it will not be
> fine because legacy virtio abuses pci in fundamentally broken ways.
> So yes you need a mediator on the host but even giving this
> mediator a chance to be robust on top of hardware
> means the hardware interface can not simply mirror legacy
> to hardware.
>
> For example, host mediator needs to trap writes into mac,
> buffer them and then send a 6 byte write.
> Now, pci actually does allow 6 byte writes, but legacy
> guests instead to 6 single byte writes for portability reasons.

It's a known race condition, so PCI over adminq doesn't make it worse.
The mediator can just mirror what guests write over the admin
commands.

Thanks

> --
> MSr
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

