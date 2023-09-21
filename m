Return-Path: <virtio-dev-return-13899-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECDA9CD494C
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 04:09:36 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 564B28C125
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 04:09:36 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 377CE986681
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 04:09:36 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 1EDB2983D6F; Thu, 21 Sep 2023 04:09:36 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0E34C98667C
	for <virtio-dev@lists.oasis-open.org>; Thu, 21 Sep 2023 04:09:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: sTuOT344Pc2aeHR6BURIWw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695269371; x=1695874171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r1f3RO7EbN7a/8RzgcVk9emsNNFsPVfSLCeGszklvhY=;
        b=WlwfsXj3VE2qszTgdVOLEzjq3RtwITmwst/B2ypcmQj8VdJp3rrqfIl1opiahrKPcz
         DHNdCxRnfnC4bJtaknpUjOiX3ctS4HsGQ01Op+n9t7PkNmZvXWpe5zKaT4mlTEZC+lWd
         exWJyK1bOP7V20HjIPiaPAwwXiZ8WV96Z1p67+za8DkkcMuP92oMht+Fg1rLeA6HuNsb
         5cP+5A1l4pwrvPYRV/MKIGowL1u+kg1WrTIUdaJV9K3Xm6KHEEiuWdslj+uOM6Gvewbm
         d3vPX2Fco8u98tSPSHED8UzrA0Au9HtYwrfdN9vmc/C4mtoaFTEIn8aXoSFqVKE3RnjZ
         dvXw==
X-Gm-Message-State: AOJu0Ywj30y8yD4dwJjKUsGb31tTcYe+E9/LDHPZlCQtiWwuO4FGPjJC
	uinWE2zX0Dw6+mUe6jpbGxv0jN5oEcBWnLlA/hN1NYYfK/Jkp0T5pcfc7LgrMyBS2f8Br4PM9Xv
	/I6PSPw2lx16P6tyDUm2YDrrAui75P7PGPAPy52YHiMGzEH+35Wj1bmQ=
X-Received: by 2002:ac2:5b1d:0:b0:500:94aa:739c with SMTP id v29-20020ac25b1d000000b0050094aa739cmr4115885lfn.61.1695269370948;
        Wed, 20 Sep 2023 21:09:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHciCKA3OZHUusfGOKKe1ZbOPUif/Jqn4gmUrxzOWscCE36CnIyR6Uhfa4ConT7r6hkcfL02lKW0ETl3AXst/M=
X-Received: by 2002:ac2:5b1d:0:b0:500:94aa:739c with SMTP id
 v29-20020ac25b1d000000b0050094aa739cmr4115876lfn.61.1695269370615; Wed, 20
 Sep 2023 21:09:30 -0700 (PDT)
MIME-Version: 1.0
References: <PH0PR12MB5481C41D4F32DA26D5831471DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <67680965-b115-32c7-dfdf-c56ab37bdd81@intel.com> <213a0f94-cee2-d8c5-3c5d-d2d7fc920e75@intel.com>
 <PH0PR12MB5481AE8C6E5EAFE9A4ADA6F6DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <f1fe513e-d42d-03a6-348c-5e58aac0a759@intel.com> <PH0PR12MB5481323A3B4D67EB66328476DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <5f01772f-eb27-bfe0-7f69-b83fbd90dda0@intel.com> <PH0PR12MB5481ABF4B9BC2082BC54AB1DDCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230918144312-mutt-send-email-mst@kernel.org> <bb402c34-ad07-063a-f4f5-d8c6b3a642c7@intel.com>
 <20230920054836-mutt-send-email-mst@kernel.org> <CACGkMEsn+9AqgmurN8-GXkcu8UxAr62_woJn3XZN+oUkTQNPUg@mail.gmail.com>
 <PH0PR12MB5481830365A80EF4583A3FFADCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB5481830365A80EF4583A3FFADCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 21 Sep 2023 12:09:18 +0800
Message-ID: <CACGkMEshxAU3Mjo7vczBNRb=P=FnenO4mPb9HJL0Ma3ZRbe-oA@mail.gmail.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Zhu, Lingshan" <lingshan.zhu@intel.com>, 
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and vq state

On Thu, Sep 21, 2023 at 12:01=E2=80=AFPM Parav Pandit <parav@nvidia.com> wr=
ote:
>
>
>
> > From: Jason Wang <jasowang@redhat.com>
> > Sent: Thursday, September 21, 2023 8:48 AM
>
> > As replied in another thread, the issues for BAR are:
> >
> > 1) Not sure it can have an efficient interface, it would be something l=
ike
> > VIRTIO_PCI_CAP_PCI_CFG which is very slow compared to single register
> > accessing
> > 2) There's no owner/group/member for MMIO, most of the time, we only ne=
ed
> > a single MMIO device. If we want the owner to manage itself, it seems
> > redundant as is implied in all the existing transports (without admin c=
ommands).
> > Even if we had, it might still suffer from bootstrap issues.
> > 3) For live migration, it means the admin commands needs to start from
> > duplicating every existing transport specific interface it can give us.=
 One
> > example is that we may end up with two interfaces to access virtqueue
> > addresses etc. This results in extra complicity and it is actually a fu=
ll transport
> > (driver can just use admin commands to drive the device).
> In [1] there is no duplication. The live migration driver never parses th=
e device context either while reading or write.
> Hence no code and no complexity in driver and no duplicate work.
> Therefore, those admin commands are not to drive the guest device either.

I'm not sure how this is related to the duplication issue.

>
> > 4) Admin commands itself may not be capable of doing things like dirty =
page
> > logging, it requires the assistance from the transport
> >
> Admin command in [1] is capable of dirty page logging.

In your design, the logging is done via DMA not the virtqueue.

The only job for virtqueue is to initiate the DMA. But if DMA can be
initiated via virtqueue, it can be done in other ways.

>
> > 1) Parav's proposal does several couplings: couple basic build blocks (=
suspend,
> > dirty page tracking) with live migration, couple live migration with ad=
min
> > commands.
> In which use case you find dirty page tracking useful without migration f=
or which you like to see it detached from device migration flow?

Is it only the dirty page tracking? It's the combinations of

1) suspending
2) device states
3) dirty page tracking

Eeah of those will have use cases other than live migration: VM stop,
power management in VM, profiling and monitoring, failover etc.

> One can always use these commands if they wish to as_is.
>
> > 2) It's still not clear that Parav's proposal can work, a lot of corner=
 cases needs
> > to be examined
> >
> Please let me know which part can be improved in [1].

I will do that but it may take time. It's near to the public holiday.

Thanks

>
> [1] https://lore.kernel.org/virtio-comment/20230909142911.524407-7-parav@=
nvidia.com/T/#md9fcfa1ba997463de8c7fb8c6d1786b224b0bead
>
>
> > >
> > > > the bar is only a proxy, doesn't fix anything. and even larger side
> > > > channel attacking surface: vf-->pf-->vf
> > >
> > > In this model there's no pf. BAR belongs to vf itself and you submit
> > > commands for the VF through its BAR.
> > > Just separate from the pci config space.
> > >
> > > The whole attacking surface discussion is also puzzling.  We either
> > > are or are not discussing confidential computing/TDI.  I couldn't
> > > figure it out. This needs a separate thread I think.
> >
> > Anyhow, it's not bad to take it into consideration. But we can do it el=
sewhere for
> > sure.
> Thanks.
> Please have comments in [1].
>
> [1] https://lore.kernel.org/virtio-comment/20230909142911.524407-7-parav@=
nvidia.com/T/#md9fcfa1ba997463de8c7fb8c6d1786b224b0bead
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

