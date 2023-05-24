Return-Path: <virtio-dev-return-12818-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 821ACC7EE2D
	for <virtio-dev@archiver.kernel.org>; Wed, 24 May 2023 20:13:03 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id E360660363
	for <virtio-dev@archiver.kernel.org>; Wed, 24 May 2023 20:13:02 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DA16B986560
	for <virtio-dev@archiver.kernel.org>; Wed, 24 May 2023 20:13:02 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id CDA5D983E27; Wed, 24 May 2023 20:13:02 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BB709986551
	for <virtio-dev@lists.oasis-open.org>; Wed, 24 May 2023 20:13:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: qRIpv-pKMlCBec69T9WWfg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684959176; x=1687551176;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=deUo2xVUGUKD1ucnaJWAVHaLECp+gWUt74Fu3IpQkd8=;
        b=FpzVPXFvboDRBMeAEmDuXlJ7Ul2Orjvf/p+fmV95KJqYsSy+VTPjT3JUqcNindo+ZL
         ALDlxpB4ago75waBaRnHIxLOqyLGMk2hbuyg3NhEgu01jI6JnUVBtJRLaNkZnVtNNYFp
         M68Yi2xUlI+thEee7H7O57MrAlTQJAAR8gZfPIOiip5vEjeHNqgbcgr+oTYjZTIof+k7
         hwrld8k32wgMgVVyK7Vjce4fWU+EiuhNAxwXOVj7uX4Q4pAQdgUkBY+K4D4udZP4jgfq
         MV3u+L7li5+/R3ZJu+We7SPNItr8FdJlBVqYeRaVAQm0nJk29cwcOpiTVuPpfvXwFzmU
         9WZw==
X-Gm-Message-State: AC+VfDziXt8Eg1MAlnsPVtdmrMUdgLWV+JHS6OC0LGfThjbZDm9O0qQS
	0KpsXA3ZwT2X5ON60C70dbB9W/SxpROlUyEgVornppb8X0EeudmaiCmaWyl/1oUHOXXZwLcr/85
	ZM9/gJAjrfC837ZeGc3VmPJMuEpke
X-Received: by 2002:a7b:ce93:0:b0:3f6:3e4:7cc9 with SMTP id q19-20020a7bce93000000b003f603e47cc9mr597538wmj.40.1684959176530;
        Wed, 24 May 2023 13:12:56 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ53WP5uJ10ZDtBp1zTNEJ0RfG8ad1sHIHYaTYxOtsRcBtdFXdQNKHS7GYCef6TX6rtWZ7QEuQ==
X-Received: by 2002:a7b:ce93:0:b0:3f6:3e4:7cc9 with SMTP id q19-20020a7bce93000000b003f603e47cc9mr597524wmj.40.1684959176107;
        Wed, 24 May 2023 13:12:56 -0700 (PDT)
Date: Wed, 24 May 2023 16:12:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"david.edmondson@oracle.com" <david.edmondson@oracle.com>,
	"sburla@marvell.com" <sburla@marvell.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	Yishai Hadas <yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Message-ID: <20230524155902-mutt-send-email-mst@kernel.org>
References: <20230521102050-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54815D83C3287FE7B3A2947CDC429@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230522154149-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481A2AD326E7F0A7CEFC223DC439@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230522170700-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54818BD5421AC200C2DEEDCFDC409@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230523141718-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548124A538CE4CCCE76F068FDC409@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230524054225-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481C5C2A080FC9BD6296AE5DC419@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481C5C2A080FC9BD6296AE5DC419@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] RE: [PATCH v2 1/2] transport-pci: Introduce
 legacy registers access commands

