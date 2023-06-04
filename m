Return-Path: <virtio-dev-return-12855-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D5FCC7EE29
	for <virtio-dev@archiver.kernel.org>; Sun,  4 Jun 2023 22:10:20 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id C938544345
	for <virtio-dev@archiver.kernel.org>; Sun,  4 Jun 2023 22:10:19 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AF9CD98633E
	for <virtio-dev@archiver.kernel.org>; Sun,  4 Jun 2023 22:10:19 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 98C3B9843C4; Sun,  4 Jun 2023 22:10:19 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 86758986332
	for <virtio-dev@lists.oasis-open.org>; Sun,  4 Jun 2023 22:10:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: OOCWWITSPFqF2gPew3pSBA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685916614; x=1688508614;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7QwVfOgOYd0jGucXRcXGUSnyxguvvKHe3OZoUaHEL+U=;
        b=Un46tCg2+fOdkQ/XBx2mCEAWFmPc2W6CCeSy9QPiwM+n3Wx1BTtUTluKypFPola8kx
         yAaVa7tmMD5Tu7Dm8NxulvNpKSDlQ+0aBiHxdci/zouURhKJJOUGH9/P4NFQH2//nLVV
         Vt4TvCWdV8CG0iEU8Csd/K2qwd6pgZd+zkzK0hSrO2336GfORRtUlWj6k+Pe4o1a5xaA
         rsBQJhJpMmI+wi4Lz7WIWttVWRBSEsj6VAAqjFw9GMPx1/29d2+naneP2K9S5s6yY/YN
         d9d95p7xhtCYy+FF3BvUPEE4KhGr71MEa7X5R10hQrqtPz+k7EMt6QrQRHXWW6Xr1dUr
         7tFQ==
X-Gm-Message-State: AC+VfDzI3WpLUxgwomrobDf2Odj9w+xaM5SBWCFXMukRYBR1+CO1NV6c
	+pEkSCExTwi3u3qGykdtFAnAE0i6RYPcTDyegkr5lykmILFFt52UoXu3I2tISwFdQAFPMjC3Ala
	zCppSzI8bU1oUGMrhUbkK+6JSFbud
X-Received: by 2002:a7b:ce0d:0:b0:3f7:cb42:fa28 with SMTP id m13-20020a7bce0d000000b003f7cb42fa28mr619455wmc.28.1685916613855;
        Sun, 04 Jun 2023 15:10:13 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5IwhJ5xUf8UrSTjsHWz6qQsLEw12pPpjJMQhWx2hyBCJ5mwNkWuTKHtYBmxBrJiECbEJHWmA==
X-Received: by 2002:a7b:ce0d:0:b0:3f7:cb42:fa28 with SMTP id m13-20020a7bce0d000000b003f7cb42fa28mr619447wmc.28.1685916613459;
        Sun, 04 Jun 2023 15:10:13 -0700 (PDT)
Date: Sun, 4 Jun 2023 18:10:08 -0400
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
Message-ID: <20230604174856-mutt-send-email-mst@kernel.org>
References: <20230602203604.627661-1-parav@nvidia.com>
 <20230602203604.627661-3-parav@nvidia.com>
 <20230604091651-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481195B63FD61C35447FFDFDC4CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230604095615-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481D7C7EEAC610BBBDEB69ADC4CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230604103309-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54813E50A9821F960C43C5BFDC4CA@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54813E50A9821F960C43C5BFDC4CA@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v3 2/3] transport-pci: Introduce legacy registers access
 commands

On Sun, Jun 04, 2023 at 03:01:52PM +0000, Parav Pandit wrote:
> 
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Sunday, June 4, 2023 10:42 AM
> 
> > > > BTW all these may/must/should need to go into conformance section.
> > > >
> > > Conformance section for the AQ itself is missing. And I am aware to fix it post
> > your v13 series.
> > 
> > Hmm missing where? It was supposed to be added here:
> >
> Conformance chapter doesn't have any links to aq requirements.

Good point, but the section itself is not missing, just a couple of links
in the conformance chapter. Sounds like a trivial omission we
can correct as an editorial fix.

>  
> > commit bf1d6b0d24ae899d08c7cf24ed480cf5881c49ef
> > Author: Michael S. Tsirkin <mst@redhat.com>
> > Date:   Sun Nov 20 19:43:45 2022 -0500
> > 
> >     admin: conformance clauses
> > 
> > what did I miss?
> > 
> > 
> > > > Generally the way we structure the spec is an explanation of the
> > > > theory of operation (mostly missing here)
> > > >
> > > It is not any different from v2.
> > > Theory of operation is not going to describe the whole driver design.
> > > It is not likely the scope like any other section.
> > > Section "Legacy Interfaces: SR-IOV VFs Registers Access" has theory of
> > operation described and also in commit log.
> > >
> > > This is like recent AQ patches and notification coalescing and more.
> > >
> > > So if can pin point what exactly you want to see in theory of operation, it will
> > be helpful.
> > > Because for one person, 10 lines of theory is enough like how we have most
> > of the spec, another wants 100 lines with pseudo code in appendix.
> > 
> > yes but I think this assumes a bit much. you start by saying there's no IO BAR.
> > Okay, it's not even mandatory to give motivation, but can't hurt. The next step is
> > you describe a bunch of commands. Presumably the reader will draw the
> > conclusion that they replace an io bar?
> > But it's implicit, and that is not good.
> > 
> > So, I imagine we have a driver that translates legacy accesses to AQ commands,
> > yes? 
> Yes.
> 
> > And it also somehow uses the extra command to get an address and then
> > translates notifications to writes at that address? This kind of thing is what I
> > called a theory of operation.
> >
>  
> > A couple of paragraphs.
> >
> Yes, but I don't see such details for the AQ, notification coalescing.

