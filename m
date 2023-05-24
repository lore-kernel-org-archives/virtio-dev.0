Return-Path: <virtio-dev-return-12816-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9CA7C7EE2D
	for <virtio-dev@archiver.kernel.org>; Wed, 24 May 2023 19:58:16 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 4DED817917F
	for <virtio-dev@archiver.kernel.org>; Wed, 24 May 2023 19:58:15 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4419C986555
	for <virtio-dev@archiver.kernel.org>; Wed, 24 May 2023 19:58:15 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 352C69864BF; Wed, 24 May 2023 19:58:15 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 222B69864CD
	for <virtio-dev@lists.oasis-open.org>; Wed, 24 May 2023 19:58:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: LoP-ExGgOlGL97gLcrAkQQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684958286; x=1687550286;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uszJM1MPot7zZVlNabwipFhkEQEhQWzB343i/tRhCu4=;
        b=BL5kIxKUIVNFbB+xG0QzBpUQRmCsE+lrcWsq8NVaAq6DfuQmP83JUP57wa7G2XBnUg
         fF9vS/Jiev999DhaRdDuXv2s0iBqGTw6aDpudUN4XTtwag6FIeyjrCsXqLrDIZgLGZeD
         cvRmkAXA8NL3ApEm4nMcZLhjovV+FfI/GO4MpPKhzvumUdOUHawx0hOwKg9k7Vpf0Kwk
         jlNd1NgVMJDpIQpdw7lOcZPO4pEDHFWuqRYcJNrl8h5LGX9pdXeknOXc+WWpMBPnzWkt
         lb8r/6K3Tfj2d6HbuVb1ukO3rUp+U8ZJD+2fW601S37SgkXivUMbt1bV9lx8QCf5oLqR
         fSzg==
X-Gm-Message-State: AC+VfDxa12nUatZQ2vayppmlEcIA//yK+OgWR3wRhKwndsNBSdrn3L1e
	pdl0x2E544elCTyTBfMF6UaEQHbIrzFcIyv90j/e19ffqxIwi69u3HwAQcS9qdCPfhx1hWPBco+
	jGtCCrW/UJGmcGq3ckjQcOJl8CkJb
X-Received: by 2002:a5d:4c8b:0:b0:306:37bf:ca5a with SMTP id z11-20020a5d4c8b000000b0030637bfca5amr623075wrs.47.1684958286382;
        Wed, 24 May 2023 12:58:06 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5yLc/QlTqguJiujCJD+ajavynSdvNEMQHBtiXWa7ghBiY/P5uEMLu4b8jkSxCQmxpnes5leQ==
X-Received: by 2002:a5d:4c8b:0:b0:306:37bf:ca5a with SMTP id z11-20020a5d4c8b000000b0030637bfca5amr623058wrs.47.1684958286024;
        Wed, 24 May 2023 12:58:06 -0700 (PDT)
Date: Wed, 24 May 2023 15:58:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Jason Wang <jasowang@redhat.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"david.edmondson@oracle.com" <david.edmondson@oracle.com>,
	"sburla@marvell.com" <sburla@marvell.com>,
	Yishai Hadas <yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Message-ID: <20230524155301-mutt-send-email-mst@kernel.org>
References: <CACGkMEsp0i7EyyBBp06wJzrVBLNbH7MP_TT-j7b5c_yavgAmqw@mail.gmail.com>
 <20230511085205-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54812F2EFEC7B6A235953A82DC749@PH0PR12MB5481.namprd12.prod.outlook.com>
 <0f75a142-71e9-676a-11ae-a54e6dbb472d@redhat.com>
 <20230515060641-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54817BC2F2FBFE3609AFA23CDC789@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230523141439-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481E89D0E5DD6F291F8E149DC409@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230524013429-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481E07A038AFF7E461C6912DC419@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481E07A038AFF7E461C6912DC419@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v2 0/2] transport-pci: Introduce legacy registers access
 using AQ

On Wed, May 24, 2023 at 06:57:30PM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Wednesday, May 24, 2023 1:57 AM
> 
> 
> > I am frankly lost at this point, this thread is too big.
> > 
> > So where do you want to go for this project?  I would like something specific,
> > email threads are growing too big.
> > I think the reason is that there is actually a host of small related subprojects. So
> > when you propose just this small feature, everyone jumps in with their own pet
> > project proposing addressing that too.
> > 
> > For example:
> > - SIOV guys were adding transport over VQ. It would seem that
> >   can include support for legacy.
> Yes. SIOV can support legacy and modern emulation.
> We need to have the SIOV devices without this emulation support so that they natively good.
> 
> > - For migration we need ability to report member events to owner.
> Which events you have in mind?

memory faults/dirtying for example.

> The AQ is design to carry the migration of the VFs and would be controlled via the AQ so it knows whats going on.
> 
> >   It would seem that can be used to support INT#x.
> > - Ability to stick capabilities in extended config space
> >   is a good idea, for a variety of reasons.
> > 
> > and so on.  Understandably frustrating, and it is easy to go overboard with
> > generality.
> > 
> > If you feel your path for progress is clear, that's good.
> The path seems clear to me for supporting legacy registers access for the VFs and future SIOV.
> Let's conclude it in other thread we are discussing of patch 1/2.
> 
> > if not, here are ideas for getting this unstuck:
> > - start a TODO.md file with a list of things we need to address,
> >   and for each one a list of options
> > - everyone will add to this file then we get a higher level
> >   picture and can discuss "this will be addressed by A, that by B"
> This is certainly present in my personal todo list to discuss, I am happy to maintain in the public virtio doc at
> https://github.com/oasis-tcs/virtio-docs/
> 
> > - have a chat at the upstream developers meeting (May 31)
> >   so far it's about vdpa blk
> > - anyone coming to the kvm forum to have a chat there?
> > 
> > Hope this helps.
> Definitely a good suggestion.
> I will send PR for virtio-docs to maintain our TODO list.

Hmm. This is just a dumping ground then.  Fine by me, but what I had in
mind is a common list of known problems to address by TC as a whole.
If you want that we want patches on list and discussion, maybe even
voting.


> Since some of the discussions are ongoing basis if we can meet monthly
> on more practically on need basis, it will help to make progress
> faster.

That meeting is byweekly actually I think.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

