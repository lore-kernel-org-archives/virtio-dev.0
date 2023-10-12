Return-Path: <virtio-dev-return-13998-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52090CDB46E
	for <virtio-dev@archiver.kernel.org>; Thu, 12 Oct 2023 09:59:45 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 8D7FA749ED
	for <virtio-dev@archiver.kernel.org>; Thu, 12 Oct 2023 09:59:44 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 61C1A986828
	for <virtio-dev@archiver.kernel.org>; Thu, 12 Oct 2023 09:59:44 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 439E7986474; Thu, 12 Oct 2023 09:59:44 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2FAA698660F
	for <virtio-dev@lists.oasis-open.org>; Thu, 12 Oct 2023 09:59:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 1El60NkAOgW5LqIKpu2AHA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697104780; x=1697709580;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jKXLchiWN9cxSFNH/uAw6BjF5FTBg1Yi/KiDE8wDnOk=;
        b=mO/S+XF+UOjCzIhZ+IU+fYVXZfvHh+oDZxAQZz0Vycl5GgCPNC52x65qtO9rlXhUzI
         881tpPOULNParViBs6fTrRQgVGbuTPg+o6Q1h6sQC/5vJzSP86DuQT+N+7vsNrRSlGF2
         mPf9NN+Cm6f4esjmEPu4gnCHvg9igVmv5zj5bMFOy0a+EXQ0c0hlO+6znkH4xB75CSM8
         G4weCzcGmSITtgMkWjtwz1YSQCqoBiIJDo8y60dDHAj7kvx3niij6wKdmIA4Lz0RbDZU
         Wi8pcOGha8hBgYWLE+J4ejErdcDGGJdLZrAavbrwYj9ZrDr8VVrHelI+2BGFPI9xRD7w
         NLeA==
X-Gm-Message-State: AOJu0YxY+em2jvo/8QkI0iQiCWIdhCsxB+x1gTjbXWS6PxGSlIbtQ9hY
	vSrTgVY9DbyZN9juWQ0A+Pzf1lvjDZunRjagNF6yJEjI1i9T11ZmRY3nGq2RbINR6ouATa0Q3zW
	IOVl5iq7i9ZIGnfqBWDknlAuXlTy6
X-Received: by 2002:a05:600c:1d22:b0:407:4993:984c with SMTP id l34-20020a05600c1d2200b004074993984cmr10499237wms.30.1697104780314;
        Thu, 12 Oct 2023 02:59:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDay0hW53ER5lFEnSRBal2GFaroxlVbyM2hDWt4KKmyDxN2h7mpCkf6+8y0BLSJA2LpRNQUA==
X-Received: by 2002:a05:600c:1d22:b0:407:4993:984c with SMTP id l34-20020a05600c1d2200b004074993984cmr10499220wms.30.1697104779838;
        Thu, 12 Oct 2023 02:59:39 -0700 (PDT)
Date: Thu, 12 Oct 2023 05:59:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Parav Pandit <parav@nvidia.com>,
	Jason Wang <jasowang@redhat.com>,
	"eperezma@redhat.com" <eperezma@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Message-ID: <20231012054804-mutt-send-email-mst@kernel.org>
References: <PH0PR12MB5481C11F6D68A892A091E2AFDCC3A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <e9c482d5-1441-fec5-b55b-f1ac6e81f85b@intel.com>
 <PH0PR12MB5481C57B255B0D5EA6FB109DDCC3A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <ddbd47c8-6985-2d08-bf98-0e7516f0c3c4@intel.com>
 <20230926064201-mutt-send-email-mst@kernel.org>
 <305d9907-9668-d362-1ff2-49a5e9f90e42@intel.com>
 <20230927113510-mutt-send-email-mst@kernel.org>
 <558fe3d6-0b81-4def-7256-52ac3cbffa8f@intel.com>
 <20231011061508-mutt-send-email-mst@kernel.org>
 <373821b2-1a1e-3bf3-51dc-8af54db85d00@intel.com>
MIME-Version: 1.0
In-Reply-To: <373821b2-1a1e-3bf3-51dc-8af54db85d00@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] Re: [virtio-dev] Re: [PATCH 0/5] virtio:
 introduce SUSPEND bit and vq state

On Wed, Oct 11, 2023 at 06:38:32PM +0800, Zhu, Lingshan wrote:
> 
> 
> On 10/11/2023 6:20 PM, Michael S. Tsirkin wrote:
> > On Mon, Oct 09, 2023 at 06:01:42PM +0800, Zhu, Lingshan wrote:
> > > 
> > > On 9/27/2023 11:40 PM, Michael S. Tsirkin wrote:
> > > > On Wed, Sep 27, 2023 at 04:20:01PM +0800, Zhu, Lingshan wrote:
> > > > > On 9/26/2023 6:48 PM, Michael S. Tsirkin wrote:
> > > > > > On Tue, Sep 26, 2023 at 05:25:42PM +0800, Zhu, Lingshan wrote:
> > > > > > > We don't want to repeat the discussions, it looks like endless circle with
> > > > > > > no direction.
> > > > > > OK let me try to direct this discussion.
> > > > > > You guys were speaking past each other, no dialog is happening.
> > > > > > And as long as it goes on no progress will be made and you
> > > > > > will keep going in circles.
> > > > > > 
> > > > > > Parav here made an effort and attempted to summarize
> > > > > > use-cases addressed by your proposal but not his.
> > > > > > He couldn't resist adding "a yes but" in there oh well.
> > > > > > But now I hope you know he knows about your use-cases?
> > > > > > 
> > > > > > So please do the same. Do you see any advantages to Parav's
> > > > > > proposal as compared to yours? Try to list them and
> > > > > > if possible try not to accompany the list with "yes but"
> > > > > > (put it in a separate mail if you must ;) ).
> > > > > > If you won't be able to see any, let me know and I'll try to help.
> > > > > > 
> > > > > > Once each of you and Parav have finally heard the other and
> > > > > > the other also knows he's been heard, that's when we can
> > > > > > try to make progress by looking for something that addresses
> > > > > > all use-cases as opposed to endlessly repeating same arguments.
> > > > > Sure Michael, I will not say "yes but" here.
> > > > > 
> > > > >   From Parav's proposal, he intends to migrate a member device by its owner
> > > > > device through the admin vq,
> > > > > thus necessary admin vq commands are introduced in his series.
> > > > > 
> > > > > 
> > > > > I see his proposal can:
> > > > > 1) meet some customers requirements without nested and bare-metal
> > > > > 2) align with Nvidia production
> > > > > 3) easier to emulate by onboard SOC
> > > > Is that all you can see?
> > > > 
> > > > Hint: there's more.
> > > please help provide more.
> > Just a small subset off the top of my head:
> > Error handling.
> handle failed live migration? how?

