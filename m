Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BF72770E
	for <virtio-dev@lists.linux.dev>; Mon, 29 Jul 2024 02:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722218812; cv=none; b=F068nbTSdAtko6Z4tLOe5gGFNg9yan22Okllspu3fBIErCP8bE5JZc+H6qqmQ5vqAHgngi7RC324QkZWfnbKC0yCG0KpPbQPQnaWx4hO7Gqzycw6NJHUIShHpgFqHDYwqzo4FH6/1g/CexFiT281zs3I+QKwNbz25+kc+3umyj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722218812; c=relaxed/simple;
	bh=gDT/ykWLjSKq64w0/H9JwZcZsOjMPi3uy4g3RxYW0+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FEAHRDQzdDFvWylYRNJ2fWslaUmZLgs44hLm2VyTF7peQ/v+aobZMaMBFErnxP/75F+xJEyvL3I18Ba02BCRd2tezLJY7j21x+GdNMHuzLKxKZnqRVSiMuv7BbbwpKBEAQTccunOdI1AclvHrni905jiQdzABMq7e6+pBYPtMKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AYHX33iV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AYHX33iV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722218808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PrqTFdMmaMUL1Y58ZHngeWA4ABxlLjJgQebIEkenRm8=;
	b=AYHX33iVwI1bCNkr/xAtCFoUaI3VTFDYKG9ovNfoQdo3dbmz4NDPoKZwsjb3X3gT/NGnVk
	x4B3miUwVLwLZbpYsQWEwnPCkIBMCv00F50MTofFlJgKyJJe2Nit7tpg7xhGV29LgQ/aEl
	wXIfRsOqajm1rKLNHuOpOF1XUT0Cbt4=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-TNe1jOMWMaGN9NJbnKJ0jw-1; Sun, 28 Jul 2024 22:06:45 -0400
X-MC-Unique: TNe1jOMWMaGN9NJbnKJ0jw-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1fc596b86a6so25598875ad.1
        for <virtio-dev@lists.linux.dev>; Sun, 28 Jul 2024 19:06:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722218805; x=1722823605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PrqTFdMmaMUL1Y58ZHngeWA4ABxlLjJgQebIEkenRm8=;
        b=n3fZTxJiLgZExwuVaxSC7GmZwjOOoK3Hlbpj+EbPP2RjkvzO9D42gJB+gkur1wee7F
         0xG8dR36Vh5WGuxgVjpHAKzYEDTwvEs2LvFFiqodm6cHhHadx9LdYkU4UQrGEFJ71mIl
         Rf1RgDVWh/kgYG5mAI99URmzmeqRp0SaHruoHgprt7ijAjFB3wSE3Bu8cLfdTEUnBRfR
         g+NZ0K+23N22KaJrSN0sKujrAuyVBZ7NFCFbszK43t1jVyxKuTjqRFUPttyCPUWY8jVF
         X7NR9emlNAUnWHog5hHVfIdwZSYmZgR/4vI/I0FG0JMdDR26UpQFwlSRv8sriGsjLx7R
         0+Rw==
X-Forwarded-Encrypted: i=1; AJvYcCXQMUBvtqsIRleshFWzYEHL7cuTPDdu+HBoPw9IGaXf8H9Gtlg5/sHTCZ/i/hxPxcJsylG66OqKX6+qQERPJ3dN23RSv99Cb8sJqQ==
X-Gm-Message-State: AOJu0Yyh+NRpZ3fdCWYyDouWx7ek6XTN9ptxknYkx/UKmQcVckJWTRA0
	CHYTfjahL4qehCNRouGI9MjYTS9BZ5ewawwXkTOftbZ43RGRncOS6a0xnn61dpNkN9vuWnsI7dw
	NAxU9ttmNUoYbIRk9wAYItHlINroknqgfwkq9+KEb8AFN3qjhScb1OMhKE/1Qm2GwFqFSolGSCi
	oL8Hdr1KQi2yvyWiY/ZA5J8vSoVtW87On53g==
