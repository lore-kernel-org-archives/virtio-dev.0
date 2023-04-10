Return-Path: <virtio-dev-return-12077-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B854FC77B6F
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Apr 2023 06:15:09 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 2A7F626A52
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Apr 2023 06:15:09 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1F8C19863D1
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Apr 2023 06:15:09 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 162339862A5; Mon, 10 Apr 2023 06:15:09 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F13F898632A
	for <virtio-dev@lists.oasis-open.org>; Mon, 10 Apr 2023 06:15:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 4qUFUZtGOxa_pLYZRqZaGg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681107301;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZgKN1CFCIbPBrIWfoZPGnyMqR9jcuaJWNZZ6wVC8IAk=;
        b=raDwjKhjK27DQL1UVuK5MiaPj27g/QLawZO91fZqnw4BtmQk14VXJ2AG6ALwPtmEXV
         DCceNfsSEtWlCRhviWDWdgsosnv4kAHVOj8AZWDxCnAilefllSedh5fzlVR59STDRpfq
         Iz7UZhW+4ixLqH9Dh4ji2z5vUtRWtw3UeikYNIm+EBVoqJcowCG5aOBJzpdW0M2lI8TH
         w7GheaFXU3vgISS4oqGjscSpmIEG/RBP0Apc1LBoOD9G7A/BRpAdsGmjs1FJrxB15fDm
         0j/M0P1BvT+DxySiklGxBAgd2abb/nQP3Q+cOYncgEfwgIF98vbaD+sesPNNGhe/gYPN
         7JUw==
X-Gm-Message-State: AAQBX9dO5sk1p7fWalYjzqW/f7IV9SaDH5B6vKi3qGZgyL4BmZgu2ylP
	+kFtzSnvi3ekMYKxeWnB0sZy+eGXcEEdlUXkLbXU4juJZaZo0+v4T/GtNsOKAU/JglmP8qfuWPw
	e6LxC3Hie1giEBizbl+toRDabFejr
X-Received: by 2002:a05:600c:ac3:b0:3ee:1084:aa79 with SMTP id c3-20020a05600c0ac300b003ee1084aa79mr5355216wmr.20.1681107301589;
        Sun, 09 Apr 2023 23:15:01 -0700 (PDT)
X-Google-Smtp-Source: AKy350bs2Ukuy6eYTykw4jInyYwLWinYsLgQ8dNKJfU5z0p0EbE/qTiUHxVWbR52gLQ9LNdMbdTdQg==
X-Received: by 2002:a05:600c:ac3:b0:3ee:1084:aa79 with SMTP id c3-20020a05600c0ac300b003ee1084aa79mr5355203wmr.20.1681107301278;
        Sun, 09 Apr 2023 23:15:01 -0700 (PDT)
Date: Mon, 10 Apr 2023 02:14:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>, virtio-dev@lists.oasis-open.org,
	cohuck@redhat.com, virtio-comment@lists.oasis-open.org,
	shahafs@nvidia.com, Satananda Burla <sburla@marvell.com>
Message-ID: <20230410020906-mutt-send-email-mst@kernel.org>
References: <20230330225834.506969-1-parav@nvidia.com>
 <20230330225834.506969-10-parav@nvidia.com>
 <20230407043841-mutt-send-email-mst@kernel.org>
 <CACGkMEtkOdwixxaRz2Pv9xP75vb13ncboX5XRs8NqFCUsS16aQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEtkOdwixxaRz2Pv9xP75vb13ncboX5XRs8NqFCUsS16aQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] Re: [PATCH 09/11] transport-pci: Describe PCI
 MMR dev config registers

On Mon, Apr 10, 2023 at 09:33:32AM +0800, Jason Wang wrote:
> This is fine for vDPA but not for virtio if the design can only work
> for some specific setups (OSes/archs).
> 
> Thanks

Well virtio legacy has a long history of documenting existing hacks :)
But yes, VIRTIO_F_ORDER_PLATFORM has to be documented.
And we have to decide what to do about ACCESS_PLATFORM since
there's a security problem if device allows not acking it.
Two options:
- relax the rules a bit and say device will assume ACCESS_PLATFORM
  is acked anyway
- a new flag that is insecure (so useful for sec but useless for dpdk) but optional

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

