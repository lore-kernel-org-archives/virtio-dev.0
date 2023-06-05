Return-Path: <virtio-dev-return-12867-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE615C7EE24
	for <virtio-dev@archiver.kernel.org>; Mon,  5 Jun 2023 21:57:14 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 15FD26846A
	for <virtio-dev@archiver.kernel.org>; Mon,  5 Jun 2023 21:57:14 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E856B98649D
	for <virtio-dev@archiver.kernel.org>; Mon,  5 Jun 2023 21:57:13 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id D1E2B986486; Mon,  5 Jun 2023 21:57:13 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B942898648A
	for <virtio-dev@lists.oasis-open.org>; Mon,  5 Jun 2023 21:57:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: bL47BhPPOfSeTcJ_zusf_g-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686002230; x=1688594230;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o/i9s4K/c6xtxmoKDqVUXpMb3RyrGC9Wd0t+58xgX1o=;
        b=CrL1VaXbw8rB0INz8s8FnNdWMMHZm5ocHCzSosHa9QvGkwm5R3oGfZHk+1OwO/uC42
         kotGBQneBBX/jNxTq7nWvtLdk2CC/xC0OsYwQzOVw59qg7mVjjp+g/pVXH9r6DyRalV0
         xPR+URyskOa9RcGlUZo3xyv5wc4jV90nZeE97Q0amQs8DkpOAbxSLMk04Rv0M/mob+SS
         KdzQ76D9Ja/YpE+SrCWnnr19KFKEC7ny4Am5m2Su4r68ckeKuYr0QGxFY9/e3yom7rXm
         a/NiBxoNVff4Nx1+pF81WN0NkccLstu40UbdhipZsrqQ9fcTkQUBh9T9nZJw6lc9om03
         Ml2A==
X-Gm-Message-State: AC+VfDzmBuLGWLkiYsum1ZT9BSQfT9sgDASSx/0siue33ACWPjAMrWAT
	uDxVrEu/0yAb45pB3G+exQBltQEL9diAqDrx8V7wqxJeCuGICvMb6nMGLeyZTrivVtyDQaE97uB
	jMxRo6y6UJVKlwMz1m71T+qDUj74y
X-Received: by 2002:adf:fe91:0:b0:30d:5071:b035 with SMTP id l17-20020adffe91000000b0030d5071b035mr161291wrr.56.1686002230161;
        Mon, 05 Jun 2023 14:57:10 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ65HekcIgydehCi1Wr6j2updk10S9C6nDi22I1rtl86xK3agyNrSYbnngYcHpWwqWYg7pzGSg==
X-Received: by 2002:adf:fe91:0:b0:30d:5071:b035 with SMTP id l17-20020adffe91000000b0030d5071b035mr161272wrr.56.1686002229832;
        Mon, 05 Jun 2023 14:57:09 -0700 (PDT)
Date: Mon, 5 Jun 2023 17:57:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"david.edmondson@oracle.com" <david.edmondson@oracle.com>,
	"sburla@marvell.com" <sburla@marvell.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	Yishai Hadas <yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Message-ID: <20230605174755-mutt-send-email-mst@kernel.org>
References: <20230604101351-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548139ACEC00E7CA6D988182DC4CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230604105027-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481B721C34D85D63FCC1F3DDC4CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230604174224-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481DABA25CA36A5460B13E5DC4CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230605014539-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481C14D65D5E10CD23A9F67DC4DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230605092859-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481CEB3A34AAB49A282F2A8DC4DA@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481CEB3A34AAB49A282F2A8DC4DA@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v3 0/3] transport-pci: Introduce legacy registers access
 using AQ

On Mon, Jun 05, 2023 at 04:04:57PM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Monday, June 5, 2023 9:50 AM
> 
> > > Can you explain the motivation of : why querying notification offset via the
> > group member PF is a problem, if there is."
> > 
> > I tried already, I can repeat if you like:
> > 
> > So, I am thinking of a model of using a tiny stub driver for the member.
> This is what is proposed here.
> 
> > Control path driver is bigger as it operates AQ command, that would be the
> > owner driver.  E.g. for PCI this driver needs to map BAR offsets.
> The bar belongs to the PCI VF and hence BAR mapping will be done by the VF tiny stub driver, aka vfio vf driver in this proposal.
> And control path driver provides the AQ facility to issue the commands for register read/write.
> 
> > Then it handles all data path for this member: driver and device notifications.
> > It is clean and easy on all systems assuming you know offsets at device probe.
> > But getting it in software from another driver (owner driver) is AFAIK tricky on
> > some systems.
> > 
> We can assume that systems will eventually improve as multiple OS are improving one way or another.
> 
> > Generally solutions can be found, they can be more or less robust, and if
> > systems designers have to overcome obstacles in implementing virtio they will
> > just go to a competing interface as opposed to jump through hoops and work on
> > extending either the OS or the virtio spec.
> > 
> 
> > Yes I know your sales department tells you there's no demand for this feature
> > on anything that is not linux/x86 and maybe arm, and maybe this means there
> > won't ever be either, but let's just not raise this again can we? E.g. there was
> > some interest from microsoft at some point, I think there was a reorg and that
> > project died but hey you never know.
> > Anyway, you asked I am trying to answer.
> > 
> It is not the sales department. MS has zero virtio tc presence to show the interest.
> MS has zero inbox driver to my knowledge without current feature.
> Hence, the absence shows lack of interest and hence building something for them with pessimism that they will not extend is not right IMHO.
> 
> > The cleanest way is just doing things consistently through one device.
> I would surely do that for all future devices which will be self-contained.
> The cost of doing that for legacy is not worth the efforts.
> And since we agree that read/write 4 commands are OK on the AQ, the 5th command is no exception to it.
> 
> We are not at the point of questioning the existence of 4 commands itself on AQ.

Yes I think these 4 are fine.

> > In this case for data path it has to be the VF, so let's just make this part simple
> > and self contained.
> > 
> So data path is on the VF to do driver notifications by the tiny stub vfio vf driver.
> It queries the PF driver when it wants to use AQ facility.

No. The VMM talks to either PF for config space or VF for data path.

> > 
> > > I don't see a problem with AQ that covers VF,SF/SIOV for legacy.
> > >
> > > Proposed AQ command is cheap and covers both VF, SF/SIOV.
> > 
> > Well for SIOV BAR has to be the owner BAR. This was exactly the reason I asked
> > for this. If it's not to be I think this is my second preference:
> > no new command at all, and SIOV will come up with its own.
> 
> So a AQ notify query command services both VF and PF.
> It always returns the BAR number for the own.

For the owner? owner of SRIOV group is PF, not VF.

> A PF would have delegated the window in the PF BAR to the SF/SIOV.
> And hence, this command is just fine like rest of the 4 commands.

It would be fine if it could return PF BAR, but in your proposal
it can't.

> (Linux already has SF accessing the PF dedicated BAR for more than 2 years for non virtio device).


What's the point of this discussion even? You ask some questions
apparently to clarify what issue I'm trying to address.  I try to
clarify. You then turn around and say we agree, there's no issue, all of
this does not matter, case closed.  Whom do you expect to convince with
this line of reasoning? 

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

