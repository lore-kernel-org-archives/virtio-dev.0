Return-Path: <virtio-dev-return-13932-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E6A7E7D0C2
	for <virtio-dev@archiver.kernel.org>; Fri, 22 Sep 2023 03:17:52 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 0288C2B01F
	for <virtio-dev@archiver.kernel.org>; Fri, 22 Sep 2023 03:17:52 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DC39A9866AB
	for <virtio-dev@archiver.kernel.org>; Fri, 22 Sep 2023 03:17:51 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id BD5549864C1; Fri, 22 Sep 2023 03:17:51 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id ABB9C98669E
	for <virtio-dev@lists.oasis-open.org>; Fri, 22 Sep 2023 03:17:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: UT_o6bQ7NA2x7u2KKIBXVQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695352668; x=1695957468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VKRFydK7gHJIGc1An0jO34UIyrf6X6QxSb8Wda3PFS4=;
        b=PPC1FGylsNECdZ97C9tu8K4Kb0YmOvWq9aw5P4jzAw5MUPNyMg9FVQP6zmrtSs3Syt
         WzDtQwZlEKDsrFpNqM+dRoXSG/TD1GnOcwpLFDUw2ZHdF76DSI41sAmO9r1EsMaVMA0f
         YD+jB0PgA93Hi4Yt7cl0zkeYp/XxQcpboCxnSJJVUsWjKY0BXHOGNTaTmAR5fP1lkWjC
         tgofkksUGxt8oDeLCWQNUycLdaxBBZ7bLyp4xNdtyV3deTE8gmzXWI6wQwQJCFxKEzjG
         Q5nNdiSZ4tzqMzaCC3b5YwwSSRlr8dduGfz3dcTRWBM2NiHYDitoLe8NLhF5BdYheGzy
         FpqA==
X-Gm-Message-State: AOJu0YxkNTs1e4imIZJy8YlQXczJQMGU4sjoEJBR5B4+w9h5W/oIGmTK
	tEv38JjmXuYx4yfpt1dljhGLUUw03n6LIpm4feTE05ald4AQo+bTAyDnBwrxqUA5f79EEt9V5pT
	BdXqiCF4H/5m+dSPIyM5dsdqAXMymmD5N9NjbzHDHkOTi
X-Received: by 2002:a05:6512:b21:b0:503:3278:3221 with SMTP id w33-20020a0565120b2100b0050332783221mr7377460lfu.69.1695352667962;
        Thu, 21 Sep 2023 20:17:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6jLFAWQobQu7YJsr0/J9NeK5RMThuSKcfHKr41/y/dxVLwUK0Y97f/SS/vWZNDHC+0xxpwdioFz9c/eyEV7A=
X-Received: by 2002:a05:6512:b21:b0:503:3278:3221 with SMTP id
 w33-20020a0565120b2100b0050332783221mr7377433lfu.69.1695352667519; Thu, 21
 Sep 2023 20:17:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230919114242.2283646-1-Jiqian.Chen@amd.com> <20230919114242.2283646-2-Jiqian.Chen@amd.com>
 <CACGkMEuEXk2UzXU7sFUk-nHEeE7QoB3kbjnHgktY7KWuK71Xrg@mail.gmail.com> <BL1PR12MB58490A484087B2B2C37B6E43E7F8A@BL1PR12MB5849.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB58490A484087B2B2C37B6E43E7F8A@BL1PR12MB5849.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 22 Sep 2023 11:17:35 +0800
Message-ID: <CACGkMEtx-i_9dgdONFzEmmWYNRhaoJQZX7a5OmLfDvGoUaajPQ@mail.gmail.com>
To: "Chen, Jiqian" <Jiqian.Chen@amd.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, David Airlie <airlied@redhat.com>, 
	Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>, 
	=?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, 
	Robert Beckett <bob.beckett@collabora.com>, 
	Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com>, Parav Pandit <parav@nvidia.com>, 
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, 
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, 
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Stefano Stabellini <sstabellini@kernel.org>, 
	=?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>, 
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

