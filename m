Return-Path: <virtio-dev-return-12429-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69BA8C77B60
	for <virtio-dev@archiver.kernel.org>; Wed, 26 Apr 2023 09:33:38 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 8EAF029FD1
	for <virtio-dev@archiver.kernel.org>; Wed, 26 Apr 2023 09:33:37 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7D48E986650
	for <virtio-dev@archiver.kernel.org>; Wed, 26 Apr 2023 09:33:37 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 709FE98663F; Wed, 26 Apr 2023 09:33:37 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5BEC998663C;
	Wed, 26 Apr 2023 09:33:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R941e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0Vh2lPgm_1682501607;
Message-ID: <1682501373.3154237-2-xuanzhuo@linux.alibaba.com>
Date: Wed, 26 Apr 2023 17:29:33 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 parav@nvidia.com,
 virtio-dev@lists.oasis-open.org,
 "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
 "helei.sig11@bytedance.com" <helei.sig11@bytedance.com>,
 houp@yusur.tech,
 zhenwei pi <pizhenwei@bytedance.com>
References: <1ab0beff-8b18-7a94-1a68-6bf36bcd0394@bytedance.com>
 <CACGkMEvh+G2Tm=WDTOK3K2GO8c2dQ4y=UiKAk_kvsid2MGzbGg@mail.gmail.com>
 <8f65c9aa-c867-0929-151c-21bbe25a0693@bytedance.com>
 <CACGkMEu9Tzrj+9CUzWOeGhRK-qONHk6cf+2RTTJtxtcKFB8cqw@mail.gmail.com>
In-Reply-To: <CACGkMEu9Tzrj+9CUzWOeGhRK-qONHk6cf+2RTTJtxtcKFB8cqw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [virtio-dev] Re: Re: [virtio-comment] [PROPOSAL] Virtio Over Fabrics(TCP/RDMA)

On Tue, 25 Apr 2023 14:36:04 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Mon, Apr 24, 2023 at 9:38=E2=80=AFPM zhenwei pi <pizhenwei@bytedance.c=
om> wrote:
> >
> >
> >
> > On 4/24/23 11:40, Jason Wang wrote:
> > > On Sun, Apr 23, 2023 at 7:31=E2=80=AFPM zhenwei pi <pizhenwei@bytedan=
ce.com> wrote:
> > >>
> > >> Hi,
> > >>
> > >> In the past years, virtio supports lots of device specifications by
> > >> PCI/MMIO/CCW. These devices work fine in the virtualization environm=
ent,
> > >> and we have a chance to support virtio device family for the
> > >> container/host scenario.
> > >
> > > PCI can work for containers for sure (or does it meet any issue like
> > > scalability?). It's better to describe what problems you met and why
> > > you choose this way to solve it.
> > >
> > > It's better to compare this with
> > >
> > > 1) hiding the fabrics details via DPU
> > > 2) vDPA
> > >
> > Hi,
> >
> > Sorry, I missed this part. "Network defined peripheral devices of virtio
> > family" is the main purpose of this proposal,
>
> This can be achieved by either DPU or vDPA.

I agree this.

So I didn't understand what the meaning of this realization. Although I am =
also
very excited to this idea, this broaden the possibility of virtio. But, I s=
till
really want to know what the meaning of this idea is, better performance? Or
can achieve some situations that we cannot achieved now.

> I think the advantages is,
> if we standardize this in the spec, it avoids vendor specific
> protocol.


Sorry, I dont got this.

Thanks.