On Wed, May 24, 2023 at 07:18:56PM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Wednesday, May 24, 2023 6:08 AM
> > 
> > On Tue, May 23, 2023 at 10:22:27PM +0000, Parav Pandit wrote:
> > >
> > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > Sent: Tuesday, May 23, 2023 2:49 PM
> > > > > > iokit is from my previous work experience not virtio.
> > > > > > For virtio we had a lot of trouble with hacks like this on windows.
> > > > > I don't know why windows driver need to talk to PF driver until
> > > > > now when the
> > > > AQ doesn't exists.
> > > >
> > > > What is it you want to know?
> > > >
> > > Why a VF driver needs to talk to a PF driver in windows without AQ?
> > 
> > I don't know- it doesn't? If it did, it would be hard as we learned when trying to
> > support pci-bridge-seat. Doable, but annoying.
> If it does today, something likely is missing in that OS. Their model for sriov has not evolved as much as Linux from what I see.
> So not to worry about it, as they may have to implement more things.
> 
> > 
> > > > > > That's an important platform.
> > > > > >
> > > > > I am not sure how important is it.
> > > > > What I learnt that a decade has passed and even after that virtio
> > > > > drivers are
> > > > not part of the OS distro.
> > > >
> > > > Because with QEMU they are so easy to side-load. So we never bothered.
> > > >
> > > I don't understand your comment.
> > > I was saying to my knowledge a Windows OS do not have a virtio drivers in
> > their distro which you said is important.
> > 
> > It's important for windows to work well with virtio. And it does because we
> > supply an install disk with virtio drivers through QEMU
> 
> Ok. So WDM can use their IPR model or will be able to build infra as/if needed.
> 
> > > I propose:
> > > Method-1:
> > > 1. VF legacy registers access over AQ of PF 2. VF driver notifications
> > > using MMIO of VF
> > >
> > > Method-2:
> > > 1. legacy registers access using two MMIO registers (data and addr) 2.
> > > VF driver notifications using MMIO of VF
> > 
> > I think I prefer Method-1, I didn't exactly see Method-2 to judge though.
> > 
> Ok. so lets step forward in v3 using 4 commands for registers access.
> 2 RW commands for common config.
> 2 RW commands for device config.
> 
> Notification on below.
> 
> > 
> > > > > I am asking a 1.x PCI device has the VF notification BAR already,
> > > > > why we don't
> > > > use it, why to build an additional one in device?
> > > >
> > > > Following this logic, a 1.x PCI device also has modern common config.
> > > > All you really truly need is a flag to make it behave like legacy,
> > > > from POV of device config and VQs.
> > > >
> > > Dual definition to same area in device is not elegant way to achieve it.
> > > We already discussed that some area is RW, some is not. It moves location.
> > >
> > > And it still doesn't solve the problem of reset.
> > > Hence, either doing via AQ or 2 registers method would work fine.
> > >
> > > It keeps legacy also isolated from mainstream.
> > >
> > > > So let's try to keep drivers self-contained as much as possible.
> > > >
> > > You said "AQ is fine" at the end of email.
> > > Hard to understand your mixed suggestion in context of sending v3.
> > 
> > I am saying a simple thing actually:
> > - notifications are through VF
> > - rest of config is through PF (AQ)
> > seems like a consistent model to me.
> > 
> Sounds good to me.
> What about discovery the notification place for the VF?
> We have two options.
> 1. discover them via AQ like config registers access
> 2. discover it via extended PCI capability
> 
> #1 is far more programable and does not need to bake in the PCI device layout.

I think 2 is easier for drivers to use.

> So this way one day in future we can get rid of it more easily for those PCI devices who may prefer everything in the hw.

I think these devices are better off with a new transport using
drastically less registers.

> > > > if you want to re-use the normal notifications for VFs we already
> > > > describe them using capabilities.
> > > >
> > > That capability is intermixed with 1.x register queue_notify_off.
> > 
> > Hmm yes annoying I forgot about this.
> > 
> 
> > > So, I see following options.
> > > a. either to create a new legacy specific extended capability, or b.
> > > say queue_notify_off doesn't apply for legacy notifications because
> > > this register doesn't exist for legacy c. exchange it via the AQ like above
> > struct.
> > 
> > a feels ok to me... maybe test the waters with express capability as well, it will
> > come handy down the road I think.
> Yes, if this is really needed for some OS, this addition will be possible in future in the spec and also of the devices in CC list here.

hmm not sure what do you mean. I meant to put the capabilities
with the new legacy bar in express config space.

