Return-Path: <virtio-dev-return-12168-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F570C77B73
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Apr 2023 04:33:41 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id AC9753DF4A
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Apr 2023 04:33:40 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9BA589865F0
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Apr 2023 04:33:40 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 88F979864B3; Wed, 12 Apr 2023 04:33:40 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 38ADB98650E
	for <virtio-dev@lists.oasis-open.org>; Wed, 12 Apr 2023 04:33:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: G7N0hu7oMy6FsCA1UQKtoQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681274014;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=crWmLPbSbRjaifsablsWW6T90zI8HnIkumgE0f1te6o=;
        b=1qSZc75Z5O2gRBM+fsLIHNggy63dB8Uy7OQXa1kTGsA6lQrocuq1wqHfeNWaNdHPD2
         Q+dh7upVIkPTq3+4prbbL+S/LKfLEnRCo8FJmepxfQuhpf2z+PhlpLDQh3ougmsHCc6B
         ezpwyjcd8mSOXmhsVFMYnkNTRI3u6RvnUMy+luzpimKDQ7jL42W5yEbfqxcKwsFF/mHc
         q6UjRKHNPDudRxYKC3xywgta4HCnh4lxbL1wmXpeQyqPAO3ZJ2CZHkz/6tHRf0InqoTe
         CD+3FQjOG4pLfyxyaXIP/x5f1SbD3LRB5eJs0DiBy67LYTMyJEs0pkDcwNPcH3bhn6yo
         CkPg==
X-Gm-Message-State: AAQBX9dsGZGZu9PMtE12lWHcKrbr4FHADtHVIgCic6RFMuhuZs9Rp2Kb
	dQJM8XoZX4jWkm4+OVYQZYsR1yNOAmHWYfdYO1SlZoaIbvVotjOKejI/8qHF9zxy5wUGa/2CVnD
	sD1fmk8u011hEeqv9ZPLnEZNhx11s
X-Received: by 2002:a1c:f310:0:b0:3ee:282d:1016 with SMTP id q16-20020a1cf310000000b003ee282d1016mr10825162wmq.25.1681274014376;
        Tue, 11 Apr 2023 21:33:34 -0700 (PDT)
X-Google-Smtp-Source: AKy350aTqtTbJ8SNxQq9u7uHWoIvQT3MWsDWzOycMKRaczyej0NBmHErT86pINtjX2z34/jCBKqgPA==
X-Received: by 2002:a1c:f310:0:b0:3ee:282d:1016 with SMTP id q16-20020a1cf310000000b003ee282d1016mr10825147wmq.25.1681274014051;
        Tue, 11 Apr 2023 21:33:34 -0700 (PDT)
Date: Wed, 12 Apr 2023 00:33:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: virtio-dev@lists.oasis-open.org, cohuck@redhat.com,
	virtio-comment@lists.oasis-open.org, shahafs@nvidia.com,
	Satananda Burla <sburla@marvell.com>
Message-ID: <20230412003135-mutt-send-email-mst@kernel.org>
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


So considering common legacy registers. How exactly is INT#x
handled? It's required for old guests since they fail over to that
when MSI-X fails for some reason.




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
> +\field{cap.length} SHOULD be 4KBytes.
> +
> +The transitional MMR device MUST present a legacy configuration
> +memory mapped registers capability using \field{virtio_pcie_ext_cap}.
> +
>  \subsubsection{Legacy Interface: A Note on Feature Bits}
> -\label{sec:Virtio Transport Options / Virtio Over PCI Bus /
> -Virtio Structure PCI Capabilities / Legacy Interface: A Note on Feature Bits}
> +\label{sec:Virtio Transport Options / Virtio Over PCI Bus / Virtio Structure PCI Capabilities / Legacy Interface: A Note on Feature Bits}
>  
>  Only Feature Bits 0 to 31 are accessible through the
>  Legacy Interface. When used through the Legacy Interface,
> -- 
> 2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

