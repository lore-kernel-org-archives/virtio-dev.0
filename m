Return-Path: <virtio-dev-return-11277-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEFB0C6FA8E
	for <virtio-dev@archiver.kernel.org>; Sat, 25 Feb 2023 17:26:55 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id C80832B046
	for <virtio-dev@archiver.kernel.org>; Sat, 25 Feb 2023 17:26:54 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AB39A98678A
	for <virtio-dev@archiver.kernel.org>; Sat, 25 Feb 2023 17:26:54 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 966D79866A9; Sat, 25 Feb 2023 17:26:54 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 84B44986784
	for <virtio-dev@lists.oasis-open.org>; Sat, 25 Feb 2023 17:26:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 76f0ocOXOKKhuPqid2jxIQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2oojSJWoXapCXnijFXxtfKvkqke3TAFh4kgUKnZddYo=;
        b=kk+onDs/fuCdxWR1ducviCsbXc00MZJ1yAroS1Axh7+oDGBKoDYy7aa6zmrFx3CevN
         yFZlz94kL6J1CXCHMAoGVVxlPVHOFAn2n7zOqHREwHtXj0Akod7Ea0vulQwEkCXlZw0n
         4d19tALzY6sF/awygJ/vRqyhx+RCeG5hjpmS0EuHIowRsDeXgU+crnH68URUEbeaev43
         Tz3xi+0ZEYxdFf88xYgMpwsyMr119RPrstbQ5zymv86l0zVsoLCpoSuKZXWbk22ChYxk
         u5JBa0jrLJeMWCXKjD1I22ZI93yyGt0VwnzapyixA4xDpRNfqWx1QB+F7HmBJwS7QxIS
         ySzg==
X-Gm-Message-State: AO0yUKVSrFrll3SCp9ZuYUPayaPDYCz2l3b9DzgkZmXc1VbyFB7WB9bx
	EAUcp+qw+nIHqiM1/lz80659r3Y7QnHDiUHHobzpclvNuwmV4tnuoAAacp1KqCyNMmIbn57Tn81
	BcbMkYV6mTKe82MtHJ6FLJmcdKaRG
X-Received: by 2002:a5d:4b03:0:b0:2c9:3f36:73e3 with SMTP id v3-20020a5d4b03000000b002c93f3673e3mr2038466wrq.17.1677346009837;
        Sat, 25 Feb 2023 09:26:49 -0800 (PST)
X-Google-Smtp-Source: AK7set+srnbVA6ijln/Mw/nKCrAaIZpr6O6woikD1mdLumdFOzSVNpm67BvsrGIjsZOo1pHXQVk3mA==
X-Received: by 2002:a5d:4b03:0:b0:2c9:3f36:73e3 with SMTP id v3-20020a5d4b03000000b002c93f3673e3mr2038456wrq.17.1677346009470;
        Sat, 25 Feb 2023 09:26:49 -0800 (PST)
Date: Sat, 25 Feb 2023 12:26:45 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: virtio-dev@lists.oasis-open.org, cohuck@redhat.com,
	virtio-comment@lists.oasis-open.org, shahafs@nvidia.com
Message-ID: <20230225121237-mutt-send-email-mst@kernel.org>
References: <20230224231232.340814-1-parav@nvidia.com>
 <20230224231232.340814-3-parav@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230224231232.340814-3-parav@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH 2/2] transport-pci: Move transitional device id to legacy
 section
Message-ID: <20230225172645.UK9QDehvK-8KIkiFaptrQlCvgZe9gBGL-cEpasTf3A4@z>

On Sat, Feb 25, 2023 at 01:12:32AM +0200, Parav Pandit wrote:
> Currently PCI device requirements section contains mix of normative
> statements for for regular (non transitional) device and
> transitional device under one section.
> 
> Some requirements of the transitional device are also located in
> legacy interface section which is the right section for it.

> Hence,
> 1. Move transitional device requirements to their designated Legacy
>    interface section
> 2. Describe regular device requirements without quoting it as "non
>    transitional device"

I do not think this is the way to go.

Spec covers the functioning of modern devices and
the transitional devices when operated by modern drivers.
The text that covers using modern interfaces belongs in the regular
section.

Legacy devices and drivers are covered in separate legacy sections which are
non-normative (not because they have to, but simply because writing
normative sections for legacy devices would be extra effort).

Take this example. Modern drivers ignore revision, but transitional ones
need to have 0 because this is what legacy drivers expect.
Reporting 0 in revision this belongs in legacy section.

