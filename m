Return-Path: <virtio-dev-return-13142-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76650EB64DC
	for <virtio-dev@archiver.kernel.org>; Thu, 29 Jun 2023 06:03:37 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 6413376043
	for <virtio-dev@archiver.kernel.org>; Thu, 29 Jun 2023 06:03:35 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1541D9866FC
	for <virtio-dev@archiver.kernel.org>; Thu, 29 Jun 2023 06:03:35 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id EDA329841AB; Thu, 29 Jun 2023 06:03:34 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C824B986813
	for <virtio-dev@lists.oasis-open.org>; Thu, 29 Jun 2023 06:03:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 2LPZaFYLOXyEAm0Zzwdxxw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688018611; x=1690610611;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Vn4pIxXdldAGJK2qwvp/z0MC1chDzWDzziVkfQpNJM=;
        b=Yt3GzE7n13/HcwiGHVbR0TzDkQd3cNvVBaAhFGTdweXUQo92x20IQtWcaRc+5hevDo
         ssu7SzJz/E9ORhoIdSQH5JMZiho8gcHrEX2f6ziIutRprKptm08Dp4UX+cMdWXsQQpoY
         5hvQZWwB45rumc2K47faJqSSosqk2wBYbH2NTZ3DjABTkyAnYCC66BOuXXgWANYQ2kjb
         xl3WNunkiplRvE9Qs0ghoxKCZLSMhE3y1Z2xTosOfSh8MglQ7crC1lGNrRNc9NFveDFr
         IzLguEyC5Y99I5Y6tiDgaR/PFja5p5j7HW8tJEnO39H7now2tHHFjuDXd1xtBeokCNiL
         ujgw==
X-Gm-Message-State: AC+VfDwmqOGIm1oBqirou/wJrI6oMlj0dcjzag+tUYnFBVgrYVX0vC89
	RSYvhLcCc9GPRVQAbEQaX8sLujWLmoJ4RRtkYsFqedfqnDzM++Id4gET4Gc7nt47MBzQ6XTZdPf
	o3ItYYSiIIJJAIGKw2cdVrEm1I9GB
X-Received: by 2002:a05:600c:880c:b0:3f7:e78e:8a41 with SMTP id gy12-20020a05600c880c00b003f7e78e8a41mr3443247wmb.18.1688018610902;
        Wed, 28 Jun 2023 23:03:30 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5ETgYo1ZbZdbKzDob3NebjQ7HiHkh7U6Ui5k1rhPA48hX/YO3R43aOtK7luEb498Prtwzt2w==
X-Received: by 2002:a05:600c:880c:b0:3f7:e78e:8a41 with SMTP id gy12-20020a05600c880c00b003f7e78e8a41mr3443225wmb.18.1688018610520;
        Wed, 28 Jun 2023 23:03:30 -0700 (PDT)
Date: Thu, 29 Jun 2023 02:03:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Jason Wang <jasowang@redhat.com>, Heng Qi <hengqi@linux.alibaba.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Message-ID: <20230629020128-mutt-send-email-mst@kernel.org>
References: <CACGkMEvFmAiWDp8w=ytin21Oi+PcTb1X3Eve7Kt2NVr_RkhgmA@mail.gmail.com>
 <PH0PR12MB54811123CFCDEFE3B48D4381DC24A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230628061257-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481ED6C94DE8CC414C3369BDC24A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230628123131-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481BA1CDA0942170186CB59DC24A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230628132122-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54814D42786A6981467D3FADDC24A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230628152125-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481EAD97F6163C52DF4FF53DC25A@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481EAD97F6163C52DF4FF53DC25A@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] RE: [PATCH v19] virtio-net: support inner
 header hash

On Thu, Jun 29, 2023 at 01:56:34AM +0000, Parav Pandit wrote:
> 
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Wednesday, June 28, 2023 3:45 PM
> > > > Maybe I get it. You want to use the new features as a carrot to
> > > > force drivers to implement DMA? You suspect they will ignore the
> > > > spec requirement just because things seem to work?
> > > >
> > > Right because it is not a must normative.
> > 
> > Well SHOULD also does not mean "ok to just ignore".
> > 
> > 	This word, or the adjective "RECOMMENDED", mean that there
> > 	   may exist valid reasons in particular circumstances to ignore a
> > 	   particular item, but the full implications must be understood and
> > 	   carefully weighed before choosing a different course.
> >
> RECOMMENDED and SHOULD forces the device to support MMIO, which is not good.
> So rather a good design is device tells the starting offset for the extended config space.
> And extended config space MUST be accessed using a DMA.
> With this sw can have infinite size MMIO and hw device forces DMA based on its implementation of where to start DMA from.
> This also gives the ability to maintain current config as MMIO for backward compatibility.

Really we do not need offsets. We have feature bits, and offsets are
implied. But let's start a separate thread for discussions of this?


> > 
> > 
> > > > There's some logic here, for sure. you just might be right.
> > > >
> > > > However, surely we can discuss this small tweak in 1.4 timeframe?
> > >
> > > Sure, if we prefer the DMA approach I don't have a problem in adding
> > temporary one field to config space.
> > >
> > > I propose to add a line to the spec " Device Configuration Space"
> > > section, something like,
> > >
> > > Note: Any new device configuration space fields additional MUST consider
> > accessing such fields via a DMA interface.
> > >
> > > And this will guide the new patches of what to do instead of last moment
> > rush.
> > 
> > Yea, except again I'd probably make it a SHOULD: e.g. I can see how switching to
> > MMIO might be an option for qemu helping us debug DMA issues.
> >
> There are too many queues whose debugging is needed and MMIO likely not the way to debug.
>  
> > The time to discuss this detail would be around when proposal for the DMA
> > access to config space is on list though: I feel this SHOULD vs MUST is a small
> > enough detail.
> >
> >From implementation POV it is certainly critical and good step forward to optimize virtio interface.
>  
> > Going back to inner hash. If we move supported_tunnels back to config space,
> > do you feel we still need GET or just drop it? I note we do not have GET for
> > either hash or rss config.
> >
> For hash and rss config, debugging is missing. :)
> Yes, we can drop the GET after switching supported_tunnels to struct virtio_net_hash_config.
>  
> > And if we no longer have GET is there still a reason for a separate command as
> > opposed to a field in virtio_net_hash_config?
> > I know this was done in v11 but there it was misaligned.
> > We went with a command because we needed it for supported_tunnels but
> > now that is no longer the case and there are reserved words in
> > virtio_net_hash_config ...
> > 
> > Let me know how you feel it about that, not critical for me.
> 
> struct virtio_net_hash_config reserved is fine.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

