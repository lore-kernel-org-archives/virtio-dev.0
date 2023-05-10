Return-Path: <virtio-dev-return-12621-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2407C7EE22
	for <virtio-dev@archiver.kernel.org>; Wed, 10 May 2023 06:05:36 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id D751660055
	for <virtio-dev@archiver.kernel.org>; Wed, 10 May 2023 06:05:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 203FE986654
	for <virtio-dev@archiver.kernel.org>; Wed, 10 May 2023 06:05:34 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 59288986575; Wed, 10 May 2023 06:05:33 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D31A298656B
	for <virtio-dev@lists.oasis-open.org>; Wed, 10 May 2023 06:05:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 0T9E-nJSMv-OwjLRG1hOGA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683698697; x=1686290697;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PZg9tavluvQxJfSivwkBBt66u0szBTHvYkt/rXK0IgU=;
        b=jTjZ651R0n0emowq/a9zodb/GpHq7sIARO+5RjJp474z8+6iYf8M7Q8bsbGLk//qOv
         LiUl/g/66uckIMkdRCWrea1XHo0wH1FHB+V7eDzQbZnyW5k3ciICEBFSPR651YijaNT6
         yhXboHo/EKOdS9AAcUYo9s4SdTJ/PeqhnnzzvnXkmjZo/kzVqT8EH3E0aFd+D3IJKNsr
         Vg6Fc+IN4kCz6hVrfduklUZIW2PNoM/R2bHCrkHmzzaka5edcV/hlLAisUUwznCLzqm+
         lP5uEj/T5T4zAVvTS+0U+Hl/5j8oSPwRS+2oxA1pQHGyNSXIKmeITab3dEjHeAE7Cm2C
         eQfQ==
X-Gm-Message-State: AC+VfDwngOr9JxLnbxpcRE+bRjBChr/ADOGwWeN8kWEIHQB6LuO6v6mq
	3MNOUA+ZhlWsqJXZUNDlwaLfZGcEUUIVliRqqGgWjBVtTPvFsFiyw2NjPkQvDT1xmuxfwdntGmh
	0e6h2pO+wyK+jNJkj86vXZ/KbciJD
X-Received: by 2002:a17:907:a04:b0:94a:8291:a1e3 with SMTP id bb4-20020a1709070a0400b0094a8291a1e3mr12709932ejc.74.1683698697096;
        Tue, 09 May 2023 23:04:57 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5vtTaguZXmxjEJnBOfx1C5MGZW8fb1/XCthyjcqlskWRywBo2ouPvf/aXDsXhrZDtuNIB5pA==
X-Received: by 2002:a17:907:a04:b0:94a:8291:a1e3 with SMTP id bb4-20020a1709070a0400b0094a8291a1e3mr12709912ejc.74.1683698696789;
        Tue, 09 May 2023 23:04:56 -0700 (PDT)
Date: Wed, 10 May 2023 02:04:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>, virtio-dev@lists.oasis-open.org,
	cohuck@redhat.com, david.edmondson@oracle.com, sburla@marvell.com,
	yishaih@nvidia.com, maorg@nvidia.com,
	virtio-comment@lists.oasis-open.org, shahafs@nvidia.com
Message-ID: <20230510014534-mutt-send-email-mst@kernel.org>
References: <20230506000135.628899-1-parav@nvidia.com>
 <CACGkMEt_2B68a+BZ4-vfeDf_eYj5ZhxrDNd6dxuiF85qr0yN2g@mail.gmail.com>
 <20230507093959-mutt-send-email-mst@kernel.org>
 <CACGkMEtfMbcu2OPsH6P2tA1aHh2FKygv=xkJ-e1XQzb62nE1vQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEtfMbcu2OPsH6P2tA1aHh2FKygv=xkJ-e1XQzb62nE1vQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v2 0/2] transport-pci: Introduce legacy registers access
 using AQ

On Mon, May 08, 2023 at 10:23:39AM +0800, Jason Wang wrote:
> > I thought so too originally. Unfortunately I now think that no, legacy is not
> > going to be a byproduct of transport virtqueue for modern -
> > it is different enough that it needs dedicated commands.
> 
> If you mean the transport virtqueue, I think some dedicated commands
> for legacy are needed. Then it would be a transport that supports
> transitional devices. It would be much better than having commands for
> a partial transport like this patch did.

OK I am beginning to get what you are saying.  So your criticism is
this: what if device supports vq transport for modern, and we want to
build a transitional device on top.  how will that look. yes?
A reasonable thing to include at least in the commit log. Parav?

You are also asking what if the device uses transport vq,
and we want transitional on top of that.
It's a fair question but I don't exactly get why would
this legacy support feature be wanted for the vq transport
and not for other transports.




> > Consider simplest case, multibyte fields. Legacy needs multibyte write,
> > modern does not even need multibyte read.
> 
> I'm not sure I will get here,

What does this mean?

> since we can't expose admin vq to
> guests, it means we need some software mediation. So if we just
> implement what PCI allows us, then everything would be fine (even if
> some method is not used).
> 
> Thanks

To repeat discussion on one of the previous versions, no it will not be
fine because legacy virtio abuses pci in fundamentally broken ways.
So yes you need a mediator on the host but even giving this
mediator a chance to be robust on top of hardware
means the hardware interface can not simply mirror legacy
to hardware.

For example, host mediator needs to trap writes into mac,
buffer them and then send a 6 byte write.
Now, pci actually does allow 6 byte writes, but legacy
guests instead to 6 single byte writes for portability reasons.
-- 
MSr


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

