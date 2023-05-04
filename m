Return-Path: <virtio-dev-return-12545-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95F39C77B7C
	for <virtio-dev@archiver.kernel.org>; Thu,  4 May 2023 06:30:59 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id F2ECA419A9
	for <virtio-dev@archiver.kernel.org>; Thu,  4 May 2023 06:30:58 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E80419866B3
	for <virtio-dev@archiver.kernel.org>; Thu,  4 May 2023 06:30:58 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id DA56F983EB5; Thu,  4 May 2023 06:30:58 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C9FA998663F
	for <virtio-dev@lists.oasis-open.org>; Thu,  4 May 2023 06:30:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 3_xCzFEjN3Oz4y7EeGqL7g-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683181855; x=1685773855;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ijHy8M86XtSR7kwmnq7aGSGB3lz17yxCF/KzfpbaU3M=;
        b=HELnzHUesZYsRCtXis8KkJjDWjAuSx2FeAlmi2/PKx3gfp/+mqrY1RfGxw2reVeSOd
         QE5im1JCCoWzeRiIstpr/eeY4s6za0fUp20SuJYaTXKBRwOeT8t/fWc5uwFCB6REfMc2
         ETeLD+4RF0neEIyhM5xprYTLIsOgCYz6QjodO/1kTWXtLRTzG5iK+HOV5dkyGH8+xczN
         VXPlYsoX/lzhseoQBGfN61ktYAEfcdKhDYUwhbXIpqkAHUoK5hpdi6MVOL2jcpPjDU8X
         zyBjZatj4d4VGFwn99VkjEdLNiFUctkANg7xyNYGdYYJDtRZkE1pAeE2iM6fKNbVeSsf
         6D8Q==
X-Gm-Message-State: AC+VfDyD1pDYktDbxCcgeVmeMgj4ZOhxj4Ogj7WPvUrNTy1sfEkJ5+VS
	UPqhX9VEu8e4Xv1oYpTpw1Vu8deWfIaJcJQ1X25rJFgyrtR/ev/v13mnI3TMVcmmCSecZbmv5VA
	uqihccRd+PTOIdbFVK9k/NbaTjJkL
X-Received: by 2002:a1c:f20f:0:b0:3f3:888b:ab78 with SMTP id s15-20020a1cf20f000000b003f3888bab78mr3615394wmc.37.1683181855699;
        Wed, 03 May 2023 23:30:55 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ66ManI/pKe9Esa0DMz9CtlEODQzfLJIvNiQ9YAqgDhNaza345Fmt27tmBFUhqWB5/QtHKqnw==
X-Received: by 2002:a1c:f20f:0:b0:3f3:888b:ab78 with SMTP id s15-20020a1cf20f000000b003f3888bab78mr3615371wmc.37.1683181855347;
        Wed, 03 May 2023 23:30:55 -0700 (PDT)
Date: Thu, 4 May 2023 02:30:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: virtio-dev@lists.oasis-open.org, cohuck@redhat.com,
	david.edmondson@oracle.com, sburla@marvell.com, jasowang@redhat.com,
	virtio-comment@lists.oasis-open.org, shahafs@nvidia.com,
	Yishai Hadas <yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>
Message-ID: <20230504023034-mutt-send-email-mst@kernel.org>
References: <20230503032659.530330-1-parav@nvidia.com>
 <20230503032659.530330-2-parav@nvidia.com>
 <20230503011627-mutt-send-email-mst@kernel.org>
 <c0ece552-d618-cbe3-c841-6c6fe72e8f18@nvidia.com>
 <20230503124212-mutt-send-email-mst@kernel.org>
 <ba053f8a-4adb-5395-ed75-ac1d0bfe20ee@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <ba053f8a-4adb-5395-ed75-ac1d0bfe20ee@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v1 1/2] transport-pci: Introduce legacy registers access
 commands

On Wed, May 03, 2023 at 01:21:39PM -0400, Parav Pandit wrote:
> 
> 
> On 5/3/2023 12:48 PM, Michael S. Tsirkin wrote:
> 
> > > > As simple as it is, I feel this falls far short of describing how
> > > > a device should operate.
> > > > Some issues:
> > > > 	- legacy device config offset changes as msi is enabled/disabled
> > > > 	  suggest separate commands for device/common config
> > > This is fine and covered here. The one who is making msix enable/disable
> > > knows which registers to access before/after disable/enable and device also
> > > knows it as it is supplying the register.
> > > So they just follow the standard legacy register access behavior.
> > 
> > But do VFs support INT#x? I will have to re-read the spec.
> > 
> VFs do not support INTx.
> When hypervisor knows that it cannot support msix for the guest, it can
> avoid using the VF for the guest.

it's the guest that does not support msix. Not host.

> > > > 	- legacy device endian-ness changes with guest
> > > > 	  suggest commands to enable LE and BE mode
> > > guest endianeness is not known to the device.
> > 
> > But is known to hypervisor.
> > 
> It can be an extension command in future as part of the VF administration
> command to set it by the hypervisor PF.
> 
> > > Currently it is only for the
> > > LE guests who had some legacy requirement.
> > 
> > I don't like tying this to LE implicitly some devices might be BE only.
> > With my idea device can support command to set LE, command to set BE or
> > both.
> > 
> It can be an addition in future if needed.
> 
> > > and PCIe is LE anyway.
> > 
> > PCIE config endian-ness does not matter heere.
> > 
> > > > 	- legacy guests often assume INT#x support
> > > > 	  suggest a way to tunnel that too;
> > > INT#x is present on the PCI device itself. So no need to tunnel it.
> > > Also INT#x is very narrow case. When MSI-X is not supported, a hypervisor
> > > can choose not to even connect such device to the guest VM.
> > 
> > devices will support MSI. But *guest* might not support MSIX you only
> > find out late when it is driving the device.
> > 
> It is a pathological case that may not exist because legacy drivers and
> linux kernels all the way upto 2.6.32 have msix support.
> 
> And in case if hypervisor sw wants to support for unknown scenario, it can
> use the one msix based interrupt to emulate intx.
> 
> > > > I expected to see more statements along the lines of
> > > >           command ABC has the same effect as access
> > > >           to register DEF of the member through the legacy pci interface
> > > > 
> > > Yes, good point. I will add it in the theory of operation section for this
> > > mapping detail.
> > 
> > OK, and overall if you see an existing statement about legacy do not
> > copy it, just explain how it is mapped.
> > 
> Yes, will not copy, only the mapping part to add.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