X-Received: by 2002:a17:90a:bb84:b0:2cb:5fe6:8a1d with SMTP id 98e67ed59e1d1-2cf7ceafd79mr10695244a91.9.1722218804741;
        Sun, 28 Jul 2024 19:06:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIn0QgfPyq3bBiwhtNqo7WKE1Qewu4DB9eM+QPfcaSFcDvTNudWEZgAoQTfDBaZwmnkMNTa/ldfcoWLbSVcYg=
X-Received: by 2002:a17:90a:bb84:b0:2cb:5fe6:8a1d with SMTP id
 98e67ed59e1d1-2cf7ceafd79mr10695214a91.9.1722218804249; Sun, 28 Jul 2024
 19:06:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240724033816.GD492231@quicinc.com> <CACGkMEs_FHg6xZAw2V7AKvj5XFCmaA0Xm+ei7z4OFJPNgO5Thw@mail.gmail.com>
 <20240726011340-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240726011340-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 29 Jul 2024 10:06:33 +0800
Message-ID: <CACGkMEsK=xZXouPX7MqoZJyrZ7ufOcHOQjFvR40xdg3XvStnaw@mail.gmail.com>
Subject: Re: [RFC] vduse config write support
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>, xieyongji@bytedance.com, stefanha@redhat.com, 
	virtio-dev@lists.linux.dev, virtualization@lists.linux.dev, 
	quic_mnalajal@quicinc.com, quic_eberman@quicinc.com, quic_pheragu@quicinc.com, 
	quic_pderrin@quicinc.com, quic_cvanscha@quicinc.com, 
	quic_pkondeti@quicinc.com, quic_tsoni@quicinc.com, 
	eperezma <eperezma@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, Cindy Lu <lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 1:15=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Fri, Jul 26, 2024 at 10:47:59AM +0800, Jason Wang wrote:
> > On Wed, Jul 24, 2024 at 11:45=E2=80=AFAM Srivatsa Vaddagiri
> > <quic_svaddagi@quicinc.com> wrote:
> > >
> > > Currently vduse does not seem to support configuration space writes
> > > (vduse_vdpa_set_config does nothing). Is there any plan to lift that
> > > limitation? I am aware of the discussions that took place here:
> > >
> > > https://patchwork.kernel.org/project/netdevbpf/patch/20210615141331.4=
07-11-xieyongji@bytedance.com/
> > >
> > > Perhaps writes can be supported *selectively* without violating safet=
y concerns
> > > expressed in the above email discussion?
> >
> > Adding more relevant people here.
> >
> > It can probably be done case by case. The main reason for avoiding
> > config writing is
> >
> > 1) to prevent buggy/malicious userspace from hanging kernel driver for =
ever
> > 2) to prevent buggy/malicious userspace device to break the semantic
> >
> > Basically, it is the traditional trust model where the kernel doesn't
> > trust userspace.
> >
> > E.g current virtio-blk has the following codes:
> >
> > tatic ssize_t
> > cache_type_store(struct device *dev, struct device_attribute *attr,
> >          const char *buf, size_t count)
> > {
> >         struct gendisk *disk =3D dev_to_disk(dev);
> >         struct virtio_blk *vblk =3D disk->private_data;
> >         struct virtio_device *vdev =3D vblk->vdev;
> >         int i;
> >
> >         BUG_ON(!virtio_has_feature(vblk->vdev, VIRTIO_BLK_F_CONFIG_WCE)=
);
> >         i =3D sysfs_match_string(virtblk_cache_types, buf);
> >         if (i < 0)
> >         return i;
> >
> >         virtio_cwrite8(vdev, offsetof(struct virtio_blk_config, wce), i=
);
> >         virtblk_update_cache_mode(vdev);
> >         return count;
> > }
>
> To be fair, I think if you allow a block device in userspace you have alr=
eady
> allowed said userspace to crash the kernel unless you have
> also restricted the filesystems mounted on this device to FUSE.

I'm not sure I will get here, I think the kernel should be able to
survive from the buggy device no matter if it is a real one or
something emulated in the userspace?

And if we can manage to do that, we should have an extra safe layer
(e.g we've agreed that we need to use shadow cvq for VDUSE networking
devices).

THanks

>
> --
> MST
>

