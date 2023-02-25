Return-Path: <virtio-dev-return-11292-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32E42C7EE2D
	for <virtio-dev@archiver.kernel.org>; Sat, 25 Feb 2023 23:16:21 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 258E326A3B
	for <virtio-dev@archiver.kernel.org>; Sat, 25 Feb 2023 23:16:20 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0A7C7986791
	for <virtio-dev@archiver.kernel.org>; Sat, 25 Feb 2023 23:16:20 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id EEA4098413F; Sat, 25 Feb 2023 23:16:19 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CB36B9867A4
	for <virtio-dev@lists.oasis-open.org>; Sat, 25 Feb 2023 23:16:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 5EVty-GcNBWNoD-PqVXuHQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iPG3qwNVIGR7UTWQXNziaOID2ai2P++BEbnS485BiP4=;
        b=fVOMLNHvSVQ34cJzXkSK7neQ2Ku9szi1VCDnzPMyZCTR439wrAhSFE3XwXlkWh4a8M
         cVOk7FWngTtBqwBUQLJcW+PaU+nFsuHQZuO2g/b08SQByrwVz87Q9rmQ9jJm5NVF4k76
         yEZGKLZyUK18DQUhW9WgF67f9FIja/FheOhz2+lswkEZ6T5r4kw3snq1iNuPab4Rq1G6
         sPt6Tgk9ckL8CeNGMtxkrLuPbxAASf8D6efxLu2Lp+9JsScKDdZ6UGltWQDZHsrgSmU9
         GtQcNVc+E97Mn+UOfuSEg44zNMCCFcXUK07rYEgdBUVmD7Gd5f5NTZV84aB8BxmfFKrR
         3nTw==
X-Gm-Message-State: AO0yUKUv8KRM7WVvWsJmDgqqjmS2GZ29/aqzy/+LWxwNZp8bVZPdQ/tj
	LKT3r3hBwrorAPwh5q2k0RCV9dkXIqXVJ47JypBOweFh29cgsk8ZwCFOmj4/nA+6FiNoRR0GIQW
	OV2idslm+pCaPM6nw3KSLPwmrhFd7+mwNlg==
X-Received: by 2002:adf:fd07:0:b0:2c5:3cd2:b8e with SMTP id e7-20020adffd07000000b002c53cd20b8emr17521753wrr.1.1677366975838;
        Sat, 25 Feb 2023 15:16:15 -0800 (PST)
X-Google-Smtp-Source: AK7set/togmVdVaSeWhKjn30d95FoHhSL8vlJVK4P1Jw8C3FDrgMdTZ1HdwQ+EsAuoFcqewPsvJPrw==
X-Received: by 2002:adf:fd07:0:b0:2c5:3cd2:b8e with SMTP id e7-20020adffd07000000b002c53cd20b8emr17521743wrr.1.1677366975491;
        Sat, 25 Feb 2023 15:16:15 -0800 (PST)
Date: Sat, 25 Feb 2023 18:16:12 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: virtio-dev@lists.oasis-open.org, cohuck@redhat.com,
	virtio-comment@lists.oasis-open.org, shahafs@nvidia.com
Message-ID: <20230225181523-mutt-send-email-mst@kernel.org>
References: <20230225223001.430522-1-parav@nvidia.com>
 <20230225223001.430522-4-parav@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230225223001.430522-4-parav@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH 3/3] transport-pci: Relocate common config legacy
 interface
Message-ID: <20230225231612.5DNv32cAfDOOJiCr8ayApct2F0uRTVtgQdCBYPUQJG8@z>

On Sun, Feb 26, 2023 at 12:30:01AM +0200, Parav Pandit wrote:
> Relocate legacy interface section of common configuration structure near
> where 1.x based common configuration structure is defined.
> 
> This aligns the spec to follow rest of the other Legacy interfaces
> section.
> 
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/164
> Signed-off-by: Parav Pandit <parav@nvidia.com>
> ---
>  conformance.tex   |   3 +-
>  transport-pci.tex | 186 +++++++++++++++++++++++-----------------------
>  2 files changed, 95 insertions(+), 94 deletions(-)
> 

I can't be bothered to check whether this actually just moves text
around or also changes a bunch of stuff on the way.

