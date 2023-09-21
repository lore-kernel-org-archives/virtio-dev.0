Return-Path: <virtio-dev-return-13914-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF9CAE706E3
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 08:11:17 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 1E9D0335C4
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 08:11:17 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 026F1986686
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 08:11:17 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id DF2AC98667C; Thu, 21 Sep 2023 08:11:16 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CFAF698667D
	for <virtio-dev@lists.oasis-open.org>; Thu, 21 Sep 2023 08:11:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 33Ta6tvlPYeyBlXc43C8_w-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695283872; x=1695888672;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6p5T7q0LTcgkX5hPq4b85Od5qG9aMuCV8oh7RUSvK+U=;
        b=lC16RGraIG/xac4wI5LUuwy33hYbWlw/L9LR5MJmlEPzlKCMy80bBs3wtVwAnvaEAi
         m/PZJEx8mze8v6JedfWF/p6U8zjLVlLGVPt2I9pBogo7+NO8TE9C6JiAeQevClBJ8m3S
         JB01k+wqNJwv6e5QCi7uAwHIQgV9yNadtTu3LSZa7MTBE5/jb3fNM7mPNqguTnl8A0/h
         5TaUaEd8F/IEMoiyk1uI5XbWxzGCXd8vzUguuIguh1dsZVL25l9SMRX47gstGtvs7dev
         egw1jEV6CIjXVi92E7+QagVKlSChuto62rN5y5kX5/GxQD8jiN8c5OBU8CuNiInIAVTr
         KREw==
X-Gm-Message-State: AOJu0Yz17jgJVchq2p90kqJvqyrOx2xJbQSUjxhEM+7lX25yz8JmcwPv
	o8XGTbWTNtZWTBbR0PddFV2v3Y0i6ED0rUxaWxS97zwr6g9D2cyMQyCKpySw6n25Qe8autwsZad
	nrpnuKgtStFDHnn7j3Z03A0tc0Xrv
X-Received: by 2002:a05:6402:292f:b0:533:3cdd:3faf with SMTP id ee47-20020a056402292f00b005333cdd3fafmr947577edb.1.1695283872600;
        Thu, 21 Sep 2023 01:11:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHawwYKEehQ+mlKyTH52v1gZ2suTtTsn85YmMyh7YFsoy/vXwvKLZI1qwS/Uke2fo5s22x7xw==
X-Received: by 2002:a05:6402:292f:b0:533:3cdd:3faf with SMTP id ee47-20020a056402292f00b005333cdd3fafmr947561edb.1.1695283872229;
        Thu, 21 Sep 2023 01:11:12 -0700 (PDT)
Date: Thu, 21 Sep 2023 04:11:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "Zhu, Lingshan" <lingshan.zhu@intel.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	Jason Wang <jasowang@redhat.com>
Message-ID: <20230921040133-mutt-send-email-mst@kernel.org>
References: <20230920101402-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54816F8341A77E63831316DBDCF9A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230920160218-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54814A89793CF796412D6A27DCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230921004957-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481E096E0298F29C9EA73B4DCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230921015810-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481821D526E376771E70204DCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230921031129-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54810CEA225EA1BB896AF7C2DCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54810CEA225EA1BB896AF7C2DCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: Re: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and
 vq state

On Thu, Sep 21, 2023 at 07:53:18AM +0000, Parav Pandit wrote:
> 
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Thursday, September 21, 2023 12:51 PM
> 
> > > > As I said, doable without mediation but already done with.
> > > >
> > > It is not done in the virtio spec that can work without mediation right?
> >
> > have trouble parsing this sentence
> 
> I mean to say,
> Virtio spec has not achieved mediation less, device migration.
> Virtio spec has not achieved device migration using mediation.

But yes it has - it was implemented with shadow vq.

> And two proposals are trying to do it.
> 
> > 
> > > >
> > > > > > 1. For mediation something that works within existing mediation
> > > > > > framework - e.g. reusing as he does feature bits - will require
> > > > > > less support than a completely separate facility.
> > > > > > I think Zhu Lingshan also believes that since there will be less
> > > > > > code -> less security issues.
> > > > > >
> > > > > With approach of [1], there is less code in the core device
> > > > > migration flow
> > > > because none of those fields etc are parsed/read/written by the
> > > > driver software.
> > > >
> > > > What is or is not executed in a specific flow is a separate question.
> > > > But the point is vdpa and any mediation have to talk virtio things
> > > > such as feature bits. So reusing e.g. feature bits needs less code
> > > > than operating the admin command machinery to check what is
> > > > supported. Yes, you can operate this machinery during setup and not
> > > > during migration itself. It's still less code to maintain.
> > > >
> > > I wouldn't go down the path of code comparison.
> > > But if you want to: we can take a concrete example of what is done by similar
> > device who uses admin command approach.
> > > The admin command-based approach migration driver is likely 10x smaller
> > than the actual driver driving the feature bits and rest of the config.
> > 
> > yes but mediation driver already has to do feature bits. so if doing mediation
> > then the cost of adding this specific extension is low.
> >
> I thought first you were counting the cost of the code and not the spec in your point "feature bits needs less code than operating".

