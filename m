Return-Path: <virtio-dev-return-13883-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE264CE79CF
	for <virtio-dev@archiver.kernel.org>; Wed, 20 Sep 2023 12:40:57 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 438278742B
	for <virtio-dev@archiver.kernel.org>; Wed, 20 Sep 2023 12:40:57 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1B217986671
	for <virtio-dev@archiver.kernel.org>; Wed, 20 Sep 2023 12:40:57 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 023E698666A; Wed, 20 Sep 2023 12:40:57 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E732098666B
	for <virtio-dev@lists.oasis-open.org>; Wed, 20 Sep 2023 12:40:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: P8Ca8NsCNBitjFB8H10LTQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695213652; x=1695818452;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nXJC+vU/acAYUVnhkTJDUUavmo47RfMhNn2aWcAyZoE=;
        b=o1trL59bXuad/sH04XnDpcU+co4EIx5ty7s28augyQETV0EOzKid6LuGp+tsej3t1y
         /qStNGBsSPP2w6ffPWcYc13DteOzBjBXJ1ZZsWLzGHkEg8nHLnAUdvFklgOIpwcWUWnK
         b/aZb0Px07XyzJk89MdN7ooquWLxqqG6ibgwnyQR34iwbHCnSNsbbpagGosgxjyAntCe
         upY3fq+7lMTafNjMq6ewQg7oj8j1e7KQ2SjFy8Vz3hpYqUPDYKI2zBOOCUaY1Xt0hIWq
         Lns0ZmgQnDHLVQedkkCp/hoBWKVXRzyvkMuejGKVnxGA6RPj/jy9f1IVT0Te4G45L7t8
         WtcA==
X-Gm-Message-State: AOJu0Yy1CA0GxT1V0qQ9SEAaIlbdUjMQ+D2+vHAuP1JIMn7DQCIJjrwX
	MQmn397LJ7B1Ln673Y7uVKnlNU4gu7Y3GmqF8yUUcYH3dnlMkkIX5dMUuPBKmR/n85eRz6E6Zjz
	tys7HLiJhlwOF2y2akouC04KEZ9bo
X-Received: by 2002:a05:6512:280b:b0:4f9:51ac:41eb with SMTP id cf11-20020a056512280b00b004f951ac41ebmr2731747lfb.16.1695213652050;
        Wed, 20 Sep 2023 05:40:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG//mqG5EkRPLdcgapJ9qt0hgsBxkkp3Owyx12oyzQNGjmSQBf9plbYGhaRbmGJr1yk3siPmA==
X-Received: by 2002:a05:6512:280b:b0:4f9:51ac:41eb with SMTP id cf11-20020a056512280b00b004f951ac41ebmr2731711lfb.16.1695213651461;
        Wed, 20 Sep 2023 05:40:51 -0700 (PDT)
Date: Wed, 20 Sep 2023 08:40:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>
Cc: Parav Pandit <parav@nvidia.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	Jason Wang <jasowang@redhat.com>
Message-ID: <20230920083057-mutt-send-email-mst@kernel.org>
References: <f1fe513e-d42d-03a6-348c-5e58aac0a759@intel.com>
 <PH0PR12MB5481323A3B4D67EB66328476DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <5f01772f-eb27-bfe0-7f69-b83fbd90dda0@intel.com>
 <PH0PR12MB5481ABF4B9BC2082BC54AB1DDCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230918144312-mutt-send-email-mst@kernel.org>
 <bb402c34-ad07-063a-f4f5-d8c6b3a642c7@intel.com>
 <20230920054836-mutt-send-email-mst@kernel.org>
 <2f67fb85-2238-9c34-a265-b0f97b7ab7e1@intel.com>
 <20230920075243-mutt-send-email-mst@kernel.org>
 <ec70e1c7-ffc3-fb6e-0b0a-6f51d7d9d0a5@intel.com>
MIME-Version: 1.0
In-Reply-To: <ec70e1c7-ffc3-fb6e-0b0a-6f51d7d9d0a5@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: Re: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and
 vq state

