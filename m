Return-Path: <virtio-dev-return-12399-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82038C77B61
	for <virtio-dev@archiver.kernel.org>; Tue, 25 Apr 2023 06:36:21 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id B83F842B68
	for <virtio-dev@archiver.kernel.org>; Tue, 25 Apr 2023 06:36:20 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 97DE498643F
	for <virtio-dev@archiver.kernel.org>; Tue, 25 Apr 2023 06:36:20 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 814B7983FEA; Tue, 25 Apr 2023 06:36:20 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6E9F79863E1
	for <virtio-dev@lists.oasis-open.org>; Tue, 25 Apr 2023 06:36:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: U3mZmsmtN9Cf1-0ICYx10A-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682404576; x=1684996576;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xSErFDXGO1fF4vUHmxtdPG926CYXboj6VViKPDf4EJM=;
        b=JIF7CxDZyByjqrc4jkGx7ndY9DqJLGlAV6KqXhyCf7Ey53T5gx7i1aLavuaLNUNtly
         tRjCefHyTKjOPf+cZfF/C5zmTULrQDWF2vj6ZYlqYlVMsZZBnI8c3QUy4g5ing0dNXzO
         MTspYPcAbTT4i4VkE/3IqVRSF092M4vQZWAYtXxWvshHBTkrcyySXk1YZht/6D+unk38
         WcaYnbfHg5r710XXCv3Yft9heBK1sgfeaWAJ7HwjzwjE7WqEH4pFVCnI/g2IVK4KzeA/
         rFJOXuRjvVrw8oo2INVvwz5gfb4VaLG/eQEUb6KKFf4wwctfMoB82DnBvqKvN2JkyGGK
         WWsA==
X-Gm-Message-State: AAQBX9feFaIjFiqFjDbibJ9AP8z3f45PvAo5Wo2v5L03uV/bODLTDMVa
	ToRfYmp+JuUto+B19Yhyrx0g0iv3bDYPORnAzC9qDskxOtrE8Jg1P5mmdqOEPA3rhJmo2B6q5R5
	x0lfMtYBpFOa1vyM50jqQ1HVq0GinETn41fpwy3hZZUtk
X-Received: by 2002:a2e:9196:0:b0:2a7:6e3e:c8bc with SMTP id f22-20020a2e9196000000b002a76e3ec8bcmr3195499ljg.27.1682404576741;
        Mon, 24 Apr 2023 23:36:16 -0700 (PDT)
X-Google-Smtp-Source: AKy350b0P2gEg0MyD3KN3nORSrzpjkoeaUnNjJAazOu3G0fukVe7XcuE29Tlu+fsGPHWtcG68NOf1Su3tkQjFhV/Hvk=
X-Received: by 2002:a2e:9196:0:b0:2a7:6e3e:c8bc with SMTP id
 f22-20020a2e9196000000b002a76e3ec8bcmr3195490ljg.27.1682404576399; Mon, 24
 Apr 2023 23:36:16 -0700 (PDT)
MIME-Version: 1.0
References: <1ab0beff-8b18-7a94-1a68-6bf36bcd0394@bytedance.com>
 <CACGkMEvh+G2Tm=WDTOK3K2GO8c2dQ4y=UiKAk_kvsid2MGzbGg@mail.gmail.com> <8f65c9aa-c867-0929-151c-21bbe25a0693@bytedance.com>
In-Reply-To: <8f65c9aa-c867-0929-151c-21bbe25a0693@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 25 Apr 2023 14:36:04 +0800
Message-ID: <CACGkMEu9Tzrj+9CUzWOeGhRK-qONHk6cf+2RTTJtxtcKFB8cqw@mail.gmail.com>
To: zhenwei pi <pizhenwei@bytedance.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, parav@nvidia.com, 
	virtio-dev@lists.oasis-open.org, 
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, 
	"helei.sig11@bytedance.com" <helei.sig11@bytedance.com>, houp@yusur.tech
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: Re: [virtio-comment] [PROPOSAL] Virtio Over Fabrics(TCP/RDMA)

On Mon, Apr 24, 2023 at 9:38=E2=80=AFPM zhenwei pi <pizhenwei@bytedance.com=
> wrote:
>
>
>
> On 4/24/23 11:40, Jason Wang wrote:
> > On Sun, Apr 23, 2023 at 7:31=E2=80=AFPM zhenwei pi <pizhenwei@bytedance=
.com> wrote:
> >>
> >> Hi,
> >>
> >> In the past years, virtio supports lots of device specifications by
> >> PCI/MMIO/CCW. These devices work fine in the virtualization environmen=
t,
> >> and we have a chance to support virtio device family for the
> >> container/host scenario.
> >
> > PCI can work for containers for sure (or does it meet any issue like
> > scalability?). It's better to describe what problems you met and why
> > you choose this way to solve it.
> >
> > It's better to compare this with
> >
> > 1) hiding the fabrics details via DPU
> > 2) vDPA
> >
> Hi,
>
> Sorry, I missed this part. "Network defined peripheral devices of virtio
> family" is the main purpose of this proposal,

This can be achieved by either DPU or vDPA. I think the advantages is,
if we standardize this in the spec, it avoids vendor specific
protocol.