yes - with vdpa it's mostly just
	vdev->status |= SUSPEND
	vdev->status &= ~SUSPEND
all over the place.

> > > If one needs more precise numbers of number of lines of code, I can derive it.
> > > As features and functionality grows, every line of code gets added there in
> > mediation too.
> > > I agree such mediation has value and use case, as we know it is not the only
> > approach fitting all use cases.
> > 
> > Do you see how this extension is easier for mediation than driving admin queue
> > though?
> >
> If we count the total cost of code than building the mediation framework + extensions, than it is not.
> But as I said, I wouldn't compare two solutions as they are addressing a slightly different requirement.

yes they are. the point of comparison was explaining why people who
use mediation anyway might not want to also use aq. can i assume
that's clear?

> What to compare is what can be reused between two solutions.
>  
> > > >
> > > > > > 2. With or without mediation, the mapping of commands to VFs is
> > > > > > simpler, allowing more control - for example, let's say you want
> > > > > > to reset a VF - you do not need to flush the queue of existing
> > > > > > commands, which might potentially take a long time because some
> > > > > > other VFs are very busy - you just reset the VF which any unmap
> > > > > > flow will
> > > > already do.
> > > > > >
> > > > > If I understand you right, to reset a VF, no need to flush the
> > > > > queues without
> > > > mediation too.
> > > > > Just do VF FLR or do device reset, both will be fine.
> > > >
> > > > Not to reset the VF - that's a narrow definition. To put it back in
> > > > its original state unrelated to any VMs.  Nope, FLR is not enough -
> > > > there could be commands in queue addressing the VF. If they take
> > > > effect after FLR VF state changed and it can't be cleanly assigned to a new
> > VM.
> > > >
> > > If you mean the SR-PCIM command, than it is virtio spec to define them.
> > > We ratified this recently in the PCI-SIG of what gets cleared on VF FLR and
> > what stays that SR-PCIM interface to do.
> > 
> > Interesting. Which ECN exactly do you refer to?
> > 
> B405.
> 
> > > So if other commands are in pipe, only after they are done, such VF will be
> > assigned to new VM.
> > 
> > Exactly. this is exactly what I meant when I said "flush the queue" - you have to
> > wait until these commands are done, then do reset.
> >
> Not exactly. VF reset is fully controlled by the guest.
> Hence, it does not collide with admin side of commands,

No, host does VF reset in a number of situations, including
guest restart, guest shutdown, etc.

> Same admin command for dirty page tracking and device context do not mess with FLR.
> This is the critical because VF FLR cannot clear the page addresses already reported and not yet read by the driver.
> It is covered in admin proposal.

They might not mess with it in that you can still do FLR but they will
mess with what hosts commonly try to achieve with FLR which is getting a
clean VF that has nothing to do with a given guest state.
For example
- queue stop command on PF
- flr on VF
- stop command is seen by PF

will get you a VF that is not running and can not be given to another
guest. You have to
- queue stop command on PF
- stop command is seen by PF
- flr on VF
in this order.

> > > This aspect is also covered in the proposal [2] in the DISCARD command and
> > stop dirty page tracking (aka stop write reporting).
> > >
> > > [1]
> > > https://lore.kernel.org/virtio-comment/20230909142911.524407-7-parav@n
> > > vidia.com/T/#mf15b68617f772770c6bf79f70e8ddc6fea834cfa
> > >
> > > To me, frankly, both methods are addressing two slightly different requirement
> > due to which it may not be worth the comparison.
> > > It is not either or.
> > > And so far, technically what I understand is, both methods has its pros, cons
> > and limitations due to which both requirements (passthrough and nest) cannot
> > be addressed uniformly.
> > > Both has its space for the solution it offers.
> > > At best, two methods can find some common ground of commands or
> > plumbing to reuse, it will be great.
> > > If I am understanding is wrong, I would like to learn and discuss.
> > 
> > okay now that's progress. what it would be great next if there was a review of
> > this proposal that does not say "just use my patch instead it does the same" but
> > instead says "here is how you can reuse plumbing from my patch and it will
> > address most of your use-case".
> 
> I really didn't say it, but it is easy to miss out or interpret that.
> I assume your comment applies to both the proposals.
> 
> This is what I proposed to Lingshan to review dirty page tracking and device context from admin proposal if we find it useful in his v1.
> He didn't explain why he cannot use it.
> 
> Lingshan,
> Can we please start fresh to review requirements of both the modes (passthrough, mediation) and see what all we can converge to from both the proposals?
> (before sending vX of each series).
> This will help us to unify the plumbing if possible, on both areas.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

