Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DFE433C1
	for <virtio-dev@lists.linux.dev>; Tue, 30 Jul 2024 03:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722309055; cv=none; b=DUxid+MYZhcfo3N+Jncz2bhOORpF1g60x0cSkHhaoU4oNmavfZ6piSoGqM6sQWKmNPCdIiU+fW3khYvoaL9nvFwGCye0tiOia99fjDBPsMUnKbrv5d/b6vuICl5faVvui44q1i+sPUx+nNQy7/tIIXgI5LhI31UrBBWToawExh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722309055; c=relaxed/simple;
	bh=hoPk+Y1c2pYRS5BORMEZbsorfi+63n2pxsSueQkde3k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yrwexk9Uzg5tghUwT8vHbrvzk1LrcQrAxQ2jbnKoBJC9OfMRV5UP7W2VG6EFK1VpvrDUBleLgsg7Rznb79MhVFF+fI1GQZKIymX1XQBh/sXnyLK5CcsncNt6P9zJtnQy/Z3PPPBwobEGFoQ6dODcj4z97nOAn0dM6HXk/17Crtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AGRfDePX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AGRfDePX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722309052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hoPk+Y1c2pYRS5BORMEZbsorfi+63n2pxsSueQkde3k=;
	b=AGRfDePX/jTtd5xfMotoc2zZVU1C0G3JB79bREQlEfjQgspARxwLehT/Z4Mc62cTN4976X
	XF78jZw2H/fv52kiMPai9yPYoKyhuA9bHL0O2mKbpNZqABrweW5oIcbRQFEZlI2488YL2h
	Bdruq+IOwLSopB6l4wDgDQPoxdHkIbE=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-gHQPDVyoNJykX1GP4K1uFw-1; Mon, 29 Jul 2024 23:10:48 -0400
X-MC-Unique: gHQPDVyoNJykX1GP4K1uFw-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2cd4e722d82so3946517a91.3
        for <virtio-dev@lists.linux.dev>; Mon, 29 Jul 2024 20:10:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722309048; x=1722913848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hoPk+Y1c2pYRS5BORMEZbsorfi+63n2pxsSueQkde3k=;
        b=vswC5RGqoXi2Wb53hvAG+LXNnATIR3Rc+gLp6+rbphfqsgpeR36UdpnSHnxKbS/0PF
         c4xU5ENrmzBhPv6m8OwZ19YI7FGo8PQrUFka9GHAUaI5FsjR69msm2prlrzKM3/MxH+c
         J7dntmqaaSluRp7urOXI6Wc545vdkV3kMjGJFMvv9I4JKH2FL7tHEKPcJDRLjaKiobqw
         wCKINGCd/iSuEingm/0+9KxH2LBBoi+FB8sTw45mbsNeicTD6rtSesXiSHB+dyC8XzXE
         TNsV5KI30JC3LX4dCmZctW/HXR5BUplp7IjtbZLrFgUY3J1OlOiB2+MyDk4pvhwbuiY0
         iNYw==
X-Forwarded-Encrypted: i=1; AJvYcCU28m+jh0ce0WajQ+c3ttUmcwdrWfofTPkrJifADqAxu+BUMHmYwivRIWDJL5w3RQfxVsd6cNxPQMceOllEZ1srn3l2KKTMO7WK/Q==
X-Gm-Message-State: AOJu0YwIVT1unqZ6IpPmhgrJAjSOK9yDuE6DGA3enUgMtX61cNZ9aHEq
	wkHsv4GVtWZfeD+92m278efvoGJQPJbt5qVoe0tu1Ckw7fbyU3N11alTwBI3RATyjHYA0lnHv1Q
	Pd2RpaoNtr9n08DOsARi7/qr7NvAvzyc/5Vb5boIipoMVitAm941jgMLHxLBahR1h/Kio5Z9h28
	mieRnuqkW7LoNda+1DajJL8p+mzc+v04Exgg==
X-Received: by 2002:a17:90b:915:b0:2cb:5455:8018 with SMTP id 98e67ed59e1d1-2cf7e1fb9d1mr7881927a91.23.1722309047789;
        Mon, 29 Jul 2024 20:10:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIt5i2b9H8odLQpO+0TZxjUjhrhFHoUwZ7ouWKVcyhF8EmvcBUEQGWKFmxEqa0/kUjpb0g0bdydgoerkwk248=
