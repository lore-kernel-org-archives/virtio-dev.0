Return-Path: <virtio-dev-return-12054-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3781CC6FD1D
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Apr 2023 09:17:29 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 5EA792B142
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Apr 2023 09:17:28 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 44CB69865DE
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Apr 2023 09:17:28 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 2F587983F7B; Fri,  7 Apr 2023 09:17:28 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1FC029865D7
	for <virtio-dev@lists.oasis-open.org>; Fri,  7 Apr 2023 09:17:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: dT2DLIuLOreY-S9vVaPH_Q-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680859044;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gWiuFC1C7I6AehfZZEVipgn+kSzLGTWf1hml4xNu5oo=;
        b=dU05xVr/VBlzHFu3vD77iqIzd0PuxKmfZA9SfDh3cGdOCqpPRgJr8LZWAUOnwydHbD
         TmGsdFaTTQvRk2H/YOVrJ48fodRm8631vlceYnf2DuTVdTFh/w0TcRIfyNZzqBu9woVV
         K3KaDm9usXOeJO7bCrd2SDQlqzHyiJp0byz2sXFJOyI6D77oPqNRthy4kmmg5CtQKygp
         rkc7oxk60gYar+miCo6w1ETK64rIS7MVBWfjlC1/qixOVBTy4Uidd2XmhDj6g536uzCj
         R/090iYCp+PU5FMgBR5BQCfx3pV/rWkY67W9rW4SGZ7XcvuEWOu7WOgJwa9140kDDFrY
         uVZQ==
X-Gm-Message-State: AAQBX9ey/gB/anfp6d+zykONqf/YBt1qWF6faE+u3wXJiVl1E5Wy36ox
	FODoswQ4SlS6++eMw2JKAUFkxHVPFwYH9qMpP3ut7Kra7oK/NRqXPfvSGRdO8HNKMNhtTQQjte2
	ufGFFZnfqAOuyC3lyxl03UjOsD7Qw
X-Received: by 2002:a5d:6a82:0:b0:2ce:a758:d6fb with SMTP id s2-20020a5d6a82000000b002cea758d6fbmr1065718wru.1.1680859044259;
        Fri, 07 Apr 2023 02:17:24 -0700 (PDT)
X-Google-Smtp-Source: AKy350YSXRD7z5Oh5UJYdXAV4merOcc4WDVqsEX5DbQqsRaIdkwB/qynJwhVftQEmkyQmxsKo3E/LA==
X-Received: by 2002:a5d:6a82:0:b0:2ce:a758:d6fb with SMTP id s2-20020a5d6a82000000b002cea758d6fbmr1065702wru.1.1680859043937;
        Fri, 07 Apr 2023 02:17:23 -0700 (PDT)
Date: Fri, 7 Apr 2023 05:17:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: virtio-dev@lists.oasis-open.org, cohuck@redhat.com,
	virtio-comment@lists.oasis-open.org, shahafs@nvidia.com,
	Satananda Burla <sburla@marvell.com>
Message-ID: <20230407045541-mutt-send-email-mst@kernel.org>
References: <20230330225834.506969-1-parav@nvidia.com>
 <20230330225834.506969-7-parav@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230330225834.506969-7-parav@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [PATCH 06/11] introduction: Introduce transitional MMR interface

