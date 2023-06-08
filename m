Return-Path: <virtio-dev-return-12892-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88E9BC7EE45
	for <virtio-dev@archiver.kernel.org>; Thu,  8 Jun 2023 15:05:31 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id C299E2AC82
	for <virtio-dev@archiver.kernel.org>; Thu,  8 Jun 2023 15:05:29 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 37DD998666B
	for <virtio-dev@archiver.kernel.org>; Thu,  8 Jun 2023 15:05:29 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 8C37A986655; Thu,  8 Jun 2023 15:05:28 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E43E298666D
	for <virtio-dev@lists.oasis-open.org>; Thu,  8 Jun 2023 15:04:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: l8kV2krgPmG12A2Y4zytnA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686236637; x=1688828637;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tBZ8zJ+mOpk54ZEDFfA4+9UVvzU3kDJsb4RhrOaV6rI=;
        b=hCIJRbWfeqYjeBL7oJ/+EcjUTNv6Lzm12b6VooUgVh7ZYSwK3/Npf8XbCZa+JYDGq0
         WK7MU20jflkHa5KELah65xGqC2HhcBmAsIVEPT2Ofh+83a2R83mQyE3MB9QAKRUHoFEG
         Ftdcn7DQPnkHzIq9Sz1ElaD1cZbv1R93u19kMXWys+tZeTpDUVNvmGyp4d2QZykZ4uzc
         Hlj+BuEqFZHjTl+XYc+RkiEx8nYcHobZ6RnpIgWKomD/ayO89/d25B194/pvg7p0gF6C
         S6SiV2UrrwzJSRMEZp7v3uRFidSK9wdYCKBoQAuwFvQFkivr4chSZaApzirDEbAYukCY
         +4fA==
X-Gm-Message-State: AC+VfDxn+W64a2Uf75ncTyf0B+AOMWHitaYJlVH2r2gfU5J+HFTBNZl0
	Tc8Ty6S2+khxiS1iWrYsxKqNYDtmawvI0Xtpi78lIWiHGsci4oCjYbYjQTNxhhk/yc8babptmFc
	UAe93TXMUlN4PBfDQBfF3tMq/lGKD
X-Received: by 2002:a5d:4564:0:b0:30a:efcc:f89a with SMTP id a4-20020a5d4564000000b0030aefccf89amr2188529wrc.2.1686236637230;
        Thu, 08 Jun 2023 08:03:57 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4F0ZTzRapRyKx9xbLmUWLECLOadyhMfXYnFeYG0edhqHzhyqhybUXywIviQ5OurTny3NVJFg==
X-Received: by 2002:a5d:4564:0:b0:30a:efcc:f89a with SMTP id a4-20020a5d4564000000b0030aefccf89amr2188511wrc.2.1686236636910;
        Thu, 08 Jun 2023 08:03:56 -0700 (PDT)
Date: Thu, 8 Jun 2023 11:03:51 -0400
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
Message-ID: <20230608105640-mutt-send-email-mst@kernel.org>
References: <PH0PR12MB5481CEB3A34AAB49A282F2A8DC4DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230605174755-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548180E16376862A3C0DFF1DDC4DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230606073544-mutt-send-email-mst@kernel.org>
 <CACGkMEv1so_KGwJZG3GnAf=JNky7+BMNK7N4NTtucDS+WyW5VA@mail.gmail.com>
 <PH0PR12MB5481D80A48F3BD82D86B3DB0DC53A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEsVrqCGJJ2Q5OGbgPdtEJHTpvVt6nEKP_MzkSH_-cOa6w@mail.gmail.com>
 <PH0PR12MB54810313CA6DD1995F52745DDC50A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230608104215-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54810E0A5A5E56B6420EB05CDC50A@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54810E0A5A5E56B6420EB05CDC50A@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: Re: [virtio-dev] Re: [PATCH v3 0/3] transport-pci: Introduce legacy
 registers access using AQ

On Thu, Jun 08, 2023 at 02:53:28PM +0000, Parav Pandit wrote:
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Thursday, June 8, 2023 10:44 AM
> > > Since this ABI reflects what we agree on, I would want to raise for
> > > vote in coming days to be part of 1.3 in few days as we have more than 3
> > weeks to sort out non-ABI language part.
> > 
> > I think there's a bunch of work to tighten wording in v4, don't believe it is ready
> > for vote yet. 
> 3rd patch has the conformance section.
> Rest of the legacy interface semantics are just same as today.
> We are not fixing the legacy interface itself, so not sure what to tighten specifically.

I'll do a proper review after the forum. Generally
lots of small things. Went looking just to give you a couple of
examples:
	  too many mentions of VFs and PFs.
	  text should talk about owner and member. Minimise
	  mention of VFs to make it easier to extend to
	  different group types.

another example:
	+The PCI VF device SHOULD NOT expose PCI BAR 0 when it prefers to support

VFs don't expose BARs at all. PF exposes VF BARs in SRIOV capability.



> > Unfortunately I need to get ready for travel and then travel for the
> > kvm forum, during this time I will try but I can't promise when I will be able to
> > go over it in detail and send comments. Back June 20.
> 
> Ok. that will be really helpful. I will revise v5 as soon as you and others have comments.
> 
> Total line of spec line are < 200 lines including the 1st clean patch.
> And changelog anyway precisely captures what changed so should not be too many reviews to me.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

