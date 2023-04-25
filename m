Return-Path: <virtio-dev-return-12416-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 685EAC6FD18
	for <virtio-dev@archiver.kernel.org>; Tue, 25 Apr 2023 20:55:58 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 520141456B3
	for <virtio-dev@archiver.kernel.org>; Tue, 25 Apr 2023 20:55:56 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4A00A986641
	for <virtio-dev@archiver.kernel.org>; Tue, 25 Apr 2023 20:55:56 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 3CE0C986475; Tue, 25 Apr 2023 20:55:56 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 27F249864A2
	for <virtio-dev@lists.oasis-open.org>; Tue, 25 Apr 2023 20:55:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: GJiXHNycOTWN0We_-JHAbA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682456150; x=1685048150;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F/ag6fvmgxoMa10Rt7MJYhmieAGDE3VoomX1bDoIEOg=;
        b=jd1bUsxBrlcRjYWy+lQYAXfOyT9sJxJwQiXZzbZBjnynewCQqvCLxq6olU/vP6enMA
         EO59MWfgplQJuQFhCRX0/sLZXMY5aY3wrnICS80I39Nj0YWYABd8hYwaHT5MQXFHsUpS
         eH8bzciOVoFnFBXKkJjVxJpfSGFajuZh4sVWm40XveR4ijleGY+n3agdOVR2+XHs7riM
         cwE9tbTD2qKEqAFYSaRGXa3/Tan5qsd9FHuiXC+cemACefmOLopAb1oBthvIOwQQc5AN
         CueCjfU+rjir6W1ylUDNeUtCg1oHqonE2/vpJ9OV95s+DDAn+daxW8utFKRlTJousdVz
         mrtw==
X-Gm-Message-State: AAQBX9dl3eRohnPwLYG1hkeHyOCuWBha4CYEO6Qexggr4DGUpRIUNh9o
	CbL5AiIJlGJxnjy4c6T3li/dKC8JVCyiVsA8wKdhAduwVynSSMRQIIZ1LlTB6wwIuoB4HuGfzDo
	4N674pclhatTJpCqnCC1gbzgRopYW
X-Received: by 2002:a1c:7211:0:b0:3ef:8b0:dbb1 with SMTP id n17-20020a1c7211000000b003ef08b0dbb1mr11139913wmc.7.1682456150679;
        Tue, 25 Apr 2023 13:55:50 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZYPPb6PpBng8v2V072xo8VKSGSKPcf+1En3llWkO+Q9fftwb4CE2lyrin0VrW6neV0PMVXkw==
X-Received: by 2002:a1c:7211:0:b0:3ef:8b0:dbb1 with SMTP id n17-20020a1c7211000000b003ef08b0dbb1mr11139901wmc.7.1682456150383;
        Tue, 25 Apr 2023 13:55:50 -0700 (PDT)
Date: Tue, 25 Apr 2023 16:55:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"sgarzare@redhat.com" <sgarzare@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>,
	"nrupal.jani@intel.com" <nrupal.jani@intel.com>,
	"Piotr.Uminski@intel.com" <Piotr.Uminski@intel.com>,
	"hang.yuan@intel.com" <hang.yuan@intel.com>,
	"virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>,
	Jiri Pirko <jiri@nvidia.com>, Zhu Lingshan <lingshan.zhu@intel.com>,
	"pasic@linux.ibm.com" <pasic@linux.ibm.com>,
	Shahaf Shuler <shahafs@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <20230425162425-mutt-send-email-mst@kernel.org>
References: <cover.1682354275.git.mst@redhat.com>
 <79c27bca6f72e4ea5d1d0e3a6b1a54369b03fb30.1682354275.git.mst@redhat.com>
 <e9256f17-f9ab-de6d-0377-d9fc210a7cc0@nvidia.com>
 <20230425020925-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481D9A42176A43075D4AD4DDC649@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230425092651-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481BB7BCD1D9FF68395633BDC649@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230425160346-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548102A2FD30A15994D6C0F5DC649@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB548102A2FD30A15994D6C0F5DC649@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v12 03/10] admin: introduce group administration commands

On Tue, Apr 25, 2023 at 08:18:54PM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Tuesday, April 25, 2023 4:05 PM
> > > Ok. I feel it is still worth to have commit log updated. If you happen to revise
> > v13, please do.
> > > Else its fine.
> > >
> > > v12 surely doesn't merge cleanly. So v13 is needed anyway.
> > >
> > > Can you please generate? Patch-5 of v12 fails to apply.
> > 
> > should apply on top of 985bbf397db4228faf3ec464e838687dc4cb4904.  master
> > will fail because of the file movement.  I will need to rebase to apply on latest
> > master, I will do it before we start voting.
> 
> Ok. sounds good. I assume you will post rebased v13 with commit log updated?
> When do you plan to do?
> I request that it is better to rebase now because legacy related patches need to touch the add the PCI extended capability on top of your changes.

I can rebase and push to a branch. Day after tomorrow at the earliest
due to a holiday.  I don't want to repost right now, spamming is not
polite to reviewers, several days need to pass.

> This results in further manual merges for me.
> Better to do the work once with one time rebase, instead of both of us.
> 
> Let me know if I should generate v13 fixing above two items as you have holiday this week.
> It helps me build on top of AQ patches with one time rebase.

I pushed the rebase to tag mst-admin-v13 on github.

Don't have time for tweaks it's a holiday.
I usually leave patches on list for a week or so.
If no comments I will post v13 and we will roll a vote.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

