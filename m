Return-Path: <virtio-dev-return-13912-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF047CD342E
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 07:20:57 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id ECAEA2B019
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 07:20:56 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B6ECF98668D
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 07:20:56 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 9852D98667C; Thu, 21 Sep 2023 07:20:56 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8851098667D
	for <virtio-dev@lists.oasis-open.org>; Thu, 21 Sep 2023 07:20:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: a09UFSuFMu-27gENcKLqVg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695280852; x=1695885652;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bAyjvVlg7qc1+jxbZplVZ0p41+XcQEFE/NpFf/M5p8M=;
        b=k6Pu5RNDxwFvM32jTZA1wJIvXpthJZD8tBsJUC0P7BOSMzN4/q0jJ1/xqO8vKbJ2Pu
         dCAzpXjHQE4fkayPwe/17U6phcNF2jnXFbnGXlDs6UJsBOGOKPBBQGwf9Dg5gGTtvEnE
         VU25B7oibGEYJS8rdajJ8O8PcQMl6NWC5DVh81fh8abpbvz7w4Sxe0cmXUm+OFbcMTiL
         mKIAVLErChvFE39EfablrNMdD8ZnC1Aueqku3jiv/Z/9KGzsYRzPFfDoJ18DjaHKLpxE
         RJ+pTUyzSRpSPUySeVupE/CB16dCy23us1Rr9B6jYz1E4EMRk+/tRJ6G9+ruHrvBxjDd
         Aklg==
X-Gm-Message-State: AOJu0YxEuT8XbavQg7WtvSnu5piETbGIQFBYsVAwi+yU+8gL4VtOSPZu
	Gi0RVhlkDAsTRCcqfV1zusoqsklHPC8eFjWuSFOk72Qp3yHsi2Ch8xvwU+I4YAHcBY82j4pyX/l
	ZvrIClU+OjNWvEM79pp/hv0sfITr1
X-Received: by 2002:a17:906:2cc:b0:9a5:b878:7336 with SMTP id 12-20020a17090602cc00b009a5b8787336mr4614229ejk.7.1695280852433;
        Thu, 21 Sep 2023 00:20:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDdlpoPmD0ZytDCkLLFmznK45W8BzXC8CfOBxEc8e3/EmeETTegK9esXMdVbAS0U8Q9sUecQ==
X-Received: by 2002:a17:906:2cc:b0:9a5:b878:7336 with SMTP id 12-20020a17090602cc00b009a5b8787336mr4614216ejk.7.1695280852087;
        Thu, 21 Sep 2023 00:20:52 -0700 (PDT)
Date: Thu, 21 Sep 2023 03:20:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "Zhu, Lingshan" <lingshan.zhu@intel.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	Jason Wang <jasowang@redhat.com>
Message-ID: <20230921031129-mutt-send-email-mst@kernel.org>
References: <20230920084058-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548110E53C924C984FA24A49DCF9A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230920101402-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54816F8341A77E63831316DBDCF9A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230920160218-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54814A89793CF796412D6A27DCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230921004957-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481E096E0298F29C9EA73B4DCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230921015810-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481821D526E376771E70204DCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481821D526E376771E70204DCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: Re: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and
 vq state

On Thu, Sep 21, 2023 at 06:31:01AM +0000, Parav Pandit wrote:
> 
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Thursday, September 21, 2023 11:37 AM
> 
> > > We should be enhancing the device context so that more and more items can
> > be annotated.
> > > I started with small to get the design and idea through and will expand the
> > device context so that cross vendors can migrate.
> > 
> > As I said, doable without mediation but already done with.
> >
> It is not done in the virtio spec that can work without mediation right?

have trouble parsing this sentence

> > 
> > > > 1. For mediation something that works within existing mediation
> > > > framework - e.g. reusing as he does feature bits - will require less
> > > > support than a completely separate facility.
> > > > I think Zhu Lingshan also believes that since there will be less
> > > > code -> less security issues.
> > > >
> > > With approach of [1], there is less code in the core device migration flow
> > because none of those fields etc are parsed/read/written by the driver
> > software.
> > 
> > What is or is not executed in a specific flow is a separate question.
> > But the point is vdpa and any mediation have to talk virtio things such as feature
> > bits. So reusing e.g. feature bits needs less code than operating the admin
> > command machinery to check what is supported. Yes, you can operate this
> > machinery during setup and not during migration itself. It's still less code to
> > maintain.
> >
> I wouldn't go down the path of code comparison.
> But if you want to: we can take a concrete example of what is done by similar device who uses admin command approach.
> The admin command-based approach migration driver is likely 10x smaller than the actual driver driving the feature bits and rest of the config.

yes but mediation driver already has to do feature bits. so if doing
mediation then the cost of adding this specific extension is low.

> If one needs more precise numbers of number of lines of code, I can derive it.
> As features and functionality grows, every line of code gets added there in mediation too.
> I agree such mediation has value and use case, as we know it is not the only approach fitting all use cases.

Do you see how this extension is easier for mediation than driving
admin queue though?

> > 
> > > > 2. With or without mediation, the mapping of commands to VFs is
> > > > simpler, allowing more control - for example, let's say you want to
> > > > reset a VF - you do not need to flush the queue of existing
> > > > commands, which might potentially take a long time because some
> > > > other VFs are very busy - you just reset the VF which any unmap flow will
> > already do.
> > > >
> > > If I understand you right, to reset a VF, no need to flush the queues without
> > mediation too.
> > > Just do VF FLR or do device reset, both will be fine.
> > 
> > Not to reset the VF - that's a narrow definition. To put it back in its original state
> > unrelated to any VMs.  Nope, FLR is not enough - there could be commands in
> > queue addressing the VF. If they take effect after FLR VF state changed and it
> > can't be cleanly assigned to a new VM.
> > 
> If you mean the SR-PCIM command, than it is virtio spec to define them.
> We ratified this recently in the PCI-SIG of what gets cleared on VF FLR and what stays that SR-PCIM interface to do.

Interesting. Which ECN exactly do you refer to?

> So if other commands are in pipe, only after they are done, such VF will be assigned to new VM.

Exactly. this is exactly what I meant when I said "flush the queue" -
you have to wait until these commands are done, then do reset.

> This aspect is also covered in the proposal [2] in the DISCARD command and stop dirty page tracking (aka stop write reporting).
> 
> [1] https://lore.kernel.org/virtio-comment/20230909142911.524407-7-parav@nvidia.com/T/#mf15b68617f772770c6bf79f70e8ddc6fea834cfa
> 
> To me, frankly, both methods are addressing two slightly different requirement due to which it may not be worth the comparison.
> It is not either or.
> And so far, technically what I understand is, both methods has its pros, cons and limitations due to which both requirements (passthrough and nest) cannot be addressed uniformly.
> Both has its space for the solution it offers.
> At best, two methods can find some common ground of commands or plumbing to reuse, it will be great.
> If I am understanding is wrong, I would like to learn and discuss.

okay now that's progress. what it would be great next if there was a
review of this proposal that does not say "just use my patch instead it
does the same" but instead says "here is how you can reuse plumbing from
my patch and it will address most of your use-case".

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

