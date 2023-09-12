Return-Path: <virtio-dev-return-13681-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 747E7CA0ECF
	for <virtio-dev@archiver.kernel.org>; Tue, 12 Sep 2023 03:44:05 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id E219D79509
	for <virtio-dev@archiver.kernel.org>; Tue, 12 Sep 2023 03:44:04 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D286F9865B7
	for <virtio-dev@archiver.kernel.org>; Tue, 12 Sep 2023 03:44:04 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id C2EFB9843C1; Tue, 12 Sep 2023 03:44:04 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B1D0898648C
	for <virtio-dev@lists.oasis-open.org>; Tue, 12 Sep 2023 03:44:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: T4x17P_EPAe7QMpMThZU-w-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694490241; x=1695095041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c0OO+nwsyzoy2ApNTU+Vnha5kkoOZIi/zBoroAVLuBU=;
        b=ZWOQYZ1+XadqPb/UpsTpQe4Bm3iXfMJSsH4x0YC2IfWDvjVW4+LFATKH43gMU3aXHy
         OkEiOw4HyHTdh865kbhpWqsKayFyjhxTiNp2Ixh8C+CN4g23gdrR4NfkFCsfVm3N6PRx
         +1UkjSP2pVhtnSSr2uFucVj2+fFruTut948Ew1xZ32aJeHI62vuiXh9QOTxxgB2Pnfxm
         PefSJVJvHEzbAigv3cqVVlbQZlQ/YQT21sJUFqBy6NMjVbccKStXfwhlyxR1PlOtc5vy
         bj6IbC4DA2DnzJIruKkUoC/aivi5fSHZJ2iyuwNQok0B79rFDACn+xq3VozKyKxkqNNy
         GbxA==
X-Gm-Message-State: AOJu0YxGoMxWhyQw2j+bXRgYLPU7z0qtsMBpS1slj41ZsAEeBP6rrXv6
	cptiaD/5jgLuul0q9FNo6dYPlyF0DUCZjRCCtFzLgqEITgYcrzuYR3gQmSdAifAjr1sZAXlXb89
	jPN7liNfvJQNNbpyIbrRuee5ZPn50dIQjxAD9KSBkUK0Q
X-Received: by 2002:a05:6512:250b:b0:500:b515:906d with SMTP id be11-20020a056512250b00b00500b515906dmr9443720lfb.61.1694490241046;
        Mon, 11 Sep 2023 20:44:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNDy+R8e0qLrpaTt57tU8he2MtV4WMoaI8Qi4I8Nu5StLKX+uQMeNTqwm9/9URxlzcNaaKNYCkth+vbz/m4bE=
X-Received: by 2002:a05:6512:250b:b0:500:b515:906d with SMTP id
 be11-20020a056512250b00b00500b515906dmr9443701lfb.61.1694490240660; Mon, 11
 Sep 2023 20:44:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230906081637.32185-1-lingshan.zhu@intel.com>
 <20230906081637.32185-6-lingshan.zhu@intel.com> <20230906043016-mutt-send-email-mst@kernel.org>
 <CACGkMEu4R_nUFmpoNesmjJ-PtoE5brpWh8NLruWhEWycm2K4yg@mail.gmail.com>
 <PH0PR12MB5481A50B1B13CE1756B98D0DDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEtMmwWGJDYe5BLvLCcetThv-yfPR2QbphNuuh+bp-+ikg@mail.gmail.com>
 <PH0PR12MB5481ED8DC23DC6D42665FB8EDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <eb6c350e-1198-7d83-a553-99c9c8c21edc@intel.com> <PH0PR12MB5481760E00AD18DB8BF91636DCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <ad1dd3a6-7c11-5c6b-b50f-d608ec027dcd@intel.com> <PH0PR12MB54819C4A4220712DCD57AD56DCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <fff7720f-6019-bd87-b14b-c0bf996f3959@intel.com> <PH0PR12MB5481D11A7DF45292103D9290DCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <88b8b14c-88d8-1f76-0e6e-7b5f334171f1@intel.com> <PH0PR12MB5481CBE0CDFF4ACD712F371CDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <2b3e8da1-5cbb-f990-0c1d-c0e894a73486@intel.com> <PH0PR12MB5481E8114A659954251F17DCDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB5481E8114A659954251F17DCDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 12 Sep 2023 11:43:49 +0800
Message-ID: <CACGkMEtAe3j+A=gNEOJiZF8rcJnT-zw7Xg67LLM92FZCm0XqyQ@mail.gmail.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "Zhu, Lingshan" <lingshan.zhu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	"eperezma@redhat.com" <eperezma@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>, 
	"stefanha@redhat.com" <stefanha@redhat.com>, 
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, 
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [virtio-comment] [PATCH 5/5] virtio-pci: implement VIRTIO_F_QUEUE_STATE

On Mon, Sep 11, 2023 at 7:50=E2=80=AFPM Parav Pandit <parav@nvidia.com> wro=
te:
>
> > From: Zhu, Lingshan <lingshan.zhu@intel.com>
> > Sent: Monday, September 11, 2023 3:03 PM
>
> > By the way, do you see anything we need to improve in this series?
>
> Admin commands for passthrough devices of [1] is comprehensive proposal c=
overing all the aspects.

What do you mean by "all the aspects"?

Of course it can't handle nesting well, passthrough doesn't work when
your hardware has N levels abstractions but nesting is M levels. Trap
and emulation is a must.

And exposing the whole device to the guest drivers will have security
implications, your proposal has demonstrated that you need a
workaround for FLR at least.

For non standard device we don't have choices other than passthrough,
but for standard devices we have other choices.

Thanks

>
> To me [1] is superset work that covers all needed functionality and downt=
ime aspects.
>
> I plan to improve [1] with v1 this week by extending device context and a=
ddressing other review comments.
>
> [1] https://lists.oasis-open.org/archives/virtio-comment/202309/msg00061.=
html


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