For example you can try restarting VM on source.
Or at least report an error to hypervisor.


> and for other errors, we have mature error handling solutions
> in virtio for years, like re-read, NEEDS_RESET.

facepalm

Are you aware of the fact that Linux still doesn't support
it since it turned out to be an extremely awkward interface
to use?

> If that is not good enough, then the corollary is:
> admin vq is better than config space,


You keep confusing admin vq with admin commands.


> then the further corollary could be:
> we should refactor virito-pci interfaces to admin vq commands,
> like how we handle features
> 
> Is that true?
> > Extendable to other group types such as SIOV.
> For SIOV, the admin vq is a transport, but for SR-IOV
> the admin vq is a control channel, that is different,
> and admin vq can be a side channel.
> 
> For example, for SIOV, we config and migrate MSIX through
> admin vq. For SRIOV, they are in config space.

And that's a mess. FYI we already got feedback from Linux devs
who are wondering why we can't come up with a consistent
interface that does everything.


> > Batching of commands
> > less pci transactioons
> so this can still be a QOS issue.
> If batching, others to starve?

And if you block CPU since you are not accepting
a posted write this is better?

> > Support for keeping some data off-device
> I don't get it, what is off-device?
> The live migration facilities need to fetch data from the device anyway

Heh this is what was driving nvidia to use DMA so heavily all this time.
no - if data is not in registers, device can fetch the data from
across pci express link, presumably with a local cache.


> > 
> > which does not mean it's better unconditionally.
> > are above points clear?
> The thing is, what blocks the config space solution?
> Why admin vq is a must for live migration?
> What's wrong in config space solution?

Whan you say what's wrong do you mean you still see no
advantages to doing DMA at all? config space is just better
with no drawbacks?

> Shall we refactor everything in virtio-pci to use admin vq?

> > 
> > as long as you guys keep not hearing each other we will keep
> > seeing these flame wars. if you expect everyone on virtio-comment
> > to follow a 300 message thread you are imo very much mistaken.
> I am sure I have not ignored any questions.
> I am saying admin vq is problematic for live migration,
> at least it doesn't work for nested, so why admin vq is a must for live
> migration?


My suggestion for you was to add admin command support to
VF memory, as an alternative to admin vq. It looks like that
will address the nested virt usecase.

> > 
> > > > 
> > > > 
> > > > 
> > > > 
> > > > > The general purpose of his proposal and mine are aligned: migrate virtio
> > > > > devices.
> > > > > 
> > > > > Jason has ever proposed to collaborate, please allow me quote his proposal:
> > > > > 
> > > > > "
> > > > > Let me repeat once again here for the possible steps to collaboration:
> > > > > 
> > > > > 1) define virtqueue state, inflight descriptors in the section of
> > > > > basic facility but not under the admin commands
> > > > > 2) define the dirty page tracking, device context/states in the
> > > > > section of basic facility but not under the admin commands
> > > > > 3) define transport specific interfaces or admin commands to access them
> > > > > "
> > > > > 
> > > > > I totally agree with his proposal.
> > > > > 
> > > > > Does this work for you Michael?
> > > > > 
> > > > > Thanks
> > > > > Zhu Lingshan
> > > > I just doubt very much this will work.  What will "define" mean then -
> > > > not an interface, just a description in english? I think you
> > > > underestimate the difficulty of creating such definitions that
> > > > are robust and precise.
> > > I think we can review the patch to correct the words.
> > > > 
> > > > Instead I suggest you define a way to submit admin commands that works
> > > > for nested and bare-metal (i.e. not admin vq, and not with sriov group
> > > > type). And work with Parav to make live migration admin commands work
> > > > reasonably will through this interface and with this type.
> > > why admin commands are better than registers?
> > > 
> > > This publicly archived list offers a means to provide input to the
> > > OASIS Virtual I/O Device (VIRTIO) TC.
> > > 
> > > In order to verify user consent to the Feedback License terms and
> > > to minimize spam in the list archive, subscription is required
> > > before posting.
> > > 
> > > Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> > > Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> > > List help: virtio-comment-help@lists.oasis-open.org
> > > List archive: https://lists.oasis-open.org/archives/virtio-comment/
> > > Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
> > > List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
> > > Committee: https://www.oasis-open.org/committees/virtio/
> > > Join OASIS: https://www.oasis-open.org/join/
> > > 


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

