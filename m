Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9176417722
	for <virtio-dev@lists.linux.dev>; Tue, 21 May 2024 03:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716263444; cv=none; b=HFjigGNAXyG3DRO3DKtzdSKKYH+78hLE+hqoZJoMgL2daR2QQt4WlOsreuXxVULF7Ah5Tu3MkWQsedjVIBQJfoBUWCb8lVV61X/XsgVFYNlUM6KzxzECX++3GqOdLswQ+Bo7KGTkkfmkU4wA31p1mkp57Pr2TnP+vJOel8ZBcSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716263444; c=relaxed/simple;
	bh=2Ij2mq3Yx4Z/96MDi/kOeK9/8q9A4cKgHjnvldGVITU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=VFcmlad4chQeq7AteiIMyslM1EyW/NeMiIESGp+sHz5puH+o9kMQ916rzE26bx/krKNAuXIqwZYOVJXPoOpHLbh7ASYqN7wRr7kKIToN+29JYMXMhe3WpxRyiqbGU/cq2ovdwdM9aG19KxD9ARNWtUfJ3YczU2IXoOSld8MM4hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Og5zmJA4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Og5zmJA4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716263441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T/ckDHkreZnH6ILA7GLh0roDcmeHS6c1vOQASTl41T8=;
	b=Og5zmJA4ge0TsYS746BoS25s4AX8SXGnoUjZ+0FSbEw5QrLNjzYVT/8Kp0fwBvyHuuAixr
	fkABnR3vysXfZNxXmHO058L7lJ3nnEYRm9gt63VR5oSooa0OKC4W9D5adADk7PaY/Zm/tJ
	9KdVl/wo+yhHJW7qaMxsst1yYPYLkC4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-DUoOJ4KiPXmWtgfctlwOSg-1; Mon, 20 May 2024 23:50:40 -0400
X-MC-Unique: DUoOJ4KiPXmWtgfctlwOSg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42015260835so42844695e9.0
        for <virtio-dev@lists.linux.dev>; Mon, 20 May 2024 20:50:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716263439; x=1716868239;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T/ckDHkreZnH6ILA7GLh0roDcmeHS6c1vOQASTl41T8=;
        b=L1CfkOGyj7VaIAV/hmJlL3G7PVxZC/55s01wzvd7mn0edHk4D/EcWJmCDTiiZmYRQB
         DtlDGMNE+cJVTAzj8YYyuv2k76H2XdzHscMR22iF4TD4KK/Cq7Hwrihe6UgRiplFXCqA
         +kO/AY2xPyPj5ds9FI1W6Th8rqARlsAY4Ro6D2O3vLJGqBqrQuxJN0sjl2sG/aHQohAl
         8QnsD7/18FSA9/lxMFjAqOD5g4K4e/HzMtkMO+EVmxSKQEo+rdt+cfvRUqbC2WscgIgC
         ULntRAUSaJ+NM4TxKetqRjrdqjqPEAljQ+Z+PVq6hBe6RadJQ4EdWa3OdgH0NCaIZmSw
         XmxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzYM5NX+2FK/FLIrdmEpB1t68s45zBkmvqMDIkVwG87/8s44cSpyvicM1/0WS9czLq1JQPAg/H9pdavw7WksWT1wg/K31G8CKQ/Q==
X-Gm-Message-State: AOJu0YybGewJ2mLis5a/bub1nwHRz8RlavCSPgcHWEGRPdMpvWJwN9Rc
	lCpYS2zug1VakR1eTwOlUuA6rYHMQuAXVtmVW9Y0sFeaP7st7IgkAWJv8o0TXtRdxprxWlhHMrQ
	g8AHZgOw3XzoRqigadLptGtcPTUZ/HU5wlYVEZVV0Cct7TNwEqRKQqEDQG3c=
X-Received: by 2002:a05:600c:198c:b0:420:2a22:bd3e with SMTP id 5b1f17b1804b1-4202a22c4c8mr116838165e9.18.1716263438829;
        Mon, 20 May 2024 20:50:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF121U3KDg23gso8P5g9H2GIQvRaCsbc6qjkVIIGH9aJNzro874iN1zt8PFrB5Tl8P5d7eosw==