On Fri, Mar 31, 2023 at 01:58:29AM +0300, Parav Pandit wrote:
> Introduce terminology for the transitional MMR device and transitional
> MMR driver.
> 
> Add description of the transitional MMR device. It is a PCI
> device that implements legacy virtio common configuration registers
> followed by legacy device specific registers in a memory region at
> an offset.
> 
> This enables hypervisor such as vfio driver to emulate
> I/O region towards the guest at BAR0. By doing so VFIO driver can
> translate read/write accesses on I/O region from the guest
> to the device memory region.
> 
> High level comparison of 1.x, transitional & transitional MMR
> sriov vf device:
> 
> +------------------+ +--------------------+ +--------------------+
> |virtio 1.x        | |Transitional        | |Transitional        |
> |SRIOV VF          | |SRIOV VF            | |MMR SRIOV VF        |
> |                  | |                    | |                    |
> ++---------------+ | ++---------------+   | ++---------------+   |
> ||dev_id =       | | ||dev_id =       |   | ||dev_id =       |   |
> ||{0x1040-0x106C}| | ||{0x1000-0x103f}|   | ||{0x10f9-0x10ff}|   |
> |+---------------+ | |+---------------+   | |+---------------+   |
> |                  | |                    | |                    |
> |+------------+    | |+------------+      | |+-----------------+ |
> ||Memory BAR  |    | ||Memory BAR  |      | ||Memory BAR       | |
> |+------------+    | |+------------+      | ||                 | |
> |                  | |                    | || +--------------+| |
> |                  | |+-----------------+ | || |legacy virtio || |
> |                  | ||IOBAR impossible | | || |+ dev cfg     || |
> |                  | |+-----------------+ | || |registers     || |
> |                  | |                    | || +--------------+| |
> |                  | |                    | |+-----------------+ |
> +------------------+ +--------------------+ +--------------------+
> 
> Motivation and background:
> PCIe and system limitations:
> 1. PCIe VFs do not support IOBAR cited at [1].
> 
> Perhaps the PCIe spec could be extended, however it would be only
> useful for virtio transitional devices. Even if such an extension
> is present, there are other system limitations described below in (2)
> and (3).
> 
> 2. cpu io port space limit and fragmentation
> x86_64 is limited to only 64K worth of IO port space at [2],
> which is shared with many other onboard system peripherals which
> are behind PCIe bridge; such I/O region also needs to be aligned
> to 4KB at PCIe bridge level cited at [3]. This can lead to a I/O space
> fragmentation. Due to this fragmentation and alignment need,
> actual usable range is small.
> 
> 3. IO space access of PCI device is done through non-posted message
>  which requires higher completion time in the PCIe fabric for
> round trip travel.
> 
> [1] PCIe spec citation:
> VFs do not support I/O Space and thus VF BARs shall not indicate I/O Space.
> 
> [2] cpu arch citiation:
> Intel 64 and IA-32 Architectures Software Developer’s Manual
> The processor’s I/O address space is separate and distinct from
> the physical-memory address space. The I/O address space consists
> of 64K individually addressable 8-bit I/O ports, numbered 0 through FFFFH.
> 
> [3] PCIe spec citation:
> If a bridge implements an I/O address range,...I/O address range
> will be aligned to a 4 KB boundary.
> 
> Co-developed-by: Satananda Burla <sburla@marvell.com>
> Signed-off-by: Parav Pandit <parav@nvidia.com>
> ---
>  introduction.tex | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/introduction.tex b/introduction.tex
> index e8b34e3..9a0f96a 100644
> --- a/introduction.tex
> +++ b/introduction.tex
> @@ -161,6 +161,20 @@ \subsection{Legacy Interface: Terminology}\label{intro:Legacy
>    have a need for backwards compatibility!
>  \end{note}
>  
> +\begin{description}
> +\item[Transitional MMR Device]
> +       is a PCI device which exposes legacy virtio configuration
> +       registers followed by legacy device configuration registers as
> +       memory mapped registers (MMR) at an offset in a memory region
> +       BAR, has no I/O region BAR,

in fact, most of existing pci interface can be in either IO or memory bar,
I don't think we specify that it's in a memory bar in the spec.
For example IIRC qemu has a flag that uses IO for signalling
kicks for modern VQs, this is slightly faster on some architectures.


> having its own PCI Device ID range,
> +       and follows the rest of the functionalities


this setence isn't grammatical.
not sure what exactly you are trying to say here, can not
help you rewrite.

> of the transitional device.

a transitional device probably.

> +\end{description}
> +
> +\begin{description}
> +\item[Transitional MMR Driver]
> +       is a PCI device driver that supports the Transitional MMR device.
> +\end{description}
> +
>  Devices or drivers with no legacy compatibility are referred to as
>  non-transitional devices and drivers, respectively.
>  
> @@ -174,6 +188,22 @@ \subsection{Transition from earlier specification drafts}\label{sec:Transition f
>  sections tagged "Legacy Interface" in the section title.
>  These highlight the changes made since the earlier drafts.
>  
> +\subsection{Transitional MMR interface: specification drafts}\label{sec:Transitional MMR interface: specification drafts}
> +
> +The transitional MMR device and driver differs from the
> +transitional device and driver respectively in few areas. Such

a few

> +differences are contained in sections named
> +'Transitional MMR interface', like this one. When no differences
> +are mentioned explicitly, the transitional MMR device and driver
> +follow exactly the same functionalities as that of the
> +transitional device and driver respectively.

Ugh, we called these transitional because they were there for
the transition period :)

The thing that I feel you miss here is that
transitional driver using transitional device MUST NOT
use the legacy interface.

The new thing with this MMR is that it's a memory mapped
access to legacy registers.


Going back to my idea of just adding legacy MMR capability to existing
modern and transitional devices, as opposed to a completely new type of
device, we would basically have a modern driver access the new
capability, and forward accesses from a legacy driver to there.
So "memory mapped legacy interface" would be a better name I think.




> +
> +\begin{note}
> +Transitional MMR interface is only required to support backward
> +compatibility. It should not be implemented unless there is a need
> +for the backward compatibility.
> +\end{note}
> +
>  \section{Structure Specifications}\label{sec:Structure Specifications}
>  
>  Many device and driver in-memory structure layouts are documented using
> -- 
> 2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

