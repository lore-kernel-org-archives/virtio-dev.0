Return-Path: <virtio-dev-return-12623-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 974D6C77B7D
	for <virtio-dev@archiver.kernel.org>; Wed, 10 May 2023 07:43:30 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id CE2DF120D62
	for <virtio-dev@archiver.kernel.org>; Wed, 10 May 2023 07:43:29 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C231F9865CF
	for <virtio-dev@archiver.kernel.org>; Wed, 10 May 2023 07:43:29 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id B53CF986569; Wed, 10 May 2023 07:43:29 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9FE0798657F
	for <virtio-dev@lists.oasis-open.org>; Wed, 10 May 2023 07:43:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: EjYh_8zzORGcDdq4fZ56Gw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683704604; x=1686296604;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A1sh1CKFGV6rXJgC6lW/6Xlf36Ciy/6yh4KDr2YmBYQ=;
        b=N12azpfyG4raSb0t5HTTZZh6NIHFgzTqsRYFGO9wB6/lSLJ/9UhVGvodxL+HJAfkt5
         N4GWgwAS8irbjMcm18HCG2bxHWXlNADCuHC7vFcNuSpDDj/RmaPVg87Yl/bnBA1XJSFN
         IOlLoCZJWTt4nJRtmsJ/gDlmReXBSQ+X96Ya0i630wycZijjkwcug4KUWFsK/OJXr7dY
         WgGh2LdofuGQsD9CNnloKizUZ0SbNG9x1CiRPVjKhsjbDBSwRVZ00j9GBIv5PDuQD8E0
         DmRxx1DSpmpTwa0Et3Bc1gBAVErukKSgx3LcLmLRqFOJpHQ1HB0Nq9reIr+oSkK3m2VP
         3j2Q==
X-Gm-Message-State: AC+VfDzD70iYrFaJTL9PSeM8tX4Ui52eY1+HgRwqX5imdYxIe9YvRCW0
	QHYUto7iV+rrv3NjyiVYUpKp5okq1sTCvNzGeLZYlCMVs2voJBPTkUWJLBT5Mahi6jLY4Eb5kHX
	acy1r3W2F9LHlffixYY7kGcjGoAjP
X-Received: by 2002:adf:f946:0:b0:306:32fa:6750 with SMTP id q6-20020adff946000000b0030632fa6750mr10394945wrr.33.1683704603829;
        Wed, 10 May 2023 00:43:23 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4SadztY4vFL7iJapGYUEoNJtdlvTMcycschUtXXzK3HYQczfB4K7cek5/2mWE5uY45hVMSzg==
X-Received: by 2002:adf:f946:0:b0:306:32fa:6750 with SMTP id q6-20020adff946000000b0030632fa6750mr10394929wrr.33.1683704603520;
        Wed, 10 May 2023 00:43:23 -0700 (PDT)
Date: Wed, 10 May 2023 03:43:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>, virtio-dev@lists.oasis-open.org,
	cohuck@redhat.com, david.edmondson@oracle.com, sburla@marvell.com,
	yishaih@nvidia.com, maorg@nvidia.com,
	virtio-comment@lists.oasis-open.org, shahafs@nvidia.com
Message-ID: <20230510033812-mutt-send-email-mst@kernel.org>
References: <20230506000135.628899-1-parav@nvidia.com>
 <CACGkMEt_2B68a+BZ4-vfeDf_eYj5ZhxrDNd6dxuiF85qr0yN2g@mail.gmail.com>
 <20230507093959-mutt-send-email-mst@kernel.org>
 <CACGkMEtfMbcu2OPsH6P2tA1aHh2FKygv=xkJ-e1XQzb62nE1vQ@mail.gmail.com>
 <20230510014534-mutt-send-email-mst@kernel.org>
 <CACGkMEvTs9oMewgrQpYZu1v1wdUXtxsvjqB6CPRf+y4C8EN_KQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEvTs9oMewgrQpYZu1v1wdUXtxsvjqB6CPRf+y4C8EN_KQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [PATCH v2 0/2] transport-pci: Introduce legacy registers access
 using AQ

On Wed, May 10, 2023 at 03:01:25PM +0800, Jason Wang wrote:
> On Wed, May 10, 2023 at 2:05 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
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
> 
> Yes. I think it needs to be done through the transport virtqueue
> otherwise the transport is not self-contained.

I mean, any feature can be done over transport vq.

But there is value in adding legacy commands to an otherwise
modern device without reworking it completely to
switch to a different transport.


> > A reasonable thing to include at least in the commit log. Parav?
> >
> > You are also asking what if the device uses transport vq,
> > and we want transitional on top of that.
> > It's a fair question but I don't exactly get why would
> > this legacy support feature be wanted for the vq transport
> > and not for other transports.
> 
> Not sure I get the question, but all the existing transport support
> legacy, if we want to have another, should the legacy support be a
> must or not?

This specific proposal is for tunneling legacy over admin vq.
It can live alongside a normal modern VF, with hypervisor
combining these to create a transitional device.

> >
> >
> >
> >
> > > > Consider simplest case, multibyte fields. Legacy needs multibyte write,
> > > > modern does not even need multibyte read.
> > >
> > > I'm not sure I will get here,
> >
> > What does this mean?
> 
> I meant I don't get what the issue if "modern does not even need
> multibyte read".

parse error again. reword?

> >
> > > since we can't expose admin vq to
> > > guests, it means we need some software mediation. So if we just
> > > implement what PCI allows us, then everything would be fine (even if
> > > some method is not used).
> > >
> > > Thanks
> >
> > To repeat discussion on one of the previous versions, no it will not be
> > fine because legacy virtio abuses pci in fundamentally broken ways.
> > So yes you need a mediator on the host but even giving this
> > mediator a chance to be robust on top of hardware
> > means the hardware interface can not simply mirror legacy
> > to hardware.
> >
> > For example, host mediator needs to trap writes into mac,
> > buffer them and then send a 6 byte write.
> > Now, pci actually does allow 6 byte writes, but legacy
> > guests instead to 6 single byte writes for portability reasons.
> 
> It's a known race condition, so PCI over adminq doesn't make it worse.

it can however make it better - you can do a single 6 byte write command.

> The mediator can just mirror what guests write over the admin
> commands.

and this "just" just isn't good enough, or we end up with hacks
in hardware.

> Thanks
> 
> > --
> > MSr
> >


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

