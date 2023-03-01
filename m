Return-Path: <virtio-dev-return-11340-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 214CDC64EC7
	for <virtio-dev@archiver.kernel.org>; Wed,  1 Mar 2023 10:36:56 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id E646C41F0D
	for <virtio-dev@archiver.kernel.org>; Wed,  1 Mar 2023 10:36:55 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CDE61986672
	for <virtio-dev@archiver.kernel.org>; Wed,  1 Mar 2023 10:36:55 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id B3024986663; Wed,  1 Mar 2023 10:36:55 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8DE2A9866D6
	for <virtio-dev@lists.oasis-open.org>; Wed,  1 Mar 2023 10:36:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: JJHIYrjJOY6OGtT22ZsOTQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677667010;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=34l4UeWr1DvaXCS7IyjMEkRU8q3M7QJLOg0S3rrnSZM=;
        b=tA93O2xAIlcxU92/Sbg7tfoAH7jV64Pj2hMZBKNKOnPfmCADUcDOQrSRNndPur6J5y
         H27iCl2bSYluJTKJ/CNrCTGaLtG8vLIYuIbpYi3Cgi1LPgwcCcSdvSio/yi6zcoJpTU0
         1+m/eHIxPQlN++9t47hk1z6Ul27sGAt2JbyKgP13ANB6xZZVKz2yCiEq+qzoXjnKN6i6
         ZUaFKrwSXDITjUjtZaaJXsOpt74lQZ530dJA7uLIubVgBOtwniKJonFQz32WlqAo55ZN
         oZORWUDF74FryL8e7gt+bvg4dPM5b58gIMf7oA/xS56AEN3/qysmbBpkS/H/+23Xp36i
         u1CA==
X-Gm-Message-State: AO0yUKUWMGPuXr4v8/vSWFClfrsghZDWIH0UQR5hNChLE/cRBsnNm8nK
	4a2g9vuKKmrV9wJGgZ8TRMHfErmbj0PyJ9SDVgyCP31b8zJGFslG0kptzjgMa9M44Bcl8TvmAtA
	L0YPop2/xDYKaIM+LeLuQvgARlmzg
X-Received: by 2002:adf:ea52:0:b0:2c7:832:8cce with SMTP id j18-20020adfea52000000b002c708328ccemr4161062wrn.49.1677667010023;
        Wed, 01 Mar 2023 02:36:50 -0800 (PST)
X-Google-Smtp-Source: AK7set9zztxKc4NKFiC10A5LM059attFa1e+BQ9fknNIIm5WBI9QrFCIVbVRyN0Phg54IDe3P5hdKg==
X-Received: by 2002:adf:ea52:0:b0:2c7:832:8cce with SMTP id j18-20020adfea52000000b002c708328ccemr4161035wrn.49.1677667009618;
        Wed, 01 Mar 2023 02:36:49 -0800 (PST)
Date: Wed, 1 Mar 2023 05:36:45 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, virtio-comment@lists.oasis-open.org,
	virtio-dev@lists.oasis-open.org, Parav Pandit <parav@nvidia.com>,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Message-ID: <20230301053407-mutt-send-email-mst@kernel.org>
References: <20230223075934-mutt-send-email-mst@kernel.org>
 <CACGkMEvc2Px_Zz11R5QYwMXYm_j5rsYV2LrZt5yf8tZQxuT_Bg@mail.gmail.com>
 <20230224030509-mutt-send-email-mst@kernel.org>
 <CACGkMEuOu=6qKQO2TJ0B6ZLRH_-rGtZMYVtw7gn+BFbnJgWkrw@mail.gmail.com>
 <20230227023657-mutt-send-email-mst@kernel.org>
 <CACGkMEtOFC-xygzgECi82j4Q6PacpjVnyPMs1Q6c9PN0RfX5bw@mail.gmail.com>
 <20230227124800-mutt-send-email-mst@kernel.org>
 <CACGkMEvUaQuzMx4iwkaYg9t9Bz2Ev0eHAwgrWbNEwtQHZOkkvQ@mail.gmail.com>
 <20230228060352-mutt-send-email-mst@kernel.org>
 <CACGkMEvAGABhk6JX7+F-sDtRM7t1oONEz9wrgKM7iShmyYV34A@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEvAGABhk6JX7+F-sDtRM7t1oONEz9wrgKM7iShmyYV34A@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [PATCH v9] virtio-net: support inner header hash

