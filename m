Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6013D196DA2
	for <virtio-dev@lists.linux.dev>; Wed,  2 Oct 2024 23:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727913404; cv=none; b=IIij9Hpkue0QGz68w59V2u0Qar90vLUY3i7B9gQBRfTDKOIE7Yvr0JNkqAHuU/pgHcipiCIJC3qRoKSKpjiqbdV+pW7e8qdBTCUOMt7JQQFHcQ1rj0lcr1HRy8mc4ecjNDmORTYcy2/IAas/e2aLWwjEZcH8ErI0GcOpJxSDys0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727913404; c=relaxed/simple;
	bh=TkWmaNjobsczGTdIkYhn5D1IoEQfdT3pZ7qtwt0+v94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SdbWTVm0PIYiRohD21NbCIxsI9Q2j9GvcdWcWt3iAVFymKQKTo4DWdDZtor3zyP9EyzflY9dL4Mbgos3bdmRLXZ4syO+3pXBAwCf6z5QLUamI9xeiw0tpUOGpyuCDII0QJ8Kl+Xy6i7L4PBQ4Ew0gptiVv7Yys8P7mBRp3Y71/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IQqwBGAv; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IQqwBGAv"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a90deec0f8bso4944266b.1
        for <virtio-dev@lists.linux.dev>; Wed, 02 Oct 2024 16:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727913400; x=1728518200; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TkWmaNjobsczGTdIkYhn5D1IoEQfdT3pZ7qtwt0+v94=;
        b=IQqwBGAvM/wChEbC4jaARAYVp2cuL1zib7Lpv1+dzC7bVG7Em7iPc3xcYOOS5pEeI8
         V6OImB2fSZTQFNkHRwxSMbICwe6Dycap3K+k4vPcQylGHGMC/iTgyYqpDfPVTTykc9Xn
         o6Gj4QppwVwtSg/iM8+RVj6yCY4HPhRL/BEMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727913400; x=1728518200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TkWmaNjobsczGTdIkYhn5D1IoEQfdT3pZ7qtwt0+v94=;
        b=huaTVVGrNdNBdiG93Z8L8VP9TWTI81+N/fYNRP7lC9hXeHR2vloVrMb2Jm39Kb7Z5/
         jABEv9prvcpKHOSsTd3L2qKT/nT2PANi/OixWgx2ko7dXJpziLxnfGHKoXlRwX183UVX
         WgkKveX/qRiI8ysHBrfNc568lREy1xG0wGt2cgYyhG8uzfrvb5xEgzkmpUxY0J+8Qj1n
         xsTODupaPoJ2g2PEuXBRdCk1Yak2Y9XGzoga8ct7RzDZdwwkfz7nttKXk2LWlVG0n8AE
         7VUtTmaIdUSPo0BRrjSJR0koa0ElvX0dkZ6u1Xf7cZUL+X1zPQxoW5YJr1Lv52c8bYBM
         zw6g==
X-Forwarded-Encrypted: i=1; AJvYcCVwq+ObgQsjAelATm66HINf9YoAvUGQ5la7ivaObaKYGAFY/kDfcUIwE72LNM2DHqmTMx8sDx7Gh36q@lists.linux.dev
X-Gm-Message-State: AOJu0YxyN+8vt75wLS1tGZeMqTkxMkx5qpkGiL2osCmQYNIB6TdE2LSJ
	YMQaOAJshEx+9XhUsQlShcNgvQ7Ea8kLatOD+BT9+40e8rGijG6BNoa7SiNfIJLeSt2HHYauFHY
	=
X-Google-Smtp-Source: AGHT+IGGPe38MTKVT4GcvIKG9Iz7mXxTD4bBm/1uNXNEUTPaQ2oX7nI+ppLpApMkIjBLjXmLSKA7vQ==
X-Received: by 2002:a17:907:3da9:b0:a96:7d20:28f0 with SMTP id a640c23a62f3a-a98f81fd8d3mr222804566b.2.1727913400575;
        Wed, 02 Oct 2024 16:56:40 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c2946d0bsm925652366b.113.2024.10.02.16.56.38
        for <virtio-dev@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 16:56:39 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a8d0d82e76aso40750366b.3
        for <virtio-dev@lists.linux.dev>; Wed, 02 Oct 2024 16:56:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUNVaW2Ln/e7COk2oncYGtUZR5X0KN1Yu0RteTa+oecJmDRyty/nxcmoABgl9QYvOYQgufeEOtbTn0o@lists.linux.dev
X-Received: by 2002:a17:907:7fa7:b0:a8a:8cdb:838c with SMTP id
 a640c23a62f3a-a98f838aa6emr496483866b.53.1727913397985; Wed, 02 Oct 2024
 16:56:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240925145228.27953-1-mgurtovoy@nvidia.com> <CABVzXAntBt+5L4a1ntud_7j_EHiB4yG6FuskNaPBirOfLJ7i6w@mail.gmail.com>
 <ca954af2-4c61-41f5-8cf0-69a1233704ba@nvidia.com> <CABVzXAma4T+=meTSRNKhq70w4imc=A5imy2zofX2ndJz-XVByg@mail.gmail.com>
 <adf195c4-6d7e-47ff-ac62-dc4c0f463f21@nvidia.com> <CABVzXA=wov8OgADXbDiVVnhncc=zgET4MAGd3H1pr26XS38JBw@mail.gmail.com>
In-Reply-To: <CABVzXA=wov8OgADXbDiVVnhncc=zgET4MAGd3H1pr26XS38JBw@mail.gmail.com>
From: Daniel Verkamp <dverkamp@chromium.org>
Date: Wed, 2 Oct 2024 16:56:10 -0700
X-Gmail-Original-Message-ID: <CABVzXAmxuVngKjNvc9AsnkuNcOK+7JeEuBE9CDaMxAA=b3f=fw@mail.gmail.com>
Message-ID: <CABVzXAmxuVngKjNvc9AsnkuNcOK+7JeEuBE9CDaMxAA=b3f=fw@mail.gmail.com>
Subject: Re: [PATCH 1/1] virtio-blk: Add description for blk_size field
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org, 
	stefanha@redhat.com, virtio-dev@lists.linux.dev, oren@nvidia.com, 
	parav@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 6:45=E2=80=AFPM Daniel Verkamp <dverkamp@chromium.o=
rg> wrote:
> On Wed, Sep 25, 2024 at 4:42=E2=80=AFPM Max Gurtovoy <mgurtovoy@nvidia.co=
m> wrote:
[...]
> > I'm curious if you've encountered any actual implementations where
> > drivers send non-block-size-aligned requests to block devices. I never
> > saw such implementation.
>
> I don't know of any real-world implementations like this, but the
> point of the spec is to allow interoperability without having to know
> about every implementation.

I did find at least one existing real-world driver implementation that
ignores blk_size and VIRTIO_BLK_F_BLK_SIZE - the u-boot virtio-blk
driver: https://github.com/u-boot/u-boot/blob/master/drivers/virtio/virtio_=
blk.c

So this is not just spec language lawyering; this driver depends on
the ability to read/write at arbitrary 512-byte sector addresses and
data sizes, and it seems like it should be allowed to do that based on
my reading of the spec.

(Perhaps u-boot's driver does not work with the QEMU's virtio-blk
device with certain storage configurations, per Stefan's note, but
that is again just one device implementation.)

-- Daniel
