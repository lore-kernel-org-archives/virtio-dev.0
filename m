Return-Path: <virtio-dev-return-11351-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C46BC678D4
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 07:42:20 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 49C4B2ACA8
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 07:42:19 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 283B498667E
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 07:42:19 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 0E471983EB8; Thu,  2 Mar 2023 07:42:19 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EB411986674
	for <virtio-dev@lists.oasis-open.org>; Thu,  2 Mar 2023 07:42:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: ZNf_d0byMAuMYw5nF5nT9Q-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677742935;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O9xvXmGZyO/ORzW2Sm8cV8FSEeXyOc0GMQDqezateig=;
        b=fFXTvUZBAonvpRyHs3Avi6doc5ezFSc374l0RJ7f8qinElZpX0tc911Xl2zxdBO8Rn
         aTY+CX/Z+CRTlz2KkAG55xev0TJojbLZ/+yPla1wNJUa4ZzUf5IPAr8QDWKY438FxhNV
         6vEDtWEQisSc8vgSyHwQT9IcMFirZTi/cnTGpsjKU6kBzOcsp23y1sxfmKbrrz9WmoAX
         NsKRcKH2Wimg59Aq+dxtZMt9omMUAsj4o+irsK0FHv5LwVyqXdLFY+pvq/s9d5MzxCN5
         pv46aySd+TKubh+b/MFPF9sZqb10wK+2D8MeOtG3Zxay1hs5Tw0eOKneIrfuGpfoAdlb
         Gvew==
X-Gm-Message-State: AO0yUKXZN990kji6ef0j4TH1AqilaC9WD/t78D143dOhVioZFQaGXB3P
	IwQiVY9pRUabqSuDlrmuiQml/QhOvqAWl07t5M87gQNAD1AyhR4nweJCrY8fffF8i2rWNomE2Ad
	N2JwOdOXLVDcC6HxnqtKiVgGXZ4Jn
X-Received: by 2002:a05:600c:491f:b0:3ea:bc08:42ad with SMTP id f31-20020a05600c491f00b003eabc0842admr7004203wmp.2.1677742934793;
        Wed, 01 Mar 2023 23:42:14 -0800 (PST)
X-Google-Smtp-Source: AK7set/7hioXyDkcW7ijSRo4vOW6rfYqBidwUpFXbSaen07ieKxpN14VEK8KBSwKNRcuVGaHvnrWHQ==
X-Received: by 2002:a05:600c:491f:b0:3ea:bc08:42ad with SMTP id f31-20020a05600c491f00b003eabc0842admr7004188wmp.2.1677742934449;
        Wed, 01 Mar 2023 23:42:14 -0800 (PST)
Date: Thu, 2 Mar 2023 02:42:10 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, virtio-comment@lists.oasis-open.org,
	virtio-dev@lists.oasis-open.org, Parav Pandit <parav@nvidia.com>,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Message-ID: <20230302024129-mutt-send-email-mst@kernel.org>
References: <20230224030509-mutt-send-email-mst@kernel.org>
 <CACGkMEuOu=6qKQO2TJ0B6ZLRH_-rGtZMYVtw7gn+BFbnJgWkrw@mail.gmail.com>
 <20230227023657-mutt-send-email-mst@kernel.org>
 <CACGkMEtOFC-xygzgECi82j4Q6PacpjVnyPMs1Q6c9PN0RfX5bw@mail.gmail.com>
 <20230227124800-mutt-send-email-mst@kernel.org>
 <CACGkMEvUaQuzMx4iwkaYg9t9Bz2Ev0eHAwgrWbNEwtQHZOkkvQ@mail.gmail.com>
 <20230228060352-mutt-send-email-mst@kernel.org>
 <CACGkMEvAGABhk6JX7+F-sDtRM7t1oONEz9wrgKM7iShmyYV34A@mail.gmail.com>
 <20230301053407-mutt-send-email-mst@kernel.org>
 <CACGkMEsSCGo01WsLvDojB5s8yjqL1mV0s328DnssosnNO=4M4w@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEsSCGo01WsLvDojB5s8yjqL1mV0s328DnssosnNO=4M4w@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [PATCH v9] virtio-net: support inner header hash

