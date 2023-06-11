Return-Path: <virtio-dev-return-12926-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E295C7EE2E
	for <virtio-dev@archiver.kernel.org>; Sun, 11 Jun 2023 00:27:39 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id AA8DE2B058
	for <virtio-dev@archiver.kernel.org>; Sun, 11 Jun 2023 00:27:38 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 87F4D98680A
	for <virtio-dev@archiver.kernel.org>; Sun, 11 Jun 2023 00:27:38 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 6A2D89843C4; Sun, 11 Jun 2023 00:27:38 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5254C9867FF
	for <virtio-dev@lists.oasis-open.org>; Sun, 11 Jun 2023 00:27:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: Hv2q9TI4PEajkfgYGTNEIg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686443254; x=1689035254;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QP2pES/IEZtLPiaQRZBemW8XwOjq3KHE582PnleRYpY=;
        b=TZGCN7PkKkX2YKnea6Q7eg5aO//YFt+U6KyOrZKdPTS1T5s9NiJUVViHFrE1tUyiWR
         y05HcxRaXlVOVbIrriYG6wQ3ttGC6N4OWh2xRD+o99W+snGd7lwuat4kNOGyiuDOuqdf
         MpStjCg9Fj9iGh/ZfO2cwois148R0tBic654Zz9Km6C+YRBtOu5FUhtoxoyYp4Lw7FrJ
         4p9kQ2x9alP5tbU3Fh3LdUaNgoL2hYuIUjhVgwnvifw6yu04XuiK6ueMUPKge2T+rAF1
         WSzDNUaAh+Q8h1nVzxsHSodnzszhDfp4ORoCYpQjhZZMUbS7gJ5BGvJ6w22NSK3rgzgA
         fwhw==
X-Gm-Message-State: AC+VfDxnTFpeEZ+2aKp/EionyEJNngKBjswO1Eo5sHwjgC2gGs9jOhcN
	F5LIb2Fi2RBuTUf8z/QcZlYKTYUaOM3w3CYiygmuEt7Zry9izz+pVgW0p58otmYdpLDWVVeOFqO
	40BPciZww/ChKt7xtuHonIJIq+jgq
X-Received: by 2002:a5d:65d1:0:b0:30e:4886:3533 with SMTP id e17-20020a5d65d1000000b0030e48863533mr1549444wrw.34.1686443254487;
        Sat, 10 Jun 2023 17:27:34 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5dgp71MotG7SGk9H1g5rvVFJYWiRP2jjMR46Pr/v37tgZam/YOZRNZPIDS1D7HBVCNDb3pjQ==
X-Received: by 2002:a5d:65d1:0:b0:30e:4886:3533 with SMTP id e17-20020a5d65d1000000b0030e48863533mr1549432wrw.34.1686443253976;
        Sat, 10 Jun 2023 17:27:33 -0700 (PDT)
Date: Sat, 10 Jun 2023 20:27:29 -0400
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
Message-ID: <20230610202143-mutt-send-email-mst@kernel.org>
References: <PH0PR12MB5481B197049376E7C4D0112EDC51A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEsPjwgx=atOC1ww+RnfJcrg7m2CmMXWQCCoreCwsWVpLg@mail.gmail.com>
 <PH0PR12MB54817C027CB2B7BB74BD35EDDC51A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEsGA4ZhOPn5OCTZEZkja2UrLpJ8DXH+d62Fp5rtdicseg@mail.gmail.com>
 <PH0PR12MB5481F1BE96B1CE71F4FBD2D8DC51A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEu+LDKUkg5ZZjcRsztrL1QGY2a6wto8r93Ddwc6L=a63w@mail.gmail.com>
 <PH0PR12MB5481175A9D915E3BF396AFFBDC51A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEsN=5DcMsZa5hHGKb9kCRUVA2CcwZ4uif-E0HKaXiJ-fA@mail.gmail.com>
 <20230609031923-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54817CE9205B222B57680AE4DC51A@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54817CE9205B222B57680AE4DC51A@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] Re: [virtio-dev] Re: [PATCH v3 0/3]
 transport-pci: Introduce legacy registers access using AQ

