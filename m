Return-Path: <virtio-dev-return-12761-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A68DC77B7F
	for <virtio-dev@archiver.kernel.org>; Fri, 19 May 2023 06:10:30 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id A45A92CADB
	for <virtio-dev@archiver.kernel.org>; Fri, 19 May 2023 06:10:29 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7196F986721
	for <virtio-dev@archiver.kernel.org>; Fri, 19 May 2023 06:10:29 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 5523A9841AB; Fri, 19 May 2023 06:10:29 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 43D7A98671F
	for <virtio-dev@lists.oasis-open.org>; Fri, 19 May 2023 06:10:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: PTF2wI-MNPyiQRgtg8d1EQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684476625; x=1687068625;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KaL2Um4S7YpzJTgVM8Z9SyiG26BlS90fArl6Ky0EDUQ=;
        b=He6RO+62b1N5Nvr0yIgGmiQT5VHGhL+939rFFTBxALf4C7LWGtZ+fVJwCtq7BCVaPg
         7mUtNNzqQfGWNZNrW4FL2kIj1OaTUbrilyMFOphxo/vA2FyqwtJZxkH2NRa+D6nzIMoN
         tWeHkMuuU3me/9rwjpka6l5Q+HzaziEfxR46DFDiLtHIkiOMI1faNszurl7lTXaEs+lj
         B/j2VYebNc/DSU2jDVFlB8P6pIqNxJ/aq53os9jXXaWOnjQ/NyTJL/0ZlhDz0Afa5Gp0
         ARZuT7qXy2+YnuCHLU72s9lCkT5NKMXRyqx6l03ge+E8I4lLl6BJiWcrgblLCIR6tDzQ
         6p4Q==
X-Gm-Message-State: AC+VfDwoi8KIet0v2SWNuoQ4ToolO7C0Gb7F2xHEJ5TvR/pF7SieAVsN
	ANxhtQ8gBkg8Y8nestuVj0vPV+xQEi3GPnDczU6yDwQEBuSF2smgvZg8ozXHDN06HElvu6GfxNa
	2t1IYqPgkmoyuXqkQbseufHCRiKk1/ZcjluN3
X-Received: by 2002:ac2:4a6f:0:b0:4f1:4796:af9d with SMTP id q15-20020ac24a6f000000b004f14796af9dmr368670lfp.66.1684476625092;
        Thu, 18 May 2023 23:10:25 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ70WUeL+ehYQZQqJj5xUXc07VEKwj9D2G6swDClBdNkNpsI+Kdj+0moOsROpcwejciYFlGpiA==
X-Received: by 2002:ac2:4a6f:0:b0:4f1:4796:af9d with SMTP id q15-20020ac24a6f000000b004f14796af9dmr368661lfp.66.1684476624741;
        Thu, 18 May 2023 23:10:24 -0700 (PDT)
Date: Fri, 19 May 2023 02:10:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: virtio-dev@lists.oasis-open.org, cohuck@redhat.com,
	virtio-comment@lists.oasis-open.org, shahafs@nvidia.com,
	Satananda Burla <sburla@marvell.com>
Message-ID: <20230519020737-mutt-send-email-mst@kernel.org>
References: <20230330225834.506969-1-parav@nvidia.com>
 <20230330225834.506969-9-parav@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230330225834.506969-9-parav@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH 08/11] transport-pci: Introduce virtio extended capability

On Fri, Mar 31, 2023 at 01:58:31AM +0300, Parav Pandit wrote:
> PCI device configuration space for capabilities is limited to only 192
> bytes shared by many PCI capabilities of generic PCI device and virtio
> specific.
> 
> Hence, introduce virtio extended capability that uses PCI Express
> extended capability.
> Subsequent patch uses this virtio extended capability.
> 
> Co-developed-by: Satananda Burla <sburla@marvell.com>
> Signed-off-by: Parav Pandit <parav@nvidia.com>

So looking at this in isolation, it probably warrants an extra
github issue. So I would like to find out whether we
should introduce this capability and switch to it for new devices.

