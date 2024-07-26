Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D3722611
	for <virtio-dev@lists.linux.dev>; Fri, 26 Jul 2024 02:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721962102; cv=none; b=lJ6XH9uUFNWR6n/PpQY+2Le4XZRpBN1d55piOBiJsf4GVZwhiFi0DYFKyS+sCXGMTCgxbqdZMJrkL1bXkJtKD8R7nWatyMJkOO39cV06UYMEbSWswE8JnGc2tE1NN/OXv1GSnR+SSmi8ElmTARt8zLRDv4F/5NgTio0Ik5GDW38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721962102; c=relaxed/simple;
	bh=d8bULL5OlDjO2se6e+60D2DArmYrTX1nstX7roW9G7c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b21ClJindG2vOu3vDQhCAKLknzuBWaafyT1+rHjmtc1e5vjqZqyIesR61C1h+ESP9Hp7kWBQzHbjhclGvZKTbZBwwHT+3qp7kDPGQX3ZeD02EJI1T6xj6izavs0mo4EflZcpoxGHSCSfg81apvgwks4Ht7CUUJka9QFhiBnxs6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NmGaK/Yw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NmGaK/Yw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721962099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XeSDxtiQmXwuFwReFKz8QuvPcZxIukFuNiAfW92ndEE=;
	b=NmGaK/Yw3xJAEkGLI9UkifgHr4jxc3LXYWWItYNJbCQFfic+CDV0W/e9yDJE8dv8I69gcQ
	8Gn2m2AL4LRxmaPJBVSRrQ/F8Wb2ltbRcabfss6njJ9qMq9+bkIr0ITvOs4QTmobZrkjpX
	eVSQKb7NoE/uhLGaDXsUdamPXFfIAW4=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-I9Lq-qAHMlCQpGl05WX50A-1; Thu, 25 Jul 2024 22:48:16 -0400
X-MC-Unique: I9Lq-qAHMlCQpGl05WX50A-1
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-48a33435f58so961512137.3
        for <virtio-dev@lists.linux.dev>; Thu, 25 Jul 2024 19:48:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721962095; x=1722566895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XeSDxtiQmXwuFwReFKz8QuvPcZxIukFuNiAfW92ndEE=;
        b=wbhOEPqJnIHvXzl4TVzM8J4uoec2FD/UdMgh+xL+ABn5gFqrFh7W43+CpUXRSfcfxY
         ZNc4aTs7HzDOm68R1NxnG4iPUI9K2cpKa9WWDNsHQbuSs+xjZ6x4Xu2yRc1+NFZQnGrr
         ZCVV95Mt5eeKNsdoBHeg1KvEKpdeF8Tmlfk0PGmaAABFMe5FFM0iYJXWEpGxk/gEcCCb
         hNpLueAX3Hpwxi2c733FaWT5GAuwsdRPEMEKLhwGqphs+FCU/9bf6B+DpjZH4SgHHz6Y
         3jaoCzdYXmbvoza+jIDkSCT/uP8oDlH4CTqZpA6ckp84PC1YTP1ZikdMKqtWOUoUGrOW
         HRcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxsxG3qpsEKviEjZqGJTmBtaI/h/fK4kHLgRoq/SdqlpNxlnhn/5ov+nWpOz5jkLF3wKO7bwcRf95EXi3CEeFgmXUuJsQG9zMHDw==
X-Gm-Message-State: AOJu0Yz3YONUM5LbCfYL6DWW9otP8WvJ/oXzlF0UDu/vagE8qipiPi1T
	8j67ucp7dxaW1wZjK7aJlsxsseZ6VL2RiyBPIYhdKLxbn9kSpDCWuPt9cLRYWW6Jn3j9036Ypf/
	8fOdsdOMTiD2gIqntzWm58UpNZBSshXsoq3d9mIg5yc4L02SP+oONVdnatjwlhPDRyORDBLf42U
	NqJGfsxAASTbr3cXEM96yexKsm81Sl89wP7g==
X-Received: by 2002:a05:6102:1490:b0:492:ae79:ffbb with SMTP id ada2fe7eead31-493d64b60d7mr6971884137.24.1721962095614;
        Thu, 25 Jul 2024 19:48:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGJMjJgl3eknXfvv5ap2fhBTc1Cv5wiWyzl5o6/g2CSXpIOpv10cO81GugKlsYlCKMI/brwSe+8C4ESYpD3q4=
X-Received: by 2002:a05:6102:1490:b0:492:ae79:ffbb with SMTP id
 ada2fe7eead31-493d64b60d7mr6971863137.24.1721962095151; Thu, 25 Jul 2024
 19:48:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240724033816.GD492231@quicinc.com>
In-Reply-To: <20240724033816.GD492231@quicinc.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 26 Jul 2024 10:47:59 +0800
Message-ID: <CACGkMEs_FHg6xZAw2V7AKvj5XFCmaA0Xm+ei7z4OFJPNgO5Thw@mail.gmail.com>
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

On Wed, Jul 24, 2024 at 11:45=E2=80=AFAM Srivatsa Vaddagiri
<quic_svaddagi@quicinc.com> wrote:
>
> Currently vduse does not seem to support configuration space writes
> (vduse_vdpa_set_config does nothing). Is there any plan to lift that
> limitation? I am aware of the discussions that took place here:
>
> https://patchwork.kernel.org/project/netdevbpf/patch/20210615141331.407-1=
1-xieyongji@bytedance.com/
>
> Perhaps writes can be supported *selectively* without violating safety co=
ncerns
> expressed in the above email discussion?