> > 
> > > > However, this creates a weird mix where there's this command that
> > > > mostly follows legacy pci config layout except notifications which
> > > > are there in the legacy pci config are actually somewhere else.  And
> > > > this is just inconsistent and confusing, and the reason for this is
> > implementation defined.
> > > Depends on how you see it.
> > > It is at same level of inconsistency as 1.x for a legit reason which is to split
> > config registers from data path register.
> > >
> > > It is not implementation defined. Notification over AQ cannot reach same perf
> > level as MMIO.
> > > I will avoid repeating it.
> > 
> > yes, no need to repeat. I think what you are missing is that I am proposing this
> > as an intermediate step while we work on support for notifications, or even a
> > patch in the patchset.
> > 
> Like said above, share your thoughts on the two options and I will modify this patch or add new in v3.
> > 
> > I think what he meant is that tvq project will be reworked on top of AQ. tvq,
> > indeed, does expose a full transport on top of AQ and it seems logical to try and
> > add legacy guest support to that.
> Yes, I also acked that for SIOV devices to have legacy support on top of base SIOV device interface.
> 
> > > > Talking about the two register thing.  We actually have this already:
> > > > VIRTIO_PCI_CAP_PCI_CFG.  We could allow access to IO BAR through it.
> > > >
> > > To which IOBAR? The one that doesn't exist in the VF?
> > 
> > exactly. bar value is currently 0-6 other values are reserved.
> > we can steal e.g. 7 and say this is legacy IOBAR.
> > The advantage is that we can use this IOBAR for anything at all, e.g.
> > VIRTIO_PCI_CAP_DEVICE_CFG too.
> > 
> > > It is weird to create VIRTIO_PCI_CAP_PCI_CFG and point to non-existing area.
> > >
> > > We can have new extended capability as,
> > >
> > > VIRTIO_PCI_CAP_PCI_LEGACY_REG, that has slightly better interface and it
> > also avoid intermix with 1.x using above two registers.
> > 
> > it's not a big deal, if you prefer a new capability fine.
> > 
> > > >
> > > > But really since apparently you want to focus on how we solve
> > > > notifications let's focus on that. I feel the main issue is poking
> > > > at 1.x registers and at the same time at legacy registers.
> > > No, it is not 1.x registers. Register and bar offset is shared via the AQ.
> > 
> > That's good then. It's not always clear what you want to do, this is the problem
> > with high level discussion as opposed to a specific patch.
> > 
> > > > The spec was written with a strong assumption that it is either or, never a
> > mix.
> > > Transitional device supposed to support both as written in the spec.
> > > No different here.
> > > Now for real device.
> > >
> > > > Changing that will be painful.
> > > > This is why I was asking about VIRTIO_NET_F_LEGACY_HEADER - legacy
> > > > can live in software then and we do not need to worry about it in
> > > > the spec. I got it that there's too much software here for your
> > > > taste, but the problem with legacy is really that it was always ad hoc and
> > implementation derived.
> > > > So we need to keep it siloed.
> > >
> > > This is why I am trying to avoid putting in PCI registers of the VF,
> > > but if you prefer, we can do using new VIRTIO_PCI_CAP_PCI_LEGACY_REG
> > > with two registers.
> > 
> > Oh. You are saying access to capability previously indicated modern and now it
> > is also done for legacy? That indeed is a good point.
> > Not sure what to do here. I'll ponder a bit.
> 
> The new capability in mind is:
> VIRTIO_PCI_EXT_CAP_PCI_LEGACY_REG
> 
> struct virtio_pci_legacy_cfg_cap {
> 	struct virtio_pci_cap cap;
> 	le32 addr; /* register offset, width, op=RD/WR, status:0=pending,1=done)
> 	le32 reg_data; 
> };

I would use cap64, cap is there because we did not think about 64 bit early enough.

> This will be hard to do for SIOV in future, so I prefer AQ cmd for config register access and notification discovery.
> WDYT?

I need to go back and look at how does SIOV tvq proposal manage
notifications then.  Do not remember off the top of my head.


-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

