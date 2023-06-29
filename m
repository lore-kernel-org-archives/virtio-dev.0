Return-Path: <virtio-dev-return-13156-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D82FEB64DD
	for <virtio-dev@archiver.kernel.org>; Thu, 29 Jun 2023 19:35:36 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 8E069419B7
	for <virtio-dev@archiver.kernel.org>; Thu, 29 Jun 2023 19:35:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6EE85986704
	for <virtio-dev@archiver.kernel.org>; Thu, 29 Jun 2023 19:35:34 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 585569865B5; Thu, 29 Jun 2023 19:35:34 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2B28F986677
	for <virtio-dev@lists.oasis-open.org>; Thu, 29 Jun 2023 19:35:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 93dZEb1vN0qCKbDLj5qTsg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688067320; x=1690659320;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=knH21IFruCIg33l6T9KZjkWBOdv9GZE6vAthMmADri8=;
        b=KYSrSft9rQD2Dob7yMW1+hfofIWzvA+ibeGSZmXgpyj8u/8L15byRNQHa9v4sXW+mu
         ZY5EwsJBNcvNjD9AA6Qp14k1jfirdlo8KcAGXvDW2YiYfPSP+SNwg6K1H2DfqSM9IbOs
         56YKpD3svHlMinoSgkFqBeAI/8py8aulceLZDQBPjzXuRmk51mtKLI3g/1DbNp6D4Cdi
         ifuzQVExuvQhRJcFidQCLYZ49XkjxuZQl3ylOag7OpXCIHU4z9opwRO2tZ6M4UHPBZPj
         9VK4tyeL/H5ii3Y6khnpFrAdEbLTMdf03bOdACfvoDL7KK/4JuZPVbunn6D1qMcE5u69
         ybyg==
X-Gm-Message-State: ABy/qLb5zUEjgCljLuwSl237uXvcSTlizCF5I2/tdBV4flWCMlX2VJOr
	i6hET9zzqV+aOglOLOpAlSa193QCqAeSpCGgaASZoSX+RPw9Mi2UJLV+O5cjqVugEA64BLTIepT
	tD01liPYfN5YvN9FU9XxUwCPvXLvj
X-Received: by 2002:a5d:6e56:0:b0:313:f33c:24c4 with SMTP id j22-20020a5d6e56000000b00313f33c24c4mr424105wrz.39.1688067319920;
        Thu, 29 Jun 2023 12:35:19 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGDyWl6peSg4mKE9DKTzv7p1IyNT/p9yCIGj9Qp+dgHOWs7tMrDZSWmt8ofQpXW0qSSTNRgrw==
X-Received: by 2002:a5d:6e56:0:b0:313:f33c:24c4 with SMTP id j22-20020a5d6e56000000b00313f33c24c4mr424093wrz.39.1688067319507;
        Thu, 29 Jun 2023 12:35:19 -0700 (PDT)
Date: Thu, 29 Jun 2023 15:35:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Cornelia Huck <cohuck@redhat.com>,
	"virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Message-ID: <20230629153345-mutt-send-email-mst@kernel.org>
References: <87edoyqvnu.fsf@redhat.com>
 <20230407071926-mutt-send-email-mst@kernel.org>
 <87r0spjct2.fsf@redhat.com>
 <PH0PR12MB54819136AEC54AA081DD395ADC25A@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54819136AEC54AA081DD395ADC25A@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] [RFC] virtio 1.3 schedule

On Thu, Jun 29, 2023 at 05:41:34PM +0000, Parav Pandit wrote:
> Hi Cornelia, Michael,
> 
> > From: virtio-comment@lists.oasis-open.org <virtio-comment@lists.oasis-
> > open.org> On Behalf Of Cornelia Huck
> > Sent: Wednesday, April 12, 2023 12:17 PM
> 
> > >> - July 1st 2023: enter feature freeze; all proposed changes must at
> > >>   least have an open github issue that refers to a proposal on-list
> > >> - August 1st 2023: enter change freeze; everything needs to have been
> > >>   voted upon (i.e. we can start with preparations for a release like
> > >>   compiling the change log)
> > >> - at the same time, fork virtio-next, which can be used for development
> > >>   while we're working on the release
> > >> - August/September 2023: prepare draft, initiate initial voting etc.
> > >
> > > Hmm looks like you forgot a 30 day the public review period (or is
> > > that included in the "etc"? ).  During this period we will likely
> > > receive review comments which we have to address. Should the changes
> > > turn out to be material, another public review period will be required.
> > > Let's spell it out please.
> > 
> > Yeah, that's what I meant with "etc"... let's make this:
> > 
> > - August 2023: prepare draft, aim to have it ready and voted upon by
> >   August 31 the latest (preferrably earlier)
> > - September 2023: public review period (30 days)
> > - October 2023: another public review period, if needed; otherwise, get
> >   comittee specification ready and voted upon
> > - October (maybe November, if we're running late) 2023: virtio 1.3
> >   released
> > 
> > The most important dates are feature freeze on Jul 1 and change freeze on Aug
> > 1, I guess; for the rest, we depend on whether people are out on PTO, which
> > kind of feedback we get, etc. -- but as long as we release
> > 1.3 in 2023, I'll be happy enough.
> 
> We have two extension features that has gone through several reviews and are in advance stage (and also late) for 1.3. :)
> 
> 1. inner hash v19, rolling to v20 anytime this week. 1 Patch.
> [1] https://lists.oasis-open.org/archives/virtio-comment/202306/msg00490.html
> 
> 2. first user of aq for legacy access at v7.
> 2 patches. First 2 are Fixes.
> [2] https://lists.oasis-open.org/archives/virtio-comment/202306/msg00491.html
> 
> Both need few more days of review and vote.
> Shall we please have few days in July for them so that it can be part of 1.3? 
> or whole July is needed to prepare the draft spec?

I think it's not too bad, projects that do releases every couple of
months can afford to be strict, we do them ones a year and a half
it makes sense to be flexible.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