Adding more relevant people here.

It can probably be done case by case. The main reason for avoiding
config writing is

1) to prevent buggy/malicious userspace from hanging kernel driver for ever
2) to prevent buggy/malicious userspace device to break the semantic

Basically, it is the traditional trust model where the kernel doesn't
trust userspace.

E.g current virtio-blk has the following codes:

tatic ssize_t
cache_type_store(struct device *dev, struct device_attribute *attr,
         const char *buf, size_t count)
{
        struct gendisk *disk =3D dev_to_disk(dev);
        struct virtio_blk *vblk =3D disk->private_data;
        struct virtio_device *vdev =3D vblk->vdev;
        int i;

        BUG_ON(!virtio_has_feature(vblk->vdev, VIRTIO_BLK_F_CONFIG_WCE));
        i =3D sysfs_match_string(virtblk_cache_types, buf);
        if (i < 0)
        return i;

        virtio_cwrite8(vdev, offsetof(struct virtio_blk_config, wce), i);
        virtblk_update_cache_mode(vdev);
        return count;
}

So basically the question is if we make the config write a posted
write or non-posted one.

If we make vduse config write a posted one, it means vduse doesn't
need to wait for the usersapce response. This is much more safe but it
breaks the above code as it looks like it requires a non-posted
semantic. We need to filter out virtio-blk or change the code to have
a read after the write:

while (virtio_cread8(vdev, offsetof(struct virtio_blk_config, wce) & XXX)
       /* sleep or other */

But we may suffer from the userspace who doesn't update the wce bit
forever, or maybe we can have a timeout there.

If we make vduse config write a non posted one, it means the vduse
needs to wait for the response from the userspace. It satisfies the
above code's assumption but it needs to deal with the buggy userspace
which might be challenging. Technically, we can have a device
emulation in the kernel but it looks like overkill for wce (or I don't
know how it can mandate wce for userspace devices).

I feel it might make sense for other devices that only require posted
write semantics.

>
> We are thinking of using vduse for hypervisor assisted virtio devices, wh=
ich
> may need config write support and hence this question.
>
> To provide more details, we have a untrusted host that spins off a protec=
ted
> (confidential) guest VM on a Type-1 hypervisor (Gunyah). VMM in untrusted=
 host
> leads to couple of issues:
>
> 1) Latency of (virtio) register access. VMM can take too long to respond =
with
> VCPU stalled all that while. I think vduse shares a similar concern, due =
to
> which it maintains a cache of configuratin registers inside kernel.

Maybe you can give an example for this? We cache the configuration
space to a faster access to that.

>
> 2) For PCI pass-through devices, we are concerned of letting VMM be in ch=
arge of
> emulating the complete configuration space (how can VM defend against inv=
alid
> attributes presented for passthr devices)?

Virtio driver has been hardened for this, for example:

commit 72b5e8958738aaa453db5149e6ca3bcf416023b9
Author: Jason Wang <jasowang@redhat.com>
Date:   Fri Jun 4 13:53:50 2021 +0800

    virtio-ring: store DMA metadata in desc_extra for split virtqueue

More hardening work is ongoing.

> I am aware of TDISP, but I think it
> may not be available for some of the devices on our platform.
>
> One option we are considering is for hypervisor to be in charge of virtio=
-PCI
> bus emulation, allowing only select devices (with recognized features) to=
 be
> registered on the bus. VMM would need to register devices/features with
> hypervisor, which would verify it (as per some policy) and present them t=
o VM on
> the virtio-PCI bus it would emulate. Protected VM should be shielded from
> invalid device configuration information that it may otherwise read from =
a
> compromised VMM.
>
> For virtio devices, the hypervisor would also service most register read/=
writes
> (to address concern #1), which implies it would need to cache a copy of t=
he
> device configuration information (similar to vduse).
>
> We think vduse can be leveraged here to initialize the hypervisor cache o=
f
> virtio registers. Basically have a vdpa-gunyah driver registered on the v=
dpa
> bus to which vduse devices are bound (rather than virtio-vdpa or vhost-vd=
pa).
> vdpa-gunyah driver can pull configuration information from vduse and pass=
 that
> on to hypervisor. It will also help inject IRQ and pass on queue notifica=
tions
> (using hypervisor specific APIs).

Just to make sure I understand the design here, is vdpa-gunyah
expected to have a dedicated uAPI other than vhost-vDPA? Wonder any
reason why vhost-vDPA can be used here.

>
> We will however likely need vduse to support configuration writes (guest =
VM
> updating configuration space, for ex: writing to 'events_clear' field in =
case of
> virtio-gpu). Would vduse maintainers be willing to accept config_write su=
pport
> for select devices/features (as long as the writes don't violate any safe=
ty
> concerns we may have)?

I think so, looking at virtio_gpu_config_changed_work_func(), the
events_clear seems to be fine to have a posted semantic.

Maybe you can post an RFC to support config writing and let's start from th=
ere?

Thanks

>
> Thanks
> vatsa
>

