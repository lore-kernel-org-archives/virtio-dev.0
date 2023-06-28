Return-Path: <virtio-dev-return-13124-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5D53EB64D7
	for <virtio-dev@archiver.kernel.org>; Wed, 28 Jun 2023 15:41:14 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id D55CEC8DE6
	for <virtio-dev@archiver.kernel.org>; Wed, 28 Jun 2023 15:41:13 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C480C98658B
	for <virtio-dev@archiver.kernel.org>; Wed, 28 Jun 2023 15:41:13 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id AFAED986585; Wed, 28 Jun 2023 15:41:13 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9B81C986587
	for <virtio-dev@lists.oasis-open.org>; Wed, 28 Jun 2023 15:41:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: uZzuH_beO0ivWAiqxxtt7Q-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687966867; x=1690558867;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1T9eVthjOMHTWY4Y0Ln9fmXrWL3wVn8OipVUuvz5zes=;
        b=fUX0ngRjpHmlcvcUFQoy/xysGie6Nwf5/xZCJRduVWwM5qMlwLsuCxWfDgCNkgzsEH
         3mrN0pauGbYs2VM0nXCxmxWWYtQT+lO6jYbvM8Kl7v0TTHPCCIIWhQ9RhY3e5nFeErhd
         F7ZjUSAJxpCNreexMA7Zd1QVBpF7a4TkihtE/7iBmie91hBFATnUN5HZkyOx4Tp1TdYP
         +SD6PrjCRnPtiaXlOJAkbXqbfyz7WGKu14xSL48LB0seikhstaUSMjeOeymuMN/KSEjB
         x1KtqTzB5Soq4C5/PQW8Eh+un4C4PnWWHn7iv1rEoXlrzJc5EG1hEcZ+xk81JguzMJ6B
         21WA==
X-Gm-Message-State: AC+VfDwt/ha8zCYWzFj44q7FP/9AE581mpc22RiWu6+TRfrINnzpogbN
	e6Xp0IaBh5aoo4m8EePI9j3jlK8tG3HQANZulWoLbYoTxGpS5YSiNnOBttCTjvd9F3XTblSIcFa
	+L5ZlHzFP9VSlqhgDCjUCDC/s/NDm
X-Received: by 2002:a7b:c8c2:0:b0:3f7:5d:49ff with SMTP id f2-20020a7bc8c2000000b003f7005d49ffmr40659463wml.1.1687966866880;
        Wed, 28 Jun 2023 08:41:06 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6OwTcqfIyNiLFhS5JPpwRHmT3rs28ProjVx11/UiqtwbgEJDvoyTl8GzBGx24rR5aDHbHfZQ==
X-Received: by 2002:a7b:c8c2:0:b0:3f7:5d:49ff with SMTP id f2-20020a7bc8c2000000b003f7005d49ffmr40659444wml.1.1687966866546;
        Wed, 28 Jun 2023 08:41:06 -0700 (PDT)
Date: Wed, 28 Jun 2023 11:41:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtio-dev@lists.oasis-open.org, parav@nvidia.com,
	virtio-comment@lists.oasis-open.org,
	Jason Wang <jasowang@redhat.com>,
	"Zhu, Lingshan" <lingshan.zhu@intel.com>
Message-ID: <20230628112107-mutt-send-email-mst@kernel.org>
References: <20230626062210.49020-1-xuanzhuo@linux.alibaba.com>
 <1687854185.3344731-3-xuanzhuo@linux.alibaba.com>
 <20230627115247-mutt-send-email-mst@kernel.org>
 <1687918864.3728812-2-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <1687918864.3728812-2-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] [RFC PATCH] admin-queue: bind the group member
 to the device

On Wed, Jun 28, 2023 at 10:21:04AM +0800, Xuan Zhuo wrote:
> On Tue, 27 Jun 2023 12:02:41 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Tue, Jun 27, 2023 at 04:23:05PM +0800, Xuan Zhuo wrote:
> > > So, this is how I understand the process of creating vf:
> > >
> > > 1. Create a PCI VF, at this time there may be no backend virtio device, or there
> > >     is only a default backend. It does not fully meet our expectations.
> > > 2. Create device or migrate device
> > > 3. Bind the backend virtio device to the vf
> >
> > I can see this making sense as a feature bit that says VFs are not
> > initialized by default and must first be setup through an admin command.
> > This will likely need to be a feature bit because it's changing
> > behaviour outside of admin commands.
> >
> > Then, we can have:
> >
> > 	ADMIN_SETUP VF#
> > 	ADMIN_CLEANUP VF#
> >
> > I like this because this generalizes CREATE/DESTROY that SIOV guys proposed.
> 
> Great!!
> 
> >
> >
> > Why do we need an id as a level of indirection though? What is wrong
> > with just using VF# directly?
> 
> I think VF# is ok. I also need to use it. But we need an ID for virtio device
> not the transport(PF, VF).
> 
> What I want to emphasize is that PCI(pf or vf) is a transport, it is only used
> to connect the virtio driver and the virtio device. Right?
> 
> The virtio device does not necessarily exist depending on PCI. For example, a
> virtio device is migrated from another DPU, and it is not associated with any
> PCI. What I have always wanted to say is that this device(not PCI) must have its
> own ID, which has nothing to do with the transport.
> 
> Now we want to use this migrated device and connect it to the corresponding
> vm (migrated from the same host). We can passthrough vf to this vm. But how do I
> tell our DPU to bind this migrated device with this vf?
> We can specify the VF by the VF#, but how can we specify the virtio device?
> Maybe there are two migrated virtio device.
> 
> Maybe we should compare it to the case of using PF directly before. The biggest
> difference here is that PF is directly hot-plugged by the DPU, so when a
> user(custom) buys a virtio-net device, the DPU directly inserts a new PCI device
> on the host. Now the vf is created by the user, and only the user knows how to
> use each one. We cannot directly bind the device purchased or migrated by the
> user to a certain vf. We need the user in the host to bind the vf(transport) to
> a certain virtio device.
> 
> Thanks.
> 
> 

Maybe I didn't have enough coffee today but I can't figure out what all
this means :( For example what does "exist depending" mean?  What does
"device is migrated" mean?  What does it mean to be "migrated from the
same host"? What is "any PCI"? E.g. I know people did vm migration
moving virtio from a hardware device to a software
implementation. Is that "not associated with any PCI" ?
What is "user(custom)"? how is "the vf is created by the user"?
what does it mean to "bind the device .. to a certain vf"?
It looks like Parav understand what's going on though, so
maybe it's my fault.

But fundamentally, the problem is that the spec patch doesn't do
anything useful by itself, it relies on some out of spec interface to
make these id values make sense. So the TC is reduced to guessing: we
could just trust you that it's useful somehow and at the same time
serves the purpose whatever it is.

But it would be better if instead of trying to explain what that does in
vague terms, you post a spec patch that allows doing whatever needs
doing for these IDs to make sense through e.g. admin commands.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