On Thu, Mar 02, 2023 at 10:57:12AM +0800, Jason Wang wrote:
> On Wed, Mar 1, 2023 at 6:36 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Wed, Mar 01, 2023 at 10:36:41AM +0800, Jason Wang wrote:
> > > On Tue, Feb 28, 2023 at 7:05 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Tue, Feb 28, 2023 at 11:04:26AM +0800, Jason Wang wrote:
> > > > > On Tue, Feb 28, 2023 at 1:49 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > >
> > > > > > On Mon, Feb 27, 2023 at 04:35:09PM +0800, Jason Wang wrote:
> > > > > > > On Mon, Feb 27, 2023 at 3:39 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > > > >
> > > > > > > > On Mon, Feb 27, 2023 at 12:07:17PM +0800, Jason Wang wrote:
> > > > > > > > > Btw, this kind of 1:1 hash features seems not scalable and flexible.
> > > > > > > > > It requires an endless extension on bits/fields. Modern NICs allow the
> > > > > > > > > user to customize the hash calculation, for virtio-net we can allow to
> > > > > > > > > use eBPF program to classify the packets. It seems to be more flexible
> > > > > > > > > and scalable and there's almost no maintain burden in the spec (only
> > > > > > > > > bytecode is required, no need any fancy features/interactions like
> > > > > > > > > maps), easy to be migrated etc.
> > > > > > > > >
> > > > > > > > > Prototype is also easy, tun/tap had an eBPF classifier for years.
> > > > > > > > >
> > > > > > > > > Thanks
> > > > > > > >
> > > > > > > > Yea BPF offload would be great to have. We have been discussing it for
> > > > > > > > years though - security issues keep blocking it. *Maybe* it's finally
> > > > > > > > going to be there but I'm not going to block this work waiting for BPF
> > > > > > > > offload.  And easily migrated is what BPF is not.
> > > > > > >
> > > > > > > Just to make sure we're at the same page. I meant to find a way to
> > > > > > > allow the driver/user to fully customize what it wants to
> > > > > > > hash/classify. Similar technologies which is based on private solution
> > > > > > > has been used by some vendors, which allow user to customize the
> > > > > > > classifier[1]
> > > > > > >
> > > > > > > ePBF looks like a good open-source solution candidate for this (there
> > > > > > > could be others). But there could be many kinds of eBPF programs that
> > > > > > > could be offloaded. One famous one is XDP which requires many features
> > > > > > > other than the bytecode/VM like map access, tailcall. Starting from
> > > > > > > such a complicated type is hard. Instead, we can start from a simple
> > > > > > > type, that is the eBPF classifier. All it needs is to pass the
> > > > > > > bytecode to the device, the device can choose to run it or compile it
> > > > > > > to what it can understand for classifying. We don't need maps, tail
> > > > > > > calls and other features.
> > > > > >
> > > > > > Until people start asking exactly for maps because they want
> > > > > > state for their classifier?
> > > > >
> > > > > Yes, but let's compare the eBPF without maps with the static feature
> > > > > proposed here. It is much more scalable and flexible.
> > > >
> > > > I looked for some examples of RSS using BPF and only found this:
> > > > https://github.com/Netronome/bpf-samples/blob/master/programmable_rss/rss_user.c
> > > > seems to use maps.
> > >
> > > Yes and this is also the way we emulate RSS with TUN/TAP via steering
> > > eBPF support for TUN/TAP. The reason is that it needs to emulate not
> > > only the hash but also the indirection. If we only replace the hash
> > > function with the eBPF program but reuse the RSS indirection table, we
> > > don't need maps.
> >
> > How? Add a special helper?
> 
> We can let the eBPF program return the hash:
> 
> [eBPF hasing] -> hash value -> [indirection table lookup]
> 
> Note that if we don't consider future full eBPF offloading, we can
> start with classical BPF.
> 
> Thanks

So again this is a custom thing not a standard use of BPF.
Normally value returned is pass/drop.

> >
> > > >
> > > >
> > > > > > And it makes sense - if you want
> > > > > > e.g. load balancing you need stats which needs maps.
> > > > >
> > > > > Yes, but we know it's possible to have that (through the XDP offload).
> > > >
> > > > Not without a lot more work to make xdp offload happen.
> > > >
> > >
> > > Yes, that's why a simple eBPF RSS hashing program looks much more easier.
> > >
> > > Thanks
> >
> > Notice that at this point this is no longer a generic BPF - you
> > are using a special helper. For tunnels I would imagine two tables
> > could easily turn out to be useful. Then what? Another table?
> > If yes then I can't say I like where this is going ...
> >
> > > > > This is impossible with the approach proposed here.
> > > > >
> > > > > >
> > > > > > > We don't need to worry about the security
> > > > > > > because of its simplicity: the eBPF program is only in charge of doing
> > > > > > > classification, no other interactions with the driver and packet
> > > > > > > modification is prohibited. The feature is limited only to the
> > > > > > > VM/bytecode abstraction itself.
> > > > > > >
> > > > > > > What's more, it's a good first step to achieve full eBPF offloading in
> > > > > > > the future.
> > > > > > >
> > > > > > > Thanks
> > > > > > >
> > > > > > > [1] https://www.intel.com/content/www/us/en/architecture-and-technology/ethernet/dynamic-device-personalization-brief.html
> > > > > >
> > > > > > Dave seems to have nacked this approach, no?
> > > > >
> > > > > I may miss something but looking at kernel commit, there are few
> > > > > patches to support that:
> > > > >
> > > > > E.g
> > > > >
> > > > > commit c7648810961682b9388be2dd041df06915647445
> > > > > Author: Tony Nguyen <anthony.l.nguyen@intel.com>
> > > > > Date:   Mon Sep 9 06:47:44 2019 -0700
> > > > >
> > > > >     ice: Implement Dynamic Device Personalization (DDP) download
> > > > >
> > > > > And it has been used by DPDK drivers.
> > > > >
> > > > > Thanks
> > > > >
> > > > > >
> > > > > > > >
> > > > > > > > --
> > > > > > > > MST
> > > > > > > >
> > > > > >
> > > >
> >


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

