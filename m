Return-Path: <virtio-dev-return-13148-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F09BEB64D9
	for <virtio-dev@archiver.kernel.org>; Thu, 29 Jun 2023 11:54:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 8258576043
	for <virtio-dev@archiver.kernel.org>; Thu, 29 Jun 2023 11:54:33 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 60E5D986633
	for <virtio-dev@archiver.kernel.org>; Thu, 29 Jun 2023 11:54:33 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 4980B9865A8; Thu, 29 Jun 2023 11:54:33 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 368C09865CA
	for <virtio-dev@lists.oasis-open.org>; Thu, 29 Jun 2023 11:54:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: vNnFGvX8Oly-LmbMzYBGtw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688039669; x=1690631669;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b9DQVVlJRuS0z0N/6y6cvre/aIGM6+4+EqNJUrUKLh0=;
        b=Ank5/ELO6bUVdjST8khlLrgJZiR/37r/wS/qSYgb+lJIK0hi1JRHEyePcEpK7rTC7D
         WzXZo2kr4udJbEXG/LCc5dy/uJAXDwXGzC9mAOuAeNcXGdXD26aX5Etyb5hS+AD9rokg
         XiDhLX2WgO1JEK21cwKIYWxw8GOgfHXwaIjkQjoQi9m7D7rA0NaZs1bsvOZJTcTxX6Gp
         IdTbedjkNd/RP2InNFve/CD9lWnrmjw1ucFeuaRvrJRrxg62En9DBdJNTguOzLZWWpyO
         Yxd4hz+eNpylNOtQN49TBQd8ViTbAHamQ3QnueQm7Up4i3jbYZ+5gYWOAa2cz7Amuim+
         f3GQ==
X-Gm-Message-State: AC+VfDzk5OLizdW4L8NRbD0ddzddSXmGnR+QLF9242FXCPurSLqfitVM
	LvdlxGc6wfoVB1Z5Zqo32N+S19iqGNXFM/pwn8eFWq3rs6iw6fFqy//92kW7gvbDWlaYX8lRYki
	PvdBI0Zl/3Az0Akfomrf0r8cV8ylI
X-Received: by 2002:a05:6000:118d:b0:313:fca5:9079 with SMTP id g13-20020a056000118d00b00313fca59079mr6224254wrx.59.1688039669561;
        Thu, 29 Jun 2023 04:54:29 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ63xHKcE9RRSMH85CFAlOgVv9Dsmk1ID8ehrw+nBPfHz8woCCsiP9Ah09CTjWIYPX0xHUM4ZA==
X-Received: by 2002:a05:6000:118d:b0:313:fca5:9079 with SMTP id g13-20020a056000118d00b00313fca59079mr6224240wrx.59.1688039669151;
        Thu, 29 Jun 2023 04:54:29 -0700 (PDT)
Date: Thu, 29 Jun 2023 07:54:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, virtio-comment@lists.oasis-open.org,
	virtio-dev@lists.oasis-open.org, Parav Pandit <parav@nvidia.com>,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Message-ID: <20230629074925-mutt-send-email-mst@kernel.org>
References: <20230627163549.40028-1-hengqi@linux.alibaba.com>
 <CACGkMEvFmAiWDp8w=ytin21Oi+PcTb1X3Eve7Kt2NVr_RkhgmA@mail.gmail.com>
 <20230628060519-mutt-send-email-mst@kernel.org>
 <2522ab61-a333-a33b-784c-01ea6b4b42da@redhat.com>
MIME-Version: 1.0
In-Reply-To: <2522ab61-a333-a33b-784c-01ea6b4b42da@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [virtio-comment] Re: [PATCH v19] virtio-net: support inner
 header hash

