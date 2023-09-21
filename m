Return-Path: <virtio-dev-return-13907-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 466D7CD4958
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 05:42:10 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 7A7C52B013
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 05:42:09 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 543FF986688
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 05:42:09 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 3CDD6983EB5; Thu, 21 Sep 2023 05:42:09 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2CB3F98667C
	for <virtio-dev@lists.oasis-open.org>; Thu, 21 Sep 2023 05:42:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: M2x1oCsxMMSWp5WkZSdK9g-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695274925; x=1695879725;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ub2Rim5wEUpkKeR2hZr0UKA6vEGp63tch8o1Ib3htEs=;
        b=pqk/lhYHDpJbyaPnPbTrLpfd3PwYn5LBiyZsr6UM2ak/Iuv3I231cxBGlb5M5b/hNB
         8BQ4MtmkUmpfBL4HjztFQWlb7nWXztBZ4HGpxQFhwrNV5gXTTbJhtOmOsJRYiyxGojwM
         dQ9vpYmT9T1k2ioFeQ8ZWEN7hOqoSH17ryHub+g9/X4ID4iuPS4T3sWtuxiGyU/RWJQT
         DmWakxPTJKS7Y7S3tPdlpvhXj8mmDXXiMVcTyaCvoOzMiH6vBZKLERYcuxS8DsEX2SID
         TzMB1+gKIxbIzEsth4WYRsUw4Do0EPIiXnUh+Cn/Wifnat/Ui0i2BgKl5HXKqVSIyMbL
         7TXw==
X-Gm-Message-State: AOJu0YydQWCZJoNNmkxjiwlWo4R59QuwV6v+Rl9RfzGFqb9wXfs5JbMf
	BHKBbn9AgCLnlYW3Fg4tdcV1LwhuqRSuo7m6kE9uwRhr6WdmPLeAwBBJae/YJLblvhPNIJLpcA1
	dMByb9T/NkVdAu28DgI7OcGCtO8AZ
X-Received: by 2002:a17:906:5a6e:b0:9ae:5212:e3b with SMTP id my46-20020a1709065a6e00b009ae52120e3bmr2407390ejc.5.1695274925404;
        Wed, 20 Sep 2023 22:42:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHzl5yAtQulKw45/iD3YOIPeFjJcGgUFdZRfNDpgj/g3465F2ERpX0F4nqy3pKLT5bwwEbfg==
X-Received: by 2002:a17:906:5a6e:b0:9ae:5212:e3b with SMTP id my46-20020a1709065a6e00b009ae52120e3bmr2407382ejc.5.1695274925052;
        Wed, 20 Sep 2023 22:42:05 -0700 (PDT)
Date: Thu, 21 Sep 2023 01:41:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "Zhu, Lingshan" <lingshan.zhu@intel.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	Jason Wang <jasowang@redhat.com>
Message-ID: <20230921004957-mutt-send-email-mst@kernel.org>
References: <bb402c34-ad07-063a-f4f5-d8c6b3a642c7@intel.com>
 <20230920054836-mutt-send-email-mst@kernel.org>
 <2f67fb85-2238-9c34-a265-b0f97b7ab7e1@intel.com>
 <20230920075243-mutt-send-email-mst@kernel.org>
 <20230920084058-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548110E53C924C984FA24A49DCF9A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230920101402-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54816F8341A77E63831316DBDCF9A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230920160218-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54814A89793CF796412D6A27DCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54814A89793CF796412D6A27DCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: Re: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and
 vq state

On Thu, Sep 21, 2023 at 03:43:12AM +0000, Parav Pandit wrote:
> 
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Thursday, September 21, 2023 1:34 AM
> > 
> > On Wed, Sep 20, 2023 at 05:21:52PM +0000, Parav Pandit wrote:
> > > > OK so with this summary in mind, can you find any advantages to
> > > > inband+mediation that are real or do you just see disadvantages? And
> > > > it's a tricky question because I can see some advantages ;)
> > >
> > > inband + mediation may be useful for nested case.
> > 
> > Hint: there's more.
> 
> Can you please list down?
> 
> The starting point of discussion is, there is passthrough member device without mediation in virtio interface layers.
> How shall device migration should work for it?

I was attempting to have each of you see other's point of view.
It seems clear I was right, at least one way communication was
not getting through. Let me try to help.


First, clearly Zhu Lingshan cares about the mediation use-case, not the
un-mediated one.  Mediation is clearly heavier but also more powerful
in many use-cases - is that obvious or do I need to list the reasons?
To mention one example, it supports cross-vendor migration. Which the unmediated
variant maybe can in theory support too, and when it does maybe in a better and
more structured way - but that will require standartization effort that
didn't happen yet. With mediation it was already demonstrated more than
once.

1. For mediation something that works within existing mediation framework -
e.g. reusing as he does feature bits - will require less support
than a completely separate facility.
I think Zhu Lingshan also believes that since there will be less code ->
less security issues.

2. With or without mediation, the mapping of commands to VFs is simpler,
allowing more control - for example, let's say you want to reset a VF -
you do not need to flush the queue of existing commands, which might
potentially take a long time because some other VFs are very busy - you
just reset the VF which any unmap flow will already do.



But Zhu Lingshan, all this will be pointless if you also do not try to
do this and list what are reasonable points that Parav made. Please do
not mistake what I'm doing here for taking sides I just want the
communication to start working. And that means everyone tries to take
all use-cases into account even if working for a vendor that does not
care about this use-case. Otherwise we will just keep getting into these
flamewars.
-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

