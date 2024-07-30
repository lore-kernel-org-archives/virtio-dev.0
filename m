Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F88E146D6B
	for <virtio-dev@lists.linux.dev>; Tue, 30 Jul 2024 03:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722308790; cv=none; b=J1IogO7XDhXW4Uirzotn/JzHbSoebrSYc+au/EU5vsZ9Kzruq1Mx7UL47dDShW8CVDqwX1jL7g3h8uEqF9VwcBBBmKuuFvNS3E45t6NthgWS9eJoOq8JwWJkg7+sdyTarU8en0r1A9IFkpka2oTI0EnYOoxAu0CH5OOs37kl3AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722308790; c=relaxed/simple;
	bh=HyX+3BVaOG7CR9AYkNVWcTm75cFajmUq2m/2q0ImLMs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MHY9+PRieRIBBe4GNJ2ECT28UCw0gGTSPEfYNXaEW7BWRHbicVXynzhYN9vaFV3OFglG3SKDO1UPdNK9XM5U19EZ0hh3Udw5cezP0xHCtTDw8880TRKhR4PpxiF3LgtS7qug1rGGL49kBznQiOZTCfPQVPsyDdax7vScya9YuO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YJaoH4QB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YJaoH4QB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722308786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HyX+3BVaOG7CR9AYkNVWcTm75cFajmUq2m/2q0ImLMs=;
	b=YJaoH4QBweO4zLBqQXQfXEtGXMEaZUptcsfuO7lw9pC5fAIL9AKbjKSaglkvT3GCl7FBPy
	1NhqpQ8vFv2dorULfmZ5IIF5Gy4tqw5MaasQGzwaSks6leVPWfmVi/7XkslJxbN3oq1qjJ
	Q1r0r/n/HNF+0cVdexrErhzjdF/d/TQ=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-bAo5zzoGOnmBn1Z4Wbwmjw-1; Mon, 29 Jul 2024 23:06:24 -0400
X-MC-Unique: bAo5zzoGOnmBn1Z4Wbwmjw-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-7a2a04c79b6so3518885a12.0
        for <virtio-dev@lists.linux.dev>; Mon, 29 Jul 2024 20:06:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722308783; x=1722913583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HyX+3BVaOG7CR9AYkNVWcTm75cFajmUq2m/2q0ImLMs=;
        b=usdaM3Dnwpgr2nqyxRHxaznMYi3/jJn45EFvwZRGfD/D2U+lrZ5P5GZuN6EqfQSE2R
         6K1QwVn/qAoQ8lRYFsOM8gG19J0zp4wkES7dSHX0qyCS7Yon4qlhS2jgJyMOUlcar6Hs
         9ImvtSXzy9l7Ru6H6R/rz9qXC0DwfmNu8fDRZWutIH8ThdjW4sCs6Ewp/uMZiggLwUhR
         pnTGtk2826XXeDW3/8wOthXnWALABTVUwyZQVqNoULB516ae6mfGvTL2n7KNhsHM48C5
         YpO3/zStQV+JD5lu+YqHWxgdJewJNPy4tqCP5Q1YhkAgsWDKLzJW1gU5FnPHDYIWu5vZ
         HjfA==
X-Forwarded-Encrypted: i=1; AJvYcCXFP+FMc+5UPXOvw7YXpDNP13c5n22EfPElMko0NtWe2qZyJRZeAFqeqi/p4nM7woLjxukV+OeSsz6Ur2yn7CG71+SOqh2vE/APYw==
X-Gm-Message-State: AOJu0YxJRK0jf+Ig3MTnqXJvLcu74BM0wXO9g5AP748hrpeQpb05SS7x
	c6bX8vCwlhdijiR+2p7JNh+CjeLX0wFc2A+lBUxvAhBihq0T3hTq61Bp5eyW0CNDYLd9OAo+WfU
	uJaQNUAyEpSV5G0VrDbUaol4W/6Tw6/ZJ6E5jz6AQeH+4KA4Stnx8wWW2hI8groVZ5XGFWlpLfL
	zcpe0EV5sCPguC48lW/sqrkg8IyQ1ODJTO/Q==
