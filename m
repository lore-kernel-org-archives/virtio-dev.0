Return-Path: <virtio-dev-return-12053-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A505C6FD1D
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Apr 2023 08:55:15 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 238D23357F
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Apr 2023 08:55:14 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AC7C8986734
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Apr 2023 08:55:13 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 88D2E986629; Fri,  7 Apr 2023 08:55:13 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5311B9865DA
	for <virtio-dev@lists.oasis-open.org>; Fri,  7 Apr 2023 08:55:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 997TW6gxONC852BX6LjyFg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680857709;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RDl1fy8Ssbq7j9jecG5eGwcWQdgvPh1uxwatLNEkgss=;
        b=XTFuM8nkTt97Q+gPGlSLVA9K6pjIHwmMwzqTGxEfBdJAuRxOJhPUr4ZWy2MytIugAs
         HUv8CfoF7LN+Kr5IvBjblUF5eoWv5GDdJ+Nx0QSQ5voPHdPCAEauLakY2B2K2qFJuiTp
         5Wp+uPN1pFEHuqyfHlPuve7wCdZWcribaBnh023ykDZUHzyEBjOePteNMJu7ihfT4XY/
         ayv8tiWelKuivZaybRs9CP9/bLW3YMY0F1w5vJSpHdwxW+hy92nVq4uZV7isOr8M2n3z
         DqXU2xhm47m4EU+wolV/VHaFeEI6AIsIIqxtqB398SvuSqtuty+ARWXNB3wLSPFxn2cv
         UJCw==
X-Gm-Message-State: AAQBX9fWnI0djUnYRvNC6NHP8XFLimNmHAd8+E23N6M/isUOcRlvTGq7
	4q2vFXkVvsMUA3vK96JUZo9nKiPwtbHsCYRgjVAgD1BvhcUgNYeHaKDybKcVOFaHRIWqXptIsaK
	T9cZ7dxJskrf4UugP5CO6bK0gYDFH
X-Received: by 2002:a5d:4885:0:b0:2ef:b4ac:8e5 with SMTP id g5-20020a5d4885000000b002efb4ac08e5mr135313wrq.28.1680857709700;
        Fri, 07 Apr 2023 01:55:09 -0700 (PDT)
X-Google-Smtp-Source: AKy350Zsuv5fe+T1x/adBKgURa37WGjOY6WdayiinaOjhOiKHtR8k5d6M3E8LFCc3lAs0fimG/vNAA==
X-Received: by 2002:a5d:4885:0:b0:2ef:b4ac:8e5 with SMTP id g5-20020a5d4885000000b002efb4ac08e5mr135299wrq.28.1680857709366;
        Fri, 07 Apr 2023 01:55:09 -0700 (PDT)
Date: Fri, 7 Apr 2023 04:55:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: virtio-dev@lists.oasis-open.org, cohuck@redhat.com,
	virtio-comment@lists.oasis-open.org, shahafs@nvidia.com,
	Satananda Burla <sburla@marvell.com>
Message-ID: <20230407043841-mutt-send-email-mst@kernel.org>
References: <20230330225834.506969-1-parav@nvidia.com>
 <20230330225834.506969-10-parav@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230330225834.506969-10-parav@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH 09/11] transport-pci: Describe PCI MMR dev config
 registers

On Fri, Mar 31, 2023 at 01:58:32AM +0300, Parav Pandit wrote:
> Legacy virtio configuration registers and adjacent
> device configuration registers are located somewhere
> in a memory BAR.
> 
> A new capability supplies the location of these registers
> which a driver can use to map I/O access to legacy
> memory mapped registers.
> 
> This gives the ability to locate legacy registers in either
> the existing memory BAR or as completely new BAR at BAR 0.
> 
> A below example diagram attempts to depicts it in an existing
> memory BAR.
> 
> +------------------------------+
> |Transitional                  |
> |MMR SRIOV VF                  |
> |                              |
> ++---------------+             |
> ||dev_id =       |             |
> ||{0x10f9-0x10ff}|             |
> |+---------------+             |
> |                              |
> ++--------------------+        |
> || PCIe ext cap = 0xB |        |
> || cfg_type = 10      |        |
> || offset   = 0x1000  |        |
> || bar      = A {0..5}|        |
> |+--|-----------------+        |
> |   |                          |
> |   |                          |
> |   |    +-------------------+ |
> |   |    | Memory BAR = A    | |
> |   |    |                   | |
> |   +------>+--------------+ | |
> |        |  |legacy virtio | | |
> |        |  |+ dev cfg     | | |
> |        |  |registers     | | |
> |        |  +--------------+ | |
> |        +-----------------+ | |
> +------------------------------+
> 
> Co-developed-by: Satananda Burla <sburla@marvell.com>
> Signed-off-by: Parav Pandit <parav@nvidia.com>


I am split about using the extended capability for this, since in
practice this makes for more code in hypervisors.  How about just using
an existing capability as opposed to the extended capability? Less work
for existing hypervisors, no? And let's begin to use the extended
capability for something more important than legacy access.




