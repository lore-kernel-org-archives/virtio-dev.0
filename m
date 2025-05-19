Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B511DF256
	for <virtio-dev@lists.linux.dev>; Mon, 19 May 2025 08:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747642748; cv=none; b=MIcMEJq+R2oMeBgadi6PYt2uUPt5zRE4vRscwE86BtprKKkVo1jm2uajLcbh6ERmvsO1hTFv/MwfBu1Qspmi7OxsnVTuTw+n+zjF2KEFfo3axFSYT8xRKJdUZl9nAzZHr4/oF3xlx4VU8VcDD8O7mcUcdEZ0KX1DR/moX8Gf5B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747642748; c=relaxed/simple;
	bh=bpNMFiSO65YqREFKfph54Li2ZC08i0gZG+fmPAm0pLA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eAZpiv5gmY/m3t24G3oJvQoU+GcT4uwfPl8tmlMOBRtTk5FgWrEfPPcA1fChimm9MLMyfjUSmy/a8OFvPBETjspmzS395ybV3A3hl+hqaB8omOcN3d8Mu3Xey/ScLTxnmcVUJKh9/b7QVE4ZRvfttfnwhpeXMTdu96/y6ouevZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l90DR0ug; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l90DR0ug"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-601fb2b7884so358050a12.2
        for <virtio-dev@lists.linux.dev>; Mon, 19 May 2025 01:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747642743; x=1748247543; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vFkdQmhSeQUF05kWJRA2SbiD0uKNt5o+G9EfIhwY3+k=;
        b=l90DR0ugRv64RXc912nLnwncutjev9KbtCkzGZRNQ75dzuFCZlrfkwdDSvbL+lc04Z
         2AeX+TAb2sODLITWf1Yfwu/Fa88WrLglYAvRs/4ksjxGAiEbHhVSwuDyK83L8PREo6rW
         nkoyG1STJVLfC9Y3YG+wtSBiu2YHSrs+EmkLacJ5W88tSSiBMcRx2HJJWoOwPYZEOs6f
         e8nrJiMvwxZbDEY/YWyVvVvGh3FYYXNoLxr7FpI3iDQ3s7rruc44qoLIye8W6gajvh66
         SduVvCq5SoFqgt7c0K5n18cqLvbwFnHQjPyaQYKjXg10S+2cAfrQ2LZu/XZcaZ17AHrJ
         cLsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747642743; x=1748247543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vFkdQmhSeQUF05kWJRA2SbiD0uKNt5o+G9EfIhwY3+k=;
        b=YNbHEiibISmggFA39vOEDctgKP1jmlTL+z/yGsmyINVylFHo79B1VghhT3FoCuhMWV
         zghP+rcVPQwTvC9zWsF8X5ZixDgaRXagDsO1En6UeXBQQmbSfNnBANSkYETEo8ulzufQ
         RfsFJc4cTgOVcaC+rIF3STHv6d/5TSd6rQf/NkcxMZfFNkH4lBNKGESl3hPsywltbnss
         H95/cC2L87Y9YlE7gdS6giw7xdptNmUOQTDZCJL0I4zXAclprbcwrcrM0TFfoKR+OqPe
         vE4+1VhGMpGeyt3wLRYF6hEecvsGrS9ay/suX77CEVGSz5kFsSYwDsRZOAv5oxBlHswb
         3zEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBtn/l3spVgHl50GZiBAak6ku8c2trpIutWAb2x0fxQ1tcTI4yoCI1lcstYwfWj4H2lO+SaFrIxGqe@lists.linux.dev
X-Gm-Message-State: AOJu0YzU9LYQzWi8L/gg/mIishLkVHHK3UOJZBrq/BHnXDKPGuXng5Sr
	Mkp7koVWPwLML2szupka3MAHAOc95lFdPEeqeTz1E5qThfOcJjM5AElCLCSvL61e7b7MCr4JOr8
	Pz2FskD0rpP2eot1Om8M/Yqo68Jm8xwagUcKdVooEog==
X-Gm-Gg: ASbGncskI966R6pqooaUNCSB/mG/qXVYDje2PoulW1sMyRT1g+zDae+fVeLJf4rEztr
	D9BKpS5wtze+uF2e9HzcPINneGtdaCQSLxgoMxjXazYYAN5f2IQ/9kOfPlACRUGMYctqRssRl9j
	66Okz09u6FIpB2XfAYZ4+u80bwfDX4Dyp3+8CGJA==
