Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0991C5485
	for <virtio-dev@lists.linux.dev>; Mon, 19 May 2025 12:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747657851; cv=none; b=qHFz8H5zQxcBgd2ynBORJ57oRwlewvN1yniQPHiWRAbZyNdEWQ1qkbuQhW+oi2w9GznrozCKAUKIP5JiWxar7Qg2xQA9Q8ilxyX71SwCmgKq9MW4rHNV1p9Sx3T9kXMF69V4AdeIsP4HGPM+otlh8/epS4OpJ/eJw0VXPWbUcRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747657851; c=relaxed/simple;
	bh=cjmIuppiw3ZfVZeRQUzXzpW2c0/PI1s4TY/CoiOGaSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=bkYHa+vm2c7SJpcjYW+10vul6AXa7CumxIwRCxoIxtIFc9eOgWayT+NhcxUqlq0nwdaVhejMpBDi+wnLnxznFnt41TI8IBAtm4QlG1haXQl2rNuoRwk7PQVzmqcyRcGX6mUKvhJR4JINoPJ3JYhTjdj4gTGAVzj6varm1fgCD7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BF35268G; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BF35268G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747657847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mMzdHr/O71dzg2i0/IqeRVkSu7FOn4cczFEMrikDdIs=;
	b=BF35268Gh3BASNOtvU/FPZuqLxbDHLHmGtL8uJzArKbblgLENExYofW4Uy24QW/CzIGpZ0
	bcsWYFmGZzhMT56+5Pr2WofjvHgfdxokj64F+H1fY5gnx2y1C8BFXrWCPo5CFjSGCYtkmh
	UV1pYEMoW8bFFOZPNL/hUwZcuRlMFtY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-26KB1QD2MH25mOksIZy-jg-1; Mon, 19 May 2025 08:30:44 -0400
X-MC-Unique: 26KB1QD2MH25mOksIZy-jg-1
X-Mimecast-MFC-AGG-ID: 26KB1QD2MH25mOksIZy-jg_1747657840
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a35bf8377fso2938596f8f.1
        for <virtio-dev@lists.linux.dev>; Mon, 19 May 2025 05:30:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747657840; x=1748262640;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mMzdHr/O71dzg2i0/IqeRVkSu7FOn4cczFEMrikDdIs=;
        b=lasjl4lHeWC8iZjjJkW9besjBKyvLJq5Mc2AGAKVYhiJAQPzZ+yatFlLwktWtpnccD
         f9tamDKd+pOCE3Q8+bw96eY5CrP97/netPXT9zD2CR1YYIKzenrC49xl/0t22SBF60LC
         d6nTmWfH3trZ5zk6Euvw/hWVg4FNgFalY7CQAJ+Rv23iRyDEuNTHxC1vEmboXc7HXfxl
         Lk9ZdQc4lpNHJ7MLvBClYNh77F7frJX4HuVHXNxq2GrZ21JdWymLznJiUfVXExJUIqLW
         8Ap+LpxLQ2Z5TXpM8VIRiehK5/Hz/ZKgJT+mKmjwdjeGXgy1TL8LouYkrsGuNu/VCst8
         r8uQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2TCyAoY6TNi3RKNaCBI38AP4mHpJD+xxCoLqq7VQsrgFIeQ+JdesR/y9ejP5U/zIcFzLGLwBPdr85@lists.linux.dev
X-Gm-Message-State: AOJu0YxmT41DoDGDkj9Ax7KbtTBwtI3RzvXzaxD3P4yQdWwGvN1Agp3F
	U2CLjbDmgwtUdICNFq2Zo0S5gKMRAdXICuCvS1ALvf5rFPHFMXNrEC+yEPedjmSe/9Q+D94wQ6A
	x/wf2vMbb/AFmq5mfKnPvNKax3yIadZ0H5lqItaU80LFE49wbwn+PtNtfbo6YLQE=
X-Gm-Gg: ASbGncvBPrtKep8MISkqvzlxX+n8UkTI2I0Xzh7/lcCpe4lrLP0W9fvyrJI4XmlzJTJ
	VclIR3151Ip5ZuyYNVAuK+iT+WmYrK2LjXBOiqBbnm2PW4JoLc+G/WXxyNpujS+D68n75VOFDtj
	DD/+sTsFXRnkw1kQcTf1M+tytBm8GCoXI4yZy0rWeVk0FNvyF1Rm34EAeFykM6uKyDrrNyq23HW
	id7/HAHFBPv+NELLEz1nPiU03/ynSVSO79pQjuV3IOy4Kgpg/m393PUjXpomklWd1lADTG0K1dO
	9rDTWA==
X-Received: by 2002:adf:f30f:0:b0:3a3:60f0:e2eb with SMTP id ffacd0b85a97d-3a360f0e520mr8699393f8f.33.1747657839977;
        Mon, 19 May 2025 05:30:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnor2EOpFboeqwlA8m+khJQ/6TlnD4f82+4QfCj9mUYV/zj5uEb4JZVo+3adLk8MZfoqSzsw==
X-Received: by 2002:adf:f30f:0:b0:3a3:60f0:e2eb with SMTP id ffacd0b85a97d-3a360f0e520mr8699358f8f.33.1747657839472;
        Mon, 19 May 2025 05:30:39 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca5a5b4sm12521119f8f.21.2025.05.19.05.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 05:30:38 -0700 (PDT)
