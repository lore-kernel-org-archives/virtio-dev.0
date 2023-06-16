Return-Path: <virtio-dev-return-12951-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6A8BEB64DB
	for <virtio-dev@archiver.kernel.org>; Fri, 16 Jun 2023 00:57:21 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id EBB3C60366
	for <virtio-dev@archiver.kernel.org>; Fri, 16 Jun 2023 00:57:20 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E2DB398680A
	for <virtio-dev@archiver.kernel.org>; Fri, 16 Jun 2023 00:57:20 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id D6A5B986800; Fri, 16 Jun 2023 00:57:20 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BF7579867FF
	for <virtio-dev@lists.oasis-open.org>; Fri, 16 Jun 2023 00:57:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 0UjDdnhYOaKDfD-PBVh-2g-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686877033; x=1689469033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H/JfajNV7HUXrKewKDgAMP1gV0GPYdYh+HuHOct5u/I=;
        b=ZWX7PDd6Xwns5EkzHOpRCvy2z5e2D1OvR6Oumso0PJZWCJ/4QZObWfUrYssjuosdFJ
         /Cx/WdIiXEKsC/58R8uOfAV9CJBs1yBc7DcydZ+GZqQqmLd0supjPUGJfcE2Lm2znr6M
         uxpO9+mNBnmwVk5N7pW63DJG8iptpQH71Jyup6gC8FvEMyES2MeeOgS+s0UerPz6zZcX
         PXCBKEyvu/OFs9QlLS9EPRLm+coPsNCpKY8JTxDqIKx6BGn2N9h7jYqjVE2lfi/01eJt
         1un1v24pO3MH8OQ2uZhwHlQR8pzMhGbEgxyTBBiMx09eNSIigIUhBR3+0qB8N9sbEOgK
         imuA==
X-Gm-Message-State: AC+VfDyB8IVXak3idC8uJtRtM71fXSsqOT7FzRnFD77c1qLg9+uB9AMI
	eNsgqLSjT3Mnn1BkHQDzLTJCvG/xw87W5+0Ik8chiguuKwkmPPq2kgAslyT6O1YPunt9Z53xUw0
	I+eq0pJSeOzv0XAx53819iOzVAaW66k0t9cSFU5ktm34A
X-Received: by 2002:a2e:9684:0:b0:2b1:e6eb:1fdf with SMTP id q4-20020a2e9684000000b002b1e6eb1fdfmr642652lji.42.1686877033578;
        Thu, 15 Jun 2023 17:57:13 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7Gy8g3zVLd8uP5A+CqnuQFgz7wLA/bSHMjEmJH7a2r6SwWEYBdZ1kxegCy2WOLHfJrP/onfGVLsSuqGDRbNkg=
X-Received: by 2002:a2e:9684:0:b0:2b1:e6eb:1fdf with SMTP id
 q4-20020a2e9684000000b002b1e6eb1fdfmr642642lji.42.1686877033135; Thu, 15 Jun
 2023 17:57:13 -0700 (PDT)
MIME-Version: 1.0
References: <1686550355.2503424-1-xuanzhuo@linux.alibaba.com>
 <20230612022526-mutt-send-email-mst@kernel.org> <1686569235.2395291-1-xuanzhuo@linux.alibaba.com>
 <20230613045854-mutt-send-email-mst@kernel.org> <1686810211.4567776-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1686810211.4567776-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 16 Jun 2023 08:57:01 +0800
Message-ID: <CACGkMEta1nU__CJTNLQzK1F7nShLgpPWT4eXwkFD=eA1ph+iow@mail.gmail.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtio-dev@lists.oasis-open.org, 
	virtio-comment@lists.oasis-open.org, Parav Pandit <parav@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [virtio-comment] Re: About custom device counter

On Thu, Jun 15, 2023 at 2:34=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Tue, 13 Jun 2023 05:02:01 -0400, "Michael S. Tsirkin" <mst@redhat.com>=
 wrote:
> > On Mon, Jun 12, 2023 at 07:27:15PM +0800, Xuan Zhuo wrote:
> > > On Mon, 12 Jun 2023 02:25:42 -0400, "Michael S. Tsirkin" <mst@redhat.=
com> wrote:
> > > > On Mon, Jun 12, 2023 at 02:12:35PM +0800, Xuan Zhuo wrote:
> > > > > We hope to support device custom counter. That is, virtio spec pr=
ovides a
> > > > > channel for driver and device, and both key and value are provide=
d by device.
> > > > >
> > > > > We discussed this issue earlier, and after some internal practice=
, I think it is
> > > > > still necessary to discuss this again.
> > > > >
> > > > > It is very important, each cloud vendor will always have some spe=
cial counters,
> > > > > these counters may not exist in another vendor. At the same time,=
 if we have
> > > > > to discuss it in the spec every time we add a counter, or add a f=
eature, I
> > > > > think it is very inconvenient. Manufacturers may add some new cou=
nters at any
> > > > > time based on some new requirements. Some counters may also be re=
moved at any
> > > > > time.
> > > > >
> > > > > Of course I know that doing this might hurt migration. But what I=
 want to say is,
> > > > > why does it affect live migration? These counters we plan to give=
 to users
> > > > > through ethtool -S, and some changes have taken place in the etht=
ool counters
> > > > > output by users. Does this have any practical impact? Or do we di=
rectly use
> > > > > some other output in a way, we can clearly tell the user that the=
se counters
> > > > > may change during the migration process. For example, the driver =
is migrated
> > > > > to some new devices. These devices support some new counters. I t=
hink users
> > > > > should be able to see these new counters. These new counters may =
be the
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
> Such as "limit", in a cloud scenario, multiple users purchase different V=
Ms, and
> these VMs share the capabilities of the same host. In order to ensure tha=
t each
> VM will not affect others, the network card(virtio-net) capability of eac=
h VM is
> limited. When these users purchase VMs, this limit has already been deter=
mined.
> So if the network card traffic of a vm exceeds the upper limit, packet lo=
ss will
> occur. It is necessary for us to count these packet losses. And the devic=
e
> should expose to the user.
>
>
> Such as "session", our dpu supports tcp connection tracking, but there is=
 an
> upper limit to the number of connections, and if it exceeds, packet loss =
will
> also occur.
>
> These are two commonly used scenarios, I hope they can help you.

But you didn't explain why these can't be abstracted in the virtio spec?

Thanks

>
> Thanks.
>
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
> > > > Feedback License: https://www.oasis-open.org/who/ipr/feedback_licen=
se.pdf
> > > > List Guidelines: https://www.oasis-open.org/policies-guidelines/mai=
ling-lists
> > > > Committee: https://www.oasis-open.org/committees/virtio/
> > > > Join OASIS: https://www.oasis-open.org/join/
> > > >
> >
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

