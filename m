Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8B746525
	for <virtio-dev@lists.linux.dev>; Mon,  1 Jul 2024 19:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719863759; cv=none; b=nwFG+6QVvSM3qpF/PkvZOYCbLTl9lrdQjAnIfrt+vIvp2XNXxiNm5gZAjohUdFid0rf7tvw/EGxQzFwDycKi+1QzrcrSjP7DBcaQhyTQlGdig0WRSYlMgcDIltctP4zf8ZC9m7c2MEp3wMrylkYtkRuwN4baK5Y2qDOihnMaHM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719863759; c=relaxed/simple;
	bh=97TPLKgM8RGxg3yk/7854pk/rLs3te49pMrzHQf/FPU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uACpceBWKXHq21I04iBp2tOpjb1P+Vzr9pxz+osN6XjZSis/o828DHkcb7hIOUceDuQXJu7mqIkKPn23AG83vyq90Ph6k/HFFcHS00FUpY4yN7cqxyk5XAa5Vv+WbLnhu6Tnp7nU1x/qipJkJP2tTMvYs6BCWmnNVkAFifrdLYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AQjzQMJX; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AQjzQMJX"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fa901ad6f3so368415ad.0
        for <virtio-dev@lists.linux.dev>; Mon, 01 Jul 2024 12:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719863757; x=1720468557; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=97TPLKgM8RGxg3yk/7854pk/rLs3te49pMrzHQf/FPU=;
        b=AQjzQMJXKrVL96HaJ/rWS7Ao2/LioIahpROL0lTfKkCOEDctJ+PWgg9AnNAF6BQRVc
         8J5dHS/pFIFIY1HHnZsvpHv13Mi781Oi/23VYixCE9S/5NO904uZUt0hggQzgV1GsXJx
         1M5VghtGCQewbnEUOysHTzqxGLOJ6k/eUSFBp8z4/QTFXdt9Y8WRtjzLE7ohUL+8AJsC
         MusMel6PQLho7T3UyApynG/Cf/beaL3uvSGQy1ahe+45PGUvBjF1oXeRInVyGZ7FJc37
         xC/cRfvJT5S0QIjb0cS7OS0EIeq0c7lPGr2+nORiV5pmgTO5aQSNB9ikvNti+Hxa6h8G
         qHyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719863757; x=1720468557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=97TPLKgM8RGxg3yk/7854pk/rLs3te49pMrzHQf/FPU=;
        b=Ja6OkPeiSb92SIzPiMak4npF8rpMlrdpSWcfNjd6Ds53srCJzz2DWnkozu1SOVoyCD
         5dNqpgbVxAk5gbJ81+ktNQNJEPiIn20e+TcjwSIInkD+iHgfO1RkZ415k8FORW2TuHwg
         Wv0qXLoOLo8s23uARDhPS13T4JKsxSrhhYNHZk+Gfa4UEX/WfL29Yx6jaW1FtDEkENAZ
         l/2TIhSTN7LSC5+OL0WFMfZD+tSXcfaeGtTRxmnp2or0r5CB9spweX9WD7xV9i7yr2vn
         gabP5/G/3nD5GrV34602/FaLIBkWarHjwEK/lCT2V05QDYlxb98qoyRBQHF/Mtmg0lzY
         0qQg==
X-Gm-Message-State: AOJu0Ywc9Df3C5B/rY/g7fisvM34nuSaig+n4So16Qkz7FA3AwaqR31U
	GGmYTwiyJ9F1FC+qKwfHA0rRewb9ZYBRqNPeKCTQhK5mvi6jJGTKmrqimRtwKJu6fBnSk/+CJQW
	nT+LcotK2La302HMheIbnzo4TCkDMiCboPiLb
X-Google-Smtp-Source: AGHT+IEWfShNV1I75/yw3iEmfSVYUAr+oBjaLEpDaA9reqlx00vwAY/lPZJJmsmui0tQnkaDRyJVPSZphNtynM86a2g=
X-Received: by 2002:a17:902:f7d1:b0:1f6:5bba:8ea3 with SMTP id
 d9443c01a7336-1fad8ef381amr5747075ad.25.1719863757380; Mon, 01 Jul 2024
 12:55:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAOGAQepPkUDF8vmzRiG41xOGhFdDuq8-EHmdTrdVrK6E346G7A@mail.gmail.com>
 <20240701142831-mutt-send-email-mst@kernel.org> <CAOGAQepE5G+yR0FQMFW8oZ24p0DVKZgmkDJsB09hbxF+P7KvCQ@mail.gmail.com>
 <20240701153918-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240701153918-mutt-send-email-mst@kernel.org>
From: Roman Kiryanov <rkir@google.com>
Date: Mon, 1 Jul 2024 12:55:46 -0700
Message-ID: <CAOGAQerR1Y59gXq=PVSPtWMrDbxZWfA_T1GcOFSOqP09k7Mwuw@mail.gmail.com>
Subject: Re: VIRTIO_VSOCK_OP_REQUEST with the same src_port from a guest
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.linux.dev, JP Cottin <jpcottin@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 1, 2024 at 12:40=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
> Can Linux driver ever trigger this? Some other driver?

I have never seen a driver with this behavior so far.

> If this is something that drivers don't actually ever
> trigger, why does it matter how exactly the device
> behaves?

I think there is a value in having the spec to cover all cases.
