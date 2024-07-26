Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6FC2C9A;
	Fri, 26 Jul 2024 07:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721977426; cv=none; b=iqfeXLejG9RSCDDfoTDO1sKNYA6pnBApuuwacyHMRYtXG1o43mCMIVojAlnVl6u2bdKcQzumjkosHzpa2gNe4wNVz6eIlfImwn45T4EY0WU8FTq9CBng8Bf5muVyyC51uJrE4SLwYMXI/lsoUCxspUPQm1QhbDGLXAisBq/dM8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721977426; c=relaxed/simple;
	bh=tIulMi0NhUrZ2/CQdYf1aFpVG9HLYNaYpMLfEtPiVag=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S6/0IrcrGB7JorFLnE10chcIgCAUbEG31WPXVRMckRO6EM7BRUxJTM/fEGOXThEvc3YJKGBR90+QIMpPpG28bT9gXbwN5LLEU2skFWcSWFzx/lH3MBGrbv3Hemh48w2jNVTn6aEBcXPUWJru51M5wI5tfzrRq8gxinyDrpcxEfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bMWRN4m0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bMWRN4m0"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46Q169lt027355;
	Fri, 26 Jul 2024 07:03:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:reply-to:subject:to; s=qcppdkim1; bh=Ze7OXJn9hObndV7
	saPnCXgOYn6rex9sHIrMMVE7aK5U=; b=bMWRN4m0tRBzqsGLdht37r+8Voa0P+t
	XLWwmL6vzakkW9aetgZOmiQ3E0him7B1fqHog+we4tFFgth2flsAEZ6Zwj470n+U
	CLUPsQP1t4t2pmWJ5rLBri1Fia7j+Hq6UlOa42t3tKgAYZ5LNKAuDWqXFrRb1FfC
	eClXCoFfofvgpzTer3Ca1I0EfPlteoipJAM6fo3nhLyf+TgvzeCICQA/TXtd2zu7
	uT22N1SiT+Y3GsnY3L2D9n7HRmjvqPiWvwosTbwN69p74K78zLbCgDnQXYgH3MQv
	ukHWggutuJ2Lh78IC2UOvv6l0y6aPA43fjJJpEXJugSyqPmg5lnC1jw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40m1tw8mu4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jul 2024 07:03:35 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46Q73Ypu023688
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jul 2024 07:03:34 GMT
Received: from quicinc.com (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 26 Jul
 2024 00:03:28 -0700
Date: Fri, 26 Jul 2024 12:33:24 +0530
From: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
To: Jason Wang <jasowang@redhat.com>
CC: <xieyongji@bytedance.com>, <stefanha@redhat.com>,
        <virtio-dev@lists.linux.dev>, <virtualization@lists.linux.dev>,
        <quic_mnalajal@quicinc.com>, <quic_eberman@quicinc.com>,
        <quic_pheragu@quicinc.com>, <quic_pderrin@quicinc.com>,
        <quic_cvanscha@quicinc.com>, <quic_pkondeti@quicinc.com>,
        <quic_tsoni@quicinc.com>, eperezma <eperezma@redhat.com>,
        Stefano Garzarella
	<sgarzare@redhat.com>, mst <mst@redhat.com>,
        Cindy Lu <lulu@redhat.com>
Subject: Re: [RFC] vduse config write support
Message-ID: <20240726070324.GA723942@quicinc.com>
Reply-To: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
References: <20240724033816.GD492231@quicinc.com>
 <CACGkMEs_FHg6xZAw2V7AKvj5XFCmaA0Xm+ei7z4OFJPNgO5Thw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
In-Reply-To: <CACGkMEs_FHg6xZAw2V7AKvj5XFCmaA0Xm+ei7z4OFJPNgO5Thw@mail.gmail.com>
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 62RwzwzkiRCfbEwXEfJKdJowB7W6h_3k
X-Proofpoint-GUID: 62RwzwzkiRCfbEwXEfJKdJowB7W6h_3k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-26_04,2024-07-25_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1011
 lowpriorityscore=0 impostorscore=0 phishscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2407260045

* Jason Wang <jasowang@redhat.com> [2024-07-26 10:47:59]:

> On Wed, Jul 24, 2024 at 11:45???AM Srivatsa Vaddagiri
> <quic_svaddagi@quicinc.com> wrote:
> >
> > Currently vduse does not seem to support configuration space writes
> > (vduse_vdpa_set_config does nothing). Is there any plan to lift that
> > limitation? I am aware of the discussions that took place here:
> >
> > https://patchwork.kernel.org/project/netdevbpf/patch/20210615141331.407-11-xieyongji@bytedance.com/
> >
> > Perhaps writes can be supported *selectively* without violating safety concerns
> > expressed in the above email discussion?
> 
> Adding more relevant people here.
> 
> It can probably be done case by case. The main reason for avoiding
> config writing is
> 
> 1) to prevent buggy/malicious userspace from hanging kernel driver for ever
> 2) to prevent buggy/malicious userspace device to break the semantic
> 
> Basically, it is the traditional trust model where the kernel doesn't
> trust userspace.
> 
> E.g current virtio-blk has the following codes:
> 
> tatic ssize_t
> cache_type_store(struct device *dev, struct device_attribute *attr,
>          const char *buf, size_t count)
> {
>         struct gendisk *disk = dev_to_disk(dev);
>         struct virtio_blk *vblk = disk->private_data;
>         struct virtio_device *vdev = vblk->vdev;
>         int i;
> 
>         BUG_ON(!virtio_has_feature(vblk->vdev, VIRTIO_BLK_F_CONFIG_WCE));
>         i = sysfs_match_string(virtblk_cache_types, buf);
>         if (i < 0)
>         return i;
> 
>         virtio_cwrite8(vdev, offsetof(struct virtio_blk_config, wce), i);
>         virtblk_update_cache_mode(vdev);
>         return count;
> }
> 
> So basically the question is if we make the config write a posted
> write or non-posted one.
> 
> If we make vduse config write a posted one, it means vduse doesn't
> need to wait for the usersapce response. This is much more safe but it
> breaks the above code as it looks like it requires a non-posted
> semantic. We need to filter out virtio-blk or change the code to have
> a read after the write:
> 
> while (virtio_cread8(vdev, offsetof(struct virtio_blk_config, wce) & XXX)
>        /* sleep or other */
>
> But we may suffer from the userspace who doesn't update the wce bit
> forever, or maybe we can have a timeout there.
> 
> If we make vduse config write a non posted one, it means the vduse
> needs to wait for the response from the userspace. 

I was thinking only a read followed by write will needs to stall on a response
from userspace, but yes we will have the same issue of dealing with buggy
userspace. At least for PCI, I think there is provision to use surprise removal
facility, where guest can be notified of malfunctioning device. In case of
userspace (vduse daemon) not responding in time, can the surprise removal event
be injected by VMM (hypervisor in our case)? Guest can decide what to do with it
next.

> It satisfies the
> above code's assumption but it needs to deal with the buggy userspace
> which might be challenging.  Technically, we can have a device
> emulation in the kernel but it looks like overkill for wce (or I don't
> know how it can mandate wce for userspace devices).
> 
> I feel it might make sense for other devices that only require posted
> write semantics.
> 
> >
> > We are thinking of using vduse for hypervisor assisted virtio devices, which
> > may need config write support and hence this question.
> >
> > To provide more details, we have a untrusted host that spins off a protected
> > (confidential) guest VM on a Type-1 hypervisor (Gunyah). VMM in untrusted host
> > leads to couple of issues:
> >
> > 1) Latency of (virtio) register access. VMM can take too long to respond with
> > VCPU stalled all that while. I think vduse shares a similar concern, due to
> > which it maintains a cache of configuratin registers inside kernel.
> 
> Maybe you can give an example for this? We cache the configuration
> space to a faster access to that.

