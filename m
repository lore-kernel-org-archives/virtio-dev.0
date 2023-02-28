Return-Path: <virtio-dev-return-11332-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26F00C64ED6
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Feb 2023 08:52:54 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 435E92B055
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Feb 2023 08:52:54 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 20B5F986633
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Feb 2023 08:52:54 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 015879865FA; Tue, 28 Feb 2023 08:52:54 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E2DB6986601
	for <virtio-dev@lists.oasis-open.org>; Tue, 28 Feb 2023 08:52:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: mMokU9kfOY-K-_R5LBgGug-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677574369;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QvpdkuEVj/Tbsc2NUBxGwqBYY3TbWHOLagj6J2WbxlA=;
        b=ga2d8ak9rUaizH5Hed5MUDDwuF/sSQYyIuNYIOTnZN+dtcvgh+inq1XQA647vQI6f1
         sMhuv3aRvqVwFYKYUjivjfaqnDNDSnm9kZW1jUL9U8+tuUlIKtuVQ+DLz0nd9T+JUFXM
         H9yY5pEXn5cnne02XjTKgghw2yxfRBtnqEffnvgCkdaa4hgm0DOjcWZL3Zm7poxHCyOd
         xtF3pg1PZEow6BF6gkDEnezszMzs4XMjDGJ1o9+CE8WnRZqiK4HKCkE1tpD371g+v7Dp
         tPwMo9CptegmJDUiCGE/dZgRBg3OL0/MrW3svnHJnDy7AkShPRdTuaE0+UXKEdUI22zs
         RJDw==
X-Gm-Message-State: AO0yUKWseGC/PyzEk5GmiX0T6URjvDGfn9O6dblbd8JRvTcz0ldygQoa
	uij3qZqV/Ru0RUysHrG5j8XEo3L/wNmAtl6nBXkrTMwbjQqhFe4fes3HT4fG4/W5aRZ4VvEoYPg
	SJd5WgZncAt1nVc1qWKCdahWgkfR7
X-Received: by 2002:a17:906:aac4:b0:8b2:d30:e721 with SMTP id kt4-20020a170906aac400b008b20d30e721mr1530376ejb.71.1677574368823;
        Tue, 28 Feb 2023 00:52:48 -0800 (PST)
X-Google-Smtp-Source: AK7set/HgoFjQ91OOynBgU4af8K08PZYiN6P+tIq9v63Tlqjji7DuMeMqcWBBWGtlg97DevWOiwf/w==
X-Received: by 2002:a17:906:aac4:b0:8b2:d30:e721 with SMTP id kt4-20020a170906aac400b008b20d30e721mr1530363ejb.71.1677574368549;
        Tue, 28 Feb 2023 00:52:48 -0800 (PST)
Date: Tue, 28 Feb 2023 03:52:44 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, virtio-comment@lists.oasis-open.org,
	virtio-dev@lists.oasis-open.org, Parav Pandit <parav@nvidia.com>,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Message-ID: <20230228034620-mutt-send-email-mst@kernel.org>
References: <0f53212f-a89b-ad3c-73e3-a7a7b5533058@linux.alibaba.com>
 <1047920c-5dd5-8f31-0c4c-a108f36155f8@redhat.com>
 <20230223075934-mutt-send-email-mst@kernel.org>
 <CACGkMEvc2Px_Zz11R5QYwMXYm_j5rsYV2LrZt5yf8tZQxuT_Bg@mail.gmail.com>
 <20230224030509-mutt-send-email-mst@kernel.org>
 <CACGkMEuOu=6qKQO2TJ0B6ZLRH_-rGtZMYVtw7gn+BFbnJgWkrw@mail.gmail.com>
 <20230227023657-mutt-send-email-mst@kernel.org>
 <CACGkMEtOFC-xygzgECi82j4Q6PacpjVnyPMs1Q6c9PN0RfX5bw@mail.gmail.com>
 <20230227124800-mutt-send-email-mst@kernel.org>
 <CACGkMEvUaQuzMx4iwkaYg9t9Bz2Ev0eHAwgrWbNEwtQHZOkkvQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEvUaQuzMx4iwkaYg9t9Bz2Ev0eHAwgrWbNEwtQHZOkkvQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [PATCH v9] virtio-net: support inner header hash
