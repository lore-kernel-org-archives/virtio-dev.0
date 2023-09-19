Return-Path: <virtio-dev-return-13836-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B6BBCD5BA9
	for <virtio-dev@archiver.kernel.org>; Tue, 19 Sep 2023 12:31:24 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id C13DE2236E
	for <virtio-dev@archiver.kernel.org>; Tue, 19 Sep 2023 12:31:23 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B5942986560
	for <virtio-dev@archiver.kernel.org>; Tue, 19 Sep 2023 12:31:23 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id AB0349864C2; Tue, 19 Sep 2023 12:31:23 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9DA79986503
	for <virtio-dev@lists.oasis-open.org>; Tue, 19 Sep 2023 12:31:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: c7rwQiSVN8OQkhk3Hfsg5Q-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695126677; x=1695731477;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=foEuGHpN02cZZRHgVG6c0QInXgm/KQsAjoIQJjUhPEM=;
        b=mc7KUT2M4O45SpbsV2mtPLgAAUAZ/waPEUaAs9JwqUtLS88vG657e2vUHE78DH13S3
         4RcOtCrQSAIEXGJWa8HDWeK17m7gyu8Cn2QQcVs6qLodjDlRhRLA5YnapIJmux/EOnjw
         s2AZB+ynGeeMkcQe6KmJ41rXa44pavYNI3fbEovA55KHzYnCmJZ48/6bBlc1RXbQL3yU
         MxgM5HGKifFiacf7+59j+micsdLxb120HiLEwS6GoTn8E0ry9YDcS9x+6nwm28cDObGX
         SSSdKVxNH1X5eMuT6Ph6JISClywK8KTt+ZwDoD9qdOiWS9p8ij7tm3x48LfH3+/29lFS
         YvSw==
X-Gm-Message-State: AOJu0Ywt1DHNkZiyZ5AIqduOdiXutpajuahgQ4Gc2EATmdIfdtf+fbs7
	Xn/BK6YBMQu/N1X0264MirPBGqHGrDEuFYPNQlNjIrqewibla6BdJUeFtoVuiaE6sxg4iFTC9sm
	e8j3vymhh0Ilk7eaf4VnDBS6aA/zg
X-Received: by 2002:a17:907:7622:b0:9a1:e994:3444 with SMTP id jy2-20020a170907762200b009a1e9943444mr9781235ejc.3.1695126677426;
        Tue, 19 Sep 2023 05:31:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEb3B61aTdbbapBWgqBDzul7TRECZ9JfP3c02/1NZo6uc1VdIFZ3t0h1Xm1oeTneoLXE2/ODQ==
X-Received: by 2002:a17:907:7622:b0:9a1:e994:3444 with SMTP id jy2-20020a170907762200b009a1e9943444mr9781216ejc.3.1695126677126;
        Tue, 19 Sep 2023 05:31:17 -0700 (PDT)
Date: Tue, 19 Sep 2023 08:31:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiqian Chen <Jiqian.Chen@amd.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	David Airlie <airlied@redhat.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	=?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>,
	Robert Beckett <bob.beckett@collabora.com>,
	Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com>,
	Parav Pandit <parav@nvidia.com>,
	virtio-comment@lists.oasis-open.org,
	virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org,
	linux-kernel@vger.kernel.org,
	Stefano Stabellini <sstabellini@kernel.org>,
	Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>,
	Alex Deucher <Alexander.Deucher@amd.com>,
	Christian Koenig <Christian.Koenig@amd.com>,
	Stewart Hildebrand <Stewart.Hildebrand@amd.com>,
	Xenia Ragiadakou <burzalodowa@gmail.com>,
	Honglei Huang <Honglei1.Huang@amd.com>,
	Julia Zhang <Julia.Zhang@amd.com>, Huang Rui <Ray.Huang@amd.com>
Message-ID: <20230919082802-mutt-send-email-mst@kernel.org>
References: <20230919114242.2283646-1-Jiqian.Chen@amd.com>
 <20230919114242.2283646-2-Jiqian.Chen@amd.com>
MIME-Version: 1.0
In-Reply-To: <20230919114242.2283646-2-Jiqian.Chen@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [VIRTIO PCI PATCH v5 1/1] transport-pci: Add freeze_mode to
 virtio_pci_common_cfg

On Tue, Sep 19, 2023 at 07:42:42PM +0800, Jiqian Chen wrote:
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
> @@ -319,6 +319,7 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
>          le64 queue_desc;                /* read-write */
>          le64 queue_driver;              /* read-write */
>          le64 queue_device;              /* read-write */
> +        le16 freeze_mode;               /* read-write */
>          le16 queue_notif_config_data;   /* read-only for driver */
>          le16 queue_reset;               /* read-write */
>

we can't add fields in the middle of the structure like this -
offset of queue_notif_config_data and queue_reset changes.

  
> @@ -393,6 +394,12 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
>  \item[\field{queue_device}]
>          The driver writes the physical address of Device Area here.  See section \ref{sec:Basic Facilities of a Virtio Device / Virtqueues}.
>  
> +\item[\field{freeze_mode}]
> +        The driver writes this to set the freeze mode of virtio pci.
> +        VIRTIO_PCI_FREEZE_MODE_UNFREEZE - virtio-pci is running;
> +        VIRTIO_PCI_FREEZE_MODE_FREEZE_S3 - guest vm is doing S3, and virtio-pci enters S3 suspension;
> +        Other values are reserved for future use, like S4, etc.
> +

we need to specify these values then.

we also need
- feature bit to detect support for S3
- conformance statements documenting behavious under S3


>  \item[\field{queue_notif_config_data}]
>          This field exists only if VIRTIO_F_NOTIF_CONFIG_DATA has been negotiated.
>          The driver will use this value when driver sends available buffer
> -- 
> 2.34.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

