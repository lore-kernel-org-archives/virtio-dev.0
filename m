Return-Path: <virtio-dev-return-13052-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF69DEB64D8
	for <virtio-dev@archiver.kernel.org>; Thu, 22 Jun 2023 17:28:33 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 35872419AD
	for <virtio-dev@archiver.kernel.org>; Thu, 22 Jun 2023 17:28:33 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 19C649865EB
	for <virtio-dev@archiver.kernel.org>; Thu, 22 Jun 2023 17:28:33 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id EBF9E9865D0; Thu, 22 Jun 2023 17:28:32 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D9A989865D1
	for <virtio-dev@lists.oasis-open.org>; Thu, 22 Jun 2023 17:28:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 0crTC6gQOjiT0iAKlWYcDA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687454909; x=1690046909;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LK5eR5DXGtlTXSbp5C0grvI/We9i0tfLxzt9xCuJL2g=;
        b=dNeb1uiUIvyZkpoj5IlieVS9vEh1M1J871swOBZCQbJ7oIZHsI9Q/Auq1oHxugJvyI
         y9320P1GAutq4KQoph7eiyvwEPQEVw8m6PV7F0XG63q3v6ex4noCXfWCiWXOFeE765Bi
         o+pwPuIUvpJYADQovYLSPvNcftZu23t0QgyKVSzhbO4MLjpU5Xks7VC8mdA3Bg28MJzZ
         MAf2So6cBxWax93ZnwVH8Jj+xQNw4buPHj1rbpYf+nUOjpuqieqymEjfW8RueNxB9hby
         cANvuERSxyb4j/DujbTqi7ymP8gJ2hSy71AJfoQlhWAGzRQCm9VPc/XKpWkAJY+oq+EZ
         ZoxQ==
X-Gm-Message-State: AC+VfDw/Oe1T0ovw9n/Wz/tCzAcDdyF5NS9Zn6maHpsWT0nWFKItqlQZ
	CuwyNEJ8sxSI1ofioQoqHeeaM8pQ4p5MyBc/DaudrFhQ/P0QJLnn3Iws0wGfEEjNOcJPGtpf6yJ
	q3o2MnF6fdkHpB1CVOB6d6xvuhDiy
X-Received: by 2002:a17:907:2d2b:b0:988:d6ca:ea72 with SMTP id gs43-20020a1709072d2b00b00988d6caea72mr10705767ejc.71.1687454909612;
        Thu, 22 Jun 2023 10:28:29 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7a9dtaDA9N0c/iDURyg2UHx+cTdLgMLlmKG7f9mNUNYXrYXmoELuNY+JeZUky86GajZJSjug==
X-Received: by 2002:a17:907:2d2b:b0:988:d6ca:ea72 with SMTP id gs43-20020a1709072d2b00b00988d6caea72mr10705755ejc.71.1687454909301;
        Thu, 22 Jun 2023 10:28:29 -0700 (PDT)
Date: Thu, 22 Jun 2023 13:28:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	Jason Wang <jasowang@redhat.com>,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Cornelia Huck <cohuck@redhat.com>
Message-ID: <20230622131455-mutt-send-email-mst@kernel.org>
References: <20230621163116-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481C4EA5D0614E1289DFC77DC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230622021932-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54815D6D07A49CE775620088DC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <82e83a90-6491-c20b-d96d-f9e0d15c2641@linux.alibaba.com>
 <PH0PR12MB5481A5055A5F58045437391CDC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230622123203-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548100743287D401B8ED78CFDC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230622125601-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481FFF9F0F1443F75782C26DC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481FFF9F0F1443F75782C26DC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] Re: [PATCH v18] virtio-net: support inner
 header hash

