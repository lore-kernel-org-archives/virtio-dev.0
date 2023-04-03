Return-Path: <virtio-dev-return-11934-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 850C4C77B62
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 21:05:30 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id AEF8026A38
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 21:05:28 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 31B4B986646
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 21:05:28 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 9B0169863ED; Mon,  3 Apr 2023 21:05:27 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C38A19863E5
	for <virtio-dev@lists.oasis-open.org>; Mon,  3 Apr 2023 21:04:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: IDU0w1jnPfymWMG996GDCw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680555859;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JlqjnVOB0UTCOlK20t3CnPMA47HLiLr1lvMvx+AyJ6w=;
        b=foOZ7WcyRSYSERE9AZiMj55yd7vVZ4JY/8oGXtPcos/7wnfal7PTtMxX/h9b32sKI+
         tIPSkfCaz2wgxQRkhP6HJV4mYgsO34cPxcbdL5ixPN105ETDecZSJlSKCK6txeA4Orhf
         sWfhLsiQxLI2oEp4cR/0lMbcEesWlh2V0ku97S5NQOEprLlUo3Y2KS6DN7SvhuhlncL0
         l4iyStlh5J62K2U0dnrlTZKnO2Xyz23k4wPybVwA+/1RKeweX0D3xldTzgKGlE1Ix31B
         fmpHMVSZkkiMwQ5+Y1dApPleA2pZil4ednVvRBFOHHKuVcOROrxsxSP7APygkgc0+ltD
         zJDw==
X-Gm-Message-State: AAQBX9c1i95S6M4SMKKrOnkTgawOa5p9Dh/HM5FvgQHIYbbwcSJ7HUei
	4cjQsHH0ZgnUfv+4WJW30oQs+hNb5izBNp3PjFZkK4Cj/QGNXmUBmU0NtcwcSQEsznoB1Cv947q
	Tl5o590XPLBgXmWXzk3GgUYCAVjrO
X-Received: by 2002:a17:906:a2c7:b0:933:4184:f0d7 with SMTP id by7-20020a170906a2c700b009334184f0d7mr9943ejb.69.1680555858908;
        Mon, 03 Apr 2023 14:04:18 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZUaPfzFvke1bqkMPJyT3YSZJWinECAPDWgnRKJL1qS8ufJFbOJpe/ay89Cr8tvnM9TplmWYw==
X-Received: by 2002:a17:906:a2c7:b0:933:4184:f0d7 with SMTP id by7-20020a170906a2c700b009334184f0d7mr9927ejb.69.1680555858545;
        Mon, 03 Apr 2023 14:04:18 -0700 (PDT)
Date: Mon, 3 Apr 2023 17:04:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Message-ID: <20230403163730-mutt-send-email-mst@kernel.org>
References: <20230403105050-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481D50080A3A7C5F81E3F62DC929@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230403110320-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481EC65708410304D9C1EA3DC929@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230403111735-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54813E4193BC32775BDB2019DC929@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230403130950-mutt-send-email-mst@kernel.org>
 <24e5437e-d6bd-d65c-9ec2-699277a113a3@nvidia.com>
 <20230403135446-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54815AFE1FE7E1D2AAABBAF4DC929@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54815AFE1FE7E1D2AAABBAF4DC929@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] Re: [PATCH 00/11] Introduce transitional mmr
 pci device

On Mon, Apr 03, 2023 at 08:25:02PM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Monday, April 3, 2023 2:02 PM
> 
> > > Because vqs involve DMA operations.
> > > It is left to the device implementation to do it, but a generic wisdom
> > > is not implement such slow work in the data path engines.
> > > So such register access vqs can/may be through firmware.
> > > Hence it can involve a lot higher latency.
> > 
> > Then that wisdom is wrong? tens of microseconds is not workable even for
> > ethtool operations, you are killing boot time.
> > 
> Huh.
> What ethtool latencies have you experienced? Number?

I know an order of tens of eth calls happens during boot.
If as you said each takes tens of ms then we are talking close to a second.
That is measureable.

> > I frankly don't know, if device vendors are going to interpret "DMA" as "can
> > take insane time" then maybe we need to scrap the whole admin vq idea and
> > make it all memory mapped like Jason wanted, so as not to lead them into
> > temptation?
> 
> DMA happens for all types of devices for control and data path.
> Can you point to any existing industry specification and real implementation that highlights such timing requirements.
> This will be useful to understand where these requirements come from.
> 
> Multiple device implementors do not see memory mapped registers as way forward.
> Discussed many times.
> There is no point in going that dead end.

OK then. Then if it is a dead end then it looks weird to add a whole new
config space as memory mapped.

> > Let me try again.
> > 
> > Modern host binds to modern interface. It can use the PF normally.
> > Legacy guest IOBAR accesses to VF are translated to transport vq accesses.
> > 
> I understand this part.
> Transport VQ is on the PF, right? (Nothing but AQ, right?)
> 
> It can work in VF case with trade-off compared to memory mapped registers.
> A lightweight hypervisor cannot benefit from this which wants to utilize this for transitional PF too.
> So providing both the options is useful.

If hardware vendors do not want to bear the costs of registers then they
will not implement devices with registers, and then the whole thing will
become yet another legacy thing we need to support. If legacy emulation
without IO is useful, then can we not find a way to do it that will
survive the test of time?

> Again, I want to emphasize that register read/write over tvq has merits with trade-off.
> And so the mmr has merits with trade-off too.
> 
> Better to list them and proceed forward.
> 
> Method-1: VF's register read/write via PF based transport VQ
> Pros:
> a. Light weight registers implementation in device for new memory region window

Is that all? I mentioned more.

> Cons:
> a. Higher DMA read/write latency
> b. Device requires synchronization between non legacy memory mapped registers and legacy regs access via tvq

Same as a separate mmemory bar really.  Just don't do it. Either access
legacy or non legacy.

> c. Can only work with the VF. Cannot work for thin hypervisor, which can map transitional PF to bare metal OS
> (also listed in cover letter)

Is that a significant limitation? Why?

> Method-2: VF's register read/write via MMR (current proposal)
> Pros:
> a. Device utilizes the same legacy and non-legacy registers.

Not really. For starters endian-ness can be different. Maybe for some
devices and systems. 

> b. an order of magnitude lower latency due to avoidance of DMA on register accesses
> (Important but not critical)

And no cons? Even if you could not see them yourself did I fail to express myself to such
an extent?

> > > No. Interrupt latency is in usec range.
> > > The major latency contributors in msec range can arise from the device side.
> > 
> > So you are saying there are devices out there already with this MMR hack
> > baked in, and in hardware not firmware, so it works reasonably?
> It is better to not assert a solution a "hack",

Sorry if that sounded offensive.  a hack is not necessary a bad thing.
It's a quick solution to a very local problem, though.

> when you are still
> trying to understand the trade-offs of multiple solutions and when you
> are yet to fully review all requirements.
> (and when solution is also based on an offline feedback from you!)

Sorry if I set you on a wrong path I frankly didn't realize how
big a change the result will be. I was thinking more along the lines
of a capability describing a portion of a memory bar, saying access
there is equivalent to access to the io bar. That's it.

> No. I didn't say that device is out there.
> However, large part of the proposed changes is done based on real devices (and not limited to virtio).

Yes motivation is one of the things I'm trying to work out here.
It does however not help that it's an 11 patch strong patchset
adding 500 lines of text for what is supposedly a small change.

> Regarding tvq, I have some idea on how to improve the register read/writes so that its optimal for devices to implement.

Sounds useful, and maybe if tvq addresses legacy need then focus on
that?

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

