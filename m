Return-Path: <virtio-dev-return-13891-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63483CD4942
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 03:18:15 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id A45AE2AED9
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 03:18:14 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 85BE7986686
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 03:18:14 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 6DF1F983D6F; Thu, 21 Sep 2023 03:18:14 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5CAEC98667C
	for <virtio-dev@lists.oasis-open.org>; Thu, 21 Sep 2023 03:18:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: RSYu-koHPjCTnQYxTCXBxQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695266288; x=1695871088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RX+s1kUMBJK3ZYf9kOFLePe+Tj4gqzY+lK+lMFLaUHg=;
        b=KDS6265Hord+88m2bE0lt6CTbR+qM5Ptux1Cm3YyFPPeD6CFCvJMgHmT746tHhGMn7
         rE3EkVsAILNUlE+6/6teTzmjc5VZ6EBh2vA/PeaV6hKs6HuizbYRX6uqs421Do890g4v
         PWMUS3RQgzkQcMP0QPd1HrGTPh/Ltk7yhh3lNioUbA8X7kQEyWQT0/lIEnaLPbWpWtkY
         ljZDpfalo4K0wbMwyZXFSoIlr0UcwNHePoW2P1FSmK/zPLA8Bygz195I7FAbqGFkXINC
         KBL7HfINvLS20VhU+kywtSuOxfaJTTAZjJoIQLC2ykZduzCFB+iz7DeCPB7Mvcz04Nez
         Ynkw==
X-Gm-Message-State: AOJu0YzaA0CYNHC/j8ogTD/vj4pIKlyZtzgHhkxbfD3939/dVpblAF2s
	wbFk/UPLYpS/ONHPha01/fBkZyu72UaEAl7HJAjF2x/v3f0HeMEChxDn72NX48x1gndrJU+oGvo
	h+MJ1wIpSCsRxmjD7NZmyDr20Y+4XYu1Hvv6hUNvtpm2d
X-Received: by 2002:a19:6905:0:b0:502:adbb:f9db with SMTP id e5-20020a196905000000b00502adbbf9dbmr2565041lfc.65.1695266288042;
        Wed, 20 Sep 2023 20:18:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkDmRl1GFc+mBokcF+UJjXHWCgT56umKUdzaIIJ5y77yvIK1haJzrnMzkpyTAMwbeZXAc8Kq8oHPShx5fA/p0=
X-Received: by 2002:a19:6905:0:b0:502:adbb:f9db with SMTP id
 e5-20020a196905000000b00502adbbf9dbmr2565025lfc.65.1695266287707; Wed, 20 Sep
 2023 20:18:07 -0700 (PDT)
MIME-Version: 1.0
References: <PH0PR12MB5481C41D4F32DA26D5831471DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <67680965-b115-32c7-dfdf-c56ab37bdd81@intel.com> <213a0f94-cee2-d8c5-3c5d-d2d7fc920e75@intel.com>
 <PH0PR12MB5481AE8C6E5EAFE9A4ADA6F6DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <f1fe513e-d42d-03a6-348c-5e58aac0a759@intel.com> <PH0PR12MB5481323A3B4D67EB66328476DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <5f01772f-eb27-bfe0-7f69-b83fbd90dda0@intel.com> <PH0PR12MB5481ABF4B9BC2082BC54AB1DDCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230918144312-mutt-send-email-mst@kernel.org> <bb402c34-ad07-063a-f4f5-d8c6b3a642c7@intel.com>
 <20230920054836-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230920054836-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 21 Sep 2023 11:17:56 +0800
Message-ID: <CACGkMEsn+9AqgmurN8-GXkcu8UxAr62_woJn3XZN+oUkTQNPUg@mail.gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Zhu, Lingshan" <lingshan.zhu@intel.com>, Parav Pandit <parav@nvidia.com>, 
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and vq state

On Wed, Sep 20, 2023 at 6:36=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Wed, Sep 20, 2023 at 02:06:13PM +0800, Zhu, Lingshan wrote:
> >
> >
> > On 9/19/2023 2:49 AM, Michael S. Tsirkin wrote:
> > > On Mon, Sep 18, 2023 at 06:41:55PM +0000, Parav Pandit wrote:
> > > > > Please refer to the code for setting FEATURES_OK.
> > > > It wont work when one needs to suspend the device.
> > > > There is no point of doing such work over registers as fundamental =
framework is over the AQ.
> > > Well not really. It's over admin commands. When these were built the
> > > intent always was that it's possible to use admin commands through
> > > another interface, other than admin queue. Is there a problem
> > > implementing admin commands over a memory BAR? For example, I can see
> > > an "admin command" capability pointing at a BAR where
> > > commands are supplied, and using a new group type referring to
> > > device itself.
> > I am not sure, if a bar cap would be implemented as a proxy for the adm=
in vq
> > based live migration.
>
> Not a proxy for a vq in that there's no vq then.

As replied in another thread, the issues for BAR are:

1) Not sure it can have an efficient interface, it would be something
like VIRTIO_PCI_CAP_PCI_CFG which is very slow compared to single
register accessing
2) There's no owner/group/member for MMIO, most of the time, we only
need a single MMIO device. If we want the owner to manage itself, it
seems redundant as is implied in all the existing transports (without
admin commands). Even if we had, it might still suffer from bootstrap
issues.
3) For live migration, it means the admin commands needs to start from
duplicating every existing transport specific interface it can give
us. One example is that we may end up with two interfaces to access
virtqueue addresses etc. This results in extra complicity and it is
actually a full transport (driver can just use admin commands to drive
the device).
4) Admin commands itself may not be capable of doing things like dirty
page logging, it requires the assistance from the transport

>
> > then the problems of admin vq LM that we have
> > discussed
> > still exist.
>
> I freely admit the finer points of this extended flamewar have been lost
> on me, and I wager I'm not the only one. I thought you wanted to migrate
> the device just by accessing the device itself (e.g. the VF) without
> accessing other devices (e.g. the PF), while Parav wants it in a
> separate device so the whole of the device itself can passed through to
> guest.

If accessing the device itself, anything prevents us from passing it
through to the guest? It is how all the existing devices are built.

> Isn't this, fundamentally, the issue?

For me it's not. The fundamental issues are:

1) Parav's proposal does several couplings: couple basic build blocks
(suspend, dirty page tracking) with live migration, couple live
migration with admin commands. This proposal doesn't do such coupling,
and admin commands can be built on top.
2) It's still not clear that Parav's proposal can work, a lot of
corner cases needs to be examined

>
> > the bar is only a proxy, doesn't fix anything. and even larger
> > side channel attacking surface: vf-->pf-->vf
>
> In this model there's no pf. BAR belongs to vf itself
> and you submit commands for the VF through its BAR.
> Just separate from the pci config space.
>
> The whole attacking surface discussion is also puzzling.  We either are
> or are not discussing confidential computing/TDI.  I couldn't figure
> it out. This needs a separate thread I think.

Anyhow, it's not bad to take it into consideration. But we can do it
elsewhere for sure.

Thanks





>
> --
> MST
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

