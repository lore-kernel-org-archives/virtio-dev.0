Return-Path: <virtio-dev-return-12808-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A215C77B73
	for <virtio-dev@archiver.kernel.org>; Wed, 24 May 2023 10:07:47 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 6C011142D4A
	for <virtio-dev@archiver.kernel.org>; Wed, 24 May 2023 10:07:46 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6863D986432
	for <virtio-dev@archiver.kernel.org>; Wed, 24 May 2023 10:07:46 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 5C964986410; Wed, 24 May 2023 10:07:46 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4A66C986414
	for <virtio-dev@lists.oasis-open.org>; Wed, 24 May 2023 10:07:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: Yezcu-kOMn6ESKSWFADNKQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684922860; x=1687514860;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KjdHisyXWPLpieor90KnFadcTP2yEYAlFMJHCG4RRvQ=;
        b=AXqZd3SyS4G5NknSgvixtClz5HWnHVVZy96xdEoCw3lMEbKGeuJ4GhlaCmFg1/Ul53
         xJCTZtgCBxa71LaVOzrNe/nngqEMPgYIlPV0C7FrOacLIymBtfjq3/1fnfzYOPAogiHZ
         LQCJpVj4lX1QAH8LirzUuGDTDu2aK7ExSFo6ZwHy8ji7BJlXZNU/ZBj8QFQ00TMqP0lJ
         whVU9pRXDfsR601UqTOcf+xDv1IE6MrxqHfxP7NrD+hfAcyr/4+0VO+b6ZpjbX8ojzo3
         K5kGXUUAcUglR6xZf4DlgvADy9qGvOIZB2IZ4yXiXS+trdYirSsBWeVeSslr4z6tqiHt
         zTjA==
X-Gm-Message-State: AC+VfDzMi8vlh4mQL4+V3vt+bhbSUJRljrlV5uv0FZ/x8sJ+HvYznQ50
	umBwhy3U+THS66jQMDTlrjtLBI7L0XLr3TUtlB0HTDhWZcvFfEJCcdyajTZV1ujHLbBtAWVYoFf
	pRCLYHoMRF0VV0qubhxaWExbbW2X/
X-Received: by 2002:a7b:ce19:0:b0:3f6:787:4a77 with SMTP id m25-20020a7bce19000000b003f607874a77mr6068131wmc.24.1684922859812;
        Wed, 24 May 2023 03:07:39 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6japDvwEbx1+JPzZV5sj1qeSgQWhmAac3zfJeEmn/jPiDQaNBNbNrxA7LaA/40zkgHfWTHAA==
X-Received: by 2002:a7b:ce19:0:b0:3f6:787:4a77 with SMTP id m25-20020a7bce19000000b003f607874a77mr6068116wmc.24.1684922859358;
        Wed, 24 May 2023 03:07:39 -0700 (PDT)
Date: Wed, 24 May 2023 06:07:34 -0400
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
Message-ID: <20230524054225-mutt-send-email-mst@kernel.org>
References: <20230521050829-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548161A2D28C387C9AF23B81DC429@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230521102050-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54815D83C3287FE7B3A2947CDC429@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230522154149-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481A2AD326E7F0A7CEFC223DC439@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230522170700-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54818BD5421AC200C2DEEDCFDC409@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230523141718-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548124A538CE4CCCE76F068FDC409@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB548124A538CE4CCCE76F068FDC409@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] RE: [PATCH v2 1/2] transport-pci: Introduce
 legacy registers access commands

On Tue, May 23, 2023 at 10:22:27PM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Tuesday, May 23, 2023 2:49 PM
> > > > iokit is from my previous work experience not virtio.
> > > > For virtio we had a lot of trouble with hacks like this on windows.
> > > I don't know why windows driver need to talk to PF driver until now when the
> > AQ doesn't exists.
> > 
> > What is it you want to know?
> >
> Why a VF driver needs to talk to a PF driver in windows without AQ?

I don't know- it doesn't? If it did, it would be hard as we learned
when trying to support pci-bridge-seat. Doable, but annoying.

