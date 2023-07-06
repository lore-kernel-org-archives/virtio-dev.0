Return-Path: <virtio-dev-return-13275-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B83EAEB64D9
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 18:06:42 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 255762A821
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 18:06:42 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1E091986808
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 18:06:42 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 1119D98672D; Thu,  6 Jul 2023 18:06:42 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F3D7D98672E
	for <virtio-dev@lists.oasis-open.org>; Thu,  6 Jul 2023 18:06:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: tO71p_yoNEWP4TSwvcjS_w-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688666766; x=1691258766;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SBSIr2o4D6yoKXC3WuXQwLCB8nqYuzMosTID8u/DyRY=;
        b=aFI5+La8r0HFc06w3fngXTpGD6YFvR6AozXbEifNN0741J0DdtrzNtG3bmnDoMwWNS
         yRoIIed3Hir2X4ht0n5e/ZxiMl6rITd3XxgMMYs0a0SQAhlOWXcn+T/Vmf0TBMEp+2rW
         n2DofowuT5M+dOW8jbmLrFlbxrOecrRls8MZ4v8OhOhDmgjGek1NXExK/oeKlGzGcZE0
         nU86kTZpoOSL2tXgXBRoGhGjwmjahRaN5s/pCSZjjQKSc6c/v2t7UwN7RhYLhuqvmlvL
         q0rIwGqSd633FotOlNUxnIxWJYMZUPXxSiC8qe8bj0YFbpxx1a7pRP0WvCWYHpqiOooH
         245w==
X-Gm-Message-State: ABy/qLa2VmjF6n40TMpSJgRoKyoIc5yhNn3BwqCeJ6AHZGyN/GpZjPP0
	ewHbtVNV/1fpabx0PBWGaeClc2ewF2WBS3vNpe5HLSXpZRd18fI3GFvGhSUxvbmryBApPsiA6tt
	RZKqXvegNHiyxAWU5BnyM43waOav4
X-Received: by 2002:a05:600c:2102:b0:3fa:9538:963e with SMTP id u2-20020a05600c210200b003fa9538963emr2180297wml.36.1688666766627;
        Thu, 06 Jul 2023 11:06:06 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHWCRWpH/FzzWtMqaxc4V7yMUhIn5Yq0IAp7NhJJywXy7+oPk8X/qLF2Z/Gtl2GIUjZc6M7ng==
X-Received: by 2002:a05:600c:2102:b0:3fa:9538:963e with SMTP id u2-20020a05600c210200b003fa9538963emr2180281wml.36.1688666766277;
        Thu, 06 Jul 2023 11:06:06 -0700 (PDT)
Date: Thu, 6 Jul 2023 14:06:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Cornelia Huck <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"david.edmondson@oracle.com" <david.edmondson@oracle.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"sburla@marvell.com" <sburla@marvell.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	Yishai Hadas <yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
	Shahaf Shuler <shahafs@nvidia.com>
Message-ID: <20230706135858-mutt-send-email-mst@kernel.org>
References: <20230706041714.65600-1-parav@nvidia.com>
 <20230706041714.65600-5-parav@nvidia.com>
 <87r0pluhqy.fsf@redhat.com>
 <PH0PR12MB5481ED484C57428AD3D959C5DC2CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230706123954-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54817D2E9B0D7C5FE9EA2B0EDC2CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230706132638-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54813564E839C71709DCBDEFDC2CA@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54813564E839C71709DCBDEFDC2CA@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v10 4/4] transport-pci: Introduce group legacy group
 member config region access

