Return-Path: <virtio-dev-return-11915-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3DA2C76188
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 17:16:41 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id C837A26A28
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 17:16:40 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id ADC459863F0
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 17:16:40 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 9C0209863DE; Mon,  3 Apr 2023 17:16:40 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 897379863E4
	for <virtio-dev@lists.oasis-open.org>; Mon,  3 Apr 2023 17:16:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: DWzj4in8OoaU4qh1upmjbg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680542197;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UiC1Qh6VcpujEMg4TGP+8T9kvcWcukLPlo+aPG/CVY0=;
        b=6ML9km+4pq8E+qjr2JgdN8yaicT3lM1MLaGj8efQuk1XwcVwgXJ5usbXrWQLt6xeNb
         +1ZGCGjNu9yiZelvyEzpGgOp2uh2aWMrkOwpTI+sXCwjVlMu362Q9TJ0p/Ix4ql752oK
         Z4LWgD2drBGaZZ1miGy+UqaegFZdRpGjrymNISRWN3He894/Mk427d53FmZuX3tjow7O
         HF26jthE6SnP0Y2SMZwGMt7P5xwX2ZqjoCQQzD8pQRv3K/LwUs/cunj7lHKqjRbQFK1Y
         rZ5HpvXZw46ZGjv+4zhQtX4V8mwb/0A+Gil7I00PucvXCjWbPCYgV7quhsJFF3g6NBYk
         BdFw==
X-Gm-Message-State: AAQBX9d4YECOOojyVrpehPJocjevq192TUrMtNaAOgPG7NwwmYghJCxe
	36rEbUVj4eMqj3BBDfWD08hsLuUuk+LBtPr3uVMUA7ky4Ni1hoo3WJtFSaCWySNOzqE9OGA7yTr
	1EZvq5+iKIzsLfCheB9qDS1lec6WH
X-Received: by 2002:a17:906:da1b:b0:932:b790:932c with SMTP id fi27-20020a170906da1b00b00932b790932cmr33038102ejb.44.1680542197477;
        Mon, 03 Apr 2023 10:16:37 -0700 (PDT)
X-Google-Smtp-Source: AKy350YwDsrrlVqRYHa1MFLeAUt2eCnzGu6Pj45mnysGi1x1vTgQ0Hr3qnzgM2FYNfdFqZ5mi6Sjvg==
X-Received: by 2002:a17:906:da1b:b0:932:b790:932c with SMTP id fi27-20020a170906da1b00b00932b790932cmr33038087ejb.44.1680542197132;
        Mon, 03 Apr 2023 10:16:37 -0700 (PDT)
Date: Mon, 3 Apr 2023 13:16:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Message-ID: <20230403130950-mutt-send-email-mst@kernel.org>
References: <20230330225834.506969-1-parav@nvidia.com>
 <20230331024500-mutt-send-email-mst@kernel.org>
 <0dcd9907-4bb0-ef0d-678d-5bc8f0ded9ec@nvidia.com>
 <20230403105050-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481D50080A3A7C5F81E3F62DC929@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230403110320-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481EC65708410304D9C1EA3DC929@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230403111735-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54813E4193BC32775BDB2019DC929@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54813E4193BC32775BDB2019DC929@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] Re: [PATCH 00/11] Introduce transitional mmr
 pci device

On Mon, Apr 03, 2023 at 03:36:25PM +0000, Parav Pandit wrote:
> 
> 
> > From: virtio-comment@lists.oasis-open.org <virtio-comment@lists.oasis-
> > open.org> On Behalf Of Michael S. Tsirkin
> 
> > > Transport vq for legacy MMR purpose seems fine with its latency and DMA
> > overheads.
> > > Your question was about "scalability".
> > > After your latest response, I am unclear what "scalability" means.
> > > Do you mean saving the register space in the PCI device?
> > 
> > yes that's how you used scalability in the past.
> >
> Ok. I am aligned.
>  
> > > If yes, than, no for legacy guests for scalability it is not required, because the
> > legacy register is subset of 1.x.
> > 
> > Weird.  what does guest being legacy have to do with a wish to save registers
> > on the host hardware? 
> Because legacy has subset of the registers of 1.x. So no new registers additional expected on legacy side.
> 
> > You don't have so many legacy guests as modern
> > guests? Why?
> > 
> This isn't true.
> 
> There is a trade-off, upto certain N, MMR based register access is fine.
> This is because 1.x is exposing super set of registers of legacy.
> Beyond a certain point device will have difficulty in doing MMR for legacy and 1.x.
> At that point, legacy over tvq can be better scale but with lot higher latency order of magnitude higher compare to MMR.
> If tvq being the only transport for these registers access, it would hurt at lower scale too, due the primary nature of non_register access.
> And scale is relative from device to device.

Wow! Why an order of magnitide?

> > >
> > > > > > And presumably it can all be done in firmware ...
> > > > > > Is there actual hardware that can't implement transport vq but
> > > > > > is going to implement the mmr spec?
> > > > > >
> > > > > Nvidia and Marvell DPUs implement MMR spec.
> > > >
> > > > Hmm implement it in what sense exactly?
> > > >
> > > Do not follow the question.
> > > The proposed series will be implemented as PCI SR-IOV devices using MMR
> > spec.
> > >
> > > > > Transport VQ has very high latency and DMA overheads for 2 to 4
> > > > > bytes
> > > > read/write.
> > > >
> > > > How many of these 2 byte accesses trigger from a typical guest?
> > > >
> > > Mostly during the VM boot time. 20 to 40 registers read write access.
> > 
> > That is not a lot! How long does a DMA operation take then?
> > 
> > > > > And before discussing "why not that approach", lets finish
> > > > > reviewing "this
> > > > approach" first.
> > > >
> > > > That's a weird way to put it. We don't want so many ways to do
> > > > legacy if we can help it.
> > > Sure, so lets finish the review of current proposal details.
> > > At the moment
> > > a. I don't see any visible gain of transport VQ other than device reset part I
> > explained.
> > 
> > For example, we do not need a new range of device IDs and existing drivers can
> > bind on the host.
> >
> So, unlikely due to already discussed limitation of feature negotiation.
> Existing transitional driver would also look for an IOBAR being second limitation.

Some confusion here.
If you have a transitional driver you do not need a legacy device.



> > > b. it can be a way with high latency, DMA overheads on the virtqueue for
> > read/writes for small access.
> > 
> > numbers?
> It depends on the implementation, but at minimum, writes and reads can pay order of magnitude higher in 10 msec range.

A single VQ roundtrip takes a minimum of 10 milliseconds? This is indeed
completely unworkable for transport vq. Points:
- even for memory mapped you have an access take 1 millisecond?
  Extremely slow. Why?
- Why is DMA 10x more expensive? I expect it to be 2x more expensive:
  Normal read goes cpu -> device -> cpu, DMA does cpu -> device -> memory -> device -> cpu

Reason I am asking is because it is important for transport vq to have
a workable design.


But let me guess. Is there a chance that you are talking about an
interrupt driven design? *That* is going to be slow though I don't think
10msec, more like 10usec. But I expect transport vq to typically
work by (adaptive?) polling mostly avoiding interrupts.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

