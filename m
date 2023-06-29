Return-Path: <virtio-dev-return-13149-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AACDFEB64DC
	for <virtio-dev@archiver.kernel.org>; Thu, 29 Jun 2023 11:55:41 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 0E9108508B
	for <virtio-dev@archiver.kernel.org>; Thu, 29 Jun 2023 11:55:41 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EF97B986639
	for <virtio-dev@archiver.kernel.org>; Thu, 29 Jun 2023 11:55:40 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id E32AF9865CA; Thu, 29 Jun 2023 11:55:40 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D1F859865A8
	for <virtio-dev@lists.oasis-open.org>; Thu, 29 Jun 2023 11:55:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: NJtZeaC5PmKIlHJq5YZWVg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688039737; x=1690631737;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jON5Zm4Gwvo1ka51uxCxMPmcEgxBmFQ/OarQ7lKwJhU=;
        b=aOr+01eXwZyHgc8wudtUJLVk7h66EZD9+xXmEgMC24LLmyrnJWIkphFX+aGqdcaL9r
         fcwj4jC2BM08qJ1RJaIwQpYhsNM6cWbp6XX9ZpnKcuYelcVBh71eNWKajsC8Vvr7yhN4
         zZiK13RQqSlLxCZyXy0vaUg6uWnlJDRTPSZFyDgOECZL9SS9MkFl1skWT4+/INl4rauy
         OUyGJbyqA8dC575VNHB+KrsBIvScgGWLiU0ClRVRz1cXGM41qFI425JfpMJyOhT09E35
         sszioAn8BJbDZt42rqX7wQBO9cAHkIykDXeUkSpboHdUXNM500KTtn9Vm9daUMxlDAzV
         1QrA==
X-Gm-Message-State: AC+VfDyxtDpJlBHEBCumfvRPukEcUyFDGsg9XB5XO/DK3RWi9PJS4thh
	1q4T+QuDq2KCINXtvon2MJeqJ80wU+IkkXIQwwYmI8qVHRPGR7IoEbSxYIDPRKLrSugFTtqkgTV
	A7diBSiMWYNSAv7jAadPg2+hhzoV7
X-Received: by 2002:a05:6512:ad4:b0:4fb:76f7:fde9 with SMTP id n20-20020a0565120ad400b004fb76f7fde9mr9199045lfu.30.1688039737153;
        Thu, 29 Jun 2023 04:55:37 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5q/DOyWFCz8gkQgDVltGEwXr1cOVl4H+zJQhtRIJdnrDN1FlIR4BP0ibwsh+GGUALHBvcPNQ==
X-Received: by 2002:a05:6512:ad4:b0:4fb:76f7:fde9 with SMTP id n20-20020a0565120ad400b004fb76f7fde9mr9199038lfu.30.1688039736690;
        Thu, 29 Jun 2023 04:55:36 -0700 (PDT)
Date: Thu, 29 Jun 2023 07:55:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, virtio-comment@lists.oasis-open.org,
	virtio-dev@lists.oasis-open.org, Parav Pandit <parav@nvidia.com>,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Message-ID: <20230629075441-mutt-send-email-mst@kernel.org>
References: <20230627163549.40028-1-hengqi@linux.alibaba.com>
 <CACGkMEvFmAiWDp8w=ytin21Oi+PcTb1X3Eve7Kt2NVr_RkhgmA@mail.gmail.com>
 <20230628060519-mutt-send-email-mst@kernel.org>
 <2522ab61-a333-a33b-784c-01ea6b4b42da@redhat.com>
 <20230629074925-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230629074925-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [virtio-comment] Re: [PATCH v19] virtio-net: support inner
 header hash

