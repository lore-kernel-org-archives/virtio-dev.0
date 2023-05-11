Return-Path: <virtio-dev-return-12660-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 235E4C7EE22
	for <virtio-dev@archiver.kernel.org>; Thu, 11 May 2023 20:58:29 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 6A7BA142D6B
	for <virtio-dev@archiver.kernel.org>; Thu, 11 May 2023 20:58:28 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5DA8E9866F6
	for <virtio-dev@archiver.kernel.org>; Thu, 11 May 2023 20:58:28 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 50CC49866D9; Thu, 11 May 2023 20:58:28 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3BFF79866E3
	for <virtio-dev@lists.oasis-open.org>; Thu, 11 May 2023 20:58:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 4NrErV44PwO4xtZ5EkON2A-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683838702; x=1686430702;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p/yGR6Nd7PrVB7p1n8dX2oI7PvCx1/oHN2ZRylAXXy0=;
        b=I7HZS9g+Aaix32cxVDACXjAVLZ03XgWh/H4atKOqzUdbYNtji5n6vuifwzrQuCLsuX
         sio7rW8cH6B5/zf0il2/mMyPzkksYuuRybiz/fBrbznNYi96eWTBky+mjMpSDTobjVGL
         FPSMsHNBliwuwcm9Y7XCGgMBGlkcKIGzOTzRzRLQ3xuKyT0o2Yg2uSSjOKMIan9u/VSk
         UXS1iP0TMMc4wzxvfacB2kBV1KUx1C+CTxbuYASmCR+xgw8Xc9MkgoqOp8suSpbDIPZg
         EfibFvWMp3sIAY/I7zWNHYfwzD6dCvOazoxqTRDYEqEcaA4DM3sC0TRt+sjI1G3GPcCX
         kTAA==
X-Gm-Message-State: AC+VfDxCDF3LWBnyCUMQjj2J2RjEDJTlP4bqpOwxvT9jAcoJ6KiQsxeI
	vJZNkXYogSG/XeQP02TkpHkEvqBv/OPfFDu4SwvGqRiKw73qcwqYfldymAOzDbEiHBatraVnsoZ
	kkpH2Nts7sNY3ft3qIbfqRXxttc54
X-Received: by 2002:adf:e909:0:b0:307:c0c4:108f with SMTP id f9-20020adfe909000000b00307c0c4108fmr4287666wrm.33.1683838702115;
        Thu, 11 May 2023 13:58:22 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7jkypahT/aWyZ+K1MSaIgH8Uw3GeGuO7+sWSp1F13WcdEO0PgoXfDZHdcHWcqzjuBObuT1pw==
X-Received: by 2002:adf:e909:0:b0:307:c0c4:108f with SMTP id f9-20020adfe909000000b00307c0c4108fmr4287659wrm.33.1683838701824;
        Thu, 11 May 2023 13:58:21 -0700 (PDT)
Date: Thu, 11 May 2023 16:58:16 -0400
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
Message-ID: <20230511165529-mutt-send-email-mst@kernel.org>
References: <CACGkMEtfMbcu2OPsH6P2tA1aHh2FKygv=xkJ-e1XQzb62nE1vQ@mail.gmail.com>
 <20230510014534-mutt-send-email-mst@kernel.org>
 <43ec1c8d-7d11-2400-3649-1fe366b1e21b@nvidia.com>
 <20230510121417-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481F030A76141320F03956EDC779@PH0PR12MB5481.namprd12.prod.outlook.com>
 <PH0PR12MB5481CEB307F413E53B03D502DC779@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEtm5AS50YmPi6A5=gzZZ9Jm55NEJ3GKOTzv-Z0m5E5J_w@mail.gmail.com>
 <PH0PR12MB5481DE0569EC53A862A4D2E9DC749@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230511093309-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548187706D06D135D3C4FF03DC749@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB548187706D06D135D3C4FF03DC749@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v2 0/2] transport-pci: Introduce legacy registers access
 using AQ

On Thu, May 11, 2023 at 08:47:04PM +0000, Parav Pandit wrote:
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Thursday, May 11, 2023 9:39 AM
> > 
> > On Thu, May 11, 2023 at 01:28:40PM +0000, Parav Pandit wrote:
> > > This is not the objective to transport all PCI virtio fields over AQ.
> > > Transport VQ commands proposal commands and commands in this proposal
> > are just fine the way there without quoting it as "transport".
> > 
> > I mean, it's a transport in a sense of where it will reside in e.g.
> > linux virtio stack - below virtio core.
> > We don't save much code there by reusing the same register layout of legacy
> > pci.
> > But let's at least make this feature complete, and then we'll see whether it is
> > cleaner to reuse legacy layout or build a new one.
> 
> I don't follow your comment about "this feature complete".
> When you say _this_, it means the feature proposed in this patch of supporting legacy over PCI VFs?
> 
> If so, anything missing in this proposal?

I think I commented at least on what I see as missing is first of all
a need to support INT#x emulation since level interrupts are I think
not supported for VFs. right?


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

