Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A727C268FD8
	for <virtio-dev@lists.linux.dev>; Mon, 19 May 2025 07:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747641255; cv=none; b=GI1KQn5peekjLufMgIjplWb3OUyIljL3/gEX6m3Q4vevN85Eoqa8qVLrRwA2nS2AeVrtY/eokNwrnqOZWU3GAeoIlGbVWOfqeuXkLJJvdzxX717nh70cfIHGk5ei+jD4I0Npg+5A18hdUc5WjnVW1bcoFE4G6DDPcoSIKlSS2N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747641255; c=relaxed/simple;
	bh=gHw9xM47vpgNmmAxCbICgREiCN6VsyLJsErmhJYQp2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=LVtj4q5aelt8bGLHM0sGrj8OeBC0On0NU8zpipPL0W0q5wa+mkdIz6ElWUBHJURSQvolrjQh07CseOtXI6d07Z+5fDnTSdcjLWcGodolZkutMhJ5zXqljIKTNGc0Lt+knjxrZ9JyO2ITrSYeSt/k3ODrFyNATE/FklzCvaD/g6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OqXTMFNZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OqXTMFNZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747641248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YwmBBOp9THTBNT9jNMewePNtCq9SepWACAPy4cTXeSE=;
	b=OqXTMFNZXrV6DfIAAyNXaEfGyNn6g7CDVccBcBBvZjc5Q5yOwgymcECx7wv+IFpCL3NFLx
	WBAeiTntsLcDw/QkpBLyEtVl5leveMo9Bpvenl+AfKDUVHEW0zaBONKMigRTLPiPfBQy5g
	BBOSC6FfMHJo3YjN86PTGszXnebf7NQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-fYl3nV3jNwuRBb8mQmU3xg-1; Mon, 19 May 2025 03:54:07 -0400
X-MC-Unique: fYl3nV3jNwuRBb8mQmU3xg-1
X-Mimecast-MFC-AGG-ID: fYl3nV3jNwuRBb8mQmU3xg_1747641246
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a3696a0d3aso455749f8f.2
        for <virtio-dev@lists.linux.dev>; Mon, 19 May 2025 00:54:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747641245; x=1748246045;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YwmBBOp9THTBNT9jNMewePNtCq9SepWACAPy4cTXeSE=;
        b=ensbvi4e4/7u1SX30QgWkYn4V0Mqcu3l1sG2PtC2zGj+WMc9Biw50LjprD72raFoXb
         B8Lm6i2n9Nbngfd1CwVKIJhrZf6bILf/knslv2DHMruFUoNREVIn8a7mhdq1diAbOsol
         RyHVwC4b6yhJYAwYe9nvPQZMNq9HbgL02+OniOuN67qojxqllbHNV13JsX15bmwcpoKw
         IxIQ1UY0ewt7H34EyyzRyxWxUnSI13SWZj+EQiLg6MU6KnaII7mjtqk9L2KbirGsptp8
         gpTV06h+Y4EyJDNQZLrlh54xN8NtKP9zOu8s4G2N0TyHAQQiuL0C2S1FB1jd19bf8jyq
         MJSw==
X-Forwarded-Encrypted: i=1; AJvYcCWU8lag/vjI81hZCM5FoKhnKYT2jwL5Q/rPwqK5/ZuELSbQSlND0E+E9z1kurpsOaDgK2/9RhYU3AtN@lists.linux.dev
X-Gm-Message-State: AOJu0YyUZ1mCBJyS9QIXOXGWp/VTORnDGTm1b8orAATl7Y5/SYe4CQqk
	8mCiCkAeTcYCUfAtJfHha+wW4WYGj1OcWqiVb0+vc8p/b9NIEvwU6f78y+ke97+JYP/ySNH8wfb
	SZorHp3ZzGD4b4VJ84XzFFZOLwxMA5r5jQ/bXutQ90ENSSrO6XrTr4kmjLR/efeU=
X-Gm-Gg: ASbGnct8tE6tbb7ji24unxuqSJDMpcyOpjIYheKaPvZ5tzpmXeR/3XeT4fJrpxm/BIk
	pVycl1Gh/U/T7z7nFra6eYdUTnts+vpI4Kzvta10ZzRt5F0LwDC9xN42EFm1MW0VkJqetJo09Tk
	nlbkdGfcpEvVMhIrT7nUlaIxAnEWTCb1ywKFWxsP0Vn6HAP1zSzn6XcPU5PjKNrdYeIZ74KXrVN
	cq3begAT0Gxk1UAAxrOKytFfVUEq/XUl2Q2x3ByjoVy0NEdsaVkJjup6IXMYzJ5lceeIOGqZo2v
	BnbHyg==
