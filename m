Return-Path: <virtio-dev-return-14171-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90F8DC46CD3
	for <virtio-dev@archiver.kernel.org>; Wed, 20 Dec 2023 05:53:10 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id ED9277413C
	for <virtio-dev@archiver.kernel.org>; Wed, 20 Dec 2023 05:53:09 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DF6AD986547
	for <virtio-dev@archiver.kernel.org>; Wed, 20 Dec 2023 05:53:09 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id D1602983F74; Wed, 20 Dec 2023 05:53:09 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BB00B98654A
	for <virtio-dev@lists.oasis-open.org>; Wed, 20 Dec 2023 05:53:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: c5EvkV9YPmyo-GM9GGbTag-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703051584; x=1703656384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dKfENHGkrSLtlME4xIanE840yr40Ddp9BMfJN4UBJX8=;
        b=uoihXzCpYgNtVf3/M16UyaPktHK1KG+BfQVHiNTDC0Nd97o/KfK+mFEYMQL6vCb7yP
         92LsJ1eWKUB8K5spy285zmKRb30UVlp2AZTyDKUtoxfwnoByC+RAs5DKlwPN7bl4B6zX
         fS0e+jfissH3c8CeBzWSbTmpb3oA8hhikDmDBMcY/87uG4u5aooAagYHza+mu22o1G1u
         7TMZGVS3Bfqil+BFmwe7F59xmX3w7S7juIWX1SwAJwexwFNHJpaV9Iq2nPGulKgaa9PB
         4yK3AyKzAK5EddM3Og5o1sW5+SSk55KWjRGgrx4FjS1/s7jmIQ920vCWBvbswB0ZkASB
         ERqg==
X-Gm-Message-State: AOJu0Yysmhc0ff8BDQADEGN/W4YnV49nzGnbnJ8tX1YIC2/9NKnGRSep
	/yX+PTl+Deg1prQxD+rnozEROFdhpIk+ucNo4rwYVIDdG9sZT8aerdRvFpaPZsUkCl1EwuejQ9N
	nf7AfeuhKb0jo7OAVH/XuZlMXblwwMPL5aHrx6oQoQpHa
X-Received: by 2002:a05:6a00:1d84:b0:6d7:656c:154c with SMTP id z4-20020a056a001d8400b006d7656c154cmr2991577pfw.57.1703051584021;
        Tue, 19 Dec 2023 21:53:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHNVOIW//wn7b+IQFvMbBM+QUOeEQaLp9WDL57jOvbQa5uTKctfJq/Fm1Pq8f9IYXuHfISjQfsJwxszRz7dqx4=
X-Received: by 2002:a05:6a00:1d84:b0:6d7:656c:154c with SMTP id
 z4-20020a056a001d8400b006d7656c154cmr2991569pfw.57.1703051583680; Tue, 19 Dec
 2023 21:53:03 -0800 (PST)
MIME-Version: 1.0
References: <959e1a7ccdfffaaadd865a627924cf492ce22bfa.1702277523.git.hengqi@linux.alibaba.com>
 <20231211110350-mutt-send-email-mst@kernel.org> <a8ba676e-de43-45ae-a6a8-a67d0dd41c1f@linux.alibaba.com>
 <20231212032713-mutt-send-email-mst@kernel.org> <bfd25f86-4292-45d2-a7a2-fe61bde0edb4@linux.alibaba.com>
 <b739d275-3664-4509-8a91-f19690719475@linux.alibaba.com> <fafa078b-14f5-460d-b03e-122afb9156ba@linux.alibaba.com>
 <CACGkMEuCb13=-b1yMYi3NOehL+6eNWjWsmBHfcYho1w0HwpVBA@mail.gmail.com>
 <6d9353f7-2899-4ba9-8aef-2431c9362207@linux.alibaba.com> <CACGkMEsh9h_syGag48DL9rSSH2Yp4Ht-ES4gA-5rv16Lih_tJw@mail.gmail.com>
 <20231219134036-mutt-send-email-mst@kernel.org>
