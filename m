Return-Path: <virtio-dev-return-12992-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9072EB64D9
	for <virtio-dev@archiver.kernel.org>; Tue, 20 Jun 2023 02:55:30 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 246A616DCCC
	for <virtio-dev@archiver.kernel.org>; Tue, 20 Jun 2023 02:55:30 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 00E5B98650C
	for <virtio-dev@archiver.kernel.org>; Tue, 20 Jun 2023 02:55:29 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id DE95998638D; Tue, 20 Jun 2023 02:55:29 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B5ECC9863BD;
	Tue, 20 Jun 2023 02:55:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Vla-FS6_1687229721;
Message-ID: <1687229151.8558426-2-xuanzhuo@linux.alibaba.com>
Date: Tue, 20 Jun 2023 10:45:51 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
 "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
 Jason Wang <jasowang@redhat.com>,
 Parav Pandit <parav@nvidia.com>
References: <1686550355.2503424-1-xuanzhuo@linux.alibaba.com>
 <20230612022526-mutt-send-email-mst@kernel.org>
 <1686569235.2395291-1-xuanzhuo@linux.alibaba.com>
 <20230613045854-mutt-send-email-mst@kernel.org>
 <1686810211.4567776-1-xuanzhuo@linux.alibaba.com>
 <20230616101113-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481D058584D7AF742C1FEE1DC5FA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230619101745-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230619101745-mutt-send-email-mst@kernel.org>
Subject: [virtio-dev] Re: [virtio-comment] Re: About custom device counter

On Mon, 19 Jun 2023 10:20:56 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Mon, Jun 19, 2023 at 12:33:33PM +0000, Parav Pandit wrote:
> >
> >
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: Friday, June 16, 2023 10:13 AM
> > > > Such as "limit", in a cloud scenario, multiple users purchase
> > > > different VMs, and these VMs share the capabilities of the same host.
> > > > In order to ensure that each VM will not affect others, the network
> > > > card(virtio-net) capability of each VM is limited. When these users purchase
> > > VMs, this limit has already been determined.
> > > > So if the network card traffic of a vm exceeds the upper limit, packet
> > > > loss will occur. It is necessary for us to count these packet losses.
> > > > And the device should expose to the user.
> > >
> > > OK so here, driver is expected to rate limit yes?
> > >
> > Some implementations of txq are lossy and some are not creating backpressure/flow control to driver so driver can rate limit it naturally.
> > So a tx packet drop counter is needed to cover the lossy implementations which is abstract enough regardless of reason on why device dropped it.
>
>
> Yes but Xuan Zhuo here is saying that he wants a register that is
> like link speed, not a counter.
>

A counter.

This is a capability, but it only exists between the device and the user. The
capability is set when the user buys a network card, so it has nothing to do
with the driver. As a result, some packets were lost, and we hope that these
counter can be passed to users. Because this capability has nothing to do
with the virtio spec, we always want it to be a vendor custom counter.

Of course, some parameters can be abstracted, and we are very happy to do so.
But I am worried that this will lead to inaccurate expressions of meaning.

Anyway we can try something out, I'll sort out some of the counters we'd like to
have. There are also some that I think we want to customize. We discuss further
based on these counters.


Thanks.


>
> > A more granular counter becomes vendor specific that we can possibly avoid or place under different command.
>
>
> --
> MST
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

