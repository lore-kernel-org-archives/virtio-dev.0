Return-Path: <virtio-dev-return-12422-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95502C77B78
	for <virtio-dev@archiver.kernel.org>; Wed, 26 Apr 2023 03:03:48 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id CE02F3711A
	for <virtio-dev@archiver.kernel.org>; Wed, 26 Apr 2023 03:03:47 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C0B68986650
	for <virtio-dev@archiver.kernel.org>; Wed, 26 Apr 2023 03:03:47 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id B34E9983D70; Wed, 26 Apr 2023 03:03:47 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9F6609864A2
	for <virtio-dev@lists.oasis-open.org>; Wed, 26 Apr 2023 03:03:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 47rFvHLYNquGi_UrZTrWqw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682478221; x=1685070221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=veN78nQ8ynyiy9us883OttMEFcRypLuEY7eMRjOcxSE=;
        b=OaKTtWJcD7WKh/pojMwyAN+3XqprNShaXkFpOUWjq+wsW1MDW9XcDe54C1sxrZ97lT
         YU5BndtyujXm48vitqMxd0RGybyF+Sr967ILFh03/1DrakkH3uEgaUdqSEOPVjxuirvS
         Wlj12db/FoEYm67PTf7XL6Sg9jAkDAnUW2d3+jRNnqqNRv9Mr4wiGTjvrNBQjQXrwtz3
         Hdc92+9ptVlDe1tWAeoLtKkhEA0phIL9WDu4Vp0Ri9MdKloQ9T6w4Ts8Bqgreo4Nb/Om
         2ZidQ+eWPICEEivL13yFujZ8n/+IyD8JLO8nPTw7KkhBD/4SerMHLGNQHz90bMamxmCF
         uDAA==
X-Gm-Message-State: AAQBX9cjoA3/JIP5WjmRS6M9rB1JPO4DhahCTJtwK1SGC3WjbS8ZUQTs
	S7zZ+7nsTXy4b1fBQTcuLRQzAjaCQYomXAeelTNOpQ1b3/eAA+lMA3jmSYtIfwfmmtQVptA12XZ
	Hjgjw3b1zyEyZjrc34NJGHay29DDpZZ2FGkC37Tr0uRkl
X-Received: by 2002:a2e:88cd:0:b0:2a8:b076:3877 with SMTP id a13-20020a2e88cd000000b002a8b0763877mr3859002ljk.10.1682478221346;
        Tue, 25 Apr 2023 20:03:41 -0700 (PDT)
X-Google-Smtp-Source: AKy350b8dgbOoKwCv/5NH9dYzFTFpkckqz6KviKVdF+hi1aY6DtqEB8vxxjYVMTshI320AF0wpBhF7yVOeRQbQqRqN0=
X-Received: by 2002:a2e:88cd:0:b0:2a8:b076:3877 with SMTP id
 a13-20020a2e88cd000000b002a8b0763877mr3858993ljk.10.1682478221058; Tue, 25
 Apr 2023 20:03:41 -0700 (PDT)
MIME-Version: 1.0
References: <1ab0beff-8b18-7a94-1a68-6bf36bcd0394@bytedance.com>
 <CACGkMEvh+G2Tm=WDTOK3K2GO8c2dQ4y=UiKAk_kvsid2MGzbGg@mail.gmail.com> <20230425140942.GB697094@fedora>
In-Reply-To: <20230425140942.GB697094@fedora>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 26 Apr 2023 11:03:29 +0800
Message-ID: <CACGkMEvJhoM=BzVUAYaBjdkuAsY2fVijL1p8LzC63F1RGoKC5g@mail.gmail.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: zhenwei pi <pizhenwei@bytedance.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
	Cornelia Huck <cohuck@redhat.com>, parav@nvidia.com, virtio-dev@lists.oasis-open.org, 
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, 
	"helei.sig11@bytedance.com" <helei.sig11@bytedance.com>, houp@yusur.tech
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [virtio-comment] [PROPOSAL] Virtio Over Fabrics(TCP/RDMA)

On Tue, Apr 25, 2023 at 10:09=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.c=
om> wrote:
>
> On Mon, Apr 24, 2023 at 11:40:02AM +0800, Jason Wang wrote:
> > On Sun, Apr 23, 2023 at 7:31=E2=80=AFPM zhenwei pi <pizhenwei@bytedance=
.com> wrote:
> > > I develop an kernel initiator(unstable, WIP version, currently TCP/RD=
MA
> > > supported):
> > > https://github.com/pizhenwei/linux/tree/virtio-of-github
> >
> > A quick glance at the code told me it's a mediation layer that convert
> > descriptors in the vring to the fabric specific packet. This is the
> > vDPA way.
> >
> > If we agree virtio of fabic is useful, we need invent facilities to
> > allow building packet directly without bothering the virtqueue (the
> > API is layout independent anyhow).
>
> I agree. vrings makes sense for RDMA, but I think virtio_fabrics.c
> should not be dependent on vrings.
>
> Linux struct virtqueue is independent of vrings but the implementation
> currently lives in virtio_ring.c because there has never been a
> non-vring transport before.
>
> It would be nice to implement virtqueue_add_sgs() specifically for
> virtio_tcp.c without the use of vrings. Is a new struct
> virtqueue_ops needed with with .add_sgs() and related callbacks?
>
> Luckily the <linux/virtio.h> API already supports this abstraction and
> changes to existing device drivers should be unnecessary or minimal.

That's my understanding.

Btw, I'm also ok if we start with vring and optimize on top.

Thanks

>
> Stefan


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

