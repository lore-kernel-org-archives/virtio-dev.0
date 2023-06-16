Return-Path: <virtio-dev-return-12954-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DA33EB64D8
	for <virtio-dev@archiver.kernel.org>; Fri, 16 Jun 2023 14:42:19 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 6D94A1CA24B
	for <virtio-dev@archiver.kernel.org>; Fri, 16 Jun 2023 14:42:18 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5D15398680B
	for <virtio-dev@archiver.kernel.org>; Fri, 16 Jun 2023 14:42:18 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 4EF9C986801; Fri, 16 Jun 2023 14:42:18 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3C3AD986802
	for <virtio-dev@lists.oasis-open.org>; Fri, 16 Jun 2023 14:42:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: zn_j1nC2MBukupP8hG_bSg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686926534; x=1689518534;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QJIWpMmlgHZqtKSM5xvEwCKZKGLUc0Hwta3F6st9/oU=;
        b=a0izYp/frdkEhpaRtVDOyMWf7lPV6CadMg7gWQ0ZuYw+XkSKT6IX6oCERLZ3dRHKub
         iPK2tmMQSTEfi+k9QjWVcQccVMwbog/V+8akoGxcfm7OwIVxJrJAaRfEDdT92X7+75zB
         l1ZbOj3w/kQrZe75kAjfkKpbnEk3qVXUZpDjkLjCGclQzjkGtUZg4d+CfL430uNQ81ge
         +ZHlEZzPHlihVRdozAwzZnTxuU31g5DV8D1gjLqwSGDzwytre0mjnrjDL6QMX3vK8XbI
         jZcP1aqduO5kNaFFvPslgd94GLH0DHucKrCtaOxvqnLiJyC2Cd2kIbp8CtCFFxH/sfM3
         NqoQ==
X-Gm-Message-State: AC+VfDyFc/O/VITETNmXMNeeLx23lEt2hEc7wbThEtMHE/ScIIc56J8t
	eXkWhrUuo0fUlD4iVFQIVF0QIER9eJVo7n6G+WP1lLX+9/3VBfLwF/K7nwFbJmiWJFP0X7HB497
	u4RKJTB1jS6W7VpMbY0z57PTzJPKb
X-Received: by 2002:a5d:4ec8:0:b0:306:43ad:b34e with SMTP id s8-20020a5d4ec8000000b0030643adb34emr1341069wrv.18.1686926534689;
        Fri, 16 Jun 2023 07:42:14 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4AgDh79H7fodSjPNEp+rEsxzvahNGfBufoJlGPLq9yZb1yuL6TXAFicBgiye2hSkyIAryczg==
X-Received: by 2002:a5d:4ec8:0:b0:306:43ad:b34e with SMTP id s8-20020a5d4ec8000000b0030643adb34emr1341061wrv.18.1686926534338;
        Fri, 16 Jun 2023 07:42:14 -0700 (PDT)
Date: Fri, 16 Jun 2023 10:42:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Jason Wang <jasowang@redhat.com>, virtio-dev@lists.oasis-open.org,
	virtio-comment@lists.oasis-open.org,
	Parav Pandit <parav@nvidia.com>
Message-ID: <20230616104141-mutt-send-email-mst@kernel.org>
References: <1686550355.2503424-1-xuanzhuo@linux.alibaba.com>
 <20230612022526-mutt-send-email-mst@kernel.org>
 <1686569235.2395291-1-xuanzhuo@linux.alibaba.com>
 <20230613045854-mutt-send-email-mst@kernel.org>
 <1686810211.4567776-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEta1nU__CJTNLQzK1F7nShLgpPWT4eXwkFD=eA1ph+iow@mail.gmail.com>
 <1686879405.6211739-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <1686879405.6211739-1-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [virtio-comment] Re: About custom device counter