I certainly tried for AQ.

For notification coalescing there's a whole paragraph:
\subparagraph{Operation}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Notifications Coalescing / Operation}



> These commands are not special.
> Commands described "what" they do. "When and how" is not described in the spec.

If the "what" is "return offset for notifications" but there's no
description on what these notifications are then the "what" is
at best incomplete.

> It is left to the driver to compose such things.
> How Net device should use "queue reset" is not explained in theory of operation.
> What is described is mechanics of queue reset steps...
> 
> Those details were put in the commit log, and not in the spec.
> If you want to add theory of operation like nvme spec, we need to have dedicated section.
> I don't see a reason, why this should be the first patch set to do so in v4.
> I am more than happy to add, but it can be done in generic way as follow up.

I don't think so personally.
As bigger issues get fixed, we start polishing up smaller ones.
It is reasonable to ask that people try to decide on a high level
design up front to avoid sending you back to the drawing board -
though that's unavoidable sometimes, a straw can break camel's back,
but that's not the case here.

Nitpicking when the design itself is undergoing big changes is
unproductive for everyone - reviewers and contributors.
Now you are getting asked to clarify things is a good sign that
the design is converging. The less time we keep arguing about
protocol the faster this will happen.

And I commented on previous versions too that the notification part is
not near ready, and suggested splitting it up to a follow up patch.
This is still the case, and I still think you should get the 4 config
access commands merged first then focus on notifications.

> > 
> > 
> > > > v2 had other issues so I missed this one.
> > > >
> > > > > But ok.
> > > > >
> > > > > No. It is not related to last command.
> > > > > What does a PCI Device use BAR for?
> > > >
> > > > To reserve address space and know which addresses to claim.
> > > >
> > > > Generally if I heard "not use BAR0" I would assume that the meaning
> > > > is that VF
> > > > BAR0 in SRIOV expended capability should be 0. However, that affects
> > > > all VFs and not just this VF so I don't really know what can it mean.
> > > >
> > > A PCI PF and VF device which wants to support legacy emulation should not
> > expose BAR 0 in the struct virtio_pci_cap struct.
> > > Instead it should use other BARs.
> > >
> > > > > As described in the spec, it uses the BAR in struct virtio_pci_cap
> > > > > for exposing
> > > > various things.
> > > >
> > > > Now I'm confused.
> > > > So do you mean the \field{bar} in virtio_pci_cap or PCI BAR?
> > > >
> > > Yes.
> > > > > So it means that PCI VF should use other than PCI BAR 0 for
> > > > > various Virtio
> > > > Structure PCI Capabilities that it exposes.
> > > >
> > > > I suspect you then want to say "should not expose to driver any
> > > > structures inside it's BAR0"?
> > > Instead of bisecting at structure level, it is indicated on usage so that it doesn't
> > need to bisect on "what about MSI-X".
> > 
> > But what is the answer?
> >
> BAR 0 should not be used at all by the VF device for anything including MSI-X.
> > > > And does this include this new command you are adding or not?
> > > > It mentions bar too.  What about e.g. MSIX tables? Could there be
> > > > other capabilities referring to a BAR?
> > >
> > 
> > ?
> > 
> New command also should not report BAR 0.
> > > > How does hypervisor know whether VF followed this rule (it's a
> > > > should, not a hard rule after all)?
> > > >
> > > It is not a MUST.

Check up on the difference between SHOULD and MUST in the RFC.
If things break without this then you make it MUST. SHOULD is
a recommendation.

> > > Hypervisor software using this VF very easily know this when VF is attached to
> > the hypervisor driver by reading the capability.
> > 
> > which capability? E.g. there's a vendor specific capability we don't even know
> > what's in there. If you really want to save code in the hypervisor this "should" is
> > pretty useless.
> > 
> All the pci vendor capabilities for which all the code already exists.
> It is not related to code saving.

Isn't code saving the reason you want to prevent VFs from using BAR0?

> Even those cap check is not needed.
> Hypervisor driver needs to only check that BAR-0 is empty of not from the PCI layer. 

How do you check this? BAR0 size 0? Then say so. That affects all VFs and some of
them might not have legacy access.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

