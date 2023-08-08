Return-Path: <virtio-dev-return-13503-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C598C001DB
	for <virtio-dev@archiver.kernel.org>; Tue,  8 Aug 2023 08:09:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id BF76123D78
	for <virtio-dev@archiver.kernel.org>; Tue,  8 Aug 2023 08:09:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id ABEB5986492
	for <virtio-dev@archiver.kernel.org>; Tue,  8 Aug 2023 08:09:32 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 9A4E898403A; Tue,  8 Aug 2023 08:09:32 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 86C35986460;
	Tue,  8 Aug 2023 08:09:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VpKd63J_1691482166;
Date: Tue, 08 Aug 2023 16:04:40 +0800
Message-Id: <1691481880.8297818-1-xuanzhuo@linux.alibaba.com>
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Parav Pandit <parav@nvidia.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>
Cc: Satananda Burla <sburla@marvell.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>
Subject: [virtio-dev] virtio-net ip restriction.

## Background

For cloud, the ip restriction is important. Because the user of the vm is
untrustworthy. One user may use the ip of another to config the netdevice to
receive and send packets. So we need to restrict the ip traffic of the device(or port).

## Implement
Now we have these choice:

1. introduce the switch(as the part of pf or as a separate device under all PF
   and VFs ), the switch support rx/tx filter
2. the virtio-net device support the ip restriction


Parav wrote:
> I understood that you for some reason do not need restrictions for the PF.
> I do not know why you don't need it. :)
> Most cloud setups that I came across so far, needs it, but ok...

PF is used by the administrator, so the ip restriction for the PF is
not important. But we can have this feature.

> The design for the switch object needs to cover the PF as well, even though it may not be done initially.
> (hint: an abstraction of switch port to be done, instead of doing things directly on the group member id).
>
> We are seeing use cases reducing of having switch located on the PF for its VFs.

So for you, we should introduce a switching PF?

> So please reconsider.
> I remember you mentioned in past in other thread, that mac etc is controlled from the infrastructure side.

YES.

> So, I repeatedly ask if you _really_ need to have the switch object as part of the owner PF or not.

For me, that are all ok.
Could you explain the difference between these?
So I would to know which one is better and which one is simper?

> Which sort of contradicts with locating the administrative switch on the owner PF.

Why?

For us, all is on the DPU.

>
> If it does, flow filters vq that is being worked with Heng, Satananda, David
> and others seems right direction to implement simple->complex switch object
> progressively.

Great!!


Thanks.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