On Fri, Jun 09, 2023 at 05:11:53PM +0000, Parav Pandit wrote:
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Friday, June 9, 2023 3:22 AM
> > 
> > On Fri, Jun 09, 2023 at 02:27:01PM +0800, Jason Wang wrote:
> > > > I would like to keep the stateful interactions of 1.x device outside of 0.9.5.
> > >
> > > I don't think this is a real problem, but let's see the drawbacks of
> > > this proposal:
> > >
> > > 1) non-trivial changes of full new transport alike ABI
> > > 2) can't work for nesting
> > > 3) require vendor to implement legacy behaviour which can't be
> > > documented precisely
> > > 4) require admin virtqueue to work
> > >
> > > We won't have the above issues if we use modern + legacy header/mac.
> > >
> > > Thanks
> > 
> > 
> > All this is true. But it's by design. It makes the legacy thing as isolated as
> > possible. Because let's be frank we won't be able to drop legacy support in like
> > 10 years. But hardware vendors will do that quickly if they can't sell hardware.
> 
> I don't think above 4 points are true for below reasoning.
> 
> Hypervisor flow without involving guest; first sanity round to figure out things can work:
> 1. reset the device
> 2. set ACK and DRIVER bit
> 3. read features and make sure _MAC, _HDR are supported.
> 4. if not abort.
> 5. reset the device 2nd time so that guest can have right view of things.
> 
> On guest access of legacy area:
> 6. reset the device
> 7. set ACK and DRIVER bit on guest request
> 8. read features and make sure _MAC, _HDR are offered
> 8.1 Hope for the best that on two completely unrelated device reset on #1 and #6, the device offers exact same feature bits.
> And mention this in the spec 1.x for rest of the future.

> We shouldn't be adding such a limitation to the spec.
> We have seen this with mlx5 device where 5 years ago one thought this cannot happen.
> And now with modern use case now features changes across two resets for mlx5 device.

Interesting this actually violates a spec recommendation:

	If a device has successfully negotiated a set of features 
	at least once (by accepting the FEATURES_OK \field{device
	status} bit during device initialization), then it SHOULD
	NOT fail re-negotiation of the same set of features after
	a device or system reset.  Failure to do so would interfere
	with resuming from suspend and error recovery.


> Baking such limitation in current spec for past 1.x is sub-optimal.
> 
> ok, so to avoid baking such reset flow nasty things in spec, lets avoid flow of #1 to #5 in hypervisor.
> So, provision the device to support these new feature bits via AQ.
> So AQ is required for feature provisioning anyway.
> 
> So, your point #4 is required in both methods and so it scores same as this proposal.
> Hence feature bit is not of an advantage.
> 
> With _MAC now we need writable mac on 1.x config space.
> for 1.x writable mac has two requirements.
> 1. It must be atomic (not for 0.9.5, but must for 1.x like CVQ)
> 2. should be synchronous to know success/failure to know when it is effective
> 
> Both are present on the CVQ, so yet add another duplicate 1.x scheme that fulfill above requirements.
> 
> ok. So may be let's do AQ command for just mac setting.
> 
> This scores down now for two reasons.
> a. Duplicate of existing 1.x feature
> b. requires AQ.
> 
> So, from RW mac we moved from 1.x cfg space to AQ. This mediation for 1.x is not good.
> And now it's not trivial either as it is not just simple *p_mac = X.
> Hence, #1 of non-trivial starts to looks less appealing.
> 
> Your point #3 about vendor to implement legacy behavior.
> If vendor needs to support legacy, vendor anyway needs to implement _HDR anyway in data path.
> and above MAC change, and feature provisioning.
> 
> For legacy there is no extra/special documentation.
> All the behavior listed in Legacy interfaces section for configuration register present applies here.
> 
> So, I don't see mac support is trivial by any means compared to proposed scheme for 1.x.
> Hence, comparing trivialness of two solutions seems same for your point #1 once you do mac plumbing.
> 
> Regarding #2 on nesting. I won't claim I understand this as your level of knowledge.
> If you are sauing only the VF is in VM as virtio PCI device to supporting nested guest, that doesn't have AQ, hence it doesn't work due above issues.

Nothing is tied to admin queue here btw - it's using admin commands.
And by the way, there's a simple way to make this work with nesting
down the road if we want to: add support for sending admin commands
using MMIO. Jason, if you want to solve nesting I think that's the best
way. Will address other use-cases too, not just legacy.


> Then yes, but than it is back to square one, where you need sequence #1 to #8 to be done + non-forward-looking spec changes on reset flow.
> 
> In that alternative, one can say, hey skip steps #1 to #5, and on step #8 doesn't have required feature bit, mark the device FAILED.
> But this is common case and its late in the init flow to discover it.
> 
> And now MAC cannot be set atomically either in nesting with just feature bit without ugly and non-trivial spec updates.
> And when one needs nesting with legacy, probably PV is better.
> 
> As Michael said,
> Overall isolating legacy to AQ for config, intx and by reusing 1.x's notification is good trade off where 1.x device level interface is kept as detached from the legacy as possible.
> 
> This is why the notification address query also was desired via AQ as proposed in v3, but it is small trade off if you think it should be discovered via PCI cap like v5.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

