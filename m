Return-Path: <virtio-dev-return-12959-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51AE9EB64DA
	for <virtio-dev@archiver.kernel.org>; Mon, 19 Jun 2023 14:25:46 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 77F9094AAD
	for <virtio-dev@archiver.kernel.org>; Mon, 19 Jun 2023 14:25:45 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 49FAC986430
	for <virtio-dev@archiver.kernel.org>; Mon, 19 Jun 2023 14:25:45 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 2295D986397; Mon, 19 Jun 2023 14:25:45 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0F28898639E
	for <virtio-dev@lists.oasis-open.org>; Mon, 19 Jun 2023 14:25:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 9RcjTN8tO5WdNt91JmRMVQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687184742; x=1689776742;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f0MhPpftw5piCr2ASxb1OYE83bFaKqjYcppSqiKo8rA=;
        b=EdbdGXfTlVc7Eo0TOeueR2eio0aYz4ZSbk6nnDPXIpz9tc7yu8PgM5+jA5bcZ66uMM
         d/GFivd24ABV0Ia34D9wX1//1oTZTKntPp5qlTmtMfZaWLZOPnDb/zLTsj7rAO5/Gesm
         t5qg3O2u2sucG5aQwcbSZ6otO3WAATQkKyzbnm86TOl8eHVFeZIBNi5T8NNfHPh3cy5B
         eWrhhlaa7KQ8DRvbWLB8zAd4zr2RY7KzbitFDZmB72l/dMCqdti2OxqEvVdWP9BP7MkI
         EWiMJtr+pdbiN3gkcus3msCtG0MWbovYrmevQmtaovjuGacIdtXaGguolGJ8cs2WSn3r
         RCTg==
X-Gm-Message-State: AC+VfDyUgpn5sWVarC+MUK8MV9IWa+cyRu9/mziZfKHiGRuPlFru94I4
	fXqPuP0DpBZQ3JZ7wtFS98BehYZyChWN2brxS9uIUul24q+N/iM6BZchLCxLdwNk4SoMUoZeHfB
	eHNLxrCBNDMrI9F8ySyzznv/LPKAN
X-Received: by 2002:adf:f081:0:b0:311:1853:8a98 with SMTP id n1-20020adff081000000b0031118538a98mr5882639wro.60.1687184741842;
        Mon, 19 Jun 2023 07:25:41 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5w65mcvue1nM1KEI+qr7Sz0xz+gnRoJGmKR+tqyI3fECiUtvaBEFN5Rvh2csbQpz0NW2/OQQ==
X-Received: by 2002:adf:f081:0:b0:311:1853:8a98 with SMTP id n1-20020adff081000000b0031118538a98mr5882628wro.60.1687184741513;
        Mon, 19 Jun 2023 07:25:41 -0700 (PDT)
Date: Mon, 19 Jun 2023 10:25:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org,
	Parav Pandit <parav@nvidia.com>, Jason Wang <jasowang@redhat.com>
Message-ID: <20230619102132-mutt-send-email-mst@kernel.org>
References: <1686550355.2503424-1-xuanzhuo@linux.alibaba.com>
 <20230612022526-mutt-send-email-mst@kernel.org>
 <1686569235.2395291-1-xuanzhuo@linux.alibaba.com>
 <20230613045854-mutt-send-email-mst@kernel.org>
 <1686810211.4567776-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <1686810211.4567776-1-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] Re: About custom device counter

On Thu, Jun 15, 2023 at 02:23:31PM +0800, Xuan Zhuo wrote:
> On Tue, 13 Jun 2023 05:02:01 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Mon, Jun 12, 2023 at 07:27:15PM +0800, Xuan Zhuo wrote:
> > > On Mon, 12 Jun 2023 02:25:42 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > On Mon, Jun 12, 2023 at 02:12:35PM +0800, Xuan Zhuo wrote:
> > > > > We hope to support device custom counter. That is, virtio spec provides a
> > > > > channel for driver and device, and both key and value are provided by device.
> > > > >
> > > > > We discussed this issue earlier, and after some internal practice, I think it is
> > > > > still necessary to discuss this again.
> > > > >
> > > > > It is very important, each cloud vendor will always have some special counters,
> > > > > these counters may not exist in another vendor. At the same time, if we have
> > > > > to discuss it in the spec every time we add a counter, or add a feature, I
> > > > > think it is very inconvenient. Manufacturers may add some new counters at any
> > > > > time based on some new requirements. Some counters may also be removed at any
> > > > > time.
> > > > >
> > > > > Of course I know that doing this might hurt migration. But what I want to say is,
> > > > > why does it affect live migration? These counters we plan to give to users
> > > > > through ethtool -S, and some changes have taken place in the ethtool counters
> > > > > output by users. Does this have any practical impact? Or do we directly use
> > > > > some other output in a way, we can clearly tell the user that these counters
> > > > > may change during the migration process. For example, the driver is migrated
> > > > > to some new devices. These devices support some new counters. I think users
> > > > > should be able to see these new counters. These new counters may be the
> > > > > purpose of the migration.
> > > > >
> > > > > We don't need to support live migration at this point.
> > > > >
> > > > > Thanks.
> > > >
> > > >
> > > > Why not just document the thing?
> > >
> > > Device Counter or Device Stat, we discussed this issue earlier,
> > > So I want to slove the problem migration firstly.
> > >
> > >
> > > Thanks.
> >
> > Sorry have trouble parsing this.
> >
> > Can we get examples of counters from various vendors, so that
> > it's clear what kind of thing this, and it becomes convincing
> > that abstracting this in virtio spec is pointless?
> 
> Such as "limit", in a cloud scenario, multiple users purchase different VMs, and
> these VMs share the capabilities of the same host. In order to ensure that each
> VM will not affect others, the network card(virtio-net) capability of each VM is
> limited. When these users purchase VMs, this limit has already been determined.
> So if the network card traffic of a vm exceeds the upper limit, packet loss will
> occur. It is necessary for us to count these packet losses. And the device
> should expose to the user.
> 
> 
> Such as "session", our dpu supports tcp connection tracking, but there is an
> upper limit to the number of connections, and if it exceeds, packet loss will
> also occur.
> 
> These are two commonly used scenarios, I hope they can help you.
> 
> Thanks.


So not a counter at all really. More a capability.

My rule of thumb is that if something can be relevant to multiple
vendors then it should not be a vendor specific capaiblity.
What you have described can easily apply to a software
virtio imlementation, so it's relevant for multiple
vendors.

So please try to add this to the spec as a generic capability.
Yes adding vendor specific extensions is of course less work
for vendors. But the ecosystem is only strong if everyone is
working on the same spec and codebase.

> 
> >
> > Also, am I right assuming that in virtualized settings this is mostly
> > relevant for hosts? E.g. guests see a vendor neutral virtio but
> > host wants to figure out source of issues?
> >
> >
> >
> >
> > >
> > > >
> > > > --
> > > > MST
> > > >
> > > >
> > > > This publicly archived list offers a means to provide input to the
> > > > OASIS Virtual I/O Device (VIRTIO) TC.
> > > >
> > > > In order to verify user consent to the Feedback License terms and
> > > > to minimize spam in the list archive, subscription is required
> > > > before posting.
> > > >
> > > > Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> > > > Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> > > > List help: virtio-comment-help@lists.oasis-open.org
> > > > List archive: https://lists.oasis-open.org/archives/virtio-comment/
> > > > Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
> > > > List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
> > > > Committee: https://www.oasis-open.org/committees/virtio/
> > > > Join OASIS: https://www.oasis-open.org/join/
> > > >
> >


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