On Thu, Jul 06, 2023 at 05:47:08PM +0000, Parav Pandit wrote:
> 
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Thursday, July 6, 2023 1:34 PM
> > 
> > On Thu, Jul 06, 2023 at 04:58:51PM +0000, Parav Pandit wrote:
> > >
> > >
> > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > Sent: Thursday, July 6, 2023 12:42 PM
> > > >
> > > > We will need to detail how notifications work though. The reason is
> > > > that the legacy notifications are received by owner driver (which is
> > > > not legacy!) and forwarded to device.
> > > > We need to explain exactly how this is done for people who don't
> > > > read minds and did not follow 3 months of mailing list debates, and
> > > > explain how this has the same effect as triggering driver notification through
> > the legacy interface.
> > > >
> > > I am not going to write driver implementation in the spec here.
> > > But I agree some high-level text is needed.
> > > With your suggestions
> > > 1. to merge pci and generic in one section, 2. add description to
> > > notification, 3. past rewrites provided in v9,
> > >
> > > The draft of v11, looks like below. Please see how much more verbose to make
> > it, if at all.
> > >
> > > \paragraph{Legacy Driver Notification}\label{par:Basic Facilities of a
> > > Virtio Device / Device groups / Group administration commands / Legacy
> > > Interface / Legacy Driver Notifications}
> > >
> > > If the group owner device or the group member device support driver
> > > notifications via a memory-mapped operation or I/O operation, these
> > > notifications are sent to the device via accessing such a notification
> > > region using a memory or I/O operation instead of sending the
> > > notifications through the administration command.
> > 
> > This paragraph adds very little information - just some vague hints at how things
> > work.
> > 
> A hunk added this paragraph back.
> Going to remove it as description is duplicate of what is written below.
>
> > > The driver of the owner device can send a driver notification to the
> > > member device by executing
> > VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE
> > > with the \field{offset} matching \field{Queue Notify} and the
> > > \field{data} containing the virtqueue index to be notified.
> > >
> > > However, as many administration commands are used for slow path
> > > configuration, a separate fast path mechanism for such notifications
> > > is desired. For the SR-IOV group type, the optional command
> > > VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_INFO
> > > addresses this need by returning to the driver one or more addresses
> > > which to be used to send such driver notifications.
> > >
> > > In one example, the driver in the hypervisor which intercepts I/O BAR
> > > accesses for the \field{Queue Notify} can access the notification area
> > > directly as memory or I/O access (depending on what the device
> > > reported) instead of slow administration command.
> > >
> Above paragraph is really more than enough for the reader to implement.
> I will merge your text of 16-bit notify vq line here.

I don't have all of the context in front of me. We'll see in v11.
Try to keep a style consistent with what we have written
for the config space.


> > > For the command VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_INFO the driver
> > sets
> > > \field{opcode} to 0x6.
> > > The driver sets \field{group_member_id} which refers to the member
> > > device to be accessed. This command does not use
> > \field{command_specific_data}.
> > >
> > > This command is currently only defined for the SR-IOV group type. When
> > > the device supports VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_INFO command,
> > the
> > > group owner device hardwires VF BAR0 to zero in the SR-IOV Extended
> > > capability and the group member device does not use PCI BAR0 in all
> > > the Virtio PCI capabilities listed in section \ref{sec:Virtio Transport Options /
> > Virtio Over PCI Bus / Virtio Structure PCI Capabilities}.
> > 
> > After reading this I still have no clue at how these notifications work.
> > maybe it's in some other patch. Let's see v11.
> >
> There is only one patch now in v11 other than two fixes.
> 
> > Just making a wild guess:
> > 
> > it is true that
> > 	to supply a driver notification to the device, it is possible for the driver
> > to write the vq index of the vq to be notified, in little endian format, using a
> > single 16 byte write at the address provided ?
> > 
> > and I am guessing that
> > 	the write is an IO or a memory write, depending on the
> > 	type of the BAR referred to?
> > 
> > then why don't we just say this?
> All this while I assume that what you wrote above is already written in description for "queue notify" register in " Legacy Interfaces: A Note on PCI Device Layout".
> So no need to repeat.
> 
> But I realized that base spec is totally silent on it, but still we are supposed to write here.
> Ok.
> So yes, let me add above line here, without touching existing legacy interface section.

It's not documented all that well. I think it was clearer originally
but with all the VIRTIO_F_NOTIFICATION_DATA and such it bit-rotted.

But again even if you add it there, you can not claim it's exactly the
same as legacy because the address is different, the address type is
different, the driver is different (this is owner driver) and even
the device is different.

Please also call out the unusual configuration where the type
is "member" and then you have the owner driver access the
memory of the member device. People might be confused.

I also think we should explain that order of entries is a hint
to driver: use the 1st entry that you can.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