> diff --git a/conformance.tex b/conformance.tex
> index 0d3616f..b654fe0 100644
> --- a/conformance.tex
> +++ b/conformance.tex
> @@ -262,8 +262,7 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
>  \item Section \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Message Framing / Legacy Interface: Message Framing}
>  \item Section \ref{sec:General Initialization And Device Operation / Device Initialization / Legacy Interface: Device Initialization}
>  \item Section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Discovery / Legacy Interfaces: A Note on PCI Device Discovery}
> -\item Section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus/ Virtio Structure PCI Capabilities / Legacy Interfaces: A Note on Common
> -configuration Layout}
> +\item Section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / Virtio Structure PCI Capabilities / Common configuration structure layout / Legacy Interfaces: A Note on Common configuration Layout}
>  \item Section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / Virtio Structure PCI Capabilities / Legacy Interface: A Note on feature bits}
>  \item Section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Device Initialization / Virtio Device Configuration Layout Detection / Legacy Interface: A Note on Device Layout Detection}
>  \item Section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Device Initialization / Virtqueue Configuration / Legacy Interface: A Note on Virtqueue Configuration}
> diff --git a/transport-pci.tex b/transport-pci.tex
> index 9d4c713..19375d0 100644
> --- a/transport-pci.tex
> +++ b/transport-pci.tex
> @@ -494,6 +494,100 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
>  were used before the queue reset.
>  (see \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}).
>  
> +\paragraph{Legacy Interfaces: A Note on Common configuration
> +Layout}\label{sec:Virtio Transport Options / Virtio Over PCI Bus
> +/ Virtio Structure PCI Capabilities / Common configuration
> +structure layout / Legacy Interfaces: A Note on Common
> +configuration Layout}
> +
> +The transitional device MUST present part of the configuration
> +registers in a legacy configuration structure in BAR0 in the
> +first I/O region of the PCI Device.
> +
> +The legacy configuration structure is described below.
> +It consists of two parts.
> +\begin{enumerate}
> +  \item Legacy common configuration structure
> +  \item Device configuration structure (optional)
> +\end{enumerate}
> +
> +When used through the legacy interface, the legacy common
> +configuration structure has the following layout:
> +
> +\begin{tabularx}{\textwidth}{ |X||X|X|X|X|X|X|X|X| }
> +\hline
> + Bits & 32 & 32 & 32 & 16 & 16 & 16 & 8 & 8 \\
> +\hline
> + Read / Write & R & R+W & R+W & R & R+W & R+W & R+W & R \\
> +\hline
> + Purpose & Device Features bits 0:31 & Driver Features bits 0:31 &
> +  Queue Address & \field{queue_size} & \field{queue_select} & Queue Notify &
> +  Device Status & ISR \newline Status \\
> +\hline
> +\end{tabularx}
> +
> +When MSI-X capability is enabled on the device, the device MUST
> +present two additional fields immediately following the above fields:
> +
> +\begin{tabular}{ |l||l|l| }
> +\hline
> +Bits       & 16             & 16     \\
> +\hline
> +Read/Write & R+W            & R+W    \\
> +\hline
> +Purpose (MSI-X) & \field{config_msix_vector}  & \field{queue_msix_vector} \\
> +\hline
> +\end{tabular}
> +
> +The device configuration structure is optional. Its existence
> +is decided by each device type. The transitional device MUST
> +present the device-specific configuration structure if any at an
> +offset immediately following the legacy common configuration structure.
> +
> +The device configuration structure:
> +
> +\begin{tabular}{|l||l|l|}
> +\hline
> +Bits & Device Specific & \multirow{3}{*}{\ldots} \\
> +\cline{1-2}
> +Read / Write & Device Specific & \\
> +\cline{1-2}
> +Purpose & Device Specific & \\
> +\hline
> +\end{tabular}
> +
> +Note: The device configuration structure byte offset is
> +calculated dynamically; when MSI-X capability is enabled, the
> +device configuration structure is located at byte offset 24,
> +when MSI-X capability is disabled, the device configuration
> +structure is located at byte offset 20.
> +
> +As legacy devices had no \field{config_generation} field,
> +see \ref{sec:Basic Facilities of a Virtio Device / Device
> +Configuration Space / Legacy Interface: Device Configuration
> +Space}~\nameref{sec:Basic Facilities of a Virtio Device / Device Configuration Space / Legacy Interface: Device Configuration Space} for workarounds.
> +
> +When using the legacy interface, the transitional driver MUST
> +use the legacy configuration structure in BAR0 in the first
> +I/O region of the PCI device.
> +
> +When using the legacy interface, the driver MAY access
> +the device-specific configuration structure using any width
> +accesses and the transitional device MUST present the driver with
> +the same results as when accessed using the ``natural'' access
> +method (i.e. 32-bit accesses for 32-bit fields, etc).
> +
> +Note that this is possible because while the legacy common
> +configuration structure is PCI (i.e. little) endian, when using
> +the legacy interface the device-specific configuration structure
> +is encoded in the native endian of the guest (where such
> +distinction is applicable).
> +
> +The transitional driver when using the legacy interface MUST
> +the device-specific configuration structure at an offset
> +immediately following the legacy common configuration structure.
> +
> +
>  \subsubsection{Notification structure layout}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Notification capability}
>  
>  The notification location is found using the VIRTIO_PCI_CAP_NOTIFY_CFG
> @@ -767,98 +861,6 @@ \subsubsection{PCI configuration access capability}\label{sec:Virtio Transport O
>  specified by some other Virtio Structure PCI Capability
>  of type other than \field{VIRTIO_PCI_CAP_PCI_CFG}.
>  
> -\subsubsection{Legacy Interfaces: A Note on Common configuration
> -Layout}\label{sec:Virtio Transport Options / Virtio Over PCI Bus
> -/ Virtio Structure PCI Capabilities / Legacy Interfaces: A Note on Common
> -configuration Layout}
> -
> -The transitional device MUST present part of the configuration
> -registers in a legacy configuration structure in BAR0 in the
> -first I/O region of the PCI Device.
> -
> -The legacy configuration structure is described below.
> -It consists of two parts.
> -\begin{enumerate}
> -  \item Legacy common configuration structure
> -  \item Device configuration structure (optional)
> -\end{enumerate}
> -
> -When used through the legacy interface, the legacy common
> -configuration structure has the following layout:
> -
> -\begin{tabularx}{\textwidth}{ |X||X|X|X|X|X|X|X|X| }
> -\hline
> - Bits & 32 & 32 & 32 & 16 & 16 & 16 & 8 & 8 \\
> -\hline
> - Read / Write & R & R+W & R+W & R & R+W & R+W & R+W & R \\
> -\hline
> - Purpose & Device Features bits 0:31 & Driver Features bits 0:31 &
> -  Queue Address & \field{queue_size} & \field{queue_select} & Queue Notify &
> -  Device Status & ISR \newline Status \\
> -\hline
> -\end{tabularx}
> -
> -When MSI-X capability is enabled on the device, the device MUST
> -present two additional fields immediately following the above fields:
> -
> -\begin{tabular}{ |l||l|l| }
> -\hline
> -Bits       & 16             & 16     \\
> -\hline
> -Read/Write & R+W            & R+W    \\
> -\hline
> -Purpose (MSI-X) & \field{config_msix_vector}  & \field{queue_msix_vector} \\
> -\hline
> -\end{tabular}
> -
> -The device configuration structure is optional. Its existence
> -is decided by each device type. The transitional device MUST
> -present the device-specific configuration structure if any at an
> -offset immediately following the legacy common configuration structure.
> -
> -The device configuration structure:
> -
> -\begin{tabular}{|l||l|l|}
> -\hline
> -Bits & Device Specific & \multirow{3}{*}{\ldots} \\
> -\cline{1-2}
> -Read / Write & Device Specific & \\
> -\cline{1-2}
> -Purpose & Device Specific & \\
> -\hline
> -\end{tabular}
> -
> -Note: The device configuration structure byte offset is
> -calculated dynamically; when MSI-X capability is enabled, the
> -device configuration structure is located at byte offset 24,
> -when MSI-X capability is disabled, the device configuration
> -structure is located at byte offset 20.
> -
> -As legacy devices had no \field{config_generation} field,
> -see \ref{sec:Basic Facilities of a Virtio Device / Device
> -Configuration Space / Legacy Interface: Device Configuration
> -Space}~\nameref{sec:Basic Facilities of a Virtio Device / Device Configuration Space / Legacy Interface: Device Configuration Space} for workarounds.
> -
> -When using the legacy interface, the transitional driver MUST
> -use the legacy configuration structure in BAR0 in the first
> -I/O region of the PCI device.
> -
> -When using the legacy interface, the driver MAY access
> -the device-specific configuration structure using any width
> -accesses and the transitional device MUST present the driver with
> -the same results as when accessed using the ``natural'' access
> -method (i.e. 32-bit accesses for 32-bit fields, etc).
> -
> -Note that this is possible because while the legacy common
> -configuration structure is PCI (i.e. little) endian, when using
> -the legacy interface the device-specific configuration structure
> -is encoded in the native endian of the guest (where such
> -distinction is applicable).
> -
> -The transitional driver when using the legacy interface MUST
> -the device-specific configuration structure at an offset
> -immediately following the legacy common configuration structure.
> -
>  \subsubsection{Legacy Interface: A Note on feature
>  bits}\label{sec:Virtio Transport Options / Virtio Over PCI Bus /
>  Virtio Structure PCI Capabilities / Legacy Interface: A Note on feature bits}
> -- 
> 2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

