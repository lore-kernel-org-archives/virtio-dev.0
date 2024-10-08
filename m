Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19454EC4
	for <virtio-dev@lists.linux.dev>; Tue,  8 Oct 2024 01:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728352727; cv=none; b=XxpthOiXMYb9yfOcYTBUGtBx294KztJX/9E6/Gy5G30x5wShe59TCzwrfcxGER+QqmnbhIgQnRu4kpZViSeZuz2e6wBCbJiK3HnMyxuFOkOUD/IIFxaTGNPGmWWEHUPuUT/TMfCsqqtiHbKnR4jJdy5j6c0UYWIkX31r6irt22E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728352727; c=relaxed/simple;
	bh=iR1AABhP2SeY8og6YbsbxDnGo7LF6IaoaOuu/o/b7Tk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RrxtCFBmZRGIJdo395USgEILkyXvh5Qw/pF2yfF4Yfd8SX39eIEc5Hby0tUQh8Ri43TVI49XHMQeoOH8AYzr77KNihOCARZew+UwTWnSMByoOe63/YRtLGJqJmYVg/YDeOithvI54T4fWxeUcwvJodnJjvzLlhajkRai8CMLTrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SJXcaWdk; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SJXcaWdk"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c88367684bso1025288a12.0
        for <virtio-dev@lists.linux.dev>; Mon, 07 Oct 2024 18:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728352724; x=1728957524; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iR1AABhP2SeY8og6YbsbxDnGo7LF6IaoaOuu/o/b7Tk=;
        b=SJXcaWdk3U/8UAOcwZKFgC5Q8d53PGn06Wyin6qjw1ElXdhmEe0QesYvN02ebP1M/E
         DXMpIt+JPDfRSBy9Sc6WZ8JlFdpLJzn4ei+UPkqdEXoSx14Hgzy6Sepu5hg+GUPL23IA
         71qwfESj1KRDXENUBYyeHz+nG42HT3pz/LCMo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728352724; x=1728957524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iR1AABhP2SeY8og6YbsbxDnGo7LF6IaoaOuu/o/b7Tk=;
        b=j16GGEXkrEFIse6SyTWJBgATnLIWzrZmBN1Yp/oWuWXWk2OI8w1QNSn9KbH+bOp9ky
         KH/jcMIHiBfJKCatvbBUY2tE319Z+C/VUZLuiuy55Bk0wS02//tdkwXcm/ZCKwSc3NeU
         H5eCy2RwSkRKub9OacjV71PctBIkWyB5vWj/NG5TbjYqxW5ErAgUHUuAAGsAzvQE6Q5B
         /8DdJDocqQ1JxKK01LKEu1SWEiGPNm+qoa5IYNi191Bl9l8HcPhWbjqKY9R3miGtHkbo
         HPz0KiWnsRUScZq6k+Yfm2qnDP7tUrjoK9BjHJY1WKClot8i2Xuh1u6cwaUX5xLfOH7U
         JlZA==
X-Forwarded-Encrypted: i=1; AJvYcCWdN/jByWKidtLwV/3YMK2D5VOKcIWLZk82PUJndvkaXDKEqHcC4ok2R335poF6/T/O7/g3HI9j1M8q@lists.linux.dev
X-Gm-Message-State: AOJu0Yy5j3L4zSam6KxBue9KEE92SohZ3mmGJ16PJ2JKdXu5d0GvbaVS
	uz95YpFeYY3enx5UIM9vPKzSRqlnLdczeJfax1KJZd05+f8NlSHK9tAk/Sh7pqxaloqzWPwa3J0
	=
X-Google-Smtp-Source: AGHT+IGXXsWb0FPKxEsENIXVePtdcgyLCO9EJLliF8APc6eaBdeLsi7P0Oj2082VDsYgXvT/+Rpa6Q==
X-Received: by 2002:a17:907:7f8e:b0:a99:63d8:a1a8 with SMTP id a640c23a62f3a-a9963d8a3c9mr80676166b.1.1728352724279;
        Mon, 07 Oct 2024 18:58:44 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a993a929562sm388440666b.121.2024.10.07.18.58.42
        for <virtio-dev@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 18:58:43 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c903f5bd0eso1340281a12.3
        for <virtio-dev@lists.linux.dev>; Mon, 07 Oct 2024 18:58:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU1HXy20NPlD+5VzQqB185moJD8XJatb5eOODK9S4t5UM7oVzT/ILzi5H3BDBTyhefdLJrCHtfHKpev@lists.linux.dev