> > > > That's an important platform.
> > > >
> > > I am not sure how important is it.
> > > What I learnt that a decade has passed and even after that virtio drivers are
> > not part of the OS distro.
> > 
> > Because with QEMU they are so easy to side-load. So we never bothered.
> > 
> I don't understand your comment.
> I was saying to my knowledge a Windows OS do not have a virtio drivers in their distro which you said is important.

It's important for windows to work well with virtio. And it does because
we supply an install disk with virtio drivers through QEMU

> > > It doesn't need to because guest is anyway going to do whatever it does.
> > 
> > yes. But hypervisor can do work-arounds or detect broken functionality and
> > stop cleanly.
> >
> You mentioned this several times.
> Below requirement still holds fine.
>  
> > > The clear requirement is: to not fix legacy but to support legacy.
> > > Fixing legacy is role of 1.x. Not the role of legacy interface itself using
> > AQ/MMIO.
> >
>  > And for purpose of BAR mapping, such BAR in the VF can be mapped too.
> > > You didn't answer why VF BAR is a problem and suggest PF BAR.
> > 
> > VF BAR by itself is not a problem. Discovering VF BAR mapping offset through PF
> > is.
> > 
> At the end of the email you right that "AQ is fine" but here you write discovering that through the PF AQ is.
> How to interpret your comment?
> 
> > > If notification for VF is in VF -> hence other config registers also in VF, such
> > blanket statements does not help.
> > 
> > not other config registers. what's needed in VF driver should be retrievable
> > through VF.
> >
> This applies to the modern device, for legacy emulation, I don't see this a mandatory.
> 
> > > Your comments and suggestions are helpful.
> > > Some of them follow the loop that doesn't help.
> > > Again, thanks a lot for the inputs and reviews.
> > >
> > > The design discussion helped to produce two solutions here than what was
> > started in v0.
> > 
> > OK good. Now I suggest you make an effort to come up with some compromise
> > that will make this thread stop. I really can't say I even remember what we said
> > in the beginning.
> 
> > You had this idea of starting with a problem statement document how about
> > doing that? Because I feel every time people bring up some idea and a problem
> > this idea would solve, you go "this is out of scope". Let's decide what the scope
> > is?
> >
> The requirements are simple and straightforward at start of the cover letter.
> i.e. for quick reference in short: A PCI VF passthrough to guest VM to support legacy + 1.x.
> 
> I propose:
> Method-1:
> 1. VF legacy registers access over AQ of PF
> 2. VF driver notifications using MMIO of VF
> 
> Method-2:
> 1. legacy registers access using two MMIO registers (data and addr)
> 2. VF driver notifications using MMIO of VF

I think I prefer Method-1, I didn't exactly see Method-2 to judge
though.


> > > I am asking a 1.x PCI device has the VF notification BAR already, why we don't
> > use it, why to build an additional one in device?
> > 
> > Following this logic, a 1.x PCI device also has modern common config.
> > All you really truly need is a flag to make it behave like legacy, from POV of
> > device config and VQs.
> > 
> Dual definition to same area in device is not elegant way to achieve it.
> We already discussed that some area is RW, some is not. It moves location.
> 
> And it still doesn't solve the problem of reset.
> Hence, either doing via AQ or 2 registers method would work fine.
> 
> It keeps legacy also isolated from mainstream.
> 
> > So let's try to keep drivers self-contained as much as possible.
> >
> You said "AQ is fine" at the end of email.
> Hard to understand your mixed suggestion in context of sending v3.

I am saying a simple thing actually:
- notifications are through VF
- rest of config is through PF (AQ)
seems like a consistent model to me.

> > > And notification also works well that reuses transitional device's notification.
> > 
> > I don't know what these are. You had some weird
> > +struct virtio_admin_cmd_lq_notify_query_result {
> > +       u8 bar; /* PCI BAR number of the member VF */
> > +       u8 reserved[7];
> > +       le64 offset; /* Byte offset within the BAR */ };
> > if you want to re-use the normal notifications for VFs we already describe them
> > using capabilities.
> >
> That capability is intermixed with 1.x register queue_notify_off.

