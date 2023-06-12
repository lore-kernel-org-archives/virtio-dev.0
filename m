Return-Path: <virtio-dev-return-12940-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 150B8C7EE25
	for <virtio-dev@archiver.kernel.org>; Mon, 12 Jun 2023 11:29:13 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 4BB3DF3F48
	for <virtio-dev@archiver.kernel.org>; Mon, 12 Jun 2023 11:29:13 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3F788986534
	for <virtio-dev@archiver.kernel.org>; Mon, 12 Jun 2023 11:29:13 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 34B95986486; Mon, 12 Jun 2023 11:29:13 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 206FC9864F2;
	Mon, 12 Jun 2023 11:29:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R321e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VkxuGDh_1686569338;
Message-ID: <1686569235.2395291-1-xuanzhuo@linux.alibaba.com>
Date: Mon, 12 Jun 2023 19:27:15 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org,
 virtio-comment@lists.oasis-open.org,
 Parav Pandit <parav@nvidia.com>,
 Jason Wang <jasowang@redhat.com>
References: <1686550355.2503424-1-xuanzhuo@linux.alibaba.com>
 <20230612022526-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230612022526-mutt-send-email-mst@kernel.org>
Subject: [virtio-dev] Re: [virtio-comment] Re: About custom device counter

On Mon, 12 Jun 2023 02:25:42 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Mon, Jun 12, 2023 at 02:12:35PM +0800, Xuan Zhuo wrote:
> > We hope to support device custom counter. That is, virtio spec provides a
> > channel for driver and device, and both key and value are provided by device.
> >
> > We discussed this issue earlier, and after some internal practice, I think it is
> > still necessary to discuss this again.
> >
> > It is very important, each cloud vendor will always have some special counters,
> > these counters may not exist in another vendor. At the same time, if we have
> > to discuss it in the spec every time we add a counter, or add a feature, I
> > think it is very inconvenient. Manufacturers may add some new counters at any
> > time based on some new requirements. Some counters may also be removed at any
> > time.
> >
> > Of course I know that doing this might hurt migration. But what I want to say is,
> > why does it affect live migration? These counters we plan to give to users
> > through ethtool -S, and some changes have taken place in the ethtool counters
> > output by users. Does this have any practical impact? Or do we directly use
> > some other output in a way, we can clearly tell the user that these counters
> > may change during the migration process. For example, the driver is migrated
> > to some new devices. These devices support some new counters. I think users
> > should be able to see these new counters. These new counters may be the
> > purpose of the migration.
> >
> > We don't need to support live migration at this point.
> >
> > Thanks.
>
>
> Why not just document the thing?

Device Counter or Device Stat, we discussed this issue earlier,
So I want to slove the problem migration firstly.


Thanks.


>
> --
> MST
>
>
> This publicly archived list offers a means to provide input to the
> OASIS Virtual I/O Device (VIRTIO) TC.
>
> In order to verify user consent to the Feedback License terms and
> to minimize spam in the list archive, subscription is required
> before posting.
>
> Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> List help: virtio-comment-help@lists.oasis-open.org
> List archive: https://lists.oasis-open.org/archives/virtio-comment/
> Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
> List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
> Committee: https://www.oasis-open.org/committees/virtio/
> Join OASIS: https://www.oasis-open.org/join/
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

