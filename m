Return-Path: <virtio-dev-return-13132-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C92BEB64DC
	for <virtio-dev@archiver.kernel.org>; Wed, 28 Jun 2023 17:16:29 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 583252A826
	for <virtio-dev@archiver.kernel.org>; Wed, 28 Jun 2023 17:16:28 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1EB4F9865CF
	for <virtio-dev@archiver.kernel.org>; Wed, 28 Jun 2023 17:16:28 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 038C3986585; Wed, 28 Jun 2023 17:16:28 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E29D4986588
	for <virtio-dev@lists.oasis-open.org>; Wed, 28 Jun 2023 17:16:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 08aTictrOuKMoqZeBEW4qw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687972584; x=1690564584;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/beAg24EPBSdpYJKknG5/bbZy5Asy+6LWILRn8cAPsk=;
        b=bsKGUqdwEjLAlWweuinj+/paA6UOrN7AUWVi9JnjoI5o/1lfOlAsv9jeduBaQa33o0
         6QruB0GENEDEDRJVlmUcC9JuGGxEd93U7u4a31jBwseHVeHH6m8110rTThTXYeV/lNY0
         LC4ph+AB0YI0trb1hQogqT6eO7Om5oVNQwuysYiUWS++fgvhuXxsvCkHXUws7I21y+Vu
         UIH84ZUvJQa6Dbbj+toM9A/0oBe0NnmsgRDdafTrDcfq0fdr+604AlbFL+UqoAtlJ+FQ
         zdNvt1lt26Lk1RinTXvM9M9qjzK7eB6467BFZPLIqWRcEHvv45ZBLCZrmnmt3txMgg0+
         1Hig==
X-Gm-Message-State: AC+VfDxooVUxlA+Umj9BTKfnNqvnLiaaH3oKXrasKke7Yk/Kg/WtMOl8
	JzkofDqWbYz6R4hAKwpMyX0Vd2fwD6VgqIRbHomxhhbdSLnqxQBB4JH9wwwLtmcV/MxjEEiHs3h
	vZOA7YMooZwT+WDF7fN6QXZgZOWLc
X-Received: by 2002:a5d:5692:0:b0:30e:590f:78d1 with SMTP id f18-20020a5d5692000000b0030e590f78d1mr22871522wrv.63.1687972584238;
        Wed, 28 Jun 2023 10:16:24 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ43pItxca6r1RZXyVgUC8nCU9y5cGzgEBN/3eeub07PVn+7yrQ2YjLPfwgORIRJJWN/4fFYnA==
X-Received: by 2002:a5d:5692:0:b0:30e:590f:78d1 with SMTP id f18-20020a5d5692000000b0030e590f78d1mr22871500wrv.63.1687972583814;
        Wed, 28 Jun 2023 10:16:23 -0700 (PDT)
Date: Wed, 28 Jun 2023 13:16:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Jason Wang <jasowang@redhat.com>, Heng Qi <hengqi@linux.alibaba.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Message-ID: <20230628130839-mutt-send-email-mst@kernel.org>
References: <20230627163549.40028-1-hengqi@linux.alibaba.com>
 <CACGkMEvFmAiWDp8w=ytin21Oi+PcTb1X3Eve7Kt2NVr_RkhgmA@mail.gmail.com>
 <PH0PR12MB54811123CFCDEFE3B48D4381DC24A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230628061257-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481ED6C94DE8CC414C3369BDC24A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230628123131-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481BA1CDA0942170186CB59DC24A@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481BA1CDA0942170186CB59DC24A@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] RE: [PATCH v19] virtio-net: support inner
 header hash

