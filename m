Return-Path: <virtio-dev-return-13884-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC9CBCE79D0
	for <virtio-dev@archiver.kernel.org>; Wed, 20 Sep 2023 12:41:58 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 58D9912D34B
	for <virtio-dev@archiver.kernel.org>; Wed, 20 Sep 2023 12:41:58 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4BC9C986677
	for <virtio-dev@archiver.kernel.org>; Wed, 20 Sep 2023 12:41:58 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 3FA4098666A; Wed, 20 Sep 2023 12:41:58 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 327EC98666B
	for <virtio-dev@lists.oasis-open.org>; Wed, 20 Sep 2023 12:41:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 73rCTdWtN7urDJi6glOV9A-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695213714; x=1695818514;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N1Y5SmDy6HKLZx/dzkicyps8p7KQ9FdYrerfI3Ssygs=;
        b=Lpog1ar4HcNij0h/oJTe9DJZcJGg1mY+aNoH2qYK9M4iRHvZSsmfHeXtgD/mD7tOLm
         mcBVNzhG4RQQRDwAkRCC1imSomny5hg5iz0qCHIFPXLVkrz21MgwyjNpygUid/ve0KOP
         bB9qnt4jc51GdKyJdw0mfzNkfVbnotRjRpgU8GNf4f4dxAR53X8jvi7jHAu5jKgxXjoz
         WF3IzsZfy9zAA+OnWK9QztGY1pxAL3RnJ4pAkk70yXWOPstVeShUcaeU8UwYKNG5qvUi
         qz3P8QIOCCN8z0G2jKHqMdVSqaWVCFyHz7WA1mnLrozBqQzJUyorpQ0qNW8hEmdEVuKS
         V3tA==
X-Gm-Message-State: AOJu0YyzoWv+ABi7m9aZ4csQgRHnDP7sWtQc+QtqRQ8x3HHk4HjPA78j
	VxQFcjn8GRsDn4kPr5154vrh2USIfasmUw8pK//1ATeHPJrP8hmXjuJGshEYOBBQj2gETUN2dmm
	U1g5aXFD6E+qzATaYwyiUN9VfoMQl
X-Received: by 2002:a05:6512:baa:b0:503:2877:67e3 with SMTP id b42-20020a0565120baa00b00503287767e3mr2693320lfv.6.1695213714510;
        Wed, 20 Sep 2023 05:41:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmkPewFZlKJpisyFdVTGKPZCX0WXAgUbuveKL1JajNCYj8Ujpo6aOEG8MNCGj+/TwibV5EKw==
X-Received: by 2002:a05:6512:baa:b0:503:2877:67e3 with SMTP id b42-20020a0565120baa00b00503287767e3mr2693299lfv.6.1695213714080;
        Wed, 20 Sep 2023 05:41:54 -0700 (PDT)
Date: Wed, 20 Sep 2023 08:41:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>
Cc: Parav Pandit <parav@nvidia.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	Jason Wang <jasowang@redhat.com>
Message-ID: <20230920084058-mutt-send-email-mst@kernel.org>
References: <PH0PR12MB5481AE8C6E5EAFE9A4ADA6F6DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <f1fe513e-d42d-03a6-348c-5e58aac0a759@intel.com>
 <PH0PR12MB5481323A3B4D67EB66328476DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <5f01772f-eb27-bfe0-7f69-b83fbd90dda0@intel.com>
 <PH0PR12MB5481ABF4B9BC2082BC54AB1DDCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230918144312-mutt-send-email-mst@kernel.org>
 <bb402c34-ad07-063a-f4f5-d8c6b3a642c7@intel.com>
 <20230920054836-mutt-send-email-mst@kernel.org>
 <2f67fb85-2238-9c34-a265-b0f97b7ab7e1@intel.com>
 <20230920075243-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230920075243-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: Re: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and
 vq state

