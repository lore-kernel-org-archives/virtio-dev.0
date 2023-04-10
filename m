Return-Path: <virtio-dev-return-12070-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA238C77B6E
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Apr 2023 01:23:19 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id E4EBB2B027
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Apr 2023 01:23:18 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BA7A898638E
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Apr 2023 01:23:18 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 976A39843C6; Mon, 10 Apr 2023 01:23:18 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 80BAF986319
	for <virtio-dev@lists.oasis-open.org>; Mon, 10 Apr 2023 01:23:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: wJADfeSfPrKf_ZIujBTCpA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681089795; x=1683681795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Eu1pndOYzQe5VDeRbdOwXgapHf0wOtC7QTMr5cDdq8=;
        b=Yh6oyqZStrSHPFYqqfdtZkWtH1h5TfA96AksaLHqX5XH722PXRSt8I5BSau60lSVHm
         diN1i8GwBqXucW2tplvpuMMfp7C7V3HyImz1F0NXGx9asOYonwTqBCDMnGlcrYb3iSJh
         4LUWrkgP16ujvkfMr9f9b7kexT+E3SZgFvbcVJemoAvdj3D5pkkR/sCtfmpL5KI1N5rq
         9LvGMe4rOWnJg6Wd57UlNQ+86hIjW145fivw3Fv7LHzatR4+L4aMhsG98XIDry8mm+ld
         9xzpt258IPAG2ZGOpJmnkXRUSRS0tUTm2JPDvjdwzdh+Y+IxHLZVIu7ZlzSqDM/wpubz
         mG2g==
X-Gm-Message-State: AAQBX9d6C2OcvkzUjI9XVhBCaJfk0gR7O1w4VOU+TUNAhcb98BFYWBng
	Nfumv/RhCbx6PgIeu98lyaUxQpJzprrfelBssDZDLi1ngcOoFeZl00M5CSX/za9VNgxSoHKpKYJ
	qiIMwm7bLFfzM/unLpnY8UMLsO1MhQM2IRCMijijWx9qL
X-Received: by 2002:a05:6870:5627:b0:184:c14:a685 with SMTP id m39-20020a056870562700b001840c14a685mr2745336oao.9.1681089795497;
        Sun, 09 Apr 2023 18:23:15 -0700 (PDT)
X-Google-Smtp-Source: AKy350Yw3fyMc7uTSMfav4F+sPt3XO+LghfthTiihQuRRzVgygzVhZINAhO7isVvy5Duq7beTD21ING09g4R+EnfRlc=
X-Received: by 2002:a05:6870:5627:b0:184:c14:a685 with SMTP id
 m39-20020a056870562700b001840c14a685mr2745321oao.9.1681089795195; Sun, 09 Apr
 2023 18:23:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230209033056.96657-1-xuanzhuo@linux.alibaba.com>
 <20230209033056.96657-2-xuanzhuo@linux.alibaba.com> <20230323154656.7f036d52.pasic@linux.ibm.com>
 <ff9b28a1-e0ee-f082-1f40-f3e149c9403e@linux.alibaba.com> <7a9ebec0-5e87-b80f-4f2c-c4db7ae4fe84@linux.ibm.com>
 <20230405084632-mutt-send-email-mst@kernel.org> <1680837735.392044-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1680837735.392044-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 10 Apr 2023 09:23:04 +0800
