Return-Path: <virtio-dev-return-13941-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F2D5CE7A94
	for <virtio-dev@archiver.kernel.org>; Mon, 25 Sep 2023 02:52:37 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 9AF4E2AEEF
	for <virtio-dev@archiver.kernel.org>; Mon, 25 Sep 2023 02:52:36 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 52A3398640A
	for <virtio-dev@archiver.kernel.org>; Mon, 25 Sep 2023 02:52:36 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 2AC08986379; Mon, 25 Sep 2023 02:52:36 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1740B98637A
	for <virtio-dev@lists.oasis-open.org>; Mon, 25 Sep 2023 02:52:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: miIb-y64M2y2F_BiEHTM2Q-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695610352; x=1696215152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dvSNAd005cPkGlRILEQbu1tvQcInzbTRhT9CZO/Khiw=;
        b=S8W0zcqa2Nd6oHFmTgLhYqCSMKGW2KQ7e5/BnlL54WptUad8iZeP/qTc+gIZpPnJKN
         DbA4BSEL0fPXWJMQvrQ1gLHtb18b+++COQoNYqUkAk/5kkBcZWKs8nVYjMikvJaMBMTx
         fsTKPVzcxLGvjqVvQ5FcNKrtE/cBVQ25XY0NtUfp+NNTIJCosE2SrL45p0YznWWiaIrR
         7LT6Vl9y8rEttEYtOkPYKfwBKJWJue4nCmOjmVidIrgrsM39mmx650fu9z0rPFaQe4YH
         BC9aRzqzdg4lMjm9nvyt39a95FhAAtwFkFfy460l7uqBwNq3v4SsA4x3ueSbm3AKjwR+
         TffQ==
X-Gm-Message-State: AOJu0YytlCL1Q88elORCx6OnUcDJJzGiUxJk4V+xNVqqLrM91z0ovopn
	yi+N7Fe+rNYrlIlTG4l/SgzwT3QNa/1peHF9GjaLl/x//ghhefEw5JJpI3n47XJQ5bSaUFZR2Fq
	lSJfvW0bksQtrhIl/QBCgdTj7LmVDi68aoEzoNEUSctaU
X-Received: by 2002:a05:6512:3043:b0:503:9c2:e44e with SMTP id b3-20020a056512304300b0050309c2e44emr5477022lfb.55.1695610352134;
        Sun, 24 Sep 2023 19:52:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYkcmxSFRmz4bV1vaXQBWC3Hagr0bVdlUMbajCZhWM7FIzduz2o2bsO8DnG6xVp3slwSFzNKGiZx4OjbRtGy0=
X-Received: by 2002:a05:6512:3043:b0:503:9c2:e44e with SMTP id
 b3-20020a056512304300b0050309c2e44emr5476990lfb.55.1695610351568; Sun, 24 Sep
 2023 19:52:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230919114242.2283646-1-Jiqian.Chen@amd.com> <20230919114242.2283646-2-Jiqian.Chen@amd.com>
 <CACGkMEuEXk2UzXU7sFUk-nHEeE7QoB3kbjnHgktY7KWuK71Xrg@mail.gmail.com>
 <BL1PR12MB58490A484087B2B2C37B6E43E7F8A@BL1PR12MB5849.namprd12.prod.outlook.com>
 <CACGkMEtx-i_9dgdONFzEmmWYNRhaoJQZX7a5OmLfDvGoUaajPQ@mail.gmail.com> <BL1PR12MB5849E38DE89D80B8A4CB7128E7FFA@BL1PR12MB5849.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB5849E38DE89D80B8A4CB7128E7FFA@BL1PR12MB5849.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 25 Sep 2023 10:52:20 +0800
Message-ID: <CACGkMEv0d3frw9KJcC3qDs0p8ZeWg6dowNEHcAHsgaOTm4CAAQ@mail.gmail.com>
To: "Chen, Jiqian" <Jiqian.Chen@amd.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, David Airlie <airlied@redhat.com>, 
	Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>, 
	=?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, 
	Robert Beckett <bob.beckett@collabora.com>, 
	Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com>, Parav Pandit <parav@nvidia.com>, 
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, 
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, 
	Stefano Stabellini <sstabellini@kernel.org>, =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>, 
	"Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>, 
	"Hildebrand, Stewart" <Stewart.Hildebrand@amd.com>, Xenia Ragiadakou <burzalodowa@gmail.com>, 
	"Huang, Honglei1" <Honglei1.Huang@amd.com>, "Zhang, Julia" <Julia.Zhang@amd.com>, 
	"Huang, Ray" <Ray.Huang@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [virtio-dev] Re: [VIRTIO PCI PATCH v5 1/1] transport-pci: Add
 freeze_mode to virtio_pci_common_cfg

