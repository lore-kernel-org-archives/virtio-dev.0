Return-Path: <virtio-dev-return-12955-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07D82EB64DA
	for <virtio-dev@archiver.kernel.org>; Mon, 19 Jun 2023 01:59:37 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id A2AD92AEC2
	for <virtio-dev@archiver.kernel.org>; Mon, 19 Jun 2023 01:59:36 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9267C9863BD
	for <virtio-dev@archiver.kernel.org>; Mon, 19 Jun 2023 01:59:36 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 817DD986382; Mon, 19 Jun 2023 01:59:36 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 674EF986396;
	Mon, 19 Jun 2023 01:59:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VlNhuZw_1687139969;
Message-ID: <1687139062.147956-1-xuanzhuo@linux.alibaba.com>
Date: Mon, 19 Jun 2023 09:44:22 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org,
 virtio-comment@lists.oasis-open.org,
 Parav Pandit <parav@nvidia.com>,
 Jason Wang <jasowang@redhat.com>
References: <1686550355.2503424-1-xuanzhuo@linux.alibaba.com>
 <20230612022526-mutt-send-email-mst@kernel.org>
 <1686569235.2395291-1-xuanzhuo@linux.alibaba.com>
 <20230613045854-mutt-send-email-mst@kernel.org>
 <1686810211.4567776-1-xuanzhuo@linux.alibaba.com>
 <20230616101113-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230616101113-mutt-send-email-mst@kernel.org>
Subject: [virtio-dev] Re: [virtio-comment] Re: About custom device counter

On Fri, 16 Jun 2023 10:13:23 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Thu, Jun 15, 2023 at 02:23:31PM +0800, Xuan Zhuo wrote:
> > On Tue, 13 Jun 2023 05:02:01 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > On Mon, Jun 12, 2023 at 07:27:15PM +0800, Xuan Zhuo wrote:
> > > > On Mon, 12 Jun 2023 02:25:42 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > > On Mon, Jun 12, 2023 at 02:12:35PM +0800, Xuan Zhuo wrote:
> > > > > > We hope to support device custom counter. That is, virtio spec provides a
> > > > > > channel for driver and device, and both key and value are provided by device.
> > > > > >
> > > > > > We discussed this issue earlier, and after some internal practice, I think it is
> > > > > > still necessary to discuss this again.
> > > > > >
> > > > > > It is very important, each cloud vendor will always have some special counters,
> > > > > > these counters may not exist in another vendor. At the same time, if we have
> > > > > > to discuss it in the spec every time we add a counter, or add a feature, I
> > > > > > think it is very inconvenient. Manufacturers may add some new counters at any
> > > > > > time based on some new requirements. Some counters may also be removed at any
> > > > > > time.
> > > > > >
> > > > > > Of course I know that doing this might hurt migration. But what I want to say is,
> > > > > > why does it affect live migration? These counters we plan to give to users
> > > > > > through ethtool -S, and some changes have taken place in the ethtool counters
> > > > > > output by users. Does this have any practical impact? Or do we directly use
> > > > > > some other output in a way, we can clearly tell the user that these counters
> > > > > > may change during the migration process. For example, the driver is migrated
> > > > > > to some new devices. These devices support some new counters. I think users
> > > > > > should be able to see these new counters. These new counters may be the
> > > > > > purpose of the migration.
> > > > > >
> > > > > > We don't need to support live migration at this point.
> > > > > >
> > > > > > Thanks.
> > > > >
> > > > >
> > > > > Why not just document the thing?
> > > >
> > > > Device Counter or Device Stat, we discussed this issue earlier,
> > > > So I want to slove the problem migration firstly.
> > > >
> > > >
> > > > Thanks.
> > >
> > > Sorry have trouble parsing this.
> > >
> > > Can we get examples of counters from various vendors, so that
> > > it's clear what kind of thing this, and it becomes convincing
> > > that abstracting this in virtio spec is pointless?
> >
> > Such as "limit", in a cloud scenario, multiple users purchase different VMs, and
> > these VMs share the capabilities of the same host. In order to ensure that each
> > VM will not affect others, the network card(virtio-net) capability of each VM is
> > limited. When these users purchase VMs, this limit has already been determined.
> > So if the network card traffic of a vm exceeds the upper limit, packet loss will
> > occur. It is necessary for us to count these packet losses. And the device
> > should expose to the user.
>
> OK so here, driver is expected to rate limit yes?

The counter is for the user, not for the driver. Let the user know that some
packets are dropped by rate limit. If they need more traffic, then users may
need to buy a larger network card.

The driver does not know about this.


>
> > Such as "session", our dpu supports tcp connection tracking, but there is an
> > upper limit to the number of connections, and if it exceeds, packet loss will
> > also occur.
>
> What can be done here? Just don't run so many apps?

This function will be used in some special scenarios, I am not particularly
sure. But we do have such a need.

I just gave two examples. In fact, there are many other scenarios. In the cloud
scenario, we still have many strange features for customers. We want to embrace
the virtio, so we're not trying to do something that isn't compliant, but we do
currently have the problem that in our backend, we have a lot of functionality
that can't be exposed to the driver or the guest os by the standard virtio
channels. This actually affects the use of the virtio standard in cloud vendors.
For example, some cloud manufacturers are turning to use custom equipment.

We believe that virtio/virtio-net should also accelerate its evolution and
become more modern, so as to meet the needs of the market.

Thanks.


>
> > These are two commonly used scenarios, I hope they can help you.
> >
> > Thanks.
> >
> >
> > >
> > > Also, am I right assuming that in virtualized settings this is mostly
> > > relevant for hosts? E.g. guests see a vendor neutral virtio but
> > > host wants to figure out source of issues?
> > >
> > >
> > >
> > >
> > > >
> > > > >
> > > > > --
> > > > > MST
> > > > >
> > > > >
> > > > > This publicly archived list offers a means to provide input to the
> > > > > OASIS Virtual I/O Device (VIRTIO) TC.
> > > > >
> > > > > In order to verify user consent to the Feedback License terms and
> > > > > to minimize spam in the list archive, subscription is required
> > > > > before posting.
> > > > >
> > > > > Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> > > > > Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> > > > > List help: virtio-comment-help@lists.oasis-open.org
> > > > > List archive: https://lists.oasis-open.org/archives/virtio-comment/
> > > > > Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
> > > > > List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
> > > > > Committee: https://www.oasis-open.org/committees/virtio/
> > > > > Join OASIS: https://www.oasis-open.org/join/
> > > > >
> > >
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

