Return-Path: <virtio-dev-return-13128-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9F0BEB64DC
	for <virtio-dev@archiver.kernel.org>; Wed, 28 Jun 2023 16:45:54 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 1DF2768469
	for <virtio-dev@archiver.kernel.org>; Wed, 28 Jun 2023 16:45:54 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EE4E3986588
	for <virtio-dev@archiver.kernel.org>; Wed, 28 Jun 2023 16:45:53 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id D78EC986585; Wed, 28 Jun 2023 16:45:53 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C4247986587
	for <virtio-dev@lists.oasis-open.org>; Wed, 28 Jun 2023 16:45:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: Ctnd9JPZMnmMFTPCcHDNoQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687970750; x=1690562750;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D/+wFaP2tV3eI8lBoLIE5wBoYbfWoq5jOXd49ousCw8=;
        b=FjwpRNsaHGZ1uKT6PHjkrv6A/oXSZGforba6T11q0Fk5mj8H9IR7/AfXeJG50WJQDt
         FVt1gmvIQD11zLYjUhqlEbQfAyiyrYz9ZfFEmOOJe6mcuLti8ABpyJMzketS2kjPZ7Yb
         psN5/52euMF0ZYkyAOka0gj3Scpm031gCTD8gR1xgOyuKm26EV+EL94rJ32XG94LpRxJ
         JroN43QPbSznkxTdPgGJ+apmkcoyVb790KdJcpZgApF3i5h++l9bRqUwZTyhs8/fJPBf
         a0Hxn0GmWFAKKbYj5Y8jFRJObBCUaMYUFlt7EK5UpwvqStdc5fOs8d3+83jn3u0zZDTy
         SAcA==
X-Gm-Message-State: AC+VfDzgqy2TWJoo0h+ZjT7nWoYw+48yyGgXB1mfoG1uK8xBRIOsJQnd
	TfAJ7xLmG6LW4sV2xmIBEjJYDkedUdslNDUktxCTyJOGPQykWzCVLSS0/hkczjHx1uHKV6IxFt1
	CgpJqKqkBFVn9jpC8m6YbC8ccAMw9
X-Received: by 2002:a19:380f:0:b0:4f8:4512:c844 with SMTP id f15-20020a19380f000000b004f84512c844mr19015322lfa.48.1687970749790;
        Wed, 28 Jun 2023 09:45:49 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ69NcTmw/elY+pUPidZQQK3N4SBumgsTJdrWiiIRwCXxApfHYFK8XZpUF0LOCilOO9pDKdt8w==
X-Received: by 2002:a19:380f:0:b0:4f8:4512:c844 with SMTP id f15-20020a19380f000000b004f84512c844mr19015309lfa.48.1687970749396;
        Wed, 28 Jun 2023 09:45:49 -0700 (PDT)
Date: Wed, 28 Jun 2023 12:45:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Jason Wang <jasowang@redhat.com>, Heng Qi <hengqi@linux.alibaba.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Message-ID: <20230628123131-mutt-send-email-mst@kernel.org>
References: <20230627163549.40028-1-hengqi@linux.alibaba.com>
 <CACGkMEvFmAiWDp8w=ytin21Oi+PcTb1X3Eve7Kt2NVr_RkhgmA@mail.gmail.com>
 <PH0PR12MB54811123CFCDEFE3B48D4381DC24A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230628061257-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481ED6C94DE8CC414C3369BDC24A@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481ED6C94DE8CC414C3369BDC24A@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] RE: [PATCH v19] virtio-net: support inner
 header hash

On Wed, Jun 28, 2023 at 04:18:02PM +0000, Parav Pandit wrote:
> 
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Wednesday, June 28, 2023 6:27 AM
> > 
> > On Wed, Jun 28, 2023 at 04:23:09AM +0000, Parav Pandit wrote:
> > >
> > > > From: Jason Wang <jasowang@redhat.com>
> > > > Sent: Tuesday, June 27, 2023 11:46 PM
> > > >
> > > > Having it in the config space, then a type agnostic provisioning
> > > > through config space + feature bits just works fine.
> > > >
> > > Provisioning is far simpler thing to do in device specific way than asking device
> > to store this value in onchip area which is rarely accessed.
> > 
> > I thought a lot about this over the weekend. I just do not see this working out,
> > sorry.  Two things is never easier than one. 
> 
> You proposed two things and making it mandatory.
> I am glad that you realized to do using one interface.
> 
> In different context, you proposed two interface for driver notification on PF and/or VF BAR in separate thread for flexibility. I asked for one.
> Somehow you promoted flexibility (and also complexity that no vendor wanted), and here you lean towards single interface...
> 
> So more explanation of the rationale will help to understand.

OK I will try.

Actually, my preblem is exactly if there's no one single
interface that can do everything.


Two interfaces that do the same might seem redundant but
there could be good reasons for this, in this case legacy.

See the difference?

> I didn't propose two interfaces. Let me explain again.
> 
> I proposed, 
> a. all new fields to go via vq (single interface)
> b. all existing fields to stay in cfg space (single interface)
> c. if one wants to optimize optionally existing fields can utilize (same flexibility how you asked for PF and VF notification).
> 
> 
> > We already need config space with provisioning.  
> Provisioning does provision features, config space and control parameters, msix vectors and more.
> Provisioning does _not_ need config space.

I mean it needs to provision it.

> > In fact e.g. on Linux we want drivers to keep doing virtio_cread()
> > and all the DMA tricks should be hidden behind the scenes. You don't like it that
> > config space is on-chip? Build an interface for it not to be on chip. There is
> > simply no downside to that.
> > 
> This is the ask to build software interface between driver and device to not demand on-chip config space more importantly _predictably_.

Absolutely. So we would say that driver SHOULD use the DMA interface
if it is present.

> > I came back after a small break and I still see this discussion that keeps playing
> > out as a big distraction.
> > In particular where are you doing to store the things that are for DMA?
> > In system RAM? We don't *have* anywhere in system RAM to store this, we will
> > need an interface to allocate system RAM and pass it to device for this idea to
> > work. So in 1.3 where we won't have this, there is much less of an excuse to use
> > a vq.
> To store what?
> CVQ is already there to do GET and SET operation.

To store whatever value CVQ is requesting. Where is it going to
come from?


> > 
> > 
> > 
> > 
> > > There are many fields of many features for 1.4 are discussed including this
> > one. All of these capabilities just cannot be stored in config space.
> > 
> > config space is synchronous interface, vq is asynchronous.  Setup is just too
> > messy to do asynchronously. So yes, config space.
> > 
> Huh, I disagree. The whole virtio spec has got the VQs all over and you say that VQ is messy.
> Doesn't make any sense at all.

Asynchronous is just harder for software.  Look at the hoops virtio net
has to jump through to do control path over cvq and weep. Compare to
single liner virtio_cread.

I happen to maintain Linux drivers too, so I care.

> > 
> > Please let people just focus on fixing config space instead of temporary cvq
> > hacks.
> 
> The ask is to have predictable sizing for existing defined config space field and not keep infinitely growing by two interfaces.

I don't know what "predictable sizing" is or why does it matter.

I get the value of reduced MMIO register map.
I get that the only way to get that appears to be to pass values
around using DMA.

I don't think we need to throw away config space - just use DMA to access it.

And "existing defined" here seems to be at a completely random point in time.
If someone wants to have fields in MMIO, I see no reason not to.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

