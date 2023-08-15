Return-Path: <virtio-dev-return-13529-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9220CC001DB
	for <virtio-dev@archiver.kernel.org>; Tue, 15 Aug 2023 00:35:40 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id A30CA71CB6
	for <virtio-dev@archiver.kernel.org>; Tue, 15 Aug 2023 00:35:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DD2269866EC
	for <virtio-dev@archiver.kernel.org>; Tue, 15 Aug 2023 00:35:33 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id D0F4A9863FA; Tue, 15 Aug 2023 00:35:33 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BAB85986371
	for <virtio-dev@lists.oasis-open.org>; Tue, 15 Aug 2023 00:35:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: nbfCq5EbNvOTObKtghgBsQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692059717; x=1692664517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u0vaDuEVUIjlj6UOtXtTItR2rsgTMIiTlrPleYbnPSk=;
        b=aCv5oppasIT/Gfe7v1kou0EpGjAEnpgwwfo9c9svtJ1z9lN/O2MzWjbgMETxlBZ44D
         UDJvo/Hw7NQFcm79asoof75Gwkvt6wPe+Gpi/PTSlPnxPtdo+igT7BciQPqLfB+gB2zO
         ruGMab6WdpblkYzrc+d2RiFd9xkh82QKpbvS3mgSDrF/RHupLwjsZHXIKGbAPuFwYq81
         /pW3itWo7uWpiKcaKL6gVJusL3QOGNy0XH2UY8uUm5jaNC3ucUQt1iOJR61a1l4/kOwL
         qolCL6rloKxPnR9tN1tC+LIyTr8hLShARH1C4buSCdoV9p8gI4802pTan8U9TKl/CeuZ
         NSqQ==
X-Gm-Message-State: AOJu0Yw50h8Z35gL91xC1MwEqW4SI80SeZnHnyFm4hlgowXkJMN51iqj
	6dj7BMlpmBsFiDKF7nbJGPZHaAf2lM51XWFljT4Tpqv9Uhtf8ZSag5fm3PS8UlVW+ZPZCiMqorP
	u1t9rwod3V1K/krWaq45oKAR4nx08DV97NEHz6quZEcTA
X-Received: by 2002:a2e:9a90:0:b0:2b6:df71:cff1 with SMTP id p16-20020a2e9a90000000b002b6df71cff1mr7795248lji.52.1692059717373;
        Mon, 14 Aug 2023 17:35:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOACkFTRnoaWV5zTq8piXeyteWkVb7+B/oNyn9pt+gV8YWyYKYtvG9/KH+Ee+aDoD7l8RYr95IlPwr35Xzn3o=
X-Received: by 2002:a2e:9a90:0:b0:2b6:df71:cff1 with SMTP id
 p16-20020a2e9a90000000b002b6df71cff1mr7795241lji.52.1692059717208; Mon, 14
 Aug 2023 17:35:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230814192904.30062-1-lingshan.zhu@intel.com> <20230814192904.30062-6-lingshan.zhu@intel.com>
In-Reply-To: <20230814192904.30062-6-lingshan.zhu@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 15 Aug 2023 08:35:05 +0800
Message-ID: <CACGkMEsHvg8W_UA_nn-UdU7rAEgxseSSC9tBoaF__-AS6a-1BA@mail.gmail.com>
To: Zhu Lingshan <lingshan.zhu@intel.com>
Cc: mst@redhat.com, eperezma@redhat.com, cohuck@redhat.com, 
	virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [RFC PATCH 5/5] virtio-pci: implement VIRTIO_F_QUEUE_STATE

On Mon, Aug 14, 2023 at 7:29=E2=80=AFPM Zhu Lingshan <lingshan.zhu@intel.co=
m> wrote:
>
> This patch adds two new le16 fields to common configruation structure
> to support VIRTIO_F_QUEUE_STATE in PCI tranport layer.
>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> ---
>  transport-pci.tex | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/transport-pci.tex b/transport-pci.tex
> index a5c6719..d9bccb0 100644
> --- a/transport-pci.tex
> +++ b/transport-pci.tex
> @@ -321,6 +321,8 @@ \subsubsection{Common configuration structure layout}=
\label{sec:Virtio Transport
>          le64 queue_device;              /* read-write */
>          le16 queue_notif_config_data;   /* read-only for driver */
>          le16 queue_reset;               /* read-write */
> +        le16 queue_avail_state;         /* read-write */
> +        le16 queue_used_state;          /* read-write */

Those need to be placed at the end of this structure at least or we
need a dedicated new capability.

>
>          /* About the administration virtqueue. */
>          le16 admin_queue_index;         /* read-only for driver */
> @@ -415,6 +417,16 @@ \subsubsection{Common configuration structure layout=
}\label{sec:Virtio Transport
>          This field exists only if VIRTIO_F_RING_RESET has been
>          negotiated. (see \ref{sec:Basic Facilities of a Virtio Device / =
Virtqueues / Virtqueue Reset}).
>
> +\item[\field{queue_avail_state}]
> +        This field is vaild only if VIRTIO_F_QUEUE_STATE has been
> +        negotiated. The driver sets and gets the available state of
> +        the virtqueue here (see \ref{sec:Virtqueues / Virtqueue State}).
> +
> +\item[\field{queue_used_state}]
> +        This field is vaild only if VIRTIO_F_QUEUE_STATE has been
> +        negotiated. The driver sets and gets the used state of the
> +        virtqueue here (see \ref{sec:Virtqueues / Virtqueue State}).
> +
>  \item[\field{admin_queue_index}]
>          The device uses this to report the index of the first administra=
tion virtqueue.
>          This field is valid only if VIRTIO_F_ADMIN_VQ has been negotiate=
d.
> @@ -488,6 +500,9 @@ \subsubsection{Common configuration structure layout}=
\label{sec:Virtio Transport
>  present either a value of 0 or a power of 2 in
>  \field{queue_size}.
>
> +If VIRTIO_F_QUEUE_STATE has not been negotiated, the device MUST ignore
> +any accesses against \field{queue_avail_state} and \field{queue_used_sta=
te}.
> +
>  If VIRTIO_F_ADMIN_VQ has been negotiated, the value
>  \field{admin_queue_index} MUST be equal to, or bigger than
>  \field{num_queues}; also, \field{admin_queue_num} MUST be
> --
> 2.35.3
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