Message-ID: <CACGkMEv=7FyVZme6HBRxy6U9+7ehiwUTc9=z7PHt6R7ZER7EPg@mail.gmail.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Wen Gu <guwen@linux.alibaba.com>, 
	Halil Pasic <pasic@linux.ibm.com>, virtio-comment@lists.oasis-open.org, 
	hans@linux.alibaba.com, herongguang@linux.alibaba.com, 
	zmlcc@linux.alibaba.com, dust.li@linux.alibaba.com, tonylu@linux.alibaba.com, 
	zhenzao@linux.alibaba.com, helinguo@linux.alibaba.com, 
	gerry@linux.alibaba.com, cohuck@redhat.com, 
	Jan Kiszka <jan.kiszka@siemens.com>, kgraul@linux.ibm.com, wenjia@linux.ibm.com, 
	jaka@linux.ibm.com, hca@linux.ibm.com, twinkler@linux.ibm.com, 
	raspl@linux.ibm.com, virtio-dev@lists.oasis-open.org, 
	Alexandra Winter <wintera@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [virtio-comment] Re: [virtio-dev] Re: [virtio-comment] [PATCH v3
 1/1] virtio-ism: introduce new device virtio-ism

On Fri, Apr 7, 2023 at 11:24=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Wed, 5 Apr 2023 08:52:14 -0400, "Michael S. Tsirkin" <mst@redhat.com> =
wrote:
> > On Wed, Apr 05, 2023 at 02:39:53PM +0200, Alexandra Winter wrote:
> > >
> > >
> > > On 24.03.23 05:03, Wen Gu wrote:
> > > >
> > > >
> > > > On 2023/3/23 22:46, Halil Pasic wrote:
> > > >
> > > >> On Thu,  9 Feb 2023 11:30:56 +0800
> > > >> Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> > > >>
> > >
> > > ...
> > >
> > > >
> > > >> To get back to the things proposed here: the cdid is IMHO
> > > >> a nice thing, and is functionally corresponding to the
> > > >> (S)EID. But it is 16 byte wide, and I have no idea how
> > > >> is it supposed to be used in the CLC handshake.
> > > >>
> > > >
> > > > CLC handshake carry one SEID for all the SMC-D device. Considering
> > > > coexistence with ISM, I am not sure whether we can change or increa=
se
> > > > the SEID.. cc Alexandra
> > > >
> > > > Thanks!
> > > > Wen Gu
> > >
> > > As mentioned by others, discussions are ongoing.
> > > It would be great, if we can agree on a way to use the existing CLC h=
andshake
> > > for SMC-D via virtio-ism and ism-loopback.
> > > In that case SEID needs to be unique per hardware instance, cannot be=
 increased and
> > > can only be changed for x86 in a non-colliding way.
> > >
> > > An alternative would be to define new a SMC-D(?) protocol variant/ver=
sion, where we
> > > are free to define new fields (e.g. UUIDs).
> > >
> > > Alexandra
> >
> > Problem with tying to hardware is that it is blocking
> > migration (which is a challenge with ism anyway, but still).
>
>
> We don't want to support migration. At least we don't want to support it =
for the
> time being. Because there are indeed many problems. I think Migration is =
not
> necessary for a new Virtio device.

We'd really need to take migration into consideration when developing
new devices. It is not guaranteed that this device is backed by local
RAMs. At least we should avoid designs that may complicate future
migration support.

Thanks

>
> Thanks.
>
>
> >
> >
> > > >
> > > >> If this is really supposed to work with SMC and not just take
> > > >> inspiration from it, I would like some insight from our
> > > >> SMC experts (they are already on copy).
> > > >>
> > > >> Regards,
> > > >> Halil
> > > >>
> > > >> ------------------------------------------------------------------=
---
> > > >> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.or=
g
> > > >> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.=
org
> >
> >
> > ---------------------------------------------------------------------
> > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> >
>
> This publicly archived list offers a means to provide input to the
> OASIS Virtual I/O Device (VIRTIO) TC.
>
> In order to verify user consent to the Feedback License terms and
> to minimize spam in the list archive, subscription is required
> before posting.
>
> Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> List help: virtio-comment-help@lists.oasis-open.org
> List archive: https://lists.oasis-open.org/archives/virtio-comment/
> Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
> List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-l=
ists
> Committee: https://www.oasis-open.org/committees/virtio/
> Join OASIS: https://www.oasis-open.org/join/
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