On Fri, Sep 22, 2023 at 4:07=E2=80=AFPM Chen, Jiqian <Jiqian.Chen@amd.com> =
wrote:
>
> Hi Jason,
>
> On 2023/9/22 11:17, Jason Wang wrote:
> > On Thu, Sep 21, 2023 at 2:28=E2=80=AFPM Chen, Jiqian <Jiqian.Chen@amd.c=
om> wrote:
> >>
> >> Hi Jason,
> >>
> >> On 2023/9/21 12:22, Jason Wang wrote:
> >>> On Tue, Sep 19, 2023 at 7:43=E2=80=AFPM Jiqian Chen <Jiqian.Chen@amd.=
com> wrote:
> >>>>
> >>>> When guest vm does S3, Qemu will reset and clear some things of virt=
io
> >>>> devices, but guest can't aware that, so that may cause some problems=
.
> >>>> For excample, Qemu calls virtio_reset->virtio_gpu_gl_reset when gues=
t
> >>>> resume, that function will destroy render resources of virtio-gpu. A=
s
> >>>> a result, after guest resume, the display can't come back and we onl=
y
> >>>> saw a black screen. Due to guest can't re-create all the resources, =
so
> >>>> we need to let Qemu not to destroy them when S3.
> >>>>
> >>>> For above purpose, we need a mechanism that allows guests and QEMU t=
o
> >>>> negotiate their reset behavior. So this patch add a new parameter
> >>>> named freeze_mode to struct virtio_pci_common_cfg. And when guest
> >>>> suspends, it can write freeze_mode to be FREEZE_S3, and then virtio
> >>>> devices can change their reset behavior on Qemu side according to
> >>>> freeze_mode. What's more, freeze_mode can be used for all virtio
> >>>> devices to affect the behavior of Qemu, not just virtio gpu device.
> >>>
> >>> A simple question, why is this issue specific to pci?
> >> I thought you possibly missed the previous version patches. At the beg=
inning, I just wanted to add a new feature flag VIRTIO_GPU_F_FREEZE_S3 for =
virtio-gpu since I encountered virtio-gpu issue during guest S3, so that th=
e guest and qemu can negotiate and change the reset behavior during S3. But=
 Parav and Mikhail hoped me can improve the feature to a pci level, then ot=
her virtio devices can also benefit from it. Although I am not sure if expa=
nding its influence is appropriate, I have not received any feedback from o=
thers, so I change it to the pci level and made this version.
> >> If you are interested, please see the previous version: https://lists.=
oasis-open.org/archives/virtio-comment/202307/msg00209.html, thank you.
> >
> > This is not a good answer. Let me ask you differently, why don't you
> > see it in other forms of transport like virtio-gpu-mmio?
> Sorry for not understanding your question before. Did you mean why did I =
add freeze_mode for virtio-pci type devices instead of virtio-mmio type dev=
ices?

Yes.

> If that's the case, it isn't well thought out by me, because there is onl=
y virtio-gpu with pci support in my environment, so I, as a matter of cours=
e, improve it from virtio-gpu-pci to a virtio-pci level instead of virtio-m=
mio.
> Do you think I need to add freeze_mode for virtio-mmio too?

Because the function you describe is to preserve the render resources
which have nothing specific to PCI. It's a core virtio function.

I'd suggest fixing it at the virtio level instead of PCI level.

> Or improve it to a higher level, like virtio-bus? I am looking forward to=
 getting your suggestions, thanks.

As pointed out in other thread, reusing the existing status state
machine is a perfect way for doing this.

We can tweak the state machine to be able to do both migration and S3.

Thanks

>
> >
> > Thanks
> >
> >>
> >>>
> >>> Thanks
> >>>
> >>>
> >>>>
> >>>> Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
> >>>> ---
> >>>>  transport-pci.tex | 7 +++++++
> >>>>  1 file changed, 7 insertions(+)
> >>>>
> >>>> diff --git a/transport-pci.tex b/transport-pci.tex
> >>>> index a5c6719..2543536 100644
> >>>> --- a/transport-pci.tex
> >>>> +++ b/transport-pci.tex
> >>>> @@ -319,6 +319,7 @@ \subsubsection{Common configuration structure la=
yout}\label{sec:Virtio Transport
> >>>>          le64 queue_desc;                /* read-write */
> >>>>          le64 queue_driver;              /* read-write */
> >>>>          le64 queue_device;              /* read-write */
> >>>> +        le16 freeze_mode;               /* read-write */
> >>>>          le16 queue_notif_config_data;   /* read-only for driver */
> >>>>          le16 queue_reset;               /* read-write */
> >>>>
> >>>> @@ -393,6 +394,12 @@ \subsubsection{Common configuration structure l=
ayout}\label{sec:Virtio Transport
> >>>>  \item[\field{queue_device}]
> >>>>          The driver writes the physical address of Device Area here.=
  See section \ref{sec:Basic Facilities of a Virtio Device / Virtqueues}.
> >>>>
> >>>> +\item[\field{freeze_mode}]
> >>>> +        The driver writes this to set the freeze mode of virtio pci=
.
> >>>> +        VIRTIO_PCI_FREEZE_MODE_UNFREEZE - virtio-pci is running;
> >>>> +        VIRTIO_PCI_FREEZE_MODE_FREEZE_S3 - guest vm is doing S3, an=
d virtio-pci enters S3 suspension;
> >>>> +        Other values are reserved for future use, like S4, etc.
> >>>> +
> >>>>  \item[\field{queue_notif_config_data}]
> >>>>          This field exists only if VIRTIO_F_NOTIF_CONFIG_DATA has be=
en negotiated.
> >>>>          The driver will use this value when driver sends available =
buffer
> >>>> --
> >>>> 2.34.1
> >>>>
> >>>
> >>>
> >>> ---------------------------------------------------------------------
> >>> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> >>> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> >>>
> >>
> >> --
> >> Best regards,
> >> Jiqian Chen.
> >
>
> --
> Best regards,
> Jiqian Chen.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