On Wed, Sep 20, 2023 at 08:16:13PM +0800, Zhu, Lingshan wrote:
> 
> 
> On 9/20/2023 8:05 PM, Michael S. Tsirkin wrote:
> > On Wed, Sep 20, 2023 at 07:22:32PM +0800, Zhu, Lingshan wrote:
> > > 
> > > On 9/20/2023 6:36 PM, Michael S. Tsirkin wrote:
> > > > On Wed, Sep 20, 2023 at 02:06:13PM +0800, Zhu, Lingshan wrote:
> > > > > On 9/19/2023 2:49 AM, Michael S. Tsirkin wrote:
> > > > > > On Mon, Sep 18, 2023 at 06:41:55PM +0000, Parav Pandit wrote:
> > > > > > > > Please refer to the code for setting FEATURES_OK.
> > > > > > > It wont work when one needs to suspend the device.
> > > > > > > There is no point of doing such work over registers as fundamental framework is over the AQ.
> > > > > > Well not really. It's over admin commands. When these were built the
> > > > > > intent always was that it's possible to use admin commands through
> > > > > > another interface, other than admin queue. Is there a problem
> > > > > > implementing admin commands over a memory BAR? For example, I can see
> > > > > > an "admin command" capability pointing at a BAR where
> > > > > > commands are supplied, and using a new group type referring to
> > > > > > device itself.
> > > > > I am not sure, if a bar cap would be implemented as a proxy for the admin vq
> > > > > based live migration.
> > > > Not a proxy for a vq in that there's no vq then.
> > > I think if the driver sends admin commands through a VF's bar, then
> > > VF forwards the admin commands to the PF, it acts like a proxy,
> > > or an agent. Anyway it takes admin commands.
> > Why send them to the PF? They are controlling the VF anyway.
> I think its still too heavy compared to this series proposal

it will be on you to prove all the complexity is unnecessary though.

> > 
> > > So the problems we have discussed still exist.
> > > > > then the problems of admin vq LM that we have
> > > > > discussed
> > > > > still exist.
> > > > I freely admit the finer points of this extended flamewar have been lost
> > > > on me, and I wager I'm not the only one. I thought you wanted to migrate
> > > > the device just by accessing the device itself (e.g. the VF) without
> > > > accessing other devices (e.g. the PF), while Parav wants it in a
> > > > separate device so the whole of the device itself can passed through to
> > > > guest. Isn't this, fundamentally, the issue?
> > > we are implementing basic facilities for live migration.
> > > 
> > > We have pointed out lots of issues, there are many discussions with
> > > Jason and Parav about the problems in migration by admin vq, for example:
> > > security, QOS and nested.
> > /me shrugs
> > Thanks for the summary I guess. Same applies to almost any proposal.
> > What would help make progress is an explanation why this has grown into
> > a megathread.  Do you understand Parav's thoughts well enough to
> > summarize them?
> as far as I see, I don't see admin vq as must for live migration.
> and it does not serve nested for sure.
> > 
> > > > > the bar is only a proxy, doesn't fix anything. and even larger
> > > > > side channel attacking surface: vf-->pf-->vf
> > > > In this model there's no pf. BAR belongs to vf itself
> > > > and you submit commands for the VF through its BAR.
> > > > Just separate from the pci config space.
> > > If using the bar to process admin commands,
> > > is this solution too heavy compared to my proposal in this series?
> > somewhat - because it's more comprehensive - you can actually
> > migrate a device using it.
> > this series just begins to define how to poke at some
> > of the vq state - it's a subset of the necessary functionality.
> > 
> > And it will give you a bunch of side benefits, such as
> > support for legacy compat commands that were merged.
> next version will include in-flight descriptors and dirty page tracking.

what we don't need is another version of this megathread.
which it sounds like you intend to restart?
nor do I cherish maintaining two independent mechanisms for doing
the same thing in the spec.
all of the above is already in parav's patchset so you guys should find
a way to work together rather than compete?

> I failed to process the comments for legacy.
> legacy devices are defined by code than the spec, if wants to migrate legacy
> devices, maybe working on QEMU first

that is not much in the way of addressing, just saying go pound sand.
the functionality has already been accepted by the TC though I don't
know what you are trying to say here. that we should drop it from spec?

> > 
> > 
> > 
> > > > The whole attacking surface discussion is also puzzling.  We either are
> > > > or are not discussing confidential computing/TDI.  I couldn't figure
> > > > it out. This needs a separate thread I think.
> > > I agree confidential computing is out of spec. Parva mentioned TDISP and
> > > even
> > > in TDISP spec, it explicitly defined some attacking model, and PF is an
> > > example.
> > > 
> > > It is out of spec anyway.
> > OK so we are ignoring TDISP applications for now? Everyone agrees on
> > that?
> sure
> > 


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

