Return-Path: <virtio-dev-return-11587-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16E96C6FD19
	for <virtio-dev@archiver.kernel.org>; Thu,  9 Mar 2023 19:36:44 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 52D0626A36
	for <virtio-dev@archiver.kernel.org>; Thu,  9 Mar 2023 19:36:43 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 481BA98670C
	for <virtio-dev@archiver.kernel.org>; Thu,  9 Mar 2023 19:36:43 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 3C6509866FF; Thu,  9 Mar 2023 19:36:43 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 288B5986700
	for <virtio-dev@lists.oasis-open.org>; Thu,  9 Mar 2023 19:36:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: lCbSIlBmN4CLoxjFYLUF6g-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678390595;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vrc0ENZWAjfF8ubyNjZ4Dw7ZPty7y87bUKpLpAod5DY=;
        b=MXbEH4BenRn1pYUDLuDXZvXunSCRqs17TZ9UAOKRFIoFS22VeOaC0N+a8y7d9qeTjC
         hcGWYVfHbOpY813zoLcQoXcurK0H5+l8AoiEEqfIR4cvFXN2wUerYCYeSzPW0J9M1zPY
         vfM0X7ppgpDjvYArM5eGoIBl9QCnYRS522SLZdJQSVPg96ji1RFro9nNAR+hmvLDGZHN
         2GN1o0of19mBlu/0cSCkGIHlgcjImoTzqdByXHuysAKcxzZ9iHnX9kr7t7HrvsmUhOSS
         x7IlIQLoWMmuUivbOi9ip0aE6OHgXvJ0zJCNVCw9dN5ODI7NtHvLWWTOtYsp8sN+zBlR
         A/ig==
X-Gm-Message-State: AO0yUKWp/KHw76c1DJ6jrX2wTCdV+CLKgQjbwmLliTxl+Kc7rWztB6bi
	w/v2s/iHzaAC70na1xwMsaN9xxUMZZ0EOTQLO2byqrjs+5FSXHaENy2EfoCCj5a2ItLopiXFGf+
	e5YvhUFDyDuEH9Dd6s7pUietsKrBh
X-Received: by 2002:a17:907:9702:b0:8b1:2cdb:b8dd with SMTP id jg2-20020a170907970200b008b12cdbb8ddmr26025374ejc.58.1678390594819;
        Thu, 09 Mar 2023 11:36:34 -0800 (PST)
X-Google-Smtp-Source: AK7set9uWWSgLb9aaqUlp1HaqQeYcaaE1BMCO4PLpFqmP52yIQzJXv2f3DqRhKjpyUf86TGFSeOD8A==
X-Received: by 2002:a17:907:9702:b0:8b1:2cdb:b8dd with SMTP id jg2-20020a170907970200b008b12cdbb8ddmr26025186ejc.58.1678390590686;
        Thu, 09 Mar 2023 11:36:30 -0800 (PST)
Date: Thu, 9 Mar 2023 14:36:26 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
	Parav Pandit <parav@nvidia.com>, Jason Wang <jasowang@redhat.com>,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Message-ID: <20230309142612-mutt-send-email-mst@kernel.org>
References: <20230218143715.841-1-hengqi@linux.alibaba.com>
 <20230228061309-mutt-send-email-mst@kernel.org>
 <25231225-59c8-91b0-e0dd-3dab8aa8164b@linux.alibaba.com>
 <20230308093311-mutt-send-email-mst@kernel.org>
 <c334a082-4b78-c7ea-e04a-6436f4965516@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <c334a082-4b78-c7ea-e04a-6436f4965516@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: Re: [virtio-dev] Re: [virtio-comment] Re: [virtio-dev] Re: [PATCH
 v9] virtio-net: support inner header hash

