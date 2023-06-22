Return-Path: <virtio-dev-return-13063-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F545EB64D8
	for <virtio-dev@archiver.kernel.org>; Thu, 22 Jun 2023 19:02:39 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 6CC7016DFC9
	for <virtio-dev@archiver.kernel.org>; Thu, 22 Jun 2023 19:02:38 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 47A559865D6
	for <virtio-dev@archiver.kernel.org>; Thu, 22 Jun 2023 19:02:38 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 2EF709865D1; Thu, 22 Jun 2023 19:02:38 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1B32F9865D4
	for <virtio-dev@lists.oasis-open.org>; Thu, 22 Jun 2023 19:02:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 8YQQrRl5OraLt3SqlLNDng-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687460547; x=1690052547;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ZoUV8xeBTxBmISQ83N6BrZgRzcns+xHKg2Qj0lEanA=;
        b=R5fAU2laS+TDnY8jaZDUi+Bo210jrVVbF/T/UrfqhSB9c8q7paA3AOivKCmecnVtbS
         TeLHHwnC4mNRM/PJeySbBM0clwvBjlEi+hytXdpa4Vrw13SG8mrRz5zvRyVtwHkjORo7
         PN56xmNiVUMrBNvf2kxMPkLFos4hZbW55nrTYy+aBHy7h8ZxtkEbtOXnSQqRUCO7G1+W
         vH0AD5sKjeF7ENV4yg1T16GEg7BP/LLuNwbxLbTmtsG1Eo1q5mTo3P8vc+WSYO8qOrwE
         jfyq8hy3kBj3l5Fg4tyNSDpdPzmA1WoBIsEYMg/MbKSwYafhWZQcSMF4fJgvK/S0zlRm
         igfA==
X-Gm-Message-State: AC+VfDzk8lhYC3zbIb2OkvrZmLwgv9xJukha77kfjcC0g6YAGgaYSp9i
	7iilNfuuiAX6pNzI2vF8dT5SnuIcklCEKhSwIj5BhIMD2PM6uamJayGm+5i0nnK/4riEi4jIWil
	b74FYeYpCot08jy5s9JARjFz92ZSr
X-Received: by 2002:a17:907:7fa4:b0:977:e916:9b83 with SMTP id qk36-20020a1709077fa400b00977e9169b83mr22000639ejc.8.1687460547334;
        Thu, 22 Jun 2023 12:02:27 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4rsltVdSQsdz/B8nsm8NfVcBZaQTsWdsf0HKuA63rmehIFxLb5ANU5csD7EZ/bC6YQeVTQDQ==
X-Received: by 2002:a17:907:7fa4:b0:977:e916:9b83 with SMTP id qk36-20020a1709077fa400b00977e9169b83mr22000620ejc.8.1687460547067;
        Thu, 22 Jun 2023 12:02:27 -0700 (PDT)
Date: Thu, 22 Jun 2023 15:02:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	Jason Wang <jasowang@redhat.com>,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Cornelia Huck <cohuck@redhat.com>
Message-ID: <20230622145052-mutt-send-email-mst@kernel.org>
References: <20230622021932-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54815D6D07A49CE775620088DC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230622130359-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481367BAA5DE0BAA33DBAA8DC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230622132837-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481B65F624B16200B91B0AADC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230622140412-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481BE907C0BBACC00389091DC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230622143626-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54812621EAFA660735B3A8F0DC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54812621EAFA660735B3A8F0DC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] Re: [virtio-dev] Re: [virtio-comment] Re:
 [PATCH v18] virtio-net: support inner header hash

