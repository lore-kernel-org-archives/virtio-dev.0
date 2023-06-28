Return-Path: <virtio-dev-return-13131-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 228EEEB64DC
	for <virtio-dev@archiver.kernel.org>; Wed, 28 Jun 2023 17:08:24 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 6B0571CA273
	for <virtio-dev@archiver.kernel.org>; Wed, 28 Jun 2023 17:08:23 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 599649865D4
	for <virtio-dev@archiver.kernel.org>; Wed, 28 Jun 2023 17:08:23 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 4B680986585; Wed, 28 Jun 2023 17:08:23 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3A3BB98658B
	for <virtio-dev@lists.oasis-open.org>; Wed, 28 Jun 2023 17:08:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: ZTepGoClMqaggbjdaw9IrQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687972098; x=1690564098;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YGaPlVIs/6rK4lEovUPznMxXNratqVvD8pzB67ABWs0=;
        b=j0d3F0SDX72MzKRm+iCVewhmZams5ck8zTZl5xECfcx7Njbr3rhV1uMcCLNKCSCfu6
         6qriJvhzdPkwUZ36bieCzNNVNf8kVe3hs0oF4DpTaN/wF42mNjgToEs0M1Uur7VsYchX
         xoGI0W1AtCzwbGQY0/GhZN+EVD0tFOPNs6WP2tv5CAntVO+5RYGAmbtDL49Fe+Uimxj3
         6Pnaxf88lUrzZ3VIvAAY9PhWm+G/Y/QtcvFzD7PfzE1/c0b2NGwH6wIcH4rMvUl00MHO
         xdyCMxAOzd99ujFuHE3HzdiVWO0wwT6NJjt1EqSDexVpx4tHz09DcA3kEEk4T4hz14pz
         3bBg==
X-Gm-Message-State: ABy/qLYMA7ojDlyjZsRPfZWA7enfej6NyKI0wyluWFqM8XbxJeB8wVaq
	ByuxgU4eOgXWkOI2v1SGd1Sah4Nbwi+2gkbvlfZkRbi3PhIXoSfsJWJcmW+e2Z1vO8fK60bIGtM
	LaH8ClTfbo6zBLNXpkLT6rito+8yu
X-Received: by 2002:a05:6000:925:b0:314:11e6:da8a with SMTP id cx5-20020a056000092500b0031411e6da8amr866132wrb.1.1687972098560;
        Wed, 28 Jun 2023 10:08:18 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE+poUcPKjpK3C30ld27M+EHn9lOzZtHDLnKR6yZGnvgsV1lUwoLSgQqr75V7SSCPYWbQrxKg==
X-Received: by 2002:a05:6000:925:b0:314:11e6:da8a with SMTP id cx5-20020a056000092500b0031411e6da8amr866118wrb.1.1687972098149;
        Wed, 28 Jun 2023 10:08:18 -0700 (PDT)
Date: Wed, 28 Jun 2023 13:08:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	Jason Wang <jasowang@redhat.com>,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Cornelia Huck <cohuck@redhat.com>
Message-ID: <20230628124708-mutt-send-email-mst@kernel.org>
References: <82e83a90-6491-c20b-d96d-f9e0d15c2641@linux.alibaba.com>
 <PH0PR12MB5481A5055A5F58045437391CDC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230622123203-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548100743287D401B8ED78CFDC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230622125601-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481FFF9F0F1443F75782C26DC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230622131455-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54812CE792CC801B36AC6E56DC22A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230628062758-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481F6DD7652BE1998635DE2DC24A@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481F6DD7652BE1998635DE2DC24A@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] Re: [PATCH v18] virtio-net: support inner
 header hash

On Wed, Jun 28, 2023 at 04:46:04PM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Wednesday, June 28, 2023 6:41 AM
> 
> > > > So just quickly add the new capability in the spec and then the
> > > > number of linux releases that will have the new feature but not
> > > > config command or whatever that is will be too small for vendors to care.
> > > >
> > > I didn't follow this suggestion.
> > 
> > It is very simple though. 1.3 has inner hash feature. Imagine that instead of
> > endless flamewars rehashing same arguments, immediately post
> 
> For sure if you call this discussion a war, I didn't start it and I didn't delay it to this point either :)

Yea sorry I'm being harsh, the threads here grow too much. We all need
to make an effort not to repeat ourselves.

> Patch added GET and SET command, GET returns device static and dynamic value, without burdening the device in consistent way.
> Will moving to config space, take away the GET command? No?
> 
> Then what did one gain other than extra complexity of additional config space? Just more device memory burning.

I don't think Linux will ever use GET. It's there for completeness, I'm
fine with getting rid of it too.


