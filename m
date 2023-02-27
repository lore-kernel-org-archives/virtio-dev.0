Return-Path: <virtio-dev-return-11308-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE5B3C64ED6
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Feb 2023 07:39:11 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 358CA41A0B
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Feb 2023 07:39:11 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1D49A98644F
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Feb 2023 07:39:11 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 06D619863F0; Mon, 27 Feb 2023 07:39:11 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EA7A39863FE
	for <virtio-dev@lists.oasis-open.org>; Mon, 27 Feb 2023 07:39:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 9rlnyQOfM0yYnWucGq34OA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/zR2QNJBnVODEXp9UV6AK01eVgaek9Op9GESt79bIx8=;
        b=VAePxrdvGRbHR0aQ+mttXzN5laLXlsG3gCCAZBlj4YRCbzj9L8BW/+oQoe3saYAsUz
         wVL8dumHaGVzd0zNBe0VJK0JtFOdFHrRHIVFvzK/6/cgk8SiqJzvIh1RRSIAqzjqZaGq
         lZJU/kaFNfbeqE3awAIprffnP7ogjPLRpUWzq2+dj0TIRsV/F6fYkmraI407dVMM7LCG
         EZwUAh1BTYVqh99uKx29yae8LYMidS7F/9HlVahS0tD1gs3TGHXWfKiQOgGumz1q7xF1
         /zpYvTtrCkGFOIIQbPKoEY9iLlxeNkLVYTLNfCC2GfabCV03IsOo47zXIJDw/0ZhmRe8
         j2Lw==
X-Gm-Message-State: AO0yUKVz2gutI4fNghCKptBewrLTU+EjCRmuZ8VIQSnlzyQAHxSdKXON
	2jFVlfXQhDAnMy4Pe7NfehAX8QbPiFO+wwhFWSBzceGbIlhRcrfLQZcmG9bVehTbTMKN995nmTH
	hlIQKb3ZsBGuisNJWzou/H9IpPDwY
X-Received: by 2002:a17:907:8c89:b0:8b1:779c:a8ac with SMTP id td9-20020a1709078c8900b008b1779ca8acmr38342172ejc.13.1677483547710;
        Sun, 26 Feb 2023 23:39:07 -0800 (PST)
X-Google-Smtp-Source: AK7set+2QkYBvhy1woVZ6b/8lIYOkGGp7C7lF5jVN80AmYGsm9sm09XVwdpXfShSd9oHEbNVI4+XJw==
X-Received: by 2002:a17:907:8c89:b0:8b1:779c:a8ac with SMTP id td9-20020a1709078c8900b008b1779ca8acmr38342160ejc.13.1677483547392;
        Sun, 26 Feb 2023 23:39:07 -0800 (PST)
Date: Mon, 27 Feb 2023 02:39:02 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, virtio-comment@lists.oasis-open.org,
	virtio-dev@lists.oasis-open.org, Parav Pandit <parav@nvidia.com>,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Message-ID: <20230227023657-mutt-send-email-mst@kernel.org>
References: <20230218143715.841-1-hengqi@linux.alibaba.com>
 <20230221124518-mutt-send-email-mst@kernel.org>
 <4d123e32-1ad0-e692-7fa6-0565eb34c487@redhat.com>
 <0f53212f-a89b-ad3c-73e3-a7a7b5533058@linux.alibaba.com>
 <1047920c-5dd5-8f31-0c4c-a108f36155f8@redhat.com>
 <20230223075934-mutt-send-email-mst@kernel.org>
 <CACGkMEvc2Px_Zz11R5QYwMXYm_j5rsYV2LrZt5yf8tZQxuT_Bg@mail.gmail.com>
 <20230224030509-mutt-send-email-mst@kernel.org>
 <CACGkMEuOu=6qKQO2TJ0B6ZLRH_-rGtZMYVtw7gn+BFbnJgWkrw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEuOu=6qKQO2TJ0B6ZLRH_-rGtZMYVtw7gn+BFbnJgWkrw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v9] virtio-net: support inner header hash
Message-ID: <20230227073902.yRjyPEJeEFciVk91gTgJqwWSo4nHsDVEJZ4Mnkvt1Gw@z>

On Mon, Feb 27, 2023 at 12:07:17PM +0800, Jason Wang wrote:
> Btw, this kind of 1:1 hash features seems not scalable and flexible.
> It requires an endless extension on bits/fields. Modern NICs allow the
> user to customize the hash calculation, for virtio-net we can allow to
> use eBPF program to classify the packets. It seems to be more flexible
> and scalable and there's almost no maintain burden in the spec (only
> bytecode is required, no need any fancy features/interactions like
> maps), easy to be migrated etc.
> 
> Prototype is also easy, tun/tap had an eBPF classifier for years.
> 
> Thanks

Yea BPF offload would be great to have. We have been discussing it for
years though - security issues keep blocking it. *Maybe* it's finally
going to be there but I'm not going to block this work waiting for BPF
offload.  And easily migrated is what BPF is not.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

