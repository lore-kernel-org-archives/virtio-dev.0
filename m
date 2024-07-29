Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11B476056
	for <virtio-dev@lists.linux.dev>; Mon, 29 Jul 2024 02:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722219437; cv=none; b=mPfVaLLxnTIAMSDFMrIJ9cdPCBeOLoP/xYcvDH/sY9GgXIrAB/2cds+k4Sk6+0dcj9K/6tEKH6kPH6SirqGgecbhWsSxLWnqHH/hSTmQC758ZU5jjd/ChsHm0oU/4x85glKAgsddmz0Qf2bb23WoJd8s2iVQkOs9Gmgm0HHRREg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722219437; c=relaxed/simple;
	bh=L03jNnVo3oc5W/e4WB1NyUCikaVjOEADlO57C5GzFJQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OuE/+xjm8BYDRqjLow6O2jszyzvteql4ljcaymlpQHs35GsX8Dk8FdP0HB5apwtHTJMeFzBTSp3cZFSkDJNjlbcpyBrdB5qM1HkzbDVqbFPojqvsSxSuBzGaxYTTVGB1mjo2I2P7OxUkrHWsYdHGhWN41Dkexr06FtyVyWxt4EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dujZzf6G; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dujZzf6G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722219434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/xgPy2/4qi1bw2j0+tV2H2autbl58b7uFXuel8vkU2Y=;
	b=dujZzf6Glf4K7JVt6cy5Ft6VL3nhN8hjaqiIkHCTWT4kFg/ksrWYpLKNGhpSKGmnYP9G+9
	4glEj7Mriayo5gQHTRszBPm0PFF5MBcPEK+vFna93bWrWQMuHHTobgtGtVm4ZQHOsKvJ9I
	yfmVqhvVgD+bLPRgvUEyoj8XW6+Khv8=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-WvH4yDcVN_2PdU8CzEMYUw-1; Sun, 28 Jul 2024 22:17:02 -0400
X-MC-Unique: WvH4yDcVN_2PdU8CzEMYUw-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2cb6b642c49so2720346a91.1
        for <virtio-dev@lists.linux.dev>; Sun, 28 Jul 2024 19:17:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722219421; x=1722824221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/xgPy2/4qi1bw2j0+tV2H2autbl58b7uFXuel8vkU2Y=;
        b=n6o9vjhRQBOi9A8IOWoccIRKBlItXWXJ1s+Xp3Gmr+jQOgl0FWBivAq/AK+m78AsBF
         Usqaj+PFPQpQZZTA4T4L6xxXfUeXi2fBPJG0dfUBctvYIlldh0h+YhsEhKP/XZG5ZZg6
         04kyJONQoIfVPMBcNhMCTLaiyyQFngjI8EsQ/4efNMxNMSA0JIhMoKFEc7wRz7oqKx8p
         OXNXNPxrvDY473dmIMdri2IZmajxAU5AOj+nx5MZjiuLz4976c2piU3edXtC6e3Fpz6K
         ShStsND08IGFi89xK+nTk0R4I7GKSX10HNl/62oag8ht2rxNxDeIsl37oi04HMCsRLf3
         4EFg==
X-Forwarded-Encrypted: i=1; AJvYcCWIzW9HgFU0Buqfw/lek3Ukyxt/roQf5IYTooPAz5/PLwNUumuv72+YXIKm3rIxHUH/mlbBMuVo1cQoxEYOu+pcVXz7i2hy5rXKWQ==
X-Gm-Message-State: AOJu0Yzs+p6xqeYd9kAp3Af11oYKu7MunE30C3Zj5qzR0Tmi1QUsagW8
	ugjStOm0Idm2j+X1gaolw2tzyfl0LxovZtExAZTjSC1Yh7boagsUSHBtV5iJab0mkuAPZORmlP0
	oIR+6ZzGbKASF35GphHtFb/c+4IpGSv7W5Qp94JzAaGulyO3APTZvXKmEQ+Dhj7EMOytQl1Hix5
	fmZ8R9kugwxPMfz65No4yuSzvLVJztWOWibFOW4bGvqQ==