Message-ID: <20230228085244.tnCcr9V-PYFZmmpApqkkOGMAULgKQI7B4KDZtL3NjKU@z>

On Tue, Feb 28, 2023 at 11:04:26AM +0800, Jason Wang wrote:
> On Tue, Feb 28, 2023 at 1:49 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Feb 27, 2023 at 04:35:09PM +0800, Jason Wang wrote:
> > > On Mon, Feb 27, 2023 at 3:39 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Mon, Feb 27, 2023 at 12:07:17PM +0800, Jason Wang wrote:
> > > > > Btw, this kind of 1:1 hash features seems not scalable and flexible.
> > > > > It requires an endless extension on bits/fields. Modern NICs allow the
> > > > > user to customize the hash calculation, for virtio-net we can allow to
> > > > > use eBPF program to classify the packets. It seems to be more flexible
> > > > > and scalable and there's almost no maintain burden in the spec (only
> > > > > bytecode is required, no need any fancy features/interactions like
> > > > > maps), easy to be migrated etc.
> > > > >
> > > > > Prototype is also easy, tun/tap had an eBPF classifier for years.
> > > > >
> > > > > Thanks
> > > >
> > > > Yea BPF offload would be great to have. We have been discussing it for
> > > > years though - security issues keep blocking it. *Maybe* it's finally
> > > > going to be there but I'm not going to block this work waiting for BPF
> > > > offload.  And easily migrated is what BPF is not.
> > >
> > > Just to make sure we're at the same page. I meant to find a way to
> > > allow the driver/user to fully customize what it wants to
> > > hash/classify. Similar technologies which is based on private solution
> > > has been used by some vendors, which allow user to customize the
> > > classifier[1]
> > >
> > > ePBF looks like a good open-source solution candidate for this (there
> > > could be others). But there could be many kinds of eBPF programs that
> > > could be offloaded. One famous one is XDP which requires many features
> > > other than the bytecode/VM like map access, tailcall. Starting from
> > > such a complicated type is hard. Instead, we can start from a simple
> > > type, that is the eBPF classifier. All it needs is to pass the
> > > bytecode to the device, the device can choose to run it or compile it
> > > to what it can understand for classifying. We don't need maps, tail
> > > calls and other features.
> >
> > Until people start asking exactly for maps because they want
> > state for their classifier?
> 
> Yes, but let's compare the eBPF without maps with the static feature
> proposed here. It is much more scalable and flexible.
> 
> > And it makes sense - if you want
> > e.g. load balancing you need stats which needs maps.
> 
> Yes, but we know it's possible to have that (through the XDP offload).
> This is impossible with the approach proposed here.

I'm not actually objecting. And at least we then don't need to
worry about leaking info - it's not virtio leaking info
it's the bpf program. I wonder what does Heng Qi think.
Heng Qi would it work for your scenario?

> >
> > > We don't need to worry about the security
> > > because of its simplicity: the eBPF program is only in charge of doing
> > > classification, no other interactions with the driver and packet
> > > modification is prohibited. The feature is limited only to the
> > > VM/bytecode abstraction itself.
> > >
> > > What's more, it's a good first step to achieve full eBPF offloading in
> > > the future.
> > >
> > > Thanks
> > >
> > > [1] https://www.intel.com/content/www/us/en/architecture-and-technology/ethernet/dynamic-device-personalization-brief.html
> >
> > Dave seems to have nacked this approach, no?
> 
> I may miss something but looking at kernel commit, there are few
> patches to support that:
> 
> E.g
> 
> commit c7648810961682b9388be2dd041df06915647445
> Author: Tony Nguyen <anthony.l.nguyen@intel.com>
> Date:   Mon Sep 9 06:47:44 2019 -0700
> 
>     ice: Implement Dynamic Device Personalization (DDP) download
> 
> And it has been used by DPDK drivers.
> 
> Thanks

If we are talking about netdev then this discussion has to take place on netdev.
If it's dpdk this is more believable.

> >
> > > >
> > > > --
> > > > MST
> > > >
> >


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

