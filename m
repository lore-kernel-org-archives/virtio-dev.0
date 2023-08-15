Return-Path: <virtio-dev-return-13536-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C28AEC001B0
	for <virtio-dev@archiver.kernel.org>; Tue, 15 Aug 2023 06:00:21 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 0DD0B2AD71
	for <virtio-dev@archiver.kernel.org>; Tue, 15 Aug 2023 06:00:20 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F07A59863AD
	for <virtio-dev@archiver.kernel.org>; Tue, 15 Aug 2023 06:00:19 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id DCAB9984035; Tue, 15 Aug 2023 06:00:19 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C094B98633F;
	Tue, 15 Aug 2023 06:00:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VpqWkcR_1692079213;
Message-ID: <1692079141.2231495-4-xuanzhuo@linux.alibaba.com>
Date: Tue, 15 Aug 2023 13:59:01 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
 "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20230731074945.108883-1-xuanzhuo@linux.alibaba.com>
 <1691388913.8316696-2-xuanzhuo@linux.alibaba.com>
 <1692070761.567899-3-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB54815E430B977F2969C9FAEADC14A@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB54815E430B977F2969C9FAEADC14A@PH0PR12MB5481.namprd12.prod.outlook.com>
Subject: Re: RE: [virtio-dev] [PATCH v14 RESENT] virtio-net: support device stats

On Tue, 15 Aug 2023 04:37:41 +0000, Parav Pandit <parav@nvidia.com> wrote:
>
> > From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > Sent: Tuesday, August 15, 2023 9:09 AM
>
> > On Mon, 7 Aug 2023 14:15:13 +0800, Xuan Zhuo
> > <xuanzhuo@linux.alibaba.com> wrote:
> > > On Mon, 31 Jul 2023 15:49:45 +0800, Xuan Zhuo
> > <xuanzhuo@linux.alibaba.com> wrote:
> > > > This patch allows the driver to obtain some statistics from the device.
> > > >
> > > > In the device implementation, we can count a lot of such
> > > > information, which can be used for debugging and judging the running
> > > > status of the device. We hope to directly display it to the user through
> > ethtool.
> > > >
> > > > To get stats atomically, try to get stats for all queue pairs in one
> > > > command.
> > > >
> > > > If the feature is negotiated, the device must support all the stats
> > > > listed in this commit. If we want add new stats in future, one new
> > > > feature should be introduced.
> > >
> All or nothing does not work as its very restrictive model.
> Many stats can be cheaply counted (or already counted) by the driver today.
> Hence it must be an extendible bitmap.

Sorry.

This version already has the bitmap. I forgot to change the commit log.

Thanks.


>
> Finally supported bitmap to be queried via cvq of supported counters.
>
> Didn't review every stat yet.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

