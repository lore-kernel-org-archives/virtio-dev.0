Return-Path: <virtio-dev-return-13061-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 179EBEB64DA
	for <virtio-dev@archiver.kernel.org>; Thu, 22 Jun 2023 18:40:20 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 768994448
	for <virtio-dev@archiver.kernel.org>; Thu, 22 Jun 2023 18:40:19 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6BB009865F1
	for <virtio-dev@archiver.kernel.org>; Thu, 22 Jun 2023 18:40:19 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 60F4F9865D1; Thu, 22 Jun 2023 18:40:19 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 50C459865D5
	for <virtio-dev@lists.oasis-open.org>; Thu, 22 Jun 2023 18:40:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: MOTe6x5jPzWR8EOxsVzT4Q-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687459206; x=1690051206;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rl7mygweHwX8VG9HNyQgDs6gObz0L5xgZt6c0b4dElo=;
        b=AclMOTo6VlaRpIjWIMpgu2ims1pOpySD5Yy4nIVNoDWsDNqKKgm3rFYTt4Id7veaaJ
         VXnmIq7htpoY6f9P6btXLcgV1UDuEE1HNC8Bad41WaSVfIshU3tTwClOZyUoOaDTcstf
         djPqyIch25JlyKsGDgGP9oXzmt88/S+nJ2/CabYtXhD5EPSQ5FY7V4BKU8G/RmyM5Zm2
         XC6mGfY2iuvrac/u+2urCdJhoBtjTVb386k/WqUPf+soKmDjq4g9zUssCmr1OrFtFo8m
         dQSBcv9OHmPhimg986qrzTCaYfgbRQZvGHdMGPi3ggUeJPqx1wxSfFRFcc9g8cfABl3Q
         6dlQ==
X-Gm-Message-State: AC+VfDyglL6rIVtWuuTqe0/a6OPHk10/66Y+qHH3V7sMlsDpJT7/R51J
	8gYDPFobG5uHBH3ZlNzfyDm0I53JTf9BQRKe+qDYrsev7a8lj3tjlz74SB9llfUl7dD7UBd5/E5
	DTgLFBe6N8bg2G6fgFwQvLiR4ZliC
X-Received: by 2002:a17:907:72ca:b0:974:b15:fce5 with SMTP id du10-20020a17090772ca00b009740b15fce5mr17647702ejc.38.1687459206330;
        Thu, 22 Jun 2023 11:40:06 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5uZ9klJuXIKWEAvFDibdHWTGRy7FpaU4k1xD/6oZAJnmyk7X1h225CSloKKRc3zsIuJzDrbw==
X-Received: by 2002:a17:907:72ca:b0:974:b15:fce5 with SMTP id du10-20020a17090772ca00b009740b15fce5mr17647693ejc.38.1687459206041;
        Thu, 22 Jun 2023 11:40:06 -0700 (PDT)
Date: Thu, 22 Jun 2023 14:40:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	Jason Wang <jasowang@redhat.com>,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Cornelia Huck <cohuck@redhat.com>
Message-ID: <20230622143626-mutt-send-email-mst@kernel.org>
References: <20230621163116-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481C4EA5D0614E1289DFC77DC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230622021932-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54815D6D07A49CE775620088DC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230622130359-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481367BAA5DE0BAA33DBAA8DC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230622132837-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481B65F624B16200B91B0AADC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230622140412-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481BE907C0BBACC00389091DC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481BE907C0BBACC00389091DC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: Re: [virtio-dev] Re: [virtio-comment] Re: [PATCH v18] virtio-net:
 support inner header hash

On Thu, Jun 22, 2023 at 06:17:54PM +0000, Parav Pandit wrote:
> 
> 
> > From: virtio-dev@lists.oasis-open.org <virtio-dev@lists.oasis-open.org> On
> > Behalf Of Michael S. Tsirkin
> > Sent: Thursday, June 22, 2023 2:12 PM
> 
> [..]
> 
> > > > > The proposal for 1.4 is literally very simple as below.
> > > > > 1. All existing fields of cfg space stays in cfg space 2. Any new
> > > > > capabilities to be queried, query using a vq (aq, cfgvq, whatevervq).
> > > > > 3. Optionally existing fields can be queries over vq of #2 Once
> > > > > this arrive, no need for new GET commands.
> > > > > Till that time, don't keep infinitely grow the cfg space.
> > > > > Any next addition to cfg space, should work on defining the cfgvq.
> > > >
> > > > Simple, but short sighted. I know you guys don't support your
> > > > hardware for 10-
> > > > 20 years but for software people do.
> > > > And so "All existing fields of cfg space stays in cfg space" is a
> > > > bad idea simply because this does not allow removing things from
> > > > config space not in 10 not in
> > > > 20 years not ever.
> > > >
> > > #1 is for backward compat for existing drivers.
> > >  You missed about #3. Existing cfg space fields can be queries using the cfgvq
> > too.
> > 
> > Then #1 does not matter. We can give devices choice.
> > 
> > > >
> > > > Instead we need to allow two ways to access config space.  Teach
> > > > drivers about both, actually mandate supporting both.  And then
> > > > devices will make their own cost/benefit decision about which features they
> > want to support in MMIO.
> > >
> > > If both method is mandated, I don't see benefit at all of two methods.
> > 
> > Mandated for driver.
> > Benefit is for devices, they will have the choice which drivers to support. In 10-
> > 20 years all drivers support cfg command and then people can start shipping
> > devices without MMIO access to any registers.
> >
> Until that point devices are forced to burn memory, which is not needed at all in < 3 years.

No they are not. They can make their own decision which fields to support in MMIO space.
If they want to cut at 1.3 time, they can, but they also can cut it
at 1.2 time, this means some features will not be accessible through
MMIO only through the new commands.

> Once cfgvq is present for new fields, from the day 1, device does not need to store any newly defined fields on MMIO.

Exactly.

> And 10 to 20 years, it can stop for existing fields..
> 
> The clear benefit is fields defined in 1.4 no longer needs to be stored starting from 2023-24.

And why is it a problem that someone can also build a 1.4 device with MMIO?

> > > VQ is generic part of the spec for slow and fast operation, so it is not at all a
> > cost for config reading.
> > 
> > This will depend. E.g. if there's a single command to get all of config in one go,
> > then it actually can be a speedup, reducing the # of VM exits.
> 
> Yes, one command to get all at least device specific config.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

