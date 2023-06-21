Return-Path: <virtio-dev-return-13008-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CE21EB64D8
	for <virtio-dev@archiver.kernel.org>; Wed, 21 Jun 2023 15:56:31 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id A1C012AF9C
	for <virtio-dev@archiver.kernel.org>; Wed, 21 Jun 2023 15:56:30 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 818BF9865D0
	for <virtio-dev@archiver.kernel.org>; Wed, 21 Jun 2023 15:56:30 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 6766898643E; Wed, 21 Jun 2023 15:56:30 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5519C9865BD
	for <virtio-dev@lists.oasis-open.org>; Wed, 21 Jun 2023 15:56:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: JyfpfWfyMJOVJrh8ipbsKw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687362987; x=1689954987;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jyyJ7d//UA2fp95GTctqydabj3G6gELVMsFJ7pNar6M=;
        b=jSuASwgCAhpS31s7jnOCq9GeinfiefmhcCYdgm2zsxIweYGDdu/GTPTzPYGJySiPJJ
         wLAddFcod9W6bD11z5zaRifOizewzPfryVLcTaBZF29Z74en5PQlV3unaYcI4aimF8+t
         1Q7YsRKLHk/xcn9iC0Jnp5C7Qlw8O7Q9dFUyjt5CnWGFhbDD6PO/XhS131mskEwVAnCk
         KONe6mnTI7J9gfJCDSRXqJD0dUKOdeb80Wlag1jNezJtmOjV4icEltSxec4pEtZjevyb
         j7D+77FJ1aJojTQMts0tc5LPSWlvGxdPBwi5FA3funyAhbN5nhsLADP9ZTYiUfEwfGqc
         vfyw==
X-Gm-Message-State: AC+VfDzsTeqv15VUJZDV9EviawgcWCV0fOAyJXmV0iLIRyMUezapK4Um
	7o/xSLYKkJtNigL7mkYilv8HnAWKq1QU72oloOmlvyG6tY8ruIAJHt0E37D59m6Fqq5s46VmNkK
	/d1Mpz6huojT9eOpv6aEjq2lUHvak
X-Received: by 2002:a05:6402:1248:b0:519:6f47:d1c9 with SMTP id l8-20020a056402124800b005196f47d1c9mr11123407edw.30.1687362987007;
        Wed, 21 Jun 2023 08:56:27 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4aY7V/cc+CHEvNLsi+uzHzVpEhpZi6Nd19eUR6Hfxy+mRlHsjUgfAotORTYvSdjooRZswqCg==
X-Received: by 2002:a05:6402:1248:b0:519:6f47:d1c9 with SMTP id l8-20020a056402124800b005196f47d1c9mr11123387edw.30.1687362986706;
        Wed, 21 Jun 2023 08:56:26 -0700 (PDT)
Date: Wed, 21 Jun 2023 11:56:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"david.edmondson@oracle.com" <david.edmondson@oracle.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"sburla@marvell.com" <sburla@marvell.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	Yishai Hadas <yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
	Shahaf Shuler <shahafs@nvidia.com>
Message-ID: <20230621115131-mutt-send-email-mst@kernel.org>
References: <20230619122836-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481758B8EE080750D6377C0DC5FA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230619131115-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481D1836A5B9A7B345A20A8DC5FA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230619133322-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481E624E00FC403C9ECFA03DC5FA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230619134649-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54811536BD824EAAFE8A56D5DC5FA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <PH0PR12MB54815F1345502771D9FE24CEDC5CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <PH0PR12MB54812103E5CB5CF860B9B50CDC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54812103E5CB5CF860B9B50CDC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v6 4/4] transport-pci: Introduce group legacy group
 member config region access

On Wed, Jun 21, 2023 at 03:50:00PM +0000, Parav Pandit wrote:
> 
> 
> > From: Parav Pandit
> > Sent: Tuesday, June 20, 2023 10:12 AM
> > 
> > Michael,
> > 
> > > From: Parav Pandit <parav@nvidia.com>
> > > Sent: Monday, June 19, 2023 2:07 PM
> > > We don't need to do it now.
> > >
> > > > Current VF capability is kind of ok I guess ...
> > > >
> > > Already proposed one?
> > >
> > > > If you want admin command to query then it would need to map in PF
> > > memory.
> > > No need.
> > > It is similar to rest of the configuration access commands.
> > >
> > > > I understand two concerns with this:
> > > > - you worry that this forces ordering requirements - it's true and I
> > > >   don't know of a good fix. So if possible use VF BAR by preference?
> > > > - you worry about wasting physical memory space
> > > >   this we can fix by sticking VF# in the kick.
> > > >
> > > > As an alternative, if we can make the new command able to
> > > > communicate offset in PCI BAR or in VF BAR or both then I think
> > > > that's also an acceptable
> > >
> > > A new command proposed was for VF BAR that member driver can ask to
> > > its group owner driver (like rest of the config commands).
> > >
> > 
> > Are you ok with the admin command to query the notification address of the
> > member device bar?
> > 
> > I presented both the proposals.
> > We need to conclude this now without keep flipping between two from version
> > to version.
> > 
> > a. v3 with admin command
> > pros:
> > 1. self-contained via AQ for rest of the control path operations.
> > 2. Can work with future siov device who may want to support legacy 3. Doesn't
> > bake things in low level pci capabilities which is hard to get rid of 4. Able to add
> > new command or new response if some device wants to support this on PF
> > (very unlikely)
> > 
> Given that this has more pros and no objection to it, 
> I will revise v7 today with query admin command like v3.

Not like v3 please. If you want to re-open this:


First I think we need multiple offsets just like notification
capaiblity, sorted by priority. Second I think we need ability to report
offset within owner not member.

So please add ability to report multiple offsets, and add e.g.
a flags field, with bits for owner, member.


> > b. and v6 with capability extension.
> > Cons:
> > 1. Does not have above advantages
> > 
> > Pros:
> > 1. Uses existing PCI capability for the extension
> > 
> > 
> > > A future command can tell for the PF BAR if needed and some device
> > > wants to do such extra implementation.
> > >
> > > > compromize:
> > > > drivers that have trouble mapping VF BAR after querying PF can just
> > > > map PF BAR. WDYT?
> > >
> > > PF BAR for notification can be done later when there is some device
> > > who really have the limitation and wants to do that.
> > > We don't see that additional need as driver notifications are present
> > > on the VF already as listed in the alternative.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

