Return-Path: <virtio-dev-return-12851-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD462C77B73
	for <virtio-dev@archiver.kernel.org>; Sun,  4 Jun 2023 14:54:07 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 2284642567
	for <virtio-dev@archiver.kernel.org>; Sun,  4 Jun 2023 14:54:07 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1952B986324
	for <virtio-dev@archiver.kernel.org>; Sun,  4 Jun 2023 14:54:07 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 0D0FB9862CE; Sun,  4 Jun 2023 14:54:07 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F118E9862D0
	for <virtio-dev@lists.oasis-open.org>; Sun,  4 Jun 2023 14:54:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: k-mJT1YUOPShPb6GBUrQOA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685890426; x=1688482426;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kf/QImxZ5SccSoqxfDAWPORT6Cvo3Demo2LX7935Mzs=;
        b=CVP1ma0M8pzgcfzmGRHLURp0lvet+BFf5UrNNujt+CXiQ9E5F9UjH4aB+pH0/GvOIE
         hX+yLPQPTd8hzR2nrrM55efN5QnaA++TqvzBHCq4/oyJqyKUxnn4R3HyCwEl6gidHUWc
         Sm9BD/ItSAKrGcn1XhF320is12WNfJmEimAWxkgww9sHv+5QbT+KNRuRDGBSgzE1Bi50
         1s2yVPdwF0JopuG16gUKynJEXcMnO6Oc81f8kWK4L+9WdyrUcha2dGPuWDU63uJrNu5D
         DuTKji3tEn9Xac/ZF4R58tWzL0JX1dN5HwLz5FpRDekeR4BJtEJIrnrqSizgcwkLazwR
         cMYw==
X-Gm-Message-State: AC+VfDypt7vN4up9BR/Vq2baB8UjrkMwYvzPbVeVuc87Cc7WitLRAojg
	EtsKm4y29SSe2ven6O/oLeXjy79IWgR5Z7qQl+B4ZhHA25umeoheci6Lni7x9DEb8Qdn/vKbGtX
	RXZw8tikPLh3rI5v4PA23l55KrhVQ
X-Received: by 2002:a5d:5915:0:b0:30a:e70d:8022 with SMTP id v21-20020a5d5915000000b0030ae70d8022mr3739042wrd.26.1685890425899;
        Sun, 04 Jun 2023 07:53:45 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7N9SyTidQBbamVcm3s8PRSbGUacGYi77hZK+59IMpb7ALIxkYqqNJNG4NXSV8BiZ+fx9p6oA==
X-Received: by 2002:a5d:5915:0:b0:30a:e70d:8022 with SMTP id v21-20020a5d5915000000b0030ae70d8022mr3739035wrd.26.1685890425606;
        Sun, 04 Jun 2023 07:53:45 -0700 (PDT)
Date: Sun, 4 Jun 2023 10:53:40 -0400
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
Message-ID: <20230604105027-mutt-send-email-mst@kernel.org>
References: <20230602203604.627661-1-parav@nvidia.com>
 <20230604092441-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54815C9677C9E1F3EDE032A9DC4CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230604094535-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481443CD383D9BFA0369151DC4CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230604101351-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548139ACEC00E7CA6D988182DC4CA@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB548139ACEC00E7CA6D988182DC4CA@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v3 0/3] transport-pci: Introduce legacy registers access
 using AQ

On Sun, Jun 04, 2023 at 02:48:59PM +0000, Parav Pandit wrote:
> 
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Sunday, June 4, 2023 10:23 AM
> 
> > > > > > E.g. the notification can include VF# + VQ#?
> > > > > > At least as an option?
> > > > > No. we discussed this before to have each device on its own BAR.
> > > > > Hence no
> > > > VF# in the doorbell.
> > 
> > doorbell == available notification? yes in fact it's not strictly needed since PF can
> > use a different address for each VF.
> > 
> Sorry for doorbell terminology.
> Yes, available buffer notification.
> 
> > 
> > I am talking about the idea of exposing legacy VQ notifications in the PF BAR. To
> > me it looks nicely symmetrical, all legacy emulation goes through PF, and I think
> > it simplifies a bunch of driver code moving some complexity into hardware
> > which is what you seem to be intent on?
> > 
> Symmetrical only looks fine in emails.
> In real device, it doesn't. We also discussed this before.
> I will capture this in alternatives section of v4.
> 
> Each VF has its own available buffer notification in hardware like 1.x.
> We do not want to duplicate (and add) such functionality on the PF BAR hardware when it already exists on the VF.

yes but here we are talking about legacy notifications, not 1.x

> > > > Will it help if I get some feedback from windows driver team on the
> > > > design?
> > > >
> > > May be. I am not sure, given that these drivers are not inbox, they are not in
> > purview of the OS vendor.
> > 
> > Exactly a reason we might not see new APIs?
> > 
> I don't know.

Exactly.

> > > And OS vendor improves the OS APIs in the future for new use cases.
> > >
> > > Even the SR-IOV model in Windows is not elaborate as Linux AFAIK.
> > > So I am not sure how much value add we will have.
> > > But sure, better to have their view.
> > > Will you please add them to the discussion here or I should check?
> > 
> > I don't think they are subscribed to the list, so I can't.
> > Will talk to them.
> > 
> Ok.
> 
> > > Did anyone use vdpa acceleration on Windows?
> > > Do you have data points that someone wants VF acceleration on Windows
> > hypervisor?
> > > If you bring the use case, I would like to see there commitment to develop the
> > code also and it will be great to have virtio there.
> > 
> > We are talking about an interface that will be used tens of years from now. If the
> > interface is awkward to use on some platforms let's make it easier not hide
> > behind excuses of no demand to fix it as of last Friday.
> It is not hiding.
> The fact that virtio drivers are not inbox. I don't see an actual user by the OS vendor for the decade passed.

But why does it matter? There are a bunch of users of virtio, I know that.

> And, I do not anticipate use of legacy for tens of years from now.
> 
> It is not even a conclusion that it is awkward to use.
> You are concluding that one OS may never want to evolve their kernel APIs.

They might. That takes many years too.

> I don't see it that way.
> We have seen with two hypervisors evolving their kernel APIs and both have large deployments.
> 
> I am not pessimistic that 3rd OS vendor will not evolve.
> 
> > Device vendors can choose not to support some platforms, that is their
> > decision. As a compromise, consider device exposing this both in a PF and in a
> > VF and let's allow driver to use what's most convenient?
> >
> I also said yes, for this and you said "lets do one way".
> 
> So, when a 2nd OS vendor cannot use IPR scheme that they have, and they MUST have everything through ONLY VF, to support them, a HW vendor will build PCI device with VF legacy access registers stay in the VF.
> And spec update will be done.
> 
> We really don't see this happening. So better to build a practical spec.
> 
> And if this was important, I am still puzzled why you say "Just AQ is fine" in v2 and why you wait for next 2 weeks for v3 to show up to raise the concern now contradicting your ACK.

Because this is just AQ. All I am asking is that the BAR refers to PF,
same AQ command.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

