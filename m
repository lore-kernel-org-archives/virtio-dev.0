Return-Path: <virtio-dev-return-13074-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6DB6EB64DC
	for <virtio-dev@archiver.kernel.org>; Mon, 26 Jun 2023 07:13:15 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 2E1F714E6B2
	for <virtio-dev@archiver.kernel.org>; Mon, 26 Jun 2023 07:13:15 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 20FF8986410
	for <virtio-dev@archiver.kernel.org>; Mon, 26 Jun 2023 07:13:15 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 153D6986364; Mon, 26 Jun 2023 07:13:15 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 015A2986382
	for <virtio-dev@lists.oasis-open.org>; Mon, 26 Jun 2023 07:13:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: husX3I-lN-uTPJ0gFQocpA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687763590; x=1690355590;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=supaTbIYuFWOKxJxTsZ9ujp0cLclvYrgtF5tN2EGnd4=;
        b=IkBq9XJoyFAhfJk/O1NjJyyeCWihH3+bJEiKZigvkXIb1vxjA8gbVBasLmhQEw2ijf
         PYUQsJxVCk4viPrs9XAymPcGjxY5oDt8wb0eAqnIdhvNuEenUygfIMYz13KE4x/RUBP6
         UyHtzkW1NQbDa6TzTcZwTj1fe6dwfo3V+73UFv/6Kwk033U741CKwwVMyNkzh4+vY/VA
         1/+pbBYVa7Ah2+Xs9R4y5+JQ5xS/a6avfxOTCQTnjlooh+JjotyQDt7tZut3sjFkyMQB
         XDLqDYpYMq3MHMC3dpFFjP3HWy4GM0u/JID2XfJSjfCJ31YblnbJluyUJufTTqeSkpjF
         Wniw==
X-Gm-Message-State: AC+VfDzdXJPhi5zx6PDnOiP3hu7n3uSqZT1Zhg6AyE/Pk5Qf5pMeUgIs
	DM+OTxrg8cgZ242jkSFThEYxJ3Sz38KZliGgHMK5mfeZurfvV32xB0m5wrJQxPm5hQ/q1Epou7K
	0zXF1tSbOsAJ0dc2LRY8he2+rv2Pe
X-Received: by 2002:a5d:4fc9:0:b0:30f:bcfd:ff9e with SMTP id h9-20020a5d4fc9000000b0030fbcfdff9emr21250755wrw.12.1687763590109;
        Mon, 26 Jun 2023 00:13:10 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4BCrtTblCJKsx7kBFTM8eqnE1MHTuUDCZnKnVIvGmM2WuC58Gc6zyusRQs4ZLCEA87HzudyA==
X-Received: by 2002:a5d:4fc9:0:b0:30f:bcfd:ff9e with SMTP id h9-20020a5d4fc9000000b0030fbcfdff9emr21250739wrw.12.1687763589793;
        Mon, 26 Jun 2023 00:13:09 -0700 (PDT)
Date: Mon, 26 Jun 2023 03:13:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"david.edmondson@oracle.com" <david.edmondson@oracle.com>,
	"sburla@marvell.com" <sburla@marvell.com>,
	Yishai Hadas <yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Message-ID: <20230626023539-mutt-send-email-mst@kernel.org>
References: <20230605174755-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548180E16376862A3C0DFF1DDC4DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230606073544-mutt-send-email-mst@kernel.org>
 <CACGkMEv1so_KGwJZG3GnAf=JNky7+BMNK7N4NTtucDS+WyW5VA@mail.gmail.com>
 <PH0PR12MB5481D80A48F3BD82D86B3DB0DC53A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEsVrqCGJJ2Q5OGbgPdtEJHTpvVt6nEKP_MzkSH_-cOa6w@mail.gmail.com>
 <PH0PR12MB54810313CA6DD1995F52745DDC50A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEsy=pG=LT0hOT-PO3HTkk3NOAu6qA_GaZpKwqq8B996cA@mail.gmail.com>
 <20230609030109-mutt-send-email-mst@kernel.org>
 <CACGkMEseaZAgPdtf9AvwxLarkYXRMC0zCJqnjWQFJ90t0pSZzA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEseaZAgPdtf9AvwxLarkYXRMC0zCJqnjWQFJ90t0pSZzA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: Re: [virtio-dev] Re: [PATCH v3 0/3] transport-pci: Introduce legacy
 registers access using AQ

On Mon, Jun 26, 2023 at 11:59:42AM +0800, Jason Wang wrote:
> > - when some weird legacy
> >   support requirement surfaces, it will be up to the vendor
> >   to fix. HW vendors are also more agressive in deprecating
> >   old hardware - they will just stop shipping new
> >   hardware when there are no new customers and we can
> >   stop adding new hacks.
> 
> But the hacks would be there forever if there's users.

If they are in hardware, they won't - only as long as
hardware exists.

> >
> > - test out admin command interface. This use-case is smaller
> >   than full transport vq but similar enough that
> >   we will learn valuable lessons from it.
> 
> Another issue is that the interface is designed to be PCI specific (at
> least from its name) which may result in a strange mediation for MMIO
> legacy guests.


I doubt there's a way to make guests utilizing legacy MMIO work with
offloads - it's not widely used on x86 and other platforms have weaker
ordering.

> >   For example, it already helped us find and correct
> >   a design mistake where admin commands had 8 byte aligned length.
> >   As another example, I am working on ability to report events to admin command
> >   infrastructure which is currently missing.
> 
> If we want a MMIO interface for admin commands, it requires more
> extensions for such kind of notification.

Yes I don't know how that will work. Not sure what the
implication is though.


> >   With that in place we will be able to add INT#x emulation for very old
> >   guests.
> >
> >
> >
> > In short, this interface as you correctly point out is not the normal
> > way we build interfaces since it is not modular and less flexible than
> > individual feature bits.  However, for the legacy interface this might
> > be a good thing.
> 
> Ok, I think I would not object to this proposal, but we should not
> exclude the possibility of having things like LEGACY_HEADER in the
> future.
> 
> Thanks

Yes I always disliked that change. Feel free to propose it, I'll
support.

> >
> >
> > > > I would want to raise for vote in coming days to be part of 1.3 in few days as we have more than 3 weeks to sort out non-ABI language part.
> >


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

