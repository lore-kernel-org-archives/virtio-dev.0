Return-Path: <virtio-dev-return-13928-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BAE7E71069
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 13:05:29 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id C4B152AC4B
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 13:05:28 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A93A798668B
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 13:05:28 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 9067A986688; Thu, 21 Sep 2023 13:05:28 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CFF71986689
	for <virtio-dev@lists.oasis-open.org>; Thu, 21 Sep 2023 13:04:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: EY2yjclFOImUiV2sRw57Ow-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695301493; x=1695906293;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YXPfTQNQH48EmlfUavkq0WLjRt1okuYvPQTugeOHLqw=;
        b=NYDT6LwpJ9jNmIc+J7VX2CnASLmA8yberOWDghe88yuORTYuv7DGKSmUajaLi4is2f
         Vt0dZWXFpUl5NmE5cigrPUpaNr0t6fsPk68Sv7SF7W3wTUFHSBvSEKGY6lEQ7FgEcW/S
         oBmSwNZkoQ43l7l7RdUMVijKioYnVlHvmrjMPL4JZGA/DgztHW4FMVpiHlaLnncSfVmZ
         BPSak5s6ZmDGXazI5n58kSIrK5+euvlxO797Tau/DdxNPuYfJ1T7r7HctWw3espyIzOy
         olWu5u5YCegly9hkjZvepTVqEU/1aaccshBLWCoKkGXt7QiP0AK25QzU3g7e8E0POFac
         9ohg==
X-Gm-Message-State: AOJu0YyxbI6sjQ8D6HoOtLpr67RdYMZapHHFa6cyW7GrOFZOxI9s4vZA
	kNy9WciPNnme/hu7m8kRLkK8XC0NXbf5XPSNQnUDQ8Hm3LTduXJwJpGsSfKFj8Rx7JKXYTqw9AV
	Yet3ycZ9f24vdWsBPI5Tj8RU0wjNo
X-Received: by 2002:adf:e604:0:b0:319:7c7d:8d1 with SMTP id p4-20020adfe604000000b003197c7d08d1mr4429427wrm.44.1695301493594;
        Thu, 21 Sep 2023 06:04:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5eAupfXIb6VgmFGJH6R1839G7r6tKiSXa3q8zoLTtvPzMHnunFp2VH5Fb6EYdqGmEMcCJwQ==
X-Received: by 2002:adf:e604:0:b0:319:7c7d:8d1 with SMTP id p4-20020adfe604000000b003197c7d08d1mr4429404wrm.44.1695301493136;
        Thu, 21 Sep 2023 06:04:53 -0700 (PDT)
Date: Thu, 21 Sep 2023 09:04:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "Zhu, Lingshan" <lingshan.zhu@intel.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	Jason Wang <jasowang@redhat.com>
Message-ID: <20230921084914-mutt-send-email-mst@kernel.org>
References: <20230921015810-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481821D526E376771E70204DCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230921031129-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54810CEA225EA1BB896AF7C2DCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230921040133-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481F59CBD9B2B615D6F4B0EDCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230921060320-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54819A286CA557DD654E7BA6DCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230921073101-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481C9D17AA734BE13CA6A75DCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481C9D17AA734BE13CA6A75DCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: Re: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and
 vq state

On Thu, Sep 21, 2023 at 12:39:31PM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Thursday, September 21, 2023 5:53 PM
> 
> > 
> > Again the thread has been side-tracked, which linux module does what is not
> > what it was talking about.  By the way I wonder who decided to drop virtio
> > comment from this and copy virtio-dev. Guys please don't do this and generally
> > just send spec patches to virtio-comment, implementation discussion on virtio-
> > dev.
> 
> I have no idea who dropped the virtio-comment.
> For sure it is not me, as I am fully aware that virtio-dev is not the one to discuss.
> 
> > 
> > 
> > > >
> > > > But for example, to migrate cross-vendor you need the pci config
> > > > space to look the same and for some devices this might mean that pci
> > > > config space will have to be mediated.
> > > > Or maybe not. vdpa is a good framework in that it gives us
> > > > flexibility, it is not opinionated.
> > >
> > > Sure, as you list, both has its pros and cons.
> > > So both solutions has its space and trade off.
> > 
> > You can thinkably write a vfio based driver for PF and VF in userspace, sure. But
> > I think this is just making things unnecessarily complex for users who will have
> > to know which device to use with which driver. I think that e.g. if we have two
> > ways to submit admin commands, vdpa can just support both of them and that
> > is all.
> > When mediation is not needed then vdpa will just get out of the way.
> > 
> Well there is enough documentation already exists to indicate users to know when to use what.
> 
> > > Hence, if both can converge to same set of commands, => good.
> > > When there is different way two stacks operates for those items, we will have
> > spec extensions for both model, right?
> > 
> > My intiution says a modest amount of duplication isn't too bad.
> > E.g. I can see two ways to submit admin commands as being acceptable.
> > Are the SUSPEND bit and vq state as defined by these patches acceptable in
> > addition to vq commands as defined by your patches? For sure it seems
> > inelegant to say the least.
> 
> Right, my patches are not bifurcating the device during the device migration.
> It has generic device migration concept, so be it config space, or shared memory or admin queue or config interrupts or some other dma interface or some other things.
> All are covered under device migration that software does not need to bisect.
> 
> So may be instead of suspending the VQ, it can be reseting the VQ by using existing functionality, and when enabling the VQ, it can start from newly supplied avail index.
> This way, it can be elegant too.
> 
> These patches do not explain the motivation of why to suspend individual queues. Do you know?
> There is suspend device bit as well, so it is unclear why to have both.

Modularity is good generally but it's all guessing.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