> > 1.3 we vote on an interface to access config space through DMA (not sure it's a
> > VQ BTW but that's a separate discussion).  This should include a way to expose
> > a subset of DMA features through MMIO, for compatibility.
> 
> I think you are missing the main point that I try to highlight but presumably it didn't come across. :(
> 
> Having an optional DMA interface does _not_ help device to optimize, because device must be support old drivers.

Yea, I don't get it, sorry.
So where's this old driver that uses the inner hash feature?
It maybe will be released down the road right?
Why can't it at the same time support DMA for access to this field?






> The proposal I explained in previous email is:
> a. All new fields via vq
> This means it is _guaranteed_ to be offchip and zero reason for backward compatibility, because there is no backward compat of non existing fields.
> 
> b. all existing fields stay in cfg space
> 
> c. Optionally existing fields can also be queried via cfg space


And what I say is even simpler:
	all config space is accessible through DMA
	some of it optionally in MMIO

which fields to have in MMIO will be up to device.
Research what do drivers you care about use, and include that.






> > If we are lucky guest support can land in the same Linux release that has inner
> > hash.  Drivers do not need to care: they just do virtio_cread and that is it.
> >
> virtio_cread for extended config space accessible only via DMA or VQ will surely be hidden inside th virtio_cread(). Easy.
>  
> If we agree on this approach, great, one additional field like this can be added to config space.

I think we are pretty close then, great!


> > So a vendor that builds device with inner hash, can expose inner hash only
> > through DMA and not through MMIO.
> > 
> > I conclude that there's no reason to block this feature just because it uses config
> > space.
> >
> I must repeat that I am not blocking, I replied to way back on both the approaches in v14 or even before that.
> And also explained part of the proposal.
> 
> This is why one should discuss the design and not keep asking for patches..

I certainly don't prevent anyone from posting design sketches.  Problem
is this: even spec patches are often hard to understand, agrammatical,
etc. Not sure what to do here, but it's understandable when people only
start reviewing in earnest when the text gets half way readable.


> > 
> > > > >
> > > > > > A good implementation of virtio_cread can abstract that easily
> > > > > > so we don't need to change drivers.
> > > > >
> > > > > There is no backward compat issue for the GET command being new.
> > > >
> > > > It's just a shortcut replacing what we really want.  As long as a
> > > > shortcut is available people will keep using exactly that.  So I
> > > > fully expect more proposals for such GET commands on the pretext
> > > > that one is there so why not another one. Adding more tech debt for
> > > > whoever finally gets around to building a config space access gateway.
> > > >
> > > Not really. as suggested, the first addition of new field to the config space in
> > 1.4-time frame, should add the cfgvq, and not follow the previous example.
> > > Because this is being thought through now, it is not at all hard for any new
> > things to follow the guideline.
> > 
> > Really. Oh great, so there will be 3 ways to provision things!
> >
> Not sure how you concluded 3 ways...
> Provision is via single command via AQ by the owner device.

heh but what does this command get? if everything
device specific is in
config space it can just get config space layout exactly
and we have no extra work. if there's stuff not in config
space then it needs extra layout for that.

Yes I understand there's transport specific stuff.


> New config fields via VQ of member device itself, again single way.
> Existing config fields access via config space, single way.

That's two ways. The 3rd way refers to using cvq for inner hash
and future cfgvq for other config space.


> > I have not seen this patch yet.  And how long will this take to materialize? I don't
> > believe all TC work must be blocked until this happens, or alternatively use ad-
> > hock hacks.
> It is surely not the right way to ask for the patch when doing the design discussion and claiming that it is not ready.
> > 
> > I get it you want to save on chip memory. So work on a consistent soltion for
> > this.
> > 
> > All config space accesses should go through DMA.
> This is not predictable due to backward compat need.
> Hence the ask is all *new* config space access go through DMA.

Let's make it all go through DMA. As a vendor, you decide whether
inner hash is worth supporting now with MMIO or later with DMA.
What is wrong with that?


> > Thus no special guidelines should be necessary, and drivers can just keep doing
> > virtio_cread like they always did.
> >
> This can be very easily achieved in sw by knowing extended config space offset to use DMA.

Yea, doable. But why do you want to make future devices more expensive,
forever? then people will turn around and say we want IDPF it does
not have this baggage.

> > To add to that, it will allow cheaper devices as some existing config space will be
> > able to move quickly.
> This is possible only in those config when device side can know early enough, through a new feature bit and new registers for DMA, which will pay off for larger config space extended region.
> 
> 
> I want to summarize my humble input:
> 
> 1. all new extended config space fields to be accessed only via DMA/VQ by member device itself.

I propose optionally allow this in MMIO if device wants to.

> 2. all existing fields to stay in config space without any interface change

you mean in MMIO. ok.

> 3. optionally existing fields can be accessed vid DMA/VQ by member device itself.

I propose making this mandatory.

> 4. If above proposal looks reasonable, sure, have the inner hash field of this patch as part of existing config space. I have no problem with it.
> 
> 5. any new fields proposed in extended config space in 1.4-time frame must implement DMA/VQ interface as part of the proposal.

instead, I just propose that DMA is always a superset of MMIO.
So using DMA you know you are not missing out on anything.


> 6. And if this needs more discussion, lets spend quality time on it and differ the release by a week and at least agree on the path forward.
> No need to draft the spec normative language for design.

Yes no problem to delay a bit.

What do you think of the changes I proposed above?


-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

