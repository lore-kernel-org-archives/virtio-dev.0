Return-Path: <virtio-dev-return-13526-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C528EC001DB
	for <virtio-dev@archiver.kernel.org>; Tue, 15 Aug 2023 00:26:54 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id E47F22B014
	for <virtio-dev@archiver.kernel.org>; Tue, 15 Aug 2023 00:26:53 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B6B579863B2
	for <virtio-dev@archiver.kernel.org>; Tue, 15 Aug 2023 00:26:53 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 99087983C28; Tue, 15 Aug 2023 00:26:53 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7E26698633F
	for <virtio-dev@lists.oasis-open.org>; Tue, 15 Aug 2023 00:26:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: kMsrCgE_OiK6a_X8qLCbDg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692059209; x=1692664009;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j3Wi+j0slIr+zbwfw2qSE/SSyT7XHZ0bWHuKPipFt8E=;
        b=IeuPvF705GMgtzaWTAmqzXCgewPk4l1vDvXzXDHD5VfZ8EENuqxGAfe6/n5R7aYKQ2
         XpTaipQm/fOzKtx+gopgEb0n3L6lVlBRi33FTuXzWnDb/Nik/0F1KqlkinyiWu/fDYdR
         HHHXucTogEfd9HyPEhaOelA5gsWDtHjigNG+bfFf1mm1WLTCV8b+7sE8kmQNpncxon8L
         HAcWjFMotaEo2Kjdj0RRqO2D07oWvNepYPLv1Vmj1zaME8C3PPkBOeiitstY/C0guFxE
         dsfSGA5NoftfGhbX9xevNqa+RdedBHPQ5hsRzJyNo2E6EDMk3bQKy6wU8TCJpB7vIOHg
         l1DA==
X-Gm-Message-State: AOJu0YxyfiSOaG3FJIUldIaR7Nrek33pmoODgtXZZgNaCGKBvM3uiAtx
	ZO0x+swes0lweZWk1lJpB59lekgNVWtaT7tsbb3MoT1KfFJdkuHRnuoz6bkTyyIhPan7SN8UJRK
	6+sThcEXIchSm4ZuzS8Hv82b6LyM712dQOjG69CJxbVAf
X-Received: by 2002:a2e:2404:0:b0:2b9:f1ad:9503 with SMTP id k4-20020a2e2404000000b002b9f1ad9503mr7200720ljk.35.1692059209621;
        Mon, 14 Aug 2023 17:26:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH50RKmtyZ7OjEFFplf3IEsWJD5ihuO9/oAEu9QrHDydBHpwZXDtq9Cq5trvmfxah8qy6STG+goh/Q/o2z1BVY=
X-Received: by 2002:a2e:2404:0:b0:2b9:f1ad:9503 with SMTP id
 k4-20020a2e2404000000b002b9f1ad9503mr7200715ljk.35.1692059209260; Mon, 14 Aug
 2023 17:26:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230814192904.30062-1-lingshan.zhu@intel.com> <20230814192904.30062-2-lingshan.zhu@intel.com>
In-Reply-To: <20230814192904.30062-2-lingshan.zhu@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 15 Aug 2023 08:26:38 +0800
Message-ID: <CACGkMEvmYqKTk1Hveo96oKYw4hbEDJD2x5Ye3_nkeBTH0rcMMw@mail.gmail.com>
To: Zhu Lingshan <lingshan.zhu@intel.com>
Cc: mst@redhat.com, eperezma@redhat.com, cohuck@redhat.com, 
	virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [RFC PATCH 1/5] virtio: introduce SUSPEND bit in device status

On Mon, Aug 14, 2023 at 7:29=E2=80=AFPM Zhu Lingshan <lingshan.zhu@intel.co=
m> wrote:
>
> This patch introudces a new status bit in the device status: SUSPEND.
>
> This SUSPEND bit can be used by the driver to suspend a device,
> in order to stablize the device states and virtqueue states.
>
> Its main use case is live migration.

I think patch 3 needs to be squashed into this one.

>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Eugenio P=C3=83rez <eperezma@redhat.com>
> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> ---
>  content.tex | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/content.tex b/content.tex
> index 0a62dce..1bb4401 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -47,6 +47,9 @@ \section{\field{Device Status} Field}\label{sec:Basic F=
acilities of a Virtio Dev
>  \item[DRIVER_OK (4)] Indicates that the driver is set up and ready to
>    drive the device.
>
> +\item[SUSPEND (16)] When VIRTIO_F_SUSPEND is negotiated, indicates that =
the
> +  device has been suspended by the driver.
> +
>  \item[DEVICE_NEEDS_RESET (64)] Indicates that the device has experienced
>    an error from which it can't recover.
>  \end{description}
> @@ -73,6 +76,10 @@ \section{\field{Device Status} Field}\label{sec:Basic =
Facilities of a Virtio Dev
>  recover by issuing a reset.
>  \end{note}
>
> +The driver MUST NOT set SUSPEND if FEATURES_OK is not set.
> +
> +When set SUSPEND, the driver MUST re-read \field{device status} to ensur=
e the SUSPEND bit is set.
> +
>  \devicenormative{\subsection}{Device Status Field}{Basic Facilities of a=
 Virtio Device / Device Status Field}
>
>  The device MUST NOT consume buffers or send any used buffer
> @@ -82,6 +89,13 @@ \section{\field{Device Status} Field}\label{sec:Basic =
Facilities of a Virtio Dev
>  that a reset is needed.  If DRIVER_OK is set, after it sets DEVICE_NEEDS=
_RESET, the device
>  MUST send a device configuration change notification to the driver.
>
> +The device MUST ignore SUSPEND if FEATURES_OK is not set.

Is there any value to allow SUSPEND to be set without DRIVER_OK?

> +
> +The deivce MUST ignore SUSPEND if VIRTIO_F_SUSPEND is not negotiated.

typo.

Thanks

> +
> +If VIRTIO_F_SUSPEND is negotiated and SUSPEND is set, the device MUST cl=
ear SUSPEND
> +and resumes operation upon DRIVER_OK.
> +
>  \section{Feature Bits}\label{sec:Basic Facilities of a Virtio Device / F=
eature Bits}
>
>  Each virtio device offers all the features it understands.  During
> @@ -872,6 +886,10 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved F=
eature Bits}
>         \ref{devicenormative:Basic Facilities of a Virtio Device / Featur=
e Bits} for
>         handling features reserved for future use.
>
> +  \item[VIRTIO_F_SUSPEND(41)] This feature indicates that the driver can
> +   SUSPEND the device.
> +   See \ref{sec:Basic Facilities of a Virtio Device / Device Status Fiel=
d}.
> +
>  \end{description}
>
>  \drivernormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}
> --
> 2.35.3
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

