Return-Path: <virtio-dev-return-12082-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3200C76196
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Apr 2023 07:21:06 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 053033DF35
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Apr 2023 07:21:06 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E2BC898632A
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Apr 2023 07:21:05 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id CFF249862A5; Mon, 10 Apr 2023 07:21:05 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BFAA698631E
	for <virtio-dev@lists.oasis-open.org>; Mon, 10 Apr 2023 07:21:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: ZZ_vAiPmNsuDqheW_EFGAQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681111263; x=1683703263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pOnZM4oKYtv08VMvJswhLPik1/4GCmtKrTym0UUElAg=;
        b=P3S3HVuMT8B9oMvGRW+wbVQRRnf2Tq2Z9Dkp3FfBhjzB8ptjm6NxYIuESj0gH6JVy5
         GByXPfVw++OseTW48SriUY3pnfG7zsNiVcFQBEhrqDpMEiSU6HnHbvqmNDizF6+b6t6A
         cWmluueYdrB8zwqH21q7SVR1x4f1F2qYDWwCfAZxHhczHiyvwOOphxH4qYW5IZsqj+pn
         V5qEffk3tADEFl8iX7VWkB7rOI7fL9hKFc4DdTAsE/GUAHi5yEW3Yn4Og/qytTeVM3oV
         6osb0zNb48VA0X4u66DHjztVZT4bfRf3JOaSkwRlOPFxrZNttGbW9Wir6d1Is05o7oII
         6BAQ==
X-Gm-Message-State: AAQBX9dHtD5Yy+y3Y40IROcnJWo75CkYxB27jb8XiBu+BzpQNhUVU45z
	X4mlKBkLP6xf5wPCD+THxqpp+PWeJt+zDJ4WMbL+BOjIYhrrZsfjguwwOKoTWDNUoiHafcsSGXH
	1o9brWDtXNaVulCEcQo134k6SJH9MvIbGiO5MBhZutzGp
X-Received: by 2002:a05:6870:c22c:b0:17e:7674:8df0 with SMTP id z44-20020a056870c22c00b0017e76748df0mr3118441oae.9.1681111263077;
        Mon, 10 Apr 2023 00:21:03 -0700 (PDT)
X-Google-Smtp-Source: AKy350aOjXMKA+ZYBvRiZ7hg3IxdqxSrKXPv26P3Vt3E05uAC224RKOWHhvUvreoiCs+FrbIKrCsr8x70XvIoq+TXMQ=
X-Received: by 2002:a05:6870:c22c:b0:17e:7674:8df0 with SMTP id
 z44-20020a056870c22c00b0017e76748df0mr3118434oae.9.1681111262866; Mon, 10 Apr
 2023 00:21:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230330225834.506969-1-parav@nvidia.com> <20230330225834.506969-10-parav@nvidia.com>
 <20230407043841-mutt-send-email-mst@kernel.org> <CACGkMEtkOdwixxaRz2Pv9xP75vb13ncboX5XRs8NqFCUsS16aQ@mail.gmail.com>
 <20230410020906-mutt-send-email-mst@kernel.org> <CACGkMEtiROwuB+ECJqd13qdpMJSTMoDOzi1u_i85==42C0XSXw@mail.gmail.com>
 <20230410023715-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230410023715-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 10 Apr 2023 15:20:52 +0800
Message-ID: <CACGkMEs+E_OarQxP3NmLk3iSi7U0WgAn-m3b4eX7ULu1+v=sOw@mail.gmail.com>
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

On Mon, Apr 10, 2023 at 2:40=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Mon, Apr 10, 2023 at 02:20:16PM +0800, Jason Wang wrote:
> > On Mon, Apr 10, 2023 at 2:15=E2=80=AFPM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Mon, Apr 10, 2023 at 09:33:32AM +0800, Jason Wang wrote:
> > > > This is fine for vDPA but not for virtio if the design can only wor=
k
> > > > for some specific setups (OSes/archs).
> > > >
> > > > Thanks
> > >
> > > Well virtio legacy has a long history of documenting existing hacks :=
)
> >
> > Exactly, so the legacy behaviour is not (or can't be) defined by the
> > spec but the codes.
>
> I mean driver behaviour derives from the code but we do document it in
> the spec to help people build devices.
>
>
> > > But yes, VIRTIO_F_ORDER_PLATFORM has to be documented.
> > > And we have to decide what to do about ACCESS_PLATFORM since
> > > there's a security problem if device allows not acking it.
> > > Two options:
> > > - relax the rules a bit and say device will assume ACCESS_PLATFORM
> > >   is acked anyway
> >
> > This will break legacy drivers which assume physical addresses.
>
> not that they are not already broken.

I may miss something, the whole point is to allow legacy drivers to
run otherwise a modern device is sufficient?

>
> > > - a new flag that is insecure (so useful for sec but useless for dpdk=
) but optional
> >
> > This looks like a new "hack" for the legacy hacks.
>
> it's not just for legacy.

We have the ACCESS_PLATFORM feature bit, what is the useage for this new fl=
ag?

>
> > And what about ORDER_PLATFORM, I don't think we can modify legacy drive=
rs...
> >
> > Thanks
>
> You play some tricks with shadow VQ I guess.

Do we really want to add a new feature in the virtio spec that can
only work with the datapath mediation?

Thanks

>
> --
> MST
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