> 
> While at it, write the description using a singular object definition.
> 
> This is only an editorial change.
> 
> This patch is on top of [1].
> 
> [1] https://lists.oasis-open.org/archives/virtio-dev/202302/msg00578.html
> 
> Signed-off-by: Parav Pandit <parav@nvidia.com>
> ---
>  transport-pci.tex | 70 ++++++++++++++++++++++++-----------------------
>  1 file changed, 36 insertions(+), 34 deletions(-)
> 
> diff --git a/transport-pci.tex b/transport-pci.tex
> index e271d51..9686cc8 100644
> --- a/transport-pci.tex
> +++ b/transport-pci.tex
> @@ -28,46 +28,24 @@ \subsection{PCI Device Discovery}\label{sec:Virtio Transport Options / Virtio Ov
>  
>  \devicenormative{\subsubsection}{PCI Device Discovery}{Virtio Transport Options / Virtio Over PCI Bus / PCI Device Discovery}
>  
> -Devices MUST have the PCI Vendor ID 0x1AF4.
> -Devices MUST either have the PCI Device ID calculated by adding 0x1040
> +The device MUST have the PCI Vendor ID 0x1AF4.
> +The device MUST calculate PCI Device ID by adding 0x1040
>  to the Virtio Device ID, as indicated in section \ref{sec:Device
> -Types} or have the Transitional PCI Device ID depending on the device type,
> -as follows:
> -
> -\begin{tabular}{|l|c|}
> -\hline
> -Transitional PCI Device ID  &  Virtio Device    \\
> -\hline \hline
> -0x1000      &   network device     \\
> -\hline
> -0x1001     &   block device     \\
> -\hline
> -0x1002     & memory ballooning (traditional)  \\
> -\hline
> -0x1003     &      console       \\
> -\hline
> -0x1004     &     SCSI host      \\
> -\hline
> -0x1005     &  entropy source    \\
> -\hline
> -0x1009     &   9P transport     \\
> -\hline
> -\end{tabular}
> +Types}
>  
>  For example, the network device with the Virtio Device ID 1
> -has the PCI Device ID 0x1041 or the Transitional PCI Device ID 0x1000.
> -
> -The PCI Subsystem Vendor ID and the PCI Subsystem Device ID MAY reflect
> -the PCI Vendor and Device ID of the environment (for informational purposes by the driver).
> +has the PCI Device ID 0x1041.
>  
> -Non-transitional devices SHOULD have a PCI Device ID in the range
> -0x1040 to 0x107F.
> -Non-transitional devices SHOULD have a PCI Revision ID of 1 or higher.
> -Non-transitional devices SHOULD have a PCI Subsystem Device ID of 0x40 or higher.
> +The device SHOULD have a PCI Device ID in the range 0x1040 to 0x107F.
> +The device SHOULD have a PCI Revision ID of 1 or higher.
> +The device SHOULD have a PCI Subsystem Device ID of 0x40 or higher.
>  
>  This is to reduce the chance of a legacy driver attempting
>  to drive the device.
>  
> +The PCI Subsystem Vendor ID and the PCI Subsystem Device ID MAY reflect
> +the PCI Vendor and Device ID of the environment (for informational purposes by the driver).
> +
>  \drivernormative{\subsubsection}{PCI Device Discovery}{Virtio Transport Options / Virtio Over PCI Bus / PCI Device Discovery}
>  Drivers MUST match devices with the PCI Vendor ID 0x1AF4 and
>  the PCI Device ID in the range 0x1040 to 0x107F,
> @@ -85,8 +63,32 @@ \subsection{PCI Device Discovery}\label{sec:Virtio Transport Options / Virtio Ov
>  PCI Subsystem Device ID value.
>  
>  \subsubsection{Legacy Interfaces: A Note on PCI Device Discovery}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Discovery / Legacy Interfaces: A Note on PCI Device Discovery}
> -Transitional devices MUST have a PCI Revision ID of 0.
> -Transitional devices MUST have the PCI Subsystem Device ID
> +
> +The transitional device has one of the following PCI Device ID
> +depending on the device type:
> +
> +\begin{tabular}{|l|c|}
> +\hline
> +Transitional PCI Device ID  &  Virtio Device    \\
> +\hline \hline
> +0x1000      &   network device     \\
> +\hline
> +0x1001     &   block device     \\
> +\hline
> +0x1002     & memory ballooning (traditional)  \\
> +\hline
> +0x1003     &      console       \\
> +\hline
> +0x1004     &     SCSI host      \\
> +\hline
> +0x1005     &  entropy source    \\
> +\hline
> +0x1009     &   9P transport     \\
> +\hline
> +\end{tabular}
> +
> +The transitional device MUST have a PCI Revision ID of 0.
> +The transitional device MUST have the PCI Subsystem Device ID
>  matching the Virtio Device ID, as indicated in section \ref{sec:Device Types}.
>  Transitional devices MUST have the Transitional PCI Device ID in
>  the range 0x1000 to 0x103F.
> -- 
> 2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