> this allows us to use many
> types of remote resources which are provided by virtio target.
>
>  From the point of my view, there are 3 cases:
> 1, Host/container scenario. For example, host kernel connects a virtio
> target block service, maps it as a vdx(virtio-blk) device(used by
> Map-Reduce service which needs a fast/large size disk). The host kernel
> also connects a virtio target crypto service, maps it as virtio crypto
> device(used by nginx to accelarate HTTPS). And so on.
>
>          +----------+    +----------+       +----------+
>          |Map-Reduce|    |   nginx  |  ...  | processes|
>          +----------+    +----------+       +----------+
> ------------------------------------------------------------
> Host         |               |                  |
> Kernel   +-------+       +-------+          +-------+
>           | ext4  |       | LKCF  |          | HWRNG |
>           +-------+       +-------+          +-------+
>               |               |                  |
>           +-------+       +-------+          +-------+
>           |  vdx  |       |vCrypto|          | vRNG  |
>           +-------+       +-------+          +-------+
>               |               |                  |
>               |           +--------+             |
>               +---------->|TCP/RDMA|<------------+
>                           +--------+
>                               |
>                           +------+
>                           |NIC/IB|
>                           +------+
>                               |                      +-------------+
>                               +--------------------->|virtio target|
>                                                      +-------------+
>
> 2, Typical virtualization environment. The workloads run in a guest, and
> QEMU handles virtio-pci(or MMIO), and forwards requests to target.
>          +----------+    +----------+       +----------+
>          |Map-Reduce|    |   nginx  |  ...  | processes|
>          +----------+    +----------+       +----------+
> ------------------------------------------------------------
> Guest        |               |                  |
> Kernel   +-------+       +-------+          +-------+
>           | ext4  |       | LKCF  |          | HWRNG |
>           +-------+       +-------+          +-------+
>               |               |                  |
>           +-------+       +-------+          +-------+
>           |  vdx  |       |vCrypto|          | vRNG  |
>           +-------+       +-------+          +-------+
>               |               |                  |
> PCI --------------------------------------------------------
>                               |
> QEMU                 +--------------+
>                       |virtio backend|
>                       +--------------+
>                               |
>                           +------+
>                           |NIC/IB|
>                           +------+
>                               |                      +-------------+
>                               +--------------------->|virtio target|
>                                                      +-------------+
>

So it's the job of the Qemu to do the translation from virtqueue to packet =
here?

> 3, SmartNIC/DPU/vDPA environment. It's possible to convert virtio-pci
> request to virtio-of request by hardware, and forward request to virtio
> target directly.
>          +----------+    +----------+       +----------+
>          |Map-Reduce|    |   nginx  |  ...  | processes|
>          +----------+    +----------+       +----------+
> ------------------------------------------------------------
> Host         |               |                  |
> Kernel   +-------+       +-------+          +-------+
>           | ext4  |       | LKCF  |          | HWRNG |
>           +-------+       +-------+          +-------+
>               |               |                  |
>           +-------+       +-------+          +-------+
>           |  vdx  |       |vCrypto|          | vRNG  |
>           +-------+       +-------+          +-------+
>               |               |                  |
> PCI --------------------------------------------------------
>                               |
> SmartNIC             +---------------+
>                       |virtio HW queue|
>                       +---------------+
>                               |
>                           +------+
>                           |NIC/IB|
>                           +------+
>                               |                      +-------------+
>                               +--------------------->|virtio target|
>                                                      +-------------+
>
> >>
> >> - Theory
> >> "Virtio Over Fabrics" aims at "reuse virtio device specifications", an=
d
> >> provides network defined peripheral devices.
> >> And this protocol also could be used in virtualization environment,
> >> typically hypervisor(or vhost-user process) handles request from virti=
o
> >> PCI/MMIO/CCW, remaps request and forwards to target by fabrics.
> >
> > This requires meditation in the datapath, isn't it?
> >
> >>
> >> - Protocol
> >> The detail protocol definition see:
> >> https://github.com/pizhenwei/linux/blob/virtio-of-github/include/uapi/=
linux/virtio_of.h
> >
> > I'd say a RFC patch for virtio spec is more suitable than the codes.
> >
>
> OK. I'll send a RFC patch for virtio spec later if this proposal is
> acceptable.

Well, I think we need to have an RFC first to know if it is acceptable or n=
ot.

>
> [...]
>
> >
> > A quick glance at the code told me it's a mediation layer that convert
> > descriptors in the vring to the fabric specific packet. This is the
> > vDPA way.
> >
> > If we agree virtio of fabic is useful, we need invent facilities to
> > allow building packet directly without bothering the virtqueue (the
> > API is layout independent anyhow).
> >
> > Thanks
> >
>
> This code describes the case 1[Host/container scenario], also proves
> this case works.
> Create a virtqueue in the virtio fabric module, also emulate a
> "virtqueue backend" here, when uplayer kicks vring, the "backend" gets
> notified and builds packet to TCP/RDMA.

In this case, it won't perform good. Since it still use virtqueue
which is unnecessary in the datapath for fabric.

Thanks

>
> [...]
>
> --
> zhenwei pi
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