Yes for the same reason of faster access, we wish to have config information
cached in hypervisor. In case of VDUSE,

Guest read -> (VM exit) -> VHOST_VDPA_GET_CONFIG -> vduse_vdpa_get_config

Basically a guest read terminates in host kernel, before resuming.

In our case,

Guest read - (VM exit) - Hyp emulates read - (VM resume)

So a guest read would terminate in hypervisor itself, before it is resumed. 

Without this optimization, guest VCPU would have stalled until VMM in host can
emulate it, which can be long, especially a concern when the read is issued in
hot path (interrupt handler, w/o MSI_X).

> > 2) For PCI pass-through devices, we are concerned of letting VMM be in charge of
> > emulating the complete configuration space (how can VM defend against invalid
> > attributes presented for passthr devices)?
> 
> Virtio driver has been hardened for this, for example:
> 
> commit 72b5e8958738aaa453db5149e6ca3bcf416023b9
> Author: Jason Wang <jasowang@redhat.com>
> Date:   Fri Jun 4 13:53:50 2021 +0800
> 
>     virtio-ring: store DMA metadata in desc_extra for split virtqueue
> 
> More hardening work is ongoing.

Any additional pointers you can share? I will go over them and revert.

> > I am aware of TDISP, but I think it
> > may not be available for some of the devices on our platform.
> >
> > One option we are considering is for hypervisor to be in charge of virtio-PCI
> > bus emulation, allowing only select devices (with recognized features) to be
> > registered on the bus. VMM would need to register devices/features with
> > hypervisor, which would verify it (as per some policy) and present them to VM on
> > the virtio-PCI bus it would emulate. Protected VM should be shielded from
> > invalid device configuration information that it may otherwise read from a
> > compromised VMM.
> >
> > For virtio devices, the hypervisor would also service most register read/writes
> > (to address concern #1), which implies it would need to cache a copy of the
> > device configuration information (similar to vduse).
> >
> > We think vduse can be leveraged here to initialize the hypervisor cache of
> > virtio registers. Basically have a vdpa-gunyah driver registered on the vdpa
> > bus to which vduse devices are bound (rather than virtio-vdpa or vhost-vdpa).
> > vdpa-gunyah driver can pull configuration information from vduse and pass that
> > on to hypervisor. It will also help inject IRQ and pass on queue notifications
> > (using hypervisor specific APIs).
> 
> Just to make sure I understand the design here, is vdpa-gunyah
> expected to have a dedicated uAPI other than vhost-vDPA? 

I didn't think vdpa-gunyah would need to provide any UAPI. VDUSE daemon
functionality would be inside VMM itself. For example, the virtio-block backend
in VMM would create a VDUSE device and pass on key configuration information to
VDUSE kernel module. The vdpa device created subsequently (vdpa dev add ..) 
will be bound to vdpa-gunyah driver, which pulls the configuration information
and passes on to hypervisor, which will emulate all further access from VM. 

> Wonder any reason why vhost-vDPA can be used here.

I think vhost-vDPA will imply that VMM still tracks the device on its PCI/MMIO
transports and will be involved for any register read from VM? We didn't want
VMM to be involved in emulating register access of VM. Instead hyp will emulate
most of those accesses.  I need to think more, but I am thinking the VMM will
not even track this device on its PCI/MMIO transports, but rather on a
different, vdpa?, transport.

> > We will however likely need vduse to support configuration writes (guest VM
> > updating configuration space, for ex: writing to 'events_clear' field in case of
> > virtio-gpu). Would vduse maintainers be willing to accept config_write support
> > for select devices/features (as long as the writes don't violate any safety
> > concerns we may have)?
> 
> I think so, looking at virtio_gpu_config_changed_work_func(), the
> events_clear seems to be fine to have a posted semantic.
> 
> Maybe you can post an RFC to support config writing and let's start from there?

Ok thanks for your feedback!

- vatsa