On Thu, Jun 29, 2023 at 11:31:58AM +0800, Jason Wang wrote:
> 
> 在 2023/6/28 18:10, Michael S. Tsirkin 写道:
> > On Wed, Jun 28, 2023 at 11:46:22AM +0800, Jason Wang wrote:
> > > On Wed, Jun 28, 2023 at 12:35 AM Heng Qi <hengqi@linux.alibaba.com> wrote:
> > > > 1. Currently, a received encapsulated packet has an outer and an inner header, but
> > > > the virtio device is unable to calculate the hash for the inner header. The same
> > > > flow can traverse through different tunnels, resulting in the encapsulated
> > > > packets being spread across multiple receive queues (refer to the figure below).
> > > > However, in certain scenarios, we may need to direct these encapsulated packets of
> > > > the same flow to a single receive queue. This facilitates the processing
> > > > of the flow by the same CPU to improve performance (warm caches, less locking, etc.).
> > > > 
> > > >                 client1                    client2
> > > >                    |        +-------+         |
> > > >                    +------->|tunnels|<--------+
> > > >                             +-------+
> > > >                                |  |
> > > >                                v  v
> > > >                        +-----------------+
> > > >                        | monitoring host |
> > > >                        +-----------------+
> > > > 
> > > > To achieve this, the device can calculate a symmetric hash based on the inner headers
> > > > of the same flow.
> > > > 
> > > > 2. For legacy systems, they may lack entropy fields which modern protocols have in
> > > > the outer header, resulting in multiple flows with the same outer header but
> > > > different inner headers being directed to the same receive queue. This results in
> > > > poor receive performance.
> > > > 
> > > > To address this limitation, inner header hash can be used to enable the device to advertise
> > > > the capability to calculate the hash for the inner packet, regaining better receive performance.
> > > > 
> > > > Fixes: https://github.com/oasis-tcs/virtio-spec/issues/173
> > > > Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> > > > Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > Reviewed-by: Parav Pandit <parav@nvidia.com>
> > > > ---
> > > > v18->v19:
> > > >          1. Have a single structure instead of two. @Michael S . Tsirkin
> > > >          2. Some small rewrites. @Michael S . Tsirkin
> > > >          3. Rebase to master.
> > > > 
> > > > v17->v18:
> > > >          1. Some rewording suggestions from Michael (Thanks!).
> > > >          2. Use 0 to disable inner header hash and remove
> > > >             VIRTIO_NET_HASH_TUNNEL_TYPE_NONE.
> > > > v16->v17:
> > > >          1. Some small rewrites. @Parav Pandit
> > > >          2. Add Parav's Reviewed-by tag (Thanks!).
> > > > 
> > > > v15->v16:
> > > >          1. Remove the hash_option. In order to delimit the inner header hash and RSS
> > > >             configuration, the ability to configure the outer src udp port hash is given
> > > >             to RSS. This is orthogonal to inner header hash, which will be done in the
> > > >             RSS capability extension topic (considered as an RSS extension together
> > > >             with the symmetric toeplitz hash algorithm, etc.). @Parav Pandit @Michael S . Tsirkin
> > > >          2. Fix a 'field' typo. @Parav Pandit
> > > > 
> > > > v14->v15:
> > > >          1. Add tunnel hash option suggested by @Michael S . Tsirkin
> > > >          2. Adjust some descriptions.
> > > > 
> > > > v13->v14:
> > > >          1. Move supported_hash_tunnel_types from config space into cvq command. @Parav Pandit
> > > I may miss some discussions, but this complicates the provisioning a lot.
> > > 
> > > Having it in the config space, then a type agnostic provisioning
> > > through config space + feature bits just works fine.
> > > 
> > > If we move it only via cvq, we need device specific provisioning interface.
> > > 
> > > Thanks
> > Yea that's what I said too. Debugging too.  I think we should build a
> > consistent solution that allows accessing config space through DMA,
> > separately from this effort.  Parav do you think you can live with this
> > approach so this specific proposal can move forward?
> 
> 
> We can probably go another way, invent a new device configuration space
> capability which fixed size like PCI configuration access capability?
> 
> struct virtio_pci_cfg_cap {
>         struct virtio_pci_cap cap;
>         u8 dev_cfg_data[4]; /* Data for device configuration space access.
> */
> };
> 
> So it won't grow as the size of device configuration space grows.
> 
> Thanks

It is true, it does not have to be DMA strictly speaking.

The basic issue is with synchronous access.

We can change the capability in some way to allow asynch then
that works. E.g. make device change length to 0 and driver
must poll before considering the operation done.

Having said that, this will increase # of VM exits even more.
Not a fan, DMA seems cleaner.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

