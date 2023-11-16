Return-Path: <virtio-dev-return-14060-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4307C197A0
	for <virtio-dev@archiver.kernel.org>; Thu, 16 Nov 2023 22:26:50 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 20EB91CA24D
	for <virtio-dev@archiver.kernel.org>; Thu, 16 Nov 2023 22:26:50 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F2FFB986E11
	for <virtio-dev@archiver.kernel.org>; Thu, 16 Nov 2023 22:26:49 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id D746C986E06; Thu, 16 Nov 2023 22:26:49 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C68F0986E07
	for <virtio-dev@lists.oasis-open.org>; Thu, 16 Nov 2023 22:26:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: QtYd86LhObyEHgbP_FksLg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700173606; x=1700778406;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8WbDjbsJAViEtzpdu0gpHjopViguXknXd0a5LRav6Rg=;
        b=j47uki985KLPkJvpwO5RusRL5FXehERQF5dTElzYg3MOKzU6qUPrWixV8B1Ccsh763
         YFFbaMrQ3APLwhb/nDSow1c3mBXrI0KvMyalKYIMhlF8DjIBF8kdMIRJKHf72gqkoe8C
         VfTzWgVWguQMj6/g4TnpSbLyYmr/mGhZwt8IrQan8upfH7rYVhKDqyGfvB2qBbYA8nXQ
         JcycG/puAuo+SZf0iwlJefZn3kikn4a/gSx0ZhxpykyrbvHBq2jtbjEoUMQfwcoY8QUv
         HSgcfURM/zYuGhG3FX9YPCq6zfHg44abaO8LUvESNAX2hhiLg+64iXjfvyVWowxJqY0s
         /4pw==
X-Gm-Message-State: AOJu0YzEQdEoQqJSyqAJjcbx7AhixjdUpBNMQRGZB+x7mOA9Vqe9Ahy+
	7DGBnSl88+j9dJsP4VbsJOp9KGk8rPGXngv2jHJcUi9vR9B3w51Scpn/yeZcyqLZNRa7S1adJLe
	w92ljxhc1R7wR3dltqiHKQ8D8mWnf
X-Received: by 2002:a05:6000:1541:b0:32f:7bb6:9695 with SMTP id 1-20020a056000154100b0032f7bb69695mr16218542wry.44.1700173606116;
        Thu, 16 Nov 2023 14:26:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGiBu3ri5t/Dwj5Bs0QAq+RqVRBJLFuPR0Pj59OSodujceUq5Vh0d8dsTukm0J4AGxscW8WjQ==
X-Received: by 2002:a05:6000:1541:b0:32f:7bb6:9695 with SMTP id 1-20020a056000154100b0032f7bb69695mr16218528wry.44.1700173605769;
        Thu, 16 Nov 2023 14:26:45 -0800 (PST)
Date: Thu, 16 Nov 2023 17:26:42 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: elena.reshetova@intel.com, virtio-dev@lists.oasis-open.org,
	virtualization@lists.linux.dev
Message-ID: <20231116172507-mutt-send-email-mst@kernel.org>
References: <20231116200245.GA336841@fedora>
MIME-Version: 1.0
In-Reply-To: <20231116200245.GA336841@fedora>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: Using packed virtqueues in Confidential VMs

On Thu, Nov 16, 2023 at 03:02:45PM -0500, Stefan Hajnoczi wrote:
> Hi Elena,
> You raised concerns about using packed virtqueues with untrusted devices at
> Linux Plumbers Conference. I reviewed the specification and did not find
> fundamental issues that would preclude the use of packed virtqueues in
> untrusted devices. Do you have more information about issues with packed
> virtqueues?
> 
> I also reviewed Linux's virtio_ring.c to look for implementation issues. One
> thing I noticed was that detach_buf_packed -> vring_unmap_desc_packed trusts
> the fields of indirect descriptors that have been mapped to the device:
> 
>   flags = le16_to_cpu(desc->flags);
> 
>   dma_unmap_page(vring_dma_dev(vq),
>                  le64_to_cpu(desc->addr),
>                  le32_to_cpu(desc->len),
>                  (flags & VRING_DESC_F_WRITE) ?
>                  DMA_FROM_DEVICE : DMA_TO_DEVICE);
> 
> This could be problematic if the device is able to modify indirect descriptors.
> However, the indirect descriptor table is mapped with DMA_TO_DEVICE:
> 
>   addr = vring_map_single(vq, desc,
>                           total_sg * sizeof(struct vring_packed_desc),
>                           DMA_TO_DEVICE);
> 
> There is no problem when there is an enforcing IOMMU that maps the page with
> read-only permissions but that's not always the case. Software devices (QEMU,
> vhost kernel, or vhost-user) usually have full access to guest RAM.

Not with encrypted memory.

> They can
> cause dma_unmap_page() to be invoked with arguments of their choice (except for
> the first argument) by modifying indirect descriptors.

> I am not sure if this poses a danger since software devices already have access
> to guest RAM, but I think this code is risky. It would be safer for the driver
> to stash away the arguments needed for dma_unmap_page() in memory that is not
> mapped to the device.
> 
> Other than that, I didn't find any issues with the packed virtqueue
> implementation.
> 
> Stefan



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

