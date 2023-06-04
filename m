Return-Path: <virtio-dev-return-12847-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3EFBC7EE29
	for <virtio-dev@archiver.kernel.org>; Sun,  4 Jun 2023 14:27:09 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 5654042C26
	for <virtio-dev@archiver.kernel.org>; Sun,  4 Jun 2023 14:27:09 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 43F3B986318
	for <virtio-dev@archiver.kernel.org>; Sun,  4 Jun 2023 14:27:09 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 2FCC59862CE; Sun,  4 Jun 2023 14:27:09 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1DD8B9862D0
	for <virtio-dev@lists.oasis-open.org>; Sun,  4 Jun 2023 14:27:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: aeTuM8f6PBmIHM5vIrkyyQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685888592; x=1688480592;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dybQuKxgeWtlIq4n2d3EyCsVAq/QNVdit+Q85yt309A=;
        b=QGdNQPhN+AN8UsUrc03XBuc78JBxh7x1yl67B+WihJNC5qja/zYpbTXfhSII1Nh31V
         ZZAh5eyk/P8aMmQjLx8HbPyaDBxCN/QyJJDGokKYcZ/sT8VKKb4Fd4YwanRwT0MmqPPh
         BZ3pKsPAxZ1aD2/8DHkAEUZdgldSWIxDijDfHcZEkP3Ci9tFqo7BsT6Jyht1qKK1vrBD
         KXinGDwPsH62v9qpouRygs3vfA2Our3nHYLWqc+T2oA+ogCHCiEwFSFhipXyltfG0BGj
         CGvTX8m+ONkttyl2kxFLAn7Op61Zp9prhETtYHPWHVLrmjXZ1G3q4KN4wmD+3hwH6Ps7
         hltw==
X-Gm-Message-State: AC+VfDwd32ahkBQ4UMg+FMoe0t9dfpq9Z9Witc4/ATL3z1l2J7tHJ820
	waGT/iKPGUcRlnblp3sWDzAkbvlz8Sw50OsFAxc6FAuRKocE7kuyR6XAtCMA2r+uT2CHfyRQkHC
	9+yK0vXzPxcrNizrVCREa+1gMZAZr
X-Received: by 2002:a05:600c:204e:b0:3f6:3e9:e8fc with SMTP id p14-20020a05600c204e00b003f603e9e8fcmr5512034wmg.10.1685888592420;
        Sun, 04 Jun 2023 07:23:12 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5YOUqPxzHRo/TxRptyh1aDzPpEgOpHeKVwXiuJeGaB2nDbKcOeaHpW/r2C4CBoPLKa86bZCQ==
X-Received: by 2002:a05:600c:204e:b0:3f6:3e9:e8fc with SMTP id p14-20020a05600c204e00b003f603e9e8fcmr5512018wmg.10.1685888592094;
        Sun, 04 Jun 2023 07:23:12 -0700 (PDT)
Date: Sun, 4 Jun 2023 10:23:07 -0400
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
Message-ID: <20230604101351-mutt-send-email-mst@kernel.org>
References: <20230602203604.627661-1-parav@nvidia.com>
 <20230604092441-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54815C9677C9E1F3EDE032A9DC4CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230604094535-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481443CD383D9BFA0369151DC4CA@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481443CD383D9BFA0369151DC4CA@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v3 0/3] transport-pci: Introduce legacy registers access
 using AQ

On Sun, Jun 04, 2023 at 02:10:16PM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Sunday, June 4, 2023 9:56 AM
> > 
> > On Sun, Jun 04, 2023 at 01:41:54PM +0000, Parav Pandit wrote:
> > >
> > >
> > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > Sent: Sunday, June 4, 2023 9:34 AM
> > > >
> > > > On Fri, Jun 02, 2023 at 11:36:01PM +0300, Parav Pandit wrote:
> > > > > This short series introduces legacy registers access commands for
> > > > > the owner group member PCI PF to access the legacy registers of the
> > member VFs.
> > > >
> > > > Note that some work will be needed here to fix up grammar and
> > > > spelling mistakes.
> > > >
> > > I already verified using codespell but I guess it missed few.
> > > If you have specific already identified, let me know.
> > 
> > I remember seeing something about a drier somewhere :)
> >
> Yes. I will fix it.
>  
> > > If not I will run a different checker.
> > 
> > Yea, pls check grammar too.
> > 
> Ok.
> 
> > > > > If in future any SIOV devices to support legacy registers, they
> > > > > can be easily supported using same commands by using the group
> > > > > member identifiers of the future SIOV devices.
> > > >
> > > > Yes, with the exception of
> > > > VIRTIO_ADMIN_CMD_LQ_NOTIFY_QUERY - currently refers to VF BAR,
> > > > subfunctions do not have it.
> > > A subfunction will also have its own BAR carved out from the PF BAR.
> > > A subfunction definition will be as contains as possible.
> > >
> > > > Can we find a way to have it in the PF BAR instead?
> > > At subfution level also it will be a BAR number, which will map to the PF BAR.
> > 
> > exactly. why not support this for PF too?
> > 
> > > > E.g. the notification can include VF# + VQ#?
> > > > At least as an option?
> > > No. we discussed this before to have each device on its own BAR. Hence no
> > VF# in the doorbell.

doorbell == available notification? yes in fact it's not
strictly needed since PF can use a different address for
each VF.


> > 
> > you said that you want it but without much in the way of explanation. I'm still
> > not convinced it's a workable interface. 
> You said "AQ is just fine" in v2, this is contradictory to what you write above.
> We cannot progress with dual comments like this.

I am talking about the idea of exposing legacy VQ notifications in the
PF BAR. To me it looks nicely symmetrical, all legacy emulation goes
through PF, and I think it simplifies a bunch of driver code moving some
complexity into hardware which is what you seem to be intent on?

> > Will it help if I get some feedback from
> > windows driver team on the design?
> >
> May be. I am not sure, given that these drivers are not inbox, they are not in purview of the OS vendor.

Exactly a reason we might not see new APIs?

> And OS vendor improves the OS APIs in the future for new use cases.
> 
> Even the SR-IOV model in Windows is not elaborate as Linux AFAIK.
> So I am not sure how much value add we will have.
> But sure, better to have their view.
> Will you please add them to the discussion here or I should check?

I don't think they are subscribed to the list, so I can't.
Will talk to them.

> Did anyone use vdpa acceleration on Windows?
> Do you have data points that someone wants VF acceleration on Windows hypervisor?
> If you bring the use case, I would like to see there commitment to develop the code also and it will be great to have virtio there.

We are talking about an interface that will be used tens of years from
now. If the interface is awkward to use on some platforms let's make it
easier not hide behind excuses of no demand to fix it as of last Friday.
Device vendors can choose not to support some platforms, that is their
decision. As a compromise, consider device exposing this both in a PF
and in a VF and let's allow driver to use what's most convenient?

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