X-Received: by 2002:adf:9d91:0:b0:3a3:648c:e6c0 with SMTP id ffacd0b85a97d-3a3648ce6e2mr6828929f8f.10.1747641245453;
        Mon, 19 May 2025 00:54:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEw5NXWbVFRiP6/EUGyjabOk7wWNDTaYhl+EprjY4n0MkA6Y+Id8YvJMe07oFdvC+yFF4ArjA==
X-Received: by 2002:adf:9d91:0:b0:3a3:648c:e6c0 with SMTP id ffacd0b85a97d-3a3648ce6e2mr6828911f8f.10.1747641245107;
        Mon, 19 May 2025 00:54:05 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f39ef8bbsm204640365e9.37.2025.05.19.00.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 00:54:04 -0700 (PDT)
Date: Mon, 19 May 2025 03:54:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: virtio-comment@lists.linux.dev,
	VirtIO Dev List <virtio-dev@lists.linux.dev>,
	Bill Mills <bill.mills@linaro.org>,
	David Hildenbrand <david@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Sergio Lopez <slp@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
	Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: Central repo for VirtIO conformance tests?
Message-ID: <20250519034810-mutt-send-email-mst@kernel.org>
References: <87semtpjrt.fsf@draig.linaro.org>
 <CAAjaMXZgeNpExoiDKr3RRms_voE0bU9G033gOmawDqsFbGj2Gw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAAjaMXZgeNpExoiDKr3RRms_voE0bU9G033gOmawDqsFbGj2Gw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -iCKlZKgZY8FYtsOkNEvfl3fzpC7A8n5XiCEDMaJbtk_1747641246
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 19, 2025 at 10:43:33AM +0300, Manos Pitsidianakis wrote:
> Pinging this thread to ask the OASIS people: Would it be possible to
> host a software project (this testsuite) under OASIS but with a
> lighter contribution process? We expect everyone to be contributing to
> them, from open source/proprietary hypervisor developers, to kernel/OS
> developers, hobbyists and professionals alike. So I think a low
> barrier of entry would be reasonable here.

Take a look here pls:
https://www.oasis-open.org/open-repositories/#licensingRules



> Seeing as a test suite is essentially tied to the published VIRTIO
> spec itself it also makes it a good fit semantically. Having a suite
> with multiple VIRTIO implementations including slim images with Linux
> would also give a wider frame of reference for downstream consumers of
> the spec. Currently, the Linux kernel is the de facto (because it's
> also open source) VIRTIO implementation on the frontend side and
> oftentimes we end up looking at what Linux does to implement backends.
> 
> We'd like to potentially:
> 
> - Expand the array of rootfs images with more Linux userspace tests
> for more devices
> - Expand the array of rootfs images with other open source OSes as
> they gain VIRTIO functionalities
> - Implement missing VIRTIO spec features in our unikernel test and
> also exercise realistic but basic VIRTIO command use scenarios for
> more devices
> - (This is on my personal wishlist) write a VIRTIO fuzzer framework,
> similar in spirit to Google's syzkaller project (unsupervised
> coverage-guided kernel fuzzer)
> - As a stretch goal, provide a reference test runner framework to run
> the images with QEMU and rust-vmm vhost-user backends for people to
> adapt to their setups.
> 
> PS: The git repositories Alex linked are temporarily inaccessible due
> to internal unrelated issues, and will be public again.


At the moment, from the above link, and if you want it tied to OASIS
open repositories, it has to be one of:

BSD-3-Clause License (which shall apply if the TC makes no license selection in its approval action); Apache License v 2.0; CC-BY 2.0; CC-BY 4.0; Eclipse Public License v 1.0.


I am not a lawyer, but can full OS images we licensed under one of
these? If not, you are better off creating the repository itself outside
the confines of OASIS.

You can still use e.g. virtio-dev mailing list for communication.

> -- 
> Manos Pitsidianakis
> Emulation and Virtualization Engineer at Linaro Ltd

