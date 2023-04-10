Return-Path: <virtio-dev-return-12078-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8EC2C76196
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Apr 2023 06:20:33 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 0D65760351
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Apr 2023 06:20:33 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F423A9863A4
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Apr 2023 06:20:32 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id E704F9862A5; Mon, 10 Apr 2023 06:20:32 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D7AA7986319
	for <virtio-dev@lists.oasis-open.org>; Mon, 10 Apr 2023 06:20:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: aNC-ffCsN3iAHqoF6ZKtNA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681107627; x=1683699627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gQFO1bMA7Kgv2xL5DEouetN0N//LrjsKoKYuczpNxFM=;
        b=0a/bvaAQIv1rib9aO20XEo22deFBF4lGWsFCzc75Bqg6gc6kMWes83DstAL5ZgMquN
         evw4f/Pwy14dodN1vCvcGkdz2ICM2lPfNHtx0fyHhLDPzGXFkKSBWC20u9c/eMYz+97X
         bv48xl0EYjdlAdy4TYYvd6RdSssnTYoLFriE99Cn8NfPiZpTLUzDzNMaywYxTWcrX501
         RWfYNXUC7tYoisfaus4Gbq5suCXlSMkFS6yjdcetpf79n1dmXIu5fOeP+xq5/OZa6bnX
         JqNScgTErDqCUpvwcvQq4NoPyBcf2keaxV86O7xrDLCOLCVcAGKGE1M3UFYIZZWJn5Vw
         G6CQ==
X-Gm-Message-State: AAQBX9f65fA969KaWfHahAxfBRuUPs3xMeRzWmuqHAfIOX0xAAD9e3Wj
	FDT043qolmQdKWA6/QpLy+HtOZyFrRyU3P0KMf+sG+1PMpuQMSXYHbvG7CJK7rjZifUzEB9UX+m
	YsAGmeFmg4deB6v8AfZTQQILoyDSoo8uERAmcUVdvl5tQ
X-Received: by 2002:a05:6870:6587:b0:17f:1723:fc82 with SMTP id fp7-20020a056870658700b0017f1723fc82mr4777741oab.9.1681107627669;
        Sun, 09 Apr 2023 23:20:27 -0700 (PDT)
X-Google-Smtp-Source: AKy350YJdlIqWpsQC0sebHj85pAPO8SRWJDhR62UTB7MEA4Qxk7uLxGq0heW2g9rA1Ux10vRZuPYvHmhKCwi0bvpt0Q=
X-Received: by 2002:a05:6870:6587:b0:17f:1723:fc82 with SMTP id
 fp7-20020a056870658700b0017f1723fc82mr4777720oab.9.1681107627480; Sun, 09 Apr
 2023 23:20:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230330225834.506969-1-parav@nvidia.com> <20230330225834.506969-10-parav@nvidia.com>
 <20230407043841-mutt-send-email-mst@kernel.org> <CACGkMEtkOdwixxaRz2Pv9xP75vb13ncboX5XRs8NqFCUsS16aQ@mail.gmail.com>
 <20230410020906-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230410020906-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 10 Apr 2023 14:20:16 +0800
Message-ID: <CACGkMEtiROwuB+ECJqd13qdpMJSTMoDOzi1u_i85==42C0XSXw@mail.gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>, virtio-dev@lists.oasis-open.org, cohuck@redhat.com, 
	virtio-comment@lists.oasis-open.org, shahafs@nvidia.com, 
	Satananda Burla <sburla@marvell.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [virtio-comment] Re: [PATCH 09/11] transport-pci: Describe PCI
 MMR dev config registers

On Mon, Apr 10, 2023 at 2:15=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Mon, Apr 10, 2023 at 09:33:32AM +0800, Jason Wang wrote:
> > This is fine for vDPA but not for virtio if the design can only work
> > for some specific setups (OSes/archs).
> >
> > Thanks
>
> Well virtio legacy has a long history of documenting existing hacks :)

Exactly, so the legacy behaviour is not (or can't be) defined by the
spec but the codes.

> But yes, VIRTIO_F_ORDER_PLATFORM has to be documented.
> And we have to decide what to do about ACCESS_PLATFORM since
> there's a security problem if device allows not acking it.
> Two options:
> - relax the rules a bit and say device will assume ACCESS_PLATFORM
>   is acked anyway

This will break legacy drivers which assume physical addresses.

> - a new flag that is insecure (so useful for sec but useless for dpdk) bu=
t optional

This looks like a new "hack" for the legacy hacks.

And what about ORDER_PLATFORM, I don't think we can modify legacy drivers..=
.

Thanks

>
> --
> MST
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