X-Received: by 2002:a17:90b:4c03:b0:2ca:f755:1040 with SMTP id 98e67ed59e1d1-2cfcaaec72fmr1120834a91.7.1722308783317;
        Mon, 29 Jul 2024 20:06:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFryUvcqGZpQYTjgqUn1VlxKwR493Yb4lfjVWyYmy1iS1ZVdwKJCPFlCrpqBtot+TLUJS6GFjig5uLn+V4DMps=
X-Received: by 2002:a17:90b:4c03:b0:2ca:f755:1040 with SMTP id
 98e67ed59e1d1-2cfcaaec72fmr1120806a91.7.1722308782849; Mon, 29 Jul 2024
 20:06:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240724033816.GD492231@quicinc.com> <CACGkMEs_FHg6xZAw2V7AKvj5XFCmaA0Xm+ei7z4OFJPNgO5Thw@mail.gmail.com>
 <20240726070324.GA723942@quicinc.com> <CACGkMEtin7mb=rA_nS6ArinP4k_v-Zsa05tMb_KXXUvfuCMiKw@mail.gmail.com>
 <20240729060122.GA1542333@quicinc.com>
In-Reply-To: <20240729060122.GA1542333@quicinc.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 30 Jul 2024 11:06:11 +0800
Message-ID: <CACGkMEsRtxezU8sEPYiVWSdmEDAZ-7=ZFGO-oHidR1UcS=rgbw@mail.gmail.com>
Subject: Re: [RFC] vduse config write support
To: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
Cc: xieyongji@bytedance.com, stefanha@redhat.com, virtio-dev@lists.linux.dev, 
	virtualization@lists.linux.dev, quic_mnalajal@quicinc.com, 
	quic_eberman@quicinc.com, quic_pheragu@quicinc.com, quic_pderrin@quicinc.com, 
	quic_cvanscha@quicinc.com, quic_pkondeti@quicinc.com, quic_tsoni@quicinc.com, 
	eperezma <eperezma@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, mst <mst@redhat.com>, 
	Cindy Lu <lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 2:03=E2=80=AFPM Srivatsa Vaddagiri
<quic_svaddagi@quicinc.com> wrote:
>
> * Jason Wang <jasowang@redhat.com> [2024-07-29 10:16:48]:
>
> > > Without this optimization, guest VCPU would have stalled until VMM in=
 host can
> > > emulate it, which can be long, especially a concern when the read is =
issued in
> > > hot path (interrupt handler, w/o MSI_X).
> >
> > I think I agree with Michael, let's try to use MSI-X here where
> > there's a lot of existing optimizations in various layers.
>
> Yes sure. Even if we implement MSI-X, there is a security angle to why we=
 want
> hypervisor-hosted PCI bus (have provided details in an earlier reply
>
> https://lore.kernel.org/virtio-dev/20240726070609.GB723942@quicinc.com/T/=
#m84455763d6b4d0d3b8df814b3d64e6e48ec12ae3
>
>
> > > > > We will however likely need vduse to support configuration writes=
 (guest VM
> > > > > updating configuration space, for ex: writing to 'events_clear' f=
ield in case of
> > > > > virtio-gpu). Would vduse maintainers be willing to accept config_=
write support
> > > > > for select devices/features (as long as the writes don't violate =
any safety
> > > > > concerns we may have)?
> > > >
> > > > I think so, looking at virtio_gpu_config_changed_work_func(), the
> > > > events_clear seems to be fine to have a posted semantic.
> > > >
> > > > Maybe you can post an RFC to support config writing and let's start=
 from there?
>
> Does VDUSE support runtime configuration changes (ex: block device capaci=
ty
> changes)?

Looks like it can, it has VDUSE_DEV_INJECT_CONFIG_IRQ.

> I am curious how the atomicity of that update is handled. For ex:
> guest reading config space while concurrent updates are underway (SET_CON=
FIG).
> I think the generation count should help there - but it was not clear to =
me how
> VDUSE is handling generation_count reads during such concurrent udpates.

Similar to the above, we are missing uAPI to do that. Probably just an
uAPI to update the device generation.

Thanks

>
> - vatsa
>

