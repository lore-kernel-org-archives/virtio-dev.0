Return-Path: <virtio-dev-return-13869-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AF3FCE79C2
	for <virtio-dev@archiver.kernel.org>; Wed, 20 Sep 2023 10:36:19 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 4007F866A8
	for <virtio-dev@archiver.kernel.org>; Wed, 20 Sep 2023 10:36:19 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2246E986673
	for <virtio-dev@archiver.kernel.org>; Wed, 20 Sep 2023 10:36:19 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 0A5BD986669; Wed, 20 Sep 2023 10:36:19 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EE5A698666A
	for <virtio-dev@lists.oasis-open.org>; Wed, 20 Sep 2023 10:36:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: MYyfMcqCPQCrA9FkoNBWrQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695206175; x=1695810975;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jm9/CcI7dS+JPYILm6Lubc8U3ps3J4bILXT5ivSOBAk=;
        b=VJ460hkg/gfVardwF5zPrpfBAJx8TOcbhjhllhQbPjewEzFLHZdqc1QSg0YVutSLTS
         qWSmFmFq3L8T52nRzgaTy8RewJe61mx3qZv2/mduhBg7yi6y3jSiKPXvPHOZmKrHMUJT
         Nsp5RJ6Mgj9FNFcw0Ex0V67PvFNuM+Ryay1Op6V3vs1WUxeO3JIKHMyHEBjBd3lCrspa
         sqTzPTVxSvSltSHQeTkqGzDSIvBOEpON/bSxwBSGEXcDYzU0SMMbsZmeCCDdLAfMJnAL
         Sg56lAPq6Gy0ACVeKTz3GBugq2QDkHQFQtIG+izzJFNSWNBxQc51sXaKPNXfdm8N3RBZ
         EbbQ==
X-Gm-Message-State: AOJu0Yx1oguhkOcit9vO0JFtz4z1cExRBDy+oSZBHX7iNijRaFqOKwHH
	AV1Vo0H0qpyTTnKnPKnF9CoUDzscNvUXoXe8w+R4qu0V1ZOBj050SSOJTYWykH2pCGK0NP25DnM
	StVlueoEpStv3NkgGviUmMy7uUnLy
X-Received: by 2002:aa7:d391:0:b0:52b:c8d9:1d66 with SMTP id x17-20020aa7d391000000b0052bc8d91d66mr1532871edq.42.1695206175695;
        Wed, 20 Sep 2023 03:36:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkPpDu3fE5NifcF7cVUquDLzFi0bGlZLhjhlYhP3PorN7DsYn3kAwhiGHjGUmrNB4IZWV6UA==
X-Received: by 2002:aa7:d391:0:b0:52b:c8d9:1d66 with SMTP id x17-20020aa7d391000000b0052bc8d91d66mr1532860edq.42.1695206175365;
        Wed, 20 Sep 2023 03:36:15 -0700 (PDT)
Date: Wed, 20 Sep 2023 06:36:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>
Cc: Parav Pandit <parav@nvidia.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	Jason Wang <jasowang@redhat.com>
Message-ID: <20230920054836-mutt-send-email-mst@kernel.org>
References: <PH0PR12MB5481C41D4F32DA26D5831471DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <67680965-b115-32c7-dfdf-c56ab37bdd81@intel.com>
 <213a0f94-cee2-d8c5-3c5d-d2d7fc920e75@intel.com>
 <PH0PR12MB5481AE8C6E5EAFE9A4ADA6F6DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <f1fe513e-d42d-03a6-348c-5e58aac0a759@intel.com>
 <PH0PR12MB5481323A3B4D67EB66328476DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <5f01772f-eb27-bfe0-7f69-b83fbd90dda0@intel.com>
 <PH0PR12MB5481ABF4B9BC2082BC54AB1DDCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230918144312-mutt-send-email-mst@kernel.org>
 <bb402c34-ad07-063a-f4f5-d8c6b3a642c7@intel.com>
MIME-Version: 1.0
In-Reply-To: <bb402c34-ad07-063a-f4f5-d8c6b3a642c7@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: Re: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and
 vq state

On Wed, Sep 20, 2023 at 02:06:13PM +0800, Zhu, Lingshan wrote:
> 
> 
> On 9/19/2023 2:49 AM, Michael S. Tsirkin wrote:
> > On Mon, Sep 18, 2023 at 06:41:55PM +0000, Parav Pandit wrote:
> > > > Please refer to the code for setting FEATURES_OK.
> > > It wont work when one needs to suspend the device.
> > > There is no point of doing such work over registers as fundamental framework is over the AQ.
> > Well not really. It's over admin commands. When these were built the
> > intent always was that it's possible to use admin commands through
> > another interface, other than admin queue. Is there a problem
> > implementing admin commands over a memory BAR? For example, I can see
> > an "admin command" capability pointing at a BAR where
> > commands are supplied, and using a new group type referring to
> > device itself.
> I am not sure, if a bar cap would be implemented as a proxy for the admin vq
> based live migration.

Not a proxy for a vq in that there's no vq then.

> then the problems of admin vq LM that we have
> discussed
> still exist.

I freely admit the finer points of this extended flamewar have been lost
on me, and I wager I'm not the only one. I thought you wanted to migrate
the device just by accessing the device itself (e.g. the VF) without
accessing other devices (e.g. the PF), while Parav wants it in a
separate device so the whole of the device itself can passed through to
guest. Isn't this, fundamentally, the issue?

> the bar is only a proxy, doesn't fix anything. and even larger
> side channel attacking surface: vf-->pf-->vf

In this model there's no pf. BAR belongs to vf itself
and you submit commands for the VF through its BAR.
Just separate from the pci config space.

The whole attacking surface discussion is also puzzling.  We either are
or are not discussing confidential computing/TDI.  I couldn't figure
it out. This needs a separate thread I think.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

