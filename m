Return-Path: <virtio-dev-return-11321-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAF14C64ED8
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Feb 2023 17:50:29 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id A262A29FFE
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Feb 2023 17:50:26 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 190439867B8
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Feb 2023 17:50:26 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 790579864DB; Mon, 27 Feb 2023 17:50:25 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A2BF598658A
	for <virtio-dev@lists.oasis-open.org>; Mon, 27 Feb 2023 17:49:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: GvDrNdYBOnuLijmV0IHkGw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ook93pASaGN31vrFLc56hM1V/fGdzB6QV9H0FwGKOIE=;
        b=Vevt1ugprbO20qF1z3q/NqYeAoJv9+4T/udrM1exZDYiI7sI/79eRRJVmryzBg/OCv
         v1j4HsoFavNlsW+aUJPtybPrM+S5/YAQl2FSxjAN7M1gnG/CnGqI5FBpJjn1oij4r7aI
         E2UaCOd3+YW3lZPzrZcLvMhDtgxfvUajBy2EWui8TF4IQyvdyAX3HHdk45DEOgASCIt3
         hk2M5WXfFqR2oIY5LuQeRQycyhAEZfKqTvWSJYk8WePK0cq4pOfLij21CFImLts5nL11
         2YXfKH8FOp/cJKEGNyRMA5W131/VxrzsXjam40z6QDixi7Z5nb6wsYAgU1owcuYqGf1G
         qOxw==
X-Gm-Message-State: AO0yUKXqru2LihfZaczQJR1HHypfCPJHVVIJBpJ9P+qkziMh/55AXAGz
	1O7JVRDLxyk4LGSXM6ej5bR+pmp7bPQBafxfcXDELdFc/hjkUGt8lVYUr9ELHnLdofKmf7W0KFI
	4IACuadHO9f7cvkhck2CP4K0gaVrM
X-Received: by 2002:a05:600c:30d2:b0:3eb:3692:644e with SMTP id h18-20020a05600c30d200b003eb3692644emr5835282wmn.33.1677520170310;
        Mon, 27 Feb 2023 09:49:30 -0800 (PST)
X-Google-Smtp-Source: AK7set8X1kpJZHdtraGg0s3QYrrTdXiyhtzE/YpEqdVW0EE/Ob10M0pWvZDUPMdk1Fc6UHqIwHbkdg==
X-Received: by 2002:a05:600c:30d2:b0:3eb:3692:644e with SMTP id h18-20020a05600c30d200b003eb3692644emr5835268wmn.33.1677520170016;
        Mon, 27 Feb 2023 09:49:30 -0800 (PST)
Date: Mon, 27 Feb 2023 12:49:26 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, virtio-comment@lists.oasis-open.org,
	virtio-dev@lists.oasis-open.org, Parav Pandit <parav@nvidia.com>,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Message-ID: <20230227124800-mutt-send-email-mst@kernel.org>
References: <20230221124518-mutt-send-email-mst@kernel.org>
 <4d123e32-1ad0-e692-7fa6-0565eb34c487@redhat.com>
 <0f53212f-a89b-ad3c-73e3-a7a7b5533058@linux.alibaba.com>
 <1047920c-5dd5-8f31-0c4c-a108f36155f8@redhat.com>
 <20230223075934-mutt-send-email-mst@kernel.org>
 <CACGkMEvc2Px_Zz11R5QYwMXYm_j5rsYV2LrZt5yf8tZQxuT_Bg@mail.gmail.com>
 <20230224030509-mutt-send-email-mst@kernel.org>
 <CACGkMEuOu=6qKQO2TJ0B6ZLRH_-rGtZMYVtw7gn+BFbnJgWkrw@mail.gmail.com>
 <20230227023657-mutt-send-email-mst@kernel.org>
 <CACGkMEtOFC-xygzgECi82j4Q6PacpjVnyPMs1Q6c9PN0RfX5bw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEtOFC-xygzgECi82j4Q6PacpjVnyPMs1Q6c9PN0RfX5bw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [PATCH v9] virtio-net: support inner header hash
Message-ID: <20230227174926.pHh8VYKmtbKkrr5VCT6XggJkhbOOkB2GDpiy1RTm1HI@z>

On Mon, Feb 27, 2023 at 04:35:09PM +0800, Jason Wang wrote:
> On Mon, Feb 27, 2023 at 3:39 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Feb 27, 2023 at 12:07:17PM +0800, Jason Wang wrote:
> > > Btw, this kind of 1:1 hash features seems not scalable and flexible.
> > > It requires an endless extension on bits/fields. Modern NICs allow the
> > > user to customize the hash calculation, for virtio-net we can allow to
> > > use eBPF program to classify the packets. It seems to be more flexible
> > > and scalable and there's almost no maintain burden in the spec (only
> > > bytecode is required, no need any fancy features/interactions like
> > > maps), easy to be migrated etc.
> > >
> > > Prototype is also easy, tun/tap had an eBPF classifier for years.
> > >
> > > Thanks
> >
> > Yea BPF offload would be great to have. We have been discussing it for
> > years though - security issues keep blocking it. *Maybe* it's finally
> > going to be there but I'm not going to block this work waiting for BPF
> > offload.  And easily migrated is what BPF is not.
> 
> Just to make sure we're at the same page. I meant to find a way to
> allow the driver/user to fully customize what it wants to
> hash/classify. Similar technologies which is based on private solution
> has been used by some vendors, which allow user to customize the
> classifier[1]
> 
> ePBF looks like a good open-source solution candidate for this (there
> could be others). But there could be many kinds of eBPF programs that
> could be offloaded. One famous one is XDP which requires many features
> other than the bytecode/VM like map access, tailcall. Starting from
> such a complicated type is hard. Instead, we can start from a simple
> type, that is the eBPF classifier. All it needs is to pass the
> bytecode to the device, the device can choose to run it or compile it
> to what it can understand for classifying. We don't need maps, tail
> calls and other features.

Until people start asking exactly for maps because they want
state for their classifier? And it makes sense - if you want
e.g. load balancing you need stats which needs maps.

> We don't need to worry about the security
> because of its simplicity: the eBPF program is only in charge of doing
> classification, no other interactions with the driver and packet
> modification is prohibited. The feature is limited only to the
> VM/bytecode abstraction itself.
> 
> What's more, it's a good first step to achieve full eBPF offloading in
> the future.
> 
> Thanks
> 
> [1] https://www.intel.com/content/www/us/en/architecture-and-technology/ethernet/dynamic-device-personalization-brief.html

Dave seems to have nacked this approach, no?

> >
> > --
> > MST
> >


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