X-Received: by 2002:a17:907:3f17:b0:a99:446e:3b5f with SMTP id
 a640c23a62f3a-a99446e4104mr885416766b.50.1728352721735; Mon, 07 Oct 2024
 18:58:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240925145228.27953-1-mgurtovoy@nvidia.com> <CABVzXAntBt+5L4a1ntud_7j_EHiB4yG6FuskNaPBirOfLJ7i6w@mail.gmail.com>
 <ca954af2-4c61-41f5-8cf0-69a1233704ba@nvidia.com> <CABVzXAma4T+=meTSRNKhq70w4imc=A5imy2zofX2ndJz-XVByg@mail.gmail.com>
 <adf195c4-6d7e-47ff-ac62-dc4c0f463f21@nvidia.com> <CABVzXA=wov8OgADXbDiVVnhncc=zgET4MAGd3H1pr26XS38JBw@mail.gmail.com>
 <CABVzXAmxuVngKjNvc9AsnkuNcOK+7JeEuBE9CDaMxAA=b3f=fw@mail.gmail.com> <80c82271-b29c-4f56-b90c-e72a4ea7f3cf@nvidia.com>
In-Reply-To: <80c82271-b29c-4f56-b90c-e72a4ea7f3cf@nvidia.com>
From: Daniel Verkamp <dverkamp@chromium.org>
Date: Mon, 7 Oct 2024 18:58:15 -0700
X-Gmail-Original-Message-ID: <CABVzXA=7a9YxEHJxj8c_q71BSYM+DasG09MF6fXkdTFpWsQopQ@mail.gmail.com>
Message-ID: <CABVzXA=7a9YxEHJxj8c_q71BSYM+DasG09MF6fXkdTFpWsQopQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] virtio-blk: Add description for blk_size field
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org, 
	stefanha@redhat.com, virtio-dev@lists.linux.dev, oren@nvidia.com, 
	parav@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 6, 2024 at 4:36=E2=80=AFAM Max Gurtovoy <mgurtovoy@nvidia.com> =
wrote:
>
>
> On 03/10/2024 2:56, Daniel Verkamp wrote:
> > On Mon, Sep 30, 2024 at 6:45=E2=80=AFPM Daniel Verkamp <dverkamp@chromi=
um.org> wrote:
> >> On Wed, Sep 25, 2024 at 4:42=E2=80=AFPM Max Gurtovoy <mgurtovoy@nvidia=
.com> wrote:
> > [...]
> >>> I'm curious if you've encountered any actual implementations where
> >>> drivers send non-block-size-aligned requests to block devices. I neve=
r
> >>> saw such implementation.
> >> I don't know of any real-world implementations like this, but the
> >> point of the spec is to allow interoperability without having to know
> >> about every implementation.
> > I did find at least one existing real-world driver implementation that
> > ignores blk_size and VIRTIO_BLK_F_BLK_SIZE - the u-boot virtio-blk
> > driver: https://github.com/u-boot/u-boot/blob/master/drivers/virtio/vir=
tio_blk.c
> >
> > So this is not just spec language lawyering; this driver depends on
> > the ability to read/write at arbitrary 512-byte sector addresses and
> > data sizes, and it seems like it should be allowed to do that based on
> > my reading of the spec.
> >
> > (Perhaps u-boot's driver does not work with the QEMU's virtio-blk
> > device with certain storage configurations, per Stefan's note, but
> > that is again just one device implementation.)
>
> Vague specifications and inconsistent interpretations should be avoided.
>
> I'm trying to make the situation better.

Thanks, I do want to improve the situation as well, and hopefully we
can reach that while keeping compatibility.

> I'll send a V2 according to the comments.
>
> BTW, Are you familiar with some virtio-blk device that implements the
> buffer-cache logic you've described ? or is it only a theoretical
> discussion ?

The most straightforward (software) implementation of a virtio-blk
device on a Linux host system would be a raw disk image stored as a
regular file on a filesystem, opened in the normal (non-O_DIRECT) way,
with the device implementation translating VIRTIO_BLK_T_IN/OUT
requests into [p]read/write syscalls; arguably, the host operating
system's fs/mm code would be handling the buffering in this case, so
it's not really part of the block device implementation per se, but I
would still count it.