> ---
>  transport-pci.tex | 33 +++++++++++++++++++++++++++++++--
>  1 file changed, 31 insertions(+), 2 deletions(-)
> 
> diff --git a/transport-pci.tex b/transport-pci.tex
> index aeda4a1..55a6aa0 100644
> --- a/transport-pci.tex
> +++ b/transport-pci.tex
> @@ -168,6 +168,7 @@ \subsection{Virtio Structure PCI Capabilities}\label{sec:Virtio Transport Option
>  \item ISR Status
>  \item Device-specific configuration (optional)
>  \item PCI configuration access
> +\item Legacy memory mapped configuration registers (optional)
>  \end{itemize}
>  
>  Each structure can be mapped by a Base Address register (BAR) belonging to
> @@ -228,6 +229,8 @@ \subsection{Virtio Structure PCI Capabilities}\label{sec:Virtio Transport Option
>  #define VIRTIO_PCI_CAP_SHARED_MEMORY_CFG 8
>  /* Vendor-specific data */
>  #define VIRTIO_PCI_CAP_VENDOR_CFG        9
> +/* Legacy configuration registers capability */
> +#define VIRTIO_PCI_CAP_LEGACY_MMR_CFG    10
>  \end{lstlisting}
>  
>          Any other value is reserved for future use.
> @@ -682,6 +685,18 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
>  Configuration Space / Legacy Interface: Device Configuration
>  Space}~\nameref{sec:Basic Facilities of a Virtio Device / Device Configuration Space / Legacy Interface: Device Configuration Space} for workarounds.
>  
> +\paragraph{Transitional MMR Interface: A Note on Configuration Registers}
> +\label{sec:Virtio Transport Options / Virtio Over PCI Bus / Virtio Structure PCI Capabilities / Common configuration structure layout / Transitional MMR Interface: A Note on Configuration Registers}
> +
> +The transitional MMR device MUST present legacy virtio registers
> +consisting of legacy common configuration registers followed by
> +legacy device specific configuration registers described in section
> +\ref{sec:Virtio Transport Options / Virtio Over PCI Bus / Virtio Structure PCI Capabilities / Common configuration structure layout / Legacy Interfaces: A Note on Configuration Registers}
> +in a memory region PCI BAR.
> +
> +The transitional MMR device MUST provide the location of the
> +legacy virtio configuration registers using a legacy memory mapped
> +registers capability described in section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / Virtio Structure PCI Capabilities / Transitional MMR Interface: Legacy Memory Mapped Configuration Registers Capability}.
>  
>  \subsubsection{Notification structure layout}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Notification capability}
>  
> @@ -956,9 +971,23 @@ \subsubsection{PCI configuration access capability}\label{sec:Virtio Transport O
>  specified by some other Virtio Structure PCI Capability
>  of type other than \field{VIRTIO_PCI_CAP_PCI_CFG}.
>  
> +\subsubsection{Transitional MMR Interface: Legacy Memory Mapped Configuration Registers Capability}
> +\label{sec:Virtio Transport Options / Virtio Over PCI Bus / Virtio Structure PCI Capabilities / Transitional MMR Interface: Legacy Memory Mapped Configuration Registers Capability}
> +
> +The optional VIRTIO_PCI_CAP_LEGACY_MMR_CFG capability defines
> +the location of the legacy virtio configuration registers
> +followed by legacy device specific configuration registers in
> +the memory region BAR for the transitional MMR device.
> +
> +The \field{cap.offset} MUST be 4-byte aligned.
> +The \field{cap.offset} SHOULD be 4KBytes aligned and

what's the point of this?

> +\field{cap.length} SHOULD be 4KBytes.

Why is length 4KBytes? Why not the actual length?


> +
> +The transitional MMR device MUST present a legacy configuration
> +memory mapped registers capability using \field{virtio_pcie_ext_cap}.
> +
>  \subsubsection{Legacy Interface: A Note on Feature Bits}
> -\label{sec:Virtio Transport Options / Virtio Over PCI Bus /
> -Virtio Structure PCI Capabilities / Legacy Interface: A Note on Feature Bits}
> +\label{sec:Virtio Transport Options / Virtio Over PCI Bus / Virtio Structure PCI Capabilities / Legacy Interface: A Note on Feature Bits}
>


So it is not by chance that we abadoned the legacy interface,
it had some fundamental issues.
Let me list some off the top of my mind:
- no atomicity across accesses, so if a register changes
  while it is read driver gets trash. solved using generation id
- no defined endian-ness. solved using le
- no way to reject driver configuration

we just did a new thing instead, but I feel if you are reviving the
legacy interface yet again, it is worth thinking about solving the worst
of the warts. For example, I can see an endian-ness register that
hypervisor can either read to check device is compatible with guest, or
maybe even write to force device to specific endian-ness.
A generation counter that hypervisor can check to
verify value is consistent? Can work if hypervisor
caches configuration.
A bad state flag that device can set to make hypervisor
stop guest? Better than corrupting it ...



  
>  Only Feature Bits 0 to 31 are accessible through the
>  Legacy Interface. When used through the Legacy Interface,
> -- 
> 2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