Hmm yes annoying I forgot about this.

> So, I see following options.
> a. either to create a new legacy specific extended capability, or 
> b. say queue_notify_off doesn't apply for legacy notifications because this register doesn't exist for legacy
> c. exchange it via the AQ like above struct.

a feels ok to me... maybe test the waters with express capability
as well, it will come handy down the road I think.

> > However, this creates a weird mix where there's this command that mostly
> > follows legacy pci config layout except notifications which are there in the
> > legacy pci config are actually somewhere else.  And this is just inconsistent and
> > confusing, and the reason for this is implementation defined.
> Depends on how you see it.
> It is at same level of inconsistency as 1.x for a legit reason which is to split config registers from data path register.
>  
> It is not implementation defined. Notification over AQ cannot reach same perf level as MMIO.
> I will avoid repeating it.

yes, no need to repeat. I think what you are missing is that I am
proposing this as an intermediate step while we work on
support for notifications, or even a patch in the patchset.

> > 
> > > 3 out of 4 functionalities are done on AQ of the TVQ.
> > > So, it is time to stop asking to replicate the AQ functionality on some new
> > TVQ.
> > > This was discussed in depth.
> > 
> > I don't think I ever did that.
> >
> It is in Jason's reply when he was suggesting tvq in this same v2 series.

I think what he meant is that tvq project will be reworked on top
of AQ. tvq, indeed, does expose a full transport on top of AQ
and it seems logical to try and add legacy guest support to that.

> > My point however is the last sentence *If you need software in the middle then
> > let's please make it robust.* If BAR0 hack does not work then let's use sane
> > interfaces as much as possible.
> >
>  
> > AQ works fine I think. This new one I haven't seen yet hard to say.
> > Probably has its own set of problems ...
> >
> Ok. you review and we discuss after that.
> 
> > > Above example of legacy_register_addr and legacy register_data on the VF.
> > 
> > Talking about the two register thing.  We actually have this already:
> > VIRTIO_PCI_CAP_PCI_CFG.  We could allow access to IO BAR through it.
> > 
> To which IOBAR? The one that doesn't exist in the VF?

exactly. bar value is currently 0-6 other values are reserved.
we can steal e.g. 7 and say this is legacy IOBAR.
The advantage is that we can use this IOBAR for anything at all,
e.g. VIRTIO_PCI_CAP_DEVICE_CFG too.

> It is weird to create VIRTIO_PCI_CAP_PCI_CFG and point to non-existing area.
> 
> We can have new extended capability as,
> 
> VIRTIO_PCI_CAP_PCI_LEGACY_REG, that has slightly better interface and it also avoid intermix with 1.x using above two registers.

it's not a big deal, if you prefer a new capability fine.

> > 
> > But really since apparently you want to focus on how we solve notifications let's
> > focus on that. I feel the main issue is poking at 1.x registers and at the same time
> > at legacy registers.
> No, it is not 1.x registers. Register and bar offset is shared via the AQ.

That's good then. It's not always clear what you want to do, this
is the problem with high level discussion as opposed to a specific
patch.

> > The spec was written with a strong assumption that it is either or, never a mix.
> Transitional device supposed to support both as written in the spec.
> No different here.
> Now for real device.
> 
> > Changing that will be painful.
> > This is why I was asking about VIRTIO_NET_F_LEGACY_HEADER - legacy can live
> > in software then and we do not need to worry about it in the spec. I got it that
> > there's too much software here for your taste, but the problem with legacy is
> > really that it was always ad hoc and implementation derived.
> > So we need to keep it siloed.
> 
> This is why I am trying to avoid putting in PCI registers of the VF,
> but if you prefer, we can do using new VIRTIO_PCI_CAP_PCI_LEGACY_REG
> with two registers.

Oh. You are saying access to capability previously indicated modern
and now it is also done for legacy? That indeed is a good point.
Not sure what to do here. I'll ponder a bit.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

