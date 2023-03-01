Return-Path: <virtio-dev-return-11341-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73141C64EC7
	for <virtio-dev@archiver.kernel.org>; Wed,  1 Mar 2023 11:07:59 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id A58642A8E2
	for <virtio-dev@archiver.kernel.org>; Wed,  1 Mar 2023 11:07:58 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A1943986672
	for <virtio-dev@archiver.kernel.org>; Wed,  1 Mar 2023 11:07:58 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 96552986663; Wed,  1 Mar 2023 11:07:58 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7FB6D986669
	for <virtio-dev@lists.oasis-open.org>; Wed,  1 Mar 2023 11:07:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: C7NDVtM8ND6fsZf_3Xrb2w-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677668868;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A4/R8NBa2ScoW+sx5/hJabF7lN5wM5rBw54lwOzP74E=;
        b=x36RiMfyrFIYJy2R99Q+9QyFHVuWaCmOJcMQ3oE9Mz/WXMVpZ05HPHLnkOTr2ygpf7
         npDNgpaRkS4hI63xhVRF9kZpETFGsNBl4mtuH6/kt1EFnAINAyFYIwXrYdkzqWZtjmfC
         /Kaw6aEY93ZFofkEU402KXXwSQR/9PagYQBaFCw8/i+y3rjcXa6sNY/l9gcJ5iMRNkSw
         orl6IjtrkJ/cGosP0y8aJ8B03YZ4uVZuCiOoyXgMsRJV0SmyHDqw2eqiBp257GZUPK6r
         D8/4EFBfovTUWmIyY4u7DKXprykL/cL9Oi/n5SZ+65/mp3DInrtw2SGTz3QvPabIi2Uz
         z7AA==
X-Gm-Message-State: AO0yUKXxTUDueVUWInSyy3qpd2pz2ivt0l/GrH3ivTrYipo4+/EDyEmv
	okuSe0EOmGJLpxUYmRM91roy44aF0IrHAa/kmmkHZxVa3hljdSiN2Cw1vWQ2FCARAjSl0sxkP4D
	cGDcBaaRWK6jq9FMSw2SYQ8xBbhOH
X-Received: by 2002:a05:600c:4da6:b0:3eb:19e7:b291 with SMTP id v38-20020a05600c4da600b003eb19e7b291mr4225855wmp.11.1677668868367;
        Wed, 01 Mar 2023 03:07:48 -0800 (PST)
X-Google-Smtp-Source: AK7set/IUJMs+ptTgCwhwxepldxmGQSp4xL7YJe5KB09rfXtQfYWOakN8AP1r5R9Kh+3xcsnQCfU7w==
X-Received: by 2002:a05:600c:4da6:b0:3eb:19e7:b291 with SMTP id v38-20020a05600c4da600b003eb19e7b291mr4225843wmp.11.1677668868045;
        Wed, 01 Mar 2023 03:07:48 -0800 (PST)
Date: Wed, 1 Mar 2023 06:07:43 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
	Parav Pandit <parav@nvidia.com>, Jason Wang <jasowang@redhat.com>,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Message-ID: <20230301055801-mutt-send-email-mst@kernel.org>
References: <20230218143715.841-1-hengqi@linux.alibaba.com>
 <20230228061309-mutt-send-email-mst@kernel.org>
 <c778af08-7aac-ca35-30d2-c18bd52c5cec@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <c778af08-7aac-ca35-30d2-c18bd52c5cec@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [virtio-comment] Re: [PATCH v9] virtio-net: support inner header
 hash

On Wed, Mar 01, 2023 at 11:30:37AM +0800, Heng Qi wrote:
> 
> 
> 在 2023/2/28 下午7:16, Michael S. Tsirkin 写道:
> > On Sat, Feb 18, 2023 at 10:37:15PM +0800, Heng Qi wrote:
> > > If the tunnel is used to encapsulate the packets, the hash calculated
> > > using the outer header of the receive packets is always fixed for the
> > > same flow packets, i.e. they will be steered to the same receive queue.
> > Wait a second. How is this true? Does not everyone stick the
> > inner header hash in the outer source port to solve this?
> > For example geneve spec says:
> > 
> >     it is necessary for entropy from encapsulated packets to be
> >     exposed in the tunnel header.  The most common technique for this is
> >     to use the UDP source port
> > 
> > same goes for vxlan did not check further.
> > 
> > so what is the problem?  and which tunnel types actually suffer from the
> > problem?
> 
> 
> In fact, similar to protocols such as GRE, there is no outer transport
> header.
> 
> Thanks.


Sorry I don't understand the answer. What is similar to what?
By GRE you mean NVGRE? That has FlowID for this purpose.
Only 8 bit - is this the issue? Not enough entropy?




-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