X-Received: by 2002:a05:600c:198c:b0:420:2a22:bd3e with SMTP id 5b1f17b1804b1-4202a22c4c8mr116838045e9.18.1716263438225;
        Mon, 20 May 2024 20:50:38 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:240:5a20:b565:3672:6f2b:3d2d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-420e88b71a2sm85257125e9.31.2024.05.20.20.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 20:50:37 -0700 (PDT)
Date: Mon, 20 May 2024 23:50:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: zhenwei pi <pizhenwei@bytedance.com>
Cc: virtio-comment@lists.linux.dev, virtio-dev@lists.linux.dev,
	david@redhat.com
Subject: Re: [PATCH 1/1] balloon: introduce 6 memory statistics
Message-ID: <20240520234857-mutt-send-email-mst@kernel.org>
References: <20240513121005.459013-1-pizhenwei@bytedance.com>
 <20240513121005.459013-2-pizhenwei@bytedance.com>
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240513121005.459013-2-pizhenwei@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 13, 2024 at 08:10:05PM +0800, zhenwei pi wrote:
> Expose more memory statistics of the virtual memory subsystem from
> guest, it's helpful to analyze the memory performance and pressure
> from host side.
> 
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>

zhenwei

when subsriving to the lists you should have received this text:


Not to do:
- copy both virtio-dev and virtio-comment mailing lists (instead, pick
  one)

did you not get this text? was this, somehow, unclear that you copied both
virtip-comment and virtio-dev on your patch?


> ---
>  device-types/balloon/description.tex | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/device-types/balloon/description.tex b/device-types/balloon/description.tex
> index a1d9603..bc8e109 100644
> --- a/device-types/balloon/description.tex
> +++ b/device-types/balloon/description.tex
> @@ -305,6 +305,12 @@ \subsubsection{Memory Statistics}\label{sec:Device Types / Memory Balloon Device
>  #define VIRTIO_BALLOON_S_CACHES   7
>  #define VIRTIO_BALLOON_S_HTLB_PGALLOC 8
>  #define VIRTIO_BALLOON_S_HTLB_PGFAIL  9
> +#define VIRTIO_BALLOON_S_OOM_KILL       10
> +#define VIRTIO_BALLOON_S_ALLOC_STALL    11
> +#define VIRTIO_BALLOON_S_ASYNC_SCAN     12
> +#define VIRTIO_BALLOON_S_DIRECT_SCAN    13
> +#define VIRTIO_BALLOON_S_ASYNC_RECLAIM  14
> +#define VIRTIO_BALLOON_S_DIRECT_RECLAIM 15
>          le16 tag;
>          le64 val;
>  } __attribute__((packed));
> @@ -399,6 +405,24 @@ \subsubsection{Memory Statistics Tags}\label{sec:Device Types / Memory Balloon D
>  
>  \item[VIRTIO_BALLOON_S_HTLB_PGFAIL (9)] The number of failed hugetlb page
>    allocations in the guest.
> +
> +\item[VIRTIO_BALLOON_S_OOM_KILL (10)] The number of Out-Of-Memory killer
> +  invocations.
> +
> +\item[VIRTIO_BALLOON_S_ALLOC_STALL (11)] The number of stall count on memory
> +  allocation.
> +
> +\item[VIRTIO_BALLOON_S_ASYNC_SCAN (12)] The amount of memory that has been
> +  scanned asynchronously (in bytes).
> +
> +\item[VIRTIO_BALLOON_S_DIRECT_SCAN (13)] The amount of memory that has been
> +  scanned directly (in bytes).
> +
> +\item[VIRTIO_BALLOON_S_ASYNC_RECLAIM (14)] The amount of memory that has been
> +  reclaimed asynchronously (in bytes).
> +
> +\item[VIRTIO_BALLOON_S_DIRECT_RECLAIM (15)] The amount of memory that has been
> +  reclaimed directly (in bytes).
>  \end{description}
>  
>  \subsubsection{Free Page Hinting}\label{sec:Device Types / Memory Balloon Device / Device Operation / Free Page Hinting}
> -- 
> 2.34.1
> 