On Wed, Jun 28, 2023 at 05:06:40PM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Wednesday, June 28, 2023 12:46 PM
> 
> > Actually, my preblem is exactly if there's no one single interface that can do
> > everything.
> >
> Extended config space reading via single DMA interface is just enough.
> 
> > 
> > Two interfaces that do the same might seem redundant but there could be good
> > reasons for this, in this case legacy.
> >
> But legacy should not force it to newer interface. More below.
>  
> > See the difference?
> > 
> 
> > > I didn't propose two interfaces. Let me explain again.
> > >
> > > I proposed,
> > > a. all new fields to go via vq (single interface) b. all existing
> > > fields to stay in cfg space (single interface) c. if one wants to
> > > optimize optionally existing fields can utilize (same flexibility how you asked
> > for PF and VF notification).
> > >
> > >
> > > > We already need config space with provisioning.
> > > Provisioning does provision features, config space and control parameters,
> > msix vectors and more.
> > > Provisioning does _not_ need config space.
> > 
> > I mean it needs to provision it.
> > 
> No matter there is config space of dma, a device to be provisioned.
> 
> > > > In fact e.g. on Linux we want drivers to keep doing virtio_cread()
> > > > and all the DMA tricks should be hidden behind the scenes. You don't
> > > > like it that config space is on-chip? Build an interface for it not
> > > > to be on chip. There is simply no downside to that.
> > > >
> > > This is the ask to build software interface between driver and device to not
> > demand on-chip config space more importantly _predictably_.
> > 
> > Absolutely. So we would say that driver SHOULD use the DMA interface if it is
> > present.
> > 
> I am asking for driver MUST use the DMA interface for _extended_ config space.
> Why?
> For two reasons.
> 
> 1. Because than device is 100% sure that it does not fulfill MMIO needs
> 2. Single interface to access extended config space, which is what you asked for.
> 3. Single driver code because there is single way to get it.
> 

Right. But I think there's a better way.
Just say that any feature in MMIO MUST be also in DMA.
So any modern driver will have no reason at all to use MMIO - DMA
is a superset.


> > > > I came back after a small break and I still see this discussion that
> > > > keeps playing out as a big distraction.
> > > > In particular where are you doing to store the things that are for DMA?
> > > > In system RAM? We don't *have* anywhere in system RAM to store this,
> > > > we will need an interface to allocate system RAM and pass it to
> > > > device for this idea to work. So in 1.3 where we won't have this,
> > > > there is much less of an excuse to use a vq.
> > > To store what?
> > > CVQ is already there to do GET and SET operation.
> > 
> > To store whatever value CVQ is requesting. Where is it going to come from?
> >
> It is going to come from the device memory that does not have hard requirements of MMIO accessibility.
> For example slow flash memory.
>  
> > Asynchronous is just harder for software.  Look at the hoops virtio net has to
> > jump through to do control path over cvq and weep. Compare to single liner
> > virtio_cread.
> > 
> > I happen to maintain Linux drivers too, so I care.
> > 
> It is harder for first time if no such construct exists; and it is clearly not the case.
> This patch is already adding CVQ get and set command.

I expect get to mostly go unused.

> Async behavior already built into the virtio spec.
> Extending it for extended config space just make device more cheaper to build.
> Software cost is paid only once at device init time just like CVQ, AQ and more.
> 
> > > >
> > > > Please let people just focus on fixing config space instead of
> > > > temporary cvq hacks.
> > >
> > > The ask is to have predictable sizing for existing defined config space field and
> > not keep infinitely growing by two interfaces.
> > 
> > I don't know what "predictable sizing" is or why does it matter.
> > 
> Because when device has two ways to access config space, it always have to account and build the interface that, hey some driver will not use DMA.
> Hence have it always in the MMIO accessible area.

If we say that drivers should use DMA, they will.  If we additionally
explain that some features might not be in MMIO no sane driver will use
MMIO if it does not have to.
Or if it does then it has violated the spec and will get less features?




> > I get the value of reduced MMIO register map.
> > I get that the only way to get that appears to be to pass values around using
> > DMA.
> >
> Ok. great.
>  
> > I don't think we need to throw away config space - just use DMA to access it.
> > 
> > And "existing defined" here seems to be at a completely random point in time.
> > If someone wants to have fields in MMIO, I see no reason not to.
> 
> This demands two ways of access and that conflicts with your point of desire to do single way.
> I proposed single way, extended config space via DMA interface, that is really as simple as that.


My desire is to have a single way that works for everything.
We have legacy so we will have legacy ways too, these
might not work for everything.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

