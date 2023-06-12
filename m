Return-Path: <virtio-dev-return-12937-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76A56C7EE2F
	for <virtio-dev@archiver.kernel.org>; Mon, 12 Jun 2023 06:20:42 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id A7DB915AA46
	for <virtio-dev@archiver.kernel.org>; Mon, 12 Jun 2023 06:20:41 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 96E5398653D
	for <virtio-dev@archiver.kernel.org>; Mon, 12 Jun 2023 06:20:41 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 89F9D983E8D; Mon, 12 Jun 2023 06:20:41 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6FF9F986468;
	Mon, 12 Jun 2023 06:20:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VksbTPZ_1686550833;
Date: Mon, 12 Jun 2023 14:12:35 +0800
Message-Id: <1686550355.2503424-1-xuanzhuo@linux.alibaba.com>
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtio-dev@lists.oasis-open.org
Cc: virtio-comment@lists.oasis-open.org,"Michael S . Tsirkin" <mst@redhat.com>,
    "Parav Pandit" <parav@nvidia.com>, "Jason Wang" <jasowang@redhat.com>
Subject: [virtio-dev] About custom device counter

We hope to support device custom counter. That is, virtio spec provides a
channel for driver and device, and both key and value are provided by device.

We discussed this issue earlier, and after some internal practice, I think it is
still necessary to discuss this again.

It is very important, each cloud vendor will always have some special counters,
these counters may not exist in another vendor. At the same time, if we have
to discuss it in the spec every time we add a counter, or add a feature, I
think it is very inconvenient. Manufacturers may add some new counters at any
time based on some new requirements. Some counters may also be removed at any
time.

Of course I know that doing this might hurt migration. But what I want to say is,
why does it affect live migration? These counters we plan to give to users
through ethtool -S, and some changes have taken place in the ethtool counters
output by users. Does this have any practical impact? Or do we directly use
some other output in a way, we can clearly tell the user that these counters
may change during the migration process. For example, the driver is migrated
to some new devices. These devices support some new counters. I think users
should be able to see these new counters. These new counters may be the
purpose of the migration.

We don't need to support live migration at this point.

Thanks.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