X-Received: by 2002:a17:90b:3b42:b0:2cb:4b31:1c48 with SMTP id 98e67ed59e1d1-2cf7cfae241mr9270013a91.22.1722219421140;
        Sun, 28 Jul 2024 19:17:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJuNpRw77lqwh4iJVXUNHoFzwDf+akQ5L680oOg9a1ao4SuJuy00gUAOCuCo0SnCRbSfp20NM4w+bbqUNTQ+o=
X-Received: by 2002:a17:90b:3b42:b0:2cb:4b31:1c48 with SMTP id
 98e67ed59e1d1-2cf7cfae241mr9269981a91.22.1722219420585; Sun, 28 Jul 2024
 19:17:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240724033816.GD492231@quicinc.com> <CACGkMEs_FHg6xZAw2V7AKvj5XFCmaA0Xm+ei7z4OFJPNgO5Thw@mail.gmail.com>
 <20240726070324.GA723942@quicinc.com>
In-Reply-To: <20240726070324.GA723942@quicinc.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 29 Jul 2024 10:16:48 +0800
Message-ID: <CACGkMEtin7mb=rA_nS6ArinP4k_v-Zsa05tMb_KXXUvfuCMiKw@mail.gmail.com>
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

On Fri, Jul 26, 2024 at 3:04=E2=80=AFPM Srivatsa Vaddagiri
<quic_svaddagi@quicinc.com> wrote:
>
> * Jason Wang <jasowang@redhat.com> [2024-07-26 10:47:59]:
>
> > On Wed, Jul 24, 2024 at 11:45???AM Srivatsa Vaddagiri
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
> >
> > So basically the question is if we make the config write a posted
> > write or non-posted one.
> >
> > If we make vduse config write a posted one, it means vduse doesn't
> > need to wait for the usersapce response. This is much more safe but it
> > breaks the above code as it looks like it requires a non-posted
> > semantic. We need to filter out virtio-blk or change the code to have
> > a read after the write:
> >
> > while (virtio_cread8(vdev, offsetof(struct virtio_blk_config, wce) & XX=
X)
> >        /* sleep or other */
> >
> > But we may suffer from the userspace who doesn't update the wce bit
> > forever, or maybe we can have a timeout there.
> >
> > If we make vduse config write a non posted one, it means the vduse
> > needs to wait for the response from the userspace.
>
> I was thinking only a read followed by write will needs to stall on a res=
ponse
> from userspace, but yes we will have the same issue of dealing with buggy
> userspace. At least for PCI, I think there is provision to use surprise r=
emoval
> facility, where guest can be notified of malfunctioning device. In case o=
f
> userspace (vduse daemon) not responding in time, can the surprise removal=
 event
> be injected by VMM (hypervisor in our case)? Guest can decide what to do =
with it
> next.

I think it's a good point, we can try to implement this.

>
> > It satisfies the
> > above code's assumption but it needs to deal with the buggy userspace
> > which might be challenging.  Technically, we can have a device
> > emulation in the kernel but it looks like overkill for wce (or I don't
> > know how it can mandate wce for userspace devices).
> >
> > I feel it might make sense for other devices that only require posted
> > write semantics.
> >
> > >
> > > We are thinking of using vduse for hypervisor assisted virtio devices=
, which
> > > may need config write support and hence this question.
> > >
> > > To provide more details, we have a untrusted host that spins off a pr=
otected
> > > (confidential) guest VM on a Type-1 hypervisor (Gunyah). VMM in untru=
sted host
> > > leads to couple of issues:
> > >
> > > 1) Latency of (virtio) register access. VMM can take too long to resp=
ond with
> > > VCPU stalled all that while. I think vduse shares a similar concern, =
due to
> > > which it maintains a cache of configuratin registers inside kernel.
> >
> > Maybe you can give an example for this? We cache the configuration
> > space to a faster access to that.
>
> Yes for the same reason of faster access, we wish to have config informat=
ion
> cached in hypervisor. In case of VDUSE,
>
> Guest read -> (VM exit) -> VHOST_VDPA_GET_CONFIG -> vduse_vdpa_get_config
>
> Basically a guest read terminates in host kernel, before resuming.
>
> In our case,
>
> Guest read - (VM exit) - Hyp emulates read - (VM resume)
>
> So a guest read would terminate in hypervisor itself, before it is resume=
d.

It looks like the only difference so far is there is a userspace
assistance in the case of VDUSE.

>
> Without this optimization, guest VCPU would have stalled until VMM in hos=
t can
> emulate it, which can be long, especially a concern when the read is issu=
ed in
> hot path (interrupt handler, w/o MSI_X).

