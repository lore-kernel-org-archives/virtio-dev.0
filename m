Return-Path: <virtio-dev-return-12895-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4403DC7EE23
	for <virtio-dev@archiver.kernel.org>; Thu,  8 Jun 2023 18:03:11 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 54F502AD4E
	for <virtio-dev@archiver.kernel.org>; Thu,  8 Jun 2023 18:03:10 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 30E96986687
	for <virtio-dev@archiver.kernel.org>; Thu,  8 Jun 2023 18:03:10 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 191D398667A; Thu,  8 Jun 2023 18:03:10 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 05E9A98667B
	for <virtio-dev@lists.oasis-open.org>; Thu,  8 Jun 2023 18:03:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: yEN5xlyVMiWtqKjqzAZkGg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686247386; x=1688839386;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IkzOGhZ5dCW376oaGomicjqWXldPf++3zoj0rPxwfyY=;
        b=C0Vcd9VENwImUJ480sl/7i5Hyf8+Z2ifKwpuZ9CrTnpFw6cdpGQzqNU19rC/OaoiS1
         KJtA7Ez4oBpb3EYgv+hsDBC2KQXIwQA0dED7WdkXHSIu0kaVz7baA8Ge7LTw2tjmBV4M
         JPiWLsaVR5JXnwW+qe775mCPZjHvZsC9fXODPakJkhphcoBgHNq6Ldm3cSqy3YLjsOu7
         BGqszpnSrxpEcpLSbmfSc6fyMfD+Cp+yPPLv8O9cJU97ufV44pu6rWgbC7Jr72zDLqjo
         W/ylb+ed5G7vg4U9zJF/hTcUldIKbA5wqrHEw0Ht6QP2Z/5YoFv/3ESDIB9THYnPEofE
         wXig==
X-Gm-Message-State: AC+VfDyio3nw0F9R9bzlncxUpBk1KdgtAWekZxXO7uBV6BJ9uHW71AJT
	zQzgcF41Mlp0DgywDfGUw1jybLvdEI7JstaSiuI1/IQd35qwSrTgpyOsEwlnSAFju6oVNGHErRn
	6rnEdWQr/UN6aficMGbPB9q9xHhOR
X-Received: by 2002:adf:ce8d:0:b0:307:9194:9a94 with SMTP id r13-20020adfce8d000000b0030791949a94mr7774981wrn.17.1686247385898;
        Thu, 08 Jun 2023 11:03:05 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ70mcRsXyaQWfXTi8WoOINLAbIKun+S4h4PZQ+LJRJrLZtf7D+ixkXZpUk2fsucQDncqY1rZQ==
X-Received: by 2002:adf:ce8d:0:b0:307:9194:9a94 with SMTP id r13-20020adfce8d000000b0030791949a94mr7774966wrn.17.1686247385556;
        Thu, 08 Jun 2023 11:03:05 -0700 (PDT)
Date: Thu, 8 Jun 2023 14:03:01 -0400
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
Message-ID: <20230608140013-mutt-send-email-mst@kernel.org>
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
> 
> > another example:
> > 	+The PCI VF device SHOULD NOT expose PCI BAR 0 when it prefers to
> > support
> > 
> > VFs don't expose BARs at all. PF exposes VF BARs in SRIOV capability.
> > 
> Yes, it is exposed by PF, the wording of "PCI VF device exposing" is not right.
> I will reword it.

Note that this will then apply to all VFs of this PF, even those without
legacy support. Still not sure why it's SHOULD not a MUST.
So that driver actually checks, but it's ok to fail if the rule
is not followed maybe? In that case add a driver normative statement
too.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