On Thu, Jun 22, 2023 at 05:11:24PM +0000, Parav Pandit wrote:
> 
> 
> > From: virtio-comment@lists.oasis-open.org <virtio-comment@lists.oasis-
> > open.org> On Behalf Of Michael S. Tsirkin
> > Sent: Thursday, June 22, 2023 1:04 PM
> > To: Parav Pandit <parav@nvidia.com>
> > 
> > On Thu, Jun 22, 2023 at 04:54:48PM +0000, Parav Pandit wrote:
> > >
> > >
> > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > Sent: Thursday, June 22, 2023 12:47 PM
> > >
> > > >
> > > > The hardware footprint of keeping this in memory is also fairly
> > > > small :) I care about a messy interface because this mess builds up over time.
> > > >
> > > It is really a simple GET command.
> > > It is actually messy for the device to implement functionality in two places in
> > cfg space and cvq.
> > >
> > > > And I am worried about capabilities really. My bad that I missed
> > > > this change in v13. I only can say in my defence that I already had
> > > > to rewrite huge chunks of this proposal to make it readable so one
> > > > can't say I'm only delaying things, I also made an effort to help
> > > > this progress faster :)
> > > >
> > > > I feel we need a single place where device capabilities can live. So
> > > > far they were in config space.  It's consistent, yes I get this has
> > > > hardware costs *if* there's a huge number of VFs and *if* there's a
> > > > way to provision each VF with a different configuration.
> > > All the ifs are valid today.
> > >
> > > > And yes querying VFs over MMIO is kind of ugly. But it does at least
> > > > work, and works fine while VF is assigned.  So we can build
> > > > migration around that *today*.
> > > >
> > > Other way to say migration can be skipped for this feature bit, and it still
> > works for rest.
> > 
> > If VF is assigned then we can't really control what does guest enable.
> >
> All parameters set over the CVQ needs to be accessible to the migration entity.
> Including RSS and including this bit.
> Either by trapping the CVQ or by having AQ command to query member dev capabilities.

Yes, parameters set needs to be trapped, so they can be
replayed. This is a capability though. After guest has
driven the CVQ for a while submitting a command to it
so we get capability - I don't see how that works.

> > > > But querying over cvq while VF is assigned clearly *doesn't* work.
> > > >
> > > That is not the idea at all.
> > > Querying VF capabilities is the role of the admin command for which we built
> > it.
> > 
> > This GET is exactly that though.
> > 
> Not exactly.
> This GET command is needed for the member driver to know what is supported for the device it got.

yes. but how will hypervisor get the capability?

> > > > So what is the solution proposed for this?
> > > >
> > > 1. Query member device capabilities via admin command
> > 
> > But that's not 1.3 material.
> > 
> > > > Yes the current migration is broken in many ways but that's what we
> > > > have. Let's build something better sure but that is not 1.3 material.
> > >
> > > True, it is not 1.3 material, hence the proposal was to have the GET command.
> > > Once/if we reach agreement that no new fields to be added to config space
> > starting 1.4 and should be queried using non intercepted cfgvq, it makes sense
> > to let this go in cfg space.
> > > Else GET command seems the elegant and right approach.
> > 
> > I expect no such agreement at all. Instead, I expect that we'll have an alternative
> > way to access config space. guest virtio core then needs to learn both ways, and
> > devices can support one or both.
> > 
> Yeah, we disagree.
> Because alternative way that you propose is not predictable way to build the device efficiently.
> It always needs to account for old driver to support.
> This is clearly sub-optimal as the capabilities grow.

So just quickly add the new capability in the spec and then the number
of linux releases that will have the new feature but not config command
or whatever that is will be too small for vendors to care.

> 
> > A good implementation of virtio_cread can abstract that easily so we don't need
> > to change drivers.
> 
> There is no backward compat issue for the GET command being new.

It's just a shortcut replacing what we really want.  As long as a
shortcut is available people will keep using exactly that.  So I fully
expect more proposals for such GET commands on the pretext that one is
there so why not another one. Adding more tech debt for whoever
finally gets around to building a config space access gateway.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