On Thu, Sep 21, 2023 at 2:28=E2=80=AFPM Chen, Jiqian <Jiqian.Chen@amd.com> =
wrote:
>
> Hi Jason,
>
> On 2023/9/21 12:22, Jason Wang wrote:
> > On Tue, Sep 19, 2023 at 7:43=E2=80=AFPM Jiqian Chen <Jiqian.Chen@amd.co=
m> wrote:
> >>
> >> When guest vm does S3, Qemu will reset and clear some things of virtio
> >> devices, but guest can't aware that, so that may cause some problems.
> >> For excample, Qemu calls virtio_reset->virtio_gpu_gl_reset when guest
> >> resume, that function will destroy render resources of virtio-gpu. As
> >> a result, after guest resume, the display can't come back and we only
> >> saw a black screen. Due to guest can't re-create all the resources, so
> >> we need to let Qemu not to destroy them when S3.
> >>
> >> For above purpose, we need a mechanism that allows guests and QEMU to
> >> negotiate their reset behavior. So this patch add a new parameter
> >> named freeze_mode to struct virtio_pci_common_cfg. And when guest
> >> suspends, it can write freeze_mode to be FREEZE_S3, and then virtio
> >> devices can change their reset behavior on Qemu side according to
> >> freeze_mode. What's more, freeze_mode can be used for all virtio
> >> devices to affect the behavior of Qemu, not just virtio gpu device.
> >
> > A simple question, why is this issue specific to pci?
> I thought you possibly missed the previous version patches. At the beginn=
ing, I just wanted to add a new feature flag VIRTIO_GPU_F_FREEZE_S3 for vir=
tio-gpu since I encountered virtio-gpu issue during guest S3, so that the g=
uest and qemu can negotiate and change the reset behavior during S3. But Pa=
rav and Mikhail hoped me can improve the feature to a pci level, then other=
 virtio devices can also benefit from it. Although I am not sure if expandi=
ng its influence is appropriate, I have not received any feedback from othe=
rs, so I change it to the pci level and made this version.
> If you are interested, please see the previous version: https://lists.oas=
is-open.org/archives/virtio-comment/202307/msg00209.html, thank you.

This is not a good answer. Let me ask you differently, why don't you
see it in other forms of transport like virtio-gpu-mmio?

Thanks

>
> >
> > Thanks
> >
> >
> >>
> >> Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
> >> ---
> >>  transport-pci.tex | 7 +++++++
> >>  1 file changed, 7 insertions(+)
> >>
> >> diff --git a/transport-pci.tex b/transport-pci.tex
> >> index a5c6719..2543536 100644
> >> --- a/transport-pci.tex
> >> +++ b/transport-pci.tex
> >> @@ -319,6 +319,7 @@ \subsubsection{Common configuration structure layo=
ut}\label{sec:Virtio Transport
> >>          le64 queue_desc;                /* read-write */
> >>          le64 queue_driver;              /* read-write */
> >>          le64 queue_device;              /* read-write */
> >> +        le16 freeze_mode;               /* read-write */
> >>          le16 queue_notif_config_data;   /* read-only for driver */
> >>          le16 queue_reset;               /* read-write */
> >>
> >> @@ -393,6 +394,12 @@ \subsubsection{Common configuration structure lay=
out}\label{sec:Virtio Transport
> >>  \item[\field{queue_device}]
> >>          The driver writes the physical address of Device Area here.  =
See section \ref{sec:Basic Facilities of a Virtio Device / Virtqueues}.
> >>
> >> +\item[\field{freeze_mode}]
> >> +        The driver writes this to set the freeze mode of virtio pci.
> >> +        VIRTIO_PCI_FREEZE_MODE_UNFREEZE - virtio-pci is running;
> >> +        VIRTIO_PCI_FREEZE_MODE_FREEZE_S3 - guest vm is doing S3, and =
virtio-pci enters S3 suspension;
> >> +        Other values are reserved for future use, like S4, etc.
> >> +
> >>  \item[\field{queue_notif_config_data}]
> >>          This field exists only if VIRTIO_F_NOTIF_CONFIG_DATA has been=
 negotiated.
> >>          The driver will use this value when driver sends available bu=
ffer
> >> --
> >> 2.34.1
> >>
> >
> >
> > ---------------------------------------------------------------------
> > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> >
>
> --
> Best regards,
> Jiqian Chen.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

