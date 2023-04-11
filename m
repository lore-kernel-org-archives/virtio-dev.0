Return-Path: <virtio-dev-return-12104-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 673F8C77B70
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 02:20:25 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id A227268476
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 02:20:23 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 16B629865FD
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 02:20:23 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 8BC7C98636E; Tue, 11 Apr 2023 02:20:22 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5C91A986366
	for <virtio-dev@lists.oasis-open.org>; Tue, 11 Apr 2023 02:19:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: ngUR_-hcMk6nYeZgBYxeDA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681179590; x=1683771590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CPtj3zXdkPp+mQ8rt9riaaPqbH9Bs6m65POqA3/1Vkc=;
        b=cYLMU3oKbmzXbVL5+qtA/odWQA/LEAmMCyAPN+ZaLX+OTMEaUzXDwql+Br3/cs3ZOL
         O+RsfPcztbRBnO0b4QL3yLsO0LZKlEVCRSG+hOtl5BxcZt6HZJxEmbuEaLOgTd5djaMe
         YQNuo21fWhNMuITUhsErI0eUSh2MLPmk8m7qJ5p7QaLQyKOeDJw2URhawdmc5tBAXvnC
         Gg+l8HAxx0z5HyCGDGryeW0xmRRIt1IJFZbXU+f+0Zf3vFTkhI/S+Q1nWQLaSxtRKfhq
         0/atw8ovquq2dzjbVtaCXwprOnLs/WNrJIKXRa4/TEc3xg0YC1QPnMdVTwuYq7Pz75rT
         l18w==
X-Gm-Message-State: AAQBX9c9qMyfa+Ui9WH/58Hchy0CalgJrpcvx3c3Mpf5J7dLcXhvpCR2
	EJoG7JmA6g/zj4jxYGGCUxsdTZdza/MVvDF9ZDgfuFOOqwaH9Chz8pd4GdpMrA5+nE/uBkBwcqs
	y9ane61pJf52R5Mvl61Q+rlPNDRsVUnvS4M8CUsi43iK2
X-Received: by 2002:a05:6870:7012:b0:177:c2fb:8cec with SMTP id u18-20020a056870701200b00177c2fb8cecmr576016oae.9.1681179590446;
        Mon, 10 Apr 2023 19:19:50 -0700 (PDT)
X-Google-Smtp-Source: AKy350atjarUPwd3qG+qFk9koMdUxhVz8y9x05SQxMqpD9KBF93FvOswpdVDcmI4jH5I3JjkN4msJXP7dWebI+T8F3A=
X-Received: by 2002:a05:6870:7012:b0:177:c2fb:8cec with SMTP id
 u18-20020a056870701200b00177c2fb8cecmr576009oae.9.1681179590241; Mon, 10 Apr
 2023 19:19:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230330225834.506969-1-parav@nvidia.com> <20230330225834.506969-9-parav@nvidia.com>
 <CACGkMEtMOy4B-O-52ka+9P3OBQ_hs1KvdjWodNYg-XKLff+giw@mail.gmail.com>
 <20230410021619-mutt-send-email-mst@kernel.org> <CACGkMEsZXozY7iC7L3L9FC+o8dQGY9+Hhbag2Z-G-nxr9BvDdw@mail.gmail.com>
 <20230410055947-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230410055947-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 11 Apr 2023 10:19:39 +0800
Message-ID: <CACGkMEsKLeJ1q3Vh8h2JYM=-RcrGd+31yR1Zsw0U=SRd1JZugg@mail.gmail.com>
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

On Mon, Apr 10, 2023 at 6:04=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Mon, Apr 10, 2023 at 03:16:46PM +0800, Jason Wang wrote:
> > On Mon, Apr 10, 2023 at 2:24=E2=80=AFPM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Mon, Apr 10, 2023 at 09:36:17AM +0800, Jason Wang wrote:
> > > > On Fri, Mar 31, 2023 at 7:00=E2=80=AFAM Parav Pandit <parav@nvidia.=
com> wrote:
> > > > >
> > > > > PCI device configuration space for capabilities is limited to onl=
y 192
> > > > > bytes shared by many PCI capabilities of generic PCI device and v=
irtio
> > > > > specific.
> > > > >
> > > > > Hence, introduce virtio extended capability that uses PCI Express
> > > > > extended capability.
> > > > > Subsequent patch uses this virtio extended capability.
> > > > >
> > > > > Co-developed-by: Satananda Burla <sburla@marvell.com>
> > > > > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > > >
> > > > Can you explain the differences compared to what I've used to propo=
se?
> > > >
> > > > https://www.mail-archive.com/virtio-dev@lists.oasis-open.org/msg080=
78.html
> > > >
> > > > This can save time for everybody.
> > > >
> > > > Thanks
> > >
> > > BTW another advantage of extended capabilities is - these are actuall=
y
> > > cheaper to access from a VM than classic config space.
> >
> > Config space/BAR is allowed by both of the proposals or anything I miss=
ed?
> >
> > >
> > >
> > > Several points
> > > - I don't like it that yours is 32 bit. We do not need 2 variants jus=
t
> > >   make it all 64 bit
> >
> > That's fine.
> >
> > > - We need to document that if driver does not scan extended capbiliti=
es it will not find them.
> >
> > This is implicit since I remember we don't have such documentation for
> > pci capability, anything makes pcie special?
>
> yes - the fact that there are tons of existing drivers expecting
> everything in standard space.
>
>
> > >   And existing drivers do not scan them. So what is safe
> > >   to put there? vendor specific? extra access types?
> >
> > For PASID at least, since it's a PCI-E feature, vendor specific should
> > be fine. Not sure about legacy MMIO then.
> >
> > >   Can we make scanning these mandatory in future drivers? future devi=
ces?
> > >   I guess we can add a feature bit to flag that.
> >
> > For PASID, it doesn't need this, otherwise we may duplicate transport
> > specific features.
>
> i don't get it. what does PASID have to do with it?

My proposal is to allow PASID capability to be placed on top. So what
I meant is:

if the driver needs to use PASID, it needs to scan extend capability

So it is only used for future drivers. I think this applies to legacy
MMIO as well.

> A new feature will allow clean split at least:
> we make any new features and new devices that expect
> express capability depend on this new feature bit.
>
> > >   Is accessing these possible from bios?
> >
> > Not at least for the two use cases now PASID or legacy MMIO.
>
> can't parse english here. what does this mean?

I meant, it depends on the capability semantics. Both PASID and legacy
MMIO don't need to be accessed by BIOS. We can't change legacy BIOS to
use legacy MMIO bars.

Thanks

>
>
> > >
> > > So I like this one better as a basis - care reviewing it and adding
> > > stuff?
> >
> > There are very few differences and I will have a look.
> >
> > Thanks
> >
> > >
> > > --
> > > MST
> > >
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

