Return-Path: <virtio-dev-return-12897-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 441B3C7EE25
	for <virtio-dev@archiver.kernel.org>; Thu,  8 Jun 2023 18:31:37 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 5F0F32AC66
	for <virtio-dev@archiver.kernel.org>; Thu,  8 Jun 2023 18:31:36 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 57E17986697
	for <virtio-dev@archiver.kernel.org>; Thu,  8 Jun 2023 18:31:36 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 4A4AF986681; Thu,  8 Jun 2023 18:31:36 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3750D986682
	for <virtio-dev@lists.oasis-open.org>; Thu,  8 Jun 2023 18:31:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: rCUCQoW6MOmyM8qD2wXfew-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686249089; x=1688841089;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IAwzd1bs0MgzW+l1wqZyxmLebAWaLKVoHp2YqZ3Tn1o=;
        b=ea7pGehtYwH6LJS8sGUnYXK3meRdaNmSkSni2txbGirwzppCj/YqiNJY65G9upLvdl
         cOyjs/1Zscd3D3Fhjzrhx1snMZ+BICA+iPxE2dX7P3fHucjCDM//cPRhGqPG1mCEE6go
         sw++7GnZ/gRWNArUTCnohwLqcWXgqKimUbAdVPwx9nJH/fVhB6KucKrxesuM9s1fxVBl
         hIIqR2cFv0v8jwYUHKFBSjMY4PgLkuz3DlfC0Zhak4T7L2fKI4DLYL9tNUJUan2XYdmw
         EkdfqTpR0a13jZtqEOmGw6kcDNNIBqcae2s8VE35V+bk3CSqwrfcvJCwYf4igk5A/VK0
         34BQ==
X-Gm-Message-State: AC+VfDxsN8Gx/wivpA4e56jmFERGO8Ry5sax0UHIWvPK/T5re2+6R3jp
	Aqhjqd9mdjRhEgYGtt7buACzOKedhO30rJCmaLFSFrIO0kmMeiHFzikczrYKjq3MvVQKZAFTqEI
	gzvSh4YKROucu+tE3uDRiSP4mdZBU
X-Received: by 2002:adf:ee8e:0:b0:30e:3da5:46e5 with SMTP id b14-20020adfee8e000000b0030e3da546e5mr8430072wro.59.1686249089481;
        Thu, 08 Jun 2023 11:31:29 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6U3+2t9N1chma/4saXgf6hpn3NFMi+SQxlyU8ExgNmAQfvzaV9L/vkWo5gbZ66fx3n4HHhrQ==
X-Received: by 2002:adf:ee8e:0:b0:30e:3da5:46e5 with SMTP id b14-20020adfee8e000000b0030e3da546e5mr8430050wro.59.1686249089159;
        Thu, 08 Jun 2023 11:31:29 -0700 (PDT)
Date: Thu, 8 Jun 2023 14:31:23 -0400
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
Message-ID: <20230608142527-mutt-send-email-mst@kernel.org>
References: <PH0PR12MB548180E16376862A3C0DFF1DDC4DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230606073544-mutt-send-email-mst@kernel.org>
 <CACGkMEv1so_KGwJZG3GnAf=JNky7+BMNK7N4NTtucDS+WyW5VA@mail.gmail.com>
 <PH0PR12MB5481D80A48F3BD82D86B3DB0DC53A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEsVrqCGJJ2Q5OGbgPdtEJHTpvVt6nEKP_MzkSH_-cOa6w@mail.gmail.com>
 <PH0PR12MB54810313CA6DD1995F52745DDC50A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230608104215-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54810E0A5A5E56B6420EB05CDC50A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230608105640-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481E16441FE87FFF87A8650DC50A@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481E16441FE87FFF87A8650DC50A@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: Re: [virtio-dev] Re: [PATCH v3 0/3] transport-pci: Introduce legacy
 registers access using AQ

On Thu, Jun 08, 2023 at 03:16:02PM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Thursday, June 8, 2023 11:04 AM
> > 
> > On Thu, Jun 08, 2023 at 02:53:28PM +0000, Parav Pandit wrote:
> > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > Sent: Thursday, June 8, 2023 10:44 AM
> > > > > Since this ABI reflects what we agree on, I would want to raise
> > > > > for vote in coming days to be part of 1.3 in few days as we have
> > > > > more than 3
> > > > weeks to sort out non-ABI language part.
> > > >
> > > > I think there's a bunch of work to tighten wording in v4, don't
> > > > believe it is ready for vote yet.
> > > 3rd patch has the conformance section.
> > > Rest of the legacy interface semantics are just same as today.
> > > We are not fixing the legacy interface itself, so not sure what to tighten
> > specifically.
> > 
> > I'll do a proper review after the forum. Generally lots of small things. Went
> > looking just to give you a couple of
> > examples:
> > 	  too many mentions of VFs and PFs.
> > 	  text should talk about owner and member. Minimise
> > 	  mention of VFs to make it easier to extend to
> > 	  different group types.
> > 
> True but most additions are in PCI transport chapter.
> But will change to member and owner.

Another thing that bothers me is that it references admin commands
that are defined later in the spec. I don't like it that we
are making the reader jump back and forth ...
Maybe it's better to put this in the admin command chapter.

> > another example:
> > 	+The PCI VF device SHOULD NOT expose PCI BAR 0 when it prefers to
> > support
> > 
> > VFs don't expose BARs at all. PF exposes VF BARs in SRIOV capability.
> > 
> Yes, it is exposed by PF, the wording of "PCI VF device exposing" is not right.
> I will reword it.

So here's an example wording, I don't insist on it exactly but
the point is to show how we should use spec terminology whereever
possible:

If an owner of an SRIOV group supports all of VIRTIO_ADMIN_CMD_LCC_REG_WRITE,
VIRTIO_ADMIN_CMD_LCC_REG_READ .... then it SHOULD NOT
expose VF BAR0 (of non 0 size) as part of its SRIOV capability;
this is to facilitate emulating IO BAR0 for the legacy interface in software.



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

