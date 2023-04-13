Return-Path: <virtio-dev-return-12204-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28C25C77B61
	for <virtio-dev@archiver.kernel.org>; Thu, 13 Apr 2023 10:40:48 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 4E9392AEF3
	for <virtio-dev@archiver.kernel.org>; Thu, 13 Apr 2023 10:40:47 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 39E9B9865FF
	for <virtio-dev@archiver.kernel.org>; Thu, 13 Apr 2023 10:40:47 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 2696F986360; Thu, 13 Apr 2023 10:40:47 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 11C069865F8
	for <virtio-dev@lists.oasis-open.org>; Thu, 13 Apr 2023 10:40:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681382445; x=1683974445;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wt8QYWYgXcWDb0H4PzSCSB86AxQEfmL5GXKTxvwufWc=;
        b=YDmwzQHzDhnCtk5+QOQVyyn46gBmhw6GH8bCRhq19uMj7crbHJx5VYDu0KjKTYHoRi
         TehacCPUGy1sBJlvZjZGTSe6PWqmCz9WXs3vo214yJaX2Jb62fKZ0UeEP2HMxLeRGOEL
         W4Vtx6XCo56hDadUiQRQut5d4C2+B0l060/+q3Tax1/wFb4ymWfyThiGvB//UiQeAZlv
         KkHmUd2gezLDhRQFW/gQ+HXvm3vh1S6BcwP6TbOVTPBcA2biy6h+bquMLqPByNCYAA8V
         AEtM4qLPVSB5qRTYitTacWlhzfq/qLc9r7/keLXr8D81Yw7gB+OySOSwVSzYwKV9/bJs
         rWhw==
X-Gm-Message-State: AAQBX9epeys2zRWZReEOhy9G1T2hB5ncMRtDtknUmtcEuG2ySUVNZGax
	L5jZOGStxvQ2+iZKkUpJseiCiQ==
X-Google-Smtp-Source: AKy350ZKTDVRuGJL5YYI5HJoiDXvklp7EVihRfgojTs66okpvLm6QBr1zfRfZkA+Oait71i9Hok2BQ==
X-Received: by 2002:adf:e352:0:b0:2ef:b1bd:786 with SMTP id n18-20020adfe352000000b002efb1bd0786mr1002307wrj.13.1681382444786;
        Thu, 13 Apr 2023 03:40:44 -0700 (PDT)
Date: Thu, 13 Apr 2023 11:40:41 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Eric Auger <eric.auger@redhat.com>, virtio-dev@lists.oasis-open.org,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org, qemu-devel@nongnu.org
Message-ID: <20230413104041.GA3295191@myrica>
References: <15bf1b00-3aa0-973a-3a86-3fa5c4d41d2c@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15bf1b00-3aa0-973a-3a86-3fa5c4d41d2c@daynix.com>
Subject: [virtio-dev] Re: virtio-iommu hotplug issue

Hello,

On Thu, Apr 13, 2023 at 01:49:43PM +0900, Akihiko Odaki wrote:
> Hi,
> 
> Recently I encountered a problem with the combination of Linux's
> virtio-iommu driver and QEMU when a SR-IOV virtual function gets disabled.
> I'd like to ask you what kind of solution is appropriate here and implement
> the solution if possible.
> 
> A PCIe device implementing the SR-IOV specification exports a virtual
> function, and the guest can enable or disable it at runtime by writing to a
> configuration register. This effectively looks like a PCI device is
> hotplugged for the guest.

Just so I understand this better: the guest gets a whole PCIe device PF
that implements SR-IOV, and so the guest can dynamically create VFs?  Out
of curiosity, is that a hardware device assigned to the guest with VFIO,
or a device emulated by QEMU?

> In such a case, the kernel assumes the endpoint is
> detached from the virtio-iommu domain, but QEMU actually does not detach it.
> 
> This inconsistent view of the removed device sometimes prevents the VM from
> correctly performing the following procedure, for example:
> 1. Enable a VF.
> 2. Disable the VF.
> 3. Open a vfio container.
> 4. Open the group which the PF belongs to.
> 5. Add the group to the vfio container.
> 6. Map some memory region.
> 7. Close the group.
> 8. Close the vfio container.
> 9. Repeat 3-8
> 
> When the VF gets disabled, the kernel assumes the endpoint is detached from
> the IOMMU domain, but QEMU actually doesn't detach it. Later, the domain
> will be reused in step 3-8.
> 
> In step 7, the PF will be detached, and the kernel thinks there is no
> endpoint attached and the mapping the domain holds is cleared, but the VF
> endpoint is still attached and the mapping is kept intact.
> 
> In step 9, the same domain will be reused again, and the kernel requests to
> create a new mapping, but it will conflict with the existing mapping and
> result in -EINVAL.
> 
> This problem can be fixed by either of:
> - requesting the detachment of the endpoint from the guest when the PCI
> device is unplugged (the VF is disabled)

Yes, I think this is an issue in the virtio-iommu driver, which should be
sending a DETACH request when the VF is disabled, likely from
viommu_release_device(). I'll work on a fix unless you would like to do it

> - detecting that the PCI device is gone and automatically detach it on
> QEMU-side.
> 
> It is not completely clear for me which solution is more appropriate as the
> virtio-iommu specification is written in a way independent of the endpoint
> mechanism and does not say what should be done when a PCI device is
> unplugged.

Yes, I'm not sure it's in scope for the specification, it's more about
software guidance

Thanks,
Jean

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