On Thu, Jun 22, 2023 at 06:50:16PM +0000, Parav Pandit wrote:
> 
> 
> > From: virtio-comment@lists.oasis-open.org <virtio-comment@lists.oasis-
> > open.org> On Behalf Of Michael S. Tsirkin
> > Sent: Thursday, June 22, 2023 2:40 PM
> > To: Parav Pandit <parav@nvidia.com>
> > Cc: Heng Qi <hengqi@linux.alibaba.com>; virtio-comment@lists.oasis-open.org;
> > virtio-dev@lists.oasis-open.org; Jason Wang <jasowang@redhat.com>; Yuri
> > Benditovich <yuri.benditovich@daynix.com>; Xuan Zhuo
> > <xuanzhuo@linux.alibaba.com>; Cornelia Huck <cohuck@redhat.com>
> > Subject: [virtio-comment] Re: [virtio-dev] Re: [virtio-comment] Re: [PATCH v18]
> > virtio-net: support inner header hash
> > 
> > On Thu, Jun 22, 2023 at 06:17:54PM +0000, Parav Pandit wrote:
> > >
> > >
> > > > From: virtio-dev@lists.oasis-open.org
> > > > <virtio-dev@lists.oasis-open.org> On Behalf Of Michael S. Tsirkin
> > > > Sent: Thursday, June 22, 2023 2:12 PM
> > >
> > > [..]
> > >
> > > > > > > The proposal for 1.4 is literally very simple as below.
> > > > > > > 1. All existing fields of cfg space stays in cfg space 2. Any
> > > > > > > new capabilities to be queried, query using a vq (aq, cfgvq,
> > whatevervq).
> > > > > > > 3. Optionally existing fields can be queries over vq of #2
> > > > > > > Once this arrive, no need for new GET commands.
> > > > > > > Till that time, don't keep infinitely grow the cfg space.
> > > > > > > Any next addition to cfg space, should work on defining the cfgvq.
> > > > > >
> > > > > > Simple, but short sighted. I know you guys don't support your
> > > > > > hardware for 10-
> > > > > > 20 years but for software people do.
> > > > > > And so "All existing fields of cfg space stays in cfg space" is
> > > > > > a bad idea simply because this does not allow removing things
> > > > > > from config space not in 10 not in
> > > > > > 20 years not ever.
> > > > > >
> > > > > #1 is for backward compat for existing drivers.
> > > > >  You missed about #3. Existing cfg space fields can be queries
> > > > > using the cfgvq
> > > > too.
> > > >
> > > > Then #1 does not matter. We can give devices choice.
> > > >
> > > > > >
> > > > > > Instead we need to allow two ways to access config space.  Teach
> > > > > > drivers about both, actually mandate supporting both.  And then
> > > > > > devices will make their own cost/benefit decision about which
> > > > > > features they
> > > > want to support in MMIO.
> > > > >
> > > > > If both method is mandated, I don't see benefit at all of two methods.
> > > >
> > > > Mandated for driver.
> > > > Benefit is for devices, they will have the choice which drivers to
> > > > support. In 10-
> > > > 20 years all drivers support cfg command and then people can start
> > > > shipping devices without MMIO access to any registers.
> > > >
> > > Until that point devices are forced to burn memory, which is not needed at all
> > in < 3 years.
> > 
> > No they are not. They can make their own decision which fields to support in
> > MMIO space.
> Existing fields used by existing drivers must be in MMIO.
> Device does not have a choice.

They can if they like mask some less important features reducing the footprint.
This will be the cost/benefit analysis each vendor does separately.

Case in point, if inner hash support is in 1.3, and linux drivers don't
really use that at all for a year or two because it's only used by
alibaba in their stack, and by the time linux starts using
them it also supports the new commands, then practically
devices do not care and can just mask the feature bit in MMIO.


> > If they want to cut at 1.3 time, they can, but they also can cut it at 1.2 time, this
> > means some features will not be accessible through MMIO only through the
> > new commands.
> >
> New commands services new fields by newer driver.
> Newer driver can call new command to get new and old fields both.

yes.

> So 1.3 and 1.4 devices cannot optimize for older drivers.


I don't know what this means.

>  
> > > Once cfgvq is present for new fields, from the day 1, device does not need to
> > store any newly defined fields on MMIO.
> > 
> > Exactly.
> > 
> > > And 10 to 20 years, it can stop for existing fields..
> > >
> > > The clear benefit is fields defined in 1.4 no longer needs to be stored starting
> > from 2023-24.
> > 
> > And why is it a problem that someone can also build a 1.4 device with MMIO?
> >
> Why to build device using large MMIO when those fields are accessible via vq.

If you don't want to - don't. But it's simple and handy for software.
Not all devices are complex beasts like net.

Apropos, I am not yet sure the best way is simply adding admin vq to
vfs, in that this only works for fields not needed before DRIVER_OK.
Ideally I think we should fix all of config space, including device and
common config. I have some ideas but let's not get ahead of ourselves.

> VQ construct exists so it is already simple.
> 
> If the spec is defined in a way, that new fields must be accessible via vq, and optionally via MMIO, than it is ok.
> One can choose to build via MMIO.
> So MMIO for new fields must not be mandatory.

For devices, yes. I am suggesting mandating it for drivers.
Or maybe it's enough to make it a SHOULD.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

