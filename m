Return-Path: <virtio-dev-return-11289-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E096FC64EC7
	for <virtio-dev@archiver.kernel.org>; Sat, 25 Feb 2023 22:59:46 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 478E842A69
	for <virtio-dev@archiver.kernel.org>; Sat, 25 Feb 2023 22:59:46 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 40ED298678F
	for <virtio-dev@archiver.kernel.org>; Sat, 25 Feb 2023 22:59:46 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 35D9498413F; Sat, 25 Feb 2023 22:59:46 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2273D9866B0
	for <virtio-dev@lists.oasis-open.org>; Sat, 25 Feb 2023 22:59:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: R-CRHGsSOFSaIJ_q0hVQ6g-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2h+sRhUJ3p4jQktnbj11wy4eh/zrJNzb5zXhOQoGFs4=;
        b=Fh6fSDd0nsnfuXbDetXg2BUv+wDaxL1rf9Jn4x2uxyHasHcro4baOyCKxuDY/X2DDo
         FTV4wqre9lfJGOZ4VHWDCjTMDfirYxzSSwAzeZKNgEpxRo/Zrw5U8Em8VnEq955Fkzp3
         nO+8DpFjBPNrkDcLXNf+QUwjCerwc9Rf2b3/3N3KuVUSpGSEZAOEobh2DXJ0LuWkZvz9
         Uuo/x2Rm4V0gG6xGR7pxoaU8Gk4OSUjzNCzlmFKANCgEs1zs7REU7cP1Nqw65olpmhvD
         8tYEgLsjkJqAiX0V1WyEt6C4Mp1KDjotVhY0a7LWkZ0hxTqN+TXcfAkCdFOBBEokid7g
         gacw==
X-Gm-Message-State: AO0yUKXjnj2vnyoDl237CIP/7SE6c7dWwJhSIJboFCkIP/zGiU2DNSmp
	Pn7A4Wlmmhpi4T5xRpBuR3rihiSr8XhopZFRZsJsZ1KY5kF+BujKKcJ4ejQ42YmdPUT3KgeOvgL
	WHpUTbV0lBftKSabk3OA4rZ1Iuo5E
X-Received: by 2002:a05:600c:502b:b0:3ea:e7e7:95da with SMTP id n43-20020a05600c502b00b003eae7e795damr7629076wmr.8.1677365982667;
        Sat, 25 Feb 2023 14:59:42 -0800 (PST)
X-Google-Smtp-Source: AK7set8qnNy38LM9l6kS1IFkUZ8VNHORczSd0ygGup3RMUhnmBKTfG2X96PB0TWCkL5cNVQwkvyaJQ==
X-Received: by 2002:a05:600c:502b:b0:3ea:e7e7:95da with SMTP id n43-20020a05600c502b00b003eae7e795damr7629064wmr.8.1677365982307;
        Sat, 25 Feb 2023 14:59:42 -0800 (PST)
Date: Sat, 25 Feb 2023 17:59:39 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: virtio-dev@lists.oasis-open.org, cohuck@redhat.com,
	virtio-comment@lists.oasis-open.org, shahafs@nvidia.com
Message-ID: <20230225175847-mutt-send-email-mst@kernel.org>
References: <20230225220636.429990-1-parav@nvidia.com>
 <20230225220636.429990-3-parav@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230225220636.429990-3-parav@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v1 2/2] transport-pci: Move transitional device id to
 legacy section
Message-ID: <20230225225939.ulyrMjAEWy_LjOEiYzzpaRJN3az1bSlxSjTPrvV21t8@z>

On Sun, Feb 26, 2023 at 12:06:36AM +0200, Parav Pandit wrote:
> Currently PCI device requirements section contains mix of normative
> statements for for regular (non transitional) device and
> transitional device under one section.
> 
> Some requirements of the transitional device are also located in
> legacy interface section which is the right section for it.
> 
> Hence,
> 1. Move transitional device requirements to their designated Legacy
>    interface section
> 2. Describe regular device requirements without quoting it as "non
>    transitional device"
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

nack I already answered this. legacy sections describe
legacy interface of transitional devices.

> ---
> changelog:
> v0->v1:
> - rebased to lowercase device id notation
> - added missing '.'
> ---
>  transport-pci.tex | 74 ++++++++++++++++++++++++-----------------------
>  1 file changed, 38 insertions(+), 36 deletions(-)
> 
> diff --git a/transport-pci.tex b/transport-pci.tex
> index 9f9f076..5d22e6f 100644
> --- a/transport-pci.tex
> +++ b/transport-pci.tex
> @@ -24,50 +24,28 @@ \subsection{PCI Device Discovery}\label{sec:Virtio Transport Options / Virtio Ov
>  The PCI Device ID is calculated by adding 0x1040 to the Virtio Device ID,
>  as indicated in section \ref{sec:Device Types}.
>  Additionally, devices MAY utilize a Transitional PCI Device ID range,
> -0x1000 to 0x103F depending on the device type.
> +0x1000 to 0x103f depending on the device type.
>  
>  \devicenormative{\subsubsection}{PCI Device Discovery}{Virtio Transport Options / Virtio Over PCI Bus / PCI Device Discovery}
>  
> -Devices MUST have the PCI Vendor ID 0x1af4.
> -Devices MUST either have the PCI Device ID calculated by adding 0x1040
> +The device MUST have the PCI Vendor ID 0x1af4.
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
> +Types}.
>  
>  For example, the network device with the Virtio Device ID 1
> -has the PCI Device ID 0x1041 or the Transitional PCI Device ID 0x1000.
> -
> -The PCI Subsystem Vendor ID and the PCI Subsystem Device ID MAY reflect
> -the PCI Vendor and Device ID of the environment (for informational purposes by the driver).
> +has the PCI Device ID 0x1041.
>  
> -Non-transitional devices SHOULD have a PCI Device ID in the range
> -0x1040 to 0x107f.
> -Non-transitional devices SHOULD have a PCI Revision ID of 1 or higher.
> -Non-transitional devices SHOULD have a PCI Subsystem Device ID of 0x40 or higher.
> +The device SHOULD have a PCI Device ID in the range 0x1040 to 0x107f.
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
>  Drivers MUST match devices with the PCI Vendor ID 0x1af4 and
>  the PCI Device ID in the range 0x1040 to 0x107f,
> @@ -85,11 +63,35 @@ \subsection{PCI Device Discovery}\label{sec:Virtio Transport Options / Virtio Ov
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
> -the range 0x1000 to 0x103F.
> +the range 0x1000 to 0x103f.
>  
>  This is to match legacy drivers.
>  
> -- 
> 2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

