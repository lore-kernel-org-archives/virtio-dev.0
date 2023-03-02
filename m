Return-Path: <virtio-dev-return-11356-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6C26C6FA8E
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 08:41:56 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id D14752AEEF
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 08:41:55 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A588F986681
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 08:41:55 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 822E8983EB8; Thu,  2 Mar 2023 08:41:55 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6FFA0986674
	for <virtio-dev@lists.oasis-open.org>; Thu,  2 Mar 2023 08:41:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: yMzMry2qO4WaegM_ReC60w-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677746512;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KJzormbq5qCp68GdglgcifpqMWxYvs4LEB7FrtsIBaY=;
        b=f+CZepVd4b0wYJukOMubydMCTe8FamDF/6O5bCtgA299qYe5SW2pe128ctOAspHBnI
         YqxVZT+FZmtkzjPR0HEdwhXoOabkRo2LMJ+DYKfrn8c4v9cOU9nUvD4XISG+omCmhRC6
         hQgOSjDAI2FO+58ANyuJ160VPC5SduoNBpJUm0cQfjSdgKQT7aUUTggdcsBAL+TXxAzh
         0fYHqSi8vnrun8pE3UBm2dEUyH2AUoXDUTWBhtlp+GyqP8+nSN3xUQln6mAhyRvxYkhG
         /F/tLFXUYzxPLoRy4pB1zLZKxhzkPrtfHWV7AWZ4f3EuidqYHc6PYnjw03xA24vIim+W
         I4Lw==
X-Gm-Message-State: AO0yUKUzvoXnhUGwJbXrZgOW1F7JcWf/k+xquQE2jZawcLNlONCVGCrk
	05fu7y4Z69YJNUYAu6fRSYQRLfLXCEuzB47p1By7jztOPKPnMI+d0Op8QhB8f8gsK52lBXxlSxq
	Y8KdWTYbvrzgjA/F5rhldDC4HF9AD
X-Received: by 2002:a05:600c:4ab0:b0:3eb:395b:19dc with SMTP id b48-20020a05600c4ab000b003eb395b19dcmr6923807wmp.9.1677746512373;
        Thu, 02 Mar 2023 00:41:52 -0800 (PST)
X-Google-Smtp-Source: AK7set9DNDi/weNh9gMvVeo9uJCJhQftJc+BkqkU2vBqDP0XgN5i89K/qh3sn7vTWJ7BNGmsHDIN4A==
X-Received: by 2002:a05:600c:4ab0:b0:3eb:395b:19dc with SMTP id b48-20020a05600c4ab000b003eb395b19dcmr6923791wmp.9.1677746512102;
        Thu, 02 Mar 2023 00:41:52 -0800 (PST)
Date: Thu, 2 Mar 2023 03:41:48 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, virtio-comment@lists.oasis-open.org,
	virtio-dev@lists.oasis-open.org, Parav Pandit <parav@nvidia.com>,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Message-ID: <20230302033958-mutt-send-email-mst@kernel.org>
References: <20230227124800-mutt-send-email-mst@kernel.org>
 <CACGkMEvUaQuzMx4iwkaYg9t9Bz2Ev0eHAwgrWbNEwtQHZOkkvQ@mail.gmail.com>
 <20230228060352-mutt-send-email-mst@kernel.org>
 <CACGkMEvAGABhk6JX7+F-sDtRM7t1oONEz9wrgKM7iShmyYV34A@mail.gmail.com>
 <20230301053407-mutt-send-email-mst@kernel.org>
 <CACGkMEsSCGo01WsLvDojB5s8yjqL1mV0s328DnssosnNO=4M4w@mail.gmail.com>
 <20230302024129-mutt-send-email-mst@kernel.org>
 <CACGkMEtLRhJ=4xiwRO96hb6HOdO8n1on62Gyu72aV6+MWag2jQ@mail.gmail.com>
 <20230302030935-mutt-send-email-mst@kernel.org>
 <CACGkMEs6Bz-t0TPR9vqH+iVY-w7z72ii-nvX+YhQkHG5Z8yWTQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEs6Bz-t0TPR9vqH+iVY-w7z72ii-nvX+YhQkHG5Z8yWTQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: Re: [virtio-dev] Re: [PATCH v9] virtio-net: support inner header hash

On Thu, Mar 02, 2023 at 04:15:39PM +0800, Jason Wang wrote:
> On Thu, Mar 2, 2023 at 4:10 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, Mar 02, 2023 at 03:57:10PM +0800, Jason Wang wrote:
> > > Kernel had already used the eBPF program for hashing, classifying
> > > various types of eBPF program other than XDP/socket filter
> > > (pass/drop).
> > >
> > > Thanks
> >
> > where is it used for hashing?
> 
> I can see it is used by team/lb:
> 
> static unsigned int lb_get_skb_hash(struct lb_priv *lb_priv,
>                                     struct sk_buff *skb)
> {
>         struct bpf_prog *fp;
>         uint32_t lhash;
>         unsigned char *c;
> 
>         fp = rcu_dereference_bh(lb_priv->fp);
>         if (unlikely(!fp))
>                 return 0;
>         lhash = bpf_prog_run(fp, skb);
>         c = (char *) &lhash;
>         return c[0] ^ c[1] ^ c[2] ^ c[3];
> }
> 
> But the point is that the return value is determined by the prog type
> (or the context).
> 
> Thanks

OK so assuming we do this, how will users program this exactly?
Given this is not standard, which tools will be used to attach such
a program to the device?


> >
> > --
> > MST
> >
> >
> > ---------------------------------------------------------------------
> > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> >


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

