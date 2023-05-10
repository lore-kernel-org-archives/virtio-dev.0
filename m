Return-Path: <virtio-dev-return-12633-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 138B5C77B7C
	for <virtio-dev@archiver.kernel.org>; Wed, 10 May 2023 16:16:39 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 6232C1922EA
	for <virtio-dev@archiver.kernel.org>; Wed, 10 May 2023 16:16:38 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 597E89865D0
	for <virtio-dev@archiver.kernel.org>; Wed, 10 May 2023 16:16:38 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 4D7249865A1; Wed, 10 May 2023 16:16:38 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 36D129865AB
	for <virtio-dev@lists.oasis-open.org>; Wed, 10 May 2023 16:16:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 7Ou6lc_JM961FD_KzPYMvg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683735389; x=1686327389;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zeiuNFXuHQGuBaNYA+9qNqlmAF3hhFiU4BOpvZqDbnw=;
        b=FUBHZfQNaVcDbY7kepRd046HXJ7M/Uh4X9/lQitZKMX/FI7gzcnRR3BAT/qwrH/VY4
         mVT6Tee3YgkE6Q9DaJeacO5ingHoTeZ2SKabTE7dvxic+9/GdGaP0GW1YeHwfskqm/rs
         mh2vXo5thvJ3XZLqf67gM+nfIMxDS1bovBmb7kO64vXeRbWAw2pKZ03/E/IvjZQ34LiW
         aQYu5x9BjgOJpXqsWPONr3x+M2jYKwsnV6wjh3G5Qdkk1+qtn7n7XHLumsPe5GeTmweB
         Mr3u5OqOuGzrJFcDtmmSkjBgHN6C+viPepO9b8m2saFH6e5AVo9OS/PZ+RhoyttUhwVC
         Li4g==
X-Gm-Message-State: AC+VfDz/Co8f/M1laT2nuXNik3fRiPrEz1ePNwbMPsvPN25hKJPHJ9SN
	5TV9B9sQZNtzDfflZHmR1BNzhjEVwYL2gh3y20wvDHwI1J1mhEAkmQyzpx6EIeC5uAzSHGD/LQ7
	j0uQgrSSVYWuC3JCfU4zsQWFyieg/
X-Received: by 2002:a05:600c:21cf:b0:3f4:2aeb:30d with SMTP id x15-20020a05600c21cf00b003f42aeb030dmr4304517wmj.4.1683735389374;
        Wed, 10 May 2023 09:16:29 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ508bedg+fTzTed9XhR3O5gi8kgMQ19AjrvjGjdTM39jMd5n0IF1irMOjpd6359ktLN5Taw6A==
X-Received: by 2002:a05:600c:21cf:b0:3f4:2aeb:30d with SMTP id x15-20020a05600c21cf00b003f42aeb030dmr4304498wmj.4.1683735389105;
        Wed, 10 May 2023 09:16:29 -0700 (PDT)
Date: Wed, 10 May 2023 12:16:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Jason Wang <jasowang@redhat.com>, virtio-dev@lists.oasis-open.org,
	cohuck@redhat.com, david.edmondson@oracle.com, sburla@marvell.com,
	yishaih@nvidia.com, maorg@nvidia.com,
	virtio-comment@lists.oasis-open.org, shahafs@nvidia.com
Message-ID: <20230510121417-mutt-send-email-mst@kernel.org>
References: <20230506000135.628899-1-parav@nvidia.com>
 <CACGkMEt_2B68a+BZ4-vfeDf_eYj5ZhxrDNd6dxuiF85qr0yN2g@mail.gmail.com>
 <20230507093959-mutt-send-email-mst@kernel.org>
 <CACGkMEtfMbcu2OPsH6P2tA1aHh2FKygv=xkJ-e1XQzb62nE1vQ@mail.gmail.com>
 <20230510014534-mutt-send-email-mst@kernel.org>
 <43ec1c8d-7d11-2400-3649-1fe366b1e21b@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <43ec1c8d-7d11-2400-3649-1fe366b1e21b@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v2 0/2] transport-pci: Introduce legacy registers access
 using AQ

On Wed, May 10, 2023 at 12:11:50PM -0400, Parav Pandit wrote:
> 
> 
> On 5/10/2023 2:04 AM, Michael S. Tsirkin wrote:
> > On Mon, May 08, 2023 at 10:23:39AM +0800, Jason Wang wrote:
> > > > I thought so too originally. Unfortunately I now think that no, legacy is not
> > > > going to be a byproduct of transport virtqueue for modern -
> > > > it is different enough that it needs dedicated commands.
> > > 
> > > If you mean the transport virtqueue, I think some dedicated commands
> > > for legacy are needed. Then it would be a transport that supports
> > > transitional devices. It would be much better than having commands for
> > > a partial transport like this patch did.
> > 
> > OK I am beginning to get what you are saying.  So your criticism is
> > this: what if device supports vq transport for modern, and we want to
> > build a transitional device on top.  how will that look. yes?
> > A reasonable thing to include at least in the commit log. Parav?
> > 
> I am still trying to understand what is "vq transport for modern"?
> Do you mean transporting currently defined config space access over vq?
> If so, is this VQ belong to the guest or hypervisor?

https://lore.kernel.org/all/20220826100034.200432-2-lingshan.zhu%40intel.com/t.mbox.gz

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