On Fri, Jun 16, 2023 at 09:36:45AM +0800, Xuan Zhuo wrote:
> On Fri, 16 Jun 2023 08:57:01 +0800, Jason Wang <jasowang@redhat.com> wrote:
> > On Thu, Jun 15, 2023 at 2:34 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> > >
> > > On Tue, 13 Jun 2023 05:02:01 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > On Mon, Jun 12, 2023 at 07:27:15PM +0800, Xuan Zhuo wrote:
> > > > > On Mon, 12 Jun 2023 02:25:42 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > > > On Mon, Jun 12, 2023 at 02:12:35PM +0800, Xuan Zhuo wrote:
> > > > > > > We hope to support device custom counter. That is, virtio spec provides a
> > > > > > > channel for driver and device, and both key and value are provided by device.
> > > > > > >
> > > > > > > We discussed this issue earlier, and after some internal practice, I think it is
> > > > > > > still necessary to discuss this again.
> > > > > > >
> > > > > > > It is very important, each cloud vendor will always have some special counters,
> > > > > > > these counters may not exist in another vendor. At the same time, if we have
> > > > > > > to discuss it in the spec every time we add a counter, or add a feature, I
> > > > > > > think it is very inconvenient. Manufacturers may add some new counters at any
> > > > > > > time based on some new requirements. Some counters may also be removed at any
> > > > > > > time.
> > > > > > >
> > > > > > > Of course I know that doing this might hurt migration. But what I want to say is,
> > > > > > > why does it affect live migration? These counters we plan to give to users
> > > > > > > through ethtool -S, and some changes have taken place in the ethtool counters
> > > > > > > output by users. Does this have any practical impact? Or do we directly use
> > > > > > > some other output in a way, we can clearly tell the user that these counters
> > > > > > > may change during the migration process. For example, the driver is migrated
> > > > > > > to some new devices. These devices support some new counters. I think users
> > > > > > > should be able to see these new counters. These new counters may be the
> > > > > > > purpose of the migration.
> > > > > > >
> > > > > > > We don't need to support live migration at this point.
> > > > > > >
> > > > > > > Thanks.
> > > > > >
> > > > > >
> > > > > > Why not just document the thing?
> > > > >
> > > > > Device Counter or Device Stat, we discussed this issue earlier,
> > > > > So I want to slove the problem migration firstly.
> > > > >
> > > > >
> > > > > Thanks.
> > > >
> > > > Sorry have trouble parsing this.
> > > >
> > > > Can we get examples of counters from various vendors, so that
> > > > it's clear what kind of thing this, and it becomes convincing
> > > > that abstracting this in virtio spec is pointless?
> > >
> > > Such as "limit", in a cloud scenario, multiple users purchase different VMs, and
> > > these VMs share the capabilities of the same host. In order to ensure that each
> > > VM will not affect others, the network card(virtio-net) capability of each VM is
> > > limited. When these users purchase VMs, this limit has already been determined.
> > > So if the network card traffic of a vm exceeds the upper limit, packet loss will
> > > occur. It is necessary for us to count these packet losses. And the device
> > > should expose to the user.
> > >
> > >
> > > Such as "session", our dpu supports tcp connection tracking, but there is an
> > > upper limit to the number of connections, and if it exceeds, packet loss will
> > > also occur.
> > >
> > > These are two commonly used scenarios, I hope they can help you.
> >
> > But you didn't explain why these can't be abstracted in the virtio spec?
> 
> 
> As far as I know, there are no such concepts, and I don't like to force these
> concepts to be abstracted.
> 
> Instead of forcing abstraction, I think it is more convenient to directly
> provide a vendor channel.
> 
> Thanks.

Bypassing standartiziation always seems convenient short term.


> 
> >
> > Thanks
> >
> > >
> > > Thanks.
> > >
> > >
> > > >
> > > > Also, am I right assuming that in virtualized settings this is mostly
> > > > relevant for hosts? E.g. guests see a vendor neutral virtio but
> > > > host wants to figure out source of issues?
> > > >
> > > >
> > > >
> > > >
> > > > >
> > > > > >
> > > > > > --
> > > > > > MST
> > > > > >
> > > > > >
> > > > > > This publicly archived list offers a means to provide input to the
> > > > > > OASIS Virtual I/O Device (VIRTIO) TC.
> > > > > >
> > > > > > In order to verify user consent to the Feedback License terms and
> > > > > > to minimize spam in the list archive, subscription is required
> > > > > > before posting.
> > > > > >
> > > > > > Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> > > > > > Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> > > > > > List help: virtio-comment-help@lists.oasis-open.org
> > > > > > List archive: https://lists.oasis-open.org/archives/virtio-comment/
> > > > > > Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
> > > > > > List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
> > > > > > Committee: https://www.oasis-open.org/committees/virtio/
> > > > > > Join OASIS: https://www.oasis-open.org/join/
> > > > > >
> > > >
> > >
> >


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

