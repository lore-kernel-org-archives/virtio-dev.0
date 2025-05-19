Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455F612FF6F
	for <virtio-dev@lists.linux.dev>; Mon, 19 May 2025 08:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747641854; cv=none; b=CfeRWOM8SeOcRA394z+joNty4DpfCKl0D5RBeGi2KmveWd0NkRFXxC1zC6UfB6/agK3mOH5Mqif69+iPdzpPQDOlwuci0DMPOBbhEGDHpWqqyn2aXQ4D5hAFenw45akbX77jpZsf72lVz0Wgj8m/WLn0FLU2ht6LP+r9dzZ40Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747641854; c=relaxed/simple;
	bh=kkdpEgnkpb3bHB+BSDlkQC+9DQcAfrN6T5+JyTpz8V0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NkYQShMBuS0MoyeB9OfeikMgwTnhoccCv/58NoqhQfmu+fKjX9HxWLRiU12SqIvRW/vsujmaR0DN6hGNc/JAXGGplOSylehL7b2njzxQ/d4iKGKbI0GJ50oYuaPbElHXS47fdQxL4hOtPN8qGpFnmT84H/bv0WcwYsiyA4S2nNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VulF96SD; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VulF96SD"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-601a6e2e93cso2681691a12.1
        for <virtio-dev@lists.linux.dev>; Mon, 19 May 2025 01:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747641850; x=1748246650; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kkdpEgnkpb3bHB+BSDlkQC+9DQcAfrN6T5+JyTpz8V0=;
        b=VulF96SD8XrMH44tC11p3XAbyi1GzEOoZrxRnx6CzSKivlZgXNpItl4lTt3XmGL+CL
         GXo2Zx5GlrbxKil6orUYBeL8vtVL2VC92uC2Ajuh1sXtLyXcjm0RXnSs8k9bDvv1J5TL
         +xAaGRj8m4AorozjXg4H4jlfwYLuNYxpIeIvuu6eIOKHHO/mBmnKb1yaIFx+scIV9ntX
         gLtwVXsFeqHpNh0q1xEup7L+lIBhs63uN1AqJT5qH2Zk5W3+2Pw2XZR+NTAk4/6afV3z
         klRHfXPoif+z18XuMo7fUNVvuSV5G5CoDc8xiz2AJTnxmPTlp6PTTQzzjCIhLV9+BNBs
         ljMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747641850; x=1748246650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kkdpEgnkpb3bHB+BSDlkQC+9DQcAfrN6T5+JyTpz8V0=;
        b=bhacjpW7CJrVkc9VkPq12OCZSVw6IkIh6yZUpPj9PoJXruzTARvGN3cO3cS5FZErve
         PpYdSZh4jRIdSydNC6U8b4SUpfeMsPYZVbNUfycXmIT03Gg+K4Ei5IdCSIOfly4JnByC
         Qxu1y/CMoOV0p2lcwiIqOaWS6ppO4rxEw6Z7sgHxUC4MH8Vm1j+A/480B3EeXk5NSVD5
         73/NuVy0sBM1hd7CIAcQeHmhJnXeJ0Hs+sJPgtl/IKwPhxo4rn9E3iV0j7pfb3iBvZj5
         q5NFUuCK/O0G1NWvk9SMVdg5QVcF1D3MBOaLiEokfc6rvcScPY/F/ePpRIM9J92nPBWm
         CcXg==
X-Forwarded-Encrypted: i=1; AJvYcCVIT8ByYZh9Fov3ytJNNWzHr/tLh77ArN+TEzrs5p/HphnzaHasXnFU/ZPzhqMzTlEzQTmVYSKMFHrK@lists.linux.dev
X-Gm-Message-State: AOJu0YzvllZzkVCQ7IpSNKAw6VGT0Xljp0IU2ycTYURBt+fOTcPxGAH2
	O/gXztjNs/GGZXpf/o6kReFjlkM+cORdaFjthea8Ngsrec1NMirnBtBoKE5PnQr5i+/F8nu8n65
	Bh0HnMtrDweEoQF/oUogyzR3yphEZAMOkH8pdsCt9KA==
X-Gm-Gg: ASbGnctdlnQ+3IR1jXdUz5k4RM+Jfl+/UIWWtUMzCcM/sN1V+I6AKNtGENWo3rD7u3M
	5o5zDS0ZQ+WKBlapzDRatQ0iNW9puvoiehQOx892S+/SEZwYzKbpBZxE75VZeZ3ScZI7jlyu43n
	f4j8zUoEbVLlKuc6JUTPta1SiCZeM=
