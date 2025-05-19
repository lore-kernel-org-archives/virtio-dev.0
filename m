Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F73267F43
	for <virtio-dev@lists.linux.dev>; Mon, 19 May 2025 07:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747640644; cv=none; b=pzisscyyC7E9J1U7oH8QEsdO7DbGyGYnNOjJf0yWyR7aZI1cCsJTDYwGqc79epsjUXiKCQencFW078e7ba8qsHi+6o191MOmLEl8sCD6XngYBbAV6rECghwTfq2t0zQ45BnkH1yvFwm08AhLiDMgvAXnmw2paL3Vbs6nCLc6Mzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747640644; c=relaxed/simple;
	bh=E+nNJh5Jw2Go1iGRwdcYTZMNTtSbVMrUW4KHfaq7MwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W09vZ4UlU3VeeuwKFGDV91J5c2Ce7RFPT/uJw/aFctzEyufr3VfHtMdCzizStzjScl0IAWICp5tVq6X4noYY4vmRfLyne9/NZXVapfoyGEEsQ2JrV9akTBocyx58XxV/K03fYm9QvY+d7UFHPjcfgJMeZ53lnVc7OlGnpsH4LNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jfieTIKH; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jfieTIKH"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ad1a87d93f7so657122366b.0
        for <virtio-dev@lists.linux.dev>; Mon, 19 May 2025 00:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747640640; x=1748245440; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mmi2WE/W8I5nkjoKs+rIsXivk4kHQeci5gHFY/+6N0M=;
        b=jfieTIKHaNtifNMZaRgoCzfqfHv8GfP/6nZpkI7wkxC0sbMjEV8UPC+PQ94iuuzAQQ
         ra+Bjq6GCIWcuRsobLOgxCadFD93sfbe2MplYKzd6+YgKILh8kS4Ufar4WBaEgkRftcp
         ZBxpufoAZ9A4G73iR/0Pw4UNr2fUE4iRSORf+GNU9B3mRO4c0c9SFPitolQgCUyWZZQI
         RzTrMj+IwsFeVjCJd/Gz0E3KK6p/w1TUwu65HzVRDbkch4VIDVw/edkxNJR/9+lEtcWj
         jdZBj3EOgmUX1VK9SB5Ir5kR/7V8RCN4xJvnekyny8aNaghYSYjjcvASobypdVJwrgk7
         pxYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747640640; x=1748245440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mmi2WE/W8I5nkjoKs+rIsXivk4kHQeci5gHFY/+6N0M=;
        b=FbdvZz/JVXM6xBbBUgjQCk017qGIQizhyyYme/scb9fisPIhJ/1A8Q/2KmgALTY5Ao
         PW1QOZIzO8USktdyMsPQtUlAJ66CLVk3gSOH0PZHH359nWzkgpy9IfVG9L+5YE5WGlus
         1FlPJyZ4ms6V09wfoVsdWLmynZIDX+cahTbCnVT8z4x33DpOILxT3OD2hUZKL8UGRw12
         0WIs6YrBjny8c2Y49IX3AyWO1lIKHBx+bMa03fH4Q30ytI32M2qaglQdJ1Hl8OVmOGIP
         niNEj4l0/WQHvcanIukJeWb5M4x6YSfXoysnusBSewrd3vQ5d0svk63xuO1cARICiAHp
         NSaA==
X-Forwarded-Encrypted: i=1; AJvYcCW2q0CYHqK8Ylam6Ye0y8c+y3Y/6FXcJBhJGiPQ2SB/6WogL15hktVZEl1+vP5ipAUcxkSVZ+/H3YPO@lists.linux.dev
X-Gm-Message-State: AOJu0YwZHGMBP7qW4eGDiaqavIlQVeuefTNVtori8kdhRLJ9t1nIQbo+
	dmO7JpPmhjjBS0jxXqNytxIhjb4Q1lEheZqpPb/KpxxqlHoDK1LR4h5JlEmilDk+1TYXP4YzaI4
	XlPKUQlmY39kzO85M49HHMImp+D/cpnRaTbypjoxUP6KjF/YYLAJTcyb24g==
X-Gm-Gg: ASbGncvqHrnXb9UPFJ4rhrZsnrrORjACf9CgT5h9Dub79U6rkInOtkwOcbKuY+Xi1u1
	Nm4JLNdrnI9O7SPjKIXRx67smI9+7sI94n7oQhsv4tmdoFCDGzpcpsv2pbC7XqNNQqL4FtHJeRJ
	zXHMlCcxQzq59FZPOuiwNBAfbCj1k=
X-Google-Smtp-Source: AGHT+IHOOltbumYXCHgkLoffx1U6iUJpROfH6gSiv/IG/eaKHwh+vlK3Fmfxvo5MTPnScTa+4rP5T2Qaf90RYHf1/vg=
X-Received: by 2002:a17:907:c21:b0:ad2:28be:9a16 with SMTP id
 a640c23a62f3a-ad536f280cbmr942873566b.51.1747640640403; Mon, 19 May 2025
 00:44:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <87semtpjrt.fsf@draig.linaro.org>
In-Reply-To: <87semtpjrt.fsf@draig.linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 19 May 2025 10:43:33 +0300
X-Gm-Features: AX0GCFs_rRK39V3DxC_Ub9WBuBpQYwMG-H1XMRxkuX6XNQUQr2UDkpZvEU0OMpc
Message-ID: <CAAjaMXZgeNpExoiDKr3RRms_voE0bU9G033gOmawDqsFbGj2Gw@mail.gmail.com>
Subject: Re: Central repo for VirtIO conformance tests?
To: virtio-comment@lists.linux.dev, 
	VirtIO Dev List <virtio-dev@lists.linux.dev>
