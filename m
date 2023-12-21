Return-Path: <virtio-dev-return-14188-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1EACC35274
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Dec 2023 03:51:43 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 8D71670263
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Dec 2023 03:51:42 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 61490986703
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Dec 2023 03:51:42 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 513FE983EB5; Thu, 21 Dec 2023 03:51:42 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2A39A9867BB
	for <virtio-dev@lists.oasis-open.org>; Thu, 21 Dec 2023 03:51:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: MPkwZ92EN22vvv-NxdC-dw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703130698; x=1703735498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KgdCQyaZm6P1/KIcGQ5zMTyxN+WLJl5+rE1qeUfPDMg=;
        b=hCdnNXmGqDajr17dQnp0cCMsPvWLB84mbPmWXBb4THkiV1p6/1VuPNlateWwReIm9L
         jtzrkjgG7YcnhE+4mCpmDN50pigDeeUBn9G+aHUpPn/6U3iwtp8DGkNGGTTo3EeaakLN
         ReQJhva26/qsWKypWiXXHwd+a199h4wpnEY0nzjOLaZVJaefQUg1a1WeVe04gdzaawPX
         k3O6QX+cDrLRqfyOluXEnPy+beDUR3jvmxaQUFG5Je4HXT61kQjyvHvw/GlOV+W7HP6y
         Uzb6gLXu1iOkfuoqmbUc0iQ3U65LunuGuTRnFOUIok0ejAq0M/u3BppG04gJae4Q+Usd
         KV5g==
X-Gm-Message-State: AOJu0YwEjZmE1YjQUGd6XSpqzMwdYNmg/JXF7eEFabnC+pNxKJe6utan
	GOfqoZJikV6tdkxJqeqfH5Yxe63w3FiQA8hJxLOrR6NT7h8PRVMeP40Dz4NH3r47vl1uURzz474
	maQDHT5w0p/BGFqKia4Z33N6SwfR67N83s3t+tMgUlX2u
X-Received: by 2002:a05:6808:654b:b0:3ba:73f:e30a with SMTP id fn11-20020a056808654b00b003ba073fe30amr21992964oib.55.1703130698642;
        Wed, 20 Dec 2023 19:51:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGn8v5mQyle7rm1xw877MMtMV4jcBytqa01S6IB7tv5qI6OlmNfySzq/ZmZdbcNmlAtxQW9MyoRCH5NQqNrdqg=
X-Received: by 2002:a05:6808:654b:b0:3ba:73f:e30a with SMTP id
 fn11-20020a056808654b00b003ba073fe30amr21992955oib.55.1703130698423; Wed, 20
 Dec 2023 19:51:38 -0800 (PST)
MIME-Version: 1.0
References: <20231212032713-mutt-send-email-mst@kernel.org>
 <bfd25f86-4292-45d2-a7a2-fe61bde0edb4@linux.alibaba.com> <b739d275-3664-4509-8a91-f19690719475@linux.alibaba.com>
 <fafa078b-14f5-460d-b03e-122afb9156ba@linux.alibaba.com> <CACGkMEuCb13=-b1yMYi3NOehL+6eNWjWsmBHfcYho1w0HwpVBA@mail.gmail.com>
 <6d9353f7-2899-4ba9-8aef-2431c9362207@linux.alibaba.com> <CACGkMEsh9h_syGag48DL9rSSH2Yp4Ht-ES4gA-5rv16Lih_tJw@mail.gmail.com>
 <df90d58d-7e4e-44d7-8896-5fc5b131c164@linux.alibaba.com> <CACGkMEsxsLP=hnybYi2fiKXFq1U1zo+EuKnzfnbT3K_Wcrug5Q@mail.gmail.com>
 <68b0d00b-8b3b-4bd4-9e7c-c3b811dafd8c@linux.alibaba.com> <20231220020428-mutt-send-email-mst@kernel.org>
 <CACGkMEspotRCqjgNGbmBfR9SH8P_um4me7TVsomnaJ6Gc9pSmA@mail.gmail.com> <7fa1ca7b-17db-4f7f-a914-dfc7aac047c6@linux.alibaba.com>
In-Reply-To: <7fa1ca7b-17db-4f7f-a914-dfc7aac047c6@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 21 Dec 2023 11:51:26 +0800
Message-ID: <CACGkMEtj3bockeva1DEotbMJvsV-4Wr1H0akYPX70UqYVh9rOw@mail.gmail.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, 
	Yuri Benditovich <yuri.benditovich@daynix.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [virtio-comment] Re: [virtio-dev] Re: [virtio-comment] Re: [PATCH
 v5] virtio-net: device does not deliver partially checksummed packet and may
 validate the checksum

On Thu, Dec 21, 2023 at 11:45=E2=80=AFAM Heng Qi <hengqi@linux.alibaba.com>=
 wrote:
>
>
>
> =E5=9C=A8 2023/12/21 =E4=B8=8A=E5=8D=889:34, Jason Wang =E5=86=99=E9=81=
=93:
> > On Wed, Dec 20, 2023 at 3:35=E2=80=AFPM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> >> On Wed, Dec 20, 2023 at 02:30:01PM +0800, Heng Qi wrote:
> >>> But why are we discussing this?
> >> I think basically at this point everyone is confused about what
> >> the feature does. right now we have packets
> >> with
> >> #define VIRTIO_NET_HDR_F_NEEDS_CSUM     1       -> partial
> >> #define VIRTIO_NET_HDR_F_DATA_VALID     2       -> unnecessary
> >> and packets without either                      -> none
> >>
> >> if both 1 and 2 are set then linux uses VIRTIO_NET_HDR_F_NEEDS_CSUM bu=
t
> >> I am not sure it's not a mistake. Maybe it does not matter.
> >>
> >> What does this new thing do? So far all we have is "XDP will turn it o=
n"
> >> which is not really sufficient. I assumed it somehow replaces
> >> partial with complete.
> > It looks not? CHECKSUM_COMPLETE is less optimal than
> > CHECKSUM_UNNCESSARY as validation is still needed.
> >
> > If I understand correctly, this new thing wants DATA_VALID only.
>
> Disable NEEDS_CSUM or calculate fully checksummed packets to fully
> checksummed packets (how this is done does not matter).
> The driver will only receive two types of packets: CHECKSUM_NONE and
> DATA_VALID (CHECKSUM_UNNECESSARY).

Right, this is my understanding as well.

Thanks

>
> Thanks=EF=BC=81
>
> >
> > Thanks
> >
> >
> >
> >> That would make sense for many reasons,
> >> for example the checksum fields in the header can be reused
> >> for other purposes. But maybe not?
> >>
> >>
> >> --
> >> MST
> >>
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