Date: Mon, 19 May 2025 08:30:36 -0400
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
Message-ID: <20250519082712-mutt-send-email-mst@kernel.org>
References: <87semtpjrt.fsf@draig.linaro.org>
 <CAAjaMXZgeNpExoiDKr3RRms_voE0bU9G033gOmawDqsFbGj2Gw@mail.gmail.com>
 <20250519034810-mutt-send-email-mst@kernel.org>
 <CAAjaMXafNUEk6jAkh-9iY6JNSKzawM+GRJAHAxZ6X9dkwhMyfg@mail.gmail.com>
 <20250519041030-mutt-send-email-mst@kernel.org>
 <CAAjaMXZZX+i86U4_N1_8+czc2kcWP3=NUgLjT8BMemCYBD6uUw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAAjaMXZZX+i86U4_N1_8+czc2kcWP3=NUgLjT8BMemCYBD6uUw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: AgBvDYMdBLMLnJN2RNhJj9a2yCllepDIdv8JqyBPj20_1747657840
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, May 19, 2025 at 11:18:36AM +0300, Manos Pitsidianakis wrote:
> On Mon, May 19, 2025 at 11:15 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, May 19, 2025 at 11:03:43AM +0300, Manos Pitsidianakis wrote:
> > > Hello Michael, thanks for the reply,
> > >
> > > On Mon, May 19, 2025 at 10:54 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Mon, May 19, 2025 at 10:43:33AM +0300, Manos Pitsidianakis wrote:
> > > > > Pinging this thread to ask the OASIS people: Would it be possible to
> > > > > host a software project (this testsuite) under OASIS but with a
> > > > > lighter contribution process? We expect everyone to be contributing to
> > > > > them, from open source/proprietary hypervisor developers, to kernel/OS
> > > > > developers, hobbyists and professionals alike. So I think a low
> > > > > barrier of entry would be reasonable here.
> > > >
> > > > Take a look here pls:
> > > > https://www.oasis-open.org/open-repositories/#licensingRules
> > > >
> > > >
> > > >
> > > > > Seeing as a test suite is essentially tied to the published VIRTIO
> > > > > spec itself it also makes it a good fit semantically. Having a suite
> > > > > with multiple VIRTIO implementations including slim images with Linux
> > > > > would also give a wider frame of reference for downstream consumers of
> > > > > the spec. Currently, the Linux kernel is the de facto (because it's
> > > > > also open source) VIRTIO implementation on the frontend side and
> > > > > oftentimes we end up looking at what Linux does to implement backends.
> > > > >
> > > > > We'd like to potentially:
> > > > >
> > > > > - Expand the array of rootfs images with more Linux userspace tests
> > > > > for more devices
> > > > > - Expand the array of rootfs images with other open source OSes as
> > > > > they gain VIRTIO functionalities
> > > > > - Implement missing VIRTIO spec features in our unikernel test and
> > > > > also exercise realistic but basic VIRTIO command use scenarios for
> > > > > more devices
> > > > > - (This is on my personal wishlist) write a VIRTIO fuzzer framework,
> > > > > similar in spirit to Google's syzkaller project (unsupervised
> > > > > coverage-guided kernel fuzzer)
> > > > > - As a stretch goal, provide a reference test runner framework to run
> > > > > the images with QEMU and rust-vmm vhost-user backends for people to
> > > > > adapt to their setups.
> > > > >
> > > > > PS: The git repositories Alex linked are temporarily inaccessible due
> > > > > to internal unrelated issues, and will be public again.
> > > >
> > > >
> > > > At the moment, from the above link, and if you want it tied to OASIS
> > > > open repositories, it has to be one of:
> > > >
> > > > BSD-3-Clause License (which shall apply if the TC makes no license selection in its approval action); Apache License v 2.0; CC-BY 2.0; CC-BY 4.0; Eclipse Public License v 1.0.
> > >
> > > OK that's doable and completely reasonable.
> > >
> > > > I am not a lawyer, but can full OS images we licensed under one of
> > > > these? If not, you are better off creating the repository itself outside
> > > > the confines of OASIS.
> > >
> > > We'd be hosting essentially build recipes for the images, for tests
> > > where we use other people's code. The build recipes would have the
> > > same license.
> > >
> > > If I understand the CLA requirement correctly, even if the
> > > contribution is merged by a maintainer who has signed the CLA, the
> > > original contributor who has no write access to the repository, has to
> > > sign the CLA as well?
> >
> >
> > I think is would be the OASIS equivalent of the Linux DCO:
> >         Each person making a repo contribution must be bound to the terms of the
> >         CLA, by obtaining their signature (which may be an equivalent electronic
> >         assent)
> 
> So just a Signed-off-by? That massively simplifies things!


Well we need to make sure people read CLA and know what
it implies.
Which unfortunately I can not tell you what it is since
CLA at OASIS site is down:
https://www.oasis-open.org/resources/open-repositories/cla/individual-cla


I will reach out to OASIS to figure it out.

> > If you like I can reach out to OASIS to confirm.
> 
> Yes, that'd be very helpful, thank you.
> 
> 
> -- 
> Manos Pitsidianakis
> Emulation and Virtualization Engineer at Linaro Ltd

