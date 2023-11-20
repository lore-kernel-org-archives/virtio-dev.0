Return-Path: <virtio-dev-return-14062-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEA9FC197A0
	for <virtio-dev@archiver.kernel.org>; Mon, 20 Nov 2023 12:29:50 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 17E0C45B2B
	for <virtio-dev@archiver.kernel.org>; Mon, 20 Nov 2023 12:29:50 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EAED398685D
	for <virtio-dev@archiver.kernel.org>; Mon, 20 Nov 2023 12:29:49 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id CBE2998684F; Mon, 20 Nov 2023 12:29:49 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BB52C986851
	for <virtio-dev@lists.oasis-open.org>; Mon, 20 Nov 2023 12:29:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: ON3rUTyPN5-VgY4uwugPeQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700483383; x=1701088183;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e4OC0yOur0IZ04mctIkt9Weg8mzI9CmT9lSe7QtjZ/I=;
        b=HKYsFeerP83f5zAkW8a2+BkmdlXIjlQQrVNmPVFxdQsZfv+8JRau1GaJUV3cZTLA+o
         n41dG/fADFUk40eJjQCBmF1KW9pqJVHB6CTrwv5tCw1xsvVBDE0tfm1TlRa+eZLVxJ7e
         FN5q3irz1t3snD99lAXaiGw0LUG8/HO/BWQekt4LN+TzKlf+lNrhxQmYKaIXFWvg5NK+
         Loi3f3Tdj3dDQt8+qIsXtavH7UOaM3QqtMCP93RUIbumkjOogT2bktu48Yzpdm1uVjLI
         oodH7xQZLi9qHLZ22HLeV1Wx42lSMQKXcAPAytr3S2hCJQWLBA82/HDhCfZAHQR47zng
         nrxw==
X-Gm-Message-State: AOJu0YzboSaIheo/Q3RhE59lWfxrf966myNErJrQ//LPIRtauZnDx7El
	xziuxVySIE0wU5/M+/Ixn2yWxZwQYwM1E1xrMkLZkb0THNLwzaMIUYPaGKHPu0pbuZYLWu7BI//
	c6cgEh5k5Knt1+yyoYQuUhuDJbLok
X-Received: by 2002:a05:6000:18ad:b0:32d:b06c:d30b with SMTP id b13-20020a05600018ad00b0032db06cd30bmr5730134wri.55.1700483383314;
        Mon, 20 Nov 2023 04:29:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHiA5hPdMs1obosTpxknc0+Rt9qQ0WLFLD6MUPyHppA14MnXYwOfQDTbg9QzN09h4w9KTDWZg==
X-Received: by 2002:a05:6000:18ad:b0:32d:b06c:d30b with SMTP id b13-20020a05600018ad00b0032db06cd30bmr5730124wri.55.1700483382944;
        Mon, 20 Nov 2023 04:29:42 -0800 (PST)
Date: Mon, 20 Nov 2023 07:29:39 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Reshetova, Elena" <elena.reshetova@intel.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>
Message-ID: <20231120072623-mutt-send-email-mst@kernel.org>
References: <20231116200245.GA336841@fedora>
 <DM8PR11MB5750765B1310C904A8B1B00BE7B4A@DM8PR11MB5750.namprd11.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <DM8PR11MB5750765B1310C904A8B1B00BE7B4A@DM8PR11MB5750.namprd11.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: Using packed virtqueues in Confidential VMs

