Return-Path: <virtio-dev-return-13121-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CDCDEB64DC
	for <virtio-dev@archiver.kernel.org>; Wed, 28 Jun 2023 10:41:35 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id D08FB88E16
	for <virtio-dev@archiver.kernel.org>; Wed, 28 Jun 2023 10:41:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C522D986588
	for <virtio-dev@archiver.kernel.org>; Wed, 28 Jun 2023 10:41:34 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id B32DA98656E; Wed, 28 Jun 2023 10:41:34 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A1EC198656F
	for <virtio-dev@lists.oasis-open.org>; Wed, 28 Jun 2023 10:41:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: JdXyjg3QOhqgfOMwftQY4w-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687948888; x=1690540888;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fH2kkOXlGHn8kTqweCW06Ony08s5thWQdx8OtaoOMoc=;
        b=htvtkNn+MIb0yKzDiNLRSPRw08o5CeXjE+K844Oj0y4cyygNOWHsSM0RneewDNnUH+
         ZlgUINiGfRw5xPAaKNtD0kz5LcZUPzcnzTpL4F3jQF6fBjMVOdZIaX16JSffcLnG3PGo
         Hfro1KlJcgPGAOv6lfzuCh6wGFgASZZq4a6iIDepE1T79TDQuXDU6tLB3Yh7sf7e0SS2
         E96/jxitr8vlDaYiVkkvbzY7eMCM9LMf0M7nktubPqE4/der8meWtefRXCRgvjyIBNlW
         CrX/uinGa2znQg7ry85hjwxmffC9Faj1mtuSnlueynxNKvfg+j9WRFygc63or/sB4S39
         w9Bg==
X-Gm-Message-State: AC+VfDxPa2yqBscT9tCcgEM7HYDxgj7LRjMC8OTGC6+LLWRIcxvyMV0J
	uhgIptMswdrYJAvn4OsPzgZsStPgONw6xGCqkpedLJrIedXr2V4xAEFnRMmqomoxMO1VcMZuOlS
	HTl3TxHZAbupzSaPpHF1WaWvZNlDB
X-Received: by 2002:a5d:560a:0:b0:313:fca6:5f49 with SMTP id l10-20020a5d560a000000b00313fca65f49mr3805242wrv.6.1687948888418;
        Wed, 28 Jun 2023 03:41:28 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7uuldxKDCcJUgyvFQVg1Mf6p35kJO+OHf0K6xwBPvc4CtRP7l8KKST1vbqcfkLzO/jY2HirQ==
X-Received: by 2002:a5d:560a:0:b0:313:fca6:5f49 with SMTP id l10-20020a5d560a000000b00313fca65f49mr3805231wrv.6.1687948888087;
        Wed, 28 Jun 2023 03:41:28 -0700 (PDT)
Date: Wed, 28 Jun 2023 06:41:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	Jason Wang <jasowang@redhat.com>,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Cornelia Huck <cohuck@redhat.com>
Message-ID: <20230628062758-mutt-send-email-mst@kernel.org>
References: <20230622021932-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54815D6D07A49CE775620088DC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <82e83a90-6491-c20b-d96d-f9e0d15c2641@linux.alibaba.com>
 <PH0PR12MB5481A5055A5F58045437391CDC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230622123203-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548100743287D401B8ED78CFDC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230622125601-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481FFF9F0F1443F75782C26DC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230622131455-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54812CE792CC801B36AC6E56DC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54812CE792CC801B36AC6E56DC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] Re: [PATCH v18] virtio-net: support inner
 header hash

On Thu, Jun 22, 2023 at 05:58:29PM +0000, Parav Pandit wrote:
> > > > > > So what is the solution proposed for this?
> > > > > >
> > > > > 1. Query member device capabilities via admin command
> > > >
> > > > But that's not 1.3 material.
> > > >
> > > > > > Yes the current migration is broken in many ways but that's what
> > > > > > we have. Let's build something better sure but that is not 1.3 material.
> > > > >
> > > > > True, it is not 1.3 material, hence the proposal was to have the GET
> > command.
> > > > > Once/if we reach agreement that no new fields to be added to
> > > > > config space
> > > > starting 1.4 and should be queried using non intercepted cfgvq, it
> > > > makes sense to let this go in cfg space.
> > > > > Else GET command seems the elegant and right approach.
> > > >
> > > > I expect no such agreement at all. Instead, I expect that we'll have
> > > > an alternative way to access config space. guest virtio core then
> > > > needs to learn both ways, and devices can support one or both.
> > > >
> > > Yeah, we disagree.
> > > Because alternative way that you propose is not predictable way to build the
> > device efficiently.
> > > It always needs to account for old driver to support.
> > > This is clearly sub-optimal as the capabilities grow.
> > 
> > So just quickly add the new capability in the spec and then the number of linux
> > releases that will have the new feature but not config command or whatever
> > that is will be too small for vendors to care.
> > 
> I didn't follow this suggestion.

It is very simple though. 1.3 has inner hash feature. Imagine that
instead of endless flamewars rehashing same arguments, immediately post
1.3 we vote on an interface to access config space through DMA (not sure
it's a VQ BTW but that's a separate discussion).  This should include a
way to expose a subset of DMA features through MMIO, for compatibility.
If we are lucky guest support can land in the same Linux release that
has inner hash.  Drivers do not need to care: they just do virtio_cread
and that is it.

So a vendor that builds device with inner hash, can expose inner hash
only through DMA and not through MMIO.

I conclude that there's no reason to block this feature just
because it uses config space.





> > >
> > > > A good implementation of virtio_cread can abstract that easily so we
> > > > don't need to change drivers.
> > >
> > > There is no backward compat issue for the GET command being new.
> > 
> > It's just a shortcut replacing what we really want.  As long as a shortcut is
> > available people will keep using exactly that.  So I fully expect more proposals
> > for such GET commands on the pretext that one is there so why not another
> > one. Adding more tech debt for whoever finally gets around to building a config
> > space access gateway.
> >
> Not really. as suggested, the first addition of new field to the config space in 1.4-time frame, should add the cfgvq, and not follow the previous example.
> Because this is being thought through now, it is not at all hard for any new things to follow the guideline.

Really. Oh great, so there will be 3 ways to provision things!

I have not seen this patch yet.  And how long will this take to
materialize? I don't believe all TC work must be blocked until this
happens, or alternatively use ad-hock hacks.

I get it you want to save on chip memory. So work on a consistent
soltion for this.

All config space accesses should go through DMA.
Thus no special guidelines should be necessary, and drivers
can just keep doing virtio_cread like they always did.

To add to that, it will allow cheaper devices as
some existing config space will be able to move
quickly.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