>
> > this allows us to use many
> > types of remote resources which are provided by virtio target.
> >
> >  From the point of my view, there are 3 cases:
> > 1, Host/container scenario. For example, host kernel connects a virtio
> > target block service, maps it as a vdx(virtio-blk) device(used by
> > Map-Reduce service which needs a fast/large size disk). The host kernel
> > also connects a virtio target crypto service, maps it as virtio crypto
> > device(used by nginx to accelarate HTTPS). And so on.
> >
> >          +----------+    +----------+       +----------+
> >          |Map-Reduce|    |   nginx  |  ...  | processes|
> >          +----------+    +----------+       +----------+
> > ------------------------------------------------------------
> > Host         |               |                  |
> > Kernel   +-------+       +-------+          +-------+
> >           | ext4  |       | LKCF  |          | HWRNG |
> >           +-------+       +-------+          +-------+
> >               |               |                  |
> >           +-------+       +-------+          +-------+
> >           |  vdx  |       |vCrypto|          | vRNG  |
> >           +-------+       +-------+          +-------+
> >               |               |                  |
> >               |           +--------+             |
> >               +---------->|TCP/RDMA|<------------+
> >                           +--------+
> >                               |
> >                           +------+
> >                           |NIC/IB|
> >                           +------+
> >                               |                      +-------------+
> >                               +--------------------->|virtio target|
> >                                                      +-------------+
> >
> > 2, Typical virtualization environment. The workloads run in a guest, and
> > QEMU handles virtio-pci(or MMIO), and forwards requests to target.
> >          +----------+    +----------+       +----------+
> >          |Map-Reduce|    |   nginx  |  ...  | processes|
> >          +----------+    +----------+       +----------+
> > ------------------------------------------------------------
> > Guest        |               |                  |
> > Kernel   +-------+       +-------+          +-------+
> >           | ext4  |       | LKCF  |          | HWRNG |
> >           +-------+       +-------+          +-------+
> >               |               |                  |
> >           +-------+       +-------+          +-------+
> >           |  vdx  |       |vCrypto|          | vRNG  |
> >           +-------+       +-------+          +-------+
> >               |               |                  |
> > PCI --------------------------------------------------------
> >                               |
> > QEMU                 +--------------+
> >                       |virtio backend|
> >                       +--------------+
> >                               |
> >                           +------+
> >                           |NIC/IB|
> >                           +------+
> >                               |                      +-------------+
> >                               +--------------------->|virtio target|
> >                                                      +-------------+
> >
>
> So it's the job of the Qemu to do the translation from virtqueue to packe=
t here?
>
> > 3, SmartNIC/DPU/vDPA environment. It's possible to convert virtio-pci
> > request to virtio-of request by hardware, and forward request to virtio
> > target directly.
> >          +----------+    +----------+       +----------+
> >          |Map-Reduce|    |   nginx  |  ...  | processes|
> >          +----------+    +----------+       +----------+
> > ------------------------------------------------------------
> > Host         |               |                  |
> > Kernel   +-------+       +-------+          +-------+
> >           | ext4  |       | LKCF  |          | HWRNG |
> >           +-------+       +-------+          +-------+
> >               |               |                  |
> >           +-------+       +-------+          +-------+
> >           |  vdx  |       |vCrypto|          | vRNG  |
> >           +-------+       +-------+          +-------+
> >               |               |                  |
> > PCI --------------------------------------------------------
> >                               |
> > SmartNIC             +---------------+
> >                       |virtio HW queue|
> >                       +---------------+
> >                               |
> >                           +------+
> >                           |NIC/IB|
> >                           +------+
> >                               |                      +-------------+
> >                               +--------------------->|virtio target|
> >                                                      +-------------+
> >
> > >>
> > >> - Theory
> > >> "Virtio Over Fabrics" aims at "reuse virtio device specifications", =
and
> > >> provides network defined peripheral devices.
> > >> And this protocol also could be used in virtualization environment,
> > >> typically hypervisor(or vhost-user process) handles request from vir=
tio
> > >> PCI/MMIO/CCW, remaps request and forwards to target by fabrics.
> > >
> > > This requires meditation in the datapath, isn't it?
> > >
> > >>
> > >> - Protocol
> > >> The detail protocol definition see:
> > >> https://github.com/pizhenwei/linux/blob/virtio-of-github/include/uap=
i/linux/virtio_of.h
> > >
> > > I'd say a RFC patch for virtio spec is more suitable than the codes.
> > >
> >
> > OK. I'll send a RFC patch for virtio spec later if this proposal is
> > acceptable.
>
> Well, I think we need to have an RFC first to know if it is acceptable or=
 not.
>
> >
> > [...]
> >
> > >
> > > A quick glance at the code told me it's a mediation layer that convert
> > > descriptors in the vring to the fabric specific packet. This is the
> > > vDPA way.
> > >
> > > If we agree virtio of fabic is useful, we need invent facilities to
> > > allow building packet directly without bothering the virtqueue (the
> > > API is layout independent anyhow).
> > >
> > > Thanks
> > >
> >
> > This code describes the case 1[Host/container scenario], also proves
> > this case works.
> > Create a virtqueue in the virtio fabric module, also emulate a
> > "virtqueue backend" here, when uplayer kicks vring, the "backend" gets
> > notified and builds packet to TCP/RDMA.
>
> In this case, it won't perform good. Since it still use virtqueue
> which is unnecessary in the datapath for fabric.
>
> Thanks
>
> >
> > [...]
> >
> > --
> > zhenwei pi
> >
>
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

