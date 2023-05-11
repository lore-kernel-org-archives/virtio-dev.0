Return-Path: <virtio-dev-return-12647-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4845DC77B7C
	for <virtio-dev@archiver.kernel.org>; Thu, 11 May 2023 12:54:50 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 4A3CC8668E
	for <virtio-dev@archiver.kernel.org>; Thu, 11 May 2023 12:54:49 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 32AD99865F9
	for <virtio-dev@archiver.kernel.org>; Thu, 11 May 2023 12:54:49 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 1D65D9865D0; Thu, 11 May 2023 12:54:49 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0A4F69865E0
	for <virtio-dev@lists.oasis-open.org>; Thu, 11 May 2023 12:54:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: zZ6qLWUDOrKAJVJw9zGHcQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683809685; x=1686401685;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8k5+aZE86sGUiGUD6r0E9sJ4ItGnt3aSoV1iKFEsiwA=;
        b=S9Kk3RaqjNqkC6JzJ25x9WZM5qE87y11nayESwGp8vPI9+RFErCuQFhMSAedzPOV/T
         c5LwgWWaGG48mIjBJBdyg06c67VWveuvo/qRhbcjzbxsee0u/MbjoW28XpvswSgo11AN
         QMijJ5CnZgvK4h+tNgB4D3r0qrnHj3nsleWQ6lUPAcqsWv0uBCWaIYJkSROQhauPwyt5
         uaHp7L3q6Jr48kYc8S9kgi3JBZr8628NoXZhBjBxNDLSckFSvJ8s2674358fADqVNDY0
         r3hH/B/g7SM+DFjpCfCL1JpZc2icBaPBpn7mjbsLJS08h0FJRZQv2mXCxWVIaW8Q0o+0
         F52A==
X-Gm-Message-State: AC+VfDxXZEhRYJS5h7H3GrAItB9R1TlNd0FTHjSRZnO1F+YvbV+YOyUn
	7JxsEflH7MDnOYTu5gvTC3Iz4S3VwExm33PHrbalWvghoEtO9+A5cKYczOYHyNiNThmNKScfi2I
	7McJ/tM8peGjxch4V3YZUB/kRbrzN
X-Received: by 2002:a5d:4685:0:b0:306:4063:1afe with SMTP id u5-20020a5d4685000000b0030640631afemr16703531wrq.71.1683809685007;
        Thu, 11 May 2023 05:54:45 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5Ie1PgjJoVQ1ya0Rl+U/QguSka/mdtWQuC3nmFrzHSeCTYKHnTB80osR3KUMUNB8VFndHo1Q==
X-Received: by 2002:a5d:4685:0:b0:306:4063:1afe with SMTP id u5-20020a5d4685000000b0030640631afemr16703502wrq.71.1683809684613;
        Thu, 11 May 2023 05:54:44 -0700 (PDT)
Date: Thu, 11 May 2023 08:54:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>, virtio-dev@lists.oasis-open.org,
	cohuck@redhat.com, david.edmondson@oracle.com, sburla@marvell.com,
	yishaih@nvidia.com, maorg@nvidia.com,
	virtio-comment@lists.oasis-open.org, shahafs@nvidia.com
Message-ID: <20230511085205-mutt-send-email-mst@kernel.org>
References: <20230506000135.628899-1-parav@nvidia.com>
 <CACGkMEt_2B68a+BZ4-vfeDf_eYj5ZhxrDNd6dxuiF85qr0yN2g@mail.gmail.com>
 <20230507093959-mutt-send-email-mst@kernel.org>
 <CACGkMEtfMbcu2OPsH6P2tA1aHh2FKygv=xkJ-e1XQzb62nE1vQ@mail.gmail.com>
 <20230510014534-mutt-send-email-mst@kernel.org>
 <CACGkMEvTs9oMewgrQpYZu1v1wdUXtxsvjqB6CPRf+y4C8EN_KQ@mail.gmail.com>
 <20230510033812-mutt-send-email-mst@kernel.org>
 <CACGkMEsp0i7EyyBBp06wJzrVBLNbH7MP_TT-j7b5c_yavgAmqw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEsp0i7EyyBBp06wJzrVBLNbH7MP_TT-j7b5c_yavgAmqw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [PATCH v2 0/2] transport-pci: Introduce legacy registers access
 using AQ

