Return-Path: <virtio-dev-return-12858-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 105F8C7EE24
	for <virtio-dev@archiver.kernel.org>; Mon,  5 Jun 2023 05:52:05 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 361BDC6225
	for <virtio-dev@archiver.kernel.org>; Mon,  5 Jun 2023 05:52:05 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2190D986423
	for <virtio-dev@archiver.kernel.org>; Mon,  5 Jun 2023 05:52:05 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 07EAA98633F; Mon,  5 Jun 2023 05:52:05 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DFBD398634B
	for <virtio-dev@lists.oasis-open.org>; Mon,  5 Jun 2023 05:52:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: LIdEpDbcN9eISOLqET4GKg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685944321; x=1688536321;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kOyrVr3blhfvjoWSnvGMl4xI8Hxfh0XzRzn4ppUBkcE=;
        b=AJll3PJ0GPaVv7N2yix0vS1uZsiA/6keI68GsCJCNDftLINRrKEvsQuzO+uD6J5UhE
         lWT+kGMT0QLQBU/zlHPEutWmo58C2C1Py2uBJGZOJgWbLyNc4uUKHe/4FxUNvzdqnsME
         kNmihBLELMT0pj8kFFomZYnVNfqVd+pud925+TZUONjcI1yRflOAOWR7BQ3SpQLoMmGQ
         V934aJ1NA5Y2lTniP7ENQ/41ZorkmDNljrR/LQsygBd5LE24gsoJIX/HfVehEnN7lBW2
         uG6LKyTcGakL9aYYKsgTgpT6mXdS0DXLTdWprbZfCtQiNbD/08WyEUQo7CYkAMabELRz
         oPxQ==
X-Gm-Message-State: AC+VfDxy5GmuqO5DJi5I0WhsL9Ko6YyrpKM375Wz7BNwGwYF+McIAYo0
	0J4mWAZQAQCNK/ECLKMg+f2onAJfZj9UymPokt2uiW71YB2wKjPSo4YDrsdI2UfjmLCwgdWTKEh
	I6xKvfBhuMbMyrFXL3VVwWMF5JHGQ
X-Received: by 2002:a1c:7512:0:b0:3f6:af2:8471 with SMTP id o18-20020a1c7512000000b003f60af28471mr6778515wmc.26.1685944321633;
        Sun, 04 Jun 2023 22:52:01 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7zN4A1bxTPjp1x8qVuWh70OP382MSsn9NUvbsW1o7CbreS/xxB40GMSRX2BY8jp7+F9OY9Aw==
X-Received: by 2002:a1c:7512:0:b0:3f6:af2:8471 with SMTP id o18-20020a1c7512000000b003f60af28471mr6778503wmc.26.1685944321302;
        Sun, 04 Jun 2023 22:52:01 -0700 (PDT)
Date: Mon, 5 Jun 2023 01:51:57 -0400
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
Message-ID: <20230605014539-mutt-send-email-mst@kernel.org>
References: <20230604092441-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54815C9677C9E1F3EDE032A9DC4CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230604094535-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481443CD383D9BFA0369151DC4CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230604101351-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548139ACEC00E7CA6D988182DC4CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230604105027-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481B721C34D85D63FCC1F3DDC4CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230604174224-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481DABA25CA36A5460B13E5DC4CA@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481DABA25CA36A5460B13E5DC4CA@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v3 0/3] transport-pci: Introduce legacy registers access
 using AQ

On Sun, Jun 04, 2023 at 11:40:54PM +0000, Parav Pandit wrote:
> 
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Sunday, June 4, 2023 5:49 PM
> 
> > > Legacy can utilize the 1.x hw plumbing without building new hypothetical PF
> > hardware.
> > 
> > Maybe.
> > Whether 1.x BAR can be reused for legacy would depend on a bunch of factors.
> > E.g. with 1.x using VIRTIO_F_NOTIF_CONFIG_DATA - probably not.
> >
> Not really because legacy doesn't have that feature.
> Legacy notifications are subset of 1.x feature.
> This was also discussed.

So for legacy such hardware will likely not want to use the same BAR.


> > Let's just say, we are not in the position where we dictate these things to OS
> > vendors yet.  One of motivations of the spec is making writing drivers easier so
> > let's add an option for that pls.
> >
> There is no need to add multiple options at this point when the hw vendors are not going to implement.
> When we find another vendor to implement, we can always add the new method.
> Marvell and Nvidia both are forwarding with AQ at present proposal.
> 
> > > VF has BAR for driver notifications. This BAR is used for 1.x and legacy.
> > 
> > But it's the same piece of silicon - be it in PF or in VF.
> > I really don't see why it matters.
> >
> In same piece of silicon one needs to open yet another PCI steering entry to tell that treat this for VF.
> This double size programming is useless.
> 
> Yet again we are discussing same point as before.
> 
> > > There is no need to ask vendors to build new HW to put driver notifications
> > on the PF BAR for VFs, when it already exists on the VF.
> > I'm talking about giving vendors an option not asking them.
> >
> Ok. Understood.
> When a vendor prefers to implement such cross hw forwarding it can be done.
> There isn't a desire to burn and program extra hw for functionality that already exists on the VF.
> Hence, VF's doorbell on PF can be parked for the future option when one actually wants to implement it.

I reached out to windows team to know how big a problem this is. Let's
see.


I have another idea meanwhile: VF already has notification
capability. The only issue is offset has to be queried through modern
BAR.  How about we agree that for legacy, we just agree that offset 0 is
used?  Does not sound like a big sacrifice of memory to me, and we
completely avoid the new command and the need to tie PF and VF.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

