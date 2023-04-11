Return-Path: <virtio-dev-return-12105-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13DC5C76196
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 03:29:08 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 1D7A19EEC1
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 03:29:08 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0A5519863A4
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 03:29:08 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id E802F983FEB; Tue, 11 Apr 2023 03:29:07 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D628E986366
	for <virtio-dev@lists.oasis-open.org>; Tue, 11 Apr 2023 03:29:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: lcATixZoPGiAJn65N8J5xA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681183739; x=1683775739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uuKKq+ekn53i/mg46RJYP/LrVIrupmcdCT95/OLkYOw=;
        b=fQbJXxnx1Dqi8ahziK9cfE4ZgZTCpqSOPtu2cUY3JCEe5DJ33YH0aK7GnV2wOUkqXP
         trDcYjrzYzgoBwctL2sYrywk4ZAYOaA8TurasyVHLgUVwEJjAJow3ALms6uS8i/3qwV+
         WzqRdp2lUmQQmRmJaAbkB7VRpsG8kpgYnXPJdIX2bbymETaK16Noqe0okqJsTNyTevOu
         nf7nGFFa7j4DEzfK8D12claQGKa9aDptEgHGy84Yps/vpvdv+eLrTqxEcueJTgcK8HoT
         v9AN8cWSmMUA0KthH2J3a4KSGDQuee00jagBuCMnkMx4TrRVdlc6k1eiQYUAiCUUl+WL
         xuDA==
X-Gm-Message-State: AAQBX9dQyc/8jUsPtb0aeRNAEOO4acBqrAZfZQsAv1/Ck/UqJeuZSISa
	kEodQrkj0fajKYOScmrRN8z6LoTh8r/VjUvRxg4GYdWx9BMP9sdW+SdPFUNEpFNjdFABhzXCNZT
	AGwkbSaO4nYNd8wl9h54p1aDu+8bAnTrl3/OoMd+H53Mm
X-Received: by 2002:a4a:e2d6:0:b0:53b:4e0a:6714 with SMTP id l22-20020a4ae2d6000000b0053b4e0a6714mr3808621oot.0.1681183739741;
        Mon, 10 Apr 2023 20:28:59 -0700 (PDT)
X-Google-Smtp-Source: AKy350Yq5Xn/0A/CJxcEw+z7sHlDdzRNb0Dbf0PQVqwg7ql0gYwAFFL99z25j98ucHVwZVfeSgETMVTWwyV2fjmo2iE=
X-Received: by 2002:a4a:e2d6:0:b0:53b:4e0a:6714 with SMTP id
 l22-20020a4ae2d6000000b0053b4e0a6714mr3808618oot.0.1681183739546; Mon, 10 Apr
 2023 20:28:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230330225834.506969-1-parav@nvidia.com> <20230330225834.506969-9-parav@nvidia.com>
 <CACGkMEtMOy4B-O-52ka+9P3OBQ_hs1KvdjWodNYg-XKLff+giw@mail.gmail.com> <307a9f8f-6184-0403-97ab-1b1c16d4fd3c@nvidia.com>
In-Reply-To: <307a9f8f-6184-0403-97ab-1b1c16d4fd3c@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 11 Apr 2023 11:28:48 +0800
Message-ID: <CACGkMEucOwwFDMqyWA+DgYV7X=9f5-P4Ba_AP=5kTsjna=n+7A@mail.gmail.com>
To: Parav Pandit <parav@nvidia.com>
Cc: mst@redhat.com, virtio-dev@lists.oasis-open.org, cohuck@redhat.com, 
	virtio-comment@lists.oasis-open.org, shahafs@nvidia.com, 
	Satananda Burla <sburla@marvell.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [virtio-dev] [PATCH 08/11] transport-pci: Introduce virtio
 extended capability

On Tue, Apr 11, 2023 at 1:54=E2=80=AFAM Parav Pandit <parav@nvidia.com> wro=
te:
>
> Hi Jason,
>
> On 4/9/2023 9:36 PM, Jason Wang wrote:
> > On Fri, Mar 31, 2023 at 7:00=E2=80=AFAM Parav Pandit <parav@nvidia.com>=
 wrote:
> >>
> >> PCI device configuration space for capabilities is limited to only 192
> >> bytes shared by many PCI capabilities of generic PCI device and virtio
> >> specific.
> >>
> >> Hence, introduce virtio extended capability that uses PCI Express
> >> extended capability.
> >> Subsequent patch uses this virtio extended capability.
> >>
> >> Co-developed-by: Satananda Burla <sburla@marvell.com>
> >> Signed-off-by: Parav Pandit <parav@nvidia.com>
> >
> > Can you explain the differences compared to what I've used to propose?
> >
> > https://www.mail-archive.com/virtio-dev@lists.oasis-open.org/msg08078.h=
tml
> >
> > This can save time for everybody.
> >
>
> What is proposed in this patch similar to [1].
>
> The main difference is, the proposed new capability is always placed in
> the pci extended capability section,
> This is because legacy capability section is nearly to its full level as
> described in commit message.
>
> So providing it at either of the two locations is not valuable.
>
> What you proposed in [1] is in general useful regardless;
>
> However, it is not backward compatible, if the device place them in
> extended capability, it will not work.
>

It is kind of intended since it is only used for new PCI-E features:

"
+The location of the virtio structures that depend on the PCI Express
+capability are specified using a vendor-specific extended capabilities
+on the extended capabilities list in PCI Express extended
+configuration space of the device.
"

> To make it backward compatible, a device needs to expose existing
> structure in legacy area. And extended structure for same capability in
> extended pci capability region.
>
> In other words, it will have to be a both places.

Then we will run out of config space again? Otherwise we need to deal
with the case when existing structures were only placed at extended
capability. Michael suggest to add a new feature, but the driver may
not negotiate the feature which requires more thought.

>
> Otherwise its similar.
>
> We should do this regardless, and it will also make this series shorter
> which is also what Michael prefers.
>
> Would you like join efforts with me of drafting [1] + above description
> as independent patch?

I think it should be fine but I'm not sure what it looks like.

> We may need it even sooner than this because the AQ patch is expanding
> the structure located in legacy area.

Just to make sure I understand this, assuming we have adminq, any
reason a dedicated pcie ext cap is required?

Thanks

>
> [1]
> https://www.mail-archive.com/virtio-dev@lists.oasis-open.org/msg08078.htm=
l
>
> PASID part of the patch is not relevant here, so will skip to comment.
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