In-Reply-To: <20231219134036-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 20 Dec 2023 13:52:52 +0800
Message-ID: <CACGkMEtRddzqns4VTg3NnJ=8x=6duBnA8so2Sezk2fHSqj53gg@mail.gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, 
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, 
	Yuri Benditovich <yuri.benditovich@daynix.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [virtio-comment] Re: [PATCH v5] virtio-net: device does not
 deliver partially checksummed packet and may validate the checksum

On Wed, Dec 20, 2023 at 2:41=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Tue, Dec 19, 2023 at 03:53:14PM +0800, Jason Wang wrote:
> > On Mon, Dec 18, 2023 at 12:54=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.=
com> wrote:
> > >
> > >
> > >
> > > =E5=9C=A8 2023/12/18 =E4=B8=8A=E5=8D=8811:10, Jason Wang =E5=86=99=E9=
=81=93:
> > > > On Fri, Dec 15, 2023 at 5:51=E2=80=AFPM Heng Qi <hengqi@linux.aliba=
ba.com> wrote:
> > > >> Hi all!
> > > >>
> > > >> I would like to ask if anyone has any comments on this version, if=
 so
> > > >> please let me know!
> > > >> If not, I will collect Michael's comments and publish a new versio=
n next
> > > >> Monday.
> > > > I have a dumb question. (And sorry if I asked it before)
> > > >
> > > > Looking at the spec and code. It looks to me DATA_VALID could be se=
t
> > > > without GUEST_CSUM.
> > >
> > > I don't see that in the spec.
> > > Am I missing something? [1][2]
> > >
> > > [1] If the VIRTIO_NET_F_GUEST_CSUM feature was negotiated, the
> > > VIRTIO_NET_HDR_F_DATA_VALID bit in flags can be set: if so, device ha=
s
> > > validated the packet checksum. In case of multiple encapsulated
> > > protocols, one level of checksums has been validated.
> > > Additionally, VIRTIO_NET_F_GUEST_CSUM, TSO4, TSO6, UDP and ECN featur=
es
> > > *enable receive checksum*, large receive offload and ECN support whic=
h
> > > are the input equivalents of the transmit checksum, transmit
> > > segmentation *offloading* and ECN features, as described in 5.1.6.2.
> > >
> > > [2] If VIRTIO_NET_F_GUEST_CSUM is not negotiated, the device *MUST se=
t
> > > flags to zero* and SHOULD supply a fully checksummed packet to the dr=
iver.
> >
> > So this is kind of ambiguous and seems not what I wanted when I wrote
> > the code for DATA_VALID in 2011.
> >
> > NEEDS_CSUM maps to CHECKSUM_PARTIAL which means the packet checksum is
> > correct. So spec had
> >
> > """
> > If neither VIRTIO_NET_HDR_F_NEEDS_CSUM nor VIRTIO_NET_HDR_F_DATA_VALID
> > is set, the driver MUST NOT rely on the packet checksum being correct.
> > """
> >
> > For DATA_VALID, it maps to CHECKSUM_UNNECESSARY which is mutually
> > exclusive with CHECKSUM_PARTAIL. And this is what Linux did right now:
> >
> > For tun_put_user():
> >
> >         if (skb->ip_summed =3D=3D CHECKSUM_PARTIAL) {
> >                 ...
> >         } else if (has_data_valid &&
> >                    skb->ip_summed =3D=3D CHECKSUM_UNNECESSARY) {
> >                    hdr->flags =3D VIRTIO_NET_HDR_F_DATA_VALID;
> >         } /* else everything is zero */
> >
> > This CHECKSUM_UNNECESSARY will work even if GUEST_CSUM is disabled if
> > I was not wrong.
> >
> > And in receive_buf():
> >
> >         if (hdr->hdr.flags & VIRTIO_NET_HDR_F_DATA_VALID)
> >                 skb->ip_summed =3D CHECKSUM_UNNECESSARY;
> >
> > I think we can fix this by safely removing "*MUST set flags to zero*"
> > in [2] from the spec.
> >
> > Thanks
>
> I don't get why you want to remove this. I think this text refers to
> when no offloads are negotiated. Why would device then set any flags?

Current Linux can produce DATA_VALID without GUEST_CSUM. So it just
wants to align with that.

Driver can just not set CHECKSUM_UNNECESSARY if the rx csum is disabled.

Thanks


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

