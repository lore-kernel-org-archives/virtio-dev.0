Return-Path: <virtio-dev-return-12454-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F250C77B61
	for <virtio-dev@archiver.kernel.org>; Thu, 27 Apr 2023 17:13:38 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 406F02AEC2
	for <virtio-dev@archiver.kernel.org>; Thu, 27 Apr 2023 17:13:38 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 200A9986652
	for <virtio-dev@archiver.kernel.org>; Thu, 27 Apr 2023 17:13:38 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 09A50986644; Thu, 27 Apr 2023 17:13:38 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EA2B8986647
	for <virtio-dev@lists.oasis-open.org>; Thu, 27 Apr 2023 17:13:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: y2Nc1JjIMBilaPNaXIBv7w-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682615613; x=1685207613;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=25I9xh4S/8MFl88czJVxuQWobBtDpqtPf4UWvDKEnDs=;
        b=NKnldRlaKgc0JdERRl9l2FQneKzO8bS6wyz+uuxdGIbyhiDMAe2ySMWCq0D+2MKnTh
         IE9Ed3yOpRPvHUJKQ/JI7dD9WsKeXehhsWKVRTR6G/VHJcAHqzIXOBKdHVMxt0XgPyk4
         tpLhTya6NCjxFji9yEWnoupXH7VuFh8G5ZmRzHxEw1U7DUYqG2pT/72DdgH8X4Ml+NIh
         dbR4SCShvv1DZQlSP6a2SMUalJfAT9Vm1wpDOA4joU5ipw/9VTpNO8gKsPFwFjS5zjok
         qlqZeYvPtEbxTYV5H7omwhISJAXwCIP1cpVRsrqcnwWIBK5mSLYv8iJK3OwGgfWGi07b
         0z7A==
X-Gm-Message-State: AC+VfDw8v+7PayScB0oE+gYlqGAZ6EHgrhCTomYk/QtDpuanEqQyOm+a
	rh1ZRwogfBla1mNe4+8LoWeJ8vjmxVbO3uNXXcZU80VkDuuyXKZEL34zZ1LwGrcFrN3IUvsH9bA
	nPv10/Vfh32WyjewLV1tNzqnJltXM
X-Received: by 2002:a5d:42c6:0:b0:2f2:7a0e:5cc9 with SMTP id t6-20020a5d42c6000000b002f27a0e5cc9mr1791617wrr.19.1682615613347;
        Thu, 27 Apr 2023 10:13:33 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4QUvegOlvhpVYlfdg3PScAxfygvxpkLAZmoZJHDTLc3rWz0/nde9J2FNzL/zyD63JO5OikTQ==
X-Received: by 2002:a5d:42c6:0:b0:2f2:7a0e:5cc9 with SMTP id t6-20020a5d42c6000000b002f27a0e5cc9mr1791602wrr.19.1682615613006;
        Thu, 27 Apr 2023 10:13:33 -0700 (PDT)
Date: Thu, 27 Apr 2023 13:13:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org,
	Parav Pandit <parav@nvidia.com>, Jason Wang <jasowang@redhat.com>,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Message-ID: <20230427130008-mutt-send-email-mst@kernel.org>
References: <20230423073532.105636-1-hengqi@linux.alibaba.com>
 <20230425165659-mutt-send-email-mst@kernel.org>
 <19e6d4e6-e3d8-7eca-4d54-d113b4cc5504@linux.alibaba.com>
 <20230426104538-mutt-send-email-mst@kernel.org>
 <5463159d-daa2-101b-6abf-ea7aa4f40bd0@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <5463159d-daa2-101b-6abf-ea7aa4f40bd0@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: Re: [virtio-dev] Re: [virtio-comment] [PATCH v13] virtio-net:
 support inner header hash

On Thu, Apr 27, 2023 at 10:28:29AM +0800, Heng Qi wrote:
> 
> 
> 在 2023/4/26 下午10:48, Michael S. Tsirkin 写道:
> > On Wed, Apr 26, 2023 at 10:14:30PM +0800, Heng Qi wrote:
> > > This does not mean that every device needs to implement and support all of
> > > these, they can choose to support some protocols they want.
> > > 
> > > I add these because we have scale application scenarios for modern protocols
> > > VXLAN-GPE/GENEVE:
> > > 
> > > +\item In scenarios where the same flow passing through different tunnels is expected to be received in the same queue,
> > > +      warm caches, lessing locking, etc. are optimized to obtain receiving performance.
> > > 
> > > 
> > > Maybe the legacy GRE, VXLAN-GPE and GENEVE? But it has a little crossover.
> > > 
> > > Thanks.
> > But VXLAN-GPE/GENEVE can use source port for entropy.
> > 
> > 	It is recommended that the UDP source port number
> > 	 be calculated using a hash of fields from the inner packet
> > 
> > That is best because
> > it allows end to end control and is protocol agnostic.
> 
> Yes. I agree with this, I don't think we have an argument on this point
> right now.:)
> 
> For VXLAN-GPE/GENEVE or other modern tunneling protocols, we have to deal
> with
> scenarios where the same flow passes through different tunnels.
> 
> Having them hashed to the same rx queue, is hard to do via outer headers.
> > All that is missing is symmetric Toepliz and all is well?
> 
> The scenarios above or in the commit log also require inner headers.

Hmm I am not sure I get it 100%.
Could you show an example with inner header hash in the port #,
hash is symmetric, and you still have trouble?


It kinds of sounds like not enough entropy is not the problem
at this point. You now want to drop everything from the header
except the UDP source port. Is that a fair summary?

> 
> 
> Thanks.
> 
> > 


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

