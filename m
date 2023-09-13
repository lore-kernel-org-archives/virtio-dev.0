Return-Path: <virtio-dev-return-13745-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B32ECA0ED1
	for <virtio-dev@archiver.kernel.org>; Wed, 13 Sep 2023 04:56:53 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 4B2592B010
	for <virtio-dev@archiver.kernel.org>; Wed, 13 Sep 2023 04:56:53 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 31ED198663D
	for <virtio-dev@archiver.kernel.org>; Wed, 13 Sep 2023 04:56:53 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 19D4198403A; Wed, 13 Sep 2023 04:56:53 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 09D09986630
	for <virtio-dev@lists.oasis-open.org>; Wed, 13 Sep 2023 04:56:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 79RTos0ROlqhU7JRu7vhOg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694581008; x=1695185808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n8iZnsQM4rjezhDdtxX5CXayJ+/nEiFgIGjg0d1T4wo=;
        b=LVksmzp6Jw0qq+eA9ZYHGQKSU1k6E0/ixGtco4Sldof/7fhWUpyCfWBql0sz3WsI9S
         OFCvl0fcZstyyK/Xp56K/+u0UlwRGvtALU65aNdfZbLuASmXol2YQko0Gcly9F0aquYV
         ViJu59pEufM6LwqJ7GsQVZfZLztAo0r1s32BVQpSLKKfyQyK7o8KP/b4pyLU03op6wgA
         /ijg9T6tdIvTYP5Y8CKl5oWgZO7ZF64HyZWGikBk9AwTDtgrM6unpg6S2rzzVBPB5T9p
         QKYMdyNRKnz6RxBfRB8uHYilm+6dLMSWayXf4rXAXSnqAoZqr6vlX/unDTaLCVZCvPci
         8DYg==
X-Gm-Message-State: AOJu0YxjJ4kcYKZimP7kB2BIo1tmFL7mnh9t6N27uToGChfwo9QcXvWu
	0Aw6pK7FemX2jdwwYOxdvy63w79/Lu7F29YuHzdOLOv2qMLJh+PcoAkU9VanRwyBX5NfmIwVy8O
	6NYHLimg6YSI6Hf2A+lIC8MX1DsA0y9iPpiIyCWQVsghO
X-Received: by 2002:a05:6512:3e16:b0:500:863e:fc57 with SMTP id i22-20020a0565123e1600b00500863efc57mr1295436lfv.25.1694581008706;
        Tue, 12 Sep 2023 21:56:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEN7w6VPNSqk/BmWrefS6bq525txKVURdAV0DAF+4VFTSgEhMKcCwVRdFaVUXbBX/j5GDxvpX/bY04osQd7z3Q=
X-Received: by 2002:a05:6512:3e16:b0:500:863e:fc57 with SMTP id
 i22-20020a0565123e1600b00500863efc57mr1295379lfv.25.1694581005970; Tue, 12
 Sep 2023 21:56:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230906081637.32185-1-lingshan.zhu@intel.com>
 <PH0PR12MB5481ED8DC23DC6D42665FB8EDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEt9ATuU_OwtE_9rF1XHKCd9GavWCHx6_dFXCZibMKzJjA@mail.gmail.com>
 <PH0PR12MB5481D538B4F3F76B393C5757DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <7cc22be6-f984-ba53-5979-0306a118a6df@intel.com> <PH0PR12MB5481961B5EA6DEE900CCF068DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <5449424a-4872-0164-0c3f-caa34ad46388@intel.com> <PH0PR12MB5481CBCF7BEE5637D16BC179DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <4c4c2478-c90b-fb5b-cc06-bc74293862b9@intel.com> <PH0PR12MB54817178B8D5799FE74D4331DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <85b1670b-5094-cdb8-fde9-1a9c0906f094@intel.com> <PH0PR12MB54815711322F1CAC35189CEDDCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <b0ae1197-f9e9-4596-f9bf-559f6112458f@intel.com> <PH0PR12MB5481E0C8D74DD3479331E0ACDCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <7abce4d9-4762-dcad-6fdf-068588ebb3d9@intel.com> <PH0PR12MB54817F7ED583FA9A03735CBCDCF0A@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB54817F7ED583FA9A03735CBCDCF0A@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 13 Sep 2023 12:56:34 +0800
Message-ID: <CACGkMEsO4CkJvxFHJRG0bLJvj2f=De=Y1=2dGAxYLyxK2kTNqg@mail.gmail.com>
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

On Wed, Sep 13, 2023 at 12:20=E2=80=AFPM Parav Pandit <parav@nvidia.com> wr=
ote:
>
> All of this frankly seems intrusive enough as Michael pointed out.
> Good luck.
>

How do you define "intrusive"?

To me it's much less intrusive than what you've proposed.

1) It gives sufficient flexibility to implement migration via any
transport specific interface. It means your proposal could be built on
top of this but not vice versa.
2) It doesn't need to re-invent the wheels to save and load all the
existing PCI capabilities but your proposal needs to do that in order
to be self contained which turns out to be a new transport which
duplicates with the work of Ling Shan
3) It reuse the device status state machine instead of inventing a other

Only small extensions are required for device implementation to
migrate instead of coupling it with admin commands.

Thanks


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