X-Received: by 2002:a17:90b:915:b0:2cb:5455:8018 with SMTP id
 98e67ed59e1d1-2cf7e1fb9d1mr7881900a91.23.1722309047260; Mon, 29 Jul 2024
 20:10:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240724033816.GD492231@quicinc.com> <CACGkMEs_FHg6xZAw2V7AKvj5XFCmaA0Xm+ei7z4OFJPNgO5Thw@mail.gmail.com>
 <20240726070324.GA723942@quicinc.com> <CACGkMEtin7mb=rA_nS6ArinP4k_v-Zsa05tMb_KXXUvfuCMiKw@mail.gmail.com>
 <20240729060122.GA1542333@quicinc.com> <CACGkMEsRtxezU8sEPYiVWSdmEDAZ-7=ZFGO-oHidR1UcS=rgbw@mail.gmail.com>
In-Reply-To: <CACGkMEsRtxezU8sEPYiVWSdmEDAZ-7=ZFGO-oHidR1UcS=rgbw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 30 Jul 2024 11:10:35 +0800
Message-ID: <CACGkMEt+hCQTfCkPhPR+47rMiPCfZLCJkpC-=2drKAiAFRxJCA@mail.gmail.com>
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

On Tue, Jul 30, 2024 at 11:06=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:
>
> On Mon, Jul 29, 2024 at 2:03=E2=80=AFPM Srivatsa Vaddagiri
> <quic_svaddagi@quicinc.com> wrote:
> >
> > * Jason Wang <jasowang@redhat.com> [2024-07-29 10:16:48]:
> >
> > > > Without this optimization, guest VCPU would have stalled until VMM =
in host can
> > > > emulate it, which can be long, especially a concern when the read i=
s issued in
> > > > hot path (interrupt handler, w/o MSI_X).
> > >
> > > I think I agree with Michael, let's try to use MSI-X here where
> > > there's a lot of existing optimizations in various layers.
> >
> > Yes sure. Even if we implement MSI-X, there is a security angle to why =
we want
> > hypervisor-hosted PCI bus (have provided details in an earlier reply
> >
> > https://lore.kernel.org/virtio-dev/20240726070609.GB723942@quicinc.com/=
T/#m84455763d6b4d0d3b8df814b3d64e6e48ec12ae3
> >
> >
> > > > > > We will however likely need vduse to support configuration writ=
es (guest VM
> > > > > > updating configuration space, for ex: writing to 'events_clear'=
 field in case of
> > > > > > virtio-gpu). Would vduse maintainers be willing to accept confi=
g_write support
> > > > > > for select devices/features (as long as the writes don't violat=
e any safety
> > > > > > concerns we may have)?
> > > > >
> > > > > I think so, looking at virtio_gpu_config_changed_work_func(), the
> > > > > events_clear seems to be fine to have a posted semantic.
> > > > >
> > > > > Maybe you can post an RFC to support config writing and let's sta=
rt from there?
> >
> > Does VDUSE support runtime configuration changes (ex: block device capa=
city
> > changes)?
>
> Looks like it can, it has VDUSE_DEV_INJECT_CONFIG_IRQ.
>
> > I am curious how the atomicity of that update is handled. For ex:
> > guest reading config space while concurrent updates are underway (SET_C=
ONFIG).
> > I think the generation count should help there - but it was not clear t=
o me how
> > VDUSE is handling generation_count reads during such concurrent udpates=
.
>
> Similar to the above, we are missing uAPI to do that. Probably just an
> uAPI to update the device generation.

I meant userspace can just do:

ioctl(fd,VDUSE_DEV_INC_GENRATION);
ioctl(fd,VDUSE_DEV_SET_CONFIG);
ioctl(fd,VDUSE_DEV_INC_GENREATION);

And synchronize the device generation increasing with
vduse_vdpa_get_generation(). Then we should be fine.

Thanks

>
> Thanks
>
> >
> > - vatsa
> >