On Thu, Mar 09, 2023 at 12:55:02PM +0800, Heng Qi wrote:
> 
> 
> 在 2023/3/8 下午10:39, Michael S. Tsirkin 写道:
> > On Wed, Mar 01, 2023 at 10:56:31AM +0800, Heng Qi wrote:
> > > 
> > > 在 2023/2/28 下午7:16, Michael S. Tsirkin 写道:
> > > > On Sat, Feb 18, 2023 at 10:37:15PM +0800, Heng Qi wrote:
> > > > > If the tunnel is used to encapsulate the packets, the hash calculated
> > > > > using the outer header of the receive packets is always fixed for the
> > > > > same flow packets, i.e. they will be steered to the same receive queue.
> > > > Wait a second. How is this true? Does not everyone stick the
> > > > inner header hash in the outer source port to solve this?
> > > Yes, you are right. That's what we did before the inner header hash, but it
> > > has a performance penalty, which I'll explain below.
> > > 
> > > > For example geneve spec says:
> > > > 
> > > >      it is necessary for entropy from encapsulated packets to be
> > > >      exposed in the tunnel header.  The most common technique for this is
> > > >      to use the UDP source port
> > > The end point of the tunnel called the gateway (with DPDK on top of it).
> > > 
> > > 1. When there is no inner header hash, entropy can be inserted into the udp
> > > src port of the outer header of the tunnel,
> > > and then the tunnel packet is handed over to the host. The host needs to
> > > take out a part of the CPUs to parse the outer headers (but not drop them)
> > > to calculate the inner hash for the inner payloads,
> > > and then use the inner
> > > hash to forward them to another part of the CPUs that are responsible for
> > > processing.
> > I don't get this part. Leave inner hashes to the guest inside the
> > tunnel, why is your host doing this?
> 
> Assuming that the same flow includes a unidirectional flow a->b, or a
> bidirectional flow a->b and b->a,
> such flow may be out of order when processed by the gateway(DPDK):
> 
> 1. In unidirectional mode, if the same flow is switched to another gateway
> for some reason, resulting in different outer IP address,
>     then this flow may be processed by different CPUs after reaching the
> host if there is no inner hash. So after the host receives the
>     flow, first use the forwarding CPUs to parse the inner hash, and then
> use the hash to ensure that the flow is processed by the
>     same CPU.
> 2. In bidirectional mode, a->b flow may go to gateway 1, and b->a flow may
> go to gateway 2. In order to ensure that the same flow is
>     processed by the same CPU, we still need the forwarding CPUs to parse
> the real inner hash(here, the hash key needs to be replaced with a symmetric
> hash key).

Oh intersting. What are those gateways, how come there's expectation
that you can change their addresses and topology
completely seamlessly without any reordering whatsoever?
Isn't network topology change kind of guaranteed to change ordering
sometimes?


> > 
> > > 1). During this process, the CPUs on the host is divided into two parts, one
> > > part is used as a forwarding node to parse the outer header,
> > >       and the CPU utilization is low. Another part handles packets.
> > Some overhead is clearly involved in *sending* packets -
> > to calculate the hash and stick it in the port number.
> > This is, however, a separate problem and if you want to
> > solve it then my suggestion would be to teach the *transmit*
> > side about GRE offloads, so it can fill the source port in the card.
> > 
> > > 2). The entropy of the source udp src port is not enough, that is, the queue
> > > is not widely distributed.
> > how isn't it enough? 16 bit is enough to cover all vqs ...
> 
> A 5-tuple brings more entropy than a single port, doesn't it?

But you don't need more for RSS, the indirection table is not
that large.

> In fact, the
> inner hash of the physical network card used by
> the business team is indeed better than the udp port number of the outer
> header we modify now, but they did not give me the data.

Admittedly, out hash value is 32 bit.

> > > 2. When there is an inner header hash, the gateway will directly help parse
> > > the outer header, and use the inner 5 tuples to calculate the inner hash.
> > > The tunneled packet is then handed over to the host.
> > > 1) All the CPUs of the host are used to process data packets, and there is
> > > no need to use some CPUs to forward and parse the outer header.
> > You really have to parse the outer header anyway,
> > otherwise there's no tunneling.
> > Unless you want to teach virtio to implement tunneling
> > in hardware, which is something I'd find it easier to
> > get behind.
> 
> There is no need to parse the outer header twice, because we use shared
> memory.

shared with what? you need the outer header to identify the tunnel.

> > > 2) The entropy of the original quintuple is sufficient, and the queue is
> > > widely distributed.
> > It's exactly the same entropy, why would it be better? In fact you
> > are taking out the outer hash entropy making things worse.
> 
> I don't get the point, why the entropy of the inner 5-tuple and the outer
> tunnel header is the same,
> multiple streams have the same outer header.
> 
> Thanks.

well our hash is 32 bit. source port is just 16 bit.
so yes it's more entropy but RSS can't use more than 16 bit.
why do you need so many? you have more than 64k CPUs to offload to?


> > 
> > > Thanks.
> > > > same goes for vxlan did not check further.
> > > > 
> > > > so what is the problem?  and which tunnel types actually suffer from the
> > > > problem?
> > > > 
> > > 
> > > This publicly archived list offers a means to provide input to the
> > > OASIS Virtual I/O Device (VIRTIO) TC.
> > > 
> > > In order to verify user consent to the Feedback License terms and
> > > to minimize spam in the list archive, subscription is required
> > > before posting.
> > > 
> > > Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> > > Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> > > List help: virtio-comment-help@lists.oasis-open.org
> > > List archive: https://lists.oasis-open.org/archives/virtio-comment/
> > > Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
> > > List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
> > > Committee: https://www.oasis-open.org/committees/virtio/
> > > Join OASIS: https://www.oasis-open.org/join/
> > 
> > ---------------------------------------------------------------------
> > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

