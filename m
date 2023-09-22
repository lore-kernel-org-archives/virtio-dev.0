Return-Path: <virtio-dev-return-13930-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD5C5E7D0C2
	for <virtio-dev@archiver.kernel.org>; Fri, 22 Sep 2023 03:09:10 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 0A1822B01B
	for <virtio-dev@archiver.kernel.org>; Fri, 22 Sep 2023 03:09:10 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D283E9866AE
	for <virtio-dev@archiver.kernel.org>; Fri, 22 Sep 2023 03:09:09 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id B3E6B98669C; Fri, 22 Sep 2023 03:09:09 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A2CA498669D
	for <virtio-dev@lists.oasis-open.org>; Fri, 22 Sep 2023 03:09:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: t5abDr17MQ6Yqf1VrXtfsA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695352117; x=1695956917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jn+BgXUWPERAgqltlL7VfI6jwvRTnaYnx333xzT+yWc=;
        b=ciKXBI3P2XbF2ZHI/i1uzzz3iZrX2XNar8v/aq9uj/rDJbIgan2TcEJAyVO884ro4c
         /qymzT5DE158qKdVRn4+hAB4BYzTmY5N7NwtwsyZZVgNt9ZyiUdKPlyu8KOkljzrucpF
         IfkSodcTBFWc322vhiYxaz5376TalFNEt3G/EskmgdFXyIS6e/CESEHbJ2zqaVIoqL3p
         nx4kKrIg8w7nqJmii5FEhakojjr9XjWwE/Pn/27pOhzCbxOBjefQI26ygVnQQ2P0ydUI
         qj8o07ALeLbkZF7CKByMHOrUiM3gaTS4N3Ny8UnSRkElZ4BcBFfHN/V6FMQO3V12L2B7
         kaXg==
X-Gm-Message-State: AOJu0YzjVHwfViQcBEB0iWtVpFpDaEFLtTfRXtAj1Ynhc/JanNu+kQy2
	OvqkVXXlg7ZyryXm9ZAY6AWfVqFbt//kwsLyX6jHreBRFklagwDyUYZgUHv59veGUeRvH3ELeK/
	222XhMhk0SGV2LMNViAi+ZdtMfPCYDVQDwMPNDdCibvsZ
X-Received: by 2002:a19:4f1c:0:b0:500:b64e:4f40 with SMTP id d28-20020a194f1c000000b00500b64e4f40mr6267347lfb.41.1695352117165;
        Thu, 21 Sep 2023 20:08:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+tsVzsXKKZ5qq/IwbllvpRV7T+418z+qSPP/oqi+ASrpEprWtPEiNvmfKhA3/XLgj+gh4v6W582stfBQRzGg=
X-Received: by 2002:a19:4f1c:0:b0:500:b64e:4f40 with SMTP id
 d28-20020a194f1c000000b00500b64e4f40mr6267336lfb.41.1695352116793; Thu, 21
 Sep 2023 20:08:36 -0700 (PDT)
MIME-Version: 1.0
References: <PH0PR12MB5481C41D4F32DA26D5831471DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <67680965-b115-32c7-dfdf-c56ab37bdd81@intel.com> <213a0f94-cee2-d8c5-3c5d-d2d7fc920e75@intel.com>
 <PH0PR12MB5481AE8C6E5EAFE9A4ADA6F6DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <f1fe513e-d42d-03a6-348c-5e58aac0a759@intel.com> <PH0PR12MB5481323A3B4D67EB66328476DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <5f01772f-eb27-bfe0-7f69-b83fbd90dda0@intel.com> <PH0PR12MB5481ABF4B9BC2082BC54AB1DDCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230918144312-mutt-send-email-mst@kernel.org> <bb402c34-ad07-063a-f4f5-d8c6b3a642c7@intel.com>
 <20230920054836-mutt-send-email-mst@kernel.org> <CACGkMEsn+9AqgmurN8-GXkcu8UxAr62_woJn3XZN+oUkTQNPUg@mail.gmail.com>
 <PH0PR12MB5481830365A80EF4583A3FFADCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEshxAU3Mjo7vczBNRb=P=FnenO4mPb9HJL0Ma3ZRbe-oA@mail.gmail.com> <PH0PR12MB548172996D62E37714A9776BDCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB548172996D62E37714A9776BDCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 22 Sep 2023 11:08:25 +0800
Message-ID: <CACGkMEtW88zJkDQL58NqLzzudq=f+SmzJ8bha55Dd2fd=FRGBQ@mail.gmail.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Zhu, Lingshan" <lingshan.zhu@intel.com>, 
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and vq state

