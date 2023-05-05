Return-Path: <virtio-dev-return-12575-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F2AAC77B7F
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 14:56:21 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 437581318E0
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 14:56:21 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0DB9D9866C2
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 14:56:21 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id D7B3D98665E; Fri,  5 May 2023 14:56:20 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C53909866B4
	for <virtio-dev@lists.oasis-open.org>; Fri,  5 May 2023 14:56:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: laqYv_c0MpKsOTzdjy-ZNw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683298577; x=1685890577;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7iPSBZo8a0AiL61txlL6huadQ0DJmwdgAmmB9Qr/UK0=;
        b=gz7hkGlEdcg9F22SM+9xGmbZfVOlMJUPZ995QrjEfng4xp9/d0WuJ4EpOdRZqJQta/
         MOpA/wFe0LGSKfpeZCC+ZLNJvm7vX9cpuMw3YoMpN8J4JvV9oIIRodE0UHkMEnFVZVRI
         A1k/tc9NNt+0YNeBb3NjDX/5KJavK9CYn92SS25rakcexDHirnVGyZzohuh/DYReRmes
         kGuwEZhgtTgbI1pN2BCKhm9nvvcCiQPK0Fd+FYkqU0xYWnKN5L9kYo49kMmk/zpUQXUM
         IHqBtG0etHDrWPH0m4Qsir79ChrKoqOzDvBj0Wtww25d+8Z5QYRNYH09U3dtCYFb9GDL
         Tipg==
X-Gm-Message-State: AC+VfDwC0+1hSGczkmdo5UOPe6894IBC278LbfPN0Gzbi/sRjNlrW4QJ
	Y1s9slGZXHFzQKMz1flAobOmTCyLGrqvwcQMZ1PeRSUI9bHoYYo9Fgk2wj4OyObHVleMIN80HzC
	ZQmDWnmixo/GkPnI2va9YTtfewSb4
X-Received: by 2002:a17:907:a407:b0:94e:547b:6301 with SMTP id sg7-20020a170907a40700b0094e547b6301mr1492213ejc.8.1683298577346;
        Fri, 05 May 2023 07:56:17 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ40UPyPwb8Z+4qQSBxbVdBfVWA3CS2Tky3E37rc1fAfmEz2jqDdK5pSxHEKfJvdXU13c/hHHA==
X-Received: by 2002:a17:907:a407:b0:94e:547b:6301 with SMTP id sg7-20020a170907a40700b0094e547b6301mr1492194ejc.8.1683298577044;
        Fri, 05 May 2023 07:56:17 -0700 (PDT)
Date: Fri, 5 May 2023 10:56:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org,
	Parav Pandit <parav@nvidia.com>, Jason Wang <jasowang@redhat.com>,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Message-ID: <20230505105427-mutt-send-email-mst@kernel.org>
References: <20230423073532.105636-1-hengqi@linux.alibaba.com>
 <20230425165659-mutt-send-email-mst@kernel.org>
 <19e6d4e6-e3d8-7eca-4d54-d113b4cc5504@linux.alibaba.com>
 <20230426104538-mutt-send-email-mst@kernel.org>
 <5463159d-daa2-101b-6abf-ea7aa4f40bd0@linux.alibaba.com>
 <20230427130008-mutt-send-email-mst@kernel.org>
 <20230505135115.GA110622@h68b04307.sqa.eu95>
MIME-Version: 1.0
In-Reply-To: <20230505135115.GA110622@h68b04307.sqa.eu95>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [virtio-comment] Re: [virtio-dev] Re: [virtio-comment] [PATCH
 v13] virtio-net: support inner header hash

On Fri, May 05, 2023 at 09:51:15PM +0800, Heng Qi wrote:
> On Thu, Apr 27, 2023 at 01:13:29PM -0400, Michael S. Tsirkin wrote:
> > On Thu, Apr 27, 2023 at 10:28:29AM +0800, Heng Qi wrote:
> > > 
> > > 
> > > 在 2023/4/26 下午10:48, Michael S. Tsirkin 写道:
> > > > On Wed, Apr 26, 2023 at 10:14:30PM +0800, Heng Qi wrote:
> > > > > This does not mean that every device needs to implement and support all of
> > > > > these, they can choose to support some protocols they want.
> > > > > 
> > > > > I add these because we have scale application scenarios for modern protocols
> > > > > VXLAN-GPE/GENEVE:
> > > > > 
> > > > > +\item In scenarios where the same flow passing through different tunnels is expected to be received in the same queue,
> > > > > +      warm caches, lessing locking, etc. are optimized to obtain receiving performance.
> > > > > 
> > > > > 
> > > > > Maybe the legacy GRE, VXLAN-GPE and GENEVE? But it has a little crossover.
> > > > > 
> > > > > Thanks.
> > > > But VXLAN-GPE/GENEVE can use source port for entropy.
> > > > 
> > > > 	It is recommended that the UDP source port number
> > > > 	 be calculated using a hash of fields from the inner packet
> > > > 
> > > > That is best because
> > > > it allows end to end control and is protocol agnostic.
> > > 
> > > Yes. I agree with this, I don't think we have an argument on this point
> > > right now.:)
> > > 
> > > For VXLAN-GPE/GENEVE or other modern tunneling protocols, we have to deal
> > > with
> > > scenarios where the same flow passes through different tunnels.
> > > 
> > > Having them hashed to the same rx queue, is hard to do via outer headers.
> > > > All that is missing is symmetric Toepliz and all is well?
> > > 
> > > The scenarios above or in the commit log also require inner headers.
> > 
> > Hmm I am not sure I get it 100%.
> > Could you show an example with inner header hash in the port #,
> > hash is symmetric, and you still have trouble?
> > 
> > 
> > It kinds of sounds like not enough entropy is not the problem
> > at this point.
> 
> Sorry for the late reply. :)
> 
> For modern tunneling protocols, yes.
> 
> > You now want to drop everything from the header
> > except the UDP source port. Is that a fair summary?
> > 
> 
> For example, for the same flow passing through different VXLAN tunnels,
> packets in this flow have the same inner header and different outer
> headers. Sometimes these packets of the flow need to be hashed to the
> same rxq, then we can use the inner header as the hash input.
> 
> Thanks!

So, they will have the same source port yes? Any way to use that
so we don't depend on a specific protocol?

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

