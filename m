Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606A44D09F8
	for <virtio-dev@lists.linux.dev>; Wed, 14 Oct 2026 09:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791971340; cv=none; b=B13FZzoB5GdIL6MWLZeWMDIJwUNGe2Hn9yezE9BgX9SrtZk/bEjad7n+lRwDdXzDY5LFcB2eS7DfKb2/s51fuDgaizW14i40+Zl06StCTQv2B1g3ri6EfEQmZR/4k6MQS7kUGoakr+0W8gNCl0nOEvU6x7YhMTDB95ZOhzetX5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791971340; c=relaxed/simple;
	bh=iks/K07sV+gJQy75kwhJvnKrOnfo73k4WarAxuAdArE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=IDFHz91INBC8lMF1JCNlLSqROy9LrT1UUy3+p8Fve8MyXXRDNwIwZabLKD+v0zQOEuo5RFt/+CGU8lRBB+ulz+D0rYWrOQRKzin8rJ8kdOsi5yGFcjkQVP7FR6h+80CDAglpt3EG5VaCLeIUK4rebvXJSwUMpFl3rnD8Y2jrQM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IL2w1uYK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IL2w1uYK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791971336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X8HdNysMjMgrwS3QfWS8SXquGhUioEVAGE5g7+hmBXI=;
	b=IL2w1uYKFkPL6mCqtZRfwWWDGZHItUqIkQ+mEo5AclcqeKuW9ESa+E/9siOKOTT5zwsCI6
	sEFO5uGKQsCRSHB9ifZXakahKA6dolCBfCdMIlsznOT/aWZ3hBs0PgfwW6oPywTZAIB0m5
	jHZ4Nh+9Jeicy2C6qV/NhcNxJ9L0ABw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-x7oramayNHSJ0c-QhZ29OQ-1; Wed, 14 Oct 2026 09:48:54 +0000
X-MC-Unique: x7oramayNHSJ0c-QhZ29OQ-1
X-Mimecast-MFC-AGG-ID: x7oramayNHSJ0c-QhZ29OQ_1791971334
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4994d67d0e3so5603285e9.2
        for <virtio-dev@lists.linux.dev>; Wed, 14 Oct 2026 02:48:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791971334; x=1792576134;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X8HdNysMjMgrwS3QfWS8SXquGhUioEVAGE5g7+hmBXI=;
        b=WJ5jZMH5qZPpoNMAaUROOKPKKnDt2N9aVgPVrf9wySzFYIHnPyT0EV67ePSaXrEyID
         sJmc6xWtv3LIS79LWa5V+G1xNBW+wsh6kgPVUcwRxwZPd9RXUlS20WpAwo/2mmKuAR7h
         cTgDYldkdBBiLp33OV9mlecZV3/zj9e9ePqr3nsIWRRXwmd0sGZx3FvvY2FZCvmIRQtx
         8SjO4fdXlwztdUJUeuDTQjJbTTf7iySOw7ynJQquWOuuWF++OorWcr2RUqvJLh9g2PxN
         MhOVTJkSkHjZDzpx3+GPLiIgf7QQnDcLC4CIuGx8Zg069syLoJVe9rJMgpoNCi+BkgAJ
         3RzQ==
X-Gm-Message-State: AFq9FYJEokkUy8CfTxx6Tg74ieMJ8micoStYANNNnxuV7NAVG+nikYVu
	mi/lxlnlBmbVMTHsFVM9hW5z4rND75nLdjRXrigQZTBu6x3n2UTBsWTpP7l9HrjRoDv7yAKroDv
	c7NVNAe8ny/T9uIp2XWIUnCnQEEyW1Gea1C56/jnUY9goB7BvNRiHcHbdEwtMFTE=