On Thu, Sep 21, 2023 at 12:19=E2=80=AFPM Parav Pandit <parav@nvidia.com> wr=
ote:
>
>
> > From: Jason Wang <jasowang@redhat.com>
> > Sent: Thursday, September 21, 2023 9:39 AM
> >
> > On Thu, Sep 21, 2023 at 12:01=E2=80=AFPM Parav Pandit <parav@nvidia.com=
> wrote:
> > >
> > >
> > >
> > > > From: Jason Wang <jasowang@redhat.com>
> > > > Sent: Thursday, September 21, 2023 8:48 AM
> > >
> > > > As replied in another thread, the issues for BAR are:
> > > >
> > > > 1) Not sure it can have an efficient interface, it would be
> > > > something like VIRTIO_PCI_CAP_PCI_CFG which is very slow compared t=
o
> > > > single register accessing
> > > > 2) There's no owner/group/member for MMIO, most of the time, we onl=
y
> > > > need a single MMIO device. If we want the owner to manage itself, i=
t
> > > > seems redundant as is implied in all the existing transports (witho=
ut admin
> > commands).
> > > > Even if we had, it might still suffer from bootstrap issues.
> > > > 3) For live migration, it means the admin commands needs to start
> > > > from duplicating every existing transport specific interface it can
> > > > give us. One example is that we may end up with two interfaces to
> > > > access virtqueue addresses etc. This results in extra complicity an=
d
> > > > it is actually a full transport (driver can just use admin commands=
 to drive
> > the device).
> > > In [1] there is no duplication. The live migration driver never parse=
s the device
> > context either while reading or write.
> > > Hence no code and no complexity in driver and no duplicate work.
> > > Therefore, those admin commands are not to drive the guest device eit=
her.
> >
> > I'm not sure how this is related to the duplication issue.
> >
> You commented that admin virtqueue duplicates somethings.
> And I explained above that it does not.
>
> > >
> > > > 4) Admin commands itself may not be capable of doing things like
> > > > dirty page logging, it requires the assistance from the transport
> > > >
> > > Admin command in [1] is capable of dirty page logging.
> >
> > In your design, the logging is done via DMA not the virtqueue.
> >
> No. it is done via admin command, not DMA in [2].
>
> [2] https://lore.kernel.org/virtio-comment/20230909142911.524407-7-parav@=
nvidia.com/T/#m17b09acd8c73d374e98ad84764b315afa94f59c9
>
> > The only job for virtqueue is to initiate the DMA. But if DMA can be in=
itiated via
> > virtqueue, it can be done in other ways.
> >
> Lets first establish 4 things in alternative way, any motivation to do so=
 with 5th point without giant registers need in device.
>
> > >
> > > > 1) Parav's proposal does several couplings: couple basic build
> > > > blocks (suspend, dirty page tracking) with live migration, couple
> > > > live migration with admin commands.
> > > In which use case you find dirty page tracking useful without migrati=
on for
> > which you like to see it detached from device migration flow?
> >
> > Is it only the dirty page tracking? It's the combinations of
> >
> > 1) suspending
> > 2) device states
> > 3) dirty page tracking
> >
> > Eeah of those will have use cases other than live migration: VM stop, p=
ower
> > management in VM, profiling and monitoring, failover etc.
> >
> Suspend/resume with different power state is driven by the guest directly=
.

And there's hibernation actually where device states might be useful.

> So it may find some overlap.
>
> Device context has no overlap.

I can give you one example, e.g debugging.

>
> Dirty page tracking has no overlap. What do you want to profile and monit=
or? In case if you want to profile, it can be used without migration comman=
d anyway?

It works like a dirty bit of PTE. We all know it has a broader use
case than logging. For example, tracking working set and do
optimization on IOMMU/IOTLB or even device IOTLB.

1) Try to prove your facility can only work for one specific cases
2) Try to prove your facility can work for more than one cases

Which one is easier and more beneficial to virtio?


> If you describe, may be we I can split "device migration" chapter to two =
pieces,
> Device management and device migration.
>
> Device migration will use these basic facility.
> Would that help you?

Definitely, but it needs to be done by not making it under the
subsection of admin commands, that's it.

Let me repeat once again here for the possible steps to collaboration:

1) define virtqueue state, inflight descriptors in the section of
basic facility but not under the admin commands
2) define the dirty page tracking, device context/states in the
section of basic facility but not under the admin commands
3) define transport specific interfaces or admin commands to access them

Does this work? It seems you refused such steps in the past.

Actually, I would like to leave 2) as it's very complicated which
might not converge easily.

Thanks


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