On Wed, Mar 01, 2023 at 10:36:41AM +0800, Jason Wang wrote:
> On Tue, Feb 28, 2023 at 7:05 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Feb 28, 2023 at 11:04:26AM +0800, Jason Wang wrote:
> > > On Tue, Feb 28, 2023 at 1:49 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Mon, Feb 27, 2023 at 04:35:09PM +0800, Jason Wang wrote:
> > > > > On Mon, Feb 27, 2023 at 3:39 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > >
> > > > > > On Mon, Feb 27, 2023 at 12:07:17PM +0800, Jason Wang wrote:
> > > > > > > Btw, this kind of 1:1 hash features seems not scalable and flexible.
> > > > > > > It requires an endless extension on bits/fields. Modern NICs allow the
> > > > > > > user to customize the hash calculation, for virtio-net we can allow to
> > > > > > > use eBPF program to classify the packets. It seems to be more flexible
> > > > > > > and scalable and there's almost no maintain burden in the spec (only
> > > > > > > bytecode is required, no need any fancy features/interactions like
> > > > > > > maps), easy to be migrated etc.
> > > > > > >
> > > > > > > Prototype is also easy, tun/tap had an eBPF classifier for years.
> > > > > > >
> > > > > > > Thanks
> > > > > >
> > > > > > Yea BPF offload would be great to have. We have been discussing it for
> > > > > > years though - security issues keep blocking it. *Maybe* it's finally
> > > > > > going to be there but I'm not going to block this work waiting for BPF
> > > > > > offload.  And easily migrated is what BPF is not.
> > > > >
> > > > > Just to make sure we're at the same page. I meant to find a way to
> > > > > allow the driver/user to fully customize what it wants to
> > > > > hash/classify. Similar technologies which is based on private solution
> > > > > has been used by some vendors, which allow user to customize the
> > > > > classifier[1]
> > > > >
> > > > > ePBF looks like a good open-source solution candidate for this (there
> > > > > could be others). But there could be many kinds of eBPF programs that
> > > > > could be offloaded. One famous one is XDP which requires many features
> > > > > other than the bytecode/VM like map access, tailcall. Starting from
> > > > > such a complicated type is hard. Instead, we can start from a simple
> > > > > type, that is the eBPF classifier. All it needs is to pass the
> > > > > bytecode to the device, the device can choose to run it or compile it
> > > > > to what it can understand for classifying. We don't need maps, tail
> > > > > calls and other features.
> > > >
> > > > Until people start asking exactly for maps because they want
> > > > state for their classifier?
> > >
> > > Yes, but let's compare the eBPF without maps with the static feature
> > > proposed here. It is much more scalable and flexible.
> >
> > I looked for some examples of RSS using BPF and only found this:
> > https://github.com/Netronome/bpf-samples/blob/master/programmable_rss/rss_user.c
> > seems to use maps.
> 
> Yes and this is also the way we emulate RSS with TUN/TAP via steering
> eBPF support for TUN/TAP. The reason is that it needs to emulate not
> only the hash but also the indirection. If we only replace the hash
> function with the eBPF program but reuse the RSS indirection table, we
> don't need maps.

How? Add a special helper?

> >
> >
> > > > And it makes sense - if you want
> > > > e.g. load balancing you need stats which needs maps.
> > >
> > > Yes, but we know it's possible to have that (through the XDP offload).
> >
> > Not without a lot more work to make xdp offload happen.
> >
> 
> Yes, that's why a simple eBPF RSS hashing program looks much more easier.
> 
> Thanks

Notice that at this point this is no longer a generic BPF - you
are using a special helper. For tunnels I would imagine two tables
could easily turn out to be useful. Then what? Another table?
If yes then I can't say I like where this is going ...

> > > This is impossible with the approach proposed here.
> > >
> > > >
> > > > > We don't need to worry about the security
> > > > > because of its simplicity: the eBPF program is only in charge of doing
> > > > > classification, no other interactions with the driver and packet
> > > > > modification is prohibited. The feature is limited only to the
> > > > > VM/bytecode abstraction itself.
> > > > >
> > > > > What's more, it's a good first step to achieve full eBPF offloading in
> > > > > the future.
> > > > >
> > > > > Thanks
> > > > >
> > > > > [1] https://www.intel.com/content/www/us/en/architecture-and-technology/ethernet/dynamic-device-personalization-brief.html
> > > >
> > > > Dave seems to have nacked this approach, no?
> > >
> > > I may miss something but looking at kernel commit, there are few
> > > patches to support that:
> > >
> > > E.g
> > >
> > > commit c7648810961682b9388be2dd041df06915647445
> > > Author: Tony Nguyen <anthony.l.nguyen@intel.com>
> > > Date:   Mon Sep 9 06:47:44 2019 -0700
> > >
> > >     ice: Implement Dynamic Device Personalization (DDP) download
> > >
> > > And it has been used by DPDK drivers.
> > >
> > > Thanks
> > >
> > > >
> > > > > >
> > > > > > --
> > > > > > MST
> > > > > >
> > > >
> >


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

