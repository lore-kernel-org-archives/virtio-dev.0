Return-Path: <virtio-dev-return-13766-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDF67EDE9A8
	for <virtio-dev@archiver.kernel.org>; Thu, 14 Sep 2023 11:35:26 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 528762AEE4
	for <virtio-dev@archiver.kernel.org>; Thu, 14 Sep 2023 11:35:26 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 22851986641
	for <virtio-dev@archiver.kernel.org>; Thu, 14 Sep 2023 11:35:26 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 06A3C986640; Thu, 14 Sep 2023 11:35:26 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 083C3986639
	for <virtio-dev@lists.oasis-open.org>; Thu, 14 Sep 2023 11:34:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: h6kNeSVzOKOnucg7yzCNVg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694691280; x=1695296080;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=roQQWJGP+CjOh4y3bJO70yqtkdteVlr7qjV+gxLBPfA=;
        b=HIxm8HXjaegFGwegzJLpk08DZM/fv+xkdIeSDtR38fAfAiBMGAyhGVIFif0QNFjeS8
         XZM4yarb3T7MCBPh4gjrJH31zDBtxK2/QFRc9UQI4H69yUe+RRW2ysaXcPgDDZyZ0dEK
         SPZNM/CxoKl0lnkYO7F4KFdzbH/TZWCWxhEH2MuvxMR2FN7MpbBd7kciYymeY67hBiS8
         4MtJRNs1/Gs1n6YU29BuhFmDWTTV+88exRu4nLl7CS0soQ2AfqkCaUMGzImpCpeO1xVf
         IHFgTd84OTDXRrMZen1jPYiTV5YHWfl0HRtBOcBso5eRgdFrg0yPtNUkjMxu2YUnugvl
         3/hQ==
X-Gm-Message-State: AOJu0YwZJ7JEIndKgtvL2ko6d0VATgKfVfTS7Fo+Xcikdiafhbiua3fJ
	ZZ5pC6lw3Qu7B/YuL1Cm2OlGwJaIr3UUxtn9epv9oTfuVNGXsyT3VVKQpFzr4UC5quaXoU/qdbV
	3Qu73XHtHlLx1qk0FDoGH7I4nkopyfajzhR1R
X-Received: by 2002:a17:906:53c5:b0:9a2:2842:f1c6 with SMTP id p5-20020a17090653c500b009a22842f1c6mr4246064ejo.28.1694691280316;
        Thu, 14 Sep 2023 04:34:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxGjcSg2xordJch72pu67Ol5RvNtPgyEdGRKBUex6yYa6U76xNGFSPk98vZYP5fiTlP9My6Q==
X-Received: by 2002:a17:906:53c5:b0:9a2:2842:f1c6 with SMTP id p5-20020a17090653c500b009a22842f1c6mr4246053ejo.28.1694691279957;
        Thu, 14 Sep 2023 04:34:39 -0700 (PDT)
Date: Thu, 14 Sep 2023 07:34:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Zhu Lingshan <lingshan.zhu@intel.com>
Cc: jasowang@redhat.com, eperezma@redhat.com, cohuck@redhat.com,
	stefanha@redhat.com, virtio-comment@lists.oasis-open.org,
	virtio-dev@lists.oasis-open.org
Message-ID: <20230914073023-mutt-send-email-mst@kernel.org>
References: <20230906081637.32185-1-lingshan.zhu@intel.com>
 <20230906081637.32185-3-lingshan.zhu@intel.com>
MIME-Version: 1.0
In-Reply-To: <20230906081637.32185-3-lingshan.zhu@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [PATCH 2/5] virtio: introduce SUSPEND bit in device status

On Wed, Sep 06, 2023 at 04:16:34PM +0800, Zhu Lingshan wrote:
> This patch introduces a new status bit in the device status: SUSPEND.
> 
> This SUSPEND bit can be used by the driver to suspend a device,
> in order to stabilize the device states and virtqueue states.
> 
> Its main use case is live migration.
> 
> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
> ---
>  content.tex | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/content.tex b/content.tex
> index 0e492cd..0fab537 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -47,6 +47,9 @@ \section{\field{Device Status} Field}\label{sec:Basic Facilities of a Virtio Dev
>  \item[DRIVER_OK (4)] Indicates that the driver is set up and ready to
>    drive the device.
>  
> +\item[SUSPEND (16)] When VIRTIO_F_SUSPEND is negotiated, indicates that the
> +  device has been suspended by the driver.
> +
>  \item[DEVICE_NEEDS_RESET (64)] Indicates that the device has experienced
>    an error from which it can't recover.
>  \end{description}
> @@ -73,6 +76,10 @@ \section{\field{Device Status} Field}\label{sec:Basic Facilities of a Virtio Dev
>  recover by issuing a reset.
>  \end{note}
>  
> +The driver SHOULD NOT set SUSPEND if FEATURES_OK is not set.
> +
> +When setting SUSPEND, the driver MUST re-read \field{device status} to ensure the SUSPEND bit is set.
> +
>  \devicenormative{\subsection}{Device Status Field}{Basic Facilities of a Virtio Device / Device Status Field}
>  
>  The device MUST NOT consume buffers or send any used buffer
> @@ -82,6 +89,26 @@ \section{\field{Device Status} Field}\label{sec:Basic Facilities of a Virtio Dev
>  that a reset is needed.  If DRIVER_OK is set, after it sets DEVICE_NEEDS_RESET, the device
>  MUST send a device configuration change notification to the driver.
>  
> +The device MUST ignore SUSPEND if FEATURES_OK is not set.
> +
> +The device MUST ignore SUSPEND if VIRTIO_F_SUSPEND is not negotiated.

why? let's just forbid driver from setting it.

> +
> +The device SHOULD allow settings to \field{device status} even when SUSPEND is set.
> +
> +If VIRTIO_F_SUSPEND is negotiated and SUSPEND is set, the device SHOULD clear SUSPEND
> +and resumes operation upon DRIVER_OK.
> +

sorry what?

> +If VIRTIO_F_SUSPEND is negotiated, when the driver sets SUSPEND,
> +the device SHOULD perform the following actions before presenting SUSPEND bit in the \field{device status}:
> +
> +\begin{itemize}
> +\item Stop consuming buffers of any virtqueues and mark all finished descritors as used.
> +\item Wait until all descriptors that being processed to finish and mark them as used.
> +\item Flush all used buffer and send used buffer notifications to the driver.

flush how?

> +\item Record Virtqueue State of each enabled virtqueue, see section \ref{sec:Virtqueues / Virtqueue State}


record where?

> +\item Pause its operation except \field{device status} and preserve configurations in its Device Configuration Space, see \ref{sec:Basic Facilities of a Virtio Device / Device Configuration Space}

pause in what sense? completely?  this does not seem realistic.
e.g. pci express link has to stay active or device will die.


also, presumably here it is except a bunch of other fields.
e.g. what about queue select and all related queue fields?


> +\end{itemize}
> +
>  \section{Feature Bits}\label{sec:Basic Facilities of a Virtio Device / Feature Bits}
>  
>  Each virtio device offers all the features it understands.  During
> @@ -937,6 +964,10 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
>  	\ref{devicenormative:Basic Facilities of a Virtio Device / Feature Bits} for
>  	handling features reserved for future use.
>  
> +  \item[VIRTIO_F_SUSPEND(42)] This feature indicates that the driver can
> +   SUSPEND the device.
> +   See \ref{sec:Basic Facilities of a Virtio Device / Device Status Field}.
> +
>  \end{description}
>  
>  \drivernormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}
> -- 
> 2.35.3


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

