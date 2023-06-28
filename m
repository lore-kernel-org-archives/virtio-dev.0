Return-Path: <virtio-dev-return-13125-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCAC1EB64DA
	for <virtio-dev@archiver.kernel.org>; Wed, 28 Jun 2023 15:55:19 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 340F12ACAA
	for <virtio-dev@archiver.kernel.org>; Wed, 28 Jun 2023 15:55:19 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 27C589865D4
	for <virtio-dev@archiver.kernel.org>; Wed, 28 Jun 2023 15:55:19 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 16868986585; Wed, 28 Jun 2023 15:55:19 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0549B986587
	for <virtio-dev@lists.oasis-open.org>; Wed, 28 Jun 2023 15:55:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: pF_QB5aTPbi973EG6gG5Kg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687967712; x=1690559712;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oOTroCSDqT+KqOM3u7uDYxXlGX8PkbVwl8SWxjbUtUI=;
        b=Af7XWGv6VUCpWi8BfYPKHGYLMlNhyqWSdD8S7RA2+O8EeJVXvEOWdXkSTV7ea1bc3B
         j3wj8pyyQzt1SNaLKVSZ49BQH8GfUE4dOx2cqicZC2DJWNvWxxhnMUQx1Pya+jmg66Rb
         oA1dvw6SnTmCsZjMWMqVF/2pZx4FgCQwsnikbQ/wzC8oTLXmncglrHaVAd26hXtlXQL5
         D4aPBWjiUzRQMD4awaI+EkUTp/4xDQQ4s7pRKHUZ9q4XUXC8cP32wkffjQrZeTAHQ/BK
         6uiZCDvFUp5TymgYA320WZ7l+kRRR2KvrOrgSbzS//NwywYIVQzcfVv2iGwq9C1uP05x
         DINw==
X-Gm-Message-State: AC+VfDynmE8n0A46d49OQYuyJZrsmOSlMLe1yx4jdkkPWZ/jfoymT9HP
	nJt44mlJfX1DqxTBHRmohczOuaRheB5iPrlQ45EsMfBS6TZG2bNeQprro+WiqBqQAOaapu2RkZb
	8fK5v1RxBdgllgLAfQ15s4CAT3GxNH8VTAz6aoe8=
X-Received: by 2002:a05:600c:2051:b0:3f7:3545:4630 with SMTP id p17-20020a05600c205100b003f735454630mr31675709wmg.20.1687967712062;
        Wed, 28 Jun 2023 08:55:12 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ42D8Kv0BlCPcXpTAn52urDR/dDlp8MEPpaiK2drF2SKeOo/NqY5H/VR9ZO1HAvtiuKYYZ8qw==
X-Received: by 2002:a05:600c:2051:b0:3f7:3545:4630 with SMTP id p17-20020a05600c205100b003f735454630mr31675693wmg.20.1687967711746;
        Wed, 28 Jun 2023 08:55:11 -0700 (PDT)
Date: Wed, 28 Jun 2023 11:55:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Jason Wang <jasowang@redhat.com>, virtio-dev@lists.oasis-open.org,
	parav@nvidia.com, virtio-comment@lists.oasis-open.org,
	"Zhu, Lingshan" <lingshan.zhu@intel.com>
Message-ID: <20230628114143-mutt-send-email-mst@kernel.org>
References: <20230626062210.49020-1-xuanzhuo@linux.alibaba.com>
 <1687854185.3344731-3-xuanzhuo@linux.alibaba.com>
 <CACGkMEs=2HJ=Bg5Xk1GYZAOKpNLpf5EUrkNEkEOKU4hSbXC=mw@mail.gmail.com>
 <1687863046.3264692-9-xuanzhuo@linux.alibaba.com>
 <CACGkMEvyJrnyN0CFv2sAraNQM5E_Hkccmo1hJNzQPX8DRB5ryg@mail.gmail.com>
 <1687932392.6613173-2-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <1687932392.6613173-2-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [virtio-comment] [RFC PATCH] admin-queue: bind the group member
 to the device