On Wed, Sep 20, 2023 at 08:05:49AM -0400, Michael S. Tsirkin wrote:
> On Wed, Sep 20, 2023 at 07:22:32PM +0800, Zhu, Lingshan wrote:
> > 
> > 
> > On 9/20/2023 6:36 PM, Michael S. Tsirkin wrote:
> > > On Wed, Sep 20, 2023 at 02:06:13PM +0800, Zhu, Lingshan wrote:
> > > > 
> > > > On 9/19/2023 2:49 AM, Michael S. Tsirkin wrote:
> > > > > On Mon, Sep 18, 2023 at 06:41:55PM +0000, Parav Pandit wrote:
> > > > > > > Please refer to the code for setting FEATURES_OK.
> > > > > > It wont work when one needs to suspend the device.
> > > > > > There is no point of doing such work over registers as fundamental framework is over the AQ.
> > > > > Well not really. It's over admin commands. When these were built the
> > > > > intent always was that it's possible to use admin commands through
> > > > > another interface, other than admin queue. Is there a problem
> > > > > implementing admin commands over a memory BAR? For example, I can see
> > > > > an "admin command" capability pointing at a BAR where
> > > > > commands are supplied, and using a new group type referring to
> > > > > device itself.
> > > > I am not sure, if a bar cap would be implemented as a proxy for the admin vq
> > > > based live migration.
> > > Not a proxy for a vq in that there's no vq then.
> > I think if the driver sends admin commands through a VF's bar, then
> > VF forwards the admin commands to the PF, it acts like a proxy,
> > or an agent. Anyway it takes admin commands.
> 
> Why send them to the PF? They are controlling the VF anyway.
> 
> > So the problems we have discussed still exist.
> > > 
> > > > then the problems of admin vq LM that we have
> > > > discussed
> > > > still exist.
> > > I freely admit the finer points of this extended flamewar have been lost
> > > on me, and I wager I'm not the only one. I thought you wanted to migrate
> > > the device just by accessing the device itself (e.g. the VF) without
> > > accessing other devices (e.g. the PF), while Parav wants it in a
> > > separate device so the whole of the device itself can passed through to
> > > guest. Isn't this, fundamentally, the issue?
> > we are implementing basic facilities for live migration.
> > 
> > We have pointed out lots of issues, there are many discussions with
> > Jason and Parav about the problems in migration by admin vq, for example:
> > security, QOS and nested.
> 
> /me shrugs
> Thanks for the summary I guess. Same applies to almost any proposal.
> What would help make progress is an explanation why this has grown into
> a megathread.  Do you understand Parav's thoughts well enough to
> summarize them?


And Parav same goes for you - can you summarize Zhu Lingshan's position?

> > > 
> > > > the bar is only a proxy, doesn't fix anything. and even larger
> > > > side channel attacking surface: vf-->pf-->vf
> > > In this model there's no pf. BAR belongs to vf itself
> > > and you submit commands for the VF through its BAR.
> > > Just separate from the pci config space.
> > If using the bar to process admin commands,
> > is this solution too heavy compared to my proposal in this series?
> 
> somewhat - because it's more comprehensive - you can actually
> migrate a device using it.
> this series just begins to define how to poke at some
> of the vq state - it's a subset of the necessary functionality.
> 
> And it will give you a bunch of side benefits, such as
> support for legacy compat commands that were merged.
> 
> 
> 
> > > 
> > > The whole attacking surface discussion is also puzzling.  We either are
> > > or are not discussing confidential computing/TDI.  I couldn't figure
> > > it out. This needs a separate thread I think.
> > I agree confidential computing is out of spec. Parva mentioned TDISP and
> > even
> > in TDISP spec, it explicitly defined some attacking model, and PF is an
> > example.
> > 
> > It is out of spec anyway.
> 
> OK so we are ignoring TDISP applications for now? Everyone agrees on
> that?
> 
> -- 
> MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

