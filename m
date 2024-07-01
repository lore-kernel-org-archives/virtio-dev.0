Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475941E49E
	for <virtio-dev@lists.linux.dev>; Mon,  1 Jul 2024 19:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719861389; cv=none; b=pNiIT4PmG0T747ySTSAK4OdJrWeKfATKU0QPCdYCeHCZt5yynqB+U481RcYF+XWUKimvAH896hUFNECPPXnYkoQVzLmInmnbMmspeGZF1As6JICXppt5cx0qoOcPhpMFKugYFHdotgjiobyQLwAdZ/tBfHlhMF8p31ownaVlWa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719861389; c=relaxed/simple;
	bh=5FCqSLm57XUERk1MFfEF/pd7K3Vr0B/n+GjEp3DnSs8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jzjjXX6bvY01HUSNZEZMuO+ZvE5Za+EBxID2N0ddVbJerBQklVBf3xEEc+3nkw5s73XUN3V675Es10wJtECbM5YYboqqLaG9R8cu/K7USmkDFL7V9sCMpiq72C6Hy0KXWvuq2GQGgwTZe0qNWSl4K4xzwzSZk1JIfxOj46MLpN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D1ztxYgw; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D1ztxYgw"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fad076cd9cso336995ad.1
        for <virtio-dev@lists.linux.dev>; Mon, 01 Jul 2024 12:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719861388; x=1720466188; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5FCqSLm57XUERk1MFfEF/pd7K3Vr0B/n+GjEp3DnSs8=;
        b=D1ztxYgwG1FVnj6xmpDoZ4igaGcoUGcOUYwubWKXkn+joydbkystHH1c8FxsN7JoQP
         yYlc8Ch38chLVG48kjF8yscpVldFaNld8wP8yb0VWo++lSGm09VX1hYehDu7vEqX1Zpc
         v8QCnTRSvdA3UYgb6iSuEcYxqJUwlVnZA9EaGMp4OP4XdK6wLnpsTtU37prP9FV/HG0O
         E2wSQmkaQTXQ5PC0J6UfBFsKgVabkG23pUEg/CHYfyYwe0+J5k0a9iSo3xr5E/69WIDL
         k+pwbh0y/v9qM80u4RMPWxKiJRVFCqNa2xC9yh1L3VeXmfZhDtc5ExAK0SDwUPhA4tgH
         kIKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719861388; x=1720466188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5FCqSLm57XUERk1MFfEF/pd7K3Vr0B/n+GjEp3DnSs8=;
        b=ZJi8KPIX2oXUBf2GZ4s9ycPP4mhsQwS6k8LL204u94LQaWbDXSVxxHu6DOIYzJi/w6
         rMz1lWIxnPtoLnZ0znXnWR9hx6DA9R5aLKBoXPPZpfIeHMnuBYOV6EhP+p0lqqy98vkY
         ppofyeMjX/LnUe0fOMpEoubLAqibtTLAoNaTkHOZXAIuPO7JIzsDU18zVTe1RK8qStC7
         dwDB03wl7pTPtoxtf8S6aY0Hk7caX/+bSZVwD7Mpe8obrw+6vEEFABeWUg/FJgdCyXAt
         304Np7et44ewvmlR2EV3GHpxT9ANSdiGHYxFOo3Ah7p6b41i1jqUN6AyaceDdAFvSX7a
         6DGA==
X-Gm-Message-State: AOJu0YzhVe5KS1VMUoHOyFaguPF2B8+D7GHXP2Ajsbyb9tsKTFBxFr6T
	AH/m0bUERk3FvTrl87wBCxtoeIXxh4cTXZfMQ17n0sV8DNJiQ8v2TYaN4KXphnjNQqb+8Y67Sbv
	4nTIAUm/WmodCVup98CeYhuoHW59lSbZ7FaYU
X-Google-Smtp-Source: AGHT+IGXqSx0K7FnoCN2KXZP6PVs8n/PMnlAoQvJOT4ZDlWIogWwUozzAy7V6qYwWphn1T0WDlUOJ6s4WUl5HI5mYAs=
X-Received: by 2002:a17:902:c64b:b0:1fa:191c:fe4e with SMTP id
 d9443c01a7336-1fad8f2a0d7mr5215365ad.21.1719861387194; Mon, 01 Jul 2024
 12:16:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAOGAQepPkUDF8vmzRiG41xOGhFdDuq8-EHmdTrdVrK6E346G7A@mail.gmail.com>
 <20240701142831-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240701142831-mutt-send-email-mst@kernel.org>
From: Roman Kiryanov <rkir@google.com>
Date: Mon, 1 Jul 2024 12:16:15 -0700
Message-ID: <CAOGAQepE5G+yR0FQMFW8oZ24p0DVKZgmkDJsB09hbxF+P7KvCQ@mail.gmail.com>
Subject: Re: VIRTIO_VSOCK_OP_REQUEST with the same src_port from a guest
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.linux.dev, JP Cottin <jpcottin@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Michael, thank you for looking.

as I mentioned, I have never seen this happening.

But this code path (on the device side) exists (e.g. insertion of
<dst_port, src_port> to a
hash table says that the key already exists) even if it is never taken
and I would be nice
if the virtio-spec mentioned explicitly what to do there.

Regards,
Roman.


On Mon, Jul 1, 2024 at 11:44=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Mon, Jul 01, 2024 at 10:35:57AM -0700, Roman Kiryanov wrote:
> > Hi virtio-dev,
> >
> > we (Android Studio Emulator) have our own implementation of
> > virtio-vsock and we recently found that the virtio spec does not cover
> > the situation if a guest sends a VIRTIO_VSOCK_OP_REQUEST packet with
> > the same src_port that is already registered on the device side.
> >
> > This sounds like an error to me and I don't think I ever saw this
> > happening, but it would be nice if the spec explicitly mentioned how
> > this situation should be handled on the device side.
> >
> > The spec does mention "A VIRTIO_VSOCK_OP_RST reply is sent if ... the
> > destination has insufficient resources to establish the connection",
> > but I am not sure if this includes the duplicate src_port case. I
> > think this means the previously established connection will be broken.
> >
> > Thank you.
> >
> > Regards,
> > Roman.
>
> Another way is just to forbid this from happening.
>
> How does this happen on the driver side?
> --
> MST
>