My main question is whether e.g. seabios will be able to use it.
Could you take a look at the source and let us all know?


> ---
>  transport-pci.tex | 69 ++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 68 insertions(+), 1 deletion(-)
> 
> diff --git a/transport-pci.tex b/transport-pci.tex
> index 665448e..aeda4a1 100644
> --- a/transport-pci.tex
> +++ b/transport-pci.tex
> @@ -174,7 +174,8 @@ \subsection{Virtio Structure PCI Capabilities}\label{sec:Virtio Transport Option
>  the function, or accessed via the special VIRTIO_PCI_CAP_PCI_CFG field in the PCI configuration space.
>  
>  The location of each structure is specified using a vendor-specific PCI capability located
> -on the capability list in PCI configuration space of the device.
> +on the capability list in PCI configuration space of the device
> +unless stated otherwise.
>  This virtio structure capability uses little-endian format; all fields are
>  read-only for the driver unless stated otherwise:
>  
> @@ -301,6 +302,72 @@ \subsection{Virtio Structure PCI Capabilities}\label{sec:Virtio Transport Option
>  fields provide the most significant 32 bits of a total 64 bit offset and
>  length within the BAR specified by \field{cap.bar}.
>  
> +Virtio extended PCI Express capability structure defines
> +the location of certain virtio device configuration related
> +structures using PCI Express extended capability. Virtio
> +extended PCI Express capability structure uses PCI Express
> +vendor specific extended capability (VSEC). It has a below
> +layout:
> +
> +\begin{lstlisting}
> +struct pcie_ext_cap {
> +        le16 cap_vendor_id; /* Generic PCI field: 0xB */
> +        le16 cap_version : 2; /* Generic PCI field: 0 */
> +        le16 next_cap_offset : 14; /* Generic PCI field: next cap or 0 */
> +};
> +
> +struct virtio_pcie_ext_cap {
> +        struct pcie_ext_cap pcie_ecap;
> +        u8 cfg_type; /* Identifies the structure. */
> +        u8 bar; /* Index of the BAR where its located */
> +        u8 id; /* Multiple capabilities of the same type */
> +        u8 zero_padding[1];
> +        le64 offset; /* Offset with the bar */
> +        le64 length; /* Length of the structure, in bytes. */
> +        u8 data[]; /* Optional variable length data */
> +};
> +\end{lstlisting}
> +
> +This structure contains optional data, depending on
> +\field{cfg_type}. The fields are interpreted as follows:
> +
> +\begin{description}
> +\item[\field{cap_vendor_id}]
> +         0x0B; identifies a vendor-specific extended capability.
> +
> +\item[\field{cap_version}]
> +         contains a value of 0.
> +
> +\item[\field{next_cap_offset}]
> +        Offset to the next capability.
> +
> +\item[\field{cfg_type}]
> +        follows the same definition as \field{cfg_type}
> +        from the \field{struct virtio_pci_cap}.
> +
> +\item[\field{bar}]
> +        follows the same  same definition as  \field{bar}
> +        from the \field{struct virtio_pci_cap}.
> +
> +\item[\field{id}]
> +        follows the same  same definition as  \field{id}
> +        from the \field{struct virtio_pci_cap}.
> +
> +\item[\field{offset}]
> +        indicates where the structure begins relative to the
> +        base address associated with the BAR. The alignment
> +        requirements of offset are indicated in each
> +        structure-specific section that uses
> +        \field{struct virtio_pcie_ext_cap}.
> +
> +\item[\field{length}]
> +        indicates the length of the structure indicated by this
> +        capability.
> +
> +\item[\field{data}]
> +        optional data of this capability.
> +\end{description}
> +
>  \drivernormative{\subsubsection}{Virtio Structure PCI Capabilities}{Virtio Transport Options / Virtio Over PCI Bus / Virtio Structure PCI Capabilities}
>  
>  The driver MUST ignore any vendor-specific capability structure which has
> -- 
> 2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