X-Gm-Gg: AYBFou1DIo1bsKG/6douBrDfoDPF+0cI37BgVa+Rt1BborLfvoXGIeRMd1f5Lr8a2mL
	mQkIUO0i9oybwa7uHFg0TKJ1FWGZ7NOyG1fx74pek9UNh5jKT8SQzsHLIjg8qsFntfEEOC+7FmG
	HI2/gxSQ8RRD/bBJn3rZ2M0ZG3NmjlKS6ke+1uD+6MEqzVfgFcX+CRa3JsPXybeqh9ZEiEAWI5w
	Zo1CBCIZ34yAnKWy/smJf3kI0sapRtQD+6nmdU2GN8krIFlmZc/MVuKW6bKLXz4GNil0luUy1mj
	pt2V4rlI9wQt8OhezfV3GvE5EEAfR8jGiEO/DGzQpYcNxojgLaHr0h0vIXCPrjlklzRbhA==
X-Received: by 2002:a05:600c:190a:b0:4a1:746e:589a with SMTP id 5b1f17b1804b1-4a18e4aea54mr329619115e9.18.1791971333697;
        Wed, 14 Oct 2026 02:48:53 -0700 (PDT)
X-Received: by 2002:a05:600c:190a:b0:4a1:746e:589a with SMTP id 5b1f17b1804b1-4a18e4aea54mr329618705e9.18.1791971333173;
        Wed, 14 Oct 2026 02:48:53 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1b2ec47fcsm44778285e9.1.2026.10.14.02.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 02:48:52 -0700 (PDT)
Date: Wed, 14 Oct 2026 05:48:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
Cc: virtio-dev@lists.linux.dev, stefanha@redhat.com, ebiggers@kernel.org,
	neeraj.soni@oss.qualcomm.com
Subject: Re: [PATCH v3 0/2] virtio-blk: Add inline encryption support
Message-ID: <20261014054146-mutt-send-email-mst@kernel.org>
References: <20260913161628.368484-1-linlin.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260913161628.368484-1-linlin.zhang@oss.qualcomm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7dtcyN5qFr37-oagMqea2L0Y5Ioj8Uzx0obuU8rgGdQ_1791971334
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

First, this needs to be reposed to virtio-comment.

On Sun, Sep 13, 2026 at 09:16:13AM -0700, Linlin Zhang wrote:
> From: linlzhan <linlin.zhang@oss.qualcomm.com>
> 
> This series adds virtio-blk inline encryption support for devices backed
> by storage hardware with an inline crypto engine.
> 
> The protocol exposes device capabilities such as keyslot count, maximum
> DUN size, and supported key types. Encrypted requests identify a
> provisioned keyslot and carry a 256-bit DUN. Key management and crypto
> capability discovery use the block device control virtqueue.
> 
> The control virtqueue is defined as a generic framework so that its
> buffer layout and queue placement are independent of any particular
> control command. Inline encryption then builds on this framework with
> explicit crypto command formats, capability validation, and keyslot
> state semantics.
> 
> All key related operatios are handled in the control virtqueue, and
> the crypto I/O request is handled in the request queue.
> 
> For background on inline encryption in UFS and eMMC storage, see:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/block/inline-encryption.rst


What I worry about, is that after all the effort, virtio
crypto is being deprecated upstream.

So please tell us:
- how do we know this will be different?
- what was the response in upstream linux?
- what are some plans for use of this?

I also feel this needs a security section, given how
security sensitive this can be. E.g. is this safe to
enable for confidential computing guests?

Thanks!

> changes in v3:
>  - Add a control virtqueue
>  - Move key program/evict/derive_sw_secret/generate/prepare/import to
>    the control virtqueue
>  - Add the driver and device requirements for the request in the control
>    virtqueue
>  - Extend DUN in crypto message to a fixed four-element array of 64-bit
>    fields 
> 
> changes in v2:
>  - Revmove virtualization-specific terminology
>  - Move MUST sentence to the device/driver normative section
>  - Add explicit rejection for CRYPTO request if IE feature bit
>    isn't negociated
>  - Modify the support list of crypto modes and the definition of
>    the size of the crypto modes buffer
> ---
> 
> linlzhan (2):
>   virtio-blk: Add the control virtqueue
>   virtio-blk: Add inline encryption support
> 
>  device-types/blk/description.tex | 457 +++++++++++++++++++++++++++++--
>  1 file changed, 441 insertions(+), 16 deletions(-)
> 
> -- 
> 2.34.1
> 