On Wed, Jun 28, 2023 at 02:06:32PM +0800, Xuan Zhuo wrote:
> On Wed, 28 Jun 2023 10:49:45 +0800, Jason Wang <jasowang@redhat.com> wrote:
> > On Tue, Jun 27, 2023 at 6:54 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> > >
> > > On Tue, 27 Jun 2023 17:00:06 +0800, Jason Wang <jasowang@redhat.com> wrote:
> > > > On Tue, Jun 27, 2023 at 4:28 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> > > > >
> > > > >
> > > > > Thanks Parav for pointing it out. We may have some gaps on the case.
> > > > >
> > > > > Let me introduce our case, which I think it is simple and should be easy to
> > > > > understand.
> > > > >
> > > > > First, the user (customer) purchased a bare metal machine.
> > > > >
> > > > > ## Bare metal machine
> > > > >
> > > > > Let me briefly explain the characteristics of a bare metal machine. It is not a
> > > > > virtual machine, it is a physical machine, and the difference between it and a
> > > > > general physical machine is that its PCI is connected to a device similar to a
> > > > > DPU. This DPU provides devices such as virtio-blk/net to the host through PCI.
> > > > > These devices are managed by the vendor, and must be created and purchased
> > > > > on the vendor's management platform.
> > > > >
> > > > > ## DPU
> > > > >
> > > > > There is a software implementation in the DPU, which will respond to PCI
> > > > > operations. But as mentioned above, resources such as network cards must be
> > > > > purchased and created before they can exist. So users can create VF, which is
> > > > > just a pci-level operation, but there may not be a corresponding backend.
> > > > >
> > > > > ## Management Platform
> > > > >
> > > > > The creation and configuration of devices is realized on the management
> > > > > platform.
> > > > >
> > > > > After the user completed the purchase on the management platform (this is an
> > > > > independent platform provided by the vendor and has nothing to do with
> > > > > virtio), then there will be a corresponding device implementation in the DPU.
> > > > > This includes some user configurations, available bandwidth resources and other
> > > > > information.
> > > > >
> > > > > ## Usage
> > > > >
> > > > > Since the user is directly on the HOST, the user can create VMs, passthrough PF
> > > > > or VF into the VM. Or users can create a large number of dockers, all of which
> > > > > use a separate virtio-net device for performance.
> > > > >
> > > > > The reason why users use vf is that we need to use a large number of virtio-net
> > > > > devices. This number reaches 1k+.
> > > > >
> > > > > Based on this scenario, we need to bind vf to the backend device. Because, we
> > > > > cannot automatically complete the creation of the virtio-net backend device when
> > > > > the user creates a vf.
> > > > >
> > > > > ## Migration
> > > > >
> > > > > In addition, let's consider another scenario of migration. If a vm is migrated
> > > > > from another host, of course its corresponding virtio device is also migrated to
> > > > > the DPU. At this time, our newly created vf can only be used by the vm after it
> > > > > is bound to the migrated device. We do not want this vf to be a brand new
> > > > > device.
> > > > >
> > > > > ## Abstraction
> > > > >
> > > > > So, this is how I understand the process of creating vf:
> > > > >
> > > > > 1. Create a PCI VF, at this time there may be no backend virtio device, or there
> > > > >     is only a default backend. It does not fully meet our expectations.
> > > > > 2. Create device or migrate device
> > > > > 3. Bind the backend virtio device to the vf
> > > >
> > > > 3) should come before 2)?
> > > >
> > > > Who is going to do 3) btw, is it the user? If yes, for example, if a
> > > > user wants another 4 queue virtio-net devices, after purchase, how
> > > > does the user know its id?
> > >
> > > Got the id from the management platform.
> >
> > So it can do the binding via that management platform which this
> > became a cloud vendor specific interface.
> 
> In our scenario, this is bound by the user using this id and vf id in the os.
> 
> >
> > >
> > > >
> > > > >
> > > > > In most scenarios, the first step may be enough. We can make some fine-tuning on
> > > > > this default device, such as modifying its mac. In the future, we can use admin
> > > > > queue to modify its msix vector and other configurations.
> > > > >
> > > > > But we should allow, we bind a backend virtio device to a certain vf. This is
> > > > > useful for live migration and virtio devices with special configurations.
> > > >
> > > > All of these could be addressed if a dynamic provisioning model is
> > > > implemented (SIOV or transport virtqueue). Trying to have a workaround
> > > > in SR-IOV might be tricky.
> > >
> > >
> > > SR-IOV vf is native PCI device, this is the advancement.
> >
> > The problem is that it doesn't support flexible provisioning, e.g
> > create and destroy a single VF.
> 
> YES. ^_^!!

So sure, create it. Once you have created it, you can
use the VF# to talk to it.


I *suspect* that what this ID does is replace provisioning commands.

So instead of saying "create VF#3 with MAC 0xABC and 0x1000VQs"
you would have management say "ID 0xFACE refers to MAC ABC and 1000VQs"
and later you will say "bind VF#3 to ID 0xFACE" and that will
set it up.

Is that it?

But why is it important to do it in two steps like this?
as opposed to in one step?  I have no idea.

> 
> >
> > >
> > >
> > > >
> > > > >
> > > > > The design of virtio itself is two layers, and virtio should allow switching the
> > > > > transport layer by nature. This is our advantage.
> > > >
> > > > Is it not switching the transport layer but about binding/unbinding
> > > > vitio devices to VF?
> > >
> > > YES.
> > >
> > > >
> > > > Is a new capability or similar admin cmd sufficient in this case?
> > >
> > > All is ok.
> > >
> > >
> > > >
> > > > struct virtio_pci_bind_cap {
> > > >         struct virtio_pci_cap cap;
> > > >         u16 bind; // virtio_device_id
> > > >         u16 unbind; // virtio_device_id
> > > > };
> > >
> > > You mean that the "bind" or "unbind" is writeable?
> 
> This is a good idea.
> 
> Thanks.

So stealing valuable memory from limited pci config space, no error
handling, no filtering... Ugh.  Let's not put a round peg in a square
hole.

For management I think we should use admin commands. They were built for
the management use-case.
Config space (pci and virtio) is better for driver slow path.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

