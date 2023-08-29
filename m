Return-Path: <virtio-dev-return-13586-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0162C83F14
	for <virtio-dev@archiver.kernel.org>; Tue, 29 Aug 2023 11:20:31 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 1EB901922F0
	for <virtio-dev@archiver.kernel.org>; Tue, 29 Aug 2023 11:20:31 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0FDD7986429
	for <virtio-dev@archiver.kernel.org>; Tue, 29 Aug 2023 11:20:31 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 03BEB9863DF; Tue, 29 Aug 2023 11:20:31 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E2DEA9863D6;
	Tue, 29 Aug 2023 11:20:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R541e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VqrKB63_1693308010;
Message-ID: <1693307779.4901662-2-xuanzhuo@linux.alibaba.com>
Date: Tue, 29 Aug 2023 19:16:19 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "jasowang@redhat.com" <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 David Edmondson <david.edmondson@oracle.com>,
 "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
 "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
References: <20230821064258.20608-1-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB54814174FC713CF5640B7B10DC1DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1693279777.37882-2-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB548154BAE90B3F4A24175060DCE7A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1693293460.1621294-1-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB54811CB118D7D9BC36E563BCDCE7A@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB54811CB118D7D9BC36E563BCDCE7A@PH0PR12MB5481.namprd12.prod.outlook.com>
Subject: [virtio-dev] Re: RE: [virtio-comment] RE: RE: [PATCH v15] virtio-net: support device stats

On Tue, 29 Aug 2023 10:58:40 +0000, Parav Pandit <parav@nvidia.com> wrote:
>
> > From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > Sent: Tuesday, August 29, 2023 12:48 PM
> >
> > For this line:
> >  "If the reply header structure and actual stats are split properly, it will be easy
> >   to add the query by the owner device."
> >
> > So for the header structure, is there some specific requirements?
>
> TLV type, length, is only two fields needed and to align to 64-bit.
> struct virtio_element_type {
> 	u16 type;
> 	u16 rsvd;
> 	u32 length;
> };
>
> Above generic type if defined, that we can possibly use across many virtio devices.


I see.

So I wonder, should we be thinking about this now. When will we try to get
statistics via aq. If we try to do this, the request data may also have to use a
uniform format.

Thanks.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