X-Google-Smtp-Source: AGHT+IE0/H9inREnSVyj/Suujp07Mlf5Xo6tWTYrEZeV2VJoZHeIMJJtuOAU5r9+KwA6nJ0ORsjdG4wZi1NQrlepmiM=
X-Received: by 2002:a05:6402:520f:b0:5fb:ad3c:d0c0 with SMTP id
 4fb4d7f45d1cf-6011407dd5amr9385079a12.1.1747642743479; Mon, 19 May 2025
 01:19:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <87semtpjrt.fsf@draig.linaro.org> <CAAjaMXZgeNpExoiDKr3RRms_voE0bU9G033gOmawDqsFbGj2Gw@mail.gmail.com>
 <20250519034810-mutt-send-email-mst@kernel.org> <CAAjaMXafNUEk6jAkh-9iY6JNSKzawM+GRJAHAxZ6X9dkwhMyfg@mail.gmail.com>
 <20250519041030-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250519041030-mutt-send-email-mst@kernel.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 19 May 2025 11:18:36 +0300
X-Gm-Features: AX0GCFvF733KtOG_gIuwXmsOvfZpe_0HfQL9YTj8FGW-zt3EiirLxzumKFTA7vY
Message-ID: <CAAjaMXZZX+i86U4_N1_8+czc2kcWP3=NUgLjT8BMemCYBD6uUw@mail.gmail.com>
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

On Mon, May 19, 2025 at 11:15=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Mon, May 19, 2025 at 11:03:43AM +0300, Manos Pitsidianakis wrote:
> > Hello Michael, thanks for the reply,
> >
> > On Mon, May 19, 2025 at 10:54=E2=80=AFAM Michael S. Tsirkin <mst@redhat=
.com> wrote:
> > >
> > > On Mon, May 19, 2025 at 10:43:33AM +0300, Manos Pitsidianakis wrote:
> > > > Pinging this thread to ask the OASIS people: Would it be possible t=
o
> > > > host a software project (this testsuite) under OASIS but with a
> > > > lighter contribution process? We expect everyone to be contributing=
 to
> > > > them, from open source/proprietary hypervisor developers, to kernel=
/OS
> > > > developers, hobbyists and professionals alike. So I think a low
> > > > barrier of entry would be reasonable here.
> > >
> > > Take a look here pls:
> > > https://www.oasis-open.org/open-repositories/#licensingRules
> > >
> > >
> > >
> > > > Seeing as a test suite is essentially tied to the published VIRTIO
> > > > spec itself it also makes it a good fit semantically. Having a suit=
e
> > > > with multiple VIRTIO implementations including slim images with Lin=
ux
> > > > would also give a wider frame of reference for downstream consumers=
 of
> > > > the spec. Currently, the Linux kernel is the de facto (because it's
> > > > also open source) VIRTIO implementation on the frontend side and
> > > > oftentimes we end up looking at what Linux does to implement backen=
ds.
> > > >
> > > > We'd like to potentially:
> > > >
> > > > - Expand the array of rootfs images with more Linux userspace tests
> > > > for more devices
> > > > - Expand the array of rootfs images with other open source OSes as
> > > > they gain VIRTIO functionalities
> > > > - Implement missing VIRTIO spec features in our unikernel test and
> > > > also exercise realistic but basic VIRTIO command use scenarios for
> > > > more devices
> > > > - (This is on my personal wishlist) write a VIRTIO fuzzer framework=
,
> > > > similar in spirit to Google's syzkaller project (unsupervised
> > > > coverage-guided kernel fuzzer)
> > > > - As a stretch goal, provide a reference test runner framework to r=
un
> > > > the images with QEMU and rust-vmm vhost-user backends for people to
> > > > adapt to their setups.
> > > >
> > > > PS: The git repositories Alex linked are temporarily inaccessible d=
ue
> > > > to internal unrelated issues, and will be public again.
> > >
> > >
> > > At the moment, from the above link, and if you want it tied to OASIS
> > > open repositories, it has to be one of:
> > >
> > > BSD-3-Clause License (which shall apply if the TC makes no license se=
lection in its approval action); Apache License v 2.0; CC-BY 2.0; CC-BY 4.0=
; Eclipse Public License v 1.0.
> >
> > OK that's doable and completely reasonable.
> >
> > > I am not a lawyer, but can full OS images we licensed under one of
> > > these? If not, you are better off creating the repository itself outs=
ide
> > > the confines of OASIS.
> >
> > We'd be hosting essentially build recipes for the images, for tests
> > where we use other people's code. The build recipes would have the
> > same license.
> >
> > If I understand the CLA requirement correctly, even if the
> > contribution is merged by a maintainer who has signed the CLA, the
> > original contributor who has no write access to the repository, has to
> > sign the CLA as well?
>
>
> I think is would be the OASIS equivalent of the Linux DCO:
>         Each person making a repo contribution must be bound to the terms=
 of the
>         CLA, by obtaining their signature (which may be an equivalent ele=
ctronic
>         assent)

So just a Signed-off-by? That massively simplifies things!

> If you like I can reach out to OASIS to confirm.

Yes, that'd be very helpful, thank you.


--=20
Manos Pitsidianakis
Emulation and Virtualization Engineer at Linaro Ltd
