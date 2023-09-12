Return-Path: <virtio-dev-return-13684-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9452CA0EC3
	for <virtio-dev@archiver.kernel.org>; Tue, 12 Sep 2023 04:10:43 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 13B922A8E1
	for <virtio-dev@archiver.kernel.org>; Tue, 12 Sep 2023 04:10:43 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E03809864A8
	for <virtio-dev@archiver.kernel.org>; Tue, 12 Sep 2023 04:10:42 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id C6D9E9843C1; Tue, 12 Sep 2023 04:10:42 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B67BF986485
	for <virtio-dev@lists.oasis-open.org>; Tue, 12 Sep 2023 04:10:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 4964Ap8VPTuIyGAv3KiRbQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694491838; x=1695096638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wq8Hc0alkbdHW3+INYdNnvFkAqGCe1aKNNsQgH6vSYc=;
        b=hWirr5Kt56fQb1QPCsnFhEDhJOE/so3RVxoct6wrIrOA2iG0J8624e1VJozQyOuC2n
         PxQtsAaK+MAET4RmNoceQYFgxXW0p9N4Q5Eocso6EIzlnjKJXigFOOjWyYydZqw5eswI
         QUOMSoC7yDVkLXxmhnJRRLpqv2AFud97uy9v6EbsDJt1wEv5wtvX9L/Or8aNyxCpJsjs
         5MWTR0MI7X+2NHTM5WNoA8kczKOuza5wVagAvxiw0t9Nla6D3XSGuxkv5m8rma3IHBzZ
         i8dSpfa6dFzqctxfccRg+b7xJcQHSVTzXPy51xZwbOlNchdcF+yPW42QJPT/3+P6VepR
         eLXg==
X-Gm-Message-State: AOJu0Yz23CFQwZHA9Y5e3tnwNZr4eGC7cR2pNCvsTy2mPraJU1PG6tkL
	3CF4OTznK5lAIrc4fI1z5Ykc2/vZF/K9JBlZHuw8DigOwEIt0URFcha1K9C9QPOA3xlxkUYouHt
	VqsupBKDgdqdOuHMp06lqzCVseBy0w+RtNbWITyJCZShQ
X-Received: by 2002:a05:6512:3482:b0:502:d35b:5058 with SMTP id v2-20020a056512348200b00502d35b5058mr167889lfr.4.1694491838306;
        Mon, 11 Sep 2023 21:10:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFi0y558CFQn08AYHp35OrhyJ4TKMg34EVB8hoibWZ9Fv3P03Fkzzf/nVTa5cMddnO2B/v2YEhqexgTuoeMQjM=
X-Received: by 2002:a05:6512:3482:b0:502:d35b:5058 with SMTP id
 v2-20020a056512348200b00502d35b5058mr167879lfr.4.1694491838019; Mon, 11 Sep
 2023 21:10:38 -0700 (PDT)
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
In-Reply-To: <PH0PR12MB5481D11A7DF45292103D9290DCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 12 Sep 2023 12:10:26 +0800
Message-ID: <CACGkMEt6=AC4pYEoxNn2dpbLLEKTLj-SYV2eSUAi1ZA1LWR3qg@mail.gmail.com>
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

>
> > Why this series can not support nested?
> I don=E2=80=99t see all the aspects that I covered in series [1] ranging =
from flr, device context migration, virtio level reset, dirty page tracking=
, p2p support, etc. covered in some device, vq suspend resume piece.
>
> [1] https://lists.oasis-open.org/archives/virtio-comment/202309/msg00061.=
html

The series works for stateless devices. Before we introduce device
states in the spec, we can't migrate stateful devices. So the device
context doesn't make much sense right now.

Dirty page tracking in virtio is not a must for live migration to
work. It can be done via platform facilities or even software. And to
make it more efficient, it needs to utilize transport facilities
instead of a general one.

The FLR, P2P demonstrates the fragility of a simple passthrough method
and how it conflicts with live migration and complicates the device
implementation. And it means you need to audit all PCI features and do
workaround if there're any possible issues (or using a whitelist).
This is tricky and we are migrating virtio not virtio-pci. If we don't
use simple passthrough we don't need to care about this.

Since the functionality proposed in this series focus on the minimal
set of the functionality for migration, it is virtio specific and self
contained so nothing special is required to work in the nest.

Thanks

>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

