Return-Path: <virtio-dev-return-12081-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27E89C76196
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Apr 2023 07:17:01 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 3E94F2B021
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Apr 2023 07:17:01 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 16B719863D8
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Apr 2023 07:17:01 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id E6BF49862A5; Mon, 10 Apr 2023 07:17:00 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D4F7D98631E
	for <virtio-dev@lists.oasis-open.org>; Mon, 10 Apr 2023 07:17:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: xLrWdhu0OiS_hmm-yvreOw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681111018; x=1683703018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xCASe/31PQJgcYquO7k8UZlc3OUApt7X6Arw2QuZGaI=;
        b=K3YCY1woAWdmC2MH+efoDyiXXyVITnMkdHQi9ZBolWYkYaTHxy6Chsc9Dk54/+5ydo
         4O9Bq7l+UCsd4wejiddw/jJYSICpoj65CJyJ59WqtA4PS7M6t5FZ1DZU1JOXRKJwYWXK
         BUi0A/gRfGNaq57E3NBTMAqqKQKgYcIToG+cg0RN8xOldikVB78CPWvBWqqN3esCBfLR
         T0gSV/qw/KtY3O20E3vJ9EILgMex5JUn39A0WQRHpDUF9Iz2SdVZGtVq6ymPT549f76x
         5tuZlYyL+rOzbNeKSFUdRYFJemq035XjT2x9c0hef7BvpH32X9K8mPyudeuE/Gj1Jo+A
         yHaw==
X-Gm-Message-State: AAQBX9d0G2N1fJR0RZe7ky1+zxzkY6kdypfn9QvT/zcX+edImIBBThAV
	jnbHxiqzUWyXFTiDwfSkMMEK1pKrhMtDeCfa5dVJDnIn+ZInYUTUoEkii1cwqo9eC2oMc6J1kDA
	ZsD3ni5xGfMSF4MwdeF89i/l/+0vciCdV8+KUfi+AhTJG
X-Received: by 2002:a05:6808:3307:b0:383:fef9:6cac with SMTP id ca7-20020a056808330700b00383fef96cacmr2559408oib.9.1681111017795;
        Mon, 10 Apr 2023 00:16:57 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZovcXYKe7SHE5v/MAr73WhBk/8T+MNkULlMe06/6WhnKBFoq8FhLzH3/5tS7IX+dMqD66kgHQXIUnf05xVcys=
X-Received: by 2002:a05:6808:3307:b0:383:fef9:6cac with SMTP id
 ca7-20020a056808330700b00383fef96cacmr2559403oib.9.1681111017550; Mon, 10 Apr
 2023 00:16:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230330225834.506969-1-parav@nvidia.com> <20230330225834.506969-9-parav@nvidia.com>
 <CACGkMEtMOy4B-O-52ka+9P3OBQ_hs1KvdjWodNYg-XKLff+giw@mail.gmail.com> <20230410021619-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230410021619-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 10 Apr 2023 15:16:46 +0800
Message-ID: <CACGkMEsZXozY7iC7L3L9FC+o8dQGY9+Hhbag2Z-G-nxr9BvDdw@mail.gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>, virtio-dev@lists.oasis-open.org, cohuck@redhat.com, 
	virtio-comment@lists.oasis-open.org, shahafs@nvidia.com, 
	Satananda Burla <sburla@marvell.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [virtio-dev] [PATCH 08/11] transport-pci: Introduce virtio
 extended capability

On Mon, Apr 10, 2023 at 2:24=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Mon, Apr 10, 2023 at 09:36:17AM +0800, Jason Wang wrote:
> > On Fri, Mar 31, 2023 at 7:00=E2=80=AFAM Parav Pandit <parav@nvidia.com>=
 wrote:
> > >
> > > PCI device configuration space for capabilities is limited to only 19=
2
> > > bytes shared by many PCI capabilities of generic PCI device and virti=
o
> > > specific.
> > >
> > > Hence, introduce virtio extended capability that uses PCI Express
> > > extended capability.
> > > Subsequent patch uses this virtio extended capability.
> > >
> > > Co-developed-by: Satananda Burla <sburla@marvell.com>
> > > Signed-off-by: Parav Pandit <parav@nvidia.com>
> >
> > Can you explain the differences compared to what I've used to propose?
> >
> > https://www.mail-archive.com/virtio-dev@lists.oasis-open.org/msg08078.h=
tml
> >
> > This can save time for everybody.
> >
> > Thanks
>
> BTW another advantage of extended capabilities is - these are actually
> cheaper to access from a VM than classic config space.

Config space/BAR is allowed by both of the proposals or anything I missed?

>
>
> Several points
> - I don't like it that yours is 32 bit. We do not need 2 variants just
>   make it all 64 bit

That's fine.

> - We need to document that if driver does not scan extended capbilities i=
t will not find them.

This is implicit since I remember we don't have such documentation for
pci capability, anything makes pcie special?

>   And existing drivers do not scan them. So what is safe
>   to put there? vendor specific? extra access types?

For PASID at least, since it's a PCI-E feature, vendor specific should
be fine. Not sure about legacy MMIO then.

>   Can we make scanning these mandatory in future drivers? future devices?
>   I guess we can add a feature bit to flag that.

For PASID, it doesn't need this, otherwise we may duplicate transport
specific features.

>   Is accessing these possible from bios?

Not at least for the two use cases now PASID or legacy MMIO.

>
> So I like this one better as a basis - care reviewing it and adding
> stuff?

There are very few differences and I will have a look.

Thanks

>
> --
> MST
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

