Return-Path: <virtio-dev-return-13812-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D417CD3437
	for <virtio-dev@archiver.kernel.org>; Tue, 19 Sep 2023 04:35:39 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 7DFAF190928
	for <virtio-dev@archiver.kernel.org>; Tue, 19 Sep 2023 04:35:37 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EF2579866FD
	for <virtio-dev@archiver.kernel.org>; Tue, 19 Sep 2023 04:35:36 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 68CDA986503; Tue, 19 Sep 2023 04:35:36 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 584F69864C2
	for <virtio-dev@lists.oasis-open.org>; Tue, 19 Sep 2023 04:34:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: Ay_ktEgpN4uDQKxVyaoocw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695098059; x=1695702859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dC1p9Eo8a7jAI8bhsFPUwHJLiUMg1rN/W4oba/2gSCA=;
        b=k5DPiZ8aJSWKIJisTRzaRy4lXaKEjHT+mVAMzMzf8FUJaOc8HQiG4Sf2+8y+B2HVf3
         EOsOCIQ6CSRZBRI3ZcepOzauBTN8uOnDTvaQY6wKs9ppjdbx+khFwiPz74vujrWqxcTK
         WyY/TkOMMJypA3qz/M+bUG/fAQk2TRdLjDxd+GDQJpIbO0tBLDe7XGOWzMWXBl58jT8B
         hw2P4pq+BxkLBt94aHCodvF9ocRGmPNMTjGgFpl5NlED9bPQtxo9hgIlZdEdvklf82ys
         w6tD43H/nnXpvYDla0M5K+2Pisq2esMpU42RtFyPBfa9S6eYwKMvn/2ZARU09SAf2Y8c
         HIaQ==
X-Gm-Message-State: AOJu0Yy6H6Az5Qhfgq6F8FZTvJgDbXUFDUpUoSgGcOhVTlGR5nr73UBj
	VSVn0vWFCPfqi4dgoWoH0RrRoAJif9xwQuBJ4yhqgI2QnTKkXACMxZvlczvsEkAXP2/5YrxCWnz
	Vk1adQx0j2d26OHBjYy3p0U+PiBwAtpKD8PtnMwq0IKlo
X-Received: by 2002:a19:7113:0:b0:500:9a45:62f with SMTP id m19-20020a197113000000b005009a45062fmr7599704lfc.8.1695098059218;
        Mon, 18 Sep 2023 21:34:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUo3AEXXQtFqlNkYfp3m/0yKVxKjHbmaZXBqMbLr06cEeXpCyFO0dfsdTFqs97PHBt1Vjoy6bJdc7GuOuJQ7g=
X-Received: by 2002:a19:7113:0:b0:500:9a45:62f with SMTP id
 m19-20020a197113000000b005009a45062fmr7599688lfc.8.1695098058837; Mon, 18 Sep
 2023 21:34:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230906081637.32185-1-lingshan.zhu@intel.com>
 <PH0PR12MB5481E8114A659954251F17DCDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <17514b93-2da4-42b3-a5bf-b96358a7a875@intel.com> <PH0PR12MB5481F236858D5CD97EF55732DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <9fabd346-9b6f-a727-3de8-813ec3570772@intel.com> <PH0PR12MB5481468378DC1E5491A5427CDCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <2baee870-bf38-5d83-0543-1d0a68f8e651@intel.com> <PH0PR12MB5481A26B62962979C19280D2DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <8bd1c228-856a-9454-752d-750997c4f4db@intel.com> <4c195683-0eb8-5e92-d97a-217cfa8af760@intel.com>
 <PH0PR12MB5481860AEAD92C74A5BC19F6DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <f132cd22-e2e1-971a-894a-d62aa7ca6334@intel.com> <PH0PR12MB5481EF64F3BA3D13C34D016EDCF0A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <2f34daa5-3db3-fd64-550d-86678acbfef4@intel.com> <PH0PR12MB5481BB050713B687EDD07FB2DCF0A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <9d9ac82e-8eb9-558e-916a-c327e3c3a996@intel.com> <PH0PR12MB54814FAE1D790492C8D660E9DCF0A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEvo1cc7jnPT1ia8=+eOcgHaOhr77ey4p+_qLwq+cCE2vw@mail.gmail.com> <PH0PR12MB5481F53C9B2FFD5FF5BD4E4ADCF4A@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB5481F53C9B2FFD5FF5BD4E4ADCF4A@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 19 Sep 2023 12:34:07 +0800
Message-ID: <CACGkMEvsLnff7shd5RS8zuRQ0rbt+HHhUBDpviQ_=JiKP1mXVQ@mail.gmail.com>
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

On Sun, Sep 17, 2023 at 1:25=E2=80=AFPM Parav Pandit <parav@nvidia.com> wro=
te:
>
>
> > From: Jason Wang <jasowang@redhat.com>
> > Sent: Thursday, September 14, 2023 8:41 AM
> >
> > On Wed, Sep 13, 2023 at 12:37=E2=80=AFPM Parav Pandit <parav@nvidia.com=
> wrote:
> > >
> > >
> > >
> > > > From: Zhu, Lingshan <lingshan.zhu@intel.com>
> > > > Sent: Wednesday, September 13, 2023 9:51 AM
> > >
> > > > we plan to implement a self-contain solution
> > > Make sure that works with device reset and FLR.
> >
> > We don't need to do that. It's out of the spec.
> >
> It is not. For the PCI member device, it needs to work reliably.

We never mentioned FLR in the PCI transport layer before and vendors
have produced tons of hardware PCI devices for several years.

If it's important, please describe it in detail in your series but it doesn=
't.

> Not doing means it relies on the trap+emulation, hence it just cannot com=
plete.
> And it is ok to me.
> I just wont claim that trap+emulation is _complete_ method.
>
> > > And if not, explain that it is for mediation mode related tricks.
> >
> > It's not the tricks and again, it's not mediation but trap and emulatio=
n. It's the
> > fundamental methodology used in virtualization, so does the virtio spec=
.
>
> Not the virto spec of 2023 and more for new features.
> The base for virtio spec 1.x was 0.9.5, but not the QEMU or other mediati=
on based software AFAIK.

Are you saying those new features will not be suitable for software
devices? If yes, please explain why.

Or are you saying the virtio spec is not capable for hardware devices?

Thanks


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