On Thu, May 11, 2023 at 03:04:40PM +0800, Jason Wang wrote:
> On Wed, May 10, 2023 at 3:43 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Wed, May 10, 2023 at 03:01:25PM +0800, Jason Wang wrote:
> > > On Wed, May 10, 2023 at 2:05 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Mon, May 08, 2023 at 10:23:39AM +0800, Jason Wang wrote:
> > > > > > I thought so too originally. Unfortunately I now think that no, legacy is not
> > > > > > going to be a byproduct of transport virtqueue for modern -
> > > > > > it is different enough that it needs dedicated commands.
> > > > >
> > > > > If you mean the transport virtqueue, I think some dedicated commands
> > > > > for legacy are needed. Then it would be a transport that supports
> > > > > transitional devices. It would be much better than having commands for
> > > > > a partial transport like this patch did.
> > > >
> > > > OK I am beginning to get what you are saying.  So your criticism is
> > > > this: what if device supports vq transport for modern, and we want to
> > > > build a transitional device on top.  how will that look. yes?
> > >
> > > Yes. I think it needs to be done through the transport virtqueue
> > > otherwise the transport is not self-contained.
> >
> > I mean, any feature can be done over transport vq.
> >
> > But there is value in adding legacy commands to an otherwise
> > modern device without reworking it completely to
> > switch to a different transport.
> 
> There's probably no need for a rework since legacy is not complicated.
> More below.
> 
> >
> >
> > > > A reasonable thing to include at least in the commit log. Parav?
> > > >
> > > > You are also asking what if the device uses transport vq,
> > > > and we want transitional on top of that.
> > > > It's a fair question but I don't exactly get why would
> > > > this legacy support feature be wanted for the vq transport
> > > > and not for other transports.
> > >
> > > Not sure I get the question, but all the existing transport support
> > > legacy, if we want to have another, should the legacy support be a
> > > must or not?
> >
> > This specific proposal is for tunneling legacy over admin vq.
> > It can live alongside a normal modern VF, with hypervisor
> > combining these to create a transitional device.
> 
> Exactly, but what I meant here is
> 
> If we decide to use the admin vq, is there any good reason to tie it
> to PCI if we don't want to tunneling PCI over adminq?
> 
> Why not simply invent individual commands to access legacy facilities
> like commands to access like what transport virtqueue did for modern
> device?:
> 
> 1) device features
> 2) driver features
> 3) queue address
> 4) queue size
> 5) queue select
> 6) queue notify
> 7) device status
> 8) ISR status
> 9) config msix
> 10) queue msix
> 11) device configuration space
> 
> It focuses on the facilities instead of transport specific details
> like registers (we don't even need legacy registers in this case), I
> gives more deterministic behavior so we don't need to care about the
> cross registers read/write.

This needs thought, it is definitely more work.  Effort that could be
maybe spent on new features.  What is the motivation
here? supporting legacy mmio guests?


> >
> > > >
> > > >
> > > >
> > > >
> > > > > > Consider simplest case, multibyte fields. Legacy needs multibyte write,
> > > > > > modern does not even need multibyte read.
> > > > >
> > > > > I'm not sure I will get here,
> > > >
> > > > What does this mean?
> > >
> > > I meant I don't get what the issue if "modern does not even need
> > > multibyte read".
> >
> > parse error again. reword?
> 
> I meant we need two sets of command for legacy and modern. We can
> choose not to expose multibyte reads for modern commands.
> 
> >
> > > >
> > > > > since we can't expose admin vq to
> > > > > guests, it means we need some software mediation. So if we just
> > > > > implement what PCI allows us, then everything would be fine (even if
> > > > > some method is not used).
> > > > >
> > > > > Thanks
> > > >
> > > > To repeat discussion on one of the previous versions, no it will not be
> > > > fine because legacy virtio abuses pci in fundamentally broken ways.
> > > > So yes you need a mediator on the host but even giving this
> > > > mediator a chance to be robust on top of hardware
> > > > means the hardware interface can not simply mirror legacy
> > > > to hardware.
> > > >
> > > > For example, host mediator needs to trap writes into mac,
> > > > buffer them and then send a 6 byte write.
> > > > Now, pci actually does allow 6 byte writes, but legacy
> > > > guests instead to 6 single byte writes for portability reasons.
> > >
> > > It's a known race condition, so PCI over adminq doesn't make it worse.
> >
> > it can however make it better - you can do a single 6 byte write command.
> >
> 
> It would be tricky to detect when a legacy guest has finished writing
> to the mac.
> 
> > > The mediator can just mirror what guests write over the admin
> > > commands.
> >
> > and this "just" just isn't good enough, or we end up with hacks
> > in hardware.
> 
> Yes but this "issue" exists in this proposal as well.
> 
> Thanks
> 
> >
> > > Thanks
> > >
> > > > --
> > > > MSr
> > > >
> >


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

