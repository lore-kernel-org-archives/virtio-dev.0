Return-Path: <virtio-dev-return-11258-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F207C6FA8E
	for <virtio-dev@archiver.kernel.org>; Fri, 24 Feb 2023 17:10:22 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 324842B05F
	for <virtio-dev@archiver.kernel.org>; Fri, 24 Feb 2023 17:10:22 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 141CC98678D
	for <virtio-dev@archiver.kernel.org>; Fri, 24 Feb 2023 17:10:22 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id E795698665E; Fri, 24 Feb 2023 17:10:21 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D563E986673
	for <virtio-dev@lists.oasis-open.org>; Fri, 24 Feb 2023 17:10:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: _ytmLgurP5yW1WFse3_ckg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cIsRP8OVR050/vb6Qbd5xpiOBnQDQ1G6v4okU7neglQ=;
        b=aKvpaNB46Sc6vYYIVQ0SIBrjezB/Inl8D9Ot0xdafM0Hu2S9pvhrUPI4HYJNJFg8Ye
         7l/84WT2HNJQSZykDD1gz5YFBdYlJbkbfeBAisG/cUTZq95+VMH+gBx6ST0kxufETKAv
         K/3PiSsc/3Jl1IkG4YKqDgp1DI8h5jduNmvw2RhzKAVJrHLQ/aTIKPg9JiKi5rHltSQX
         2cIvkUdB0DcjtIwZT4Ggjy1S4Vao+N8XGxgZQ5dsZxxZYaWcj4Fv2M/RF6mEBj9N8D3T
         /gfnZCiTruSrOXTTqwGk89ylgDXfXqc3QJa8CS/u4nkIy17+zBKIhgLtwBndnhsQnIZo
         yUmw==
X-Gm-Message-State: AO0yUKXh6nEKZ3xdYYTcS8kfPbxhv1M6JZXrHJkkwiz/kIn2a41QQBvn
	WTNLhgJAxVEXMFxOYUMtmpB0v6fs8lZivcsbNTMlp8hMA11G+hOnCyo/KphImUP8Oo19FxWOKZU
	VpGyky7iNGKyTbtwF2Rpr/s3EvHzl
X-Received: by 2002:a5d:47a1:0:b0:2c5:519f:307a with SMTP id 1-20020a5d47a1000000b002c5519f307amr302387wrb.30.1677258618481;
        Fri, 24 Feb 2023 09:10:18 -0800 (PST)
X-Google-Smtp-Source: AK7set8M8+KMR+mlAC8mDM9uLSQlP/fhWoAtzLXs2ihUMMTN4yit9WOM0izFYT3o5EX1zAKnLDBgpw==
X-Received: by 2002:a5d:47a1:0:b0:2c5:519f:307a with SMTP id 1-20020a5d47a1000000b002c5519f307amr302364wrb.30.1677258618156;
        Fri, 24 Feb 2023 09:10:18 -0800 (PST)
Date: Fri, 24 Feb 2023 12:10:14 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: Parav Pandit <parav@nvidia.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	Jason Wang <jasowang@redhat.com>,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"ailan@redhat.com" <ailan@redhat.com>
Message-ID: <20230224120744-mutt-send-email-mst@kernel.org>
References: <20230218143715.841-1-hengqi@linux.alibaba.com>
 <20230223080358-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481FD1A82D37157AFCFC541DCAB9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230224030725-mutt-send-email-mst@kernel.org>
 <f8d09582-749f-11f6-90d1-ac7413ed6937@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <f8d09582-749f-11f6-90d1-ac7413ed6937@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: Re: [virtio-dev] Re: [PATCH v9] virtio-net: support inner header hash
Message-ID: <20230224171014.SQWnHto-GKy8HpCYZ8_iGS-pe9EJdi5TPC63uQO1MQM@z>

On Fri, Feb 24, 2023 at 10:38:37PM +0800, Heng Qi wrote:
> 
> 
> 在 2023/2/24 下午4:13, Michael S. Tsirkin 写道:
> > On Thu, Feb 23, 2023 at 02:40:46PM +0000, Parav Pandit wrote:
> > > 
> > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > Sent: Thursday, February 23, 2023 8:14 AM
> > > > 
> > > > On Sat, Feb 18, 2023 at 10:37:15PM +0800, Heng Qi wrote:
> > > 
> > > > So for RSS specifically, we brain-stormed with Amnon (Cc'd) and came up with
> > > > an idea: RSS indirection table entries are 16 bit but onlu 15 bits are used to
> > > > indentify an RX queue.
> > > > We can use the remaining bit as a "tunnel bit" to signal whether to use the
> > > > inner or the outer hash for queue selection.
> > > > 
> > > I further brainstormed internally with Saeed and Rony on this.
> > > 
> > > The inner hash is only needed for GRE, IPIP etc.
> > > For VXLAN and NVGRE Linux kernel transmit side uses the entropy of the source port of the outer header.
> > > It does that based on the inner header.
> > > Refer to [1] as one example.
> > > 
> > > [1] https://elixir.bootlin.com/linux/latest/source/drivers/net/geneve.c#L922
> > But I think hash was requested for RSS with dpdk, no?
> 
> I think yes, at least probably the first customer to use the feature might
> be dpdk.:)
> 
> 
> > 
> > > > The lookup will work like this then:
> > > > 
> > > > calculate outer hash
> > > > if (rss[outer hash] & tunnel bit)
> > > Tunnel bit, you mean tunneled packet, right?
> > this idea stores a bit in the indirection table
> > which signals which of the hashes to use for rss
> 
> This allows inner hash to have the ability to select a queue and place
> packets to the queue (that is, parallel to RSS),
> which seems to be different from our discussion before v9. 🙁
> 
> Thanks.

Not exactly. The idea is that we start with outer hash.
Based on that we use rss table to decide whether to use the inner hash.

Given that Parav claims it's difficult to implement in
hardware I'm not insisting this idea is included
in the patchset. We can add it later.


> > 
> > > > then
> > > > 	calculate inner hash
> > > > 	return rss[inner hash] & ~tunnel bit
> > > Why to end with a tunnel bit?
> > 
> > this just clears the bit so we end up with a vq number.
> > 
> > > > else
> > > > 	return rss[outer hash]
> > > > 
> > > > 
> > > > this fixes the security issue returning us back to status quo : specific tunnels can
> > > > be directed to separate queues.
> > > > 
> > > The number of tunnels is far higher than the number of queues with para virt driver doing decap.
> > True. This seeks to get us back to where we are before the feature:
> > driver can send specific outer hashes to specific queues.
> > outer hash collisions remain a problem.
> > 
> > 
> > > > This is for RSS.
> > > > 
> > > > 
> > > > For hash reporting indirection table is not used.
> > > > Maybe it is enough to signal to driver that inner hash was used.
> > > > We do need that signalling though.
> > > > 
> > > > My question would be whether it's practical to implement in hardware.
> > > In above example, hw calculating double hash is difficult without much gain.
> > > Either calculating on one inner or outer makes sense.
> > > 
> > > Signaling whether calculated on inner or outer is fine because hw exactly tells what it did.
> > This, in a sense, is what reporting hash tunnel type did.
> > Do you now think we need it?
> > 


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

