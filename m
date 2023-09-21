Return-Path: <virtio-dev-return-13904-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD5E1CD494B
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 04:23:10 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 0E3AA33580
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 04:23:10 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 01AE9986687
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 04:23:10 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id E8E7C983D6F; Thu, 21 Sep 2023 04:23:09 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D9B1C98667C
	for <virtio-dev@lists.oasis-open.org>; Thu, 21 Sep 2023 04:23:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: OHN1guZ_OFWkWU0qCJGLxA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695270186; x=1695874986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a/TUqywb80X2AZJMzYZES4VoyIivqwNd2hjQ6BBMthY=;
        b=S90c4IarEV9TNii0VGqjsmRt6r358b01iNGwNPSB3C8eS0aESPvZ5RzaET5SXSZkqQ
         OYiBeT3XsxCvdoNZLKZiq2tO8Zkd1cnrNNFnqT3U0EuUg1JxxoPpy7fTU/YyWugf+eUm
         8W6ft8hvALBkVTBwzHvpLScmYTiukixySrfMm9XrbugkbdT906p1i4Th/Wb1A6H9wcrN
         0irGSwToI+pDBuHLzOJGJiBGC8CtnX3Ax8K0lP4gZ/16DN5XNPENT4JuYZMeE8VbxO2T
         u/MaiCeDe70ySxA49bmv2ANCIh9AwBuK0vp1I5ad+da4NWI9EeOblHb7btDZPB4vMBVd
         jGwQ==
X-Gm-Message-State: AOJu0YzvSm/IzH+qWiD+QDD1VLopqsYzDqpPzp9Dqy0qoz8x+sG6OR7b
	DVXCGifFUA/fepNyN4pbCejbYoLsvNKMfYiyoDJIPgcguyRq4mN/kzE7GwzPvX3XVJmLgLNaewM
	pM4HUkyjQ0GBbUs/XhAIL+sDd3MjfaHa1jAGJwv54oaf9
X-Received: by 2002:a05:6512:20c7:b0:500:7696:200 with SMTP id u7-20020a05651220c700b0050076960200mr3691369lfr.59.1695270185948;
        Wed, 20 Sep 2023 21:23:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBGVyyX13pZa+3Ktq9xbUVd38RjeljW6H0syjIQrHGw1bASMEAYrUUNaIJURxjwOkNsl2CINr8g7Gw+zy70OM=
X-Received: by 2002:a05:6512:20c7:b0:500:7696:200 with SMTP id
 u7-20020a05651220c700b0050076960200mr3691353lfr.59.1695270185578; Wed, 20 Sep
 2023 21:23:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230919114242.2283646-1-Jiqian.Chen@amd.com> <20230919114242.2283646-2-Jiqian.Chen@amd.com>
In-Reply-To: <20230919114242.2283646-2-Jiqian.Chen@amd.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 21 Sep 2023 12:22:54 +0800
Message-ID: <CACGkMEuEXk2UzXU7sFUk-nHEeE7QoB3kbjnHgktY7KWuK71Xrg@mail.gmail.com>
To: Jiqian Chen <Jiqian.Chen@amd.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, David Airlie <airlied@redhat.com>, 
	Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>, 
	=?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, 
	Robert Beckett <bob.beckett@collabora.com>, 
	Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com>, Parav Pandit <parav@nvidia.com>, 
	virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, 
	qemu-devel@nongnu.org, linux-kernel@vger.kernel.org, 
	Stefano Stabellini <sstabellini@kernel.org>, =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>, 
	Alex Deucher <Alexander.Deucher@amd.com>, Christian Koenig <Christian.Koenig@amd.com>, 
	Stewart Hildebrand <Stewart.Hildebrand@amd.com>, Xenia Ragiadakou <burzalodowa@gmail.com>, 
	Honglei Huang <Honglei1.Huang@amd.com>, Julia Zhang <Julia.Zhang@amd.com>, 
	Huang Rui <Ray.Huang@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [VIRTIO PCI PATCH v5 1/1] transport-pci: Add freeze_mode to virtio_pci_common_cfg

On Tue, Sep 19, 2023 at 7:43=E2=80=AFPM Jiqian Chen <Jiqian.Chen@amd.com> w=
rote:
>
> When guest vm does S3, Qemu will reset and clear some things of virtio
> devices, but guest can't aware that, so that may cause some problems.
> For excample, Qemu calls virtio_reset->virtio_gpu_gl_reset when guest
> resume, that function will destroy render resources of virtio-gpu. As
> a result, after guest resume, the display can't come back and we only
> saw a black screen. Due to guest can't re-create all the resources, so
> we need to let Qemu not to destroy them when S3.
>
> For above purpose, we need a mechanism that allows guests and QEMU to
> negotiate their reset behavior. So this patch add a new parameter
> named freeze_mode to struct virtio_pci_common_cfg. And when guest
> suspends, it can write freeze_mode to be FREEZE_S3, and then virtio
> devices can change their reset behavior on Qemu side according to
> freeze_mode. What's more, freeze_mode can be used for all virtio
> devices to affect the behavior of Qemu, not just virtio gpu device.

A simple question, why is this issue specific to pci?

Thanks


>
> Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
> ---
>  transport-pci.tex | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/transport-pci.tex b/transport-pci.tex
> index a5c6719..2543536 100644
> --- a/transport-pci.tex
> +++ b/transport-pci.tex
> @@ -319,6 +319,7 @@ \subsubsection{Common configuration structure layout}=
\label{sec:Virtio Transport
>          le64 queue_desc;                /* read-write */
>          le64 queue_driver;              /* read-write */
>          le64 queue_device;              /* read-write */
> +        le16 freeze_mode;               /* read-write */
>          le16 queue_notif_config_data;   /* read-only for driver */
>          le16 queue_reset;               /* read-write */
>
> @@ -393,6 +394,12 @@ \subsubsection{Common configuration structure layout=
}\label{sec:Virtio Transport
>  \item[\field{queue_device}]
>          The driver writes the physical address of Device Area here.  See=
 section \ref{sec:Basic Facilities of a Virtio Device / Virtqueues}.
>
> +\item[\field{freeze_mode}]
> +        The driver writes this to set the freeze mode of virtio pci.
> +        VIRTIO_PCI_FREEZE_MODE_UNFREEZE - virtio-pci is running;
> +        VIRTIO_PCI_FREEZE_MODE_FREEZE_S3 - guest vm is doing S3, and vir=
tio-pci enters S3 suspension;
> +        Other values are reserved for future use, like S4, etc.
> +
>  \item[\field{queue_notif_config_data}]
>          This field exists only if VIRTIO_F_NOTIF_CONFIG_DATA has been ne=
gotiated.
>          The driver will use this value when driver sends available buffe=
r
> --
> 2.34.1
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

