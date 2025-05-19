Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C3E269816
	for <virtio-dev@lists.linux.dev>; Mon, 19 May 2025 08:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747642523; cv=none; b=rDUFuMnN2uzTIZgRLIO4YJvvSmBSG0lejguuIWYx3WKTZDvk6aSGiIBOC/yEAxVucRmd2VcO2pMyMUcdn++VLxzPeq2b6psYPUGt5ICRZQ9mcVH1mxWDgj2LivuOK6FuTKZpulTvSMgHwaWnRwn9Dc6WyWj8ErdDTa7eAgfhi6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747642523; c=relaxed/simple;
	bh=OfG5SD0VusI2l4bkr/ORJINhIBYTVUa3XNBNPgVpYrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=H3GIdZTFSwIDESggMKU3ZXnVVkrVJvFB5riMknCWSrRz/t0Uxh/LWHSPp1csK0dmisvReKSt1xLz+CS6r4nCfQEJSTn3/RB9Ggp5SoRtgtL7LflsJNfrH+wdmIkmWXGV26znvVt8Bd9gNZdvCxRkcDEGl7B1fm8wTtqSyR1IDig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eEE54QAr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eEE54QAr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747642520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gexG3R0s39lzjbGBPXdG/BI3vH65Yjm/9pD4sHiS+MU=;
	b=eEE54QArTUITGdCOCkIdAKWRX84vH3pVm9c3PblUb2mnBku47GGrqK5IQrEC81BrPZ7Odw
	IrKewDCoNdCDVD/9ANyfXo82GP0HNiL6XidlV+vMg9iyXi3Po8nldUV//SbkzB9Tnuv9Lq
	Kj/FVZ6SEn5qo5TGFOpkkVDlvsM/rQg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-938j0TSzPjmACxJufXOtng-1; Mon, 19 May 2025 04:15:19 -0400
X-MC-Unique: 938j0TSzPjmACxJufXOtng-1
X-Mimecast-MFC-AGG-ID: 938j0TSzPjmACxJufXOtng_1747642518
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43d4d15058dso436655e9.0
        for <virtio-dev@lists.linux.dev>; Mon, 19 May 2025 01:15:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747642518; x=1748247318;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gexG3R0s39lzjbGBPXdG/BI3vH65Yjm/9pD4sHiS+MU=;
        b=dfDrk4jtbKCCDE2rzvdHIli+ZFHawi/3l+BEVNPhGzxasLxPnhFV3DCeco1miigI10
         JsR4nkEDdKFS3R4ud3NKmalyJxBZPEdD1Ib4F0XfT3AaTKtCM0Ix8qhf82WOLf2EuTqo
         NEY1LtsSQhfbeYUcmPVTKLmNout6iMj3AAdJlJF2HqZWxavutLpS3xdzyoCT7d2xJ3D/
         vizQzj3eBue3buwsAmUrmiUTWu9yMJhD1Xb8efqXtQsu+4Niruw0QPMLYI0MNbm3P6cy
         gP2aUmxqmKAxZF8vq4Mu9Bd54NqEzVoWxLQRXQEx7xzNU+H/Zw7NKNhlpbkAZO0O2cLw
         qY/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWOxLlQFumZjZL1qFtYfwQTJI7iCpnOa7K/mKICB5BXk/LTcYp9vgCevjhtdGLj/AlSDPuCtdQpdifG@lists.linux.dev
X-Gm-Message-State: AOJu0YxeOI8MJZwlMxRTCnj5HOO1XeebhdXnAc0FWtAvO7fAiXckgzT9
	LSIGbCrbqwbP2laqHCDZ4UBycFpN3G/tLdAoC4or6MBRB7NyEMP46E2bJobpsJljYSyks/oi+uV
	QFWF/uyg9D3Qo3/NpNcuqDaV4n+w8d9IXSZ6XsolwtVSdBOxA+GP8vCZetdlOUkg=
X-Gm-Gg: ASbGncu9Ko3jplhIBbzMd+rHeAWNrdpKqjmxY7jnctwWSSf8pfrS7/Om5vlgukcXamr
	9x54mgEfjEQILlGiOzX2TKOVvOLUpY1IsXQZyNPQceOKP7hUMu8Q3TgQLcKwaPrOcIcb7QWBf8n
	pbFs7H9WQ5qryxx9KKok6ksE/G/uRZl4snydffneB5sf8i6w2u8sp2ZtL59tP3rE3wdACT8/bDd
	Fqns0DnAr6KyEAfEHrSLwtqZ8zOXqsMwtIu7dEG/8jLsGgoRZdu1S/08bjfuOsOzosHZ+CDmv/F
	yViiEA==
