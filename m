Return-Path: <virtio-dev-return-13419-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D210FC04A94
	for <virtio-dev@archiver.kernel.org>; Mon, 31 Jul 2023 05:52:56 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 2E1E22AFFB
	for <virtio-dev@archiver.kernel.org>; Mon, 31 Jul 2023 05:52:55 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1B7EC986408
	for <virtio-dev@archiver.kernel.org>; Mon, 31 Jul 2023 05:52:55 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 0B081983EBE; Mon, 31 Jul 2023 05:52:55 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EA116986364;
	Mon, 31 Jul 2023 05:52:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VoZMxTw_1690782768;
Message-ID: <1690782610.3048255-3-xuanzhuo@linux.alibaba.com>
Date: Mon, 31 Jul 2023 13:50:10 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20230726081229.55947-1-xuanzhuo@linux.alibaba.com>
 <20230726070801-mutt-send-email-mst@kernel.org>
 <1690422490.8491526-1-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB548149ED4C687913EDA3EED9DC05A@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB548149ED4C687913EDA3EED9DC05A@PH0PR12MB5481.namprd12.prod.outlook.com>
Subject: [virtio-dev] Re: RE: [PATCH v13] virtio-net: support device stats

On Mon, 31 Jul 2023 04:32:22 +0000, Parav Pandit <parav@nvidia.com> wrote:
>
> > From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > Sent: Thursday, July 27, 2023 7:18 AM
>
> > > why don't we have a config space field for supported types?
> > > more straight forward than complex rules...
> >
> > I am ok for adding a config space field.
>
> During 1.3 we completed the discussion that any new config field addition must adhere to DMA interface and not a register.
> Multiple capabilities need this.
> So lets please work on that.

OK.


>
> Counters needs to use the dma interface and it can wait one time to utilize the modern interface.
>
> I have two proposals to for the dma interface and we should discuss that in separate thread to not mix the cvq parts of the stats.
> I will start the thread shortly and put pointer to this requirement of counters + many others that we are discussing including ntuple.


I will keep pushing this, if your proposals affect this, I will fix it in
a furture version.

Thanks.


>
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