X-Google-Smtp-Source: AGHT+IHmirZYru9Ev0+zWPFghJlNnoF6YT+O2Lu3tcabpt9VlhX0uuuxlTg3AUwlnBrNyij1P8pOcY4oGaA77YypIZI=
X-Received: by 2002:a05:6402:1ec4:b0:5f7:f4ff:6267 with SMTP id
 4fb4d7f45d1cf-60090122d6bmr10464368a12.17.1747641850532; Mon, 19 May 2025
 01:04:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <87semtpjrt.fsf@draig.linaro.org> <CAAjaMXZgeNpExoiDKr3RRms_voE0bU9G033gOmawDqsFbGj2Gw@mail.gmail.com>
 <20250519034810-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250519034810-mutt-send-email-mst@kernel.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 19 May 2025 11:03:43 +0300
X-Gm-Features: AX0GCFvudy-l2E0WMQ1r6lliHiHnn8XxkdZhfoxVLqknxRREMr077S4iZT8FvDI
Message-ID: <CAAjaMXafNUEk6jAkh-9iY6JNSKzawM+GRJAHAxZ6X9dkwhMyfg@mail.gmail.com>
Subject: Re: Central repo for VirtIO conformance tests?
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.linux.dev, 
	VirtIO Dev List <virtio-dev@lists.linux.dev>, Bill Mills <bill.mills@linaro.org>, 
	David Hildenbrand <david@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
	Sergio Lopez <slp@redhat.com>, Cornelia Huck <cohuck@redhat.com>, 
	=?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Michael, thanks for the reply,

On Mon, May 19, 2025 at 10:54=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Mon, May 19, 2025 at 10:43:33AM +0300, Manos Pitsidianakis wrote:
> > Pinging this thread to ask the OASIS people: Would it be possible to
> > host a software project (this testsuite) under OASIS but with a
> > lighter contribution process? We expect everyone to be contributing to
> > them, from open source/proprietary hypervisor developers, to kernel/OS
> > developers, hobbyists and professionals alike. So I think a low
> > barrier of entry would be reasonable here.
>
> Take a look here pls:
> https://www.oasis-open.org/open-repositories/#licensingRules
>
>
>
> > Seeing as a test suite is essentially tied to the published VIRTIO
> > spec itself it also makes it a good fit semantically. Having a suite
> > with multiple VIRTIO implementations including slim images with Linux
> > would also give a wider frame of reference for downstream consumers of
> > the spec. Currently, the Linux kernel is the de facto (because it's
> > also open source) VIRTIO implementation on the frontend side and
> > oftentimes we end up looking at what Linux does to implement backends.
> >
> > We'd like to potentially:
> >
> > - Expand the array of rootfs images with more Linux userspace tests
> > for more devices
> > - Expand the array of rootfs images with other open source OSes as
> > they gain VIRTIO functionalities
> > - Implement missing VIRTIO spec features in our unikernel test and
> > also exercise realistic but basic VIRTIO command use scenarios for
> > more devices
> > - (This is on my personal wishlist) write a VIRTIO fuzzer framework,
> > similar in spirit to Google's syzkaller project (unsupervised
> > coverage-guided kernel fuzzer)
> > - As a stretch goal, provide a reference test runner framework to run
> > the images with QEMU and rust-vmm vhost-user backends for people to
> > adapt to their setups.
> >
> > PS: The git repositories Alex linked are temporarily inaccessible due
> > to internal unrelated issues, and will be public again.
>
>
> At the moment, from the above link, and if you want it tied to OASIS
> open repositories, it has to be one of:
>
> BSD-3-Clause License (which shall apply if the TC makes no license select=
ion in its approval action); Apache License v 2.0; CC-BY 2.0; CC-BY 4.0; Ec=
lipse Public License v 1.0.

OK that's doable and completely reasonable.

> I am not a lawyer, but can full OS images we licensed under one of
> these? If not, you are better off creating the repository itself outside
> the confines of OASIS.

We'd be hosting essentially build recipes for the images, for tests
where we use other people's code. The build recipes would have the
same license.

If I understand the CLA requirement correctly, even if the
contribution is merged by a maintainer who has signed the CLA, the
original contributor who has no write access to the repository, has to
sign the CLA as well?

> You can still use e.g. virtio-dev mailing list for communication.
>
> > --
> > Manos Pitsidianakis
> > Emulation and Virtualization Engineer at Linaro Ltd
>