Cc: Bill Mills <bill.mills@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>, 
	David Hildenbrand <david@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
	Sergio Lopez <slp@redhat.com>, Cornelia Huck <cohuck@redhat.com>, 
	=?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 31, 2025 at 1:38=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@linar=
o.org> wrote:
>
>
> Hi,
>
> We've been working with Panasonic to expand the testing of VirtIO across
> a range of hypervisors and VMMs. We've tackled this with two approaches:
>
>   - simple unikernel to verify features and basic functions common
>   - rootfs images to exercise the whole device
>
> The unikernel utilizes rcore-os's no_std VirtIO drivers to discover and
> initialize a range of VirtIO devices. The tests mostly focus on checking
> no unknown feature bits are advertised as well as ensuring features
> dependencies are properly realizable. This is useful for those
> interested in moving workloads between hypervisors to ensure you don't
> end up relying on a proprietary feature that aren't available elsewhere.
>
> The virgl test also does some very basic blob mapping to check the
> underlying mechanics are working.
>
> The unikernel outputs a TAP stream to make integrating into a test
> harness easier.
>
> You can find the current state here:
>
>   https://git.codelinaro.org/manos.pitsidianakis/virtio-tests
>
> While we only build an aarch64 unikernel the upstream drivers have
> examples for riscv and x86_64 as well.
>
> As more complex VirtIO devices like GPUs tend to have a significant
> user-space component, we have also started building Linux rootfs images
> to exercise those. The images themselves are built against a baseline
> architecture so they can be used on as wide a range of hardware as
> possible. They have been built with buildroot to make them lightweight
> and as close to the upstream projects as possible without relying on
> particular distro support. You may have seen the recent aarch64 GPU
> image being added to QEMU's functional tests recently:
>
>   https://gitlab.com/qemu-project/qemu/-/blob/master/tests/functional/tes=
t_aarch64_virt_gpu.py
>
> I'm currently working on a similar image utilizing a subset of the
> blktests project to exercise the VirtIO block devices. The various
> recipes can be found here:
>
>   https://gitlab.com/stsquad/buildroot/-/tree/adding-blktests?ref_type=3D=
heads
>
> although the intention is for all the recipes and basic QEMU based tests
> to be up-streamed into buildroot in due course. While I will no doubt
> expand the functional tests in QEMU over time to utilize these images,
> there is a wider question of where would be a good place to host a more
> comprehensive VirtIO test suite? While useful for validating proprietary
> hypervisors there are also a bunch of other VMMs and VirtIO backends
> other than QEMU:
>
>   - rust-vmm's vhost-device collection of vhost-user backends
>   - CrosVM
>   - Cloud Hypervisor
>   - libkrun
>
> As well as using VirtIO backends with other hypervisors such as Xen,
> Gunyah and WHPX.
>
> So this brings me to the question posed in the subject. Where would a
> good place be to host these conformance tests?
>
> My initial thought was to see if this is something OASIS could host as
> part of the specification however I'm not sure OASIS is set up for such a
> thing.
>
> We could host it as part of the QEMU project as a service to the wider
> community. While it should be pretty easy to expand QEMU's own tests to
> work with multiple hypervisors, its test machinery isn't really setup
> for non-QEMU VMMs. Ideally we would want the core repository to be able
> to run on multiple hypervisors and use different VMMs and backends
> depending on where they are being run.
>
> The other option I considered was hosting with the rust-vmm project -
> although maybe that just makes sense for the unikernel tests as they are
> rust based. We certainly need more automated testing of the vhost-device
> repository which can serve as a backend to multiple VMMs and
> hypervisors.
>
> So what do people think? Where would be a good place for common test
> repository to live?
>
> --
> Alex Benn=C3=A9e
> Virtualisation Tech Lead @ Linaro

Pinging this thread to ask the OASIS people: Would it be possible to
host a software project (this testsuite) under OASIS but with a
lighter contribution process? We expect everyone to be contributing to
them, from open source/proprietary hypervisor developers, to kernel/OS
developers, hobbyists and professionals alike. So I think a low
barrier of entry would be reasonable here.

Seeing as a test suite is essentially tied to the published VIRTIO
spec itself it also makes it a good fit semantically. Having a suite
with multiple VIRTIO implementations including slim images with Linux
would also give a wider frame of reference for downstream consumers of
the spec. Currently, the Linux kernel is the de facto (because it's
also open source) VIRTIO implementation on the frontend side and
oftentimes we end up looking at what Linux does to implement backends.

We'd like to potentially:

- Expand the array of rootfs images with more Linux userspace tests
for more devices
- Expand the array of rootfs images with other open source OSes as
they gain VIRTIO functionalities
- Implement missing VIRTIO spec features in our unikernel test and
also exercise realistic but basic VIRTIO command use scenarios for
more devices
- (This is on my personal wishlist) write a VIRTIO fuzzer framework,
similar in spirit to Google's syzkaller project (unsupervised
coverage-guided kernel fuzzer)
- As a stretch goal, provide a reference test runner framework to run
the images with QEMU and rust-vmm vhost-user backends for people to
adapt to their setups.

PS: The git repositories Alex linked are temporarily inaccessible due
to internal unrelated issues, and will be public again.

--=20
Manos Pitsidianakis
Emulation and Virtualization Engineer at Linaro Ltd
