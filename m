Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFED4C99
	for <virtio-dev@lists.linux.dev>; Fri, 26 Jul 2024 07:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721978992; cv=none; b=mkF8UsIhp6C7gBBB9FI/u6M6Y+s5b6kCBiQ+2J79VB6ZiZ0MsBTj/LOUkl/25Eno6z0pqCXOFHpfx0N1eGPQellPJ8WdWpGAtGRffYZ8BytZL5UkBqEOevgQ5hMZPAPd2f3t5FJfkLcomcTKoKk8r9nihqHPqanlM7IMNPEinlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721978992; c=relaxed/simple;
	bh=UybNjeFZ1+FCrRiUfxH6aEuVkaSExTf6GEfaolg4r7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=VFBYCzSTt075NTmysgX2KjXxK2sLIOo3vkEGOLv2Vy5K5/+kF8+UjWTlbyBoKsvegU1pk9oilyIRflPrMQCrIMgVQZvFcOmZWHnG3MJunZ45RKVDlzg/KkcOXedJm/yM4rM1z6CC8z64buRHfdLSaeRg9yAF97JQS6d8rDTTzzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hU2bVGVR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hU2bVGVR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721978989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9YlUUMETLR2dsXu/4gZO1W5F3Bqvvn+M4ImfPPlpjd8=;
	b=hU2bVGVRb7x9AbDfYnLyGBRnVUOvXQMWUeUmTo5CQJpnsBhFK/Z0//g5moh7HFsftY4+05
	kh4C2x0FTx9sQpLhMfBaDqTQWgxKiGrLNznyDZC39B/REFBi0e/zjVeR14PnKGuLjWGo04
	YAjlF6Q8qqHeEZyRhI+i5zNec48s/as=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-eCoRmyt9OfCpFg6aygzLgA-1; Fri, 26 Jul 2024 03:29:47 -0400
X-MC-Unique: eCoRmyt9OfCpFg6aygzLgA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4279837c024so12852275e9.2
        for <virtio-dev@lists.linux.dev>; Fri, 26 Jul 2024 00:29:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721978986; x=1722583786;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9YlUUMETLR2dsXu/4gZO1W5F3Bqvvn+M4ImfPPlpjd8=;
        b=t5CToVuU8IVIU1++8irkH6Z+xjXAlF6jekU44V+lPJiXtpTmLOhz5qdRPjP9DYQB2s
         OnPAZ3+CZmf5pc10i9jarQlY4UA+E33RVPUP/cQtYtQJAoRp3LGibJeCrO/F5bcMdzqX
         RA6RMF0jMODUyT5sS3hkLqZqE80t3cjiH6Rp15BFrBMm6pnQGjQQ8QsnSgME9bqab+iP
         9rMWxnY9MllOFGMvo3it9b+5E/pQz1gRa7bIMPwWfTSuPJVUKfV4WTB0OxXJHpq/hc9R
         mIYA8c8qXjwRiXoN3TAxczLsoHWtqROW0RB0tPoGPoptDeLQKJyaRtVuhA0X3efUEKQ+
         KLAg==
X-Forwarded-Encrypted: i=1; AJvYcCVrI9aXQoO3LLWORmkBNDHd76iDoc6wQp576/VXSUr3Bm7UD5uexIbb+xd9+3NI5lzGaXGIdzpyAYI+u2tHMdUzPNKdeZvYBO4WBQ==
X-Gm-Message-State: AOJu0YwBxl/xfWyZaMl3KWVtXu9vft2w4S+QH1gGvxlBoI9VVJVKzYgb
	DG3qqQHCymzk5tfJYmqiTihObKq1ZUfzRUn+mauf+Uwf/6EqXfdQrFEL3dEkuzhaBJgoAb5bxU9
	6yCA+KmGA1ae86ykoRAulVDjq59NV8AMqhQHXfbxub5uQ3pbYRJJ2XkGTRn4=
X-Received: by 2002:a5d:518d:0:b0:368:3194:8a85 with SMTP id ffacd0b85a97d-36b363e6da4mr2982056f8f.7.1721978986281;
        Fri, 26 Jul 2024 00:29:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAMMoNkp5PS6h+xxtaSrGI0s9UEC7D4+/tpvS4eIgwXP4pna3OkpPlaDbPeiNdIKgNBo2MWQ==
X-Received: by 2002:a5d:518d:0:b0:368:3194:8a85 with SMTP id ffacd0b85a97d-36b363e6da4mr2982030f8f.7.1721978985559;
        Fri, 26 Jul 2024 00:29:45 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f7:28ce:f21a:7e1e:6a9:f708])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367fc4casm4203822f8f.52.2024.07.26.00.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 00:29:44 -0700 (PDT)
Date: Fri, 26 Jul 2024 03:29:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
Cc: Jason Wang <jasowang@redhat.com>, xieyongji@bytedance.com,
	stefanha@redhat.com, virtio-dev@lists.linux.dev,
	virtualization@lists.linux.dev, quic_mnalajal@quicinc.com,
	quic_eberman@quicinc.com, quic_pheragu@quicinc.com,
	quic_pderrin@quicinc.com, quic_cvanscha@quicinc.com,
	quic_pkondeti@quicinc.com, quic_tsoni@quicinc.com,
	eperezma <eperezma@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Cindy Lu <lulu@redhat.com>
Subject: Re: [RFC] vduse config write support
Message-ID: <20240726032801-mutt-send-email-mst@kernel.org>
References: <20240724033816.GD492231@quicinc.com>
 <CACGkMEs_FHg6xZAw2V7AKvj5XFCmaA0Xm+ei7z4OFJPNgO5Thw@mail.gmail.com>
 <20240726070324.GA723942@quicinc.com>
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240726070324.GA723942@quicinc.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 26, 2024 at 12:33:24PM +0530, Srivatsa Vaddagiri wrote:
> > Maybe you can give an example for this? We cache the configuration
> > space to a faster access to that.
> 
> Yes for the same reason of faster access, we wish to have config information
> cached in hypervisor. In case of VDUSE,
> 
> Guest read -> (VM exit) -> VHOST_VDPA_GET_CONFIG -> vduse_vdpa_get_config
> 
> Basically a guest read terminates in host kernel, before resuming.
> 
> In our case,
> 
> Guest read - (VM exit) - Hyp emulates read - (VM resume)
> 
> So a guest read would terminate in hypervisor itself, before it is resumed. 
> 
> Without this optimization, guest VCPU would have stalled until VMM in host can
> emulate it, which can be long, especially a concern when the read is issued in
> hot path (interrupt handler, w/o MSI_X).

Instead of optimizing INT#x (which is futile, it's a shared interrupt
and will trigger a ton of exits anyway), just enable MSI-X.