On Mon, Nov 20, 2023 at 10:13:15AM +0000, Reshetova, Elena wrote:
> Hi Stefan, 
> 
> Thank you for following up on this! Please find my comments inline. 
> 
> > -----Original Message-----
> > From: Stefan Hajnoczi <stefanha@redhat.com>
> > Sent: Thursday, November 16, 2023 10:03 PM
> > To: Reshetova, Elena <elena.reshetova@intel.com>
> > Cc: Michael S. Tsirkin <mst@redhat.com>; virtio-dev@lists.oasis-open.org;
> > virtualization@lists.linux.dev
> > Subject: Using packed virtqueues in Confidential VMs
> > 
> > Hi Elena,
> > You raised concerns about using packed virtqueues with untrusted devices at
> > Linux Plumbers Conference. I reviewed the specification and did not find
> > fundamental issues that would preclude the use of packed virtqueues in
> > untrusted devices. Do you have more information about issues with packed
> > virtqueues?
> 
> First of all a bit of clarification: our overall logic for making our first reference
> release of Linux intel tdx stacks [1] was to enable only minimal required
> functionality and this also applied to numerous modes that virtio provided. 
> Because for each enabled functionality we would have to do a code audit and
> a proper fuzzing setup and all of this requires resources. 

However, both with packed and split I don't think speculation barriers
have been added and they are likely to be needed.
I wonder whether your fuzzing included attempts to force spectre like 
leaks based on speculation execution.

> 
> The choice of split queue was a natural first step since it is the most straightforward
> to understand (at least it was for us, bare in mind we are not experts in virtio as
> you are) and the fact that there was work already done ([2] and other patches)
> to harden the descriptors for split queue. 
> 
> [1] https://github.com/intel/tdx-tools 
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/virtio?h=v6.6-rc4&id=72b5e8958738aaa453db5149e6ca3bcf416023b9
> 
> I remember looking at the packed queue long ago and noticing that at least
> some descriptor fields are under device control and I wasn’t sure why the similar 
> hardening was not done here as for the split case.

packed has R/W descriptors. This means however that data is copied over
from descriptor and validated before use.


> However, we had many
> issues to handle in past, and since we didn’t need the packed queue, we
> never went to investigate this further. 
> It is also possible that we simply misunderstood the code at that point.
> 
> > 
> > I also reviewed Linux's virtio_ring.c to look for implementation issues. One
> > thing I noticed was that detach_buf_packed -> vring_unmap_desc_packed trusts
> > the fields of indirect descriptors that have been mapped to the device:
> > 
> >   flags = le16_to_cpu(desc->flags);
> > 
> >   dma_unmap_page(vring_dma_dev(vq),
> >                  le64_to_cpu(desc->addr),
> >                  le32_to_cpu(desc->len),
> >                  (flags & VRING_DESC_F_WRITE) ?
> >                  DMA_FROM_DEVICE : DMA_TO_DEVICE);
> 
> 
> > 
> > This could be problematic if the device is able to modify indirect descriptors.
> > However, the indirect descriptor table is mapped with DMA_TO_DEVICE:
> > 
> >   addr = vring_map_single(vq, desc,
> >                           total_sg * sizeof(struct vring_packed_desc),
> >                           DMA_TO_DEVICE);
> > 
> > There is no problem when there is an enforcing IOMMU that maps the page with
> > read-only permissions but that's not always the case. 
> 
> We don’t use IOMMU at the moment for the confidential guest, since we don’t
> have to (memory is encrypted/protected) and only explicitly shared pages are
> available for the host/devices to modify. 
> Do I understand it correctly that in our case the indirect descriptor table will 
> end up mapped shared for this mode to work and then there is no protection? 
> 

I think this whole table is copied to swiotlb (this is what DMA_TO_DEVICE
AFAIK).

> Software devices (QEMU,
> > vhost kernel, or vhost-user) usually have full access to guest RAM. They can
> > cause dma_unmap_page() to be invoked with arguments of their choice (except
> > for
> > the first argument) by modifying indirect descriptors.
> > 
> > I am not sure if this poses a danger since software devices already have access
> > to guest RAM, but I think this code is risky. It would be safer for the driver
> > to stash away the arguments needed for dma_unmap_page() in memory that is
> > not
> > mapped to the device.
> > 
> > Other than that, I didn't find any issues with the packed virtqueue
> > implementation.
> 
> Thank you for looking into this! Even if we didn’t need the packed queue, 
> I am sure other deployments might need it and it would be the best for 
> virtio to provide all modes that are secure. 
> 
> Best Regards,
> Elena.
> 
> > 
> > Stefan


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

