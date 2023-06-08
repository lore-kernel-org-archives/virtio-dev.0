Return-Path: <virtio-dev-return-12902-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1135DC7EE25
	for <virtio-dev@archiver.kernel.org>; Thu,  8 Jun 2023 19:03:51 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 72D2A94EE6
	for <virtio-dev@archiver.kernel.org>; Thu,  8 Jun 2023 19:03:50 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 56D2598668D
	for <virtio-dev@archiver.kernel.org>; Thu,  8 Jun 2023 19:03:50 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 43696986681; Thu,  8 Jun 2023 19:03:50 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 30FDD986682
	for <virtio-dev@lists.oasis-open.org>; Thu,  8 Jun 2023 19:03:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: D1VBotOAPNiMupt0t6IJ5g-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686251027; x=1688843027;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kibnLeO+kH3IjyX61ByluUg931Bb7KLObIW9ekntVr4=;
        b=O+LD6l/QYAK4YIjyStDMqJ4S+3RzCYlEbyd4cYH9hwt0+QFWUuADXnXNGwBH4j17zZ
         b6ZtV3Qy+pUgkoQmAu4I6fHaIvD5ZAFcsTMpQqTl93YhxN4JluON+SIoJr/paFHYH7Wc
         +CJOVmuBFCJDs+PynTeDyrLRE3SlMigG9kQrTLhSkezty/zra/IR5bO+DwjftfTFzDbC
         S+UTKT3liEl9aICI0giNq+QBhsFVTl1H4kmzR5GO0akfOkhfPAYiSzGSc5nYPo/lML4W
         Hec9KoeGWtX6zwBboOCBlwF6r5UDC2OVcxNySxU3NvYIW5xtW8IlEiiFnXjfMB8aCR3e
         T0Lg==
X-Gm-Message-State: AC+VfDxSiaLXLoN/HWs9H0kmM742CHuiacOyPok5g7ugFa8HWWZT22av
	VeYP+kiWpjyLiSOY2+yrfR0hcMiXc8k59R0xkfgANOOYLXFelEUlucxPLKXyX/aaXoIHCyorbnH
	E05HMRFCeQDTvhSou8vVAI8k9IaDu
X-Received: by 2002:a5d:40cd:0:b0:30a:eac4:26a0 with SMTP id b13-20020a5d40cd000000b0030aeac426a0mr6826387wrq.18.1686251026905;
        Thu, 08 Jun 2023 12:03:46 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6392xYCVR3BVLSrD+kycuZjgGbWg95+uhCoL7uqUGqx6ADeT2lfmc7NOVBm1ez0FJphaGjig==
X-Received: by 2002:a5d:40cd:0:b0:30a:eac4:26a0 with SMTP id b13-20020a5d40cd000000b0030aeac426a0mr6826381wrq.18.1686251026586;
        Thu, 08 Jun 2023 12:03:46 -0700 (PDT)
Date: Thu, 8 Jun 2023 15:03:42 -0400
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
Message-ID: <20230608150118-mutt-send-email-mst@kernel.org>
References: <CACGkMEv1so_KGwJZG3GnAf=JNky7+BMNK7N4NTtucDS+WyW5VA@mail.gmail.com>
 <PH0PR12MB5481D80A48F3BD82D86B3DB0DC53A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEsVrqCGJJ2Q5OGbgPdtEJHTpvVt6nEKP_MzkSH_-cOa6w@mail.gmail.com>
 <PH0PR12MB54810313CA6DD1995F52745DDC50A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230608104215-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54810E0A5A5E56B6420EB05CDC50A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230608105640-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481E16441FE87FFF87A8650DC50A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230608142527-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548124D3E867D25B5DB65610DC50A@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB548124D3E867D25B5DB65610DC50A@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: Re: [virtio-dev] Re: [PATCH v3 0/3] transport-pci: Introduce legacy
 registers access using AQ

On Thu, Jun 08, 2023 at 07:00:32PM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Thursday, June 8, 2023 2:31 PM
> 
> > > > I'll do a proper review after the forum. Generally lots of small
> > > > things. Went looking just to give you a couple of
> > > > examples:
> > > > 	  too many mentions of VFs and PFs.
> > > > 	  text should talk about owner and member. Minimise
> > > > 	  mention of VFs to make it easier to extend to
> > > > 	  different group types.
> > > >
> > > True but most additions are in PCI transport chapter.
> > > But will change to member and owner.
> > 
> > Another thing that bothers me is that it references admin commands that are
> > defined later in the spec. I don't like it that we are making the reader jump back
> > and forth ...
> > Maybe it's better to put this in the admin command chapter.
> > 
> I considered that before.
> In its current form, there is very less back-n-forth jump.
> This is because admin chapter mostly enumerates the opcode.
> 
> And PCI legacy chapter talks about rest of the theory and command details.
> 
> When/if we have more transports for this, probably a generic place will be suitable.
> 
> Moving now to admin will surely have more back-n-forth as it needs to talk about PCI part and that PCI part will reside in PCI section.

well the point is that it's *back" not *forth*.
IOW add the command description in admin chapter,
make it point to legacy description in pci chapter which reader has
already read.

> > > > another example:
> > > > 	+The PCI VF device SHOULD NOT expose PCI BAR 0 when it prefers to
> > > > support
> > > >
> > > > VFs don't expose BARs at all. PF exposes VF BARs in SRIOV capability.
> > > >
> > > Yes, it is exposed by PF, the wording of "PCI VF device exposing" is not right.
> > > I will reword it.
> > 
> > So here's an example wording, I don't insist on it exactly but the point is to show
> > how we should use spec terminology whereever
> > possible:
> > 
> > If an owner of an SRIOV group supports all of
> > VIRTIO_ADMIN_CMD_LCC_REG_WRITE,
> > VIRTIO_ADMIN_CMD_LCC_REG_READ .... then it SHOULD NOT expose VF BAR0
> > (of non 0 size) as part of its SRIOV capability; this is to facilitate emulating IO
> > BAR0 for the legacy interface in software.
> > 
> Yes good one. Will use.

right and my point is try to word all of it like this.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

