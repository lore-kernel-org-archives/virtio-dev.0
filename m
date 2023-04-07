Return-Path: <virtio-dev-return-12049-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 289F2C761A6
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Apr 2023 03:24:07 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id E262B33593
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Apr 2023 03:24:04 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C9BE99865E1
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Apr 2023 03:24:04 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id B406F986371; Fri,  7 Apr 2023 03:24:04 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9C3C09865D7;
	Fri,  7 Apr 2023 03:24:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0VfV9FLc_1680837834;
Message-ID: <1680837735.392044-2-xuanzhuo@linux.alibaba.com>
Date: Fri, 7 Apr 2023 11:22:15 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Wen Gu <guwen@linux.alibaba.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 virtio-comment@lists.oasis-open.org,
 hans@linux.alibaba.com,
 herongguang@linux.alibaba.com,
 zmlcc@linux.alibaba.com,
 dust.li@linux.alibaba.com,
 tonylu@linux.alibaba.com,
 zhenzao@linux.alibaba.com,
 helinguo@linux.alibaba.com,
 gerry@linux.alibaba.com,
 cohuck@redhat.com,
 jasowang@redhat.com,
 Jan Kiszka <jan.kiszka@siemens.com>,
 kgraul@linux.ibm.com,
 wenjia@linux.ibm.com,
 jaka@linux.ibm.com,
 hca@linux.ibm.com,
 twinkler@linux.ibm.com,
 raspl@linux.ibm.com,
 virtio-dev@lists.oasis-open.org,
 Alexandra Winter <wintera@linux.ibm.com>
References: <20230209033056.96657-1-xuanzhuo@linux.alibaba.com>
 <20230209033056.96657-2-xuanzhuo@linux.alibaba.com>
 <20230323154656.7f036d52.pasic@linux.ibm.com>
 <ff9b28a1-e0ee-f082-1f40-f3e149c9403e@linux.alibaba.com>
 <7a9ebec0-5e87-b80f-4f2c-c4db7ae4fe84@linux.ibm.com>
 <20230405084632-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230405084632-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [virtio-dev] Re: [virtio-comment] [PATCH v3 1/1] virtio-ism: introduce new device virtio-ism

On Wed, 5 Apr 2023 08:52:14 -0400, "Michael S. Tsirkin" <mst@redhat.com> wr=
ote:
> On Wed, Apr 05, 2023 at 02:39:53PM +0200, Alexandra Winter wrote:
> >
> >
> > On 24.03.23 05:03, Wen Gu wrote:
> > >
> > >
> > > On 2023/3/23 22:46, Halil Pasic wrote:
> > >
> > >> On Thu,=C2=A0 9 Feb 2023 11:30:56 +0800
> > >> Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> > >>
> >
> > ...
> >
> > >
> > >> To get back to the things proposed here: the cdid is IMHO
> > >> a nice thing, and is functionally corresponding to the
> > >> (S)EID. But it is 16 byte wide, and I have no idea how
> > >> is it supposed to be used in the CLC handshake.
> > >>
> > >
> > > CLC handshake carry one SEID for all the SMC-D device. Considering
> > > coexistence with ISM, I am not sure whether we can change or increase
> > > the SEID.. cc Alexandra
> > >
> > > Thanks!
> > > Wen Gu
> >
> > As mentioned by others, discussions are ongoing.
> > It would be great, if we can agree on a way to use the existing CLC han=
dshake
> > for SMC-D via virtio-ism and ism-loopback.
> > In that case SEID needs to be unique per hardware instance, cannot be i=
ncreased and
> > can only be changed for x86 in a non-colliding way.
> >
> > An alternative would be to define new a SMC-D(?) protocol variant/versi=
on, where we
> > are free to define new fields (e.g. UUIDs).
> >
> > Alexandra
>
> Problem with tying to hardware is that it is blocking
> migration (which is a challenge with ism anyway, but still).


We don't want to support migration. At least we don't want to support it fo=
r the
time being. Because there are indeed many problems. I think Migration is not
necessary for a new Virtio device.

Thanks.


>
>
> > >
> > >> If this is really supposed to work with SMC and not just take
> > >> inspiration from it, I would like some insight from our
> > >> SMC experts (they are already on copy).
> > >>
> > >> Regards,
> > >> Halil
> > >>
> > >> ---------------------------------------------------------------------
> > >> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > >> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

