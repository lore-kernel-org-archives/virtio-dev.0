Return-Path: <virtio-dev-return-11358-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 075E1C6FA8E
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 09:46:41 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 117122B058
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 09:46:41 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0087998667D
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 09:46:40 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id DED05983EB8; Thu,  2 Mar 2023 09:46:40 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CB602986674
	for <virtio-dev@lists.oasis-open.org>; Thu,  2 Mar 2023 09:46:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: ECwmN8sgNgWCUEilAfDx7A-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677750397;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LQTifb51tw9g7mS63iwkIQ6QERZF9DLNql3FrFljng8=;
        b=yPEBpMatEWMrXdMwcXTVj8uhC7RDxrqaQYCv35Y8pGExvv/7JCeoIFZNqES3u6g03G
         zOHAvPc4JtUdzYVCkSNNhVGYtB40zzfCljwzbvis+d7k/oA0MpuuqdAmiUvuphLsvKeN
         XLtEtdi48iAvkpx5T2DN7/O6IXSpWjOTPsWniKcjnZbI5iOImr0XBc19zaSNLcCJ0cQ5
         xBK767cGY1ST/oRcHYZbbnXgsq0K1JoMGhvMmIm9+MXzOvrepclcbL/q4eLW4XKCa2OM
         WjKSh8KZFDm57+noA3l7NpBxDqNPRF12waPOyXFnB1Uujzz9WiN7soNWPBM0iAje2ryS
         QH1g==
X-Gm-Message-State: AO0yUKVuQfYWERPfur/YGkuwwqaaUaaD2UBdXHGReaoul7xeTy724r1U
	v88vEogp8tz4xvjUUXtiM0M32Dpm9ypsgoBgpC9ZNnpUMSxEtdll5I6bYMJJ72T2Ix2qplnJz03
	MnSBBcsD+3dwdSDOgcJDu8WcKyGGv
X-Received: by 2002:a5d:63c9:0:b0:2c3:d707:7339 with SMTP id c9-20020a5d63c9000000b002c3d7077339mr1001408wrw.6.1677750397767;
        Thu, 02 Mar 2023 01:46:37 -0800 (PST)
X-Google-Smtp-Source: AK7set9h++uN+toAQ5p0Pyop1Dfk7zzgjOmJh9Zw7z9iNBQZJYwkpxub55cwyv1AgrleAwV3FhetXw==
X-Received: by 2002:a5d:63c9:0:b0:2c3:d707:7339 with SMTP id c9-20020a5d63c9000000b002c3d7077339mr1001395wrw.6.1677750397481;
        Thu, 02 Mar 2023 01:46:37 -0800 (PST)
Date: Thu, 2 Mar 2023 04:46:33 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, virtio-comment@lists.oasis-open.org,
	virtio-dev@lists.oasis-open.org, Parav Pandit <parav@nvidia.com>,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Message-ID: <20230302044009-mutt-send-email-mst@kernel.org>
References: <20230228060352-mutt-send-email-mst@kernel.org>
 <CACGkMEvAGABhk6JX7+F-sDtRM7t1oONEz9wrgKM7iShmyYV34A@mail.gmail.com>
 <20230301053407-mutt-send-email-mst@kernel.org>
 <CACGkMEsSCGo01WsLvDojB5s8yjqL1mV0s328DnssosnNO=4M4w@mail.gmail.com>
 <20230302024129-mutt-send-email-mst@kernel.org>
 <CACGkMEtLRhJ=4xiwRO96hb6HOdO8n1on62Gyu72aV6+MWag2jQ@mail.gmail.com>
 <20230302030935-mutt-send-email-mst@kernel.org>
 <CACGkMEs6Bz-t0TPR9vqH+iVY-w7z72ii-nvX+YhQkHG5Z8yWTQ@mail.gmail.com>
 <20230302033958-mutt-send-email-mst@kernel.org>
 <CACGkMEvNXaA0uTffiQaDL311En-L4MYJpdOZDMX4EQ4QpQvj2w@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEvNXaA0uTffiQaDL311En-L4MYJpdOZDMX4EQ4QpQvj2w@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: Re: [virtio-dev] Re: [PATCH v9] virtio-net: support inner header hash

On Thu, Mar 02, 2023 at 04:59:46PM +0800, Jason Wang wrote:
> On Thu, Mar 2, 2023 at 4:41 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, Mar 02, 2023 at 04:15:39PM +0800, Jason Wang wrote:
> > > On Thu, Mar 2, 2023 at 4:10 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Thu, Mar 02, 2023 at 03:57:10PM +0800, Jason Wang wrote:
> > > > > Kernel had already used the eBPF program for hashing, classifying
> > > > > various types of eBPF program other than XDP/socket filter
> > > > > (pass/drop).
> > > > >
> > > > > Thanks
> > > >
> > > > where is it used for hashing?
> > >
> > > I can see it is used by team/lb:
> > >
> > > static unsigned int lb_get_skb_hash(struct lb_priv *lb_priv,
> > >                                     struct sk_buff *skb)
> > > {
> > >         struct bpf_prog *fp;
> > >         uint32_t lhash;
> > >         unsigned char *c;
> > >
> > >         fp = rcu_dereference_bh(lb_priv->fp);
> > >         if (unlikely(!fp))
> > >                 return 0;
> > >         lhash = bpf_prog_run(fp, skb);
> > >         c = (char *) &lhash;
> > >         return c[0] ^ c[1] ^ c[2] ^ c[3];
> > > }
> > >
> > > But the point is that the return value is determined by the prog type
> > > (or the context).
> > >
> > > Thanks
> >
> > OK so assuming we do this, how will users program this exactly?
> 
> For DPDK users, it could be integrated with the PMD.
> For kernel ueres, it probably requires a virtio specific netlink or char device.
> 
> > Given this is not standard, which tools will be used to attach such
> > a program to the device?
> 
> vDPA tool?
> 
> Thanks

Ugh.  I think I'd like ethtool to work.




> >
> >
> > > >
> > > > --
> > > > MST
> > > >
> > > >
> > > > ---------------------------------------------------------------------
> > > > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > > > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> > > >
> >


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