On Thu, Jun 29, 2023 at 07:54:29AM -0400, Michael S. Tsirkin wrote:
> On Thu, Jun 29, 2023 at 11:31:58AM +0800, Jason Wang wrote:
> > 
> > 在 2023/6/28 18:10, Michael S. Tsirkin 写道:
> > > On Wed, Jun 28, 2023 at 11:46:22AM +0800, Jason Wang wrote:
> > > > On Wed, Jun 28, 2023 at 12:35 AM Heng Qi <hengqi@linux.alibaba.com> wrote:
> > > > > 1. Currently, a received encapsulated packet has an outer and an inner header, but
> > > > > the virtio device is unable to calculate the hash for the inner header. The same
> > > > > flow can traverse through different tunnels, resulting in the encapsulated
> > > > > packets being spread across multiple receive queues (refer to the figure below).
> > > > > However, in certain scenarios, we may need to direct these encapsulated packets of
> > > > > the same flow to a single receive queue. This facilitates the processing
> > > > > of the flow by the same CPU to improve performance (warm caches, less locking, etc.).
> > > > > 
> > > > >                 client1                    client2
> > > > >                    |        +-------+         |
> > > > >                    +------->|tunnels|<--------+
> > > > >                             +-------+
> > > > >                                |  |
> > > > >                                v  v
> > > > >                        +-----------------+
> > > > >                        | monitoring host |
> > > > >                        +-----------------+
> > > > > 
> > > > > To achieve this, the device can calculate a symmetric hash based on the inner headers
> > > > > of the same flow.
> > > > > 
> > > > > 2. For legacy systems, they may lack entropy fields which modern protocols have in
> > > > > the outer header, resulting in multiple flows with the same outer header but
> > > > > different inner headers being directed to the same receive queue. This results in
> > > > > poor receive performance.
> > > > > 
> > > > > To address this limitation, inner header hash can be used to enable the device to advertise
> > > > > the capability to calculate the hash for the inner packet, regaining better receive performance.
> > > > > 
> > > > > Fixes: https://github.com/oasis-tcs/virtio-spec/issues/173
> > > > > Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> > > > > Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > Reviewed-by: Parav Pandit <parav@nvidia.com>
> > > > > ---
> > > > > v18->v19:
> > > > >          1. Have a single structure instead of two. @Michael S . Tsirkin
> > > > >          2. Some small rewrites. @Michael S . Tsirkin
> > > > >          3. Rebase to master.
> > > > > 
> > > > > v17->v18:
> > > > >          1. Some rewording suggestions from Michael (Thanks!).
> > > > >          2. Use 0 to disable inner header hash and remove
> > > > >             VIRTIO_NET_HASH_TUNNEL_TYPE_NONE.
> > > > > v16->v17:
> > > > >          1. Some small rewrites. @Parav Pandit
> > > > >          2. Add Parav's Reviewed-by tag (Thanks!).
> > > > > 
> > > > > v15->v16:
> > > > >          1. Remove the hash_option. In order to delimit the inner header hash and RSS
> > > > >             configuration, the ability to configure the outer src udp port hash is given
> > > > >             to RSS. This is orthogonal to inner header hash, which will be done in the
> > > > >             RSS capability extension topic (considered as an RSS extension together
> > > > >             with the symmetric toeplitz hash algorithm, etc.). @Parav Pandit @Michael S . Tsirkin
> > > > >          2. Fix a 'field' typo. @Parav Pandit
> > > > > 
> > > > > v14->v15:
> > > > >          1. Add tunnel hash option suggested by @Michael S . Tsirkin
> > > > >          2. Adjust some descriptions.
> > > > > 
> > > > > v13->v14:
> > > > >          1. Move supported_hash_tunnel_types from config space into cvq command. @Parav Pandit
> > > > I may miss some discussions, but this complicates the provisioning a lot.
> > > > 
> > > > Having it in the config space, then a type agnostic provisioning
> > > > through config space + feature bits just works fine.
> > > > 
> > > > If we move it only via cvq, we need device specific provisioning interface.
> > > > 
> > > > Thanks
> > > Yea that's what I said too. Debugging too.  I think we should build a
> > > consistent solution that allows accessing config space through DMA,
> > > separately from this effort.  Parav do you think you can live with this
> > > approach so this specific proposal can move forward?
> > 
> > 
> > We can probably go another way, invent a new device configuration space
> > capability which fixed size like PCI configuration access capability?
> > 
> > struct virtio_pci_cfg_cap {
> >         struct virtio_pci_cap cap;
> >         u8 dev_cfg_data[4]; /* Data for device configuration space access.
> > */
> > };
> > 
> > So it won't grow as the size of device configuration space grows.
> > 
> > Thanks
> 
> It is true, it does not have to be DMA strictly speaking.
> 
> The basic issue is with synchronous access.
> 
> We can change the capability in some way to allow asynch then
> that works. E.g. make device change length to 0 and driver
> must poll before considering the operation done.
> 
> Having said that, this will increase # of VM exits even more.
> Not a fan, DMA seems cleaner.

And again, I am now guilty of this too - hijacking inner hash thread
for config space change discussions :(
Let's all stop please, start a new thread wen we are ready.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