I think I agree with Michael, let's try to use MSI-X here where
there's a lot of existing optimizations in various layers.

>
> > > 2) For PCI pass-through devices, we are concerned of letting VMM be i=
n charge of
> > > emulating the complete configuration space (how can VM defend against=
 invalid
> > > attributes presented for passthr devices)?
> >
> > Virtio driver has been hardened for this, for example:
> >
> > commit 72b5e8958738aaa453db5149e6ca3bcf416023b9
> > Author: Jason Wang <jasowang@redhat.com>
> > Date:   Fri Jun 4 13:53:50 2021 +0800
> >
> >     virtio-ring: store DMA metadata in desc_extra for split virtqueue
> >
> > More hardening work is ongoing.
>
> Any additional pointers you can share? I will go over them and revert.

Yes, used buffer length and IRQ hardening are reverted as we need to
deal with the legacy device more carefully. New version will be posted
in the near future.

>
> > > I am aware of TDISP, but I think it
> > > may not be available for some of the devices on our platform.
> > >
> > > One option we are considering is for hypervisor to be in charge of vi=
rtio-PCI
> > > bus emulation, allowing only select devices (with recognized features=
) to be
> > > registered on the bus. VMM would need to register devices/features wi=
th
> > > hypervisor, which would verify it (as per some policy) and present th=
em to VM on
> > > the virtio-PCI bus it would emulate. Protected VM should be shielded =
from
> > > invalid device configuration information that it may otherwise read f=
rom a
> > > compromised VMM.
> > >
> > > For virtio devices, the hypervisor would also service most register r=
ead/writes
> > > (to address concern #1), which implies it would need to cache a copy =
of the
> > > device configuration information (similar to vduse).
> > >
> > > We think vduse can be leveraged here to initialize the hypervisor cac=
he of
> > > virtio registers. Basically have a vdpa-gunyah driver registered on t=
he vdpa
> > > bus to which vduse devices are bound (rather than virtio-vdpa or vhos=
t-vdpa).
> > > vdpa-gunyah driver can pull configuration information from vduse and =
pass that
> > > on to hypervisor. It will also help inject IRQ and pass on queue noti=
fications
> > > (using hypervisor specific APIs).
> >
> > Just to make sure I understand the design here, is vdpa-gunyah
> > expected to have a dedicated uAPI other than vhost-vDPA?
>
> I didn't think vdpa-gunyah would need to provide any UAPI. VDUSE daemon
> functionality would be inside VMM itself. For example, the virtio-block b=
ackend
> in VMM would create a VDUSE device and pass on key configuration informat=
ion to
> VDUSE kernel module. The vdpa device created subsequently (vdpa dev add .=
.)
> will be bound to vdpa-gunyah driver, which pulls the configuration inform=
ation
> and passes on to hypervisor, which will emulate all further access from V=
M.

Ok, so those drivers will talk to the VMM.

>
> > Wonder any reason why vhost-vDPA can be used here.
>
> I think vhost-vDPA will imply that VMM still tracks the device on its PCI=
/MMIO
> transports and will be involved for any register read from VM?

Yes, and it is done with the assistance of the userspace.

> We didn't want
> VMM to be involved in emulating register access of VM. Instead hyp will e=
mulate
> most of those accesses.  I need to think more, but I am thinking the VMM =
will
> not even track this device on its PCI/MMIO transports, but rather on a
> different, vdpa?, transport.

Right, you need to emulate a virtio device with an existing transport
anyhow. MMIO might be easy. If you want a PCI transport it means a
huge number of devices emulation needs to be done by the hypervisor.

>
> > > We will however likely need vduse to support configuration writes (gu=
est VM
> > > updating configuration space, for ex: writing to 'events_clear' field=
 in case of
> > > virtio-gpu). Would vduse maintainers be willing to accept config_writ=
e support
> > > for select devices/features (as long as the writes don't violate any =
safety
> > > concerns we may have)?
> >
> > I think so, looking at virtio_gpu_config_changed_work_func(), the
> > events_clear seems to be fine to have a posted semantic.
> >
> > Maybe you can post an RFC to support config writing and let's start fro=
m there?
>
> Ok thanks for your feedback!
>
> - vatsa
>

Thanks

