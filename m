Return-Path: <virtio-dev-return-11907-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37882C76196
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 15:23:20 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 90C2D3DF27
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 15:23:19 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8567D9863FE
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 15:23:19 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 7B1DC9863DF; Mon,  3 Apr 2023 15:23:19 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 66FF59863DE
	for <virtio-dev@lists.oasis-open.org>; Mon,  3 Apr 2023 15:23:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: iujV2L4yOjiYpcMBtlc8_g-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680535391;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ie+9l506BIJC9elguckI8ioIKISNJPQKx/yp3ZtyNMs=;
        b=J185pBUbcy+Fjcef54nV4MWpLUsOSwT74X70QzslH/j9YEXZ/PbCcv+wZthzmy+coZ
         67SxaMiCUXpBr2dOcLm4sJKwz0u7lj3Hz3yMvGjobay6womGr/EzEyA0Oiz6MsM12a17
         HYBgf7zllVCV2SCSI2oL6gkWw/N80vWQkwYuX4AzPOHkONNfMbBqAfDDdyrG2ykqDvfD
         pl8GqlxAt1WoRWqkzGUv/thRzCzZoEOPRTsZtiR3GgQZfCbu/yPcWF28cMgrtSjZwFzD
         UIG+CPIJT/1tLEuzxf/tiEIgOnFqDCD0WCEf3qySdIETlkbYTPw1ohDgb9Mp65Kr/1rs
         9vpw==
X-Gm-Message-State: AAQBX9cGTD2NbHZEKPng3fI9Yb+zzu7QinPS3iRHtLG63Q1gWpvoPnIF
	0YhSRPulyG3c1R5fUhEXAIdNqA/uHhiXuhv/Bgqv7IcjPR8vgJF/W+517MkyIkncwTBFSupBA3Q
	DP3MTkiKuq1kZQTOqx6uouThSwDPFu8s3UhzJ+Vxqyw==
X-Received: by 2002:a17:906:174b:b0:929:7d80:3a37 with SMTP id d11-20020a170906174b00b009297d803a37mr34857090eje.37.1680535391329;
        Mon, 03 Apr 2023 08:23:11 -0700 (PDT)
X-Google-Smtp-Source: AKy350bH6GnppWPLhPpXwy3fuly/GUnxMRu17exlTDNC6TkQsqtv+bcORgUtSBFQUWDPWYF4snCc/w==
X-Received: by 2002:a17:906:174b:b0:929:7d80:3a37 with SMTP id d11-20020a170906174b00b009297d803a37mr34857069eje.37.1680535391060;
        Mon, 03 Apr 2023 08:23:11 -0700 (PDT)
Date: Mon, 3 Apr 2023 11:23:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Message-ID: <20230403111735-mutt-send-email-mst@kernel.org>
References: <20230330225834.506969-1-parav@nvidia.com>
 <20230331024500-mutt-send-email-mst@kernel.org>
 <0dcd9907-4bb0-ef0d-678d-5bc8f0ded9ec@nvidia.com>
 <20230403105050-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481D50080A3A7C5F81E3F62DC929@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230403110320-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481EC65708410304D9C1EA3DC929@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481EC65708410304D9C1EA3DC929@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH 00/11] Introduce transitional mmr pci device

On Mon, Apr 03, 2023 at 03:16:53PM +0000, Parav Pandit wrote:
> 
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Monday, April 3, 2023 11:07 AM
> 
> > > > OTOH it is presumably required for scalability anyway, no?
> > > No.
> > > Most new generation SIOV and SR-IOV devices operate without any para-
> > virtualization.
> > 
> > Don't see the connection to PV. You need an emulation layer in the host if you
> > want to run legacy guests. Looks like it could do transport vq just as well.
> >
> Transport vq for legacy MMR purpose seems fine with its latency and DMA overheads.
> Your question was about "scalability".
> After your latest response, I am unclear what "scalability" means.
> Do you mean saving the register space in the PCI device?

yes that's how you used scalability in the past.

> If yes, than, no for legacy guests for scalability it is not required, because the legacy register is subset of 1.x.

Weird.  what does guest being legacy have to do with a wish to save
registers on the host hardware? You don't have so many legacy guests as
modern guests? Why?



>  
> > > > And presumably it can all be done in firmware ...
> > > > Is there actual hardware that can't implement transport vq but is
> > > > going to implement the mmr spec?
> > > >
> > > Nvidia and Marvell DPUs implement MMR spec.
> > 
> > Hmm implement it in what sense exactly?
> >
> Do not follow the question.
> The proposed series will be implemented as PCI SR-IOV devices using MMR spec.
>  
> > > Transport VQ has very high latency and DMA overheads for 2 to 4 bytes
> > read/write.
> > 
> > How many of these 2 byte accesses trigger from a typical guest?
> > 
> Mostly during the VM boot time. 20 to 40 registers read write access.

That is not a lot! How long does a DMA operation take then?

> > > And before discussing "why not that approach", lets finish reviewing "this
> > approach" first.
> > 
> > That's a weird way to put it. We don't want so many ways to do legacy if we can
> > help it.
> Sure, so lets finish the review of current proposal details.
> At the moment 
> a. I don't see any visible gain of transport VQ other than device reset part I explained.

For example, we do not need a new range of device IDs and existing
drivers can bind on the host.

> b. it can be a way with high latency, DMA overheads on the virtqueue for read/writes for small access.

numbers?

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