X-Received: by 2002:a05:600c:34d4:b0:442:f12f:bd9f with SMTP id 5b1f17b1804b1-442fd671f28mr108219435e9.27.1747642517931;
        Mon, 19 May 2025 01:15:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQde6l3GjhJClh2R7qExVk5SBQhudSuWbw1DfLXAAlnoPwNIuuj3sL49lQK7PiPuPbhw1jeg==
X-Received: by 2002:a05:600c:34d4:b0:442:f12f:bd9f with SMTP id 5b1f17b1804b1-442fd671f28mr108219225e9.27.1747642517480;
        Mon, 19 May 2025 01:15:17 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca5a8c4sm11772768f8f.27.2025.05.19.01.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 01:15:16 -0700 (PDT)
Date: Mon, 19 May 2025 04:15:14 -0400
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
Message-ID: <20250519041030-mutt-send-email-mst@kernel.org>
References: <87semtpjrt.fsf@draig.linaro.org>
 <CAAjaMXZgeNpExoiDKr3RRms_voE0bU9G033gOmawDqsFbGj2Gw@mail.gmail.com>
 <20250519034810-mutt-send-email-mst@kernel.org>
 <CAAjaMXafNUEk6jAkh-9iY6JNSKzawM+GRJAHAxZ6X9dkwhMyfg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAAjaMXafNUEk6jAkh-9iY6JNSKzawM+GRJAHAxZ6X9dkwhMyfg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: efVt9GCclZRZZ9IwNwCrolWwqNp2rA-cPR_RXEDOIyA_1747642518
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, May 19, 2025 at 11:03:43AM +0300, Manos Pitsidianakis wrote:
> Hello Michael, thanks for the reply,
> 
> On Mon, May 19, 2025 at 10:54 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, May 19, 2025 at 10:43:33AM +0300, Manos Pitsidianakis wrote:
> > > Pinging this thread to ask the OASIS people: Would it be possible to
> > > host a software project (this testsuite) under OASIS but with a
> > > lighter contribution process? We expect everyone to be contributing to
> > > them, from open source/proprietary hypervisor developers, to kernel/OS
> > > developers, hobbyists and professionals alike. So I think a low
> > > barrier of entry would be reasonable here.
> >
> > Take a look here pls:
> > https://www.oasis-open.org/open-repositories/#licensingRules
> >
> >
> >
> > > Seeing as a test suite is essentially tied to the published VIRTIO
> > > spec itself it also makes it a good fit semantically. Having a suite
> > > with multiple VIRTIO implementations including slim images with Linux
> > > would also give a wider frame of reference for downstream consumers of
> > > the spec. Currently, the Linux kernel is the de facto (because it's
> > > also open source) VIRTIO implementation on the frontend side and
> > > oftentimes we end up looking at what Linux does to implement backends.
> > >
> > > We'd like to potentially:
> > >
> > > - Expand the array of rootfs images with more Linux userspace tests
> > > for more devices
> > > - Expand the array of rootfs images with other open source OSes as
> > > they gain VIRTIO functionalities
> > > - Implement missing VIRTIO spec features in our unikernel test and
> > > also exercise realistic but basic VIRTIO command use scenarios for
> > > more devices
> > > - (This is on my personal wishlist) write a VIRTIO fuzzer framework,
> > > similar in spirit to Google's syzkaller project (unsupervised
> > > coverage-guided kernel fuzzer)
> > > - As a stretch goal, provide a reference test runner framework to run
> > > the images with QEMU and rust-vmm vhost-user backends for people to
> > > adapt to their setups.
> > >
> > > PS: The git repositories Alex linked are temporarily inaccessible due
> > > to internal unrelated issues, and will be public again.
> >
> >
> > At the moment, from the above link, and if you want it tied to OASIS
> > open repositories, it has to be one of:
> >
> > BSD-3-Clause License (which shall apply if the TC makes no license selection in its approval action); Apache License v 2.0; CC-BY 2.0; CC-BY 4.0; Eclipse Public License v 1.0.
> 
> OK that's doable and completely reasonable.
> 
> > I am not a lawyer, but can full OS images we licensed under one of
> > these? If not, you are better off creating the repository itself outside
> > the confines of OASIS.
> 
> We'd be hosting essentially build recipes for the images, for tests
> where we use other people's code. The build recipes would have the
> same license.
> 
> If I understand the CLA requirement correctly, even if the
> contribution is merged by a maintainer who has signed the CLA, the
> original contributor who has no write access to the repository, has to
> sign the CLA as well?


I think is would be the OASIS equivalent of the Linux DCO:
	Each person making a repo contribution must be bound to the terms of the
	CLA, by obtaining their signature (which may be an equivalent electronic
	assent)

If you like I can reach out to OASIS to confirm.

> > You can still use e.g. virtio-dev mailing list for communication.
> >
> > > --
> > > Manos Pitsidianakis
> > > Emulation and Virtualization Engineer at Linaro Ltd
> >

